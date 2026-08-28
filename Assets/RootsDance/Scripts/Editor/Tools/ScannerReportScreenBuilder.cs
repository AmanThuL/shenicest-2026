using RootsDance.Scanner;
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
    /// Builds the scanner's survey-report screen as a prefab, from the kit and from the brief's
    /// low-fidelity sketch. Three levels, laid out the way the sketch draws them:
    /// <list type="bullet">
    /// <item>the report's own title on a folder tab hanging over the top edge of the frame;</item>
    /// <item>the section rail down the left margin, outside the frame, one tab per section;</item>
    /// <item>the page tabs across the top right, with the red update dot at their end.</item>
    /// </list>
    /// Inside the frame: a header band carrying the index box, the name field and the close control,
    /// then a two-column body — the turning model on the left, the function tabs and the copy on the
    /// right — with the paging arrows straddling the frame's left and right edges.
    /// <para>
    /// The canvas is 1060 x 719 reference pixels because the physical lit area of the prop's screen
    /// is 105.94 x 71.86 mm: one pixel is a tenth of a millimetre, which keeps the kit's metrics
    /// (u = 4 px, Row = 40 px) at a sane physical size and makes the two numbers checkable against
    /// each other.
    /// </para>
    /// Menu: RootsDance > Build Scanner Report Screen.
    /// </summary>
    public static class ScannerReportScreenBuilder
    {
        public const string k_ScreenPrefab = "Assets/RootsDance/Prefabs/UI/ScannerReportScreen.prefab";

        private const string k_ThemeFolder = ElectronicUIKitBuilder.ThemeFolder;
        private const string k_SectionFolder = "Assets/RootsDance/Data/Scanner";
        private const string k_DefaultTheme = "Amber";

        // Canvas
        private const float k_Width = 1060f;
        private const float k_Height = 719f;

        // Frame inset. Left and top are wide enough to hold the tabs that hang outside the frame.
        private const float k_FrameLeft = 96f;
        private const float k_FrameTop = 56f;
        private const float k_FrameRight = 40f;
        private const float k_FrameBottom = 28f;

        private const float k_HeaderHeight = 96f;
        private const float k_PreviewColumn = 360f;
        private const float k_FunctionBarHeight = 56f;

        [MenuItem("RootsDance/Build Scanner Report Screen")]
        public static void Build()
        {
            ElectronicUIKitBuilder.EnsureFolder("Assets/RootsDance/Prefabs/UI");

            GameObject root = BuildScreen();
            PrefabUtility.SaveAsPrefabAsset(root, k_ScreenPrefab);
            Object.DestroyImmediate(root);

            AssetDatabase.SaveAssets();
            Debug.Log($"ScannerReportScreenBuilder: {k_ScreenPrefab} built. Swap the theme on the "
                + "ElectronicUIRoot to change the whole screen's palette.");
        }

        /// <summary>
        /// Builds the screen and returns its root. Public so the prop builder can drop one straight
        /// onto the scanner without going through the prefab asset.
        /// </summary>
        public static GameObject BuildScreen()
        {
            GameObject root = ElectronicUIKitBuilder.NewRect("ScannerReportScreen",
                new Vector2(k_Width, k_Height));

            // The screen is a surface in the world, not an overlay: it lives on the prop's own
            // plate, so the canvas is world-space and ScannerScreenSurface owns its size and scale.
            Canvas canvas = root.AddComponent<Canvas>();
            canvas.renderMode = RenderMode.WorldSpace;
            root.AddComponent<GraphicRaycaster>();
            root.AddComponent<ScannerScreenSurface>();

            GameObject report = ElectronicUIKitBuilder.NewRect("Report", Vector2.zero);
            report.transform.SetParent(root.transform, false);
            ElectronicUIKitBuilder.Stretch((RectTransform)report.transform, 0f);
            ElectronicUIKitBuilder.AddFill(report, KitInk.Ink0);

            ElectronicUIRoot uiRoot = report.AddComponent<ElectronicUIRoot>();
            SerializedObject themed = new SerializedObject(uiRoot);
            themed.FindProperty("m_theme").objectReferenceValue =
                AssetDatabase.LoadAssetAtPath<ElectronicUITheme>(
                    $"{k_ThemeFolder}/UITheme_{k_DefaultTheme}.asset");
            themed.ApplyModifiedPropertiesWithoutUndo();

            RectTransform reportRect = (RectTransform)report.transform;

            ThemedText title = TitleTab(reportRect);
            RectTransform sectionRail = Rail(reportRect);
            ScannerReportTab sectionTemplate = TabTemplate("SectionTab", sectionRail,
                new Vector2(84f, 52f), TextAlignmentOptions.Left, KitType.Micro, false);

            RectTransform pageBar = PageBar(reportRect);
            ScannerReportTab pageTemplate = TabTemplate("PageTab", pageBar, new Vector2(26f, 40f),
                TextAlignmentOptions.Center, KitType.Micro, true);
            GameObject updateDot = UpdateDot(reportRect);

            RectTransform frame = Frame(reportRect);
            GameObject bands = ElectronicUIKitBuilder.MakeSplit("Bands", Vector2.zero,
                KitSplit.SplitAxis.Rows, new[] { k_HeaderHeight, k_Height - k_HeaderHeight },
                KitSplit.SeamStyle.Rule, -1, 0f, true);
            Fill(bands, frame);

            RectTransform header = ElectronicUIKitBuilder.Cell(bands, 0);
            ThemedText index = FieldBox(header, new Rect(20f, 20f, 128f, 56f), "1.1",
                TextAlignmentOptions.Center);
            ThemedText name = FieldBox(header, new Rect(168f, 20f, 508f, 56f), "名称",
                TextAlignmentOptions.Left);
            Button close = ControlButton(header, new Rect(792f, 16f, 64f, 64f), "X");

            GameObject columns = ElectronicUIKitBuilder.MakeSplit("Body", Vector2.zero,
                KitSplit.SplitAxis.Columns,
                new[] { k_PreviewColumn, k_Width - k_FrameLeft - k_FrameRight - k_PreviewColumn },
                KitSplit.SeamStyle.Rule, -1, 0f, true);
            Fill(columns, ElectronicUIKitBuilder.Cell(bands, 1));

            RectTransform previewCell = ElectronicUIKitBuilder.Cell(columns, 0);
            RectTransform previewSlot = PreviewBox(previewCell);

            GameObject rightRows = ElectronicUIKitBuilder.MakeSplit("RightRows", Vector2.zero,
                KitSplit.SplitAxis.Rows,
                new[] { k_FunctionBarHeight, k_Height - k_HeaderHeight - k_FunctionBarHeight },
                KitSplit.SeamStyle.Rule, -1, 0f, true);
            Fill(rightRows, ElectronicUIKitBuilder.Cell(columns, 1));

            RectTransform functionCell = ElectronicUIKitBuilder.Cell(rightRows, 0);
            RectTransform functionBar = Row("FunctionTabBar", functionCell, 8f);
            ScannerReportTab functionTemplate = TabTemplate("FunctionTab", functionBar,
                new Vector2(112f, 40f), TextAlignmentOptions.Center, KitType.Micro, false);

            ThemedText body = BodyText(ElectronicUIKitBuilder.Cell(rightRows, 1));

            Button previous = Arrow(reportRect, "<", k_FrameLeft - 22f);
            Button next = Arrow(reportRect, ">", k_Width - k_FrameRight - 22f);

            Wire(report, title, sectionRail, sectionTemplate, pageBar, pageTemplate, updateDot,
                index, name, body, functionBar, functionTemplate, previewSlot, previous, next);

            Relayout(root);

            return root;
        }

        // ------------------------------------------------------------------ level one

        /// <summary>The report's own name, on a folder tab sitting on the frame's top edge.</summary>
        private static ThemedText TitleTab(RectTransform parent)
        {
            GameObject tab = ElectronicUIKitBuilder.NewRect("TitleTab", new Vector2(560f, 52f));
            ElectronicUIKitBuilder.AddBorder(tab, KitInk.Ink5, true);
            PlaceTopLeft(tab, parent, new Rect(k_FrameLeft + 24f, 4f, 560f, 52f));

            GameObject label = ElectronicUIKitBuilder.MakeLabel("Label", "遗迹环境与资源调查报告",
                KitInk.Ink5, KitType.Body, TextAlignmentOptions.Center);
            label.transform.SetParent(tab.transform, false);
            ElectronicUIKitBuilder.Stretch((RectTransform)label.transform, 6f);

            return label.GetComponent<ThemedText>();
        }

        // ------------------------------------------------------------------ level two

        private static RectTransform Rail(RectTransform parent)
        {
            GameObject rail = ElectronicUIKitBuilder.NewRect("SectionRail", new Vector2(84f, 480f));
            PlaceTopLeft(rail, parent, new Rect(6f, 132f, 84f, 480f));

            VerticalLayoutGroup layout = rail.AddComponent<VerticalLayoutGroup>();
            layout.spacing = 16f;
            layout.childControlWidth = true;
            layout.childControlHeight = false;
            layout.childForceExpandWidth = true;
            layout.childForceExpandHeight = false;

            return (RectTransform)rail.transform;
        }

        // ------------------------------------------------------------------ level three

        private static RectTransform PageBar(RectTransform parent)
        {
            GameObject bar = ElectronicUIKitBuilder.NewRect("PageTabBar", new Vector2(280f, 40f));
            PlaceTopLeft(bar, parent, new Rect(672f, 12f, 280f, 40f));

            return Row("Row", (RectTransform)bar.transform, 0f, 6f);
        }

        /// <summary>
        /// The update dot. Accent, and square: the archive family has no circles, and the brief
        /// draws a small red block anyway. This and the per-tab dot are the screen's only two uses
        /// of Accent, and they say the same thing (spec section 5C).
        /// </summary>
        private static GameObject UpdateDot(RectTransform parent)
        {
            GameObject dot = ElectronicUIKitBuilder.NewRect("UpdateDot", new Vector2(14f, 14f));
            ElectronicUIKitBuilder.AddFill(dot, KitInk.Accent);
            PlaceTopLeft(dot, parent, new Rect(962f, 8f, 14f, 14f));

            return dot;
        }

        // ------------------------------------------------------------------ frame and body

        private static RectTransform Frame(RectTransform parent)
        {
            GameObject frame = ElectronicUIKitBuilder.NewRect("Frame", Vector2.zero);
            frame.transform.SetParent(parent, false);
            RectTransform rect = (RectTransform)frame.transform;
            rect.anchorMin = Vector2.zero;
            rect.anchorMax = Vector2.one;
            rect.offsetMin = new Vector2(k_FrameLeft, k_FrameBottom);
            rect.offsetMax = new Vector2(-k_FrameRight, -k_FrameTop);
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

            return rect;
        }

        /// <summary>A hairline box with a label in it — the index box and the name field.</summary>
        private static ThemedText FieldBox(RectTransform parent, Rect area, string text,
            TextAlignmentOptions alignment)
        {
            GameObject box = ElectronicUIKitBuilder.NewRect("FieldBox", area.size);
            ElectronicUIKitBuilder.AddBorder(box, KitInk.Ink4, false);
            PlaceTopLeft(box, parent, area);

            GameObject label = ElectronicUIKitBuilder.MakeLabel("Label", text, KitInk.Ink5,
                KitType.Body, alignment);
            label.transform.SetParent(box.transform, false);
            ElectronicUIKitBuilder.Stretch((RectTransform)label.transform, 12f);

            return label.GetComponent<ThemedText>();
        }

        private static RectTransform PreviewBox(RectTransform cell)
        {
            GameObject box = ElectronicUIKitBuilder.NewRect("PreviewBox", Vector2.zero);
            box.transform.SetParent(cell, false);
            ElectronicUIKitBuilder.Stretch((RectTransform)box.transform, 20f);
            ElectronicUIKitBuilder.AddBorder(box, KitInk.Ink4, false);

            GameObject marks = ElectronicUIKitBuilder.MakeCornerMarks("CornerMarks");
            marks.transform.SetParent(box.transform, false);
            ElectronicUIKitBuilder.Stretch((RectTransform)marks.transform, 6f);
            ElectronicUIKitBuilder.SetInk(marks.GetComponent<KitCornerMarks>(), KitInk.Ink4);

            GameObject slot = ElectronicUIKitBuilder.NewRect("PreviewSlot", Vector2.zero);
            slot.transform.SetParent(box.transform, false);
            ElectronicUIKitBuilder.Stretch((RectTransform)slot.transform, 24f);

            return (RectTransform)slot.transform;
        }

        private static ThemedText BodyText(RectTransform cell)
        {
            GameObject label = ElectronicUIKitBuilder.MakeLabel("BodyText", string.Empty,
                KitInk.Ink5, KitType.Body, TextAlignmentOptions.TopLeft, KitCase.Family, false, true);
            label.transform.SetParent(cell, false);
            ElectronicUIKitBuilder.Stretch((RectTransform)label.transform, 20f);

            return label.GetComponent<ThemedText>();
        }

        // ------------------------------------------------------------------ controls

        /// <summary>
        /// A paging arrow, straddling the frame's edge as the sketch draws it. The glyph is an
        /// ASCII angle bracket rather than a triangle: Fusion Pixel has no arrow glyphs, and a faked
        /// triangle would be the one shape on the screen that is not a rectangle or a rule.
        /// </summary>
        private static Button Arrow(RectTransform parent, string glyph, float x)
        {
            GameObject arrow = ElectronicUIKitBuilder.NewRect("Arrow" + glyph, new Vector2(44f, 72f));
            PlaceTopLeft(arrow, parent, new Rect(x, k_Height * 0.5f - 36f, 44f, 72f));

            GameObject label = ElectronicUIKitBuilder.MakeLabel("Label", glyph, KitInk.Ink5,
                KitType.Display, TextAlignmentOptions.Center);
            label.transform.SetParent(arrow.transform, false);
            ElectronicUIKitBuilder.Stretch((RectTransform)label.transform, 0f);

            return Clickable(arrow);
        }

        private static Button ControlButton(RectTransform parent, Rect area, string glyph)
        {
            GameObject button = ElectronicUIKitBuilder.NewRect("Close", area.size);
            ElectronicUIKitBuilder.AddBorder(button, KitInk.Ink5, false);
            PlaceTopLeft(button, parent, area);

            GameObject label = ElectronicUIKitBuilder.MakeLabel("Label", glyph, KitInk.Ink5,
                KitType.Body, TextAlignmentOptions.Center);
            label.transform.SetParent(button.transform, false);
            ElectronicUIKitBuilder.Stretch((RectTransform)label.transform, 4f);

            return Clickable(button);
        }

        /// <summary>
        /// Makes an object clickable. Kit graphics all have raycastTarget off, so a button needs a
        /// catcher of its own; a fully transparent Image is plumbing rather than a visual, which is
        /// why it is allowed to carry a literal colour where the kit's rules otherwise forbid one.
        /// </summary>
        private static Button Clickable(GameObject go)
        {
            Image catcher = go.GetComponent<Image>();

            if (catcher == null)
            {
                GameObject hit = ElectronicUIKitBuilder.NewRect("Hit", Vector2.zero);
                hit.transform.SetParent(go.transform, false);
                ElectronicUIKitBuilder.Stretch((RectTransform)hit.transform, 0f);
                catcher = hit.AddComponent<Image>();
                catcher.color = Color.clear;
                catcher.raycastTarget = true;
            }

            Button button = go.AddComponent<Button>();
            button.transition = Selectable.Transition.None;
            button.targetGraphic = catcher;

            return button;
        }

        // ------------------------------------------------------------------ tabs

        /// <summary>
        /// One tab, built once and left inactive as the template the presenter clones. A template
        /// rather than three hand-placed rows: the counts are data, and the sketch's first option
        /// for the page strip makes the count grow at runtime.
        /// </summary>
        private static ScannerReportTab TabTemplate(string name, RectTransform parent, Vector2 size,
            TextAlignmentOptions alignment, KitType role, bool withDot)
        {
            GameObject tab = ElectronicUIKitBuilder.NewRect(name, size);
            tab.transform.SetParent(parent, false);
            ElectronicUIKitBuilder.AddBorder(tab, KitInk.Ink4, false);

            LayoutElement layout = tab.AddComponent<LayoutElement>();
            layout.preferredWidth = size.x;
            layout.preferredHeight = size.y;

            GameObject selected = ElectronicUIKitBuilder.NewRect("Selected", Vector2.zero);
            selected.transform.SetParent(tab.transform, false);
            ElectronicUIKitBuilder.Stretch((RectTransform)selected.transform, 2f);
            ElectronicUIKitBuilder.AddFill(selected, KitInk.Ink2);
            selected.SetActive(false);

            GameObject label = ElectronicUIKitBuilder.MakeLabel("Label", name, KitInk.Ink5, role,
                alignment);
            label.transform.SetParent(tab.transform, false);
            ElectronicUIKitBuilder.Stretch((RectTransform)label.transform, 4f);

            GameObject dot = null;

            if (withDot)
            {
                dot = ElectronicUIKitBuilder.NewRect("Dot", new Vector2(8f, 8f));
                dot.transform.SetParent(tab.transform, false);
                RectTransform dotRect = (RectTransform)dot.transform;
                dotRect.anchorMin = new Vector2(1f, 1f);
                dotRect.anchorMax = new Vector2(1f, 1f);
                dotRect.pivot = new Vector2(1f, 1f);
                dotRect.anchoredPosition = new Vector2(-2f, -2f);
                dotRect.sizeDelta = new Vector2(8f, 8f);
                ElectronicUIKitBuilder.AddFill(dot, KitInk.Accent);
                dot.SetActive(false);
            }

            Button button = Clickable(tab);
            ScannerReportTab component = tab.AddComponent<ScannerReportTab>();

            SerializedObject serialized = new SerializedObject(component);
            serialized.FindProperty("m_button").objectReferenceValue = button;
            serialized.FindProperty("m_label").objectReferenceValue = label.GetComponent<ThemedText>();
            serialized.FindProperty("m_selectedMark").objectReferenceValue = selected;
            serialized.FindProperty("m_updateDot").objectReferenceValue = dot;
            serialized.ApplyModifiedPropertiesWithoutUndo();

            tab.SetActive(false);

            return component;
        }

        // ------------------------------------------------------------------ wiring

        private static void Wire(GameObject report, ThemedText title, RectTransform sectionRail,
            ScannerReportTab sectionTemplate, RectTransform pageBar, ScannerReportTab pageTemplate,
            GameObject updateDot, ThemedText index, ThemedText name, ThemedText body,
            RectTransform functionBar, ScannerReportTab functionTemplate, RectTransform previewSlot,
            Button previous, Button next)
        {
            ScannerPreviewSlot slot = report.AddComponent<ScannerPreviewSlot>();
            SerializedObject slotSerialized = new SerializedObject(slot);
            slotSerialized.FindProperty("m_slot").objectReferenceValue = previewSlot;
            slotSerialized.ApplyModifiedPropertiesWithoutUndo();

            ScannerReportPresenter presenter = report.AddComponent<ScannerReportPresenter>();
            SerializedObject serialized = new SerializedObject(presenter);

            serialized.FindProperty("m_root").objectReferenceValue = report;
            serialized.FindProperty("m_reportTitle").objectReferenceValue = title;
            serialized.FindProperty("m_sectionRail").objectReferenceValue = sectionRail;
            serialized.FindProperty("m_sectionTabTemplate").objectReferenceValue = sectionTemplate;
            serialized.FindProperty("m_pageTabBar").objectReferenceValue = pageBar;
            serialized.FindProperty("m_pageTabTemplate").objectReferenceValue = pageTemplate;
            serialized.FindProperty("m_updateDot").objectReferenceValue = updateDot;
            serialized.FindProperty("m_indexLabel").objectReferenceValue = index;
            serialized.FindProperty("m_titleLabel").objectReferenceValue = name;
            serialized.FindProperty("m_bodyLabel").objectReferenceValue = body;
            serialized.FindProperty("m_functionTabBar").objectReferenceValue = functionBar;
            serialized.FindProperty("m_functionTabTemplate").objectReferenceValue = functionTemplate;
            serialized.FindProperty("m_previewSlot").objectReferenceValue = slot;
            serialized.FindProperty("m_closeButton").objectReferenceValue = FindClose(report);
            serialized.FindProperty("m_previousButton").objectReferenceValue = previous;
            serialized.FindProperty("m_nextButton").objectReferenceValue = next;

            SerializedProperty sections = serialized.FindProperty("m_sections");
            string[] guids = AssetDatabase.FindAssets("t:ScannerReportSectionSO",
                new[] { k_SectionFolder });
            string[] paths = new string[guids.Length];

            for (int i = 0; i < guids.Length; i++)
            {
                paths[i] = AssetDatabase.GUIDToAssetPath(guids[i]);
            }

            // By path, not by GUID: the assets are named 01/02/03 so that the rail comes out in the
            // designer's order, and GUIDs are random.
            System.Array.Sort(paths, System.StringComparer.Ordinal);
            sections.arraySize = paths.Length;

            for (int i = 0; i < paths.Length; i++)
            {
                sections.GetArrayElementAtIndex(i).objectReferenceValue =
                    AssetDatabase.LoadAssetAtPath<ScannerReportSectionSO>(paths[i]);
            }

            serialized.ApplyModifiedPropertiesWithoutUndo();
        }

        private static Button FindClose(GameObject report)
        {
            Transform close = report.transform.Find("Frame/Bands/Cell0/Close");

            return close == null ? null : close.GetComponent<Button>();
        }

        // ------------------------------------------------------------------ helpers

        private static RectTransform Row(string name, RectTransform parent, float inset,
            float spacing = 8f)
        {
            GameObject row = ElectronicUIKitBuilder.NewRect(name, Vector2.zero);
            row.transform.SetParent(parent, false);
            ElectronicUIKitBuilder.Stretch((RectTransform)row.transform, inset);

            HorizontalLayoutGroup layout = row.AddComponent<HorizontalLayoutGroup>();
            layout.spacing = spacing;
            layout.childControlWidth = false;
            layout.childControlHeight = false;
            layout.childForceExpandWidth = false;
            layout.childForceExpandHeight = false;
            layout.childAlignment = TextAnchor.MiddleLeft;

            return (RectTransform)row.transform;
        }

        private static void Fill(GameObject child, RectTransform parent)
        {
            child.transform.SetParent(parent, false);
            ElectronicUIKitBuilder.Stretch((RectTransform)child.transform, 0f);
            KitSplit split = child.GetComponent<KitSplit>();

            if (split != null)
            {
                split.Relayout();
            }
        }

        private static void PlaceTopLeft(GameObject go, RectTransform parent, Rect area)
        {
            go.transform.SetParent(parent, false);
            RectTransform rect = (RectTransform)go.transform;
            rect.anchorMin = new Vector2(0f, 1f);
            rect.anchorMax = new Vector2(0f, 1f);
            rect.pivot = new Vector2(0f, 1f);
            rect.sizeDelta = area.size;
            rect.anchoredPosition = new Vector2(area.x, -area.y);
        }

        private static void Relayout(GameObject root)
        {
            KitSplit[] splits = root.GetComponentsInChildren<KitSplit>(true);

            for (int i = 0; i < splits.Length; i++)
            {
                splits[i].Relayout();
            }
        }
    }
}
