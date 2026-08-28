using Unity.Cinemachine;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.SceneManagement;
using RootsDance.App;
using RootsDance.Events;

namespace RootsDance.Editor.Tools
{
    /// <summary>
    /// Fills in Bootstrap.unity: the persistent GameBootstrap root (services + wired event channel
    /// assets), the UI slot, and the Main Camera rig — and strips the content the bootstrap scene is
    /// forbidden to hold (docs/guidelines/11-scenes-prefabs-workflow.md, TL;DR rule 15).
    /// Idempotent: every step is an "ensure", so re-running never duplicates anything.
    /// Menu: RootsDance > Build Bootstrap Scene.
    /// </summary>
    public static class BootstrapSceneBuilder
    {
        private const string k_EventsFolder = "Assets/RootsDance/Data/Events";
        private const string k_LoadLevelRequestedPath = k_EventsFolder + "/LoadLevelRequested.asset";
        private const string k_FlagRaisedPath = k_EventsFolder + "/FlagRaised.asset";
        private const string k_ReportUpdatedPath = k_EventsFolder + "/ReportUpdated.asset";
        private const string k_TimeOfDayChangedPath = k_EventsFolder + "/TimeOfDayChanged.asset";

        /// <summary>
        /// Batch entry point (-executeMethod). In batch mode
        /// <see cref="EditorSceneManager.SaveCurrentModifiedScenesIfUserWantsTo"/> cannot show its dialog
        /// and returns true, so the interactive <see cref="Build"/> is safe to call as-is.
        /// </summary>
        public static void BuildFromCommandLine()
        {
            Build();
        }

        [MenuItem("RootsDance/Build Bootstrap Scene")]
        public static void Build()
        {
            if (!EditorSceneManager.SaveCurrentModifiedScenesIfUserWantsTo())
            {
                Debug.LogWarning("Build cancelled: current scenes have unsaved changes.");
                return;
            }

            Scene scene = EditorSceneManager.OpenScene(ScenePaths.k_Bootstrap, OpenSceneMode.Single);

            RemoveForbiddenContent(scene);
            EnsureCameraRig(scene);
            GameBootstrap bootstrap = EnsureBootstrapRoot(scene);
            EnsureUiRoot(scene);

            EnsureChannel<LevelEventChannelSO>(k_LoadLevelRequestedPath);
            EnsureChannel<StringEventChannelSO>(k_FlagRaisedPath);
            EnsureChannel<ReportUpdateEventChannelSO>(k_ReportUpdatedPath);
            EnsureChannel<TimeOfDayEventChannelSO>(k_TimeOfDayChangedPath);

            // Re-load every channel from its path immediately before wiring. Creating an asset can
            // invalidate the instance CreateAsset handed back (an import in between reloads it), and
            // assigning an invalidated object silently serializes as "None" instead of failing.
            WireBootstrap(
                bootstrap,
                LoadChannel<LevelEventChannelSO>(k_LoadLevelRequestedPath),
                LoadChannel<StringEventChannelSO>(k_FlagRaisedPath),
                LoadChannel<ReportUpdateEventChannelSO>(k_ReportUpdatedPath),
                LoadChannel<TimeOfDayEventChannelSO>(k_TimeOfDayChangedPath));

            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);
            AssetDatabase.SaveAssets();

            Debug.Log("Bootstrap scene built: GameBootstrap + SceneLoader wired to 4 channel assets, "
                + "UI slot created, forbidden content removed.");
        }

