using System.Collections.Generic;
using System.Text;
using RootsDance.Archive;
using TMPro;
using UnityEditor;
using UnityEngine;
using UnityEngine.TextCore.LowLevel;

namespace RootsDance.Editor.Archive
{
    /// <summary>
    /// Generates the handwriting font asset the archive sheets are written in, from the TTF in
    /// <c>Fonts/</c>.
    /// <para>
    /// The atlas is <b>static and holds only the characters the archive actually uses</b> — every
    /// glyph in every authored document, plus ASCII. A dynamic CJK font asset grows its atlas at
    /// runtime as new glyphs are met, and the growth is written back into the asset file: that is
    /// exactly the churn that makes the existing pixel font show up as an unrelated 8 MB diff every
    /// time anyone opens the project. Static means the file is the same after a play session as
    /// before it.
    /// </para>
    /// <para>
    /// The cost is that a character no document uses will not render. That is a fair trade while the
    /// copy is authored in this repo, and the fix is to re-run this — which is also the reminder
    /// that new copy needs it.
    /// </para>
    /// </summary>
    public static class ArchiveFontBuilder
    {
        private const string k_LogPrefix = "ArchiveFontBuilder";
        private const string k_SourcePath = "Assets/RootsDance/Fonts/FZJingLei.ttf";
        public const string k_FontAssetPath = "Assets/RootsDance/Fonts/FZJingLei SDF.asset";

        private const int k_SamplingPointSize = 78;

        /// <summary>
        /// Padding is the headroom the SDF has to grow into. It has to be generous here because the
        /// face is dilated afterwards (see <see cref="k_FaceDilate"/>) and a dilate wider than the
        /// padding clips the stroke flat.
        /// </summary>
        private const int k_Padding = 12;

        private const int k_AtlasSize = 2048;

        /// <summary>
        /// How much heavier the stroke is drawn than the font was designed. 方正静蕾 is a fine-nib
        /// hand, and at the size a field note is read at it comes out looking like pencil rather
        /// than ink. Dilating the signed distance field thickens every stroke evenly, the way a
        /// wetter pen would, which is what the reference sheets are written with.
        /// </summary>
        private const float k_FaceDilate = 0.22f;

        [MenuItem("RootsDance/Archive/Build Handwriting Font")]
        public static void BuildMenu()
        {
            TMP_FontAsset asset = EnsureFontAsset();

            if (asset != null)
            {
                Debug.Log($"[{k_LogPrefix}] Built {k_FontAssetPath}.", asset);
            }
        }

        /// <summary>
        /// Rebuilds the font asset from the TTF and the current copy. Returns null after logging on
        /// failure.
        /// </summary>
        public static TMP_FontAsset EnsureFontAsset()
        {
            Font source = AssetDatabase.LoadAssetAtPath<Font>(k_SourcePath);

            if (source == null)
            {
                Debug.LogError($"[{k_LogPrefix}] {k_SourcePath} is missing.");
                return null;
            }

            string characters = CollectCharacters();

            TMP_FontAsset asset = TMP_FontAsset.CreateFontAsset(source, k_SamplingPointSize,
                k_Padding, GlyphRenderMode.SDFAA, k_AtlasSize, k_AtlasSize,
                AtlasPopulationMode.Dynamic, false);

            if (asset == null)
            {
                Debug.LogError($"[{k_LogPrefix}] TextMeshPro could not read {k_SourcePath}.");
                return null;
            }

            asset.name = "FZJingLei SDF";

            if (!asset.TryAddCharacters(characters, out string missing))
            {
                // Not fatal, but it means a document is about to print a blank where a character
                // should be, which is worth saying rather than leaving to be noticed in a screenshot.
                Debug.LogError($"[{k_LogPrefix}] {missing.Length} characters would not fit the "
                    + $"{k_AtlasSize}x{k_AtlasSize} atlas or are not in the font: '{missing}'. "
                    + "Raise the atlas size or lower the sampling point size.");
            }

            // Static from here on: nothing may be added at runtime, so the asset file cannot change
            // behind the team's back.
            asset.atlasPopulationMode = AtlasPopulationMode.Static;
            asset.isMultiAtlasTexturesEnabled = false;

            if (asset.material != null)
            {
                asset.material.SetFloat(ShaderUtilities.ID_FaceDilate, k_FaceDilate);
            }

            SaveWithSubAssets(asset);

            Debug.Log($"[{k_LogPrefix}] {asset.characterTable.Count} characters baked into a "
                + $"static {k_AtlasSize}x{k_AtlasSize} atlas.");

            return AssetDatabase.LoadAssetAtPath<TMP_FontAsset>(k_FontAssetPath);
        }

        /// <summary>
        /// Every character the archive prints: ASCII, plus everything in every authored document.
        /// </summary>
        private static string CollectCharacters()
        {
            HashSet<char> characters = new HashSet<char>();

            for (char c = ' '; c <= '~'; c++)
            {
                characters.Add(c);
            }

            // The quotation marks the page adds round the transcription are not in the copy itself.
            Add(characters, "“”…—·");

            ArchiveDocumentSO[] documents = ArchivePageStage.LoadDocuments();

            for (int i = 0; i < documents.Length; i++)
            {
                ArchiveDocumentSO document = documents[i];
                Add(characters, document.Title);
                Add(characters, document.Subtitle);
                Add(characters, document.PromptText);
                Add(characters, document.BodyText());
                Add(characters, document.Transcription);
                Add(characters, document.MarginNote);
                Add(characters, document.StampText);
                Add(characters, document.Signature);
                Add(characters, document.ArchiveCode);
                Add(characters, document.FileLocation);
            }

            StringBuilder builder = new StringBuilder(characters.Count);

            foreach (char c in characters)
            {
                if (!char.IsControl(c))
                {
                    builder.Append(c);
                }
            }

            return builder.ToString();
        }

        private static void Add(HashSet<char> set, string text)
        {
            if (string.IsNullOrEmpty(text))
            {
                return;
            }

            for (int i = 0; i < text.Length; i++)
            {
                set.Add(text[i]);
            }
        }

        /// <summary>
        /// Writes the asset with its atlas texture and material inside it, replacing any previous
        /// one at the same path so the GUID survives and everything pointing at it keeps working.
        /// </summary>
        private static void SaveWithSubAssets(TMP_FontAsset asset)
        {
            if (AssetDatabase.LoadAssetAtPath<TMP_FontAsset>(k_FontAssetPath) != null)
            {
                AssetDatabase.DeleteAsset(k_FontAssetPath);
            }

            AssetDatabase.CreateAsset(asset, k_FontAssetPath);

            for (int i = 0; i < asset.atlasTextures.Length; i++)
            {
                Texture2D atlas = asset.atlasTextures[i];

                if (atlas == null)
                {
                    continue;
                }

                atlas.name = "FZJingLei Atlas";
                AssetDatabase.AddObjectToAsset(atlas, asset);
            }

            if (asset.material != null)
            {
                asset.material.name = "FZJingLei Material";
                AssetDatabase.AddObjectToAsset(asset.material, asset);
            }

            AssetDatabase.SaveAssets();
            AssetDatabase.ImportAsset(k_FontAssetPath, ImportAssetOptions.ForceUpdate);
        }
    }
}
