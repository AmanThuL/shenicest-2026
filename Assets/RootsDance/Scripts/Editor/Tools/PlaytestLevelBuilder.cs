using System.Collections.Generic;
using System.Linq;
using Unity.Cinemachine;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;
using RootsDance.App;
using RootsDance.Data;

namespace RootsDance.Editor.Tools
{
    /// <summary>
    /// Builds a dedicated Environment + Gameplay level so the first-person controller can be
    /// playtested with visible landmarks. Bootstrap must stay free of content (rule in
    /// docs/guidelines/11-scenes-prefabs-workflow.md), so this is the only sanctioned place to
    /// walk around in. Also repairs a known Player.prefab wiring mistake before building.
    /// Menu: RootsDance > Build Player Playtest Level.
    /// </summary>
    public static class PlaytestLevelBuilder
    {
        private const string k_LevelFolder = "Assets/RootsDance/Scenes/Levels/PlayerTest";
        private const string k_EnvironmentPath = k_LevelFolder + "/PlayerTest_Environment.unity";
        private const string k_GameplayPath = k_LevelFolder + "/PlayerTest_Gameplay.unity";
        private const string k_LevelAssetPath = "Assets/RootsDance/Data/Levels/PlayerTest.asset";
        private const string k_PlayerPrefabPath = "Assets/RootsDance/Prefabs/Characters/Player.prefab";

        [MenuItem("RootsDance/Build Player Playtest Level")]
        private static void Build()
        {
            if (System.IO.File.Exists(k_EnvironmentPath) || System.IO.File.Exists(k_GameplayPath))
            {
                bool overwrite = EditorUtility.DisplayDialog(
                    "Playtest level exists",
                    "PlayerTest_Environment / PlayerTest_Gameplay already exist. Rebuild and overwrite them?",
                    "Overwrite",
                    "Cancel");

                if (!overwrite)
                {
                    return;
                }
            }

            if (!EditorSceneManager.SaveCurrentModifiedScenesIfUserWantsTo())
            {
                Debug.LogWarning("Build cancelled: current scenes have unsaved changes.");
                return;
            }

            EnsureBootstrapCinemachineBrain();
            FixPlayerHeadReference();

            EnsureFolder(k_LevelFolder);

            Transform head = BuildEnvironmentScene();
            BuildGameplayScene(head);
            CreateLevelAsset();
            RegisterScenesInBuildSettings();

            Debug.Log("Playtest level built. Open PlayerTest_Environment.unity, then open "
                + "PlayerTest_Gameplay.unity additively, set the Environment scene active, and press Play.");
        }

        /// <summary>
        /// Bootstrap's Main Camera has shipped without a CinemachineBrain since the original project
        /// scaffold — no Brain means no CinemachineCamera in any content scene ever drives the real
        /// camera, so the view never follows the player. Adds it in place if still missing.
        /// </summary>
        private static void EnsureBootstrapCinemachineBrain()
        {
            Scene bootstrap = EditorSceneManager.OpenScene(ScenePaths.k_Bootstrap, OpenSceneMode.Single);
            Camera mainCamera = Camera.main;

            if (mainCamera == null)
            {
                Debug.LogWarning("PlaytestLevelBuilder: no MainCamera-tagged Camera found in "
                    + "Bootstrap.unity; add Camera + CinemachineBrain by hand.");
                return;
            }

            if (mainCamera.GetComponent<CinemachineBrain>() != null)
            {
                return; // already fixed
            }

            mainCamera.gameObject.AddComponent<CinemachineBrain>();
            EditorSceneManager.MarkSceneDirty(bootstrap);
            EditorSceneManager.SaveScene(bootstrap);
            Debug.Log("PlaytestLevelBuilder: added the missing CinemachineBrain to Bootstrap's Main Camera.");
        }

