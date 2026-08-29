using RootsDance.App;
using Unity.Cinemachine;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>Applies the measured first-pass culling budget to the Chapter-00 exterior.</summary>
    public static class Chapter00PerformanceTuning
    {
        private const string k_MainGameplayScenePath =
            "Assets/RootsDance/Scenes/Levels/Main/Main_Gameplay.unity";
        private const string k_MainEnvironmentScenePath =
            "Assets/RootsDance/Scenes/Levels/Main/Main_Environment.unity";

        private const float k_CameraFarClip = 250f;
        private const float k_TerrainDetailDistance = 60f;
        private const float k_TerrainTreeDistance = 180f;

        /// <summary>Batch-mode entry point used after prefab settings have been applied in small ranges.</summary>
        public static void ApplySceneSettingsFromCommandLine()
        {
            if (!EditorSceneManager.SaveCurrentModifiedScenesIfUserWantsTo())
            {
                Debug.LogWarning("Chapter00PerformanceTuning: cancelled because an open scene is dirty.");
                return;
            }

            TuneBootstrapCamera();
            TuneGameplayCamera();
            TuneTerrain();
            AssetDatabase.SaveAssets();
        }

        [MenuItem("RootsDance/Environment/Apply Chapter 00 Performance Tuning")]
        public static void Apply()
        {
            if (!EditorSceneManager.SaveCurrentModifiedScenesIfUserWantsTo())
            {
                Debug.LogWarning("Chapter00PerformanceTuning: cancelled because an open scene is dirty.");
                return;
            }

            EnvironmentPrefabBuilder.ApplyPerformanceSettingsToBuiltPrefabs();
            ApplySceneSettingsFromCommandLine();

            Debug.Log("Chapter00PerformanceTuning: camera 250 m, terrain details 60 m, terrain trees 180 m, "
                + "and outdoor prefab renderer budgets applied.");
        }

        private static void TuneBootstrapCamera()
        {
            Scene scene = EditorSceneManager.OpenScene(ScenePaths.k_Bootstrap, OpenSceneMode.Single);
            Camera camera = Object.FindFirstObjectByType<Camera>(FindObjectsInactive.Include);

            if (camera == null)
            {
                throw new MissingComponentException("Bootstrap has no Camera.");
            }

            camera.farClipPlane = k_CameraFarClip;
            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);
        }

        private static void TuneGameplayCamera()
        {
            Scene scene = EditorSceneManager.OpenScene(k_MainGameplayScenePath, OpenSceneMode.Single);
            CinemachineCamera[] cameras = Object.FindObjectsByType<CinemachineCamera>(
                FindObjectsInactive.Include, FindObjectsSortMode.None);

            if (cameras.Length == 0)
            {
                throw new MissingComponentException("Main_Gameplay has no CinemachineCamera.");
            }

            for (int i = 0; i < cameras.Length; i++)
            {
                LensSettings lens = cameras[i].Lens;
                lens.FarClipPlane = k_CameraFarClip;
                cameras[i].Lens = lens;
            }

            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);
        }

        private static void TuneTerrain()
        {
            Scene scene = EditorSceneManager.OpenScene(k_MainEnvironmentScenePath, OpenSceneMode.Single);
            UnityEngine.Terrain[] terrains = Object.FindObjectsByType<UnityEngine.Terrain>(FindObjectsInactive.Include,
                FindObjectsSortMode.None);

            if (terrains.Length == 0)
            {
                throw new MissingComponentException("Main_Environment has no Terrain.");
            }

            for (int i = 0; i < terrains.Length; i++)
            {
                terrains[i].detailObjectDistance = k_TerrainDetailDistance;
                terrains[i].treeDistance = k_TerrainTreeDistance;
            }

            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);
        }
    }
}
