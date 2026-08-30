using System.Collections.Generic;
using RootsDance.Events;
using RootsDance.UI;
using TMPro;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem.UI;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

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

        private const float k_ReferenceWidth = 1920f;
        private const float k_ReferenceHeight = 1080f;

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
            RemoveStaleUiToolkitAssets(folder);

            for (int i = 0; i < k_StringChannels.Length; i++)
            {
                EnsureChannel<StringEventChannelSO>(k_EventsFolder + "/" + k_StringChannels[i] + ".asset");
            }

            GameObject prefab = BuildHudPrefab(folder + "/Test_HUD.prefab");
            BuildSandboxScene(folder + "/Test_UISandbox.unity", prefab);

            AssetDatabase.SaveAssets();
            Debug.Log($"UI sandbox built in {folder}. Open Test_UISandbox.unity, press Play, then "
                + "select a channel .asset under Data/Events/ and press Raise in its Inspector.");
        }

        // The sandbox used to be UI Toolkit (UXML/USS/PanelSettings); those file types no longer
        // apply now that runtime UI is uGUI (AGENTS.md #18). Clean up leftovers from before the
        // switch so the folder does not carry dead assets alongside the rebuilt prefab.
        private static void RemoveStaleUiToolkitAssets(string folder)
        {
            string[] stalePaths =
            {
                folder + "/Test_HUD.uxml", folder + "/Test_HUD.uss", folder + "/Test_PanelSettings.asset"
            };

            for (int i = 0; i < stalePaths.Length; i++)
            {
                if (AssetDatabase.LoadAssetAtPath<Object>(stalePaths[i]) != null)
                {
                    AssetDatabase.DeleteAsset(stalePaths[i]);
                }
            }
        }

        private static GameObject BuildHudPrefab(string path)
        {
            GameObject root = new GameObject("Test_HUD", typeof(RectTransform));
            RectTransform rootRect = (RectTransform)root.transform;
            StretchFull(rootRect);

            Canvas canvas = root.AddComponent<Canvas>();
            canvas.renderMode = RenderMode.ScreenSpaceOverlay;

            CanvasScaler scaler = root.AddComponent<CanvasScaler>();
            scaler.uiScaleMode = CanvasScaler.ScaleMode.ScaleWithScreenSize;
            scaler.referenceResolution = new Vector2(k_ReferenceWidth, k_ReferenceHeight);
            scaler.matchWidthOrHeight = 0.5f;

            root.AddComponent<GraphicRaycaster>();

            TextMeshProUGUI banner = CreateLabel(rootRect, "Banner", "TEST HUD — sandbox only, not the real UI");
            AnchorTopLeft(banner.rectTransform, new Vector2(16f, -16f), new Vector2(600f, 30f));
            banner.color = new Color(1f, 0.86f, 0.47f);
            banner.fontStyle = FontStyles.Bold;
            banner.fontSize = 18f;

            GameObject toastRoot = CreateToast(rootRect, out TextMeshProUGUI toastTitle, out TextMeshProUGUI toastLine);

            TextMeshProUGUI prompt = CreateLabel(rootRect, "Prompt", string.Empty);
            AnchorCenter(prompt.rectTransform, Vector2.zero, new Vector2(400f, 40f));
            prompt.alignment = TextAlignmentOptions.Center;

            TextMeshProUGUI subtitle = CreateLabel(rootRect, "Subtitle", string.Empty);
            AnchorBottomCenter(subtitle.rectTransform, new Vector2(0f, 16f), new Vector2(1000f, 60f));
            subtitle.alignment = TextAlignmentOptions.Center;
            subtitle.textWrappingMode = TextWrappingModes.Normal;

            InteractionPromptPresenter promptPresenter = root.AddComponent<InteractionPromptPresenter>();
            SetSerialized(promptPresenter, "m_promptChanged", LoadChannel("InteractionPrompt"));
            SetSerialized(promptPresenter, "m_label", prompt);

            ReportToastPresenter toastPresenter = root.AddComponent<ReportToastPresenter>();
            SetSerialized(toastPresenter, "m_reportUpdated",
                AssetDatabase.LoadAssetAtPath<ReportUpdateEventChannelSO>(k_EventsFolder + "/ReportUpdated.asset"));
            SetSerialized(toastPresenter, "m_root", toastRoot);
            SetSerialized(toastPresenter, "m_title", toastTitle);
            SetSerialized(toastPresenter, "m_line", toastLine);

            SubtitlePresenter subtitlePresenter = root.AddComponent<SubtitlePresenter>();
            SetSubtitleChannels(subtitlePresenter, new[] { "RadioLine", "Monologue", "Notice", "InvestigationResult" });
            SetSerialized(subtitlePresenter, "m_label", subtitle);

            GameObject prefab = PrefabUtility.SaveAsPrefabAsset(root, path);
            Object.DestroyImmediate(root);

            return prefab;
        }

        private static GameObject CreateToast(RectTransform parent, out TextMeshProUGUI title, out TextMeshProUGUI line)
        {
            GameObject toast = new GameObject("ReportToast", typeof(RectTransform), typeof(Image),
                typeof(VerticalLayoutGroup), typeof(ContentSizeFitter));
            RectTransform toastRect = (RectTransform)toast.transform;
            toastRect.SetParent(parent, false);
            AnchorTopRight(toastRect, new Vector2(-16f, -16f), new Vector2(280f, 60f));

            Image background = toast.GetComponent<Image>();
            background.color = new Color(20f / 255f, 30f / 255f, 25f / 255f, 0.85f);

            VerticalLayoutGroup layout = toast.GetComponent<VerticalLayoutGroup>();
            layout.padding = new RectOffset(12, 12, 8, 8);
            layout.spacing = 2f;
            layout.childControlHeight = true;
            layout.childForceExpandHeight = false;

            ContentSizeFitter fitter = toast.GetComponent<ContentSizeFitter>();
            fitter.verticalFit = ContentSizeFitter.FitMode.PreferredSize;

            title = CreateLabel(toastRect, "Title", string.Empty);
            title.color = new Color(200f / 255f, 245f / 255f, 215f / 255f);
            title.fontStyle = FontStyles.Bold;
            title.fontSize = 14f;

            line = CreateLabel(toastRect, "Line", string.Empty);
            line.color = new Color(160f / 255f, 200f / 255f, 175f / 255f);
            line.fontSize = 12f;

            return toast;
        }

        private static TextMeshProUGUI CreateLabel(RectTransform parent, string name, string text)
        {
            GameObject go = new GameObject(name, typeof(RectTransform));
            go.transform.SetParent(parent, false);

            TextMeshProUGUI label = go.AddComponent<TextMeshProUGUI>();
            label.text = text;
            label.color = new Color(0.92f, 0.92f, 0.92f);
            label.fontSize = 14f;
            label.raycastTarget = false;

            return label;
        }

        private static void StretchFull(RectTransform rect)
        {
            rect.anchorMin = Vector2.zero;
            rect.anchorMax = Vector2.one;
            rect.offsetMin = Vector2.zero;
            rect.offsetMax = Vector2.zero;
        }

        private static void AnchorTopLeft(RectTransform rect, Vector2 offset, Vector2 size)
        {
            rect.anchorMin = new Vector2(0f, 1f);
            rect.anchorMax = new Vector2(0f, 1f);
            rect.pivot = new Vector2(0f, 1f);
            rect.anchoredPosition = offset;
            rect.sizeDelta = size;
        }

        private static void AnchorTopRight(RectTransform rect, Vector2 offset, Vector2 size)
        {
            rect.anchorMin = new Vector2(1f, 1f);
            rect.anchorMax = new Vector2(1f, 1f);
            rect.pivot = new Vector2(1f, 1f);
            rect.anchoredPosition = offset;
            rect.sizeDelta = size;
        }

        private static void AnchorCenter(RectTransform rect, Vector2 offset, Vector2 size)
        {
            rect.anchorMin = new Vector2(0.5f, 0.5f);
            rect.anchorMax = new Vector2(0.5f, 0.5f);
            rect.pivot = new Vector2(0.5f, 0.5f);
            rect.anchoredPosition = offset;
            rect.sizeDelta = size;
        }

        private static void AnchorBottomCenter(RectTransform rect, Vector2 offset, Vector2 size)
        {
            rect.anchorMin = new Vector2(0.5f, 0f);
            rect.anchorMax = new Vector2(0.5f, 0f);
            rect.pivot = new Vector2(0.5f, 0f);
            rect.anchoredPosition = offset;
            rect.sizeDelta = size;
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

            GameObject eventSystem = new GameObject("EventSystem", typeof(EventSystem), typeof(InputSystemUIInputModule));
            SceneManager.MoveGameObjectToScene(eventSystem, scene);

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
