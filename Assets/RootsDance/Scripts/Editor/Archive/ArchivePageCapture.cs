using System.IO;
using RootsDance.Archive;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.Archive
{
    /// <summary>
    /// Writes a still of every archive sheet to <c>Logs/Captures/</c>, so the layout can be looked
    /// at without entering play mode or hunting the page down in a level. The rendering itself is
    /// <see cref="ArchivePageStage"/>'s, which the render test also uses — so what a person looks
    /// at here is the same picture CI asserts on.
    /// </summary>
    public static class ArchivePageCapture
    {
        private const string k_LogPrefix = "ArchivePageCapture";
        private const string k_OutputFolder = "Logs/Captures";
        private const int k_Width = 900;
        private const int k_Height = 1080;

        [MenuItem("RootsDance/Archive/Capture Page Previews")]
        public static void CaptureAll()
        {
            ArchiveDocumentSO[] documents = ArchivePageStage.LoadDocuments();

            if (documents.Length == 0)
            {
                Debug.LogWarning($"[{k_LogPrefix}] No documents found under Data/Archive/.");
                return;
            }

            Directory.CreateDirectory(k_OutputFolder);

            for (int i = 0; i < documents.Length; i++)
            {
                Texture2D linear = ArchivePageStage.Render(documents[i], k_Width, k_Height);

                if (linear == null)
                {
                    return;
                }

                Texture2D image = ArchivePageStage.Normalize(linear);
                string path = $"{k_OutputFolder}/ArchivePage_{documents[i].Id}.png";
                File.WriteAllBytes(path, image.EncodeToPNG());
                Object.DestroyImmediate(linear);
                Object.DestroyImmediate(image);
                Debug.Log($"[{k_LogPrefix}] Wrote {path}.");
            }
        }
    }
}
