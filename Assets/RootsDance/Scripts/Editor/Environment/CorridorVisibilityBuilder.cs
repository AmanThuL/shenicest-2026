using System;
using UnityEditor;
using UnityEditor.Rendering;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Adds a high-priority, corridor-only visibility override without touching Main_Environment.
    /// The box fades back to the level atmosphere at its edges, while an overwrite local fog
    /// replaces the intentionally opaque passage fog only while the player is inside the tunnel.
    /// </summary>
    public static class CorridorVisibilityBuilder
    {
        private const string k_MenuPath = "RootsDance/Environment/Apply Corridor Visibility";
        private const string k_ScenePath =
            "Assets/RootsDance/Scenes/Levels/Main/Main_Environment_2.unity";
        private const string k_ProfileFolder = "Assets/RootsDance/Settings/VolumeProfiles";
        private const string k_ProfilePath =
            "Assets/RootsDance/Settings/VolumeProfiles/Chapter00PassageReadable.asset";
        private const string k_RootName = "_LabCorridorVisibility";
        private const string k_VolumeName = "C00M_LabPassageReadableVolume";
        private const string k_FogName = "C00M_LabPassageReadableFog";
        private const float k_VolumePriority = 100f;
        private const float k_PostExposure = -0.5f;
        private const float k_FogMeanFreePath = 25f;
        private const float k_LocalFogMeanFreePath = 20f;

        private static readonly Vector3 k_VolumePosition = new Vector3(30.890f, 9f, 103.977f);
        private static readonly Quaternion k_CorridorRotation = Quaternion.Euler(0f, 14.106f, 0f);
        private static readonly Vector3 k_ColliderCenter = new Vector3(-0.869f, 0f, 0.891f);
        private static readonly Vector3 k_ColliderSize = new Vector3(2.618f, 4.6f, 10.218f);
        private static readonly Vector3 k_LocalFogPosition = new Vector3(30.387f, 8.140f, 105.135f);
        private static readonly Vector3 k_LocalFogSize = new Vector3(1.95f, 1.89f, 11.22f);

        [MenuItem(k_MenuPath)]
        public static void ApplyFromMenu()
        {
            if (!EditorSceneManager.SaveCurrentModifiedScenesIfUserWantsTo())
            {
                return;
            }

            EditorSceneManager.OpenScene(k_ScenePath, OpenSceneMode.Single);
            ApplyToLoadedScene();
        }

        /// <summary>
        /// Rebuilds the visibility root in an already loaded Main_Environment_2 scene. Aggregate
        /// builders can call this after their own scene edits without reopening or discarding it.
        /// </summary>
        public static void ApplyToLoadedScene()
        {
            Scene scene = SceneManager.GetSceneByPath(k_ScenePath);

            if (!scene.IsValid() || !scene.isLoaded)
            {
                throw new InvalidOperationException(
                    "Main_Environment_2 must be loaded before applying corridor visibility.");
            }

            VolumeProfile profile = EnsureProfile();
            Transform root = ReplaceRoot(scene);
            CreateReadableVolume(root, profile);
            CreateReadableLocalFog(root);

            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);
            AssetDatabase.SaveAssets();
            Debug.Log(
                "[CorridorVisibility] Installed the corridor-only exposure and fog override in "
                + "Main_Environment_2.");
        }

        /// <summary>Standalone batch entry point.</summary>
        public static void ApplyFromCommandLine()
        {
            EditorSceneManager.OpenScene(k_ScenePath, OpenSceneMode.Single);
            ApplyToLoadedScene();

            if (Application.isBatchMode)
            {
                EditorApplication.Exit(0);
            }
        }

        private static VolumeProfile EnsureProfile()
        {
            EnsureAssetFolder(k_ProfileFolder);
            VolumeProfile profile = AssetDatabase.LoadAssetAtPath<VolumeProfile>(k_ProfilePath);

            if (profile == null)
            {
                profile = VolumeProfileFactory.CreateVolumeProfileAtPath(k_ProfilePath);
            }

            if (profile == null)
            {
                throw new InvalidOperationException("Could not create corridor profile: " + k_ProfilePath);
            }

            ColorAdjustments grading = GetOrAdd<ColorAdjustments>(profile);
            grading.active = true;
            Set(grading.postExposure, k_PostExposure);

            Fog fog = GetOrAdd<Fog>(profile);
            fog.active = true;
            Set(fog.enabled, true);
            Set(fog.enableVolumetricFog, true);
            Set(fog.meanFreePath, k_FogMeanFreePath);

            EditorUtility.SetDirty(grading);
            EditorUtility.SetDirty(fog);
            EditorUtility.SetDirty(profile);
            return profile;
        }

        private static Transform ReplaceRoot(Scene scene)
        {
            foreach (GameObject sceneRoot in scene.GetRootGameObjects())
            {
                if (sceneRoot.name == k_RootName)
                {
                    UnityEngine.Object.DestroyImmediate(sceneRoot);
                    break;
                }
            }

            GameObject root = new GameObject(k_RootName);
            SceneManager.MoveGameObjectToScene(root, scene);
            root.transform.SetPositionAndRotation(Vector3.zero, Quaternion.identity);
            root.transform.localScale = Vector3.one;
            return root.transform;
        }

        private static void CreateReadableVolume(Transform parent, VolumeProfile profile)
        {
            GameObject holder = new GameObject(k_VolumeName);
            holder.transform.SetParent(parent, false);
            holder.transform.SetPositionAndRotation(k_VolumePosition, k_CorridorRotation);
            holder.transform.localScale = Vector3.one;

            Volume volume = holder.AddComponent<Volume>();
            volume.isGlobal = false;
            volume.priority = k_VolumePriority;
            volume.blendDistance = 1f;
            volume.weight = 1f;
            volume.sharedProfile = profile;

            BoxCollider collider = holder.AddComponent<BoxCollider>();
            collider.center = k_ColliderCenter;
            collider.size = k_ColliderSize;
            collider.isTrigger = true;
        }

        private static void CreateReadableLocalFog(Transform parent)
        {
            GameObject holder = new GameObject(k_FogName);
            holder.transform.SetParent(parent, false);
            holder.transform.SetPositionAndRotation(k_LocalFogPosition, k_CorridorRotation);
            holder.transform.localScale = Vector3.one;

            LocalVolumetricFog localFog = holder.AddComponent<LocalVolumetricFog>();
            LocalVolumetricFogArtistParameters parameters =
                new LocalVolumetricFogArtistParameters(
                    new Color(0.05f, 0.08f, 0.06f),
                    k_LocalFogMeanFreePath,
                    0.35f);
            parameters.blendingMode = LocalVolumetricFogBlendingMode.Overwrite;
            parameters.priority = (int)k_VolumePriority;
            parameters.size = k_LocalFogSize;
            parameters.scaleMode = LocalVolumetricFogScaleMode.ScaleInvariant;
            parameters.positiveFade = new Vector3(0.18f, 0.14f, 0.08f);
            parameters.negativeFade = parameters.positiveFade;
            parameters.distanceFadeStart = 60f;
            parameters.distanceFadeEnd = 80f;
            parameters.falloffMode = LocalVolumetricFogFalloffMode.Exponential;
            localFog.parameters = parameters;
        }

        private static T GetOrAdd<T>(VolumeProfile profile) where T : VolumeComponent
        {
            T component;

            if (!profile.TryGet(out component))
            {
                component = VolumeProfileFactory.CreateVolumeComponent<T>(
                    profile,
                    overrides: false,
                    saveAsset: false);
            }

            return component;
        }

        private static void Set<T>(VolumeParameter<T> parameter, T value)
        {
            parameter.overrideState = true;
            parameter.value = value;
        }

        private static void EnsureAssetFolder(string path)
        {
            if (AssetDatabase.IsValidFolder(path))
            {
                return;
            }

            string parent = System.IO.Path.GetDirectoryName(path);
            string name = System.IO.Path.GetFileName(path);

            if (string.IsNullOrEmpty(parent) || string.IsNullOrEmpty(name))
            {
                throw new InvalidOperationException("Invalid asset folder: " + path);
            }

            parent = parent.Replace('\\', '/');
            EnsureAssetFolder(parent);
            AssetDatabase.CreateFolder(parent, name);
        }
    }
}