        /// <summary>
        /// The bootstrap scene holds no content: no geometry, no lights, no APV, no Volume. Under
        /// HDRP the level's own _Environment part owns both the sun and the Global Volume that carries
        /// sky, fog and exposure; with several scenes open Unity takes lighting from the *active*
        /// scene, so a Directional Light left over here from the project template competes with it.
        /// </summary>
        private static void RemoveForbiddenContent(Scene scene)
        {
            GameObject[] roots = scene.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                GameObject root = roots[i];

                if (root.GetComponentInChildren<Light>(true) == null
                    && root.GetComponentInChildren<Renderer>(true) == null)
                {
                    continue;
                }

                // The camera rig is not content; never remove it even if something got parented under it.
                if (root.GetComponentInChildren<Camera>(true) != null)
                {
                    Debug.LogWarning($"Bootstrap root '{root.name}' holds a Camera and also a Light or "
                        + "Renderer; left in place — move the content out by hand.", root);
                    continue;
                }

                Debug.Log($"Removed '{root.name}' from Bootstrap (content is forbidden there).");
                Object.DestroyImmediate(root);
            }
        }

        private static void EnsureCameraRig(Scene scene)
        {
            Camera camera = FindRootComponent<Camera>(scene);

            if (camera == null)
            {
                Debug.LogWarning("Bootstrap has no Camera; add the Main Camera by hand.");
                return;
            }

            if (!camera.CompareTag("MainCamera"))
            {
                camera.tag = "MainCamera";
            }

            if (camera.GetComponent<CinemachineBrain>() == null)
            {
                camera.gameObject.AddComponent<CinemachineBrain>();
            }

            // Exactly one AudioListener in the project, and it belongs to the persistent camera.
            if (camera.GetComponent<AudioListener>() == null)
            {
                camera.gameObject.AddComponent<AudioListener>();
            }

            // HDRP's per-camera data: the project's only Camera carries it explicitly instead of
            // relying on HDRP to attach a default one the first time the camera renders.
            HDAdditionalCameraData cameraData = camera.GetComponent<HDAdditionalCameraData>();

            if (cameraData == null)
            {
                cameraData = camera.gameObject.AddComponent<HDAdditionalCameraData>();
            }

            cameraData.antialiasing = HDAdditionalCameraData.AntialiasingMode.SubpixelMorphologicalAntiAliasing;
            cameraData.SMAAQuality = HDAdditionalCameraData.SMAAQualityLevel.High;
            cameraData.dithering = true;
            cameraData.clearColorMode = HDAdditionalCameraData.ClearColorMode.Sky;
        }

        private static GameBootstrap EnsureBootstrapRoot(Scene scene)
        {
            GameBootstrap bootstrap = FindRootComponent<GameBootstrap>(scene);

            if (bootstrap == null)
            {
                // Must be a scene root: PersistentSingleton calls DontDestroyOnLoad, which Unity
                // only honours for root GameObjects.
                GameObject root = new GameObject("GameBootstrap");
                SceneManager.MoveGameObjectToScene(root, scene);
                bootstrap = root.AddComponent<GameBootstrap>();
            }

            if (bootstrap.GetComponent<SceneLoader>() == null)
            {
                bootstrap.gameObject.AddComponent<SceneLoader>();
            }

            return bootstrap;
        }

        /// <summary>
        /// An empty, correctly named slot for the UI owner's UIDocument screens (menu, HUD, pause).
        /// Deliberately left empty: a UIDocument without a PanelSettings asset and a UXML source
        /// throws at runtime, and authoring those is the UI owner's call, not the integration owner's.
        /// </summary>
        private static void EnsureUiRoot(Scene scene)
        {
            GameObject[] roots = scene.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                if (roots[i].name == "UI")
                {
                    return;
                }
            }

            GameObject uiRoot = new GameObject("UI");
            SceneManager.MoveGameObjectToScene(uiRoot, scene);
        }

        private static void WireBootstrap(GameBootstrap bootstrap, LevelEventChannelSO loadLevelRequested,
            StringEventChannelSO flagRaised, ReportUpdateEventChannelSO reportUpdated,
            TimeOfDayEventChannelSO timeOfDayChanged)
        {
            SerializedObject serialized = new SerializedObject(bootstrap);

            serialized.FindProperty("m_sceneLoader").objectReferenceValue =
                bootstrap.GetComponent<SceneLoader>();
            serialized.FindProperty("m_loadLevelRequested").objectReferenceValue = loadLevelRequested;
            serialized.FindProperty("m_flagRaised").objectReferenceValue = flagRaised;
            serialized.FindProperty("m_reportUpdated").objectReferenceValue = reportUpdated;
            serialized.FindProperty("m_timeOfDayChanged").objectReferenceValue = timeOfDayChanged;

            // m_startupLevel stays empty on purpose: there is no MainMenu scene yet, so Play always
            // starts from a level scene and GameBootstrap.Start adopts whatever is already open.

            serialized.ApplyModifiedProperties();
        }

        private static void EnsureChannel<T>(string path) where T : ScriptableObject
        {
            if (AssetDatabase.LoadAssetAtPath<T>(path) != null)
            {
                return;
            }

            EnsureFolder(k_EventsFolder);

            T channel = ScriptableObject.CreateInstance<T>();
            AssetDatabase.CreateAsset(channel, path);
            AssetDatabase.SaveAssets();
            Debug.Log($"Created event channel asset {path}.");
        }

        private static T LoadChannel<T>(string path) where T : ScriptableObject
        {
            T channel = AssetDatabase.LoadAssetAtPath<T>(path);

            if (channel == null)
            {
                Debug.LogError($"Could not load the event channel asset at {path}; "
                    + "GameBootstrap will be left unwired.");
            }

            return channel;
        }

        private static T FindRootComponent<T>(Scene scene) where T : Component
        {
            GameObject[] roots = scene.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                T found = roots[i].GetComponentInChildren<T>(true);

                if (found != null)
                {
                    return found;
                }
            }

            return null;
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
