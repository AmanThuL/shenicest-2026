using RootsDance.Core;
using RootsDance.UI;
using RootsDance.UI.Kit;
using TMPro;
using UnityEditor;
using UnityEngine;
using UnityEngine.UI;
using Object = UnityEngine.Object;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Builds <c>Prefabs/UI/CirculationConsoleScreen.prefab</c>: the central circulation terminal,
    /// on the Electronic UI Kit.
    /// <para>
    /// On the kit, unlike <c>DialogueScreenBuilder</c> — and for exactly the reason that one gives
    /// for staying off it. The kit is for diegetic device screens, and this is the one screen in
    /// the chapter that <em>is</em> a device: the player is not talking to anybody, they are
    /// reading GAIA's own panel and pressing one of its three buttons. Putting it in the dialogue
    /// box says a person said "CORE CULTIVATION CYCLE" out loud.
    /// </para>
    /// <para>
    /// Phosphor, the green theme. Precinct is a police archive and Violet is a records browser;
    /// an environmental system that has been asleep since the collapse is a lab terminal, and
    /// green is what the docs' own reference for that family uses.
    /// </para>
    /// <para>
    /// Every word on it comes from <c>Chapter02DialogueBuilder.BuildConsole</c> — the authored
    /// script for DLG-008 — except the 【】 brackets around the three cycles, which were the
    /// dialogue box's way of saying "this is a machine option". On the machine, the box is the box.
    /// </para>
    /// <para>
    /// Layout follows 电子类UI组件库规范 §5B: one frame, cut into bands, cut into cells, no empty
    /// ground between them. The three cycles share a rule rather than floating with gaps.
    /// </para>
    /// Idempotent: re-running overwrites the prefab. Menu: RootsDance &gt; UI &gt; Build
    /// Circulation Console Screen.
    /// </summary>
    public static class CirculationConsoleScreenBuilder
    {
        public const string k_PrefabPath =
            "Assets/RootsDance/Prefabs/UI/CirculationConsoleScreen.prefab";

        private const string k_ThemeFolder = "Assets/RootsDance/Data/Config/UIThemes";

        /// <summary>
        /// Phosphor's ramp on a bitmap face at half again the type size. The panel is read off a
        /// wall through the game's low resolution buffer, and the screen-space Phosphor — SDF at
        /// 16/24/40 — arrives there as grey mush; see <see cref="WallPixelFontBuilder"/>.
        /// </summary>
        private const string k_Theme = "PhosphorWall";

        // 1920x1080 reference, matching MainMenu and DialogueScreen.
        private const float k_ReferenceWidth = 1920f;
        private const float k_ReferenceHeight = 1080f;

        /// <summary>The panel itself. Not full-bleed: it is a thing standing in a room.</summary>
        private const float k_ScreenWidth = 1180f;
        private const float k_ScreenHeight = 760f;

        private const float k_HeaderHeight = 84f;
        private const float k_StatusHeight = 110f;
        private const float k_FooterHeight = 76f;

        private sealed class Cycle
        {
            public string m_index;
            public string m_chinese;
            public string m_english;
            public string m_description;
            /// <summary>
            /// Not printed on the panel any more — see BuildCycle — but kept so the script's own
            /// line is here beside the Chinese it was written with, and so the pair is one edit
            /// away from a screen that has room for both.
            /// </summary>
            public string m_descriptionEnglish;
            public string m_flag;

            /// <summary>
            /// How full the cycle's diagram is. The three cycles differ by where the water goes,
            /// and a mosaic that is dense in the middle, even across, or only at the edge says
            /// that faster than the label does.
            /// </summary>
            public float m_density;
        }

        private static readonly Cycle[] k_Cycles =
        {
            new Cycle
            {
                m_index = "01",
                m_chinese = "核心培育循环",
                m_english = "CORE CULTIVATION CYCLE",
                m_description = "适用于集中样本的集中培育与稳定观察。",
                m_descriptionEnglish =
                    "For concentrated cultivation and stable observation of pooled samples.",
                m_flag = WorldFlags.k_CirculationCore,
                m_density = 0.82f,
            },
            new Cycle
            {
                m_index = "02",
                m_chinese = "标准环形循环",
                m_english = "STANDARD RING CYCLE",
                m_description = "培育区进行均衡供给。",
                m_descriptionEnglish = "Balanced supply across the cultivation zones.",
                m_flag = WorldFlags.k_CirculationRing,
                m_density = 0.5f,
            },
            new Cycle
            {
                m_index = "03",
                m_chinese = "外缘检测循环",
                m_english = "OUTER BOUNDARY SURVEY CYCLE",
                m_description = "用于观测区域外缘变化及新增生长带。",
                m_descriptionEnglish =
                    "For observing change at the zone's outer edge and newly grown belts.",
                m_flag = WorldFlags.k_CirculationOuter,
                m_density = 0.22f,
            },
        };

        /// <summary>
        /// Every character the panel can print. The font is baked static against exactly this, so
        /// a word changed here and not re-baked prints a blank — which is why it is read from the
        /// layout rather than copied into the font builder.
        /// </summary>
        internal static string AllText
        {
            get
            {
                System.Text.StringBuilder builder = new System.Text.StringBuilder();
                builder.Append("GAIA 环境循环装置GAIA-CS状态 STATUS参数 PARAMETERS休眠偏差");
                builder.Append("与预设模型的偏差当前环境参数与预设模型存在偏差。启动 ENGAGE");
                builder.Append("启动中");

                for (int i = 0; i < k_Cycles.Length; i++)
                {
                    builder.Append(k_Cycles[i].m_index);
                    builder.Append(k_Cycles[i].m_chinese);
                    builder.Append(k_Cycles[i].m_english);
                    builder.Append(k_Cycles[i].m_description);
                }

                return builder.ToString();
            }
        }

        /// <summary>Batch entry point (-executeMethod).</summary>
        public static void BuildFromCommandLine()
        {
            Build();
        }

        [MenuItem("RootsDance/UI/Build Circulation Console Screen")]
        public static void Build()
        {
            ElectronicUITheme theme =
                AssetDatabase.LoadAssetAtPath<ElectronicUITheme>($"{k_ThemeFolder}/UITheme_{k_Theme}.asset");

            if (theme == null)
            {
                Debug.LogError($"[UI] No {k_Theme} theme at {k_ThemeFolder}. Run "
                    + "RootsDance > Build Electronic UI Kit first.");
                return;
            }

            GameObject root = BuildScreen(theme);
            PrefabUtility.SaveAsPrefabAsset(root, k_PrefabPath);
            Object.DestroyImmediate(root);

            AssetDatabase.SaveAssets();
            Debug.Log($"[UI] {k_PrefabPath} built. Point whatever opens the terminal at its "
                + "CirculationConsolePresenter.Open().");
        }

        private static GameObject BuildScreen(ElectronicUITheme theme)
        {
            GameObject root = new GameObject("CirculationConsoleScreen", typeof(RectTransform));

            Canvas canvas = root.AddComponent<Canvas>();
            canvas.renderMode = RenderMode.ScreenSpaceOverlay;

            // Above the dialogue box: the terminal is modal while it is up.
            canvas.sortingOrder = 20;

            CanvasScaler scaler = root.AddComponent<CanvasScaler>();
            scaler.uiScaleMode = CanvasScaler.ScaleMode.ScaleWithScreenSize;
            scaler.referenceResolution = new Vector2(k_ReferenceWidth, k_ReferenceHeight);
            scaler.matchWidthOrHeight = 0.5f;

            root.AddComponent<GraphicRaycaster>();

            // Everything below the canvas, so the presenter can switch the screen off without
            // switching off the canvas it lives on.
            GameObject screen = ElectronicUIKitBuilder.NewRect("Screen",
                new Vector2(k_ScreenWidth, k_ScreenHeight));
            screen.transform.SetParent(root.transform, false);

            ElectronicUIRoot uiRoot = screen.AddComponent<ElectronicUIRoot>();
            SerializedObject serializedRoot = new SerializedObject(uiRoot);
            serializedRoot.FindProperty("m_theme").objectReferenceValue = theme;
            serializedRoot.ApplyModifiedPropertiesWithoutUndo();

            ElectronicUIKitBuilder.AddFill(screen, KitInk.Ink0);

            RectTransform frame = Frame(screen, 22f);

            GameObject bands = ElectronicUIKitBuilder.MakeSplit("Bands", Vector2.zero,
                KitSplit.SplitAxis.Rows,
                new[]
                {
                    k_HeaderHeight,
                    k_StatusHeight,
                    k_ScreenHeight - 44f - k_HeaderHeight - k_StatusHeight - k_FooterHeight,
                    k_FooterHeight,
                },
                KitSplit.SeamStyle.Rule, -1, 0f, true);
            FillParent(bands, frame);

            BuildHeader(ElectronicUIKitBuilder.Cell(bands, 0));
            ThemedText status = BuildStatus(ElectronicUIKitBuilder.Cell(bands, 1));
            Button[] buttons = BuildCycles(ElectronicUIKitBuilder.Cell(bands, 2));
            BuildFooter(ElectronicUIKitBuilder.Cell(bands, 3));

            CirculationConsolePresenter presenter = root.AddComponent<CirculationConsolePresenter>();
            SerializedObject serialized = new SerializedObject(presenter);
            serialized.FindProperty("m_screen").objectReferenceValue = screen;
            serialized.FindProperty("m_statusValue").objectReferenceValue = status;

            SerializedProperty buttonList = serialized.FindProperty("m_cycleButtons");
            SerializedProperty flagList = serialized.FindProperty("m_cycleFlags");
            buttonList.arraySize = k_Cycles.Length;
            flagList.arraySize = k_Cycles.Length;

            for (int i = 0; i < k_Cycles.Length; i++)
            {
                buttonList.GetArrayElementAtIndex(i).objectReferenceValue = buttons[i];
                flagList.GetArrayElementAtIndex(i).stringValue = k_Cycles[i].m_flag;
            }

            serialized.ApplyModifiedPropertiesWithoutUndo();

            uiRoot.ApplyTheme();
            return root;
        }

        // ------------------------------------------------------------------------------ bands

        private static void BuildHeader(RectTransform header)
        {
            PlaceLabel(header, "GAIA 环境循环装置", KitInk.Ink5, KitType.Display,
                TextAlignmentOptions.Left, 18f, 480f);

            // The reference's full English title used to run along here. At this type size it
            // would take the whole band, and at the panel's reading resolution nobody was going to
            // read thirty-six characters of it anyway. The tag says the same thing in six.
            PlaceLabel(header, "GAIA-CS", KitInk.Ink3, KitType.Body,
                TextAlignmentOptions.Right, -18f, 260f, fromRight: true);
        }

        /// <summary>
        /// Two readouts and the deviation bar. The bar is the only thing on the screen allowed the
        /// accent colour: the parameters are out of range, and §2A reserves the accent for exactly
        /// that.
        /// </summary>
        private static ThemedText BuildStatus(RectTransform band)
        {
            GameObject columns = ElectronicUIKitBuilder.MakeSplit("StatusColumns", Vector2.zero,
                KitSplit.SplitAxis.Columns, new[] { 1f, 1f, 1.2f }, KitSplit.SeamStyle.Rule,
                -1, 0f, true);
            FillParent(columns, band);

            // The English moved up into the caption. As one string with the Chinese it ran past
            // its own cell and printed over the deviation bar in the next one — a readout at this
            // type size has room for one word, and the caption is where the other one lives.
            ThemedText status = Readout(ElectronicUIKitBuilder.Cell(columns, 0),
                "状态 STATUS", "休眠", KitInk.Ink5);
            Readout(ElectronicUIKitBuilder.Cell(columns, 1),
                "参数 PARAMETERS", "偏差", KitInk.Accent);

            RectTransform bar = ElectronicUIKitBuilder.Cell(columns, 2);
            PlaceLabel(bar, "与预设模型的偏差", KitInk.Ink3, KitType.Micro,
                TextAlignmentOptions.TopLeft, 16f, 340f, y: 14f);

            GameObject segments = ElectronicUIKitBuilder.MakeSegmentBar("Deviation", 18, 0.72f);
            Place(segments, bar, new Rect(16f, 58f, 340f, 32f));

            return status;
        }

        /// <summary>
        /// The three cycles, as three cells of one shared-rule split. Each cell is its own button:
        /// on a panel like this the whole block is the key, and a small SELECT button inside a cell
        /// would be a second, competing frame.
        /// </summary>
        private static Button[] BuildCycles(RectTransform band)
        {
            GameObject columns = ElectronicUIKitBuilder.MakeSplit("Cycles", Vector2.zero,
                KitSplit.SplitAxis.Columns, new[] { 1f, 1f, 1f }, KitSplit.SeamStyle.Rule,
                -1, 0f, true);
            FillParent(columns, band);

            Button[] buttons = new Button[k_Cycles.Length];

            for (int i = 0; i < k_Cycles.Length; i++)
            {
                buttons[i] = BuildCycle(ElectronicUIKitBuilder.Cell(columns, i), k_Cycles[i]);
            }

            return buttons;
        }

        private static Button BuildCycle(RectTransform cell, Cycle cycle)
        {
            // The hit area and the tint target in one: an Image with no sprite, held at Ink1 by the
            // theme, so the button's own ColorBlock multiplies against a themed ground instead of
            // against white.
            GameObject hit = ElectronicUIKitBuilder.NewRect("Key", Vector2.zero);
            hit.transform.SetParent(cell, false);
            ElectronicUIKitBuilder.Stretch((RectTransform)hit.transform, 10f);

            Image fill = hit.AddComponent<Image>();
            fill.raycastTarget = true;

            ThemedGraphic themed = hit.AddComponent<ThemedGraphic>();
            SerializedObject serializedFill = new SerializedObject(themed);
            serializedFill.FindProperty("m_ink").enumValueIndex = (int)KitInk.Ink1;
            serializedFill.ApplyModifiedPropertiesWithoutUndo();

            Button button = hit.AddComponent<Button>();
            button.targetGraphic = fill;
            button.transition = Selectable.Transition.ColorTint;

            ColorBlock colors = button.colors;
            colors.normalColor = Color.white;
            colors.highlightedColor = new Color(1.5f, 1.5f, 1.5f, 1f);
            colors.pressedColor = new Color(2.1f, 2.1f, 2.1f, 1f);
            colors.selectedColor = new Color(1.5f, 1.5f, 1.5f, 1f);
            colors.disabledColor = new Color(0.55f, 0.55f, 0.55f, 1f);
            colors.fadeDuration = 0.06f;
            button.colors = colors;

            RectTransform inner = (RectTransform)hit.transform;

            PlaceLabel(inner, cycle.m_index, KitInk.Ink3, KitType.Micro,
                TextAlignmentOptions.TopLeft, 16f, 90f, y: 12f);

            GameObject mosaic = ElectronicUIKitBuilder.MakeChipMosaic("Flow", 12, 5);
            Sparse(mosaic, cycle.m_density);
            Place(mosaic, inner, new Rect(16f, 46f, 330f, 76f));

            // The stack bottoms out at 378, which is where the ENGAGE strip starts. Every block
            // is given room for two lines whether or not its text needs them, so the three columns
            // still line up on the one that wraps.
            //
            // The English descriptions used to sit under these. They are gone: four more lines of
            // ten-pixel type is four lines nobody can read, and what they said the Chinese above
            // already says. The cycle names keep theirs — that pair is the machine's own label.
            PlaceLabel(inner, cycle.m_chinese, KitInk.Ink5, KitType.Display,
                TextAlignmentOptions.TopLeft, 16f, 340f, y: 130f, height: 62f);
            PlaceLabel(inner, cycle.m_english, KitInk.Ink4, KitType.Body,
                TextAlignmentOptions.TopLeft, 16f, 340f, y: 194f, height: 84f, wrap: true);

            PlaceLabel(inner, cycle.m_description, KitInk.Ink3, KitType.Body,
                TextAlignmentOptions.TopLeft, 16f, 340f, y: 286f, height: 90f, wrap: true);

            // The affordance. Without it the three cells read as three paragraphs of a datasheet —
            // the player has to guess that the panel is asking them something. A filled strip on
            // the cell's own bottom edge is not a competing frame: it is the bottom of this frame.
            GameObject engage = ElectronicUIKitBuilder.MakeBox("Engage", Vector2.zero, true,
                KitBox.CornerMask.None);
            engage.transform.SetParent(inner, false);
            RectTransform strip = (RectTransform)engage.transform;
            strip.anchorMin = new Vector2(0f, 0f);
            strip.anchorMax = new Vector2(1f, 0f);
            strip.pivot = new Vector2(0.5f, 0f);
            strip.offsetMin = new Vector2(0f, 0f);
            strip.offsetMax = new Vector2(0f, 48f);

            GameObject engageLabel = ElectronicUIKitBuilder.MakeLabel("Label", "启动 ENGAGE",
                KitInk.Ink0, KitType.Body, TextAlignmentOptions.Center);
            engageLabel.transform.SetParent(engage.transform, false);
            ElectronicUIKitBuilder.Stretch((RectTransform)engageLabel.transform, 4f);

            return button;
        }

        private static void BuildFooter(RectTransform footer)
        {
            // The English half of this line is gone for the same reason the title's is.
            PlaceLabel(footer, "当前环境参数与预设模型存在偏差。", KitInk.Ink3, KitType.Body,
                TextAlignmentOptions.Left, 18f, 800f);
        }

        // ---------------------------------------------------------------------------- helpers

        private static ThemedText Readout(RectTransform cell, string caption, string value,
            KitInk valueInk)
        {
            PlaceLabel(cell, caption, KitInk.Ink3, KitType.Micro, TextAlignmentOptions.TopLeft,
                16f, 300f, y: 12f);

            GameObject label = ElectronicUIKitBuilder.MakeLabel("Value", value, valueInk,
                KitType.Display, TextAlignmentOptions.TopLeft);
            Place(label, cell, new Rect(16f, 44f, 300f, 40f));

            return label.GetComponent<ThemedText>();
        }

        private static RectTransform Frame(GameObject root, float inset)
        {
            GameObject frame = ElectronicUIKitBuilder.NewRect("Frame", Vector2.zero);
            frame.transform.SetParent(root.transform, false);
            ElectronicUIKitBuilder.Stretch((RectTransform)frame.transform, inset);
            ElectronicUIKitBuilder.AddBorder(frame, KitInk.Ink5, true);

            GameObject dots = ElectronicUIKitBuilder.NewRect("NodeDots", Vector2.zero);
            dots.transform.SetParent(frame.transform, false);
            ElectronicUIKitBuilder.Stretch((RectTransform)dots.transform, 0f);
            KitNodeDots nodes = dots.AddComponent<KitNodeDots>();
            nodes.raycastTarget = false;
            ElectronicUIKitBuilder.SetInk(nodes, KitInk.Ink5);

            SerializedObject serialized = new SerializedObject(nodes);
            serialized.FindProperty("m_midpoints").boolValue = false;
            serialized.ApplyModifiedPropertiesWithoutUndo();

            return (RectTransform)frame.transform;
        }

        private static void FillParent(GameObject child, RectTransform parent)
        {
            child.transform.SetParent(parent, false);
            ElectronicUIKitBuilder.Stretch((RectTransform)child.transform, 0f);
            KitSplit split = child.GetComponent<KitSplit>();

            if (split != null)
            {
                split.Relayout();
            }
        }

        private static void PlaceLabel(RectTransform parent, string text, KitInk ink, KitType role,
            TextAlignmentOptions alignment, float x, float width, bool fromRight = false,
            float y = 0f, float height = 0f, bool wrap = false)
        {
            GameObject label = ElectronicUIKitBuilder.MakeLabel("Label", text, ink, role, alignment,
                KitCase.Family, false, wrap);
            label.transform.SetParent(parent, false);
            RectTransform rect = (RectTransform)label.transform;

            if (height <= 0f && y <= 0f)
            {
                // Vertically centred in the band — headers and footers.
                rect.anchorMin = new Vector2(fromRight ? 1f : 0f, 0f);
                rect.anchorMax = new Vector2(fromRight ? 1f : 0f, 1f);
                rect.pivot = new Vector2(fromRight ? 1f : 0f, 0.5f);
                rect.sizeDelta = new Vector2(width, 0f);
                rect.anchoredPosition = new Vector2(x, 0f);
                return;
            }

            rect.anchorMin = new Vector2(fromRight ? 1f : 0f, 1f);
            rect.anchorMax = rect.anchorMin;
            rect.pivot = new Vector2(fromRight ? 1f : 0f, 1f);
            rect.sizeDelta = new Vector2(width, height <= 0f ? 28f : height);
            rect.anchoredPosition = new Vector2(x, -y);
        }

        private static void Place(GameObject child, RectTransform parent, Rect rect)
        {
            child.transform.SetParent(parent, false);
            RectTransform target = (RectTransform)child.transform;
            target.anchorMin = new Vector2(0f, 1f);
            target.anchorMax = new Vector2(0f, 1f);
            target.pivot = new Vector2(0f, 1f);
            target.sizeDelta = new Vector2(rect.width, rect.height);
            target.anchoredPosition = new Vector2(rect.x, -rect.y);
        }

        /// <summary>
        /// Thins a mosaic so the three cycles read as three different distributions of water. Not
        /// random per run: the seed is the density, so a rebuild produces the same panel.
        /// </summary>
        private static void Sparse(GameObject mosaic, float density)
        {
            KitChipMosaic chips = mosaic.GetComponent<KitChipMosaic>();

            if (chips == null)
            {
                return;
            }

            SerializedObject serialized = new SerializedObject(chips);
            SerializedProperty fill = serialized.FindProperty("m_occupancy");

            if (fill != null)
            {
                fill.floatValue = density;
            }

            SerializedProperty seed = serialized.FindProperty("m_seed");

            if (seed != null)
            {
                seed.intValue = Mathf.RoundToInt(density * 100f);
            }

            serialized.ApplyModifiedPropertiesWithoutUndo();
        }
    }
}
