using RootsDance.UI.Kit;
using TMPro;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem.UI;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using Object = UnityEngine.Object;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Three screens assembled out of the kit, as the test of whether
    /// docs/effects/电子类UI组件库规范.md is prescriptive enough to generate rather than to copy.
    /// <para>
    /// None of them reproduces a reference. They deliberately differ on every axis the spec says is
    /// free — theme, aspect, block count, which of §5B's three cuts the body uses, and which dither
    /// family the plates run — while obeying everything §5C says is fixed. If they read as one family
    /// anyway, the spec carries the style; if they only read as one family when they copy a reference,
    /// it does not.
    /// </para>
    /// </summary>
    public static class ElectronicUIKitDemoBuilder
    {
        private const string k_Folder = "Assets/_Sandbox/UISandboxDemo";
        private const string k_Kit = ElectronicUIKitBuilder.KitFolder;
        private const string k_Themes = ElectronicUIKitBuilder.ThemeFolder;

        [MenuItem("RootsDance/Build Electronic UI Demos")]
        public static void Build()
        {
            ElectronicUIKitBuilder.EnsureFolder(k_Folder);

            // The scene has to exist before the screens do: NewScene destroys everything in the open
            // scene, and screens built beforehand would be dead by the time they were parented.
            Scene scene = NewScene();
            RectTransform canvas = BuildCanvas(scene);

            GameObject[] screens = { BuildArchive(), BuildGerminationLog(), BuildFieldUnit() };
            float x = 40f;

            for (int i = 0; i < screens.Length; i++)
            {
                RectTransform rect = screens[i].GetComponent<RectTransform>();
                Vector2 size = rect.sizeDelta;
                Place(screens[i], canvas, x, 40f, size.x, size.y);
                x += size.x + 40f;

                ElectronicUIRoot root = screens[i].GetComponent<ElectronicUIRoot>();

                if (root != null)
                {
                    root.ApplyTheme();
                }
            }

            EditorSceneManager.SaveScene(scene, $"{k_Folder}/Test_ElectronicUI.unity");

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
            Debug.Log("Electronic UI demo screens built. Open Test_ElectronicUI.unity.");
        }

        // ------------------------------------------------------------------ screen A
        // §5B "narrow + wide": a stack of small readings on the left against one large plate on the
        // right, so the eye goes from fragments to the whole. Precinct, landscape, 9 blocks (§5D mid).
        private static GameObject BuildArchive()
        {
            const float w = 1280f;
            const float h = 720f;
            GameObject root = NewScreen("Screen_SpecimenArchive", "Precinct", w, h);
            RectTransform body = Body(root, w, h, "ROOTS/BOTANY — SPECIMEN ARCHIVE", "LINK OK");

            float inset = 64f;
            float top = 104f;
            float gut = 16f;
            float left = inset;
            float colW = 300f;
            float rightX = left + colW + gut;
            float rightW = w - inset - rightX;

            Place(Kit("ChipMosaic"), body, left, top, colW, 110f);
            Place(Plate("T_PlateRoot", KitDitherPlate.DitherMode.Bayer8, 4, 2f, false),
                body, left, top + 126f, colW, 180f);
            Place(Table(new[] { "SAMPLE", "DEPTH", "MEDIUM" },
                new[] { "RD-0447", "110 MM", "LOAM" }, -1), body, left, top + 322f, colW, 120f);
            Place(Kit("SegmentBar"), body, left, top + 458f, colW, 16f);

            Place(Plate("T_PlateIris", KitDitherPlate.DitherMode.Bayer4, 6, 3f, true),
                body, rightX, top, rightW, 320f);
            Place(Kit("BarcodeRows"), body, rightX, top + 336f, rightW, 100f);
            Place(Readout("0447", "SPECIMEN ID"), body, rightX, top + 452f, rightW, 60f);

            // §5C caps the accent at two places saying one thing: both of these are the same fault.
            Place(Table(new[] { "PHYS STATE", "VIABILITY", "CONTAINMENT" },
                new[] { "LEV B", "62%", "BREACHED" }, 2), body, left, 560f, w - inset * 2f, 120f);

            return root;
        }

        // ------------------------------------------------------------------ screen B
        // §5B "equal + full width": every row cut differently, ending on one full-width plot.
        // Phosphor, portrait, 8 blocks. Halftone plates rather than Bayer — the same layout under a
        // different screen family should still be recognisable as the kit.
        private static GameObject BuildGerminationLog()
        {
            const float w = 720f;
            const float h = 960f;
            GameObject root = NewScreen("Screen_GerminationLog", "Phosphor", w, h);
            RectTransform body = Body(root, w, h, "GERMINATION LOG", "CYCLE 12");

            float inset = 48f;
            float top = 104f;
            float gut = 16f;
            float half = (w - inset * 2f - gut) * 0.5f;

            Place(Plate("T_PlateRoot", KitDitherPlate.DitherMode.HalftoneDiamond, 2, 3f, false),
                body, inset, top, half, 200f);
            Place(Plate("T_PlateIris", KitDitherPlate.DitherMode.HalftoneLine, 2, 4f, false),
                body, inset + half + gut, top, half, 200f);

            Place(Table(new[] { "STRAIN", "SOWN", "SPROUTED", "MEAN HEIGHT", "LOSS" },
                new[] { "WR-09", "03/05", "88 / 96", "41 MM", "8" }, -1),
                body, inset, top + 216f, w - inset * 2f, 200f);

            Place(Kit("ChipMosaic"), body, inset, top + 432f, half, 110f);
            Place(Plate("T_PlateCircuit", KitDitherPlate.DitherMode.HalftoneRound, 2, 3f, true),
                body, inset + half + gut, top + 432f, half, 110f);

            Place(Kit("Waveform"), body, inset, top + 558f, w - inset * 2f, 150f);

            GameObject buttons = ElectronicUIKitBuilder.NewRect("Actions", new Vector2(w, 40f));
            HorizontalLayoutGroup layout = buttons.AddComponent<HorizontalLayoutGroup>();
            layout.spacing = gut;
            layout.childControlWidth = true;
            layout.childForceExpandWidth = true;
            Nest(Kit("Button"), buttons.transform);
            Nest(Kit("ButtonSolid"), buttons.transform);
            Place(buttons, body, inset, top + 726f, w - inset * 2f, 40f);

            return root;
        }

        // ------------------------------------------------------------------ screen C
        // §5D's small tier: four blocks, nothing more. Violet, narrow portrait, blue-noise plate. The
        // interesting case for the spec — the same rules at a size where there is no room to compose.
        private static GameObject BuildFieldUnit()
        {
            const float w = 460f;
            const float h = 820f;
            GameObject root = NewScreen("Screen_FieldUnit", "Violet", w, h);
            RectTransform body = Body(root, w, h, "FIELD UNIT", "A-34");

            float inset = 32f;
            float top = 96f;
            float inner = w - inset * 2f;

            Place(Plate("T_PlateIris", KitDitherPlate.DitherMode.BlueNoise, 2, 2f, false),
                body, inset, top, inner, 300f);
            Place(Table(new[] { "OPERATOR", "FUNCTION", "STATE" },
                new[] { "TORRA", "SURVEY", "NOMINAL" }, -1), body, inset, top + 320f, inner, 120f);
            Place(Kit("SegmentBar"), body, inset, top + 460f, inner, 20f);
            Place(Readout("A-34", "UNIT"), body, inset, top + 500f, inner, 60f);

            return root;
        }

        // ------------------------------------------------------------------ helpers

        private static GameObject NewScreen(string name, string theme, float width, float height)
        {
            GameObject root = new GameObject(name, typeof(RectTransform));
            root.layer = LayerMask.NameToLayer("UI");
            RectTransform rect = root.GetComponent<RectTransform>();
            rect.sizeDelta = new Vector2(width, height);

            ElectronicUIRoot uiRoot = root.AddComponent<ElectronicUIRoot>();
            SerializedObject serialized = new SerializedObject(uiRoot);
            serialized.FindProperty("m_theme").objectReferenceValue =
                AssetDatabase.LoadAssetAtPath<ElectronicUITheme>($"{k_Themes}/UITheme_{theme}.asset");
            serialized.ApplyModifiedPropertiesWithoutUndo();

            return root;
        }

        /// <summary>
        /// The §5A skeleton every screen shares: one ground, one strong outer frame with corner marks,
        /// one title bar, and a body rect that everything else is placed into.
        /// </summary>
        private static RectTransform Body(GameObject root, float width, float height, string title,
            string status)
        {
            ElectronicUIKitBuilder.AddFill(root, KitInk.Ink0);

            GameObject frame = ElectronicUIKitBuilder.NewRect("Frame", Vector2.zero);
            frame.transform.SetParent(root.transform, false);
            ElectronicUIKitBuilder.Stretch(frame.GetComponent<RectTransform>(), 32f);
            ElectronicUIKitBuilder.AddBorder(frame, KitInk.Ink4, true);

            GameObject marks = ElectronicUIKitBuilder.NewRect("CornerMarks", Vector2.zero);
            marks.transform.SetParent(frame.transform, false);
            ElectronicUIKitBuilder.Stretch(marks.GetComponent<RectTransform>(), -8f);
            KitCornerMarks corner = marks.AddComponent<KitCornerMarks>();
            corner.raycastTarget = false;
            ElectronicUIKitBuilder.SetInk(corner, KitInk.Ink3);

            GameObject bar = ElectronicUIKitBuilder.MakeTitleBar("TitleBar", title, status);
            Place(bar, (RectTransform)root.transform, 32f, 32f, width - 64f, 40f);

            return (RectTransform)root.transform;
        }

        /// <summary>Places a child by top-left corner in screen coordinates, which is how a layout reads.</summary>
        private static void Place(GameObject go, RectTransform parent, float x, float y, float w, float h)
        {
            go.transform.SetParent(parent, false);
            RectTransform rect = go.GetComponent<RectTransform>();
            rect.anchorMin = new Vector2(0f, 1f);
            rect.anchorMax = new Vector2(0f, 1f);
            rect.pivot = new Vector2(0f, 1f);
            rect.sizeDelta = new Vector2(w, h);
            rect.anchoredPosition = new Vector2(x, -y);
        }

        private static GameObject Kit(string prefab)
        {
            GameObject asset = AssetDatabase.LoadAssetAtPath<GameObject>($"{k_Kit}/{prefab}.prefab");

            if (asset == null)
            {
                Debug.LogError($"Kit prefab {prefab} missing — run RootsDance > Build Electronic UI Kit.");
                return ElectronicUIKitBuilder.NewRect(prefab, new Vector2(100f, 40f));
            }

            return (GameObject)PrefabUtility.InstantiatePrefab(asset);
        }

        /// <summary>Parents an already-instantiated object. Named away from Object.Instantiate on
        /// purpose: an identically-shaped overload of that name is a trap to read.</summary>
        private static GameObject Nest(GameObject child, Transform parent)
        {
            child.transform.SetParent(parent, false);
            return child;
        }

        private static GameObject Plate(string texture, KitDitherPlate.DitherMode mode, int levels,
            float pixelSize, bool reticle)
        {
            return ElectronicUIKitBuilder.MakePlate("Plate", texture, mode, levels, pixelSize, reticle);
        }

        private static GameObject Table(string[] labels, string[] values, int alarmFrom)
        {
            return ElectronicUIKitBuilder.MakeDataTable("Table", labels, values, alarmFrom);
        }

        private static GameObject Readout(string value, string caption)
        {
            return ElectronicUIKitBuilder.MakeReadout("Readout", value, caption);
        }

        private static Scene NewScene()
        {
            Scene scene = EditorSceneManager.NewScene(NewSceneSetup.DefaultGameObjects, NewSceneMode.Single);

            GameObject eventSystem = new GameObject("EventSystem", typeof(EventSystem),
                typeof(InputSystemUIInputModule));
            SceneManager.MoveGameObjectToScene(eventSystem, scene);

            return scene;
        }

        private static RectTransform BuildCanvas(Scene scene)
        {
            GameObject canvasObject = new GameObject("Canvas", typeof(RectTransform), typeof(Canvas),
                typeof(CanvasScaler), typeof(GraphicRaycaster));
            canvasObject.layer = LayerMask.NameToLayer("UI");
            SceneManager.MoveGameObjectToScene(canvasObject, scene);

            Canvas canvas = canvasObject.GetComponent<Canvas>();
            canvas.renderMode = RenderMode.ScreenSpaceOverlay;

            // Constant pixel size: the kit's rules are specified in pixels and have to stay there.
            CanvasScaler scaler = canvasObject.GetComponent<CanvasScaler>();
            scaler.uiScaleMode = CanvasScaler.ScaleMode.ConstantPixelSize;
            scaler.scaleFactor = 1f;

            return (RectTransform)canvasObject.transform;
        }
    }
}
