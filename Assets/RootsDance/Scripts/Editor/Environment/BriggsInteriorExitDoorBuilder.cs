using System.IO;
using System.Linq;
using RootsDance.Environment;
using RootsDance.Rendering;
using UnityEditor;
using UnityEditor.Events;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Adds the textured automatic exit door, fits the Garage ceiling meshes to the laboratory,
    /// and restores the pre-dressing roof vegetation without touching PWB props.
    /// </summary>
    public static class BriggsInteriorExitDoorBuilder
    {
        public const string DoorPrefabPath =
            "Assets/RootsDance/Prefabs/Environment/BriggsAutomaticExitDoor.prefab";

        private const string k_EnvironmentPath =
            "Assets/RootsDance/Scenes/Levels/BriggsInterior/BriggsInterior_Environment.unity";
        private const string k_GameplayPath =
            "Assets/RootsDance/Scenes/Levels/BriggsInterior/BriggsInterior_Gameplay.unity";
        private const string k_WallMaterialPath =
            "Assets/RootsDance/Materials/Environment/Garage/GarageWallWeathered.mat";
        private const string k_IvyMaterialPath =
            "Assets/RootsDance/Materials/Environment/Garage/GarageIvy.mat";
        private const string k_TrimMaterialPath =
            "Assets/RootsDance/Materials/Environment/Garage/GarageTrim.mat";
        private const string k_CeilingMaterialPath =
            "Assets/RootsDance/Materials/Environment/Garage/GarageCeiling.mat";
        private const string k_GarageShellPath =
            "Assets/RootsDance/Meshes/Environment/Garage/GarageShell.fbx";
        private const string k_DoorName = "BriggsAutomaticExitDoor";
        private const string k_VinesName = "CeilingHoleVines";
        private const string k_EntranceDoorName = "BriggsClosedEntranceDoor";
        private const string k_CeilingAssemblyName = "BriggsCeilingAssembly";

        [MenuItem("RootsDance/Environment/Apply Briggs Exit Door")]
        public static void ApplyFromMenu()
        {
            ApplyToLoadedScenes();
        }

        /// <summary>Restores the wall, room-scale ceiling and both door scenes without touching PWB dressing.</summary>
        public static void ApplyFromCommandLine()
        {
            EditorSceneManager.OpenScene(k_EnvironmentPath, OpenSceneMode.Single);
            EditorSceneManager.OpenScene(k_GameplayPath, OpenSceneMode.Additive);
            ApplyToLoadedScenes();

            if (Application.isBatchMode)
            {
                EditorApplication.Exit(0);
            }
        }

        /// <summary>One-shot entry point for fitting the ceiling and restoring hanging vegetation.</summary>
        public static void RestorePreDressingCeilingVegetationFromCommandLine()
        {
            Scene environment = EditorSceneManager.OpenScene(k_EnvironmentPath, OpenSceneMode.Single);
            Transform props = FindRoot(environment, "_Props");
            Material ivyMaterial = LoadRequiredAsset<Material>(k_IvyMaterialPath);
            RestorePreDressingCeilingVegetation(environment, props, ivyMaterial);
            EditorSceneManager.MarkSceneDirty(environment);
            EditorSceneManager.SaveScene(environment);
            AssetDatabase.SaveAssets();
            Debug.Log("[BriggsInteriorExitDoor] Fitted the room-scale ceiling and restored hanging vegetation.");

            if (Application.isBatchMode)
            {
                EditorApplication.Exit(0);
            }
        }

        public static void ApplyToLoadedScenes()
        {
            Scene environment = FindLoadedScene(k_EnvironmentPath);
            Scene gameplay = FindLoadedScene(k_GameplayPath);
            Material wallMaterial = LoadRequiredAsset<Material>(k_WallMaterialPath);
            Material ivyMaterial = LoadRequiredAsset<Material>(k_IvyMaterialPath);
            Material trimMaterial = LoadRequiredAsset<Material>(k_TrimMaterialPath);
            GameObject doorPrefab = EnsureDoorPrefab(wallMaterial);

            AssignRoundExitWallMaterial(environment, wallMaterial);

            Transform props = FindRoot(environment, "_Props");
            RestorePreDressingCeilingVegetation(environment, props, ivyMaterial);
            CreateClosedEntranceDoor(props, trimMaterial);

            Transform interactables = FindRoot(gameplay, "_Interactables");
            PlaceDoor(doorPrefab, interactables, gameplay);

            EditorSceneManager.MarkSceneDirty(environment);
            EditorSceneManager.MarkSceneDirty(gameplay);
            EditorSceneManager.SaveScene(environment);
            EditorSceneManager.SaveScene(gameplay);
            AssetDatabase.SaveAssets();
            Debug.Log("[BriggsInteriorExitDoor] Applied textured round-exit wall and automatic door; "
                + "fitted the room-scale ceiling and restored hanging vegetation.");
        }

        public static GameObject EnsureDoorPrefab(Material wallMaterial)
        {
            EnsureFolder("Assets/RootsDance/Prefabs/Environment");
            Scene previewScene = EditorSceneManager.NewPreviewScene();

            try
            {
                GameObject root = new GameObject(k_DoorName);
                SceneManager.MoveGameObjectToScene(root, previewScene);
                int triggerLayer = LayerMask.NameToLayer("TriggerVolume");

                if (triggerLayer < 0)
                {
                    throw new System.InvalidOperationException("TriggerVolume layer is not configured.");
                }

                root.layer = triggerLayer;

                GameObject left = CreateDoorLeaf("DoorLeaf_Left", root.transform, -1.125f, wallMaterial);
                GameObject right = CreateDoorLeaf("DoorLeaf_Right", root.transform, 1.125f, wallMaterial);

                BoxCollider trigger = root.AddComponent<BoxCollider>();
                trigger.isTrigger = true;
                trigger.center = new Vector3(0f, 2.25f, 0f);
                trigger.size = new Vector3(6.25f, 4.6f, 6f);

                AutomaticSlidingDoor door = root.AddComponent<AutomaticSlidingDoor>();
                door.Configure(left.transform, right.transform, 2.5f, 2.2f);
                BriggsCorridorGateRuneBuilder.AddRunes(root, left.transform, right.transform, door);

                GameObject prefab = PrefabUtility.SaveAsPrefabAsset(root, DoorPrefabPath);

                if (prefab == null)
                {
                    throw new System.InvalidOperationException("Failed to create Briggs automatic exit door prefab.");
                }

                return prefab;
            }
            finally
            {
                EditorSceneManager.ClosePreviewScene(previewScene);
            }
        }

        public static void PlaceDoor(GameObject doorPrefab, Transform parent, Scene scene)
        {
            Transform existing = parent.Find(k_DoorName);

            if (existing != null)
            {
                Object.DestroyImmediate(existing.gameObject);
            }

            GameObject door = (GameObject)PrefabUtility.InstantiatePrefab(doorPrefab, scene);
            door.name = k_DoorName;
            door.transform.SetParent(parent, false);
            door.transform.SetLocalPositionAndRotation(new Vector3(0f, 0f, 7.15f), Quaternion.identity);
            door.transform.localScale = Vector3.one;

            AutomaticSlidingDoor automaticDoor = door.GetComponent<AutomaticSlidingDoor>();
            GateFullscreenShake screenShake = EnsureGateFullscreenShake(scene);
            UnityEventTools.AddPersistentListener(automaticDoor.ActivationStarted, screenShake.Play);
            UnityEventTools.AddPersistentListener(automaticDoor.OpeningFinished, screenShake.Stop);
            EditorUtility.SetDirty(automaticDoor);
        }

        private static GateFullscreenShake EnsureGateFullscreenShake(Scene scene)
        {
            GameObject camera = FindGameObject(scene, "FirstPersonCamera");
            GameObjectUtility.RemoveMonoBehavioursWithMissingScript(camera);
            GateFullscreenShake shake = camera.GetComponent<GateFullscreenShake>();

            if (shake == null)
            {
                shake = camera.AddComponent<GateFullscreenShake>();
            }

            return shake;
        }

        public static void RestorePreDressingCeilingVegetation(
            Scene environment,
            Transform propsRoot,
            Material ivyMaterial)
        {
            RestoreRoomScaleCeiling(environment);

            GameObject ivy = environment.GetRootGameObjects()
                .SelectMany(root => root.GetComponentsInChildren<Transform>(true))
                .Select(item => item.gameObject)
                .FirstOrDefault(item => item.name == "IvyHanging");

            if (ivy == null)
            {
                GameObject ivyPrefab = LoadRequiredAsset<GameObject>(
                    "Assets/RootsDance/Meshes/Environment/Garage/IvyHanging.fbx");
                ivy = (GameObject)PrefabUtility.InstantiatePrefab(ivyPrefab, environment);
            }

            ivy.name = "IvyHanging";
            ivy.transform.SetParent(FindGameObject(environment, "GarageSourceArt").transform, false);
            ivy.transform.SetLocalPositionAndRotation(
                new Vector3(-0.373f, -0.16892f, -0.488f),
                new Quaternion(0f, 1f, 0f, -0.00000004371139f));
            ivy.transform.localScale = new Vector3(3.0177207f, 2.110111f, 3.7525582f);

            foreach (MeshRenderer renderer in ivy.GetComponentsInChildren<MeshRenderer>(true))
            {
                renderer.sharedMaterial = ivyMaterial;
            }

            SetStatic(ivy);
            CreateCeilingHoleVines(ivy, propsRoot, ivyMaterial);
        }

        public static void CreateCeilingHoleVines(
            GameObject ivyRoot,
            Transform propsRoot,
            Material ivyMaterial)
        {
            Transform vines = propsRoot.Find(k_VinesName);

            if (vines != null)
            {
                Object.DestroyImmediate(vines.gameObject);
            }

            vines = new GameObject(k_VinesName).transform;
            vines.SetParent(propsRoot, false);
            CreateVine(ivyRoot, vines, "Ivy_Hanging_09", "MainHoleVine_Left", -0.78f, 2.5f, 12f, ivyMaterial);
            CreateVine(ivyRoot, vines, "Ivy_Hanging_10", "MainHoleVine_Right", 0.98f, 2.5f, -16f, ivyMaterial);
            vines.localPosition = Vector3.zero;
        }

        private static void RestoreRoomScaleCeiling(Scene environment)
        {
            Transform geometry = FindRoot(environment, "_Geometry");
            Transform shell = FindGameObject(environment, "GarageShell").transform;
            Transform existingAssembly = geometry.Find(k_CeilingAssemblyName);

            if (existingAssembly != null)
            {
                Object.DestroyImmediate(existingAssembly.gameObject);
            }

            string[] roofPartNames = { "Ceiling", "Ceiling_Beam", "Ceiling_Beam_Broken" };

            foreach (string roofPartName in roofPartNames)
            {
                Transform legacyPart = shell.Find(roofPartName);

                if (legacyPart != null)
                {
                    Object.DestroyImmediate(legacyPart.gameObject);
                }
            }

            GameObject source = LoadRequiredAsset<GameObject>(k_GarageShellPath);
            Material ceilingMaterial = LoadRequiredAsset<Material>(k_CeilingMaterialPath);
            Transform assembly = new GameObject(k_CeilingAssemblyName).transform;
            assembly.SetParent(geometry, false);

            CreateFittedRoofPart(
                source,
                assembly,
                "Ceiling",
                new Vector3(0f, 5f, 0f),
                new Vector3(18.8f, 0.26f, 14.8f),
                ceilingMaterial);
            CreateFittedRoofPart(
                source,
                assembly,
                "Ceiling_Beam",
                new Vector3(-6.45f, 4.82f, 0f),
                new Vector3(0.34f, 0.30f, 14.6f),
                ceilingMaterial);
            CreateFittedRoofPart(
                source,
                assembly,
                "Ceiling_Beam_Broken",
                new Vector3(1.27f, 4.82f, 0.26f),
                new Vector3(0.42f, 0.34f, 14.6f),
                ceilingMaterial);

            SetStatic(assembly.gameObject);
        }

        private static void CreateFittedRoofPart(
            GameObject source,
            Transform parent,
            string name,
            Vector3 targetCenter,
            Vector3 targetSize,
            Material material)
        {
            MeshFilter sourceFilter = source.GetComponentsInChildren<MeshFilter>(true)
                .FirstOrDefault(filter => filter.name == name);

            if (sourceFilter == null || sourceFilter.sharedMesh == null)
            {
                throw new System.InvalidOperationException(
                    $"The GarageShell roof mesh '{name}' is missing.");
            }

            GameObject part = new GameObject(name);
            part.transform.SetParent(parent, false);
            MeshFilter filter = part.AddComponent<MeshFilter>();
            filter.sharedMesh = sourceFilter.sharedMesh;
            MeshRenderer renderer = part.AddComponent<MeshRenderer>();
            renderer.sharedMaterials = Enumerable.Repeat(
                material,
                Mathf.Max(1, sourceFilter.sharedMesh.subMeshCount)).ToArray();

            Bounds meshBounds = sourceFilter.sharedMesh.bounds;
            Quaternion rotation = Quaternion.Euler(90f, 0f, 0f);
            Vector3 scale = new Vector3(
                targetSize.x / Mathf.Max(0.0001f, meshBounds.size.x),
                targetSize.z / Mathf.Max(0.0001f, meshBounds.size.y),
                targetSize.y / Mathf.Max(0.0001f, meshBounds.size.z));
            part.transform.localRotation = rotation;
            part.transform.localScale = scale;
            part.transform.localPosition = targetCenter
                - rotation * Vector3.Scale(meshBounds.center, scale);
            part.isStatic = true;
        }

        private static void CreateVine(
            GameObject ivyRoot,
            Transform parent,
            string sourceName,
            string name,
            float targetX,
            float targetZ,
            float yawOffset,
            Material material)
        {
            MeshRenderer source = ivyRoot.GetComponentsInChildren<MeshRenderer>(true)
                .FirstOrDefault(renderer => renderer.name == sourceName);

            if (source == null)
            {
                throw new System.InvalidOperationException("Ivy source mesh was not found: " + sourceName);
            }

            GameObject clone = Object.Instantiate(source.gameObject);
            clone.name = name;
            clone.transform.SetParent(parent, true);
            clone.transform.localScale *= 0.9f;
            clone.transform.rotation = Quaternion.Euler(0f, yawOffset, 0f) * source.transform.rotation;

            MeshRenderer renderer = clone.GetComponent<MeshRenderer>();
            renderer.sharedMaterial = material;
            Bounds bounds = renderer.bounds;
            clone.transform.position += new Vector3(
                targetX - bounds.center.x,
                4.96f - bounds.max.y,
                targetZ - bounds.center.z);

            foreach (Collider collider in clone.GetComponentsInChildren<Collider>(true))
            {
                Object.DestroyImmediate(collider);
            }

            clone.isStatic = true;
        }

        public static void CreateClosedEntranceDoor(Transform propsRoot, Material trimMaterial)
        {
            Transform existing = propsRoot.Find(k_EntranceDoorName);

            if (existing != null)
            {
                Object.DestroyImmediate(existing.gameObject);
            }

            GameObject garageShell = LoadRequiredAsset<GameObject>(k_GarageShellPath);
            MeshFilter source = garageShell.GetComponentsInChildren<MeshFilter>(true)
                .FirstOrDefault(filter => filter.name == "Wooden_Door_Panel");

            if (source == null || source.sharedMesh == null)
            {
                throw new System.InvalidOperationException(
                    "Garage Wooden_Door_Panel source mesh was not found.");
            }

            Transform root = new GameObject(k_EntranceDoorName).transform;
            root.SetParent(propsRoot, false);

            GameObject visual = new GameObject("Wooden_Door_Panel");
            visual.transform.SetParent(root, false);
            MeshFilter meshFilter = visual.AddComponent<MeshFilter>();
            meshFilter.sharedMesh = source.sharedMesh;
            MeshRenderer renderer = visual.AddComponent<MeshRenderer>();
            renderer.sharedMaterials = Enumerable.Repeat(
                trimMaterial,
                Mathf.Max(1, source.sharedMesh.subMeshCount)).ToArray();

            Bounds meshBounds = source.sharedMesh.bounds;
            visual.transform.localRotation =
                Quaternion.Euler(0f, 90f, 0f) * Quaternion.Euler(90f, 0f, 0f);
            visual.transform.localScale = new Vector3(
                1f,
                3.3f / Mathf.Max(0.0001f, meshBounds.size.y),
                3.8f / Mathf.Max(0.0001f, meshBounds.size.z));

            Bounds fittedBounds = renderer.bounds;
            visual.transform.position += new Vector3(3f, 1.85f, -6.99f) - fittedBounds.center;

            GameObject seal = GameObject.CreatePrimitive(PrimitiveType.Cube);
            seal.name = "EntranceLightSeal";
            seal.transform.SetParent(root, false);
            seal.transform.localPosition = new Vector3(3f, 1.85f, -7.15f);
            seal.transform.localScale = new Vector3(3.3f, 3.8f, 0.28f);
            MeshRenderer sealRenderer = seal.GetComponent<MeshRenderer>();
            sealRenderer.sharedMaterial = trimMaterial;
            sealRenderer.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.ShadowsOnly;
            sealRenderer.receiveShadows = false;

            SetStatic(root.gameObject);
        }

        private static GameObject CreateDoorLeaf(
            string name,
            Transform parent,
            float localX,
            Material material)
        {
            GameObject leaf = GameObject.CreatePrimitive(PrimitiveType.Cube);
            leaf.name = name;
            leaf.transform.SetParent(parent, false);
            leaf.transform.localPosition = new Vector3(localX, 2.25f, 0f);
            leaf.transform.localRotation = Quaternion.identity;
            leaf.transform.localScale = new Vector3(2.3f, 4.6f, 0.28f);
            leaf.GetComponent<MeshRenderer>().sharedMaterial = material;
            return leaf;
        }

        private static void AssignRoundExitWallMaterial(Scene scene, Material wallMaterial)
        {
            GameObject wall = FindGameObject(scene, "Briggs_Wall_North_RoundExit");
            MeshRenderer renderer = wall.GetComponent<MeshRenderer>();

            if (renderer == null)
            {
                throw new System.InvalidOperationException("Round-exit wall has no MeshRenderer.");
            }

            int materialCount = Mathf.Max(1, renderer.sharedMaterials.Length);
            Material[] materials = new Material[materialCount];

            for (int i = 0; i < materialCount; i++)
            {
                materials[i] = wallMaterial;
            }

            renderer.sharedMaterials = materials;
        }

        private static Scene FindLoadedScene(string path)
        {
            for (int i = 0; i < SceneManager.sceneCount; i++)
            {
                Scene scene = SceneManager.GetSceneAt(i);

                if (scene.path == path)
                {
                    return scene;
                }
            }

            throw new System.InvalidOperationException("Required scene is not loaded: " + path);
        }

        private static Transform FindRoot(Scene scene, string name)
        {
            GameObject root = scene.GetRootGameObjects().FirstOrDefault(item => item.name == name);

            if (root == null)
            {
                throw new System.InvalidOperationException("Scene root was not found: " + name);
            }

            return root.transform;
        }

        private static GameObject FindGameObject(Scene scene, string name)
        {
            GameObject found = scene.GetRootGameObjects()
                .SelectMany(root => root.GetComponentsInChildren<Transform>(true))
                .Select(item => item.gameObject)
                .FirstOrDefault(item => item.name == name);

            if (found == null)
            {
                throw new System.InvalidOperationException("Scene object was not found: " + name);
            }

            return found;
        }

        private static T LoadRequiredAsset<T>(string path) where T : Object
        {
            T asset = AssetDatabase.LoadAssetAtPath<T>(path);

            if (asset == null)
            {
                throw new FileNotFoundException("Required asset was not found: " + path);
            }

            return asset;
        }

        private static void SetStatic(GameObject root)
        {
            Transform[] transforms = root.GetComponentsInChildren<Transform>(true);

            for (int i = 0; i < transforms.Length; i++)
            {
                transforms[i].gameObject.isStatic = true;
            }
        }

        private static void EnsureFolder(string path)
        {
            string parent = Path.GetDirectoryName(path)?.Replace('\\', '/');

            if (!string.IsNullOrEmpty(parent) && !AssetDatabase.IsValidFolder(parent))
            {
                EnsureFolder(parent);
            }

            if (AssetDatabase.IsValidFolder(path))
            {
                return;
            }

            string folderParent = Path.GetDirectoryName(path)?.Replace('\\', '/');
            string folderName = Path.GetFileName(path);
            AssetDatabase.CreateFolder(folderParent, folderName);
        }
    }
}
