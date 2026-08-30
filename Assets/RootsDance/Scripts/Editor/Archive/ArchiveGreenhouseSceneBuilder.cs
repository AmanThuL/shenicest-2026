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
    /// Puts the staff photograph (<c>DOC-003_StaffPhotograph</c>) into the greenhouse as an
    /// archive sheet, next to the grey-box "photograph" interactable
    /// <c>NarrativeRuntimeBuilder.WireGreenhouse</c> already placed east of the statue.
    /// <para>
    /// Unlike <see cref="ArchiveBriggsSceneBuilder"/>, this places exactly one named document —
    /// the greenhouse has no archive desk, and <see cref="ArchivePageStage.LoadDocuments"/>
    /// returns every sheet under <c>Data/Archive</c> regardless of which level it belongs to, so
    /// picking the id explicitly here is what keeps this sheet off the Briggs desk.
    /// </para>
    /// <para>
    /// The sheet goes into the room's second environment part scene
    /// (<c>GreenhouseInterior_Environment_2</c>, already used by
    /// <c>CirculationTerminalBuilder</c> for the console prop) rather than the main
    /// <c>GreenhouseInterior_Environment</c>, so placing it never collides with whoever is
    /// editing the room itself (guideline 11).
    /// </para>
    /// <para>
    /// The position here is a placeholder — the level owner moves it in the Editor once and this
    /// menu is not run again, the same convention <see cref="ArchiveBriggsSceneBuilder"/> uses.
    /// </para>
    /// </summary>
    public static class ArchiveGreenhouseSceneBuilder
    {
        private const string k_LogPrefix = "ArchiveGreenhouseSceneBuilder";
        private const string k_DocumentId = "DOC-003";

        private const string k_ScenePath =
            "Assets/RootsDance/Scenes/Levels/GreenhouseInterior/GreenhouseInterior_Environment_2.unity";

        private const string k_GameplayPath =
            "Assets/RootsDance/Scenes/Levels/GreenhouseInterior/GreenhouseInterior_Gameplay.unity";

        private const string k_RootName = "_Archive";
        private const string k_InstanceName = "ArchiveDocument_" + k_DocumentId;

        /// <summary>
        /// Placeholder pose: level with the grey-box "StaffPhotograph" trigger
        /// (<c>NarrativeRuntimeBuilder.WireGreenhouse</c>, <c>(4, 1.5, 6.5)</c>), standing upright
        /// and facing back down the room towards the entrance at <c>z = -9</c>.
        /// </summary>
        private static readonly Vector3 k_PlaceholderPosition = new Vector3(4f, 1.1f, 6.5f);

        [MenuItem("RootsDance/Archive/Build Greenhouse Archive Scene")]
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

            ArchiveDocumentSO document = FindDocument(k_DocumentId);

            if (document == null)
            {
                Debug.LogError($"[{k_LogPrefix}] No '{k_DocumentId}' under Data/Archive; run "
                    + "RootsDance/Archive/Create Document Assets first.");
                return;
            }

            // Always additive: an environment part scene owns no camera and no listener, and
            // opening it single would throw away whatever the level owner has open right now.
            Scene scene = SceneManager.GetSceneByPath(k_ScenePath);
            bool wasOpen = scene.IsValid() && scene.isLoaded;

            if (!wasOpen)
            {
                scene = EditorSceneManager.OpenScene(k_ScenePath, OpenSceneMode.Additive);
            }

            ClearRoot(scene);

            GameObject root = new GameObject(k_RootName);
            SceneManager.MoveGameObjectToScene(root, scene);

            GameObject instance = (GameObject)PrefabUtility.InstantiatePrefab(prefab, scene);
            instance.name = k_InstanceName;
            instance.transform.SetParent(root.transform, false);
            instance.transform.position = k_PlaceholderPosition;
            instance.transform.rotation = Quaternion.LookRotation(Vector3.back, Vector3.up);

            SetLayerRecursively(instance, FirstLayerIn(AllowedLayers()));

            SerializedObject serialized = new SerializedObject(
                instance.GetComponent<ArchiveDocumentPickup>());
            serialized.FindProperty("m_document").objectReferenceValue = document;
            serialized.ApplyModifiedProperties();

            EditorSceneManager.SaveScene(scene, k_ScenePath);

            if (!wasOpen)
            {
                EditorSceneManager.CloseScene(scene, true);
            }

            AssetDatabase.Refresh();

            Debug.Log($"[{k_LogPrefix}] Wrote {k_ScenePath} with '{k_DocumentId}' at "
                + $"{k_PlaceholderPosition} — a placeholder pose for the level owner to move.");
        }

        /// <summary>
        /// Puts the read loop on the greenhouse player, so the sheet in the part scene can
        /// actually be picked up. Mirrors <see cref="ArchiveBriggsSceneBuilder.WirePlayer"/>.
        /// </summary>
        [MenuItem("RootsDance/Archive/Wire Greenhouse Player For Reading")]
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

        private static ArchiveDocumentSO FindDocument(string id)
        {
            ArchiveDocumentSO[] documents = ArchivePageStage.LoadDocuments();

            for (int i = 0; i < documents.Length; i++)
            {
                if (documents[i] != null && documents[i].Id == id)
                {
                    return documents[i];
                }
            }

            return null;
        }

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
