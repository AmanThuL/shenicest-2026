using System.Collections.Generic;
using RootsDance.Events;
using RootsDance.UI;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UIElements;

namespace RootsDance.Editor.Tools
{
    /// <summary>
    /// Builds the throwaway UI sandbox described in contracts/UI与前端契约.md: a scene holding a
    /// test HUD prefab whose presenters are wired to the real channel assets, so UI work needs no
    /// level, no player and no gameplay progress — only Play, then select a channel .asset under
    /// Data/Events/ and press its Inspector's Raise button (see Scripts/Editor/Events/).
    /// Everything it writes is prefixed Test_ and lives under Assets/_Sandbox/UISandboxDemo/, never
    /// in Assets/RootsDance/UI/ or Prefabs/UI/, which belong to the UI owner. This shared demo
    /// folder is separate from a teammate's own Assets/_Sandbox/&lt;user&gt;/ experiments.
    /// Menu: RootsDance > Build UI Sandbox (Test).
    /// </summary>
    public static class SandboxUiTestBuilder
    {
        private const string k_EventsFolder = "Assets/RootsDance/Data/Events";
        private const string k_SandboxFolder = "Assets/_Sandbox/UISandboxDemo";
        private const string k_UxmlName = "Test_HUD.uxml";

        // Channels the UI contract promises but that had never been created as assets.
        private static readonly string[] k_StringChannels =
        {
            "InteractionPrompt", "RadioLine", "Monologue", "Notice", "InvestigationResult"
        };

        [MenuItem("RootsDance/Build UI Sandbox (Test)")]
        public static void Build()
        {
            if (!EditorSceneManager.SaveCurrentModifiedScenesIfUserWantsTo())
            {
                Debug.LogWarning("Build cancelled: current scenes have unsaved changes.");
                return;
            }

            string folder = k_SandboxFolder;
            EnsureFolder(folder);

            string uxmlPath = folder + "/" + k_UxmlName;
            VisualTreeAsset uxml = AssetDatabase.LoadAssetAtPath<VisualTreeAsset>(uxmlPath);

            if (uxml == null)
            {
                Debug.LogError($"No {k_UxmlName} at {uxmlPath}. Copy the test UXML/USS pair into the "
                    + "sandbox folder first — this builder only wires assets, it does not author UI.");
                return;
            }

            for (int i = 0; i < k_StringChannels.Length; i++)
            {
                EnsureChannel<StringEventChannelSO>(k_EventsFolder + "/" + k_StringChannels[i] + ".asset");
            }

            PanelSettings panel = EnsurePanelSettings(folder + "/Test_PanelSettings.asset");
            GameObject prefab = BuildHudPrefab(folder + "/Test_HUD.prefab", uxml, panel);
            BuildSandboxScene(folder + "/Test_UISandbox.unity", prefab);

            AssetDatabase.SaveAssets();
            Debug.Log($"UI sandbox built in {folder}. Open Test_UISandbox.unity, press Play, then "
                + "select a channel .asset under Data/Events/ and press Raise in its Inspector.");
        }

        private static PanelSettings EnsurePanelSettings(string path)
        {
            PanelSettings existing = AssetDatabase.LoadAssetAtPath<PanelSettings>(path);

            if (existing != null)
            {
                return existing;
            }

            PanelSettings panel = ScriptableObject.CreateInstance<PanelSettings>();

            // A PanelSettings without a theme renders unstyled text and logs a warning; reuse
            // whichever runtime theme the project already has rather than authoring a new one.
            string[] themes = AssetDatabase.FindAssets("t:ThemeStyleSheet");
            Debug.Log($"Found {themes.Length} ThemeStyleSheet asset(s) to choose a runtime theme from.");

            if (themes.Length > 0)
            {
                string themePath = AssetDatabase.GUIDToAssetPath(themes[0]);
                panel.themeStyleSheet = AssetDatabase.LoadAssetAtPath<ThemeStyleSheet>(themePath);
                Debug.Log($"Using theme {themePath}.");
            }

            AssetDatabase.CreateAsset(panel, path);
            AssetDatabase.SaveAssets();

            return AssetDatabase.LoadAssetAtPath<PanelSettings>(path);
        }

        private static GameObject BuildHudPrefab(string path, VisualTreeAsset uxml, PanelSettings panel)
        {
            GameObject root = new GameObject("Test_HUD");

            UIDocument document = root.AddComponent<UIDocument>();
            SetSerialized(document, "m_PanelSettings", panel);
            SetSerialized(document, "sourceAsset", uxml);

            InteractionPromptPresenter prompt = root.AddComponent<InteractionPromptPresenter>();
            SetSerialized(prompt, "m_promptChanged", LoadChannel("InteractionPrompt"));

            ReportToastPresenter toast = root.AddComponent<ReportToastPresenter>();
            SetSerialized(toast, "m_reportUpdated",
                AssetDatabase.LoadAssetAtPath<ReportUpdateEventChannelSO>(k_EventsFolder + "/ReportUpdated.asset"));

            SubtitlePresenter subtitle = root.AddComponent<SubtitlePresenter>();
            SetSubtitleChannels(subtitle, new[] { "RadioLine", "Monologue", "Notice", "InvestigationResult" });

            GameObject prefab = PrefabUtility.SaveAsPrefabAsset(root, path);
            Object.DestroyImmediate(root);

            return prefab;
        }

        private static void SetSubtitleChannels(SubtitlePresenter subtitle, IReadOnlyList<string> names)
        {
            SerializedObject serialized = new SerializedObject(subtitle);
            SerializedProperty channels = serialized.FindProperty("m_channels");
            channels.arraySize = names.Count;

            for (int i = 0; i < names.Count; i++)
            {
                channels.GetArrayElementAtIndex(i).objectReferenceValue = LoadChannel(names[i]);
            }

            serialized.ApplyModifiedProperties();
        }

        private static void BuildSandboxScene(string path, GameObject prefab)
        {
            Scene scene = EditorSceneManager.NewScene(NewSceneSetup.EmptyScene, NewSceneMode.Single);
            PrefabUtility.InstantiatePrefab(prefab, scene);
            EditorSceneManager.SaveScene(scene, path);
        }

        private static StringEventChannelSO LoadChannel(string name)
        {
            return AssetDatabase.LoadAssetAtPath<StringEventChannelSO>(k_EventsFolder + "/" + name + ".asset");
        }

        private static void EnsureChannel<T>(string path) where T : ScriptableObject
        {
            if (AssetDatabase.LoadAssetAtPath<T>(path) != null)
            {
                return;
            }

            T channel = ScriptableObject.CreateInstance<T>();
            AssetDatabase.CreateAsset(channel, path);
            AssetDatabase.SaveAssets();
            Debug.Log($"Created event channel asset {path}.");
        }

        private static void SetSerialized(Object target, string propertyName, Object value)
        {
            SerializedObject serialized = new SerializedObject(target);
            SerializedProperty property = serialized.FindProperty(propertyName);

            if (property == null)
            {
                Debug.LogError($"No serialized property '{propertyName}' on {target.GetType().Name}.");
                return;
            }

            property.objectReferenceValue = value;
            serialized.ApplyModifiedProperties();
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
