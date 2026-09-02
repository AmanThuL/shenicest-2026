using System;
using System.IO;
using RootsDance.Editor.Build;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.Pipeline
{
    /// <summary>
    /// Applies the project's texture import rules automatically to everything the
    /// texture pipeline writes into <c>Assets/RootsDance/Textures/</c>.
    /// </summary>
    /// <remarks>
    /// <para>
    /// The settings come from guideline 07 section 10 (sRGB only on colour maps, normal
    /// maps typed Normal map) and guideline 05 section 7.1 (Max Size ceiling, compressed,
    /// Read/Write off, mipmaps on for 3D). Applying them here rather than by hand is what
    /// makes an import reproducible: re-importing the project produces the same settings
    /// without anyone clicking through the Inspector.
    /// </para>
    /// <para>
    /// Only files whose names follow <c>&lt;Asset&gt;_&lt;Map&gt;</c> are touched. Anything
    /// else is left exactly as the artist configured it and reported once, so this cannot
    /// quietly stomp a deliberate manual setting.
    /// </para>
    /// <para>
    /// Two more rules come from <see cref="AssetSizePolicy"/>, the shared definition the
    /// build-size audit also checks against: Non Power of 2 is set to ToNearest whenever the
    /// source size is not a multiple of 4 (block compression needs it, otherwise the texture
    /// ships uncompressed at 3x the size), and textures under a capped root get a Standalone
    /// platform override at <see cref="AssetSizePolicy.k_StandaloneMaxSize"/>.
    /// </para>
    /// </remarks>
    public sealed class TexturePipelinePostprocessor : AssetPostprocessor
    {
        /// <summary>Hard ceiling from guideline 05 section 7.1; never 4096 without a profile.</summary>
        private const int k_MaxSizeCeiling = 2048;

        private const int k_MinSize = 32;

        private void OnPreprocessTexture()
        {
            string path = assetPath.Replace('\\', '/');
            if (!path.StartsWith(TextureMapNaming.k_TextureRoot))
            {
                return;
            }

            string fileName = Path.GetFileName(path);
            if (!TextureMapNaming.TryParse(fileName, out string textureSet, out TextureMapKind kind))
            {
                Debug.LogWarning(
                    $"[TexturePipeline] '{path}' is under {TextureMapNaming.k_TextureRoot} but does not " +
                    "follow <Asset>_<Map>.png, so no import settings were applied. " +
                    "Rename it or move it out of the material-texture folder.");
                return;
            }

            TextureImporter importer = (TextureImporter)assetImporter;

            importer.textureType = kind == TextureMapKind.Normal
                ? TextureImporterType.NormalMap
                : TextureImporterType.Default;

            // Colour maps are sRGB; every data map is linear. Ignored for NormalMap type,
            // but set explicitly so the value is never left over from a previous import.
            importer.sRGBTexture = TextureMapNaming.IsColorMap(kind);

            importer.alphaSource = TextureImporterAlphaSource.FromInput;
            importer.alphaIsTransparency = TextureMapNaming.AlphaIsTransparency(kind);

            importer.mipmapEnabled = true;
            importer.isReadable = false;
            importer.wrapMode = TextureWrapMode.Repeat;
            importer.filterMode = FilterMode.Bilinear;
            importer.textureCompression = TextureImporterCompression.Compressed;
            importer.compressionQuality = (int)TextureCompressionQuality.Normal;
            importer.maxTextureSize = ResolveMaxSize(path);

            int sourceWidth;
            int sourceHeight;
            if (!TryReadSourceSize(path, out sourceWidth, out sourceHeight))
            {
                importer.GetSourceTextureWidthAndHeight(out sourceWidth, out sourceHeight);
            }

            // Block compression needs multiples of 4; anything else ships as raw RGBA32 (3x the size).
            importer.npotScale = AssetSizePolicy.IsMultipleOfFour(sourceWidth, sourceHeight)
                ? TextureImporterNPOTScale.None
                : TextureImporterNPOTScale.ToNearest;

            int standaloneCap;
            if (AssetSizePolicy.TryGetStandaloneMaxSize(path, out standaloneCap))
            {
                TextureImporterPlatformSettings standalone = importer.GetPlatformTextureSettings("Standalone");
                standalone.overridden = true;
                standalone.maxTextureSize = Mathf.Min(standaloneCap, importer.maxTextureSize);
                standalone.format = TextureImporterFormat.Automatic;
                importer.SetPlatformTextureSettings(standalone);
            }

            m_AppliedTo = $"{textureSet}_{kind}";
        }

        private string m_AppliedTo;

        private void OnPostprocessTexture(Texture2D texture)
        {
            if (string.IsNullOrEmpty(m_AppliedTo))
            {
                return;
            }

            if (texture.width != texture.height)
            {
                Debug.LogWarning(
                    $"[TexturePipeline] '{assetPath}' is {texture.width}x{texture.height}. " +
                    "Material textures are expected to be square so texel density stays predictable.");
            }

            if (!Mathf.IsPowerOfTwo(texture.width) || !Mathf.IsPowerOfTwo(texture.height))
            {
                Debug.LogWarning(
                    $"[TexturePipeline] '{assetPath}' is {texture.width}x{texture.height}, which is not " +
                    "power-of-two. GPU compression needs POT (guideline 05 section 7.1).");
            }
        }

        /// <summary>
        /// Max Size is the texture's own authored resolution, clamped to the project
        /// ceiling. Deriving it from the file rather than from a per-asset config keeps a
        /// single source of truth: the preset already decided the resolution when the
        /// texture was exported, so there is nothing here to drift out of sync.
        /// </summary>
        private static int ResolveMaxSize(string path)
        {
            int width;
            int height;
            if (!TryReadSourceSize(path, out width, out height) || width <= 0)
            {
                return k_MaxSizeCeiling;
            }

            return Mathf.Clamp(Mathf.NextPowerOfTwo(width), k_MinSize, k_MaxSizeCeiling);
        }

        /// <summary>
        /// Reads the width and height out of the source file's own header. The importer does
        /// not know the source dimensions during OnPreprocessTexture, and both Max Size and
        /// the NPOT-4 rule have to be decided there. Handles PNG (IHDR chunk) and JPEG (SOF0/
        /// SOF2 marker segment); returns false for anything else, or on a read failure.
        /// </summary>
        private static bool TryReadSourceSize(string path, out int width, out int height)
        {
            width = 0;
            height = 0;

            try
            {
                using (FileStream stream = File.OpenRead(path))
                {
                    byte[] header = new byte[24];
                    if (stream.Read(header, 0, header.Length) != header.Length)
                    {
                        return false;
                    }

                    if (header[0] == 0x89 && header[1] == 'P' && header[2] == 'N' && header[3] == 'G')
                    {
                        // Bytes 16..19 are the IHDR width, 20..23 the height, both big-endian.
                        width = (header[16] << 24) | (header[17] << 16) | (header[18] << 8) | header[19];
                        height = (header[20] << 24) | (header[21] << 16) | (header[22] << 8) | header[23];
                        return width > 0 && height > 0;
                    }

                    if (header[0] == 0xFF && header[1] == 0xD8)
                    {
                        return TryReadJpegSize(stream, out width, out height);
                    }

                    return false;
                }
            }
            catch (IOException)
            {
                return false;
            }
            catch (UnauthorizedAccessException)
            {
                // A read-only or permission-denied source file must not abort the import;
                // the caller falls back to the importer's own reported size.
                return false;
            }
        }

        /// <summary>
        /// Scans JPEG marker segments for the SOF0/SOF1/SOF2 frame header, which carries the
        /// image's own height and width (big-endian, height first) at offsets 5..8 of the
        /// segment. Assumes the stream is already known to start with the JPEG SOI marker.
        /// </summary>
        private static bool TryReadJpegSize(FileStream stream, out int width, out int height)
        {
            width = 0;
            height = 0;
            if (stream.Length < 2)
            {
                // Seeking past the end of a truncated file would throw out of the caller's guard.
                return false;
            }

            stream.Seek(2, SeekOrigin.Begin);
            var segment = new byte[9];
            while (stream.Read(segment, 0, 4) == 4)
            {
                if (segment[0] != 0xFF)
                {
                    return false;
                }

                byte marker = segment[1];
                int length = (segment[2] << 8) | segment[3];
                if (length < 2)
                {
                    // A malformed segment length would seek backwards and never progress.
                    return false;
                }

                if (marker == 0xC0 || marker == 0xC1 || marker == 0xC2)
                {
                    if (stream.Read(segment, 0, 5) != 5)
                    {
                        return false;
                    }

                    height = (segment[1] << 8) | segment[2];
                    width = (segment[3] << 8) | segment[4];
                    return width > 0 && height > 0;
                }

                stream.Seek(length - 2, SeekOrigin.Current);
            }

            return false;
        }
    }
}
