using RootsDance.Archive;
using RootsDance.Data;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Archive
{
    /// <summary>
    /// Builds the Briggs interior's second environment part scene and lays the authored archive
    /// documents on the archive desk in it.
    /// <para>
    /// The documents get their own part scene rather than going into
    /// <c>BriggsInterior_Environment</c> so that placing them never collides with whoever is
    /// editing the room itself (guideline 11). Re-running rewrites the same path: the scene is
    /// rebuilt from this recipe, so the placement is edited here or by hand in the Editor
    /// afterwards — the second wins until the next build.
    /// </para>
    /// </summary>
    public static class ArchiveBriggsSceneBuilder
    {
        private const string k_LogPrefix = "ArchiveBriggsSceneBuilder";

        private const string k_ScenePath =
            "Assets/RootsDance/Scenes/Levels/BriggsInterior/BriggsInterior_Environment_2.unity";

        private const string k_RootName = "_Archive";

        /// <summary>The archive desk, from <c>BriggsInterior_Environment</c>: BI_S9_ArchiveDesk.</summary>
        private static readonly Vector3 k_DeskPosition = new Vector3(-6.25f, 0f, -2.35f);

        /// <summary>Table top, in metres — the sheets lie on the desk, not on the floor.</summary>
        private const float k_DeskHeight = 0.95f;

        /// <summary>How far apart the two sheets lie on the desk, in metres.</summary>
        private const float k_Spacing = 0.34f;

        [MenuItem("RootsDance/Archive/Build Briggs Archive Scene")]
        public static void Build()
        {
            GameObject prefab = AssetDatabase.LoadAssetAtPath<GameObject>(
                ArchiveDocumentPrefabBuilder.k_PrefabPath);

            if (prefab == null)
            {
                Debug.LogError($"[{k_LogPrefix}] The page prefab is missing; run "
                    + "RootsDance/Archive/Build All first.");
                return;
            }

            ArchiveDocumentSO[] documents = ArchivePageStage.LoadDocuments();

            if (documents.Length == 0)
            {
                Debug.LogError($"[{k_LogPrefix}] No documents under Data/Archive; run "
                    + "RootsDance/Archive/Create Document Assets first.");
                return;
            }

            // Additive and empty: an environment part scene owns no camera and no listener, and
            // opening it single would throw away whatever the level owner has open right now.
            Scene scene = EditorSceneManager.NewScene(NewSceneSetup.EmptyScene, NewSceneMode.Additive);
            GameObject root = new GameObject(k_RootName);
            SceneManager.MoveGameObjectToScene(root, scene);

            int layer = FirstLayerIn(AllowedLayers());

            for (int i = 0; i < documents.Length; i++)
            {
                GameObject instance = (GameObject)PrefabUtility.InstantiatePrefab(prefab, scene);
                instance.name = $"ArchiveDocument_{documents[i].Id}";
                instance.transform.SetParent(root.transform, false);

                // Laid out along the desk's long axis, at reading height. Exact placement is the
                // level owner's to nudge in the Editor.
                float across = (i - (documents.Length - 1) * 0.5f) * k_Spacing;
                instance.transform.position = k_DeskPosition
                    + Vector3.up * k_DeskHeight
                    + new Vector3(across, 0f, 0f);

                // Face up: the readable side of a page looks back along its own forward axis.
                instance.transform.rotation = Quaternion.LookRotation(Vector3.down, Vector3.forward);

                SetLayerRecursively(instance, layer);

                SerializedObject serialized = new SerializedObject(
                    instance.GetComponent<ArchiveDocumentPickup>());
                serialized.FindProperty("m_document").objectReferenceValue = documents[i];
                serialized.ApplyModifiedProperties();
            }

            EditorSceneManager.SaveScene(scene, k_ScenePath);
            EditorSceneManager.CloseScene(scene, true);
            AssetDatabase.Refresh();

            Debug.Log($"[{k_LogPrefix}] Wrote {k_ScenePath} with {documents.Length} document(s) on "
                + "the archive desk. Open it additively next to BriggsInterior_Environment to move them.");
        }

        private static LayerMask AllowedLayers()
        {
            string[] guids = AssetDatabase.FindAssets("t:InteractionConfigSO");

            if (guids.Length == 0)
            {
                return ~0;
            }

            InteractionConfigSO config = AssetDatabase.LoadAssetAtPath<InteractionConfigSO>(
                AssetDatabase.GUIDToAssetPath(guids[0]));

            return config == null ? ~0 : config.InteractableLayers;
        }

        /// <summary>The lowest layer the interaction ray accepts, so the sheet is sure to be hit.</summary>
        private static int FirstLayerIn(LayerMask mask)
        {
            for (int layer = 0; layer < 32; layer++)
            {
                if ((mask.value & (1 << layer)) != 0 && !string.IsNullOrEmpty(LayerMask.LayerToName(layer)))
                {
                    return layer;
                }
            }

            return 0;
        }

        private static void SetLayerRecursively(GameObject target, int layer)
        {
            target.layer = layer;

            for (int i = 0; i < target.transform.childCount; i++)
            {
                SetLayerRecursively(target.transform.GetChild(i).gameObject, layer);
            }
        }
    }
}
