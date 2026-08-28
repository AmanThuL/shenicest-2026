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
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Tools
{
    /// <summary>
    /// Builds the additive Briggs laboratory interior from the standardised plan and Garage source art.
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
        private const string k_GarageShellPath =
            "Assets/RootsDance/Meshes/Environment/Garage/GarageShell.fbx";
        private const string k_IvyHangingPath =
            "Assets/RootsDance/Meshes/Environment/Garage/IvyHanging.fbx";
        private const string k_LabCorridorPath =
            "Assets/RootsDance/Meshes/Environment/LabCorridor.fbx";
        private const string k_ConcreteLabMaterialPath =
            "Assets/RootsDance/Materials/Environment/Concrete_Lab.mat";
        private const string k_GarageMaterialFolder =
            "Assets/RootsDance/Materials/Environment/Garage";
        private const string k_GarageTextureFolder =
            "Assets/RootsDance/Textures/Environment/Garage";
        private const string k_LabEntranceAnchor = "Checkpoint_LaboratoryEntrance";

        private const float k_LabWidth = 18f;
        private const float k_LabDepth = 14f;
        private const float k_LabHeight = 5f;
        private const float k_WallThickness = 0.5f;
        private const float k_CorridorWidth = 3.2f;
        private const float k_CorridorLength = 16.8f;
        private const float k_CorridorCenterX = 3f;
        private const float k_CorridorYawDegrees = -37.837f;
        private const float k_SouthWallZ = -7f;
        private const float k_NorthExitCenterX = 0.125f;
        private const float k_NorthExitWidth = 4.5f;

        private static readonly Vector3 k_LabTargetSize = new Vector3(k_LabWidth, k_LabHeight, k_LabDepth);

        private static readonly Vector3 k_LabTargetCenter =
            new Vector3(0f, k_LabHeight * 0.5f, 0f);

        private static readonly Vector3 k_LabEntrancePosition =
            new Vector3(k_CorridorCenterX, 1f, k_SouthWallZ - k_CorridorLength + 1.3f);

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
                GarageMaterials materials = CreateGarageMaterials();

                Dictionary<string, CheckpointPlacement> placements = BuildEnvironmentScene(materials);
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

            Log.Info("Built BriggsInterior laboratory, Garage shell and ivy, and the entrance corridor.", level);
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

        private static Dictionary<string, CheckpointPlacement> BuildEnvironmentScene(GarageMaterials materials)
        {
            Scene scene = EditorSceneManager.NewScene(NewSceneSetup.EmptyScene, NewSceneMode.Single);
            Transform lighting = CreateRoot("_Lighting");
            Transform geometry = CreateRoot("_Geometry");
            Transform sourceArt = CreateChild("GarageSourceArt", geometry);
            Transform structure = CreateChild("PlanCollisionShell", geometry);
            Transform corridorRoot = CreateChild("EntranceCorridor", geometry);
            CreateRoot("_Props");
            CreateRoot("_NavMesh");

            CreateInteriorLighting(lighting);

            GameObject shell = InstantiateModel(k_GarageShellPath, "GarageShell", sourceArt, scene);
            PrefabUtility.UnpackPrefabInstance(
                shell,
                PrefabUnpackMode.Completely,
                InteractionMode.AutomatedAction);
            FitRendererBounds(shell, k_LabTargetSize, k_LabTargetCenter, Quaternion.Euler(0f, 180f, 0f));
            AssignGarageShellMaterials(shell, materials);
            SetStatic(shell);

            GameObject ivy = InstantiateModel(k_IvyHangingPath, "IvyHanging", sourceArt, scene);
            ivy.transform.SetPositionAndRotation(shell.transform.position, shell.transform.rotation);
            ivy.transform.localScale = shell.transform.localScale;
            AssignOneMaterial(ivy, materials.Ivy);
            SetStatic(ivy);

            CreatePlanCollisionShell(structure);

            GameObject corridor = InstantiateModel(k_LabCorridorPath, "LabCorridor", corridorRoot, scene);
            Vector3 corridorCenter = new Vector3(
                k_CorridorCenterX,
                k_LabHeight * 0.5f,
                k_SouthWallZ - k_CorridorLength * 0.5f);
            Vector3 corridorSize = new Vector3(k_CorridorWidth, k_LabHeight, k_CorridorLength);
            corridor.transform.localRotation = Quaternion.Euler(0f, k_CorridorYawDegrees, 0f);
            FitParentRendererBounds(corridorRoot, corridorSize, corridorCenter);

            Material corridorMaterial = AssetDatabase.LoadAssetAtPath<Material>(k_ConcreteLabMaterialPath);

            if (corridorMaterial == null)
            {
                throw new System.IO.FileNotFoundException(
                    "Corridor material was not found: " + k_ConcreteLabMaterialPath);
            }

            AssignOneMaterial(corridor, corridorMaterial);
            SetStatic(corridor);

            Dictionary<string, CheckpointPlacement> placements =
                new Dictionary<string, CheckpointPlacement>(1);
            placements.Add(k_LabEntranceAnchor, new CheckpointPlacement(k_LabEntrancePosition, 0f));

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

        private static Transform CreateChild(string name, Transform parent)
        {
            Transform child = CreateRoot(name);
            child.SetParent(parent, false);
            return child;
        }

        private static void CreateInteriorLighting(Transform parent)
        {
            GameObject sun = new GameObject("Sun");
            sun.transform.SetParent(parent, false);
            sun.transform.rotation = Quaternion.Euler(50f, -30f, 0f);
            Light sunlight = sun.AddComponent<Light>();
            sunlight.type = LightType.Directional;
            sunlight.intensity = 1f;
            sunlight.shadows = LightShadows.Soft;

            CreatePointLight(parent, "LabFill_North", new Vector3(-3f, 3.8f, 3.5f), 1300f, 12f);
            CreatePointLight(parent, "LabFill_South", new Vector3(4f, 3.5f, -3.5f), 1100f, 11f);
            CreatePointLight(parent, "CorridorFill", new Vector3(3f, 3.2f, -15f), 900f, 10f);
        }

        private static void CreatePointLight(
            Transform parent,
            string name,
            Vector3 position,
            float intensity,
            float range)
        {
            GameObject lightObject = new GameObject(name);
            lightObject.transform.SetParent(parent, false);
            lightObject.transform.localPosition = position;
            Light light = lightObject.AddComponent<Light>();
            light.type = LightType.Point;
            light.intensity = intensity;
            light.range = range;
            light.shadows = LightShadows.None;
            light.color = new Color(0.72f, 0.84f, 0.78f);
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

        private static void FitRendererBounds(
            GameObject instance,
            Vector3 targetSize,
            Vector3 targetCenter,
            Quaternion rotation)
        {
            instance.transform.SetPositionAndRotation(Vector3.zero, rotation);
            instance.transform.localScale = Vector3.one;
            Bounds initialBounds = GetRendererBounds(instance);
            instance.transform.localScale = new Vector3(
                targetSize.x / initialBounds.size.x,
                targetSize.y / initialBounds.size.y,
                targetSize.z / initialBounds.size.z);
            Bounds fittedBounds = GetRendererBounds(instance);
            instance.transform.position += targetCenter - fittedBounds.center;
        }

        private static void FitParentRendererBounds(
            Transform parent,
            Vector3 targetSize,
            Vector3 targetCenter)
        {
            parent.SetPositionAndRotation(Vector3.zero, Quaternion.identity);
            parent.localScale = Vector3.one;
            Bounds initialBounds = GetRendererBounds(parent.gameObject);
            parent.localScale = new Vector3(
                targetSize.x / initialBounds.size.x,
                targetSize.y / initialBounds.size.y,
                targetSize.z / initialBounds.size.z);
            Bounds fittedBounds = GetRendererBounds(parent.gameObject);
            parent.position += targetCenter - fittedBounds.center;
        }

        private static Bounds GetRendererBounds(GameObject root)
        {
            Renderer[] renderers = root.GetComponentsInChildren<Renderer>(true);

            if (renderers.Length == 0)
            {
                throw new System.InvalidOperationException("Model has no renderers: " + root.name);
            }

            Bounds bounds = renderers[0].bounds;

            for (int i = 1; i < renderers.Length; i++)
            {
                bounds.Encapsulate(renderers[i].bounds);
            }

            return bounds;
        }

        private static void AssignGarageShellMaterials(GameObject shell, GarageMaterials materials)
        {
            Renderer[] renderers = shell.GetComponentsInChildren<Renderer>(true);

            for (int i = 0; i < renderers.Length; i++)
            {
                Renderer renderer = renderers[i];

                if (renderer.name == "Garage_Walls")
                {
                    AssignMaterials(
                        renderer,
                        materials.WallConcrete,
                        materials.WallPlaster,
                        materials.WallWeathered,
                        materials.WallRust);
                }
                else if (renderer.name == "Windows_Broken")
                {
                    AssignMaterials(renderer, materials.Window, materials.WallPlaster);
                }
                else if (renderer.name == "Ceiling" || renderer.name.StartsWith("Ceiling_Beam"))
                {
                    AssignMaterials(renderer, materials.Ceiling);
                }
                else if (renderer.name.StartsWith("Wall_Trim") || renderer.name == "Wooden_Door_Panel")
                {
                    AssignMaterials(renderer, materials.Trim);
                }
                else
                {
                    AssignMaterials(renderer, materials.WallConcrete);
                }
            }
        }

        private static void AssignOneMaterial(GameObject root, Material material)
        {
            Renderer[] renderers = root.GetComponentsInChildren<Renderer>(true);

            for (int i = 0; i < renderers.Length; i++)
            {
                AssignMaterials(renderers[i], material);
            }
        }

        private static void AssignMaterials(Renderer renderer, params Material[] palette)
        {
            int materialCount = Mathf.Max(1, renderer.sharedMaterials.Length);
            Material[] assigned = new Material[materialCount];

            for (int i = 0; i < materialCount; i++)
            {
                assigned[i] = palette[Mathf.Min(i, palette.Length - 1)];
            }

            renderer.sharedMaterials = assigned;
        }

        private static void SetStatic(GameObject root)
        {
            Transform[] transforms = root.GetComponentsInChildren<Transform>(true);

            for (int i = 0; i < transforms.Length; i++)
            {
                transforms[i].gameObject.isStatic = true;
            }
        }

        private static void CreatePlanCollisionShell(Transform parent)
        {
            CreateCollisionBox(
                parent,
                "Floor_18x14m",
                new Vector3(0f, -0.1f, 0f),
                new Vector3(k_LabWidth, 0.2f, k_LabDepth));
            CreateCollisionBox(
                parent,
                "Corridor_Floor_3p2x16p8m",
                new Vector3(k_CorridorCenterX, -0.1f, k_SouthWallZ - k_CorridorLength * 0.5f),
                new Vector3(k_CorridorWidth, 0.2f, k_CorridorLength));
            CreateCollisionBox(
                parent,
                "Wall_West",
                new Vector3(-9.25f, 2.5f, 0f),
                new Vector3(k_WallThickness, k_LabHeight, 15f));
            CreateCollisionBox(
                parent,
                "Wall_East",
                new Vector3(9.25f, 2.5f, 0f),
                new Vector3(k_WallThickness, k_LabHeight, 15f));

            float outerMinX = -9.5f;
            float outerMaxX = 9.5f;
            float northOpeningMinX = k_NorthExitCenterX - k_NorthExitWidth * 0.5f;
            float northOpeningMaxX = k_NorthExitCenterX + k_NorthExitWidth * 0.5f;
            CreateHorizontalWallSegment(parent, "Wall_North_West", outerMinX, northOpeningMinX, 7.25f);
            CreateHorizontalWallSegment(parent, "Wall_North_East", northOpeningMaxX, outerMaxX, 7.25f);

            float southOpeningMinX = k_CorridorCenterX - k_CorridorWidth * 0.5f;
            float southOpeningMaxX = k_CorridorCenterX + k_CorridorWidth * 0.5f;
            CreateHorizontalWallSegment(parent, "Wall_South_West", outerMinX, southOpeningMinX, -7.25f);
            CreateHorizontalWallSegment(parent, "Wall_South_East", southOpeningMaxX, outerMaxX, -7.25f);
        }

        private static void CreateHorizontalWallSegment(
            Transform parent,
            string name,
            float minimumX,
            float maximumX,
            float centerZ)
        {
            float width = maximumX - minimumX;
            CreateCollisionBox(
                parent,
                name,
                new Vector3((minimumX + maximumX) * 0.5f, 2.5f, centerZ),
                new Vector3(width, k_LabHeight, k_WallThickness));
        }

        private static void CreateCollisionBox(
            Transform parent,
            string name,
            Vector3 center,
            Vector3 size)
        {
            GameObject collision = new GameObject(name);
            collision.transform.SetParent(parent, false);
            collision.transform.localPosition = center;
            collision.isStatic = true;
            BoxCollider collider = collision.AddComponent<BoxCollider>();
            collider.size = size;
        }

        private static GarageMaterials CreateGarageMaterials()
        {
            EnsureFolder(k_GarageMaterialFolder);
            ConfigureTexture(k_GarageTextureFolder + "/GarageWindow_Normal.png", true, false);
            ConfigureTexture(k_GarageTextureFolder + "/GarageIvy_BaseMap.png", false, true);

            return new GarageMaterials(
                EnsureMaterial("GarageWallConcrete", "GarageWallConcrete_BaseMap.jpg", null, 0f, 0.3f, false),
                EnsureMaterial("GarageWallPlaster", "GarageWallPlaster_BaseMap.jpg", null, 0f, 0.25f, false),
                EnsureMaterial("GarageWallWeathered", "GarageWallWeathered_BaseMap.jpg", null, 0f, 0.22f, false),
                EnsureMaterial("GarageWallRust", "GarageWallRust_BaseMap.jpg", null, 0.2f, 0.18f, false),
                EnsureMaterial("GarageCeiling", "GarageCeiling_BaseMap.jpg", null, 0f, 0.24f, false),
                EnsureMaterial(
                    "GarageWindow",
                    "GarageWindow_BaseMap.jpg",
                    "GarageWindow_Normal.png",
                    0.5f,
                    0.42f,
                    false),
                EnsureMaterial("GarageTrim", "GarageTrim_BaseMap.jpg", null, 0f, 0.28f, false),
                EnsureMaterial("GarageIvy", "GarageIvy_BaseMap.png", null, 0f, 0.2f, true));
        }

        private static void ConfigureTexture(string path, bool isNormalMap, bool hasTransparency)
        {
            TextureImporter importer = AssetImporter.GetAtPath(path) as TextureImporter;

            if (importer == null)
            {
                throw new System.IO.FileNotFoundException("Garage texture was not imported: " + path);
            }

            TextureImporterType textureType = isNormalMap
                ? TextureImporterType.NormalMap
                : TextureImporterType.Default;
            bool needsImport = importer.textureType != textureType
                || importer.maxTextureSize != 2048
                || !importer.mipmapEnabled
                || importer.alphaIsTransparency != hasTransparency;

            if (!needsImport)
            {
                return;
            }

            importer.textureType = textureType;
            importer.maxTextureSize = 2048;
            importer.mipmapEnabled = true;
            importer.alphaIsTransparency = hasTransparency;
            importer.textureCompression = TextureImporterCompression.Compressed;
            importer.SaveAndReimport();
        }

        private static Material EnsureMaterial(
            string name,
            string baseMapName,
            string normalMapName,
            float metallic,
            float smoothness,
            bool isAlphaClipped)
        {
            string materialPath = k_GarageMaterialFolder + "/" + name + ".mat";
            Material material = AssetDatabase.LoadAssetAtPath<Material>(materialPath);

            if (material == null)
            {
                Shader shader = Shader.Find("HDRP/Lit");

                if (shader == null)
                {
                    throw new System.InvalidOperationException("HDRP/Lit shader was not found.");
                }

                material = new Material(shader);
                material.name = name;
                AssetDatabase.CreateAsset(material, materialPath);
            }

            Texture2D baseMap = AssetDatabase.LoadAssetAtPath<Texture2D>(
                k_GarageTextureFolder + "/" + baseMapName);

            if (baseMap == null)
            {
                throw new System.IO.FileNotFoundException("Garage base map was not imported: " + baseMapName);
            }

            material.SetTexture("_BaseColorMap", baseMap);
            material.SetColor("_BaseColor", Color.white);
            material.SetFloat("_Metallic", metallic);
            material.SetFloat("_Smoothness", smoothness);
            material.SetFloat("_DoubleSidedEnable", 1f);
            material.SetFloat("_DoubleSidedNormalMode", 1f);
            material.SetFloat("_AlphaCutoffEnable", isAlphaClipped ? 1f : 0f);
            material.SetFloat("_AlphaCutoff", 0.42f);
            material.enableInstancing = true;

            if (!string.IsNullOrEmpty(normalMapName))
            {
                Texture2D normalMap = AssetDatabase.LoadAssetAtPath<Texture2D>(
                    k_GarageTextureFolder + "/" + normalMapName);
                material.SetTexture("_NormalMap", normalMap);
                material.SetFloat("_NormalScale", 1f);
            }

            HDMaterial.ValidateMaterial(material);
            EditorUtility.SetDirty(material);
            return material;
        }

        private static void BuildGameplayScene(IReadOnlyDictionary<string, CheckpointPlacement> placements)
        {
            Scene scene = EditorSceneManager.NewScene(NewSceneSetup.EmptyScene, NewSceneMode.Single);
            Transform cameras = CreateRoot("_Cameras");
            Transform spawns = CreateRoot("_Spawns");
            CreateRoot("_Triggers");
            CreateRoot("_Interactables");
            Transform anchors = CreateRoot("_Anchors");

            CheckpointPlacement placement = placements[k_LabEntranceAnchor];
            GameObject anchor = new GameObject(k_LabEntranceAnchor);
            anchor.transform.SetParent(anchors, false);
            anchor.transform.SetPositionAndRotation(
                placement.Position,
                Quaternion.Euler(0f, placement.Yaw, 0f));

            GameObject spawnPoint = new GameObject("PlayerSpawn");
            spawnPoint.transform.SetParent(spawns, false);
            spawnPoint.transform.SetPositionAndRotation(
                placement.Position,
                Quaternion.Euler(0f, placement.Yaw, 0f));

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
                k_CheckpointFolder + "/02-01_LaboratoryEntrance.asset",
                "02-01 Laboratory entrance",
                level,
                k_LabEntranceAnchor,
                placements[k_LabEntranceAnchor],
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

        private sealed class GarageMaterials
        {
            public GarageMaterials(
                Material wallConcrete,
                Material wallPlaster,
                Material wallWeathered,
                Material wallRust,
                Material ceiling,
                Material window,
                Material trim,
                Material ivy)
            {
                WallConcrete = wallConcrete;
                WallPlaster = wallPlaster;
                WallWeathered = wallWeathered;
                WallRust = wallRust;
                Ceiling = ceiling;
                Window = window;
                Trim = trim;
                Ivy = ivy;
            }

            public Material WallConcrete { get; }
            public Material WallPlaster { get; }
            public Material WallWeathered { get; }
            public Material WallRust { get; }
            public Material Ceiling { get; }
            public Material Window { get; }
            public Material Trim { get; }
            public Material Ivy { get; }
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
