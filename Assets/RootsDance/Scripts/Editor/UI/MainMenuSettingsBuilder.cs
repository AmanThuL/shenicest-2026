using RootsDance.Data;
using RootsDance.UI;
using TMPro;
using UnityEditor;
using UnityEngine;
using UnityEngine.UI;
using Object = UnityEngine.Object;

namespace RootsDance.Editor.UI
{
    /// <summary>
    /// Adds the controls settings view to the existing main menu prefab while preserving its
    /// authored level and event-channel assignments. Idempotent: generated objects are replaced.
    /// </summary>
    public static class MainMenuSettingsBuilder
    {
        public const string k_PrefabPath = "Assets/RootsDance/Prefabs/UI/MainMenu.prefab";
        public const string k_SettingsPath = "Assets/RootsDance/Data/Config/ControlSettings.asset";

        private const string k_FontPath = "Assets/RootsDance/Fonts/m5x7 SDF.asset";
        private const string k_SettingsButtonName = "SettingsButton";
        private const string k_SettingsPanelName = "SettingsPanel";

        private static readonly Color k_Background = new Color(0.078f, 0.094f, 0.086f, 0.98f);
        private static readonly Color k_Panel = new Color(0.12f, 0.145f, 0.132f, 1f);
        private static readonly Color k_Foreground = new Color(0.882f, 0.922f, 0.902f, 1f);
        private static readonly Color k_Button = new Color(0.9f, 0.9f, 0.9f, 1f);
        private static readonly Color k_ButtonText = new Color(0.078f, 0.094f, 0.086f, 1f);
        private static readonly Color k_Track = new Color(0.25f, 0.29f, 0.27f, 1f);

        /// <summary>Batch entry point for Unity's <c>-executeMethod</c>.</summary>
        public static void BuildFromCommandLine()
        {
            Build();
        }

        [MenuItem("RootsDance/UI/Add Settings to Main Menu")]
        public static void Build()
        {
            ControlSettingsSO settings = EnsureSettingsAsset();
            GameObject root = PrefabUtility.LoadPrefabContents(k_PrefabPath);

            if (root == null)
            {
                Debug.LogError($"[UI] Main menu prefab not found at {k_PrefabPath}.");
                return;
            }

            try
            {
                AddSettings(root, settings);
                PrefabUtility.SaveAsPrefabAsset(root, k_PrefabPath);
            }
            finally
            {
                PrefabUtility.UnloadPrefabContents(root);
            }

            Debug.Log($"[UI] Added control settings to {k_PrefabPath}.");
        }

        private static ControlSettingsSO EnsureSettingsAsset()
        {
            ControlSettingsSO settings = AssetDatabase.LoadAssetAtPath<ControlSettingsSO>(k_SettingsPath);

            if (settings != null)
            {
                return settings;
            }

            settings = ScriptableObject.CreateInstance<ControlSettingsSO>();
            AssetDatabase.CreateAsset(settings, k_SettingsPath);
            return settings;
        }

        private static void AddSettings(GameObject root, ControlSettingsSO settings)
        {
            RectTransform rootRect = root.GetComponent<RectTransform>();
            Transform title = root.transform.Find("Title");
            Transform start = root.transform.Find("StartButton");

            if (rootRect == null || title == null || start == null)
            {
                Debug.LogError("[UI] MainMenu.prefab must contain Title and StartButton children.");
                return;
            }

            DestroyGeneratedChild(root.transform, k_SettingsButtonName);
            DestroyGeneratedChild(root.transform, k_SettingsPanelName);

            TMP_FontAsset font = AssetDatabase.LoadAssetAtPath<TMP_FontAsset>(k_FontPath);

            if (font == null)
            {
                Debug.LogError($"[UI] Main menu font not found at {k_FontPath}.");
                return;
            }

            TextMeshProUGUI[] existingLabels = root.GetComponentsInChildren<TextMeshProUGUI>(true);

            for (int i = 0; i < existingLabels.Length; i++)
            {
                existingLabels[i].font = font;
            }

            Button settingsButton = CreateButton(
                rootRect,
                k_SettingsButtonName,
                "设置",
                font,
                new Vector2(0f, -95f),
                new Vector2(220f, 50f));

            RectTransform settingsPanel = CreateRect(k_SettingsPanelName, rootRect);
            Stretch(settingsPanel);
            Image backdrop = settingsPanel.gameObject.AddComponent<Image>();
            backdrop.color = k_Background;

            RectTransform card = CreateRect("Card", settingsPanel);
            Anchor(card, new Vector2(0.5f, 0.5f), Vector2.zero, new Vector2(720f, 500f));
            Image cardImage = card.gameObject.AddComponent<Image>();
            cardImage.color = k_Panel;

            CreateLabel(card, "Title", "控制设置", font, 34f, TextAlignmentOptions.Center,
                new Vector2(0f, 184f), new Vector2(620f, 54f));
            CreateLabel(card, "SensitivityLabel", "鼠标灵敏度", font, 22f, TextAlignmentOptions.Left,
                new Vector2(-250f, 80f), new Vector2(230f, 40f));

            Slider sensitivitySlider = CreateSlider(
                card,
                new Vector2(30f, 80f),
                new Vector2(330f, 34f));
            TextMeshProUGUI sensitivityValue = CreateLabel(
                card,
                "SensitivityValue",
                "100%",
                font,
                22f,
                TextAlignmentOptions.Center,
                new Vector2(235f, 80f),
                new Vector2(100f, 40f));

            Toggle invertToggle = CreateToggle(
                card,
                font,
                new Vector2(-90f, -10f),
                new Vector2(320f, 48f));

            Button backButton = CreateButton(
                card,
                "BackButton",
                "返回",
                font,
                new Vector2(0f, -158f),
                new Vector2(220f, 50f));

            MainMenuSettingsPresenter presenter = root.GetComponent<MainMenuSettingsPresenter>();

            if (presenter == null)
            {
                presenter = root.AddComponent<MainMenuSettingsPresenter>();
            }

            Wire(
                presenter,
                settings,
                new[] { title.gameObject, start.gameObject, settingsButton.gameObject },
                settingsPanel.gameObject,
                settingsButton,
                backButton,
                sensitivitySlider,
                sensitivityValue,
                invertToggle);

            settingsPanel.gameObject.SetActive(false);
        }

