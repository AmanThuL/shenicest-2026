using RootsDance.Archive;
using RootsDance.Data;
using RootsDance.Player;
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

        private const string k_GameplayPath =
            "Assets/RootsDance/Scenes/Levels/BriggsInterior/BriggsInterior_Gameplay.unity";

        private const string k_RootName = "_Archive";

        /// <summary>The archive desk, from <c>BriggsInterior_Environment</c>: BI_S9_ArchiveDesk.</summary>
        private static readonly Vector3 k_DeskPosition = new Vector3(-6.25f, 0f, -2.35f);

        /// <summary>The desk's yaw in the room, in degrees — the sheets lie along its long axis.</summary>
        private const float k_DeskYawDegrees = 102f;

        /// <summary>
        /// Height of the desk top, in metres: the desktop slab sits at 0.78 and is 0.1 thick
        /// (<c>BriggsInteriorDressingBuilder.BuildArchiveDeskPrefab</c>), so its surface is 0.83.
        /// </summary>
        private const float k_DeskTopHeight = 0.83f;

        /// <summary>How far the paper floats above the surface, in metres — enough not to z-fight.</summary>
        private const float k_Lift = 0.012f;

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

            // Always additive: an environment part scene owns no camera and no listener, and
            // opening it single would throw away whatever the level owner has open right now.
            Scene scene = SceneManager.GetSceneByPath(k_ScenePath);
            bool wasOpen = scene.IsValid() && scene.isLoaded;

            if (!wasOpen)
            {
                scene = AssetDatabase.LoadAssetAtPath<SceneAsset>(k_ScenePath) == null
                    ? EditorSceneManager.NewScene(NewSceneSetup.EmptyScene, NewSceneMode.Additive)
                    : EditorSceneManager.OpenScene(k_ScenePath, OpenSceneMode.Additive);
            }

            // Reopening rather than making a fresh scene each time keeps the lighting and the
            // scene GUID; the contents are what gets rebuilt. It is also the only form that works
            // in batch mode, where a new additive scene next to the untitled one throws.
            ClearRoot(scene);

            GameObject root = new GameObject(k_RootName);
            SceneManager.MoveGameObjectToScene(root, scene);

            int layer = FirstLayerIn(AllowedLayers());

            for (int i = 0; i < documents.Length; i++)
            {
                GameObject instance = (GameObject)PrefabUtility.InstantiatePrefab(prefab, scene);
                instance.name = $"ArchiveDocument_{documents[i].Id}";
                instance.transform.SetParent(root.transform, false);

                // Laid out along the desk's long axis, on its surface. Exact placement is the
                // level owner's to nudge in the Editor.
                Quaternion desk = Quaternion.Euler(0f, k_DeskYawDegrees, 0f);
                float across = (i - (documents.Length - 1) * 0.5f) * k_Spacing;
                instance.transform.position = k_DeskPosition
                    + Vector3.up * (k_DeskTopHeight + k_Lift)
                    + desk * new Vector3(across, 0f, 0f);

                // Face up: the readable side of a page looks back along its own forward axis. Its
                // up runs along the desk's depth, so the text reads from where you stand at it.
                instance.transform.rotation = Quaternion.LookRotation(Vector3.down, desk * Vector3.forward);

                SetLayerRecursively(instance, layer);

                SerializedObject serialized = new SerializedObject(
                    instance.GetComponent<ArchiveDocumentPickup>());
                serialized.FindProperty("m_document").objectReferenceValue = documents[i];
                serialized.ApplyModifiedProperties();
            }

            EditorSceneManager.SaveScene(scene, k_ScenePath);

            if (!wasOpen)
            {
                EditorSceneManager.CloseScene(scene, true);
            }

            AssetDatabase.Refresh();

            Debug.Log($"[{k_LogPrefix}] Wrote {k_ScenePath} with {documents.Length} document(s) on "
                + "the archive desk. Open it additively next to BriggsInterior_Environment to move them.");
        }

        /// <summary>
        /// Puts the read loop on the Briggs player, so the sheets in the part scene can actually be
        /// picked up. The components land on the <c>Player</c> prefab instance as scene overrides —
        /// Briggs is the only level with documents in it, and the playtest scene already carries its
        /// own copy, so putting them on the prefab would give that scene two of each.
        /// </summary>
        [MenuItem("RootsDance/Archive/Wire Briggs Player For Reading")]
        public static void WirePlayer()
        {
            Scene scene = SceneManager.GetSceneByPath(k_GameplayPath);
            bool wasOpen = scene.IsValid() && scene.isLoaded;

            if (!wasOpen)
            {
                scene = EditorSceneManager.OpenScene(k_GameplayPath, OpenSceneMode.Additive);
            }

            FirstPersonController player = FindPlayer(scene);

            if (player == null)
            {
                Debug.LogError($"[{k_LogPrefix}] No FirstPersonController in {k_GameplayPath}.");

                if (!wasOpen)
                {
                    EditorSceneManager.CloseScene(scene, true);
                }

                return;
            }

            DocumentInspectController reader = ArchivePlaytestBuilder.SetUpReader(player);
            ArchivePlaytestBuilder.SetUpOffer(player, reader);

            // Read off what the log needs before closing: closing the scene destroys the objects,
            // and touching one afterwards throws.
            string playerName = player.name;

            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);

            if (!wasOpen)
            {
                EditorSceneManager.CloseScene(scene, true);
            }

            Debug.Log($"[{k_LogPrefix}] Wired the reader and the proximity offer onto "
                + $"'{playerName}' in {k_GameplayPath}.");
        }

        /// <summary>Drops what a previous build left behind, so a rebuild replaces rather than stacks.</summary>
        private static void ClearRoot(Scene scene)
        {
            GameObject[] roots = scene.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                if (roots[i].name == k_RootName)
                {
                    Object.DestroyImmediate(roots[i]);
                }
            }
        }

        /// <summary>The player in one scene, ignoring any other scene the Editor has open.</summary>
        private static FirstPersonController FindPlayer(Scene scene)
        {
            GameObject[] roots = scene.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                FirstPersonController player = roots[i].GetComponentInChildren<FirstPersonController>(true);

                if (player != null)
                {
                    return player;
                }
            }

            return null;
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