        /// <summary>
        /// PlayerLook.m_head was wired to the Player root's own transform instead of the "m_head"
        /// child — pitch would overwrite yaw every frame. Repairs it in place if still wrong.
        /// </summary>
        private static void FixPlayerHeadReference()
        {
            GameObject prefabRoot = PrefabUtility.LoadPrefabContents(k_PlayerPrefabPath);

            try
            {
                Transform head = prefabRoot.transform.Find("m_head");
                MonoBehaviour look = prefabRoot.GetComponents<MonoBehaviour>()
                    .FirstOrDefault(component => component.GetType().Name == "PlayerLook");

                if (head == null || look == null)
                {
                    Debug.LogWarning("PlaytestLevelBuilder: could not find m_head / PlayerLook on "
                        + "Player.prefab; skipping the wiring fix-up.");
                    return;
                }

                SerializedObject serialized = new SerializedObject(look);
                SerializedProperty headProperty = serialized.FindProperty("m_head");

                if (headProperty.objectReferenceValue == head)
                {
                    return; // already correct
                }

                headProperty.objectReferenceValue = head;
                serialized.ApplyModifiedProperties();
                PrefabUtility.SaveAsPrefabAsset(prefabRoot, k_PlayerPrefabPath);
                Debug.Log("PlaytestLevelBuilder: fixed PlayerLook.m_head on Player.prefab "
                    + "(was pointing at the Player root, now points at the m_head child).");
            }
            finally
            {
                PrefabUtility.UnloadPrefabContents(prefabRoot);
            }
        }

        /// <summary>Ground + spaced landmarks + sun. Returns nothing usable across scenes — the
        /// player and its head transform are built fresh in the Gameplay scene.</summary>
        private static Transform BuildEnvironmentScene()
        {
            Scene scene = EditorSceneManager.NewScene(NewSceneSetup.EmptyScene, NewSceneMode.Single);

            Transform lighting = new GameObject("_Lighting").transform;
            GameObject sun = new GameObject("Sun");
            sun.transform.SetParent(lighting, false);
            sun.transform.rotation = Quaternion.Euler(50f, -30f, 0f);
            Light light = sun.AddComponent<Light>();
            light.type = LightType.Directional;
            light.intensity = 1f;

            Transform geometry = new GameObject("_Geometry").transform;

            GameObject ground = GameObject.CreatePrimitive(PrimitiveType.Plane);
            ground.name = "Ground";
            ground.transform.SetParent(geometry, false);
            ground.transform.localScale = new Vector3(10f, 1f, 10f); // 100m x 100m

            // Landmarks ahead of spawn (+Z), rising in height so distance/parallax reads clearly
            // while walking forward — this is the whole point: Bootstrap had nothing to walk past.
            float[] forwardDistances = { 5f, 10f, 20f, 35f, 55f };

            for (int i = 0; i < forwardDistances.Length; i++)
            {
                float height = 1f + i;
                CreateLandmark(geometry, $"Landmark_Forward_{i}",
                    new Vector3(0f, height * 0.5f, forwardDistances[i]), height);
            }

            // Landmarks to the side, so turning/strafing is visible too.
            float[] sideDistances = { 5f, 10f, 20f };

            for (int i = 0; i < sideDistances.Length; i++)
            {
                CreateLandmark(geometry, $"Landmark_Right_{i}",
                    new Vector3(sideDistances[i], 1f, 0f), 2f);
            }

            // Close, tall pillar to sanity-check the pitch-up clamp against a nearby object.
            CreateLandmark(geometry, "Landmark_TallPillar", new Vector3(0f, 4f, 8f), 8f);

            EnsureFolder(k_LevelFolder);
            EditorSceneManager.SaveScene(scene, k_EnvironmentPath);

            return null;
        }

        private static void CreateLandmark(Transform parent, string name, Vector3 position, float height)
        {
            GameObject landmark = GameObject.CreatePrimitive(PrimitiveType.Cube);
            landmark.name = name;
            landmark.transform.SetParent(parent, false);
            landmark.transform.position = position;
            landmark.transform.localScale = new Vector3(1f, height, 1f);
        }

