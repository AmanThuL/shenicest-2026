using System;
using RootsDance.App;
using RootsDance.Data;
using RootsDance.UI;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;
using Object = UnityEngine.Object;

namespace RootsDance.Editor.Tools
{
    /// <summary>
    /// Puts a <see cref="RecordingModeHider"/> on every screen element the rescue panel's
    /// recording section can switch off, and creates the shared <see cref="RecordingModeSO"/>
    /// they all read. Idempotent: an element that already has its hider is re-wired, not doubled.
    /// <para>
    /// Runs as part of <c>RootsDance &gt; Dev Play &gt; Install Build Checkpoint Rescue</c>. Run
    /// it on its own after rebuilding a HUD canvas or the dialogue screen, since those builders
    /// recreate their roots from scratch and drop the hider with them.
    /// </para>
    /// </summary>
    public static class RecordingModeInstaller
    {
        public const string k_AssetPath = "Assets/RootsDance/Data/Config/RecordingMode.asset";
        public const string k_DialogueScreenPrefabPath = "Assets/RootsDance/Prefabs/UI/DialogueScreen.prefab";
        public const string k_PlayerTestGameplayPath =
            "Assets/RootsDance/Scenes/Levels/PlayerTest/PlayerTest_Gameplay.unity";

        public const string k_InteractionHudCanvasName = "InteractionHudCanvas";
        public const string k_SubtitleCanvasName = "SubtitleCanvas";
        public const string k_HelmetHudCanvasName = "HelmetHudCanvas";

        [MenuItem("RootsDance/Dev Play/Install Recording Mode Hiders")]
        public static void Install()
        {
            if (EditorApplication.isPlayingOrWillChangePlaymode)
            {
                throw new InvalidOperationException("Exit Play mode before installing recording-mode hiders.");
            }

            for (int i = 0; i < SceneManager.sceneCount; i++)
            {
                if (SceneManager.GetSceneAt(i).isDirty)
                {
                    throw new InvalidOperationException("Save or discard dirty scenes before installing hiders.");
                }
            }

            SceneSetup[] setup = EditorSceneManager.GetSceneManagerSetup();
            try
            {
                EnsureAsset();
                InstallHiders();
            }
            finally
            {
                EditorSceneManager.RestoreSceneManagerSetup(setup);
            }
        }

        /// <summary>The shared switch asset, created on first use.</summary>
        public static RecordingModeSO EnsureAsset()
        {
            RecordingModeSO asset = AssetDatabase.LoadAssetAtPath<RecordingModeSO>(k_AssetPath);
            if (asset != null)
            {
                return asset;
            }

            asset = ScriptableObject.CreateInstance<RecordingModeSO>();
            AssetDatabase.CreateAsset(asset, k_AssetPath);
            AssetDatabase.SaveAssets();
            return AssetDatabase.LoadAssetAtPath<RecordingModeSO>(k_AssetPath);
        }

        /// <summary>
        /// Opens each owning scene or prefab in turn and saves it. Does not restore the scene
        /// setup; the caller does, once, around the whole install.
        /// </summary>
        public static void InstallHiders()
        {
            EnsureAsset();

            // Opening a scene Single unloads unreferenced assets, so the switch asset is reloaded
            // after every open; a reference resolved before it serializes as a fake null.
            Scene bootstrap = EditorSceneManager.OpenScene(ScenePaths.k_Bootstrap, OpenSceneMode.Single);
            RecordingModeSO mode = EnsureAsset();
            EnsureHider(RequireRoot(bootstrap, k_InteractionHudCanvasName), RecordingHiddenUi.InteractionHints, mode);
            EnsureHider(RequireRoot(bootstrap, k_SubtitleCanvasName), RecordingHiddenUi.Subtitles, mode);
            EditorSceneManager.MarkSceneDirty(bootstrap);
            EditorSceneManager.SaveScene(bootstrap);

            GameObject dialogue = PrefabUtility.LoadPrefabContents(k_DialogueScreenPrefabPath);
            try
            {
                EnsureHider(dialogue, RecordingHiddenUi.Dialogue, EnsureAsset());
                PrefabUtility.SaveAsPrefabAsset(dialogue, k_DialogueScreenPrefabPath);
            }
            finally
            {
                PrefabUtility.UnloadPrefabContents(dialogue);
            }

            InstallHelmetHud(ScenePaths.k_MainGameplay);
            InstallHelmetHud(k_PlayerTestGameplayPath);
        }

        /// <summary>
        /// Adds or re-wires the hider on <paramref name="root"/>. The CanvasGroup is created here,
        /// at edit time, so it is visible in the Inspector rather than appearing on first Play.
        /// </summary>
        public static RecordingModeHider EnsureHider(GameObject root, RecordingHiddenUi group, RecordingModeSO mode)
        {
            CanvasGroup canvasGroup = root.GetComponent<CanvasGroup>();
            if (canvasGroup == null)
            {
                canvasGroup = root.AddComponent<CanvasGroup>();
            }

            RecordingModeHider hider = root.GetComponent<RecordingModeHider>();
            if (hider == null)
            {
                hider = root.AddComponent<RecordingModeHider>();
            }

            if (mode == null)
            {
                throw new InvalidOperationException("RecordingMode asset is not loaded; resolve it after opening the scene.");
            }

            var serialized = new SerializedObject(hider);
            serialized.FindProperty("m_mode").objectReferenceValue = mode;
            serialized.FindProperty("m_group").intValue = (int)group;
            serialized.FindProperty("m_canvasGroup").objectReferenceValue = canvasGroup;
            serialized.ApplyModifiedPropertiesWithoutUndo();
            return hider;
        }

        private static void InstallHelmetHud(string scenePath)
        {
            if (AssetDatabase.LoadAssetAtPath<SceneAsset>(scenePath) == null)
            {
                Debug.LogWarning($"RecordingModeInstaller: {scenePath} is missing; no helmet HUD hider installed there.");
                return;
            }

            Scene scene = EditorSceneManager.OpenScene(scenePath, OpenSceneMode.Single);
            GameObject canvas = FindRoot(scene, k_HelmetHudCanvasName);
            if (canvas == null)
            {
                Debug.LogWarning($"RecordingModeInstaller: {scenePath} has no {k_HelmetHudCanvasName}; "
                    + "build the helmet HUD first, then rerun this installer.");
                return;
            }

            EnsureHider(canvas, RecordingHiddenUi.HelmetHud, EnsureAsset());
            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);
        }

        private static GameObject RequireRoot(Scene scene, string name)
        {
            GameObject root = FindRoot(scene, name);
            if (root == null)
            {
                throw new InvalidOperationException(scene.path + " has no root object named " + name + ".");
            }

            return root;
        }

        private static GameObject FindRoot(Scene scene, string name)
        {
            foreach (GameObject root in scene.GetRootGameObjects())
            {
                if (root.name == name)
                {
                    return root;
                }
            }

            return null;
        }
    }
}