        private static Button CreateButton(RectTransform parent, string name, string label,
            TMP_FontAsset font, Vector2 position, Vector2 size)
        {
            RectTransform rect = CreateRect(name, parent);
            Anchor(rect, new Vector2(0.5f, 0.5f), position, size);
            Image image = rect.gameObject.AddComponent<Image>();
            image.color = k_Button;

            Button button = rect.gameObject.AddComponent<Button>();
            button.targetGraphic = image;

            TextMeshProUGUI text = CreateLabel(
                rect,
                "Label",
                label,
                font,
                18f,
                TextAlignmentOptions.Center,
                Vector2.zero,
                size);
            Stretch(text.rectTransform);
            text.color = k_ButtonText;
            return button;
        }

        private static Slider CreateSlider(RectTransform parent, Vector2 position, Vector2 size)
        {
            RectTransform root = CreateRect("SensitivitySlider", parent);
            Anchor(root, new Vector2(0.5f, 0.5f), position, size);

            RectTransform background = CreateRect("Background", root);
            Anchor(background, new Vector2(0.5f, 0.5f), Vector2.zero, new Vector2(size.x, 8f));
            Image backgroundImage = background.gameObject.AddComponent<Image>();
            backgroundImage.color = k_Track;

            RectTransform fillArea = CreateRect("FillArea", root);
            StretchWithHorizontalInset(fillArea, 10f);
            RectTransform fill = CreateRect("Fill", fillArea);
            Stretch(fill);
            Image fillImage = fill.gameObject.AddComponent<Image>();
            fillImage.color = k_Foreground;

            RectTransform handleArea = CreateRect("HandleSlideArea", root);
            StretchWithHorizontalInset(handleArea, 10f);
            RectTransform handle = CreateRect("Handle", handleArea);
            Anchor(handle, new Vector2(0.5f, 0.5f), Vector2.zero, new Vector2(24f, 28f));
            Image handleImage = handle.gameObject.AddComponent<Image>();
            handleImage.color = k_Button;

            Slider slider = root.gameObject.AddComponent<Slider>();
            slider.fillRect = fill;
            slider.handleRect = handle;
            slider.targetGraphic = handleImage;
            slider.direction = Slider.Direction.LeftToRight;
            slider.minValue = ControlSettingsSO.k_MinMouseSensitivityMultiplier;
            slider.maxValue = ControlSettingsSO.k_MaxMouseSensitivityMultiplier;
            slider.value = ControlSettingsSO.k_DefaultMouseSensitivityMultiplier;
            return slider;
        }