        private static void BuildGameplayScene(Transform unused)
        {
            Scene scene = EditorSceneManager.NewScene(NewSceneSetup.EmptyScene, NewSceneMode.Single);

            Transform spawns = new GameObject("_Spawns").transform;
            GameObject spawnPoint = new GameObject("PlayerSpawn");
            spawnPoint.transform.SetParent(spawns, false);
            spawnPoint.transform.position = new Vector3(0f, 0.1f, -10f);

            GameObject playerPrefab = AssetDatabase.LoadAssetAtPath<GameObject>(k_PlayerPrefabPath);

            if (playerPrefab == null)
            {
                Debug.LogError("PlaytestLevelBuilder: Player.prefab not found at " + k_PlayerPrefabPath);
                return;
            }

            GameObject playerInstance = (GameObject)PrefabUtility.InstantiatePrefab(playerPrefab, scene);
            playerInstance.transform.position = spawnPoint.transform.position;
            playerInstance.transform.rotation = Quaternion.identity;

            Transform head = playerInstance.transform.Find("m_head");

            Transform cameras = new GameObject("_Cameras").transform;
            GameObject cameraRig = new GameObject("FirstPersonCamera");
            cameraRig.transform.SetParent(cameras, false);
            CinemachineCamera vcam = cameraRig.AddComponent<CinemachineCamera>();

            if (head != null)
            {
                vcam.Target.TrackingTarget = head;

                // A bare Tracking Target does nothing on its own — Cinemachine only moves/rotates
                // the vcam if a procedural component in each pipeline stage consumes it. Both are
                // zero-damping "hard" copies: PlayerLook already computes the exact yaw/pitch, so
                // the camera must not add its own lag on top, or the view visibly trails the head.
                // Small, not zero: exact zero exposes every sub-frame tick of the CharacterController's
                // ground-stick correction (FirstPersonController.cs) as visible camera jitter.
                CinemachineHardLockToTarget positionControl = cameraRig.AddComponent<CinemachineHardLockToTarget>();
                positionControl.Damping = 0.05f;

                CinemachineRotateWithFollowTarget rotationControl =
                    cameraRig.AddComponent<CinemachineRotateWithFollowTarget>();
                rotationControl.Damping = 0.05f;
            }
            else
            {
                Debug.LogWarning("PlaytestLevelBuilder: Player instance has no m_head child; "
                    + "assign CinemachineCamera's Tracking Target and procedural components by hand.");
            }

            EnsureFolder(k_LevelFolder);
            EditorSceneManager.SaveScene(scene, k_GameplayPath);
        }

        private static void CreateLevelAsset()
        {
            EnsureFolder("Assets/RootsDance/Data/Levels");

            LevelSO level = AssetDatabase.LoadAssetAtPath<LevelSO>(k_LevelAssetPath);
            bool isNew = level == null;

            if (isNew)
            {
                level = ScriptableObject.CreateInstance<LevelSO>();
            }

            SerializedObject serialized = new SerializedObject(level);
            SerializedProperty scenePaths = serialized.FindProperty("m_scenePaths");
            scenePaths.arraySize = 2;
            scenePaths.GetArrayElementAtIndex(0).stringValue = k_EnvironmentPath;
            scenePaths.GetArrayElementAtIndex(1).stringValue = k_GameplayPath;
            serialized.ApplyModifiedProperties();

            if (isNew)
            {
                AssetDatabase.CreateAsset(level, k_LevelAssetPath);
            }
            else
            {
                EditorUtility.SetDirty(level);
            }

            AssetDatabase.SaveAssets();
        }

        private static void RegisterScenesInBuildSettings()
        {
            List<EditorBuildSettingsScene> scenes = EditorBuildSettings.scenes.ToList();

            AddIfMissing(scenes, k_EnvironmentPath);
            AddIfMissing(scenes, k_GameplayPath);

            EditorBuildSettings.scenes = scenes.ToArray();
        }

        private static void AddIfMissing(List<EditorBuildSettingsScene> scenes, string path)
        {
            if (scenes.Any(scene => scene.path == path))
            {
                return;
            }

            scenes.Add(new EditorBuildSettingsScene(path, true));
        }

        private static void EnsureFolder(string path)
        {
            if (AssetDatabase.IsValidFolder(path))
            {
                return;
            }

            string parent = System.IO.Path.GetDirectoryName(path).Replace('\\', '/');
            string folderName = System.IO.Path.GetFileName(path);

            EnsureFolder(parent);
            AssetDatabase.CreateFolder(parent, folderName);
        }
    }
}
