using System;
using System.Collections.Generic;
using System.Linq;
using RootsDance.App;
using RootsDance.Core;
using RootsDance.Data;
using RootsDance.Editor.DevPlay;
using RootsDance.Investigation;
using Unity.Cinemachine;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>Builds the Chapter 03 greenhouse interior level and its Dev Play checkpoints.</summary>
    public static class GreenhouseInteriorLevelBuilder
    {
        public const float k_TargetHeight = 31f;

        private const string k_LevelName = "GreenhouseInterior";
        private const string k_LevelFolder = "Assets/RootsDance/Scenes/Levels/" + k_LevelName;
        private const string k_LevelAssetPath = "Assets/RootsDance/Data/Levels/" + k_LevelName + ".asset";
        private const string k_CheckpointFolder = "Assets/RootsDance/Data/DevPlay/" + k_LevelName;
        private const string k_PlayerPrefabPath = "Assets/RootsDance/Prefabs/Characters/Player.prefab";
        private const string k_GreenhouseModelPath =
            "Assets/RootsDance/Meshes/Environment/GAIA1/Buildings/Briggs_Greenhouse.fbx";
        private const string k_SharedMaterialFolder =
            "Assets/RootsDance/Materials/Environment/GreenHouse";
        private const string k_InteriorMaterialFolder = k_SharedMaterialFolder + "/Chapter03";
        private const string k_VegetationPrefabFolder =
            "Assets/RootsDance/Prefabs/Environment/LabDressingVariants";
        private const string k_InteriorVolumeProfilePath =
            "Assets/RootsDance/Settings/VolumeProfiles/MainProfile.asset";
        private const string k_EntranceAnchor = "Checkpoint_GreenhouseEntrance";
        private const string k_CentralAnchor = "Checkpoint_CentralGreenhouse";

        private static readonly CheckpointPlacement[] k_CheckpointPlacements =
        {
            new CheckpointPlacement(k_EntranceAnchor, new Vector3(0f, 1.05f, -10f), 0f),
            new CheckpointPlacement(k_CentralAnchor, new Vector3(0f, 1f, 0f), 180f),
        };

        private static readonly PlantPlacement[] k_PlantPlacements =
        {
            new PlantPlacement("M3D_fern-1_NoCollision", -14f, -9f, 15f, 1.8f),
            new PlantPlacement("M3D_fern-2_NoCollision", -9f, -9f, 55f, 1.6f),
            new PlantPlacement("M3D_grass_patch_5_NoCollision", -5f, -9f, 95f, 1.5f),
            new PlantPlacement("M3D_grass_patch_8_NoCollision", 5f, -9f, 130f, 1.7f),
            new PlantPlacement("M3D_fern-1_NoCollision", 9f, -9f, 205f, 1.7f),
            new PlantPlacement("M3D_fern-2_NoCollision", 14f, -9f, 245f, 1.9f),
            new PlantPlacement("M3D_grass_patch_3_NoCollision", -14f, -3f, 330f, 1.7f),
            new PlantPlacement("M3D_fern-2_NoCollision", -9f, -3f, 20f, 1.8f),
            new PlantPlacement("M3D_grass_patch_7_NoCollision", -5f, -3f, 75f, 1.6f),
            new PlantPlacement("M3D_fern-1_NoCollision", 5f, -3f, 110f, 1.8f),
            new PlantPlacement("M3D_grass_patch_2_NoCollision", 9f, -3f, 175f, 1.6f),
            new PlantPlacement("M3D_fern-2_NoCollision", 14f, -3f, 225f, 1.7f),
            new PlantPlacement("M3D_fern-1_NoCollision", -14f, 4f, 285f, 1.9f),
            new PlantPlacement("M3D_grass_patch_6_NoCollision", -9f, 4f, 340f, 1.5f),
            new PlantPlacement("M3D_fern-2_NoCollision", -5f, 4f, 35f, 1.7f),
            new PlantPlacement("M3D_grass_patch_4_NoCollision", 5f, 4f, 85f, 1.6f),
            new PlantPlacement("M3D_fern-1_NoCollision", 9f, 4f, 145f, 1.8f),
            new PlantPlacement("M3D_fern-2_NoCollision", 14f, 4f, 195f, 1.8f),
            new PlantPlacement("M3D_grass_patch_1_NoCollision", -14f, 10f, 255f, 1.7f),
            new PlantPlacement("M3D_fern-2_NoCollision", -9f, 10f, 315f, 1.8f),
            new PlantPlacement("M3D_grass_patch_8_NoCollision", -5f, 10f, 10f, 1.6f),
            new PlantPlacement("M3D_fern-1_NoCollision", 5f, 10f, 65f, 1.9f),
            new PlantPlacement("M3D_grass_patch_5_NoCollision", 9f, 10f, 125f, 1.6f),
            new PlantPlacement("M3D_fern-2_NoCollision", 14f, 10f, 185f, 1.7f),
        };

        [MenuItem("RootsDance/Build Chapter 03 Greenhouse Interior")]
        public static void Build()
        {
            ThrowIfAnyOpenSceneIsDirty();

            SceneSetup[] originalSetup = EditorSceneManager.GetSceneManagerSetup();
            LevelSO level = null;

            try
            {
                AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
                EnsureFolder(k_LevelFolder);
                EnsureFolder(k_CheckpointFolder);
                EnsureFolder(k_InteriorMaterialFolder);

                GreenhouseMaterials materials = EnsureInteriorMaterials();
                BuildEnvironmentScene(materials);
                BuildGameplayScene();
                level = CreateLevelAsset();
                CreateCheckpointAssets(level);
                RegisterScenesInBuildSettings();
                AssetDatabase.SaveAssets();
            }
            finally
            {
                bool hasLoadedScene = originalSetup.Any(setup => setup.isLoaded);

                if (hasLoadedScene)
                {
                    EditorSceneManager.RestoreSceneManagerSetup(originalSetup);
                }
            }

            Log.Info("Built the Chapter 03 greenhouse interior at a 31 metre maximum height.", level);
        }

        public static void BuildFromCommandLine()
        {
            try
            {
                Build();
                EditorApplication.Exit(0);
            }
            catch (Exception exception)
            {
                Debug.LogException(exception);
                EditorApplication.Exit(1);
            }
        }

        private static void ThrowIfAnyOpenSceneIsDirty()
        {
            for (int i = 0; i < SceneManager.sceneCount; i++)
            {
                Scene scene = SceneManager.GetSceneAt(i);

                if (scene.isDirty)
                {
                    throw new InvalidOperationException(
                        "GreenhouseInterior build stopped because an open scene has unsaved changes: " + scene.path);
                }
            }
        }

        private static void BuildEnvironmentScene(GreenhouseMaterials materials)
        {
            Scene scene = EditorSceneManager.NewScene(NewSceneSetup.EmptyScene, NewSceneMode.Single);
            Transform lighting = CreateRoot("_Lighting");
            Transform geometry = CreateRoot("_Geometry");
            Transform greenhouseRoot = CreateChild("GreenhouseRoot", geometry);
            Transform props = CreateRoot("_Props");
            CreateRoot("_NavMesh");

            CreateLighting(lighting);

            GameObject greenhouse = InstantiateModel(
                k_GreenhouseModelPath,
                "Briggs_Greenhouse",
                greenhouseRoot,
                scene);
            Bounds greenhouseBounds = ScaleAndGroundModel(greenhouse, k_TargetHeight);
            ApplyInteriorMaterials(greenhouse, materials);
            ValidatePlayerScaleReference();
            SetStatic(greenhouse);
            CreateWalkableFloor(geometry, greenhouseBounds);
            CreateBotanicalBeds(props, scene);
            CreateScaleReference(props);

            EditorSceneManager.SaveScene(scene, ScenePaths.k_GreenhouseInteriorEnvironment);
        }

        private static void BuildGameplayScene()
        {
            Scene scene = EditorSceneManager.NewScene(NewSceneSetup.EmptyScene, NewSceneMode.Single);
            Transform cameras = CreateRoot("_Cameras");
            Transform spawns = CreateRoot("_Spawns");
            CreateRoot("_Triggers");
            CreateRoot("_Interactables");
            Transform anchors = CreateRoot("_Anchors");

            for (int i = 0; i < k_CheckpointPlacements.Length; i++)
            {
                CheckpointPlacement placement = k_CheckpointPlacements[i];
                GameObject anchor = new GameObject(placement.AnchorName);
                anchor.transform.SetParent(anchors, false);
                anchor.transform.SetPositionAndRotation(
                    placement.Position,
                    Quaternion.Euler(0f, placement.Yaw, 0f));
            }

            CheckpointPlacement entrance = k_CheckpointPlacements[0];
            GameObject spawnPoint = new GameObject("PlayerSpawn");
            spawnPoint.transform.SetParent(spawns, false);
            spawnPoint.transform.SetPositionAndRotation(
                entrance.Position,
                Quaternion.Euler(0f, entrance.Yaw, 0f));

            GameObject playerPrefab = AssetDatabase.LoadAssetAtPath<GameObject>(k_PlayerPrefabPath);

            if (playerPrefab == null)
            {
                throw new System.IO.FileNotFoundException("Player prefab was not found: " + k_PlayerPrefabPath);
            }

            GameObject player = (GameObject)PrefabUtility.InstantiatePrefab(playerPrefab, scene);
            player.transform.SetPositionAndRotation(spawnPoint.transform.position, spawnPoint.transform.rotation);
            player.transform.localScale = Vector3.one;
            CreateFirstPersonCamera(cameras, player.transform);

            EditorSceneManager.SaveScene(scene, ScenePaths.k_GreenhouseInteriorGameplay);
        }

        private static Transform CreateRoot(string name)
        {
            GameObject root = new GameObject(name);
            root.transform.SetPositionAndRotation(Vector3.zero, Quaternion.identity);
            root.transform.localScale = Vector3.one;
            return root.transform;
        }

        private static Transform CreateChild(string name, Transform parent)
        {
            Transform child = CreateRoot(name);
            child.SetParent(parent, false);
            return child;
        }

        private static GameObject InstantiateModel(string path, string name, Transform parent, Scene scene)
        {
            GameObject model = AssetDatabase.LoadAssetAtPath<GameObject>(path);

            if (model == null)
            {
                throw new System.IO.FileNotFoundException("Model was not imported: " + path);
            }

            GameObject instance = (GameObject)PrefabUtility.InstantiatePrefab(model, scene);
            instance.name = name;
            instance.transform.SetParent(parent, false);
            instance.transform.SetLocalPositionAndRotation(Vector3.zero, Quaternion.identity);
            instance.transform.localScale = Vector3.one;
            return instance;
        }

        private static Bounds ScaleAndGroundModel(GameObject greenhouse, float targetHeight)
        {
            Bounds originalBounds = GetRendererBounds(greenhouse);

            if (originalBounds.size.y <= 0f)
            {
                throw new InvalidOperationException("The greenhouse renderer bounds have no height.");
            }

            float uniformScale = targetHeight / originalBounds.size.y;

            if (Mathf.Abs(uniformScale - 1.2f) > 0.05f)
            {
                throw new InvalidOperationException(
                    "The calculated greenhouse scale is no longer approximately 1.2x: " + uniformScale);
            }

            greenhouse.transform.localScale = Vector3.one * uniformScale;
            Bounds fittedBounds = GetRendererBounds(greenhouse);
            greenhouse.transform.position += new Vector3(
                -fittedBounds.center.x,
                -fittedBounds.min.y,
                -fittedBounds.center.z);
            fittedBounds = GetRendererBounds(greenhouse);

            if (Mathf.Abs(fittedBounds.size.y - targetHeight) > 0.01f)
            {
                throw new InvalidOperationException(
                    "The grounded greenhouse height is not 31 metres: " + fittedBounds.size.y);
            }

            return fittedBounds;
        }

        private static Bounds GetRendererBounds(GameObject root)
        {
            Renderer[] renderers = root.GetComponentsInChildren<Renderer>(true);

            if (renderers.Length == 0)
            {
                throw new InvalidOperationException("Model has no renderers: " + root.name);
            }

            Bounds bounds = renderers[0].bounds;

            for (int i = 1; i < renderers.Length; i++)
            {
                bounds.Encapsulate(renderers[i].bounds);
            }

            return bounds;
        }

        private static void CreateWalkableFloor(Transform parent, Bounds greenhouseBounds)
        {
            GameObject floor = new GameObject("WalkableFloor");
            floor.transform.SetParent(parent, false);
            floor.transform.position = new Vector3(0f, -0.1f, 0f);
            floor.layer = LayerMask.NameToLayer("Ground");
            floor.isStatic = true;
            BoxCollider collider = floor.AddComponent<BoxCollider>();
            collider.size = new Vector3(greenhouseBounds.size.x, 0.2f, greenhouseBounds.size.z);
        }

        private static void CreateScaleReference(Transform parent)
        {
            GameObject marker = new GameObject("PlayerHeightReference_1p8m");
            marker.transform.SetParent(parent, false);
            marker.transform.localPosition = new Vector3(2f, 0.9f, 0f);
            BoxCollider collider = marker.AddComponent<BoxCollider>();
            collider.size = new Vector3(0.1f, 1.8f, 0.1f);
            collider.isTrigger = true;
            marker.SetActive(false);
        }

        private static void CreateBotanicalBeds(Transform parent, Scene scene)
        {
            Transform beds = CreateChild("BotanicalBeds", parent);

            for (int i = 0; i < k_PlantPlacements.Length; i++)
            {
                PlantPlacement placement = k_PlantPlacements[i];
                string prefabPath = k_VegetationPrefabFolder + "/" + placement.PrefabName + ".prefab";
                GameObject prefab = AssetDatabase.LoadAssetAtPath<GameObject>(prefabPath);

                if (prefab == null)
                {
                    throw new System.IO.FileNotFoundException(
                        "Greenhouse vegetation prefab was not found: " + prefabPath);
                }

                GameObject plant = (GameObject)PrefabUtility.InstantiatePrefab(prefab, scene);
                plant.name = "Botanical_" + (i + 1).ToString("00") + "_" + placement.PrefabName;
                plant.transform.SetParent(beds, false);
                plant.transform.localPosition = new Vector3(placement.X, 0f, placement.Z);
                plant.transform.localRotation = Quaternion.Euler(0f, placement.Yaw, 0f);
                plant.transform.localScale *= placement.Scale;
                SetStatic(plant);
            }
        }

        private static void CreateLighting(Transform parent)
        {
            VolumeProfile profile = AssetDatabase.LoadAssetAtPath<VolumeProfile>(k_InteriorVolumeProfilePath);

            if (profile == null)
            {
                throw new System.IO.FileNotFoundException(
                    "The greenhouse base volume profile was not found: " + k_InteriorVolumeProfilePath);
            }

            GameObject volumeObject = new GameObject("Global Volume");
            volumeObject.transform.SetParent(parent, false);
            Volume volume = volumeObject.AddComponent<Volume>();
            volume.isGlobal = true;
            volume.priority = 0f;
            volume.weight = 1f;
            volume.sharedProfile = profile;

            GameObject sunObject = new GameObject("Sun");
            sunObject.transform.SetParent(parent, false);
            sunObject.transform.rotation = Quaternion.Euler(52f, -28f, 0f);
            Light sun = sunObject.AddComponent<Light>();
            sun.type = LightType.Directional;
            sun.intensity = 12000f;
            sun.colorTemperature = 5600f;
            sun.useColorTemperature = true;
            sun.shadows = LightShadows.Soft;

            CreatePointLight(parent, "GreenhouseFill_NorthWest", new Vector3(-22f, 9f, 7f));
            CreatePointLight(parent, "GreenhouseFill_NorthCentre", new Vector3(0f, 11f, 7f));
            CreatePointLight(parent, "GreenhouseFill_NorthEast", new Vector3(22f, 9f, 7f));
            CreatePointLight(parent, "GreenhouseFill_SouthWest", new Vector3(-22f, 9f, -7f));
            CreatePointLight(parent, "GreenhouseFill_SouthCentre", new Vector3(0f, 11f, -7f));
            CreatePointLight(parent, "GreenhouseFill_SouthEast", new Vector3(22f, 9f, -7f));
        }

        private static void CreatePointLight(Transform parent, string name, Vector3 position)
        {
            GameObject lightObject = new GameObject(name);
            lightObject.transform.SetParent(parent, false);
            lightObject.transform.localPosition = position;
            Light light = lightObject.AddComponent<Light>();
            light.type = LightType.Point;
            light.intensity = 250000f;
            light.range = 28f;
            light.color = new Color(0.72f, 0.88f, 0.76f);
            light.shadows = LightShadows.None;
        }

        private static GreenhouseMaterials EnsureInteriorMaterials()
        {
            return new GreenhouseMaterials(
                EnsureInteriorMaterial("GreenHouseMetal"),
                EnsureInteriorMaterial("GreenHouseGlass"),
                EnsureInteriorMaterial("GreenHouseStained"));
        }

        private static Material EnsureInteriorMaterial(string sharedName)
        {
            string sharedPath = k_SharedMaterialFolder + "/" + sharedName + ".mat";
            string interiorPath = k_InteriorMaterialFolder + "/" + sharedName + "_Interior.mat";
            Material source = AssetDatabase.LoadAssetAtPath<Material>(sharedPath);

            if (source == null)
            {
                throw new System.IO.FileNotFoundException("Shared greenhouse material was not found: " + sharedPath);
            }

            Material interior = AssetDatabase.LoadAssetAtPath<Material>(interiorPath);

            if (interior == null)
            {
                interior = new Material(source);
                interior.name = sharedName + "_Interior";
                AssetDatabase.CreateAsset(interior, interiorPath);
            }
            else
            {
                interior.CopyPropertiesFromMaterial(source);
            }

            interior.SetFloat("_DoubleSidedEnable", 1f);
            interior.SetFloat("_DoubleSidedNormalMode", 1f);

            if (sharedName == "GreenHouseMetal")
            {
                interior.SetColor("_BaseColor", new Color(0.68f, 0.74f, 0.69f, 1f));
            }
            else if (sharedName == "GreenHouseGlass")
            {
                interior.SetColor("_BaseColor", new Color(0.62f, 0.78f, 0.70f, 0.48f));
            }
            else
            {
                interior.SetColor("_BaseColor", Color.white);
            }

            interior.enableInstancing = true;
            HDMaterial.ValidateMaterial(interior);
            EditorUtility.SetDirty(interior);
            return interior;
        }

        private static void ApplyInteriorMaterials(GameObject greenhouse, GreenhouseMaterials materials)
        {
            Renderer[] renderers = greenhouse.GetComponentsInChildren<Renderer>(true);
            int metalCount = 0;
            int glassCount = 0;
            int stainedCount = 0;

            for (int rendererIndex = 0; rendererIndex < renderers.Length; rendererIndex++)
            {
                Renderer renderer = renderers[rendererIndex];
                Material[] assigned = renderer.sharedMaterials;

                for (int materialIndex = 0; materialIndex < assigned.Length; materialIndex++)
                {
                    Material material = assigned[materialIndex];

                    if (material == null)
                    {
                        throw new InvalidOperationException(
                            "Missing material on greenhouse renderer: " + renderer.name);
                    }

                    if (material.name == "GreenHouseMetal")
                    {
                        assigned[materialIndex] = materials.Metal;
                        metalCount++;
                    }
                    else if (material.name == "GreenHouseGlass")
                    {
                        assigned[materialIndex] = materials.Glass;
                        glassCount++;
                    }
                    else if (material.name == "GreenHouseStained")
                    {
                        assigned[materialIndex] = materials.Stained;
                        stainedCount++;
                    }
                }

                renderer.sharedMaterials = assigned;
            }

            if (metalCount == 0 || glassCount == 0 || stainedCount == 0)
            {
                throw new InvalidOperationException(
                    "The greenhouse FBX did not expose all three expected mapped materials.");
            }
        }

        private static void ValidatePlayerScaleReference()
        {
            GameObject playerPrefab = AssetDatabase.LoadAssetAtPath<GameObject>(k_PlayerPrefabPath);

            if (playerPrefab == null)
            {
                throw new System.IO.FileNotFoundException("Player prefab was not found: " + k_PlayerPrefabPath);
            }

            CharacterController controller = playerPrefab.GetComponent<CharacterController>();

            if (controller == null || Mathf.Abs(controller.height - 1.8f) > 0.001f)
            {
                throw new InvalidOperationException("The Chapter 03 scale reference requires a 1.8 metre Player.");
            }
        }

        private static void SetStatic(GameObject root)
        {
            Transform[] transforms = root.GetComponentsInChildren<Transform>(true);

            for (int i = 0; i < transforms.Length; i++)
            {
                transforms[i].gameObject.isStatic = true;
            }
        }

        private static void CreateFirstPersonCamera(Transform cameras, Transform player)
        {
            Transform head = player.Find("Head");

            if (head == null)
            {
                head = player.Find("m_head");
            }

            if (head == null)
            {
                throw new InvalidOperationException("Player prefab has no Head or m_head child.");
            }

            GameObject cameraRig = new GameObject("FirstPersonCamera");
            cameraRig.transform.SetParent(cameras, false);
            CinemachineCamera camera = cameraRig.AddComponent<CinemachineCamera>();
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
            scenePaths.GetArrayElementAtIndex(0).stringValue = ScenePaths.k_GreenhouseInteriorEnvironment;
            scenePaths.GetArrayElementAtIndex(1).stringValue = ScenePaths.k_GreenhouseInteriorGameplay;
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

        private static void CreateCheckpointAssets(LevelSO level)
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
                k_CheckpointFolder + "/03-01_GreenhouseEntrance.asset",
                "03-01 Greenhouse entrance",
                level,
                k_CheckpointPlacements[0],
                completedExteriorFlags);
            CreateCheckpoint(
                k_CheckpointFolder + "/03-02_CentralGreenhouse.asset",
                "03-02 Central greenhouse",
                level,
                k_CheckpointPlacements[1],
                completedExteriorFlags);
        }

        private static void CreateCheckpoint(
            string assetPath,
            string label,
            LevelSO level,
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
                placement.AnchorName,
                placement.Position,
                placement.Yaw,
                CheckpointTimeOfDay.LevelDefault,
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
            AddSceneIfMissing(scenes, ScenePaths.k_GreenhouseInteriorEnvironment);
            AddSceneIfMissing(scenes, ScenePaths.k_GreenhouseInteriorGameplay);
            EditorBuildSettings.scenes = scenes.ToArray();
        }

        private static void AddSceneIfMissing(List<EditorBuildSettingsScene> scenes, string path)
        {
            int existingIndex = scenes.FindIndex(scene => scene.path == path);

            if (existingIndex >= 0)
            {
                scenes[existingIndex] = new EditorBuildSettingsScene(path, true);
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

        private sealed class GreenhouseMaterials
        {
            public GreenhouseMaterials(Material metal, Material glass, Material stained)
            {
                Metal = metal;
                Glass = glass;
                Stained = stained;
            }

            public Material Metal { get; }
            public Material Glass { get; }
            public Material Stained { get; }
        }

        private struct CheckpointPlacement
        {
            public CheckpointPlacement(string anchorName, Vector3 position, float yaw)
            {
                AnchorName = anchorName;
                Position = position;
                Yaw = yaw;
            }

            public string AnchorName;
            public Vector3 Position;
            public float Yaw;
        }

        private struct PlantPlacement
        {
            public PlantPlacement(string prefabName, float x, float z, float yaw, float scale)
            {
                PrefabName = prefabName;
                X = x;
                Z = z;
                Yaw = yaw;
                Scale = scale;
            }

            public string PrefabName;
            public float X;
            public float Z;
            public float Yaw;
            public float Scale;
        }
    }
}
