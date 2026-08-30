using System;
using System.Collections.Generic;
using RootsDance.App;
using RootsDance.Data;
using RootsDance.UI;
using Unity.Cinemachine;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.UI
{
    /// <summary>
    /// Extracts the visible slice of Main_Environment around the approved menu camera pose.
    /// Rebuild instead of hand-editing the generated background scene.
    /// </summary>
    public static class MainMenuBackgroundBuilder
    {
        private const string k_SourceScenePath =
            "Assets/RootsDance/Scenes/Levels/Main/Main_Environment.unity";
        private const string k_MainMenuLevelPath = "Assets/RootsDance/Data/Levels/MainMenu.asset";
        private const string k_MainMenuPrefabPath = "Assets/RootsDance/Prefabs/UI/MainMenu.prefab";
        private const string k_TveManagerPrefabPath = "Assets/RootsDance/Prefabs/Systems/TVEManager.prefab";
        private const float k_FieldOfView = 40f;
        private const float k_NearClip = 0.1f;
        private const float k_FarClip = 250f;
        private const float k_MaxVisualDistance = 150f;
        private const float k_MinViewportCoverage = 0.00015f;
        private const int k_MaxVisualRoots = 180;

        private static readonly Vector3 k_CameraPosition =
            new Vector3(28.3285f, 8.549451f, 94.99633f);
        private static readonly Vector3 k_CameraEuler = new Vector3(-9.287f, -29.826f, 0f);

        [MenuItem("RootsDance/UI/Rebuild Dynamic Main Menu Background")]
        public static void Build()
        {
            if (EditorApplication.isPlayingOrWillChangePlaymode)
            {
                Debug.LogError("MainMenuBackgroundBuilder: leave Play mode before rebuilding.");
                return;
            }

            if (HasDirtyOpenScene())
            {
                Debug.LogError("MainMenuBackgroundBuilder: save or discard other open scene changes first.");
                return;
            }

            SceneSetup[] previousSetup = EditorSceneManager.GetSceneManagerSetup();

            try
            {
                BuildBackgroundScene();
                WireMainMenuLevel();
                RegisterScenesInBuildSettings();
                MakeMenuOverlayTransparent();
                AssetDatabase.SaveAssets();
                Debug.Log("MainMenuBackgroundBuilder: dynamic Main Menu background rebuilt successfully.");
            }
            catch (Exception exception)
            {
                Debug.LogException(exception);
                throw;
            }
            finally
            {
                if (previousSetup.Length > 0)
                {
                    EditorSceneManager.RestoreSceneManagerSetup(previousSetup);
                }
            }
        }

        [MenuItem("RootsDance/UI/Open Dynamic Main Menu Preview")]
        public static void OpenPreview()
        {
            if (EditorApplication.isPlayingOrWillChangePlaymode || HasDirtyOpenScene())
            {
                Debug.LogError("MainMenuBackgroundBuilder: leave Play mode and save open scenes first.");
                return;
            }

            RegisterScenesInBuildSettings();
            EditorSceneManager.OpenScene(ScenePaths.k_Bootstrap, OpenSceneMode.Single);
            Scene background = EditorSceneManager.OpenScene(
                ScenePaths.k_MainMenuBackground, OpenSceneMode.Additive);
            EditorSceneManager.OpenScene(ScenePaths.k_MainMenu, OpenSceneMode.Additive);
            EditorSceneManager.SetActiveScene(background);
        }

        [MenuItem("RootsDance/UI/Register Dynamic Main Menu Scenes")]
        public static void RegisterScenesForPlaytest()
        {
            RegisterScenesInBuildSettings();
        }

        private static bool HasDirtyOpenScene()
        {
            for (int i = 0; i < SceneManager.sceneCount; i++)
            {
                if (SceneManager.GetSceneAt(i).isDirty)
                {
                    return true;
                }
            }

            return false;
        }

        private static void BuildBackgroundScene()
        {
            Scene sourceScene = EditorSceneManager.OpenScene(k_SourceScenePath, OpenSceneMode.Single);
            Scene sourceScene2 = EditorSceneManager.OpenScene(
                ScenePaths.k_MainEnvironment2, OpenSceneMode.Additive);
            GameObject probeObject = new GameObject("MainMenuFrustumProbe", typeof(Camera));
            probeObject.hideFlags = HideFlags.HideAndDontSave;
            probeObject.transform.SetPositionAndRotation(k_CameraPosition, Quaternion.Euler(k_CameraEuler));
            Camera probe = probeObject.GetComponent<Camera>();
            probe.fieldOfView = k_FieldOfView;
            probe.nearClipPlane = k_NearClip;
            probe.farClipPlane = k_FarClip;
            probe.aspect = 16f / 9f;

            Plane[] planes = GeometryUtility.CalculateFrustumPlanes(probe);
            List<GameObject> visualSources = CollectVisualSources(sourceScene, sourceScene2, planes, probe);
            AddRequiredRoot(visualSources, sourceScene, "ResearchFacility_GaiaV7");
            AddRequiredRoot(visualSources, sourceScene, "ResearchWayfinding");
            AddRequiredRoot(visualSources, sourceScene2, "LabCorridorPosters");
            RemoveNestedSources(visualSources);
            List<Volume> volumeSources = CollectInfluencingVolumes(sourceScene);
            Light sunSource = FindSun(sourceScene);

            UnityEngine.Object.DestroyImmediate(probeObject);

            Scene backgroundScene = EditorSceneManager.NewScene(NewSceneSetup.EmptyScene, NewSceneMode.Additive);
            backgroundScene.name = "MainMenu_Background";
            GameObject visualsRoot = CreateRoot("_Visuals", backgroundScene);
            GameObject lightingRoot = CreateRoot("_Lighting", backgroundScene);
            GameObject systemsRoot = CreateRoot("_Systems", backgroundScene);
            GameObject camerasRoot = CreateRoot("_Cameras", backgroundScene);

            int rendererCount = 0;

            for (int i = 0; i < visualSources.Count; i++)
            {
                GameObject clone = UnityEngine.Object.Instantiate(visualSources[i]);
                clone.name = visualSources[i].name;
                SceneManager.MoveGameObjectToScene(clone, backgroundScene);
                clone.transform.SetParent(visualsRoot.transform, true);
                StripToVisuals(clone);
                rendererCount += clone.GetComponentsInChildren<Renderer>(true).Length;
            }

            for (int i = 0; i < volumeSources.Count; i++)
            {
                GameObject clone = UnityEngine.Object.Instantiate(volumeSources[i].gameObject);
                clone.name = volumeSources[i].gameObject.name;
                SceneManager.MoveGameObjectToScene(clone, backgroundScene);
                clone.transform.SetParent(lightingRoot.transform, true);
                StripVolumeClone(clone);
            }

            if (sunSource != null)
            {
                GameObject sun = UnityEngine.Object.Instantiate(sunSource.gameObject);
                sun.name = sunSource.gameObject.name;
                SceneManager.MoveGameObjectToScene(sun, backgroundScene);
                sun.transform.SetParent(lightingRoot.transform, true);
                StripLightClone(sun);
                RenderSettings.sun = sun.GetComponent<Light>();
            }

            AddTveManager(backgroundScene, systemsRoot.transform);
            AddMenuCamera(backgroundScene, camerasRoot.transform);

            EditorSceneManager.SetActiveScene(backgroundScene);
            EditorSceneManager.SaveScene(backgroundScene, ScenePaths.k_MainMenuBackground);
            Debug.Log($"MainMenuBackgroundBuilder: extracted {visualSources.Count} visual roots "
                + $"({rendererCount} renderers) and {volumeSources.Count} volumes.");
        }

        private static List<GameObject> CollectVisualSources(
            Scene sourceScene, Scene sourceScene2, Plane[] planes, Camera probe)
        {
            Renderer[] renderers = UnityEngine.Object.FindObjectsByType<Renderer>(
                FindObjectsInactive.Exclude, FindObjectsSortMode.None);
            Dictionary<GameObject, float> candidates = new Dictionary<GameObject, float>();

            for (int i = 0; i < renderers.Length; i++)
            {
                Renderer renderer = renderers[i];

                Scene rendererScene = renderer.gameObject.scene;

                if ((rendererScene != sourceScene && rendererScene != sourceScene2) || !renderer.enabled
                    || Vector3.Distance(k_CameraPosition, renderer.bounds.center) > k_MaxVisualDistance
                    || !GeometryUtility.TestPlanesAABB(planes, renderer.bounds))
                {
                    continue;
                }

                float coverage = CalculateViewportCoverage(probe, renderer.bounds);

                if (coverage < k_MinViewportCoverage)
                {
                    continue;
                }

                GameObject visualRoot = ResolveVisualRoot(renderer);
                float existingCoverage;

                if (!candidates.TryGetValue(visualRoot, out existingCoverage) || coverage > existingCoverage)
                {
                    candidates[visualRoot] = coverage;
                }
            }

            List<KeyValuePair<GameObject, float>> ranked =
                new List<KeyValuePair<GameObject, float>>(candidates);
            ranked.Sort((left, right) => right.Value.CompareTo(left.Value));
            int count = Mathf.Min(k_MaxVisualRoots, ranked.Count);
            List<GameObject> result = new List<GameObject>(count);

            for (int i = 0; i < count; i++)
            {
                result.Add(ranked[i].Key);
            }

            RemoveNestedSources(result);
            result.Sort((left, right) => string.CompareOrdinal(left.name, right.name));
            return result;
        }

        private static void AddRequiredRoot(List<GameObject> sources, Scene scene, string rootName)
        {
            GameObject[] roots = scene.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                Transform[] transforms = roots[i].GetComponentsInChildren<Transform>(true);

                for (int transformIndex = 0; transformIndex < transforms.Length; transformIndex++)
                {
                    GameObject candidate = transforms[transformIndex].gameObject;

                    if (candidate.name != rootName)
                    {
                        continue;
                    }

                    if (!sources.Contains(candidate))
                    {
                        sources.Add(candidate);
                    }

                    return;
                }
            }

            Debug.LogWarning("MainMenuBackgroundBuilder: required visual root was not found: " + rootName);
        }

        private static float CalculateViewportCoverage(Camera camera, Bounds bounds)
        {
            Vector3 min = bounds.min;
            Vector3 max = bounds.max;
            float minX = 1f;
            float minY = 1f;
            float maxX = 0f;
            float maxY = 0f;
            bool hasVisibleCorner = false;

            for (int i = 0; i < 8; i++)
            {
                Vector3 corner = new Vector3(
                    (i & 1) == 0 ? min.x : max.x,
                    (i & 2) == 0 ? min.y : max.y,
                    (i & 4) == 0 ? min.z : max.z);
                Vector3 viewport = camera.WorldToViewportPoint(corner);

                if (viewport.z <= 0f)
                {
                    continue;
                }

                hasVisibleCorner = true;
                minX = Mathf.Min(minX, Mathf.Clamp01(viewport.x));
                minY = Mathf.Min(minY, Mathf.Clamp01(viewport.y));
                maxX = Mathf.Max(maxX, Mathf.Clamp01(viewport.x));
                maxY = Mathf.Max(maxY, Mathf.Clamp01(viewport.y));
            }

            return hasVisibleCorner ? Mathf.Max(0f, maxX - minX) * Mathf.Max(0f, maxY - minY) : 0f;
        }

        private static GameObject ResolveVisualRoot(Renderer renderer)
        {
            LODGroup lodGroup = renderer.GetComponentInParent<LODGroup>();

            if (lodGroup != null && lodGroup.gameObject.scene == renderer.gameObject.scene)
            {
                return lodGroup.gameObject;
            }

            ParticleSystem particleSystem = renderer.GetComponentInParent<ParticleSystem>();
            return particleSystem != null ? particleSystem.gameObject : renderer.gameObject;
        }

        private static void RemoveNestedSources(List<GameObject> sources)
        {
            HashSet<Transform> sourceTransforms = new HashSet<Transform>();

            for (int i = 0; i < sources.Count; i++)
            {
                sourceTransforms.Add(sources[i].transform);
            }

            for (int i = sources.Count - 1; i >= 0; i--)
            {
                Transform parent = sources[i].transform.parent;

                while (parent != null)
                {
                    if (sourceTransforms.Contains(parent))
                    {
                        sources.RemoveAt(i);
                        break;
                    }

                    parent = parent.parent;
                }
            }
        }

        private static List<Volume> CollectInfluencingVolumes(Scene sourceScene)
        {
            Volume[] volumes = UnityEngine.Object.FindObjectsByType<Volume>(
                FindObjectsInactive.Exclude, FindObjectsSortMode.None);
            List<Volume> result = new List<Volume>();

            for (int i = 0; i < volumes.Length; i++)
            {
                Volume volume = volumes[i];

                if (volume.gameObject.scene != sourceScene || !volume.enabled)
                {
                    continue;
                }

                if (volume.isGlobal || IsInsideVolume(volume, k_CameraPosition))
                {
                    result.Add(volume);
                }
            }

            return result;
        }

        private static bool IsInsideVolume(Volume volume, Vector3 position)
        {
            Collider[] colliders = volume.GetComponents<Collider>();

            for (int i = 0; i < colliders.Length; i++)
            {
                if (colliders[i].bounds.SqrDistance(position) <= volume.blendDistance * volume.blendDistance)
                {
                    return true;
                }
            }

            return false;
        }

        private static Light FindSun(Scene sourceScene)
        {
            Light[] lights = UnityEngine.Object.FindObjectsByType<Light>(
                FindObjectsInactive.Exclude, FindObjectsSortMode.None);

            for (int i = 0; i < lights.Length; i++)
            {
                if (lights[i].gameObject.scene == sourceScene && lights[i].type == LightType.Directional)
                {
                    return lights[i];
                }
            }

            return null;
        }

        private static void StripToVisuals(GameObject root)
        {
            Component[] components = root.GetComponentsInChildren<Component>(true);

            for (int i = components.Length - 1; i >= 0; i--)
            {
                Component component = components[i];

                if (component == null || component is Transform || component is Renderer
                    || component is MeshFilter || component is LODGroup || component is ParticleSystem)
                {
                    continue;
                }

                UnityEngine.Object.DestroyImmediate(component);
            }
        }

        private static void StripVolumeClone(GameObject root)
        {
            Component[] components = root.GetComponentsInChildren<Component>(true);

            for (int i = components.Length - 1; i >= 0; i--)
            {
                Component component = components[i];

                if (component == null || component is Transform || component is Volume
                    || component is Collider)
                {
                    continue;
                }

                UnityEngine.Object.DestroyImmediate(component);
            }
        }

        private static void StripLightClone(GameObject root)
        {
            Component[] components = root.GetComponentsInChildren<Component>(true);

            for (int i = components.Length - 1; i >= 0; i--)
            {
                Component component = components[i];

                if (component == null || component is Transform || component is Light
                    || component is HDAdditionalLightData)
                {
                    continue;
                }

                UnityEngine.Object.DestroyImmediate(component);
            }
        }

        private static void AddTveManager(Scene scene, Transform parent)
        {
            GameObject prefab = AssetDatabase.LoadAssetAtPath<GameObject>(k_TveManagerPrefabPath);

            if (prefab == null)
            {
                Debug.LogWarning("MainMenuBackgroundBuilder: TVE manager prefab was not found.");
                return;
            }

            GameObject instance = (GameObject)PrefabUtility.InstantiatePrefab(prefab, scene);
            instance.transform.SetParent(parent, false);
        }

        private static void AddMenuCamera(Scene scene, Transform parent)
        {
            GameObject cameraObject = new GameObject("MainMenuCamera");
            SceneManager.MoveGameObjectToScene(cameraObject, scene);
            cameraObject.transform.SetParent(parent, false);
            cameraObject.transform.SetPositionAndRotation(k_CameraPosition, Quaternion.Euler(k_CameraEuler));

            CinemachineCamera camera = cameraObject.AddComponent<CinemachineCamera>();
            camera.Priority = 100;
            camera.Lens.FieldOfView = k_FieldOfView;
            camera.Lens.NearClipPlane = k_NearClip;
            camera.Lens.FarClipPlane = k_FarClip;
            cameraObject.AddComponent<MainMenuCameraDrift>();
        }

        private static GameObject CreateRoot(string name, Scene scene)
        {
            GameObject root = new GameObject(name);
            SceneManager.MoveGameObjectToScene(root, scene);
            return root;
        }

        private static void WireMainMenuLevel()
        {
            LevelSO level = AssetDatabase.LoadAssetAtPath<LevelSO>(k_MainMenuLevelPath);

            if (level == null)
            {
                throw new InvalidOperationException("Main Menu level asset was not found.");
            }

            SerializedObject serialized = new SerializedObject(level);
            SerializedProperty paths = serialized.FindProperty("m_scenePaths");
            paths.arraySize = 2;
            paths.GetArrayElementAtIndex(0).stringValue = ScenePaths.k_MainMenuBackground;
            paths.GetArrayElementAtIndex(1).stringValue = ScenePaths.k_MainMenu;
            serialized.ApplyModifiedProperties();
            EditorUtility.SetDirty(level);
        }

        private static void RegisterScenesInBuildSettings()
        {
            List<EditorBuildSettingsScene> scenes =
                new List<EditorBuildSettingsScene>(EditorBuildSettings.scenes);
            EnableScene(scenes, ScenePaths.k_MainMenuBackground);
            EnableScene(scenes, ScenePaths.k_MainMenu);
            EditorBuildSettings.scenes = scenes.ToArray();
            AssetDatabase.SaveAssets();
            Debug.Log("MainMenuBackgroundBuilder: registered Main Menu scenes in the shared scene list.");
        }

        private static void EnableScene(List<EditorBuildSettingsScene> scenes, string path)
        {
            for (int i = 0; i < scenes.Count; i++)
            {
                if (scenes[i].path != path)
                {
                    continue;
                }

                scenes[i] = new EditorBuildSettingsScene(path, true);
                return;
            }

            scenes.Add(new EditorBuildSettingsScene(path, true));
        }

        private static void MakeMenuOverlayTransparent()
        {
            GameObject contents = PrefabUtility.LoadPrefabContents(k_MainMenuPrefabPath);

            try
            {
                UnityEngine.UI.Image overlay = contents.GetComponent<UnityEngine.UI.Image>();

                if (overlay == null)
                {
                    throw new MissingComponentException("Main Menu root has no background Image.");
                }

                Color color = overlay.color;
                color.a = 0.24f;
                overlay.color = color;
                PrefabUtility.SaveAsPrefabAsset(contents, k_MainMenuPrefabPath);
            }
            finally
            {
                PrefabUtility.UnloadPrefabContents(contents);
            }
        }
    }
}
