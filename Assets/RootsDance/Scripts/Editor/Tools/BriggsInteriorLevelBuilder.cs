using System.Collections.Generic;
using System.Linq;
using RootsDance.Core;
using RootsDance.Data;
using RootsDance.Editor.DevPlay;
using RootsDance.Investigation;
using Unity.Cinemachine;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Tools
{
    /// <summary>
    /// Builds the additive Briggs botanical facility interior level and its developer checkpoints.
    /// The three FBX assets keep their shared Blender origin so their connecting architecture remains aligned.
    /// </summary>
    public static class BriggsInteriorLevelBuilder
    {
        private const string k_LevelName = "BriggsInterior";
        private const string k_LevelFolder = "Assets/RootsDance/Scenes/Levels/" + k_LevelName;
        private const string k_EnvironmentPath = k_LevelFolder + "/" + k_LevelName + "_Environment.unity";
        private const string k_GameplayPath = k_LevelFolder + "/" + k_LevelName + "_Gameplay.unity";
        private const string k_LevelAssetPath = "Assets/RootsDance/Data/Levels/" + k_LevelName + ".asset";
        private const string k_CheckpointFolder = "Assets/RootsDance/Data/DevPlay/BriggsInterior";
        private const string k_PlayerPrefabPath = "Assets/RootsDance/Prefabs/Characters/Player.prefab";

        private const string k_PlantResearchLabAnchor = "Checkpoint_PlantResearchLab";
        private const string k_GreenhouseAnchor = "Checkpoint_Greenhouse";
        private const string k_SampleStorageAnchor = "Checkpoint_SampleStorage";

        private static readonly BuildingSpec[] k_Buildings =
        {
            new BuildingSpec(
                "PlantResearchLab",
                "Assets/RootsDance/Meshes/Environment/GAIA1/Buildings/Briggs_PlantResearchLab.fbx",
                k_PlantResearchLabAnchor,
                0f),
            new BuildingSpec(
                "Greenhouse",
                "Assets/RootsDance/Meshes/Environment/GAIA1/Buildings/Briggs_Greenhouse.fbx",
                k_GreenhouseAnchor,
                180f),
            new BuildingSpec(
                "SampleStorage",
                "Assets/RootsDance/Meshes/Environment/GAIA1/Buildings/Briggs_SampleStorage.fbx",
                k_SampleStorageAnchor,
                90f),
        };

        [MenuItem("RootsDance/Build Briggs Interior Checkpoint Level")]
        private static void Build()
        {
            ThrowIfAnyOpenSceneIsDirty();

            SceneSetup[] originalSetup = EditorSceneManager.GetSceneManagerSetup();
            LevelSO level = null;

            try
            {
                AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
                EnsureFolder(k_LevelFolder);
                EnsureFolder(k_CheckpointFolder);

                Dictionary<string, CheckpointPlacement> placements = BuildEnvironmentScene();
                BuildGameplayScene(placements);
                level = CreateLevelAsset();
                CreateCheckpointAssets(level, placements);
                RegisterScenesInBuildSettings();
                AssetDatabase.SaveAssets();
            }
            finally
            {
                EditorSceneManager.RestoreSceneManagerSetup(originalSetup);
            }

            Log.Info("Built BriggsInterior Environment + Gameplay scenes and three indoor checkpoints.", level);
        }

        private static void ThrowIfAnyOpenSceneIsDirty()
        {
            for (int i = 0; i < SceneManager.sceneCount; i++)
            {
                Scene scene = SceneManager.GetSceneAt(i);

                if (scene.isDirty)
                {
                    throw new System.InvalidOperationException(
                        "BriggsInterior build stopped because an open scene has unsaved changes: " + scene.path);
                }
            }
        }

        private static Dictionary<string, CheckpointPlacement> BuildEnvironmentScene()
        {
            Scene scene = EditorSceneManager.NewScene(NewSceneSetup.EmptyScene, NewSceneMode.Single);
            Transform lighting = CreateRoot("_Lighting");
            Transform geometry = CreateRoot("_Geometry");
            CreateRoot("_Props");
            CreateRoot("_NavMesh");

            CreateSun(lighting);

            Dictionary<string, CheckpointPlacement> placements =
                new Dictionary<string, CheckpointPlacement>(k_Buildings.Length);

            for (int i = 0; i < k_Buildings.Length; i++)
            {
                BuildingSpec building = k_Buildings[i];
                GameObject instance = InstantiateBuilding(building, geometry, scene);
                Bounds bounds = GetRendererBounds(instance);
                Vector3 checkpointPosition = new Vector3(bounds.center.x, bounds.min.y + 1f, bounds.center.z);

                CreateCheckpointFloor(geometry, building.Name, checkpointPosition, bounds.min.y);
                placements.Add(
                    building.AnchorName,
                    new CheckpointPlacement(checkpointPosition, building.Yaw));
            }

            EditorSceneManager.SaveScene(scene, k_EnvironmentPath);
            return placements;
        }

        private static Transform CreateRoot(string name)
        {
            GameObject root = new GameObject(name);
            root.transform.SetPositionAndRotation(Vector3.zero, Quaternion.identity);
            root.transform.localScale = Vector3.one;
            return root.transform;
        }

        private static void CreateSun(Transform parent)
        {
            GameObject sun = new GameObject("Sun");
            sun.transform.SetParent(parent, false);
            sun.transform.rotation = Quaternion.Euler(50f, -30f, 0f);
            Light light = sun.AddComponent<Light>();
            light.type = LightType.Directional;
            light.intensity = 1f;
            light.shadows = LightShadows.Soft;
        }

        private static GameObject InstantiateBuilding(BuildingSpec building, Transform parent, Scene scene)
        {
            GameObject model = AssetDatabase.LoadAssetAtPath<GameObject>(building.AssetPath);

            if (model == null)
            {
                throw new System.IO.FileNotFoundException("Building FBX was not imported: " + building.AssetPath);
            }

            GameObject instance = (GameObject)PrefabUtility.InstantiatePrefab(model, scene);
            instance.name = building.Name;
            instance.transform.SetParent(parent, false);
            instance.transform.SetLocalPositionAndRotation(Vector3.zero, Quaternion.identity);
            instance.transform.localScale = Vector3.one;

            MeshFilter[] filters = instance.GetComponentsInChildren<MeshFilter>(true);

            for (int i = 0; i < filters.Length; i++)
            {
                MeshFilter filter = filters[i];
                filter.gameObject.isStatic = true;

                if (filter.sharedMesh == null || filter.sharedMesh.vertexCount == 0)
                {
                    continue;
                }

                MeshCollider collider = filter.GetComponent<MeshCollider>();

                if (collider == null)
                {
                    collider = filter.gameObject.AddComponent<MeshCollider>();
                }

                collider.sharedMesh = filter.sharedMesh;
            }

            return instance;
        }

        private static Bounds GetRendererBounds(GameObject root)
        {
            Renderer[] renderers = root.GetComponentsInChildren<Renderer>(true);

            if (renderers.Length == 0)
            {
                throw new System.InvalidOperationException("Building has no renderers: " + root.name);
            }

            Bounds bounds = renderers[0].bounds;

            for (int i = 1; i < renderers.Length; i++)
            {
                bounds.Encapsulate(renderers[i].bounds);
            }

            return bounds;
        }

        private static void CreateCheckpointFloor(
            Transform parent,
            string buildingName,
            Vector3 checkpointPosition,
            float floorHeight)
        {
            GameObject floor = new GameObject("CheckpointFloor_" + buildingName);
            floor.transform.SetParent(parent, false);
            floor.transform.position = new Vector3(checkpointPosition.x, floorHeight - 0.05f, checkpointPosition.z);
            floor.isStatic = true;

            BoxCollider collider = floor.AddComponent<BoxCollider>();
            collider.size = new Vector3(4f, 0.1f, 4f);
        }

        private static void BuildGameplayScene(IReadOnlyDictionary<string, CheckpointPlacement> placements)
        {
            Scene scene = EditorSceneManager.NewScene(NewSceneSetup.EmptyScene, NewSceneMode.Single);
            Transform cameras = CreateRoot("_Cameras");
            Transform spawns = CreateRoot("_Spawns");
            CreateRoot("_Triggers");
            CreateRoot("_Interactables");
            Transform anchors = CreateRoot("_Anchors");

            for (int i = 0; i < k_Buildings.Length; i++)
            {
                BuildingSpec building = k_Buildings[i];
                CheckpointPlacement placement = placements[building.AnchorName];
                GameObject anchor = new GameObject(building.AnchorName);
                anchor.transform.SetParent(anchors, false);
                anchor.transform.SetPositionAndRotation(
                    placement.Position,
                    Quaternion.Euler(0f, placement.Yaw, 0f));
            }

            CheckpointPlacement initialPlacement = placements[k_PlantResearchLabAnchor];
            GameObject spawnPoint = new GameObject("PlayerSpawn");
            spawnPoint.transform.SetParent(spawns, false);
            spawnPoint.transform.SetPositionAndRotation(
                initialPlacement.Position,
                Quaternion.Euler(0f, initialPlacement.Yaw, 0f));

            GameObject playerPrefab = AssetDatabase.LoadAssetAtPath<GameObject>(k_PlayerPrefabPath);

            if (playerPrefab == null)
            {
                throw new System.IO.FileNotFoundException("Player prefab was not found: " + k_PlayerPrefabPath);
            }

            GameObject player = (GameObject)PrefabUtility.InstantiatePrefab(playerPrefab, scene);
            player.transform.SetPositionAndRotation(spawnPoint.transform.position, spawnPoint.transform.rotation);
            CreateFirstPersonCamera(cameras, player.transform);

            EditorSceneManager.SaveScene(scene, k_GameplayPath);
        }

        private static void CreateFirstPersonCamera(Transform cameras, Transform player)
        {
            Transform head = player.Find("Head");

            if (head == null)
            {
                head = player.Find("m_head");
            }
            GameObject cameraRig = new GameObject("FirstPersonCamera");
            cameraRig.transform.SetParent(cameras, false);
            CinemachineCamera camera = cameraRig.AddComponent<CinemachineCamera>();

            if (head == null)
            {
                throw new System.InvalidOperationException("Player prefab has no Head or m_head child.");
            }

            camera.Target.TrackingTarget = head;
            CinemachineHardLockToTarget positionControl = cameraRig.AddComponent<CinemachineHardLockToTarget>();
            positionControl.Damping = 0.05f;
            CinemachineRotateWithFollowTarget rotationControl =
                cameraRig.AddComponent<CinemachineRotateWithFollowTarget>();
            rotationControl.Damping = 0.05f;
        }

        private static LevelSO CreateLevelAsset()
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

            AssetDatabase.SaveAssetIfDirty(level);

            return level;
        }

        private static void CreateCheckpointAssets(
            LevelSO level,
            IReadOnlyDictionary<string, CheckpointPlacement> placements)
        {
            string[] completedExteriorFlags =
            {
                WorldFlags.k_LeftStartArea,
                WorldFlags.k_RadioBriefingStarted,
                WorldFlags.k_RadioBriefingFinished,
                WorldFlags.k_HelmetRemovable,
                WorldFlags.k_HelmetRemoved,
                WorldFlags.k_EnteredGrassBelt,
                WorldFlags.k_FirstInvestigationDone,
            };

            CreateCheckpoint(
                k_CheckpointFolder + "/02-01_PlantResearchLab.asset",
                "02-01 Plant research lab",
                level,
                k_PlantResearchLabAnchor,
                placements[k_PlantResearchLabAnchor],
                completedExteriorFlags);
            CreateCheckpoint(
                k_CheckpointFolder + "/02-02_SampleStorage.asset",
                "02-02 Sample storage",
                level,
                k_SampleStorageAnchor,
                placements[k_SampleStorageAnchor],
                completedExteriorFlags);
            CreateCheckpoint(
                k_CheckpointFolder + "/02-03_Greenhouse.asset",
                "02-03 Greenhouse",
                level,
                k_GreenhouseAnchor,
                placements[k_GreenhouseAnchor],
                completedExteriorFlags);
        }

        private static void CreateCheckpoint(
            string assetPath,
            string label,
            LevelSO level,
            string anchorName,
            CheckpointPlacement placement,
            string[] flags)
        {
            DevCheckpointSO checkpoint = AssetDatabase.LoadAssetAtPath<DevCheckpointSO>(assetPath);
            bool isNew = checkpoint == null;

            if (isNew)
            {
                checkpoint = ScriptableObject.CreateInstance<DevCheckpointSO>();
            }

            checkpoint.Configure(
                label,
                level,
                anchorName,
                placement.Position,
                placement.Yaw,
                CheckpointTimeOfDay.Night,
                flags,
                new InvestigationTargetSO[0]);

            SerializedObject serialized = new SerializedObject(checkpoint);
            serialized.FindProperty("m_snapToGround").boolValue = false;
            serialized.FindProperty("m_groundClearance").floatValue = 0f;
            serialized.ApplyModifiedProperties();

            if (isNew)
            {
                AssetDatabase.CreateAsset(checkpoint, assetPath);
            }
            else
            {
                EditorUtility.SetDirty(checkpoint);
            }

            AssetDatabase.SaveAssetIfDirty(checkpoint);
        }

        private static void RegisterScenesInBuildSettings()
        {
            List<EditorBuildSettingsScene> scenes = EditorBuildSettings.scenes.ToList();
            AddSceneIfMissing(scenes, k_EnvironmentPath);
            AddSceneIfMissing(scenes, k_GameplayPath);
            EditorBuildSettings.scenes = scenes.ToArray();
        }

        private static void AddSceneIfMissing(List<EditorBuildSettingsScene> scenes, string path)
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

        private sealed class BuildingSpec
        {
            public BuildingSpec(string name, string assetPath, string anchorName, float yaw)
            {
                Name = name;
                AssetPath = assetPath;
                AnchorName = anchorName;
                Yaw = yaw;
            }

            public string Name { get; }
            public string AssetPath { get; }
            public string AnchorName { get; }
            public float Yaw { get; }
        }

        private struct CheckpointPlacement
        {
            public CheckpointPlacement(Vector3 position, float yaw)
            {
                Position = position;
                Yaw = yaw;
            }

            public Vector3 Position;
            public float Yaw;
        }
    }
}
