using System.IO;
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
            importer.npotScale = TextureImporterNPOTScale.None;
            importer.wrapMode = TextureWrapMode.Repeat;
            importer.filterMode = FilterMode.Bilinear;
            importer.textureCompression = TextureImporterCompression.Compressed;
            importer.compressionQuality = (int)TextureCompressionQuality.Normal;
            importer.maxTextureSize = ResolveMaxSize(path);

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
            int width = ReadPngWidth(path);
            if (width <= 0)
            {
                return k_MaxSizeCeiling;
            }

            return Mathf.Clamp(Mathf.NextPowerOfTwo(width), k_MinSize, k_MaxSizeCeiling);
        }

        /// <summary>
        /// Reads the width out of a PNG IHDR chunk. The importer does not know the source
        /// dimensions during OnPreprocessTexture, and Max Size has to be set there.
        /// Returns 0 for anything that is not a readable PNG.
        /// </summary>
        private static int ReadPngWidth(string path)
        {
            try
            {
                using (FileStream stream = File.OpenRead(path))
                {
                    byte[] header = new byte[24];
                    if (stream.Read(header, 0, header.Length) != header.Length)
                    {
                        return 0;
                    }

                    if (header[0] != 0x89 || header[1] != 'P' || header[2] != 'N' || header[3] != 'G')
                    {
                        return 0;
                    }

                    // Bytes 16..19 are the IHDR width, big-endian.
                    return (header[16] << 24) | (header[17] << 16) | (header[18] << 8) | header[19];
                }
            }
            catch (IOException)
            {
                return 0;
            }
        }
    }
}
