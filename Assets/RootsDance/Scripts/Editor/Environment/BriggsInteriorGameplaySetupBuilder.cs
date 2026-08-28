using System;
using System.Collections.Generic;
using System.Linq;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Aligns the Briggs player, Dev Play anchors and ground collision with the authored interior layout.
    /// </summary>
    public static class BriggsInteriorGameplaySetupBuilder
    {
        private const string k_EnvironmentPath =
            "Assets/RootsDance/Scenes/Levels/BriggsInterior/BriggsInterior_Environment.unity";
        private const string k_GameplayPath =
            "Assets/RootsDance/Scenes/Levels/BriggsInterior/BriggsInterior_Gameplay.unity";
        private const string k_PlayerPrefabPath = "Assets/RootsDance/Prefabs/Characters/Player.prefab";
        private const string k_CheckpointFolder = "Assets/RootsDance/Data/DevPlay/BriggsInterior";

        private static readonly CheckpointPlacement[] k_Checkpoints =
        {
            new CheckpointPlacement(
                "Checkpoint_LaboratoryEntrance",
                k_CheckpointFolder + "/02-01_LaboratoryEntrance.asset",
                new Vector3(3f, 1f, -22.5f),
                0f),
            new CheckpointPlacement(
                "Checkpoint_PlantResearchLab",
                k_CheckpointFolder + "/02-01_PlantResearchLab.asset",
                new Vector3(3f, 1f, -5.5f),
                0f),
            new CheckpointPlacement(
                "Checkpoint_SampleStorage",
                k_CheckpointFolder + "/02-02_SampleStorage.asset",
                new Vector3(-4.1f, 1f, -0.7f),
                90f),
            new CheckpointPlacement(
                "Checkpoint_Greenhouse",
                k_CheckpointFolder + "/02-03_Greenhouse.asset",
                new Vector3(6.8f, 1f, -3.2f),
                180f),
        };

        [MenuItem("RootsDance/Environment/Apply Briggs Interior Gameplay Setup")]
        public static void ApplyFromMenu()
        {
            ApplyAndSave();
        }

        /// <summary>Batch entry point for the deterministic Briggs gameplay alignment pass.</summary>
        public static void ApplyFromCommandLine()
        {
            ApplyAndSave();
        }

        /// <summary>Applies the setup and preserves the caller's open-scene arrangement.</summary>
        public static void ApplyAndSave()
        {
            ThrowIfAnyOpenSceneIsDirty();
            SceneSetup[] originalSetup = EditorSceneManager.GetSceneManagerSetup();

            try
            {
                FixPlayerPrefab();
                FixEnvironmentGround();
                FixGameplayScene();
                FixCheckpointAssets();
                EnableBuildScenes();
                AssetDatabase.SaveAssets();
            }
            finally
            {
                if (originalSetup.Length > 0)
                {
                    EditorSceneManager.RestoreSceneManagerSetup(originalSetup);
                }
            }

            Debug.Log("BriggsInteriorGameplaySetupBuilder: aligned player, four checkpoints and Ground layers.");
        }

        private static void FixPlayerPrefab()
        {
            GameObject root = PrefabUtility.LoadPrefabContents(k_PlayerPrefabPath);

            try
            {
                CharacterController controller = root.GetComponent<CharacterController>();

                if (controller == null)
                {
                    throw new InvalidOperationException("Player prefab is missing CharacterController.");
                }

                controller.height = 1.8f;
                controller.radius = 0.5f;
                controller.center = Vector3.zero;
                PrefabUtility.SaveAsPrefabAsset(root, k_PlayerPrefabPath);
            }
            finally
            {
                PrefabUtility.UnloadPrefabContents(root);
            }
        }

        private static void FixEnvironmentGround()
        {
            Scene scene = EditorSceneManager.OpenScene(k_EnvironmentPath, OpenSceneMode.Single);
            int groundLayer = LayerMask.NameToLayer("Ground");

            if (groundLayer < 0)
            {
                throw new InvalidOperationException("The required Ground layer does not exist.");
            }

            SetLayer(scene, "Floor_18x14m", groundLayer);
            SetLayer(scene, "Corridor_Floor_3p2x16p8m", groundLayer);
            EditorSceneManager.SaveScene(scene);
        }

        private static void FixGameplayScene()
        {
            Scene scene = EditorSceneManager.OpenScene(k_GameplayPath, OpenSceneMode.Single);
            CheckpointPlacement entrance = k_Checkpoints[0];
            Transform anchors = EnsureRoot(scene, "_Anchors");
            Transform spawns = EnsureRoot(scene, "_Spawns");

            for (int i = 0; i < k_Checkpoints.Length; i++)
            {
                CheckpointPlacement checkpoint = k_Checkpoints[i];
                Transform anchor = EnsureDirectChild(anchors, checkpoint.AnchorName);
                anchor.SetPositionAndRotation(
                    checkpoint.Position,
                    Quaternion.Euler(0f, checkpoint.Yaw, 0f));
            }

            Transform spawn = EnsureDirectChild(spawns, "PlayerSpawn");
            spawn.SetPositionAndRotation(entrance.Position, Quaternion.Euler(0f, entrance.Yaw, 0f));

            Transform player = FindRoot(scene, "Player");

            if (player == null)
            {
                throw new InvalidOperationException("Briggs gameplay scene is missing the Player prefab instance.");
            }

            player.SetPositionAndRotation(entrance.Position, Quaternion.Euler(0f, entrance.Yaw, 0f));
            RevertCharacterControllerHeightOverride(player.gameObject);
            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);
        }

        private static void FixCheckpointAssets()
        {
            for (int i = 0; i < k_Checkpoints.Length; i++)
            {
                CheckpointPlacement checkpoint = k_Checkpoints[i];
                ScriptableObject asset = AssetDatabase.LoadAssetAtPath<ScriptableObject>(checkpoint.AssetPath);

                if (asset == null)
                {
                    throw new System.IO.FileNotFoundException(
                        "Briggs Dev Play checkpoint is missing: " + checkpoint.AssetPath);
                }

                using (SerializedObject serialized = new SerializedObject(asset))
                {
                    serialized.FindProperty("m_anchorName").stringValue = checkpoint.AnchorName;
                    serialized.FindProperty("m_position").vector3Value = checkpoint.Position;
                    serialized.FindProperty("m_yaw").floatValue = checkpoint.Yaw;
                    serialized.FindProperty("m_snapToGround").boolValue = false;
                    serialized.FindProperty("m_groundClearance").floatValue = 0f;
                    serialized.ApplyModifiedPropertiesWithoutUndo();
                }

                EditorUtility.SetDirty(asset);
            }
        }

        private static void EnableBuildScenes()
        {
            List<EditorBuildSettingsScene> scenes = EditorBuildSettings.scenes.ToList();
            EnableBuildScene(scenes, k_EnvironmentPath);
            EnableBuildScene(scenes, k_GameplayPath);
            EditorBuildSettings.scenes = scenes.ToArray();
        }

        private static void EnableBuildScene(List<EditorBuildSettingsScene> scenes, string path)
        {
            int index = scenes.FindIndex(scene => scene.path == path);

            if (index >= 0)
            {
                scenes[index] = new EditorBuildSettingsScene(path, true);
                return;
            }

            scenes.Add(new EditorBuildSettingsScene(path, true));
        }

        private static void RevertCharacterControllerHeightOverride(GameObject player)
        {
            CharacterController controller = player.GetComponent<CharacterController>();

            if (controller == null)
            {
                throw new InvalidOperationException("Player scene instance is missing CharacterController.");
            }

            using (SerializedObject serialized = new SerializedObject(controller))
            {
                SerializedProperty height = serialized.FindProperty("m_Height");

                if (height != null && height.prefabOverride)
                {
                    PrefabUtility.RevertPropertyOverride(height, InteractionMode.AutomatedAction);
                }
            }
        }

        private static void SetLayer(Scene scene, string objectName, int layer)
        {
            Transform target = FindTransform(scene, objectName);

            if (target == null)
            {
                throw new InvalidOperationException("Briggs environment is missing " + objectName + ".");
            }

            target.gameObject.layer = layer;
            EditorSceneManager.MarkSceneDirty(scene);
        }

        private static Transform EnsureRoot(Scene scene, string name)
        {
            Transform existing = FindRoot(scene, name);

            if (existing != null)
            {
                return existing;
            }

            GameObject created = new GameObject(name);
            SceneManager.MoveGameObjectToScene(created, scene);
            return created.transform;
        }

        private static Transform EnsureDirectChild(Transform parent, string name)
        {
            Transform existing = parent.Find(name);

            if (existing != null)
            {
                return existing;
            }

            GameObject created = new GameObject(name);
            created.transform.SetParent(parent, false);
            return created.transform;
        }

        private static Transform FindRoot(Scene scene, string name)
        {
            GameObject[] roots = scene.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                if (roots[i].name == name)
                {
                    return roots[i].transform;
                }
            }

            return null;
        }

        private static Transform FindTransform(Scene scene, string name)
        {
            GameObject[] roots = scene.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                Transform[] transforms = roots[i].GetComponentsInChildren<Transform>(true);

                for (int transformIndex = 0; transformIndex < transforms.Length; transformIndex++)
                {
                    if (transforms[transformIndex].name == name)
                    {
                        return transforms[transformIndex];
                    }
                }
            }

            return null;
        }

        private static void ThrowIfAnyOpenSceneIsDirty()
        {
            for (int i = 0; i < SceneManager.sceneCount; i++)
            {
                Scene scene = SceneManager.GetSceneAt(i);

                if (scene.isDirty)
                {
                    throw new InvalidOperationException(
                        "Briggs gameplay setup stopped because an open scene has unsaved changes: " + scene.path);
                }
            }
        }

        private struct CheckpointPlacement
        {
            public CheckpointPlacement(string anchorName, string assetPath, Vector3 position, float yaw)
            {
                AnchorName = anchorName;
                AssetPath = assetPath;
                Position = position;
                Yaw = yaw;
            }

            public string AnchorName;
            public string AssetPath;
            public Vector3 Position;
            public float Yaw;
        }
    }
}
