using System.IO;
using RootsDance.Archive;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.Archive
{
    /// <summary>
    /// Creates the archive's authored sheets as assets under <c>Data/Archive/</c>. The copy lives
    /// here rather than being typed into the Inspector so that it is reviewable in a diff and can
    /// be re-applied after a field is added — the assets themselves are YAML nobody hand-edits.
    /// <para>
    /// Re-running is safe: an existing asset is updated in place, so its GUID survives and every
    /// pickup already pointing at it keeps working.
    /// </para>
    /// </summary>
    public static class ArchiveDocumentLibrary
    {
        private const string k_LogPrefix = "ArchiveDocumentLibrary";
        private const string k_Folder = "Assets/RootsDance/Data/Archive";

        private sealed class Recipe
        {
            public string FileName;
            public string Id;
            public ArchiveDocumentKind Kind;
            public string Title;
            public string Subtitle;
            public string[] BodyLines;
            public string Transcription;
            public string MarginNote;
            public string StampText;
            public string Signature;
            public string ArchiveCode;
            public string FileLocation;
            public string FlagOnRead;
            public float DustAmount;

            /// <summary>Project path to the clipped photograph. Empty leaves the plate blank.</summary>
            public string PhotoPath;
        }

        private static readonly Recipe[] k_Recipes =
        {
            new Recipe
            {
                FileName = "DOC-001_UndergroundNetwork",
                Id = "DOC-001",
                Kind = ArchiveDocumentKind.FieldNote,
                Title = "地下网络",
                Subtitle = "Subterranean response / field hypothesis",
                BodyLines = new[]
                {
                    "地下有一张网。看不见，但所有植物都在回应它。",
                    "不是寄生，是互相交换养分。",
                    "我还没有完全搞懂这套机制。"
                },
                Transcription = "There is a network underground. It cannot be seen, yet every plant "
                    + "responds to it. This is not parasitism, but a mutual exchange of nutrients. "
                    + "I have not yet fully understood this mechanism.",
                MarginNote = string.Empty,
                StampText = string.Empty,
                Signature = string.Empty,
                ArchiveCode = "S9-01",
                FileLocation = string.Empty,
                FlagOnRead = "Archive.UndergroundNetworkRead",
                DustAmount = 0.8f
            },
            new Recipe
            {
                FileName = "DOC-002_RingExpansion",
                Id = "DOC-002",
                Kind = ArchiveDocumentKind.ObservationRecord,
                Title = "环状扩张现象",
                Subtitle = "Observation record / incomplete",
                BodyLines = new[]
                {
                    "我观察到一种环状扩张的现象。",
                    "边界不是静止的，它在向外缓慢爬行。",
                    "环内的土壤、植物全部被改变。",
                    "环外的一切还在枯萎。"
                },
                Transcription = "I have observed a phenomenon of ring-shaped expansion. Its boundary "
                    + "is not static; it creeps slowly outwards. All soil and plants within the ring "
                    + "have been transformed. Everything outside the ring continues to wither.",
                MarginNote = "边界不是静止的。\n记录它的移动。",
                StampText = "MARCH 22 1997",
                Signature = "Richard Fitzgerald",
                ArchiveCode = "S9-01",
                FileLocation = "DESK",
                FlagOnRead = "Archive.RingExpansionRead",
                DustAmount = 0.7f
            },
            new Recipe
            {
                // The greenhouse's staff photograph: DLG-007_StaffPhotograph (Chapter02DialogueBuilder)
                // already has Mrs. David and Verity looking for "her" in it and not finding her — this
                // sheet is the thing they are looking at. No handwritten commentary is authored for it
                // yet, so the body and margin blocks are left empty rather than invented; the title,
                // strapline and stamp date are transcribed straight off the photograph's own caption.
                FileName = "DOC-003_StaffPhotograph",
                Id = "DOC-003",
                Kind = ArchiveDocumentKind.Photograph,
                Title = "研究人员合照",
                Subtitle = "Briggs Botanical Gardens — Research Division",
                BodyLines = new string[0],
                Transcription = string.Empty,
                MarginNote = string.Empty,
                StampText = "APRIL 17 1974",
                Signature = string.Empty,
                ArchiveCode = "S9-01",
                FileLocation = "GREENHOUSE",
                FlagOnRead = string.Empty,
                DustAmount = 0.75f,
                PhotoPath = "Assets/RootsDance/Textures/Props/StaffPhotograph_BaseMap.png"
            }
        };

        [MenuItem("RootsDance/Archive/Create Document Assets")]
        public static void CreateMenu()
        {
            CreateAll();
            Debug.Log($"[{k_LogPrefix}] Wrote {k_Recipes.Length} documents into {k_Folder}.");
        }

        /// <summary>Writes every authored document, creating or updating each asset in place.</summary>
        public static ArchiveDocumentSO[] CreateAll()
        {
            if (!AssetDatabase.IsValidFolder(k_Folder))
            {
                Directory.CreateDirectory(k_Folder);
                AssetDatabase.Refresh();
            }

            ArchiveDocumentSO[] documents = new ArchiveDocumentSO[k_Recipes.Length];

            for (int i = 0; i < k_Recipes.Length; i++)
            {
                documents[i] = Apply(k_Recipes[i]);
            }

            AssetDatabase.SaveAssets();

            return documents;
        }

        private static ArchiveDocumentSO Apply(Recipe recipe)
        {
            string path = $"{k_Folder}/{recipe.FileName}.asset";
            ArchiveDocumentSO document = AssetDatabase.LoadAssetAtPath<ArchiveDocumentSO>(path);
            bool isNew = document == null;

            if (isNew)
            {
                document = ScriptableObject.CreateInstance<ArchiveDocumentSO>();
            }

            SerializedObject serialized = new SerializedObject(document);
            serialized.FindProperty("m_id").stringValue = recipe.Id;
            serialized.FindProperty("m_kind").enumValueIndex = (int)recipe.Kind;
            serialized.FindProperty("m_title").stringValue = recipe.Title;
            serialized.FindProperty("m_subtitle").stringValue = recipe.Subtitle;
            serialized.FindProperty("m_promptText").stringValue = recipe.Kind == ArchiveDocumentKind.Photograph ? "[E] 拾取 合照" : "[E] 拾取 档案";
            serialized.FindProperty("m_transcription").stringValue = recipe.Transcription;
            serialized.FindProperty("m_marginNote").stringValue = recipe.MarginNote;
            serialized.FindProperty("m_stampText").stringValue = recipe.StampText;
            serialized.FindProperty("m_signature").stringValue = recipe.Signature;
            serialized.FindProperty("m_archiveCode").stringValue = recipe.ArchiveCode;
            serialized.FindProperty("m_fileLocation").stringValue = recipe.FileLocation;
            serialized.FindProperty("m_flagOnRead").stringValue = recipe.FlagOnRead;
            serialized.FindProperty("m_dustAmount").floatValue = recipe.DustAmount;

            serialized.FindProperty("m_photo").objectReferenceValue = string.IsNullOrEmpty(recipe.PhotoPath)
                ? null
                : AssetDatabase.LoadAssetAtPath<Texture2D>(recipe.PhotoPath);

            SerializedProperty lines = serialized.FindProperty("m_bodyLines");
            lines.arraySize = recipe.BodyLines.Length;

            for (int i = 0; i < recipe.BodyLines.Length; i++)
            {
                lines.GetArrayElementAtIndex(i).stringValue = recipe.BodyLines[i];
            }

            serialized.ApplyModifiedPropertiesWithoutUndo();

            if (isNew)
            {
                AssetDatabase.CreateAsset(document, path);
            }
            else
            {
                EditorUtility.SetDirty(document);
            }

            return document;
        }
    }
}
