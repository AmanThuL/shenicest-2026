using System.Text;
using TMPro;
using UnityEditor;
using UnityEngine;
using UnityEngine.TextCore.LowLevel;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Bakes the face the wall panel is read in: Fusion Pixel at 24 pt, <b>SMOOTH</b>, static.
    /// <para>
    /// The kit's own face is the same font baked SDFAA at 90 pt, and on a screen-space UI that is
    /// right — SDF scales to any size and stays clean. On a diegetic panel it falls apart, and the
    /// reason is worth writing down: a pixel font's legibility <em>is</em> its hard edges, and SDF
    /// replaces them with a distance field that is then antialiased back into a grey ramp. At the
    /// size a wall panel's body text ends up — around ten screen pixels per character once the low
    /// resolution buffer has had it — that ramp is most of the glyph. The pixel font ends up
    /// blurrier than an ordinary one would have been.
    /// </para>
    /// <para>
    /// SMOOTH rather than RASTER, tested rather than assumed. RASTER is a hard 1-bit atlas and is
    /// crisper still <em>at its baked size</em>, but the panel does not display at exactly 24 pt —
    /// it is a world-space quad seen from wherever the read camera lands — and a 1-bit atlas
    /// resampled off its grid breaks up into noise. SMOOTH is an antialiased bitmap: no distance
    /// field, so the edges stay where the font put them, and enough grey to survive not landing on
    /// whole pixels.
    /// </para>
    /// <para>
    /// Static, and only the characters the panel prints. A dynamic atlas adds glyphs at runtime and
    /// writes them back into the asset — which is where the recurring multi-megabyte font diffs in
    /// this repo come from. Same reason <c>ArchiveFontBuilder</c> bakes its 178 characters and
    /// stops. <b>New text on the panel means running this again.</b>
    /// </para>
    /// Menu: RootsDance &gt; UI &gt; Bake Wall Panel Font.
    /// </summary>
    public static class WallPixelFontBuilder
    {
        public const string k_FontAssetPath = "Assets/RootsDance/Fonts/FusionPixel-24 Smooth.asset";

        private const string k_SourcePath =
            "Assets/RootsDance/Fonts/FusionPixel-12px-Zh_Hans.ttf";

        /// <summary>
        /// Twice the font's 12 px design size. One doubling is what the panel's reading distance
        /// asks for; two would only cost atlas.
        /// </summary>
        private const int k_PointSize = 24;

        /// <summary>SMOOTH needs a pixel of room for its antialiasing and no more.</summary>
        private const int k_Padding = 1;

        private const int k_AtlasSize = 1024;

        /// <summary>
        /// Everything the panel can print, plus the Latin and digits any readout might reach for.
        /// The panel's own strings come from the screen builder rather than being copied here, so
        /// changing a word in one place cannot leave a blank on the panel.
        /// </summary>
        private static string Characters()
        {
            StringBuilder builder = new StringBuilder();
            builder.Append(CirculationConsoleScreenBuilder.AllText);
            builder.Append("ABCDEFGHIJKLMNOPQRSTUVWXYZ");
            builder.Append("abcdefghijklmnopqrstuvwxyz");
            builder.Append("0123456789 .,:;-—/%()[]<>+");
            return builder.ToString();
        }

        [MenuItem("RootsDance/UI/Bake Wall Panel Font")]
        public static void Build()
        {
            TMP_FontAsset asset = EnsureFontAsset();

            if (asset == null)
            {
                return;
            }

            AssetDatabase.SaveAssets();
            Debug.Log($"[UI] {k_FontAssetPath} baked at {k_PointSize} pt, SMOOTH, "
                + $"{asset.characterTable.Count} characters.", asset);
        }

        /// <summary>Rebuilds the asset from the TTF. Null after logging on failure.</summary>
        public static TMP_FontAsset EnsureFontAsset()
        {
            Font source = AssetDatabase.LoadAssetAtPath<Font>(k_SourcePath);

            if (source == null)
            {
                Debug.LogError($"[UI] {k_SourcePath} is missing.");
                return null;
            }

            TMP_FontAsset asset = TMP_FontAsset.CreateFontAsset(source, k_PointSize, k_Padding,
                GlyphRenderMode.SMOOTH, k_AtlasSize, k_AtlasSize, AtlasPopulationMode.Dynamic,
                false);

            if (asset == null)
            {
                Debug.LogError($"[UI] TextMeshPro could not read {k_SourcePath}.");
                return null;
            }

            asset.name = "FusionPixel-24 Smooth";

            if (!asset.TryAddCharacters(Characters(), out string missing))
            {
                Debug.LogError($"[UI] {missing.Length} characters did not fit the "
                    + $"{k_AtlasSize}x{k_AtlasSize} atlas or are not in the font: '{missing}'.");
            }

            // Sealed after baking. From here the asset is a fixed set of glyphs; anything the panel
            // asks for that is not in it prints nothing, which is the trade for never having the
            // atlas rewrite itself behind a commit.
            asset.atlasPopulationMode = AtlasPopulationMode.Static;

            TMP_FontAsset existing = AssetDatabase.LoadAssetAtPath<TMP_FontAsset>(k_FontAssetPath);

            if (existing == null)
            {
                AssetDatabase.CreateAsset(asset, k_FontAssetPath);
            }
            else
            {
                // Overwritten in place so the GUID survives and everything pointing at the face
                // keeps pointing at it.
                EditorUtility.CopySerialized(asset, existing);
                asset = existing;
            }

            WriteAtlasAndMaterial(asset);
            EditorUtility.SetDirty(asset);
            AssetDatabase.SaveAssetIfDirty(asset);
            AssetDatabase.ImportAsset(k_FontAssetPath);

            return AssetDatabase.LoadAssetAtPath<TMP_FontAsset>(k_FontAssetPath);
        }

        /// <summary>
        /// The atlas texture and the material are sub-assets of the font, and a freshly created
        /// asset's are loose objects until they are put there.
        /// </summary>
        private static void WriteAtlasAndMaterial(TMP_FontAsset asset)
        {
            Texture2D atlas = asset.atlasTexture;

            if (atlas != null && AssetDatabase.GetAssetPath(atlas) != k_FontAssetPath)
            {
                atlas.name = asset.name + " Atlas";
                AssetDatabase.AddObjectToAsset(atlas, asset);
            }

            Material material = asset.material;

            if (material != null && AssetDatabase.GetAssetPath(material) != k_FontAssetPath)
            {
                material.name = asset.name + " Material";
                AssetDatabase.AddObjectToAsset(material, asset);
            }

            // Point filtering: the whole point of a bitmap face is that a glyph's pixels are the
            // ones the designer drew. Bilinear would put the blur back in that SDF was dropped to
            // avoid.
            if (atlas != null)
            {
                atlas.filterMode = FilterMode.Point;
            }
        }
    }
}
