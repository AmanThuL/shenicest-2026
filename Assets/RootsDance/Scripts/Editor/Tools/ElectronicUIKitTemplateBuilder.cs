using RootsDance.UI.Kit;
using TMPro;
using UnityEditor;
using UnityEngine;
using UnityEngine.UI;
using Object = UnityEngine.Object;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// The measured skeletons of docs/effects/电子类UI组件库规范.md §5B, saved as prefabs under
    /// Prefabs/UI/ElectronicKit/Templates/. Template_Archive and Template_Dossier are pixel replicas
    /// of the two archive reference screens — every band, seam, inner frame and row is placed at the
    /// coordinate measured off the source image, because the 2026-08-27 review showed that anything
    /// looser stops reading as the style. A new screen starts by copying one of these and swapping
    /// the cells' content.
    /// </summary>
    public static class ElectronicUIKitTemplateBuilder
    {
        private const string k_Templates = ElectronicUIKitBuilder.TemplateFolder;
        private const string k_Themes = ElectronicUIKitBuilder.ThemeFolder;

        [MenuItem("RootsDance/Build Electronic UI Templates")]
        public static void BuildTemplates()
        {
            ElectronicUIKitBuilder.EnsureFolder(k_Templates);

            Save(BuildArchive(), "Template_Archive");
            Save(BuildDossier(), "Template_Dossier");
            Save(BuildBrowser(), "Template_Browser");

            AssetDatabase.SaveAssets();
            Debug.Log($"Electronic UI templates built in {k_Templates}.");
        }

        // ------------------------------------------------------------------ Template_Archive
        // The police archive reference, measured at 736 x 961: frame (45,44)-(687,916); bands of
        // 53 / 350 / 142 / 326; one 29 px gutter after a 265 px left column, shared by ZoneA and
        // ZoneB; footer rows on a 40.7 px pitch. Every rule junction carries a node dot.
        private static GameObject BuildArchive()
        {
            GameObject root = NewScreen("Template_Archive", "Precinct", 736f, 961f);
            RectTransform frame = Frame(root, 45f, 44f, 49f, 45f, KitInk.Ink5);

            GameObject bands = ElectronicUIKitBuilder.MakeSplit("Bands", Vector2.zero,
                KitSplit.SplitAxis.Rows, new[] { 53f, 350f, 142f, 326f }, KitSplit.SeamStyle.Rule,
                -1, 0f, true);
            FillParent(bands, frame, 0f);

            // Header: heavy title left, status + battery right.
            RectTransform header = ElectronicUIKitBuilder.Cell(bands, 0);
            PlaceLabel(header, "POLICE LAPD", KitInk.Ink5, KitType.Display,
                TextAlignmentOptions.Left, 12f, 0f, 330f);
            PlaceLabel(header, "SIGNAL LOW", KitInk.Ink5, KitType.Body,
                TextAlignmentOptions.Right, -96f, 0f, 240f, fromRight: true);
            Battery(header, 642f - 88f, 14f, 74f, 26f);

            // ZoneA: the screen's single gutter seam. Left column of three shared-rule cells; the
            // right column is the one main image, flush to its cell on all four sides.
            GameObject zoneA = Columns(ElectronicUIKitBuilder.Cell(bands, 1),
                new[] { 265f, 348f }, 0, 29f);

            GameObject leftA = ElectronicUIKitBuilder.MakeSplit("LeftCuts", Vector2.zero,
                KitSplit.SplitAxis.Rows, new[] { 180f, 53f, 117f }, KitSplit.SeamStyle.Rule,
                -1, 0f, true);
            FillParent(leftA, ElectronicUIKitBuilder.Cell(zoneA, 0), 0f);

            GameObject prints = Columns(ElectronicUIKitBuilder.Cell(leftA, 0), new[] { 1f, 1f }, -1, 0f);
            Fingerprint(ElectronicUIKitBuilder.Cell(prints, 0), "L");
            Fingerprint(ElectronicUIKitBuilder.Cell(prints, 1), "R");

            RectTransform match = ElectronicUIKitBuilder.Cell(leftA, 1);
            PlaceLabel(match, "MATCH", KitInk.Ink4, KitType.Body, TextAlignmentOptions.Left,
                16f, 0f, 150f);
            TagBox(match, "F", new Rect(172f, 10f, 30f, 32f), KitInk.Ink5);
            TagBox(match, "M", new Rect(210f, 10f, 30f, 32f), KitInk.Ink3);

            RectTransform dna = ElectronicUIKitBuilder.Cell(leftA, 2);
            CellFill(dna, KitInk.Ink1);
            GameObject chips = ElectronicUIKitBuilder.MakeChipMosaic("Chips", 14, 6);
            Sparse(chips, 0.4f, 0.05f);
            Place(chips, dna, new Rect(8f, 8f, 249f, 101f), stretch: true, padTop: 8f);

            Place(ElectronicUIKitBuilder.MakePlate("EyePlate", "T_PlateIris",
                KitDitherPlate.DitherMode.Bayer4, 6, 3f, true, KitInk.Ink5, 7, true),
                ElectronicUIKitBuilder.Cell(zoneA, 1), Rect.zero, stretch: true);

            // The two red leader lines from the sample chips into the eye — with the warrant rows,
            // the reference's only accent, and its only diagonals.
            GameObject leaders = ElectronicUIKitBuilder.NewRect("Leaders", Vector2.zero);
            FillParent(leaders, frame, 0f);
            Leader(leaders, new[]
            {
                new Vector2(251f, 292f), new Vector2(590f, 292f), new Vector2(604f, 286f)
            }, 16f);
            Leader(leaders, new[]
            {
                new Vector2(251f, 327f), new Vector2(505f, 327f), new Vector2(540f, 302f)
            }, 0f);

            // ZoneB continues the same 265/29/348 cut, so both columns run through (spec §5C).
            GameObject zoneB = Columns(ElectronicUIKitBuilder.Cell(bands, 2),
                new[] { 265f, 348f }, 0, 29f);

            RectTransform ident = ElectronicUIKitBuilder.Cell(zoneB, 0);
            PlaceLabel(ident, "IDENT CONFIRM", KitInk.Ink4, KitType.Body,
                TextAlignmentOptions.TopLeft, 14f, 8f, 244f);
            PlaceLabel(ident, "N8-FBA71527", KitInk.Ink5, KitType.Body,
                TextAlignmentOptions.TopLeft, 14f, 44f, 244f);
            PlaceLabel(ident, "LOC RECORD", KitInk.Ink4, KitType.Body,
                TextAlignmentOptions.TopLeft, 14f, 96f, 200f);
            SlashBox(ident, new Rect(222f, 94f, 30f, 30f));

            RectTransform codes = ElectronicUIKitBuilder.Cell(zoneB, 1);
            PlaceLabel(codes, "DE 110 MM 33 DR 3", KitInk.Ink4, KitType.Body,
                TextAlignmentOptions.Left, 14f, 2f, 330f, height: 34f);
            string[] bases = { "G", "C", "A", "T" };

            for (int i = 0; i < 4; i++)
            {
                PlaceLabel(codes, bases[i], KitInk.Ink4, KitType.Micro,
                    TextAlignmentOptions.Left, 6f, 38f + i * 26f, 14f, height: 24f);
            }

            GameObject bars = ElectronicUIKitBuilder.MakeBarcode("Bars", 4);
            Place(bars, codes, new Rect(22f, 40f, 314f, 98f));

            // Footer: seven rows on the measured 40.7 pitch, dividers inset 17 px, the warrant on
            // the last two rows as the accent saying one thing twice.
            Place(ElectronicUIKitBuilder.MakeDataTable("Records",
                new[]
                {
                    "NAME", "INCEPT DATE", "FUNCTION", "PHYS STATE", "MENTAL STATE",
                    "ARREST STATUS", ""
                },
                new[]
                {
                    "MARLA ROWE", "07/15/2027", "MILITARY/ENGINEER", "LEV B", "LEV A",
                    "WARRANT NO 29772", "COUNTERFEITING/FRAUD"
                }, 5, KitInk.Ink4, KitInk.Ink5), ElectronicUIKitBuilder.Cell(bands, 3),
                new Rect(17f, 12f, 608f, 300f), stretch: true, padTop: 12f);

            Finish(root);

            return root;
        }

        // ------------------------------------------------------------------ Template_Dossier
        // The biology dossier reference, measured at 736 x 920: frame (55,54)-(682,872); bands of
        // 57 / 352 / 152 / 257. ZoneA is an equal 313/313 cut of inner-framed plates; ZoneB and
        // ZoneC share one seam 169 px in; the right side is stacked row boxes on a ~38 px pitch,
        // filled a step lighter than the ground. Node dots pin every junction.
        private static GameObject BuildDossier()
        {
            GameObject root = NewScreen("Template_Dossier", "Violet", 736f, 920f);
            RectTransform frame = Frame(root, 55f, 54f, 54f, 48f, KitInk.Ink4);

            GameObject bands = ElectronicUIKitBuilder.MakeSplit("Bands", Vector2.zero,
                KitSplit.SplitAxis.Rows, new[] { 57f, 352f, 152f, 257f }, KitSplit.SeamStyle.Rule,
                -1, 0f, true);
            FillParent(bands, frame, 0f);

            RectTransform header = ElectronicUIKitBuilder.Cell(bands, 0);
            PlaceLabel(header, "SUBJECT A-34", KitInk.Ink5, KitType.Display,
                TextAlignmentOptions.Left, 14f, 0f, 380f);
            Battery(header, 627f - 62f, 18f, 48f, 22f);

            // ZoneA: two equal cells, each holding an inner-framed plate — the eye study with its
            // three status dots against the circuit blueprint.
            GameObject zoneA = Columns(ElectronicUIKitBuilder.Cell(bands, 1),
                new[] { 313f, 313f }, -1, 0f);

            RectTransform eyeCell = ElectronicUIKitBuilder.Cell(zoneA, 0);
            Dot(eyeCell, 230f, 12f, KitInk.Ink4);
            Dot(eyeCell, 252f, 12f, KitInk.Ink4);
            Dot(eyeCell, 274f, 12f, KitInk.Ink4);
            FramedPlate(eyeCell, new Rect(18f, 39f, 284f, 287f), "T_PlateIris",
                KitDitherPlate.DitherMode.BlueNoise, 2, 2f, KitInk.Ink5);

            FramedPlate(ElectronicUIKitBuilder.Cell(zoneA, 1), new Rect(20f, 21f, 275f, 309f),
                "T_PlateCircuit", KitDitherPlate.DitherMode.Bayer2, 2, 2f, KitInk.Ink4);

            // ZoneB: the corner-bracketed fingerprint block against four stacked row boxes.
            GameObject zoneB = Columns(ElectronicUIKitBuilder.Cell(bands, 2),
                new[] { 169f, 458f }, -1, 0f);

            RectTransform printCell = ElectronicUIKitBuilder.Cell(zoneB, 0);
            Marks(printCell.gameObject, KitInk.Ink4, 10f);
            Place(ElectronicUIKitBuilder.MakePlate("Print", "T_PlateFinger",
                KitDitherPlate.DitherMode.BlueNoise, 2, 2f, false, KitInk.Ink4, 7, false),
                printCell, new Rect(30f, 14f, 108f, 124f));

            RowBoxes(ElectronicUIKitBuilder.Cell(zoneB, 1),
                new[] { "NAME", "INCEPT DATE", "FUNCTION", "MENTAL STATE" },
                new[] { "TORRA.TAHA", "03/05/2008", "DESIGNER", "UNSTABLE" });

            // ZoneC continues ZoneB's seam: the figure study against three more rows, the plot and
            // the micro data field.
            GameObject zoneC = Columns(ElectronicUIKitBuilder.Cell(bands, 3),
                new[] { 169f, 458f }, -1, 0f);

            FramedPlate(ElectronicUIKitBuilder.Cell(zoneC, 0), new Rect(16f, 18f, 137f, 221f),
                "T_PlateFigure", KitDitherPlate.DitherMode.BlueNoise, 2, 2f, KitInk.Ink4);

            GameObject readings = ElectronicUIKitBuilder.MakeSplit("Readings", Vector2.zero,
                KitSplit.SplitAxis.Rows, new[] { 112f, 145f }, KitSplit.SeamStyle.Rule, -1, 0f, true);
            FillParent(readings, ElectronicUIKitBuilder.Cell(zoneC, 1), 0f);

            RowBoxes(ElectronicUIKitBuilder.Cell(readings, 0),
                new[] { "LAST KNOWN LOCATION", "THREAT ASSESSMENT", "SPECIAL SKILLS" },
                new[] { "----", "* * *", "[PS]" });

            RectTransform plot = ElectronicUIKitBuilder.Cell(readings, 1);
            GameObject waveBox = BorderBox(plot, new Rect(21f, 8f, 433f, 62f), KitInk.Ink4);
            GameObject wave = ElectronicUIKitBuilder.MakeWaveform("Wave");
            SerializedObject waveSerialized = new SerializedObject(wave.GetComponent<KitWaveform>());
            waveSerialized.FindProperty("m_gridColumns").intValue = 26;
            waveSerialized.FindProperty("m_gridRows").intValue = 5;
            waveSerialized.ApplyModifiedPropertiesWithoutUndo();
            Place(wave, (RectTransform)waveBox.transform, new Rect(3f, 3f, 427f, 56f), stretch: true,
                padTop: 3f);

            PlaceLabel(plot, "A0 80SBN 70 2288Z 40 1093F 60 7867N 08 A662 3D 29971 55 40332 71 " +
                "B119 20 55871 09 3327D 44 90218 36 C660 12", KitInk.Ink4, KitType.Micro,
                TextAlignmentOptions.TopLeft, 21f, 76f, 433f, wrap: true, height: 64f);

            Finish(root);

            return root;
        }

        // ------------------------------------------------------------------ Template_Browser
        // The terminal browser reference, 679 x 831 — unchanged this round: the two archive screens
        // were re-measured first; this one keeps the fill-separated skeleton until its own pass.
        private static GameObject BuildBrowser()
        {
            GameObject root = NewScreen("Template_Browser", "Phosphor", 679f, 831f);

            GameObject wallpaper = ElectronicUIKitBuilder.MakeChipMosaic("Wallpaper", 22, 28);
            Place(wallpaper, (RectTransform)root.transform, Rect.zero, stretch: true);
            ElectronicUIKitBuilder.SetInk(wallpaper.GetComponent<KitChipMosaic>(), KitInk.Ink1);

            GameObject window = ElectronicUIKitBuilder.NewRect("Window", Vector2.zero);
            window.transform.SetParent(root.transform, false);
            RectTransform windowRect = (RectTransform)window.transform;
            windowRect.anchorMin = Vector2.zero;
            windowRect.anchorMax = Vector2.one;
            windowRect.offsetMin = new Vector2(16f, 11f);
            windowRect.offsetMax = new Vector2(-16f, -23f);
            ElectronicUIKitBuilder.AddFill(window, KitInk.Ink1);
            ElectronicUIKitBuilder.AddBorder(window, KitInk.Ink4, false);

            GameObject bands = ElectronicUIKitBuilder.MakeSplit("Bands", Vector2.zero,
                KitSplit.SplitAxis.Rows, new[] { 53f, 43f, 180f, 236f, 259f, 26f },
                KitSplit.SeamStyle.None, -1, 0f);
            FillParent(bands, windowRect, 0f);

            RectTransform tabBar = ElectronicUIKitBuilder.Cell(bands, 0);
            Tab(tabBar, "home", 10f, true);
            Tab(tabBar, "link", 126f, false);
            Tab(tabBar, "link", 242f, false);
            Dot(tabBar, 647f - 96f, 18f, KitInk.Ink5);
            Dot(tabBar, 647f - 66f, 18f, KitInk.Ink3);
            Dot(tabBar, 647f - 36f, 18f, KitInk.Ink2);

            RectTransform toolBar = ElectronicUIKitBuilder.Cell(bands, 1);
            PlaceLabel(toolBar, "<", KitInk.Ink5, KitType.Body, TextAlignmentOptions.Center,
                10f, 6f, 28f, casing: KitCase.Mixed, height: 32f);
            PlaceLabel(toolBar, ">", KitInk.Ink5, KitType.Body, TextAlignmentOptions.Center,
                42f, 6f, 28f, casing: KitCase.Mixed, height: 32f);
            PlaceLabel(toolBar, "@", KitInk.Ink5, KitType.Body, TextAlignmentOptions.Center,
                74f, 6f, 28f, casing: KitCase.Mixed, height: 32f);

            GameObject url = ElectronicUIKitBuilder.MakeBox("UrlField", new Vector2(420f, 31f), true,
                KitBox.CornerMask.All);
            SetBoxFill(url, KitInk.Ink0);
            Place(url, toolBar, new Rect(112f, 6f, 420f, 31f));
            PlaceLabel((RectTransform)url.transform, "type an url here...", KitInk.Ink3, KitType.Body,
                TextAlignmentOptions.Left, 14f, 0f, 380f, casing: KitCase.Mixed);

            TagBox(toolBar, "-", new Rect(647f - 74f, 6f, 30f, 31f), KitInk.Ink5);
            TagBox(toolBar, "x", new Rect(647f - 40f, 6f, 30f, 31f), KitInk.Ink5);

            Place(ElectronicUIKitBuilder.MakePlate("Banner", "T_PlateIris",
                KitDitherPlate.DitherMode.HalftoneRound, 2, 3f, false, KitInk.Ink4, 7, false),
                ElectronicUIKitBuilder.Cell(bands, 2), Rect.zero, stretch: true);

            GameObject zoneA = Columns(ElectronicUIKitBuilder.Cell(bands, 3), new[] { 63f, 37f }, -1, 0f,
                KitSplit.SeamStyle.None);
            CellFill(ElectronicUIKitBuilder.Cell(zoneA, 0), KitInk.Ink0);
            CellFill(ElectronicUIKitBuilder.Cell(zoneA, 1), KitInk.Ink0);

            RectTransform intro = ElectronicUIKitBuilder.Cell(zoneA, 0);
            PlaceLabel(intro, "Title goes here", KitInk.Ink4, KitType.Display,
                TextAlignmentOptions.Left, 18f, 8f, 380f, casing: KitCase.Mixed, italic: true,
                height: 52f);
            PlaceLabel(intro, "mini information about you, sed do eiusmod tempor incididunt ut labore.",
                KitInk.Ink3, KitType.Body, TextAlignmentOptions.TopLeft, 18f, 62f, 370f,
                casing: KitCase.Mixed, wrap: true, height: 60f);
            LinkButton(intro, 18f, 132f);
            LinkButton(intro, 210f, 132f);
            LinkButton(intro, 18f, 180f);
            LinkButton(intro, 210f, 180f);

            Place(ElectronicUIKitBuilder.MakePlate("SidePlate", "T_PlateCircuit",
                KitDitherPlate.DitherMode.HalftoneDiamond, 2, 3f, false, KitInk.Ink4, 7, false),
                ElectronicUIKitBuilder.Cell(zoneA, 1), new Rect(10f, 10f, 219f, 216f), stretch: true);

            GameObject zoneB = Columns(ElectronicUIKitBuilder.Cell(bands, 4), new[] { 38f, 62f }, -1, 0f,
                KitSplit.SeamStyle.None);
            CellFill(ElectronicUIKitBuilder.Cell(zoneB, 0), KitInk.Ink0);
            CellFill(ElectronicUIKitBuilder.Cell(zoneB, 1), KitInk.Ink0);

            Place(ElectronicUIKitBuilder.MakePlate("Portrait", "T_PlateRoot",
                KitDitherPlate.DitherMode.HalftoneLine, 2, 3f, false, KitInk.Ink4, 7, false),
                ElectronicUIKitBuilder.Cell(zoneB, 0), new Rect(10f, 10f, 226f, 239f), stretch: true);

            RectTransform about = ElectronicUIKitBuilder.Cell(zoneB, 1);
            GameObject aboutHead = ElectronicUIKitBuilder.MakeBox("AboutHead", new Vector2(381f, 36f),
                true, KitBox.CornerMask.All);
            SetBoxFill(aboutHead, KitInk.Ink2);
            Place(aboutHead, about, new Rect(10f, 10f, 381f, 36f), stretch: true, padTop: 10f,
                fixedHeight: 36f);
            PlaceLabel((RectTransform)aboutHead.transform, "About [Name]", KitInk.Ink5, KitType.Body,
                TextAlignmentOptions.Left, 14f, 0f, 280f, casing: KitCase.Mixed);
            PlaceLabel((RectTransform)aboutHead.transform, "v", KitInk.Ink5, KitType.Body,
                TextAlignmentOptions.Right, -14f, 0f, 40f, fromRight: true, casing: KitCase.Mixed);

            PlaceLabel(about, "lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do " +
                "eiusmod tempor incididunt ut labore et dolore magna aliqua. ut enim ad minim " +
                "veniam, quis nostrud exercitation.", KitInk.Ink3, KitType.Body,
                TextAlignmentOptions.TopLeft, 16f, 58f, 366f, casing: KitCase.Mixed, wrap: true,
                height: 130f);

            GameObject block = ElectronicUIKitBuilder.MakeButton("Block", "block", false);
            Place(block, about, new Rect(16f, 202f, 170f, 40f));
            GameObject add = ElectronicUIKitBuilder.MakeButton("Add", "+ add", true);
            Place(add, about, new Rect(200f, 202f, 170f, 40f));

            PlaceLabel(ElectronicUIKitBuilder.Cell(bands, 5), "by rootsdance.uwu", KitInk.Ink3,
                KitType.Micro, TextAlignmentOptions.Center, 0f, 0f, 640f, casing: KitCase.Mixed);

            Finish(root);

            return root;
        }

        // ------------------------------------------------------------------ shared pieces

        private static GameObject NewScreen(string name, string theme, float width, float height)
        {
            GameObject root = ElectronicUIKitBuilder.NewRect(name, new Vector2(width, height));

            ElectronicUIRoot uiRoot = root.AddComponent<ElectronicUIRoot>();
            SerializedObject serialized = new SerializedObject(uiRoot);
            serialized.FindProperty("m_theme").objectReferenceValue =
                AssetDatabase.LoadAssetAtPath<ElectronicUITheme>($"{k_Themes}/UITheme_{theme}.asset");
            serialized.ApplyModifiedPropertiesWithoutUndo();

            ElectronicUIKitBuilder.AddFill(root, KitInk.Ink0);

            return root;
        }

        /// <summary>The outer frame: strong border at the reference's measured inset, corner node
        /// dots, one per screen (spec §5C).</summary>
        private static RectTransform Frame(GameObject root, float left, float top, float right,
            float bottom, KitInk ink)
        {
            GameObject frame = ElectronicUIKitBuilder.NewRect("Frame", Vector2.zero);
            frame.transform.SetParent(root.transform, false);
            RectTransform rect = (RectTransform)frame.transform;
            rect.anchorMin = Vector2.zero;
            rect.anchorMax = Vector2.one;
            rect.offsetMin = new Vector2(left, bottom);
            rect.offsetMax = new Vector2(-right, -top);
            ElectronicUIKitBuilder.AddBorder(frame, ink, true);

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

        private static GameObject Columns(RectTransform parent, float[] weights, int gutterAfter,
            float gutterOverride, KitSplit.SeamStyle seam = KitSplit.SeamStyle.Rule)
        {
            GameObject split = ElectronicUIKitBuilder.MakeSplit("Columns", Vector2.zero,
                KitSplit.SplitAxis.Columns, weights, seam, gutterAfter, gutterOverride,
                seam == KitSplit.SeamStyle.Rule);
            FillParent(split, parent, 0f);

            return split;
        }

        /// <summary>Stacked bordered row boxes — the dossier's table idiom: each row a cell of a
        /// shared-rule split, filled one ramp step above the ground.</summary>
        private static void RowBoxes(RectTransform parent, string[] labels, string[] values)
        {
            GameObject rows = ElectronicUIKitBuilder.MakeSplit("Rows", Vector2.zero,
                KitSplit.SplitAxis.Rows, Weights(labels.Length), KitSplit.SeamStyle.Rule, -1, 0f);
            FillParent(rows, parent, 0f);

            for (int i = 0; i < labels.Length; i++)
            {
                RectTransform cell = ElectronicUIKitBuilder.Cell(rows, i);
                CellFill(cell, KitInk.Ink1);
                GameObject row = ElectronicUIKitBuilder.MakeDataRow($"Row{i}", labels[i], values[i],
                    false, KitInk.Ink4, KitInk.Ink5);
                Place(row, cell, new Rect(14f, 0f, 430f, 38f), stretch: true, padTop: 0f);
            }
        }

        private static float[] Weights(int count)
        {
            float[] weights = new float[count];

            for (int i = 0; i < count; i++)
            {
                weights[i] = 1f;
            }

            return weights;
        }

        private static void FillParent(GameObject child, RectTransform parent, float inset)
        {
            child.transform.SetParent(parent, false);
            ElectronicUIKitBuilder.Stretch((RectTransform)child.transform, inset);
            KitSplit split = child.GetComponent<KitSplit>();

            if (split != null)
            {
                split.Relayout();
            }
        }

        /// <summary>
        /// Places a child by its top-left corner inside a cell. With <paramref name="stretch"/> the
        /// child keeps its left/top/right offsets but follows the cell's bottom; a
        /// <paramref name="fixedHeight"/> pins the height instead.
        /// </summary>
        private static void Place(GameObject go, RectTransform parent, Rect area,
            bool stretch = false, float padTop = -1f, float fixedHeight = 0f)
        {
            go.transform.SetParent(parent, false);
            RectTransform rect = (RectTransform)go.transform;

            if (!stretch)
            {
                rect.anchorMin = new Vector2(0f, 1f);
                rect.anchorMax = new Vector2(0f, 1f);
                rect.pivot = new Vector2(0f, 1f);
                rect.sizeDelta = new Vector2(area.width, area.height);
                rect.anchoredPosition = new Vector2(area.x, -area.y);
                return;
            }

            float top = padTop >= 0f ? padTop : area.y;

            if (fixedHeight > 0f)
            {
                rect.anchorMin = new Vector2(0f, 1f);
                rect.anchorMax = new Vector2(1f, 1f);
                rect.pivot = new Vector2(0.5f, 1f);
                rect.offsetMin = new Vector2(area.x, -top - fixedHeight);
                rect.offsetMax = new Vector2(-area.x, -top);
                return;
            }

            rect.anchorMin = Vector2.zero;
            rect.anchorMax = Vector2.one;
            rect.offsetMin = new Vector2(area.x, area.x);
            rect.offsetMax = new Vector2(-area.x, -top);
        }

        private static void PlaceLabel(RectTransform parent, string text, KitInk ink, KitType role,
            TextAlignmentOptions alignment, float x, float y, float width,
            bool fromRight = false, KitCase casing = KitCase.Family, bool italic = false,
            bool wrap = false, float height = 0f)
        {
            GameObject label = ElectronicUIKitBuilder.MakeLabel("Label", text, ink, role, alignment,
                casing, italic, wrap);
            label.transform.SetParent(parent, false);
            RectTransform rect = (RectTransform)label.transform;
            float h = height > 0f ? height : 40f;

            if (y <= 0f && !wrap && height <= 0f)
            {
                rect.anchorMin = fromRight ? new Vector2(1f, 0f) : new Vector2(0f, 0f);
                rect.anchorMax = fromRight ? new Vector2(1f, 1f) : new Vector2(0f, 1f);
                rect.pivot = new Vector2(fromRight ? 1f : 0f, 0.5f);
                rect.sizeDelta = new Vector2(width, 0f);
                rect.anchoredPosition = new Vector2(x, 0f);
                return;
            }

            rect.anchorMin = new Vector2(fromRight ? 1f : 0f, 1f);
            rect.anchorMax = rect.anchorMin;
            rect.pivot = new Vector2(fromRight ? 1f : 0f, 1f);
            rect.sizeDelta = new Vector2(width, h);
            rect.anchoredPosition = new Vector2(x, -y);
        }

        /// <summary>A hairline box with a centred glyph — the L/R fingerprint tags, the F/M toggles,
        /// the browser's window controls.</summary>
        private static void TagBox(RectTransform parent, string label, Rect area, KitInk ink)
        {
            GameObject box = ElectronicUIKitBuilder.NewRect("TagBox", area.size);
            ElectronicUIKitBuilder.AddBorder(box, ink, false);

            if (!string.IsNullOrEmpty(label))
            {
                GameObject text = ElectronicUIKitBuilder.MakeLabel("Label", label, ink, KitType.Body,
                    TextAlignmentOptions.Center);
                text.transform.SetParent(box.transform, false);
                ElectronicUIKitBuilder.Stretch((RectTransform)text.transform, 2f);
            }

            Place(box, parent, area);
        }

        /// <summary>The LOC RECORD checkbox: a hairline box with a diagonal stroke.</summary>
        private static void SlashBox(RectTransform parent, Rect area)
        {
            GameObject box = ElectronicUIKitBuilder.NewRect("SlashBox", area.size);
            ElectronicUIKitBuilder.AddBorder(box, KitInk.Ink4, false);

            GameObject slash = ElectronicUIKitBuilder.NewRect("Slash", area.size);
            slash.transform.SetParent(box.transform, false);
            ElectronicUIKitBuilder.Stretch((RectTransform)slash.transform, 0f);
            KitLeader line = slash.AddComponent<KitLeader>();
            line.raycastTarget = false;
            ElectronicUIKitBuilder.SetInk(line, KitInk.Ink4);
            SerializedObject serialized = new SerializedObject(line);
            serialized.FindProperty("m_startSquare").floatValue = 0f;
            serialized.FindProperty("m_targetBox").floatValue = 0f;
            SerializedProperty points = serialized.FindProperty("m_points");
            points.arraySize = 2;
            points.GetArrayElementAtIndex(0).vector2Value = new Vector2(5f, area.height - 5f);
            points.GetArrayElementAtIndex(1).vector2Value = new Vector2(area.width - 5f, 5f);
            serialized.ApplyModifiedPropertiesWithoutUndo();

            Place(box, parent, area);
        }

        private static void Leader(GameObject overlay, Vector2[] points, float targetBox)
        {
            GameObject line = ElectronicUIKitBuilder.NewRect("Leader", Vector2.zero);
            line.transform.SetParent(overlay.transform, false);
            ElectronicUIKitBuilder.Stretch((RectTransform)line.transform, 0f);
            KitLeader leader = line.AddComponent<KitLeader>();
            leader.raycastTarget = false;
            ElectronicUIKitBuilder.SetInk(leader, KitInk.Accent);
            SerializedObject serialized = new SerializedObject(leader);
            serialized.FindProperty("m_targetBox").floatValue = targetBox;
            SerializedProperty list = serialized.FindProperty("m_points");
            list.arraySize = points.Length;

            for (int i = 0; i < points.Length; i++)
            {
                list.GetArrayElementAtIndex(i).vector2Value = points[i];
            }

            serialized.ApplyModifiedPropertiesWithoutUndo();
        }

        /// <summary>A battery meter: hairline shell, segment fill, terminal nub.</summary>
        private static void Battery(RectTransform parent, float x, float y, float width, float height)
        {
            GameObject shell = ElectronicUIKitBuilder.NewRect("Battery", new Vector2(width, height));
            ElectronicUIKitBuilder.AddBorder(shell, KitInk.Ink5, false);

            GameObject bar = ElectronicUIKitBuilder.MakeSegmentBar("Charge", 4, 0.8f);
            bar.transform.SetParent(shell.transform, false);
            ElectronicUIKitBuilder.Stretch((RectTransform)bar.transform, 4f);
            ElectronicUIKitBuilder.SetInk(bar.GetComponent<KitSegmentBar>(), KitInk.Ink5);

            GameObject nub = ElectronicUIKitBuilder.NewRect("Nub", new Vector2(4f, height * 0.4f));
            nub.transform.SetParent(shell.transform, false);
            RectTransform nubRect = (RectTransform)nub.transform;
            nubRect.anchorMin = new Vector2(1f, 0.5f);
            nubRect.anchorMax = new Vector2(1f, 0.5f);
            nubRect.pivot = new Vector2(0f, 0.5f);
            nubRect.anchoredPosition = new Vector2(1f, 0f);
            Image nubImage = nub.AddComponent<Image>();
            nubImage.raycastTarget = false;
            ThemedGraphic nubThemed = nub.AddComponent<ThemedGraphic>();
            SerializedObject serialized = new SerializedObject(nubThemed);
            serialized.FindProperty("m_ink").enumValueIndex = (int)KitInk.Ink5;
            serialized.ApplyModifiedPropertiesWithoutUndo();

            Place(shell, parent, new Rect(x, y, width, height));
        }

        private static void Fingerprint(RectTransform cell, string tag)
        {
            TagBox(cell, tag, new Rect(8f, 8f, 26f, 26f), KitInk.Ink5);
            Place(ElectronicUIKitBuilder.MakePlate("Print", "T_PlateFinger",
                KitDitherPlate.DitherMode.Bayer2, 2, 2f, false, KitInk.Ink4, 7, false), cell,
                new Rect(14f, 40f, 104f, 132f));
        }

        /// <summary>A hairline inner frame holding a dithered plate — the dossier's plate idiom.</summary>
        private static void FramedPlate(RectTransform cell, Rect area, string texture,
            KitDitherPlate.DitherMode mode, int levels, float pixelSize, KitInk highInk)
        {
            GameObject box = BorderBox(cell, area, KitInk.Ink4);
            Place(ElectronicUIKitBuilder.MakePlate("Plate", texture, mode, levels, pixelSize, false,
                highInk, 7, false), (RectTransform)box.transform,
                new Rect(3f, 3f, area.width - 6f, area.height - 6f), stretch: true, padTop: 3f);
        }

        private static GameObject BorderBox(RectTransform parent, Rect area, KitInk ink)
        {
            GameObject box = ElectronicUIKitBuilder.NewRect("Box", area.size);
            ElectronicUIKitBuilder.AddBorder(box, ink, false);
            Place(box, parent, area);

            return box;
        }

        private static void Tab(RectTransform bar, string label, float x, bool active)
        {
            GameObject tab = ElectronicUIKitBuilder.MakeBox("Tab", new Vector2(108f, 40f), active,
                KitBox.CornerMask.TopLeft | KitBox.CornerMask.TopRight);

            if (active)
            {
                SetBoxFill(tab, KitInk.Ink2);
            }

            GameObject text = ElectronicUIKitBuilder.MakeLabel("Label", label,
                active ? KitInk.Ink5 : KitInk.Ink3, KitType.Body, TextAlignmentOptions.Center,
                KitCase.Mixed);
            text.transform.SetParent(tab.transform, false);
            ElectronicUIKitBuilder.Stretch((RectTransform)text.transform, 2f);

            tab.transform.SetParent(bar, false);
            RectTransform rect = (RectTransform)tab.transform;
            rect.anchorMin = new Vector2(0f, 0f);
            rect.anchorMax = new Vector2(0f, 0f);
            rect.pivot = new Vector2(0f, 0f);
            rect.sizeDelta = new Vector2(108f, 40f);
            rect.anchoredPosition = new Vector2(x, 0f);
        }

        /// <summary>A small solid dot; radius override makes it a circle regardless of family.</summary>
        private static void Dot(RectTransform parent, float x, float y, KitInk ink)
        {
            GameObject dot = ElectronicUIKitBuilder.MakeBox("Dot", new Vector2(16f, 16f), true,
                KitBox.CornerMask.All);
            SetBoxFill(dot, ink);
            SerializedObject serialized = new SerializedObject(dot.GetComponent<KitBox>());
            serialized.FindProperty("m_radiusOverride").floatValue = 8f;
            serialized.ApplyModifiedPropertiesWithoutUndo();
            Place(dot, parent, new Rect(x, y, 16f, 16f));
        }

        private static void LinkButton(RectTransform parent, float x, float y)
        {
            GameObject button = ElectronicUIKitBuilder.MakeButton("Link", "link", false);
            Place(button, parent, new Rect(x, y, 178f, 38f));
        }

        private static void SetBoxFill(GameObject box, KitInk ink)
        {
            SerializedObject serialized = new SerializedObject(box.GetComponent<KitBox>());
            serialized.FindProperty("m_fill").boolValue = true;
            serialized.FindProperty("m_fillInk").enumValueIndex = (int)ink;
            serialized.ApplyModifiedPropertiesWithoutUndo();
        }

        private static void CellFill(RectTransform cell, KitInk ink)
        {
            GameObject fill = ElectronicUIKitBuilder.NewRect("Fill", Vector2.zero);
            fill.transform.SetParent(cell, false);
            fill.transform.SetAsFirstSibling();
            ElectronicUIKitBuilder.Stretch((RectTransform)fill.transform, 0f);

            Image image = fill.AddComponent<Image>();
            image.raycastTarget = false;

            ThemedGraphic themed = fill.AddComponent<ThemedGraphic>();
            SerializedObject serialized = new SerializedObject(themed);
            serialized.FindProperty("m_ink").enumValueIndex = (int)ink;
            serialized.ApplyModifiedPropertiesWithoutUndo();
        }

        private static void Marks(GameObject target, KitInk ink, float inset)
        {
            GameObject marks = ElectronicUIKitBuilder.NewRect("CornerMarks", Vector2.zero);
            marks.transform.SetParent(target.transform, false);
            ElectronicUIKitBuilder.Stretch((RectTransform)marks.transform, inset);
            KitCornerMarks corner = marks.AddComponent<KitCornerMarks>();
            corner.raycastTarget = false;
            ElectronicUIKitBuilder.SetInk(corner, ink);
        }

        private static void Sparse(GameObject chips, float occupancy, float highlight)
        {
            SerializedObject serialized = new SerializedObject(chips.GetComponent<KitChipMosaic>());
            serialized.FindProperty("m_occupancy").floatValue = occupancy;
            serialized.FindProperty("m_highlightChance").floatValue = highlight;
            serialized.ApplyModifiedPropertiesWithoutUndo();
        }

        /// <summary>Relayouts every split top-down once the whole tree exists, so nested cells settle
        /// before the prefab is serialised.</summary>
        private static void Finish(GameObject root)
        {
            KitSplit[] splits = root.GetComponentsInChildren<KitSplit>(true);

            for (int i = 0; i < splits.Length; i++)
            {
                splits[i].Relayout();
            }
        }

        private static void Save(GameObject go, string name)
        {
            PrefabUtility.SaveAsPrefabAsset(go, $"{k_Templates}/{name}.prefab");
            Object.DestroyImmediate(go);
        }
    }
}
