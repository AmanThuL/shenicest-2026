using System;
using System.IO;
using System.Linq;
using UnityEditor;
using UnityEditor.Rendering;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    public static class Chapter00LabPassageBuilder
    {
        public const string DoorPrefabPath =
            "Assets/RootsDance/Prefabs/Environment/Chapter00MidLate/LabSquarePassageDoor.prefab";
        public const string VolumeProfilePath =
            "Assets/RootsDance/Settings/VolumeProfiles/Chapter00PassageDark.asset";

        private const string k_MenuPath = "RootsDance/Environment/Apply Chapter 00 Lab Passage";
        private const string k_EnvironmentScenePath =
            "Assets/RootsDance/Scenes/Levels/Main/Main_Environment.unity";
        private const string k_GarageShellPath =
            "Assets/RootsDance/Meshes/Environment/Garage/GarageShell.fbx";
        private const string k_TrimMaterialPath =
            "Assets/RootsDance/Materials/Environment/Garage/GarageTrim.mat";
        private const string k_DoorName = "C00M_LabPassageSquareDoor";
        private const string k_VolumeRootName = "Chapter00LabPassage";
        private const string k_VolumeName = "C00M_LabPassageDarkVolume";
        private const string k_FogName = "C00M_LabPassageOcclusionFog";
        private const float k_PostExposure = -3.5f;

        private static readonly Vector3 k_DoorPosition = new Vector3(31.2f, 8.9f, 109.05f);
        private static readonly Quaternion k_DoorRotation = Quaternion.Euler(0f, 335.52f, 0f);
        private static readonly Vector3 k_VolumePosition = new Vector3(30.95f, 9f, 104.1f);
        private static readonly Quaternion k_VolumeRotation = Quaternion.Euler(0f, 2.9f, 0f);
        private static readonly Vector3 k_VolumeSize = new Vector3(4.2f, 4.6f, 12f);

        [MenuItem(k_MenuPath)]
        public static void ApplyToLoadedScene()
        {
            Scene environment = SceneManager.GetSceneByPath(k_EnvironmentScenePath);

            if (!environment.IsValid() || !environment.isLoaded)
            {
                throw new InvalidOperationException("Main_Environment must be loaded before applying the passage.");
            }

            GameObject doorPrefab = EnsureDoorPrefab();
            VolumeProfile profile = EnsureVolumeProfile();
            PlaceDoor(environment, doorPrefab);
            PlaceVolume(environment, profile);
            EditorSceneManager.MarkSceneDirty(environment);
            EditorSceneManager.SaveScene(environment);
            AssetDatabase.SaveAssets();
            Debug.Log("[Chapter00LabPassage] Installed the square lab door and dark local volume.");
        }

        public static GameObject EnsureDoorPrefab()
        {
            EnsureFolder(Path.GetDirectoryName(DoorPrefabPath));
            GameObject garageShell = LoadRequired<GameObject>(k_GarageShellPath);
            Material trimMaterial = LoadRequired<Material>(k_TrimMaterialPath);
            MeshFilter source = garageShell.GetComponentsInChildren<MeshFilter>(true)
                .FirstOrDefault(filter => filter.name == "Wooden_Door_Panel");

            if (source == null || source.sharedMesh == null)
            {
                throw new InvalidOperationException("Garage Wooden_Door_Panel source mesh was not found.");
            }

            Scene preview = EditorSceneManager.NewPreviewScene();

            try
            {
                GameObject root = new GameObject("LabSquarePassageDoor");
                SceneManager.MoveGameObjectToScene(root, preview);
                GameObject visual = new GameObject("Wooden_Door_Panel");
                visual.transform.SetParent(root.transform, false);
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
                visual.transform.position -= renderer.bounds.center;

                GameObject seal = GameObject.CreatePrimitive(PrimitiveType.Cube);
                seal.name = "DoorCollisionAndLightSeal";
                SceneManager.MoveGameObjectToScene(seal, preview);
                seal.transform.SetParent(root.transform, false);
                seal.transform.localPosition = new Vector3(0f, 0f, 0.12f);
                seal.transform.localScale = new Vector3(3.3f, 3.8f, 0.28f);
                MeshRenderer sealRenderer = seal.GetComponent<MeshRenderer>();
                sealRenderer.sharedMaterial = trimMaterial;
                sealRenderer.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.ShadowsOnly;
                sealRenderer.receiveShadows = false;

                SetStatic(root);
                GameObject prefab = PrefabUtility.SaveAsPrefabAsset(root, DoorPrefabPath);

                if (prefab == null)
                {
                    throw new InvalidOperationException("Failed to create the square passage door prefab.");
                }

                return prefab;
            }
            finally
            {
                EditorSceneManager.ClosePreviewScene(preview);
            }
        }

        public static VolumeProfile EnsureVolumeProfile()
        {
            EnsureFolder(Path.GetDirectoryName(VolumeProfilePath));
            VolumeProfile profile = AssetDatabase.LoadAssetAtPath<VolumeProfile>(VolumeProfilePath);

            if (profile == null)
            {
                profile = VolumeProfileFactory.CreateVolumeProfileAtPath(VolumeProfilePath);
            }

            ColorAdjustments grading;

            if (!profile.TryGet(out grading))
            {
                grading = VolumeProfileFactory.CreateVolumeComponent<ColorAdjustments>(
                    profile,
                    overrides: false,
                    saveAsset: false);
            }

            grading.active = true;
            grading.postExposure.overrideState = true;
            grading.postExposure.value = k_PostExposure;
            EditorUtility.SetDirty(grading);
            EditorUtility.SetDirty(profile);
            return profile;
        }

        private static void PlaceDoor(Scene scene, GameObject prefab)
        {
            Transform props = FindOrCreateRoot(scene, "_Props");
            Transform existing = props.Find(k_DoorName);

            if (existing != null)
            {
                UnityEngine.Object.DestroyImmediate(existing.gameObject);
            }

            GameObject door = (GameObject)PrefabUtility.InstantiatePrefab(prefab, scene);
            door.name = k_DoorName;
            door.transform.SetParent(props, true);
            door.transform.SetPositionAndRotation(k_DoorPosition, k_DoorRotation);
            door.transform.localScale = Vector3.one;
        }

        private static void PlaceVolume(Scene scene, VolumeProfile profile)
        {
            Transform lighting = FindOrCreateRoot(scene, "_Lighting");
            Transform root = lighting.Find(k_VolumeRootName);

            if (root == null)
            {
                root = new GameObject(k_VolumeRootName).transform;
                SceneManager.MoveGameObjectToScene(root.gameObject, scene);
                root.SetParent(lighting, false);
            }

            Transform holder = root.Find(k_VolumeName);
            bool createdHolder = holder == null;

            if (createdHolder)
            {
                holder = new GameObject(k_VolumeName).transform;
                holder.SetParent(root, false);
                holder.SetPositionAndRotation(k_VolumePosition, k_VolumeRotation);
                holder.localScale = Vector3.one;
            }

            Volume volume = holder.GetComponent<Volume>();

            if (volume == null)
            {
                volume = holder.gameObject.AddComponent<Volume>();
            }

            volume.isGlobal = false;
            volume.priority = 30f;
            volume.blendDistance = 1f;
            volume.weight = 1f;
            volume.sharedProfile = profile;
            BoxCollider collider = holder.GetComponent<BoxCollider>();

            if (collider == null)
            {
                collider = holder.gameObject.AddComponent<BoxCollider>();
                collider.center = Vector3.zero;
                collider.size = k_VolumeSize;
            }

            collider.isTrigger = true;
            EnsureOcclusionFog(holder, collider);
        }

        private static void EnsureOcclusionFog(Transform parent, BoxCollider volumeBounds)
        {
            Transform holder = parent.Find(k_FogName);

            if (holder == null)
            {
                holder = new GameObject(k_FogName).transform;
                holder.SetParent(parent, false);
            }

            holder.localPosition = volumeBounds.center;
            holder.localRotation = Quaternion.identity;
            holder.localScale = Vector3.one;
            LocalVolumetricFog fog = holder.GetComponent<LocalVolumetricFog>();

            if (fog == null)
            {
                fog = holder.gameObject.AddComponent<LocalVolumetricFog>();
            }

            LocalVolumetricFogArtistParameters parameters =
                new LocalVolumetricFogArtistParameters(new Color(0.05f, 0.08f, 0.06f), 0.8f, 0.55f);
            parameters.blendingMode = LocalVolumetricFogBlendingMode.Additive;
            parameters.priority = 20;
            parameters.size = volumeBounds.size;
            parameters.scaleMode = LocalVolumetricFogScaleMode.ScaleInvariant;
            parameters.positiveFade = new Vector3(0.08f, 0.08f, 0.08f);
            parameters.negativeFade = new Vector3(0.08f, 0.08f, 0.08f);
            parameters.distanceFadeStart = 60f;
            parameters.distanceFadeEnd = 80f;
            parameters.falloffMode = LocalVolumetricFogFalloffMode.Exponential;
            fog.parameters = parameters;
        }

        private static Transform FindOrCreateRoot(Scene scene, string name)
        {
            foreach (GameObject root in scene.GetRootGameObjects())
            {
                if (root.name == name)
                {
                    return root.transform;
                }
            }

            GameObject created = new GameObject(name);
            SceneManager.MoveGameObjectToScene(created, scene);
            return created.transform;
        }

        private static void SetStatic(GameObject root)
        {
            foreach (Transform child in root.GetComponentsInChildren<Transform>(true))
            {
                child.gameObject.isStatic = true;
            }
        }

        private static T LoadRequired<T>(string path) where T : UnityEngine.Object
        {
            T asset = AssetDatabase.LoadAssetAtPath<T>(path);

            if (asset == null)
            {
                throw new InvalidOperationException("Missing required asset: " + path);
            }

            return asset;
        }

        private static void EnsureFolder(string path)
        {
            if (string.IsNullOrEmpty(path) || AssetDatabase.IsValidFolder(path))
            {
                return;
            }

            EnsureFolder(Path.GetDirectoryName(path));
            AssetDatabase.CreateFolder(Path.GetDirectoryName(path), Path.GetFileName(path));
        }
    }
}