        private static Toggle CreateToggle(RectTransform parent, TMP_FontAsset font,
            Vector2 position, Vector2 size)
        {
            RectTransform root = CreateRect("InvertYAxisToggle", parent);
            Anchor(root, new Vector2(0.5f, 0.5f), position, size);

            RectTransform box = CreateRect("Background", root);
            box.anchorMin = new Vector2(0f, 0.5f);
            box.anchorMax = new Vector2(0f, 0.5f);
            box.pivot = new Vector2(0f, 0.5f);
            box.anchoredPosition = Vector2.zero;
            box.sizeDelta = new Vector2(32f, 32f);
            Image boxImage = box.gameObject.AddComponent<Image>();
            boxImage.color = k_Track;

            RectTransform checkmark = CreateRect("Checkmark", box);
            Stretch(checkmark);
            checkmark.offsetMin = new Vector2(7f, 7f);
            checkmark.offsetMax = new Vector2(-7f, -7f);
            Image checkmarkImage = checkmark.gameObject.AddComponent<Image>();
            checkmarkImage.color = k_Foreground;

            TextMeshProUGUI label = CreateLabel(
                root,
                "Label",
                "反转 Y 轴",
                font,
                22f,
                TextAlignmentOptions.Left,
                Vector2.zero,
                new Vector2(250f, 40f));
            label.rectTransform.anchorMin = new Vector2(0f, 0.5f);
            label.rectTransform.anchorMax = new Vector2(0f, 0.5f);
            label.rectTransform.pivot = new Vector2(0f, 0.5f);
            label.rectTransform.anchoredPosition = new Vector2(48f, 0f);

            Toggle toggle = root.gameObject.AddComponent<Toggle>();
            toggle.targetGraphic = boxImage;
            toggle.graphic = checkmarkImage;
            return toggle;
        }

        private static TextMeshProUGUI CreateLabel(RectTransform parent, string name, string content,
            TMP_FontAsset font, float fontSize, TextAlignmentOptions alignment, Vector2 position,
            Vector2 size)
        {
            RectTransform rect = CreateRect(name, parent);
            Anchor(rect, new Vector2(0.5f, 0.5f), position, size);
            TextMeshProUGUI text = rect.gameObject.AddComponent<TextMeshProUGUI>();
            text.font = font;
            text.fontSize = fontSize;
            text.alignment = alignment;
            text.color = k_Foreground;
            text.raycastTarget = false;
            text.text = content;
            return text;
        }

        private static void Wire(MainMenuSettingsPresenter presenter, ControlSettingsSO settings,
            GameObject[] mainMenuObjects, GameObject settingsPanel, Button settingsButton,
            Button backButton, Slider sensitivitySlider, TextMeshProUGUI sensitivityValue,
            Toggle invertToggle)
        {
            SerializedObject serialized = new SerializedObject(presenter);
            serialized.FindProperty("m_controlSettings").objectReferenceValue = settings;
            serialized.FindProperty("m_settingsPanel").objectReferenceValue = settingsPanel;
            serialized.FindProperty("m_settingsButton").objectReferenceValue = settingsButton;
            serialized.FindProperty("m_backButton").objectReferenceValue = backButton;
            serialized.FindProperty("m_mouseSensitivitySlider").objectReferenceValue = sensitivitySlider;
            serialized.FindProperty("m_mouseSensitivityValueLabel").objectReferenceValue = sensitivityValue;
            serialized.FindProperty("m_invertYAxisToggle").objectReferenceValue = invertToggle;

            SerializedProperty mainObjects = serialized.FindProperty("m_mainMenuObjects");
            mainObjects.arraySize = mainMenuObjects.Length;

            for (int i = 0; i < mainMenuObjects.Length; i++)
            {
                mainObjects.GetArrayElementAtIndex(i).objectReferenceValue = mainMenuObjects[i];
            }

            serialized.ApplyModifiedPropertiesWithoutUndo();
        }

        private static RectTransform CreateRect(string name, RectTransform parent)
        {
            GameObject go = new GameObject(name, typeof(RectTransform));
            go.transform.SetParent(parent, false);
            return (RectTransform)go.transform;
        }

        private static void Anchor(RectTransform rect, Vector2 anchor, Vector2 position, Vector2 size)
        {
            rect.anchorMin = anchor;
            rect.anchorMax = anchor;
            rect.pivot = new Vector2(0.5f, 0.5f);
            rect.anchoredPosition = position;
            rect.sizeDelta = size;
        }

        private static void Stretch(RectTransform rect)
        {
            rect.anchorMin = Vector2.zero;
            rect.anchorMax = Vector2.one;
            rect.offsetMin = Vector2.zero;
            rect.offsetMax = Vector2.zero;
        }

        private static void StretchWithHorizontalInset(RectTransform rect, float inset)
        {
            Stretch(rect);
            rect.offsetMin = new Vector2(inset, 0f);
            rect.offsetMax = new Vector2(-inset, 0f);
        }

        private static void DestroyGeneratedChild(Transform parent, string name)
        {
            Transform existing = parent.Find(name);

            if (existing != null)
            {
                Object.DestroyImmediate(existing.gameObject);
            }
        }
    }
}
