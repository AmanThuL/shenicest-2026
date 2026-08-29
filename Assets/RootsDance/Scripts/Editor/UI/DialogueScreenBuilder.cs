using RootsDance.Dialogue;
using TMPro;
using UnityEditor;
using UnityEngine;
using UnityEngine.UI;

namespace RootsDance.Editor.UI
{
    /// <summary>
    /// Builds <c>Prefabs/UI/DialogueScreen.prefab</c>: the line at the bottom of the screen and the
    /// column of options above it, wired to a <see cref="DialoguePresenter"/>.
    /// <para>
    /// Deliberately not built on the Electronic UI Kit. That kit is for diegetic device screens —
    /// the scanner's report, the helmet HUD — and a conversation between the protagonist and a
    /// flower is not a readout; dressing it as a terminal would say the wrong thing about who is
    /// talking. The kit is also documented as still being the previous spec's output, so building
    /// on it would inherit that. Plain uGUI and TextMeshPro leave a UI artist free to restyle this
    /// without unpicking anything.
    /// </para>
    /// <para>
    /// Options are laid out by a <see cref="VerticalLayoutGroup"/> rather than at fixed positions,
    /// because the presenter hides unused buttons with <c>SetActive(false)</c> and a layout group
    /// collapses inactive children. With fixed positions, a two-option exchange would leave a hole
    /// where the third button is not.
    /// </para>
    /// Idempotent: re-running overwrites the prefab with a freshly built one.
    /// Menu: RootsDance &gt; UI &gt; Build Dialogue Screen.
    /// </summary>
    public static class DialogueScreenBuilder
    {
        public const string k_PrefabPath = "Assets/RootsDance/Prefabs/UI/DialogueScreen.prefab";

        /// <summary>
        /// The project's text face: m5x7 sets the Latin, and its fallback table hands anything it
        /// has no glyph for — every Chinese character in the script — to Fusion Pixel. Pointing at
        /// the fallback directly instead would set the English in a CJK face too.
        /// </summary>
        private const string k_FontPath = "Assets/RootsDance/Fonts/m5x7 SDF.asset";

        // 1920x1080 reference, matching MainMenu.prefab's canvas scaler.
        private const float k_ReferenceWidth = 1920f;
        private const float k_ReferenceHeight = 1080f;

        private const float k_PanelWidth = 1280f;
        private const float k_LineBoxHeight = 200f;
        private const float k_LineBoxBottom = 72f;
        private const float k_ChoiceHeight = 76f;
        private const float k_ChoiceSpacing = 12f;

        /// <summary>Three is the most the chapter 02 script ever offers — the circulation console.</summary>
        private const int k_ChoiceCount = 3;

        private static readonly Color k_Backdrop = new Color(0.04f, 0.06f, 0.05f, 0.82f);
        private static readonly Color k_ChoiceFill = new Color(0.07f, 0.11f, 0.09f, 0.88f);
        private static readonly Color k_ChoiceHighlight = new Color(0.16f, 0.28f, 0.20f, 0.95f);
        private static readonly Color k_Body = new Color(0.90f, 0.93f, 0.88f, 1f);
        private static readonly Color k_Subtitle = new Color(0.66f, 0.72f, 0.65f, 1f);

        /// <summary>Batch entry point (-executeMethod).</summary>
        public static void BuildFromCommandLine()
        {
            Build();
        }

        [MenuItem("RootsDance/UI/Build Dialogue Screen")]
        public static void Build()
        {
            TMP_FontAsset font = AssetDatabase.LoadAssetAtPath<TMP_FontAsset>(k_FontPath);

            if (font == null)
            {
                Debug.LogWarning($"[UI] No font at {k_FontPath}; the screen is built with TMP's "
                    + "default face, which has no CJK glyphs. Repoint it once the project font lands.");
            }

            GameObject root = BuildScreen(font);
            PrefabUtility.SaveAsPrefabAsset(root, k_PrefabPath);
            Object.DestroyImmediate(root);

            AssetDatabase.SaveAssets();

            Debug.Log($"[UI] {k_PrefabPath} built with {k_ChoiceCount} choice buttons. Drop it into "
                + "the bootstrap scene's UI slot and point the player's DialogueRunner at its "
                + "DialoguePresenter.");
        }

