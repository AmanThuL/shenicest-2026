using System.IO;
using RootsDance.Archive;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.Archive
{
    /// <summary>
    /// Composes each archive sheet — the paper and everything written on it — into one texture, and
    /// hands it back to the document asset.
    /// <para>
    /// This exists so the fold can crease the writing and not just the paper. A crease deforms the
    /// sheet, and the ink is on the sheet; but the writing is drawn by TextMeshPro's own SDF
    /// material, which no shader of ours can reach, and a uGUI graphic is four vertices with
    /// nothing to displace. Flattening the page first turns "warp everything consistently" into one
    /// texture lookup. See docs/architecture/systems/纸张折痕研究.md §5 for the alternatives and
    /// why each of them fails.
    /// </para>
    /// <para>
    /// Baked here rather than at runtime because the copy is authored data: it is known at build
    /// time, and a sheet's writing does not change while it is being read. That costs a re-bake
    /// whenever the copy changes — the same standing cost the static font atlas already carries,
    /// and <c>Build All</c> does both.
    /// </para>
    /// </summary>
    public static class ArchivePageComposer
    {
        private const string k_LogPrefix = "ArchivePageComposer";
        private const string k_Folder = "Assets/RootsDance/Textures/Props";

        /// <summary>
        /// Tall enough that a sheet filling a 1440p screen is still sampled about one to one.
        /// </summary>
        private const int k_Height = 2048;

        [MenuItem("RootsDance/Archive/Compose Pages")]
        public static void ComposeMenu()
        {
            int count = ComposeAll();
            Debug.Log($"[{k_LogPrefix}] Composed {count} sheets into {k_Folder}.");
        }

        /// <summary>
        /// Renders every authored document's page and stores it on the document. Returns how many
        /// were written.
        /// </summary>
        public static int ComposeAll()
        {
            if (!AssetDatabase.IsValidFolder(k_Folder))
            {
                Directory.CreateDirectory(k_Folder);
                AssetDatabase.Refresh();
            }

            ArchiveDocumentSO[] documents = ArchivePageStage.LoadDocuments();
            int written = 0;

            for (int i = 0; i < documents.Length; i++)
            {
                if (Compose(documents[i]))
                {
                    written++;
                }
            }

            AssetDatabase.SaveAssets();

            return written;
        }

        /// <summary>The texture one document's page is composed into.</summary>
        public static string PagePath(ArchiveDocumentSO document)
        {
            // The texture pipeline allows exactly one underscore, reserved for the map suffix, so
            // the id's dash is dropped rather than turned into one.
            string id = document.Id == null ? "Unknown" : document.Id.Replace("-", string.Empty);

            return $"{k_Folder}/ArchivePage{id}_BaseMap.png";
        }

        /// <summary>
        /// Writes the sheet's torn outline into the composed page's alpha, taken from the paper
        /// texture rather than from the render.
        /// <para>
        /// HDRP's colour buffer is R11G11B10 by default — no alpha channel at all — so a render
        /// into it comes back fully opaque however the camera was told to clear. Widening that
        /// buffer project-wide to rescue one bake would be a poor trade, and the silhouette is
        /// already authored in the paper's own alpha.
        /// </para>
        /// <para>
        /// The PNG is read off disk rather than through the imported asset: the texture pipeline
        /// imports everything under <c>Textures/</c> non-readable, and asking the importer for
        /// readability back is undone by that same postprocessor on the reimport it triggers.
        /// </para>
        /// </summary>
        private static void StampSilhouette(Texture2D page)
        {
            string paperPath = ArchivePaperTextureBaker.k_PaperBasePath;

            if (!File.Exists(paperPath))
            {
                Debug.LogWarning($"[{k_LogPrefix}] {paperPath} is missing; the composed page will "
                    + "be a rectangle rather than a torn sheet.");
                return;
            }

            Texture2D paper = new Texture2D(2, 2, TextureFormat.RGBA32, false);

            try
            {
                if (!paper.LoadImage(File.ReadAllBytes(paperPath), false))
                {
                    Debug.LogWarning($"[{k_LogPrefix}] {paperPath} could not be read as a PNG.");
                    return;
                }

                Color[] pixels = page.GetPixels();

                for (int y = 0; y < page.height; y++)
                {
                    float v = (float)y / Mathf.Max(page.height - 1, 1);

                    for (int x = 0; x < page.width; x++)
                    {
                        float u = (float)x / Mathf.Max(page.width - 1, 1);
                        pixels[y * page.width + x].a = paper.GetPixelBilinear(u, v).a;
                    }
                }

                page.SetPixels(pixels);
                page.Apply(false, false);
            }
            finally
            {
                Object.DestroyImmediate(paper);
            }
        }

        private static bool Compose(ArchiveDocumentSO document)
        {
            // A photograph page is the print's own shape, so its bake is too.
            Vector2 units = ArchivePageLayout.PageUnits(document.Kind, document.PhotoAspect);
            int width = Mathf.RoundToInt(k_Height * units.x / units.y);

            // Composed flat: no fold, no lighting, no dust. The fold shader applies all three to
            // the finished page, and baking any of them in would fold the sheet twice.
            Texture2D linear = ArchivePageStage.Render(document, width, k_Height,
                ArchivePageStage.RenderMode.ComposeFlat);

            if (linear == null)
            {
                return false;
            }

            Texture2D image = ArchivePageStage.ToSrgb(linear);

            // A print has no torn edge to stamp; its border is in the exposure.
            if (document.Kind != ArchiveDocumentKind.Photograph)
            {
                StampSilhouette(image);
            }

            string path = PagePath(document);
            File.WriteAllBytes(path, image.EncodeToPNG());
            Object.DestroyImmediate(linear);
            Object.DestroyImmediate(image);

            AssetDatabase.ImportAsset(path, ImportAssetOptions.ForceUpdate);

            Texture2D composed = AssetDatabase.LoadAssetAtPath<Texture2D>(path);
            SerializedObject serialized = new SerializedObject(document);
            serialized.FindProperty("m_composedPage").objectReferenceValue = composed;
            serialized.ApplyModifiedPropertiesWithoutUndo();
            EditorUtility.SetDirty(document);

            return true;
        }
    }
}
