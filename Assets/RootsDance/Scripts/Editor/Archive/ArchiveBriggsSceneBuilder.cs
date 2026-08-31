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

        private const string k_EnvironmentPath =
            "Assets/RootsDance/Scenes/Levels/BriggsInterior/BriggsInterior_Environment.unity";

        private const string k_GameplayPath =
            "Assets/RootsDance/Scenes/Levels/BriggsInterior/BriggsInterior_Gameplay.unity";

        private const string k_RootName = "_Archive";

        private static readonly string[] k_DocumentIds = { "DOC-001", "DOC-002" };
        private static readonly string[] k_SupportNames = { "BI_S9_Clipboard", "BI_S9_Binder" };

        /// <summary>How far the paper floats above the surface, in metres — enough not to z-fight.</summary>
        private const float k_Lift = 0.012f;

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

            ArchiveDocumentSO[] documents = LoadLabDocuments();

            if (documents == null)
            {
                return;
            }

            Scene environmentScene = SceneManager.GetSceneByPath(k_EnvironmentPath);
            bool wasEnvironmentOpen = environmentScene.IsValid() && environmentScene.isLoaded;

            if (!wasEnvironmentOpen)
            {
                environmentScene = EditorSceneManager.OpenScene(k_EnvironmentPath, OpenSceneMode.Additive);
            }

            Transform[] supports = new Transform[k_SupportNames.Length];

            for (int i = 0; i < supports.Length; i++)
            {
                supports[i] = FindTransform(environmentScene, k_SupportNames[i]);

                if (supports[i] == null)
                {
                    Debug.LogError($"[{k_LogPrefix}] {k_SupportNames[i]} is missing from "
                        + k_EnvironmentPath + ".");

                    if (!wasEnvironmentOpen)
                    {
                        EditorSceneManager.CloseScene(environmentScene, true);
                    }

                    return;
                }
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

                Bounds supportBounds = CombinedRendererBounds(supports[i]);
                Vector3 supportPosition = supports[i].position;
                instance.transform.position = new Vector3(
                    supportPosition.x,
                    supportBounds.max.y + k_Lift,
                    supportPosition.z);

                // Face up: the readable side of a page looks back along its own forward axis. Its
                // up follows the clipboard or binder it rests on.
                instance.transform.rotation = Quaternion.LookRotation(Vector3.down, supports[i].forward);

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

            if (!wasEnvironmentOpen)
            {
                EditorSceneManager.CloseScene(environmentScene, true);
            }

            AssetDatabase.Refresh();

            Debug.Log($"[{k_LogPrefix}] Wrote {k_ScenePath} with {documents.Length} document(s) on "
                + "the archive desk. Open it additively next to BriggsInterior_Environment to move them.");
        }

        private static ArchiveDocumentSO[] LoadLabDocuments()
        {
            ArchiveDocumentSO[] all = ArchivePageStage.LoadDocuments();
            ArchiveDocumentSO[] selected = new ArchiveDocumentSO[k_DocumentIds.Length];

            for (int i = 0; i < selected.Length; i++)
            {
                for (int j = 0; j < all.Length; j++)
                {
                    if (all[j] != null && all[j].Id == k_DocumentIds[i])
                    {
                        selected[i] = all[j];
                        break;
                    }
                }

                if (selected[i] == null)
                {
                    Debug.LogError($"[{k_LogPrefix}] {k_DocumentIds[i]} is missing under "
                        + "Data/Archive; run RootsDance/Archive/Create Document Assets first.");
                    return null;
                }
            }

            return selected;
        }

        private static Transform FindTransform(Scene scene, string name)
        {
            GameObject[] roots = scene.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                Transform[] transforms = roots[i].GetComponentsInChildren<Transform>(true);

                for (int j = 0; j < transforms.Length; j++)
                {
                    if (transforms[j].name == name)
                    {
                        return transforms[j];
                    }
                }
            }

            return null;
        }

        private static Bounds CombinedRendererBounds(Transform root)
        {
            Renderer[] renderers = root.GetComponentsInChildren<Renderer>(true);
            Bounds bounds = renderers[0].bounds;

            for (int i = 1; i < renderers.Length; i++)
            {
                bounds.Encapsulate(renderers[i].bounds);
            }

            return bounds;
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