        private static GameObject BuildScreen(TMP_FontAsset font)
        {
            GameObject root = new GameObject("DialogueScreen", typeof(RectTransform));

            Canvas canvas = root.AddComponent<Canvas>();
            canvas.renderMode = RenderMode.ScreenSpaceOverlay;

            // Above the world but below anything modal. The HUD and this never show together.
            canvas.sortingOrder = 10;

            CanvasScaler scaler = root.AddComponent<CanvasScaler>();
            scaler.uiScaleMode = CanvasScaler.ScaleMode.ScaleWithScreenSize;
            scaler.referenceResolution = new Vector2(k_ReferenceWidth, k_ReferenceHeight);
            scaler.screenMatchMode = CanvasScaler.ScreenMatchMode.MatchWidthOrHeight;
            scaler.matchWidthOrHeight = 0.5f;

            root.AddComponent<GraphicRaycaster>();

            GameObject panel = NewRect("Panel", (RectTransform)root.transform);
            RectTransform panelRect = (RectTransform)panel.transform;
            Stretch(panelRect);

            CanvasGroup group = panel.AddComponent<CanvasGroup>();
            group.alpha = 0f;
            group.blocksRaycasts = false;
            group.interactable = false;

            DialoguePresenter presenter = panel.AddComponent<DialoguePresenter>();

            TextMeshProUGUI speaker;
            TextMeshProUGUI chinese;
            TextMeshProUGUI english;
            BuildLineBox(panelRect, font, out speaker, out chinese, out english);

            Button[] buttons = new Button[k_ChoiceCount];
            TextMeshProUGUI[] choiceChinese = new TextMeshProUGUI[k_ChoiceCount];
            TextMeshProUGUI[] choiceEnglish = new TextMeshProUGUI[k_ChoiceCount];
            BuildChoices(panelRect, font, buttons, choiceChinese, choiceEnglish);

            Wire(presenter, group, speaker, chinese, english, buttons, choiceChinese, choiceEnglish);

            return root;
        }

        private static void BuildLineBox(RectTransform parent, TMP_FontAsset font,
            out TextMeshProUGUI speaker, out TextMeshProUGUI chinese, out TextMeshProUGUI english)
        {
            GameObject box = NewRect("LineBox", parent);
            RectTransform rect = (RectTransform)box.transform;

            // Anchored to the bottom centre: the line sits where subtitles sit, and the panel's
            // width is fixed so a very wide window does not stretch a sentence across the screen.
            rect.anchorMin = new Vector2(0.5f, 0f);
            rect.anchorMax = new Vector2(0.5f, 0f);
            rect.pivot = new Vector2(0.5f, 0f);
            rect.sizeDelta = new Vector2(k_PanelWidth, k_LineBoxHeight);
            rect.anchoredPosition = new Vector2(0f, k_LineBoxBottom);

            Image backdrop = box.AddComponent<Image>();
            backdrop.color = k_Backdrop;
            backdrop.raycastTarget = false;

            speaker = Label(rect, "Speaker", font, 30f, TextAlignmentOptions.TopLeft, k_Body,
                new Vector2(32f, -20f), new Vector2(400f, 40f));

            chinese = Label(rect, "Chinese", font, 34f, TextAlignmentOptions.TopLeft, k_Body,
                new Vector2(32f, -68f), new Vector2(k_PanelWidth - 64f, 72f));

            english = Label(rect, "English", font, 22f, TextAlignmentOptions.TopLeft, k_Subtitle,
                new Vector2(32f, -146f), new Vector2(k_PanelWidth - 64f, 44f));
        }

        private static void BuildChoices(RectTransform parent, TMP_FontAsset font, Button[] buttons,
            TextMeshProUGUI[] chinese, TextMeshProUGUI[] english)
        {
            GameObject column = NewRect("Choices", parent);
            RectTransform rect = (RectTransform)column.transform;

            rect.anchorMin = new Vector2(0.5f, 0f);
            rect.anchorMax = new Vector2(0.5f, 0f);
            rect.pivot = new Vector2(0.5f, 0f);
            rect.sizeDelta = new Vector2(k_PanelWidth, 0f);
            rect.anchoredPosition = new Vector2(0f, k_LineBoxBottom + k_LineBoxHeight + 16f);

            VerticalLayoutGroup layout = column.AddComponent<VerticalLayoutGroup>();
            layout.spacing = k_ChoiceSpacing;
            layout.childAlignment = TextAnchor.LowerCenter;
            layout.childControlWidth = true;
            layout.childControlHeight = true;
            layout.childForceExpandWidth = true;
            layout.childForceExpandHeight = false;

            ContentSizeFitter fitter = column.AddComponent<ContentSizeFitter>();
            fitter.verticalFit = ContentSizeFitter.FitMode.PreferredSize;

            for (int i = 0; i < buttons.Length; i++)
            {
                GameObject option = NewRect($"Choice{i}", rect);

                LayoutElement element = option.AddComponent<LayoutElement>();
                element.preferredHeight = k_ChoiceHeight;

                // The graphic stays white and the states carry the colour. A Button tints by
                // multiplying its target graphic, so colouring the Image as well would make every
                // state come out darker than it was authored.
                Image fill = option.AddComponent<Image>();
                fill.color = Color.white;

                Button button = option.AddComponent<Button>();
                button.targetGraphic = fill;

                ColorBlock colors = button.colors;
                colors.normalColor = k_ChoiceFill;
                colors.highlightedColor = k_ChoiceHighlight;
                colors.selectedColor = k_ChoiceHighlight;
                colors.pressedColor = k_ChoiceHighlight;
                button.colors = colors;

                RectTransform optionRect = (RectTransform)option.transform;

                chinese[i] = Label(optionRect, "Chinese", font, 28f, TextAlignmentOptions.Left,
                    k_Body, new Vector2(24f, -10f), new Vector2(k_PanelWidth - 48f, 36f));

                english[i] = Label(optionRect, "English", font, 18f, TextAlignmentOptions.Left,
                    k_Subtitle, new Vector2(24f, -46f), new Vector2(k_PanelWidth - 48f, 24f));

                buttons[i] = button;

                // The presenter switches these on as options are offered; a prefab that ships with
                // three empty buttons showing is a prefab someone drops in and thinks is broken.
                option.SetActive(false);
            }
        }

        private static TextMeshProUGUI Label(RectTransform parent, string name, TMP_FontAsset font,
            float size, TextAlignmentOptions alignment, Color color, Vector2 topLeft, Vector2 sizeDelta)
        {
            GameObject go = NewRect(name, parent);
            RectTransform rect = (RectTransform)go.transform;

            rect.anchorMin = new Vector2(0f, 1f);
            rect.anchorMax = new Vector2(0f, 1f);
            rect.pivot = new Vector2(0f, 1f);
            rect.anchoredPosition = topLeft;
            rect.sizeDelta = sizeDelta;

            TextMeshProUGUI text = go.AddComponent<TextMeshProUGUI>();
            text.fontSize = size;
            text.alignment = alignment;
            text.color = color;
            text.raycastTarget = false;
            text.text = string.Empty;

            if (font != null)
            {
                text.font = font;
            }

            return text;
        }

        private static void Wire(DialoguePresenter presenter, CanvasGroup group,
            TextMeshProUGUI speaker, TextMeshProUGUI chinese, TextMeshProUGUI english,
            Button[] buttons, TextMeshProUGUI[] choiceChinese, TextMeshProUGUI[] choiceEnglish)
        {
            SerializedObject serialized = new SerializedObject(presenter);

            serialized.FindProperty("m_root").objectReferenceValue = group;
            serialized.FindProperty("m_speakerLabel").objectReferenceValue = speaker;
            serialized.FindProperty("m_chineseLabel").objectReferenceValue = chinese;
            serialized.FindProperty("m_englishLabel").objectReferenceValue = english;

            SetArray(serialized.FindProperty("m_choiceButtons"), buttons);
            SetArray(serialized.FindProperty("m_choiceChineseLabels"), choiceChinese);
            SetArray(serialized.FindProperty("m_choiceEnglishLabels"), choiceEnglish);

            serialized.ApplyModifiedPropertiesWithoutUndo();
        }

        private static void SetArray(SerializedProperty property, Object[] entries)
        {
            property.arraySize = entries.Length;

            for (int i = 0; i < entries.Length; i++)
            {
                property.GetArrayElementAtIndex(i).objectReferenceValue = entries[i];
            }
        }

        private static GameObject NewRect(string name, RectTransform parent)
        {
            GameObject go = new GameObject(name, typeof(RectTransform));
            go.transform.SetParent(parent, false);

            return go;
        }

        private static void Stretch(RectTransform rect)
        {
            rect.anchorMin = Vector2.zero;
            rect.anchorMax = Vector2.one;
            rect.offsetMin = Vector2.zero;
            rect.offsetMax = Vector2.zero;
        }
    }
}
