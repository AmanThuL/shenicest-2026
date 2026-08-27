using System.IO;
using RootsDance.UI;
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
    /// Builds the B-roll sandbox — the cold three-panel data screen of
    /// docs/effects/低保真终端式UI规范.md §10-§15 — into Assets/_Sandbox/UISandboxDemo, so the
    /// composition can be judged on its own before anything depends on it. Everything it writes is
    /// generated here; nothing is traced from the reference sequence.
    /// <para>
    /// It reuses the boot screen's architecture unchanged: one orthographic camera renders a
    /// low-resolution canvas into a RenderTexture, and one full-screen RawImage composites it. The
    /// only difference between the two families at the material level is <c>_GrainGate</c>.
    /// </para>
    /// </summary>
    public static class DataScreenBuilder
    {
        private const string k_SandboxFolder = "Assets/_Sandbox/UISandboxDemo";
        private const string k_CompositeShader = "RootsDance/UI/TerminalComposite";

        private const int k_BufferWidth = 640;
        private const int k_BufferHeight = 360;

        // §11, rescaled. The reference frame is 2.81:1 and this buffer is 16:9, so the two cannot both
        // be satisfied: keeping the panels' own aspect would push the row of three wider than the
        // screen. What is kept is the horizontal composition (0.101 margin / 0.198 side / 0.066 gap /
        // 0.270 centre of the width) and the cell pitch, both measured; the extra height is spent on
        // more rows rather than on taller cells. Stretching the cells instead would break the one
        // metric §11 flags as easiest to lose - the glyph filling only half its cell's height.
        private const float k_SideWidth = 127f;
        private const float k_SideHeight = 256f;
        private const float k_SideTop = 81f;
        private const float k_Gap = 42f;
        private const float k_CentreWidth = 173f;
        private const float k_CentreTop = 28f;

        // Past the bottom edge: §11's centre panel is taller than the side panels and runs off the
        // frame, and that "does not fit" is where the composition comes from.
        private const float k_CentreHeight = 340f;

        private const int k_CentreColumns = 39;
        private const int k_CentreRows = 37;

        /// <summary>
        /// Row the centre panel's name sits on. §13 puts it 58.6% down the reference frame; on this
        /// grid that is row 19 of 37, counting from the panel's top.
        /// </summary>
        private const int k_LabelRow = 19;
        private const int k_SideColumns = 14;
        private const int k_SideRows = 14;

        /// <summary>
        /// Centre cell 17x36 px on the 2464-wide reference frame, in buffer pixels. The side panels
        /// reuse it at dot scale 2, which doubles it - §11 measures the side cell at 1.94 x 1.75 the
        /// centre one, so one pitch serves both. A 3x5 glyph in a 4x9 cell fills 75% of its width and
        /// 56% of its height, against the reference's 67% and 52%.
        /// </summary>
        private static readonly Vector2Int k_CellPitch = new Vector2Int(4, 9);

        // §12. The ground is green-dominant and the type is blue-dominant; that opposition is what
        // keeps the dark end reading as afterglow rather than as a dimmed blue picture.
        private static readonly Color k_Surround = Hex(0x000000);
        private static readonly Color k_CentreGround = Hex(0x091C16);
        private static readonly Color k_SideGround = Hex(0x061210);
        private static readonly Color k_CentreDim = Hex(0x113650);
        private static readonly Color k_CentreBright = Hex(0x98D3E6);
        private static readonly Color k_SideDim = Hex(0x193454);
        private static readonly Color k_SideBright = Hex(0x7DC6EF);
        private static readonly Color k_Label = Hex(0x98D3E6);
        // Authored darker than §12's measured #18A8B5 on purpose. The flood fills the panel with a
        // field bright enough to clear the composite's bright-pass threshold, so the glow adds to it
        // where it adds nothing to a dark ground; feeding the measured value straight in lands the
        // screen 20% hot. This value composites to #19A7B4, flat to within a level across the panel.
        private static readonly Color k_Flood = Hex(0x179DA9);

        [MenuItem("RootsDance/Build Data Screen (Test)")]
        public static void Build()
        {
            EnsureFolder(k_SandboxFolder);

            RenderTexture buffer = BuildBuffer(k_SandboxFolder + "/Test_DataBuffer.renderTexture");
            Material composite = BuildCompositeMaterial(k_SandboxFolder + "/Test_DataComposite.mat");

            AssetDatabase.SaveAssets();

            GameObject prefab = BuildPrefab(k_SandboxFolder + "/Test_DataScreen.prefab", buffer, composite);
            BuildScene(k_SandboxFolder + "/Test_DataScreen.unity", prefab);

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
            Debug.Log($"Data screen built in {k_SandboxFolder}. Open Test_DataScreen.unity and press Play.");
        }

        private static GameObject BuildPrefab(string path, RenderTexture buffer, Material composite)
        {
            GameObject root = new GameObject("Test_DataScreen");

            GameObject rig = new GameObject("Signal");
            rig.transform.SetParent(root.transform, false);
            rig.transform.position = new Vector3(20000f, 0f, 0f);

            Camera camera = BuildSignalCamera(rig.transform, buffer);
            RectTransform lowRes = BuildLowResCanvas(rig.transform, camera);

            float sideOffset = (k_CentreWidth + k_SideWidth) * 0.5f + k_Gap;

            Image centrePanel = BuildPanel(lowRes, "CentrePanel", k_CentreGround,
                new Vector2(k_CentreWidth, k_CentreHeight), 0f, k_CentreTop);
            Image leftPanel = BuildPanel(lowRes, "LeftPanel", k_SideGround,
                new Vector2(k_SideWidth, k_SideHeight), -sideOffset, k_SideTop);
            Image rightPanel = BuildPanel(lowRes, "RightPanel", k_SideGround,
                new Vector2(k_SideWidth, k_SideHeight), sideOffset, k_SideTop);

            // The label sits inside the field, not beside it, so the field has to leave it a gutter -
            // §13's reference keeps blank cells either side of the name while the rest of the row
            // carries figures. Two cells of margin around a 13-character label on the centre grid.
            const int labelCells = 13;
            const int gutter = 2;
            RectInt labelHole = new RectInt(
                (k_CentreColumns - labelCells) / 2 - gutter, k_LabelRow - 1,
                labelCells + gutter * 2, 3);

            TerminalDataField centreField = BuildField(centrePanel.rectTransform, "CentreField",
                k_CentreColumns, k_CentreRows, 1, k_CellPitch, 0.82f, k_CentreDim, k_CentreBright, 1,
                labelHole);
            TerminalDataField leftField = BuildField(leftPanel.rectTransform, "LeftField",
                k_SideColumns, k_SideRows, 2, k_CellPitch, 0.79f, k_SideDim, k_SideBright, 2);
            TerminalDataField rightField = BuildField(rightPanel.rectTransform, "RightField",
                k_SideColumns, k_SideRows, 2, k_CellPitch, 0.79f, k_SideDim, k_SideBright, 3);

            // §13 puts the label 58.6% down the frame, over the field rather than beside it. Dot scale
            // 1 with one dot of tracking gives a 4 px advance, which is the centre panel's own cell
            // pitch, so the label sits on the same grid as the chatter behind it.
            DotMatrixText label = CreateDotText(lowRes, "CentreLabel", "ROOT/NET 0447", 1, 1, k_Label);
            Centre(label.RectTransform, new Vector2(0f,
                k_BufferHeight * 0.5f - k_CentreTop - (k_LabelRow + 0.5f) * k_CellPitch.y));

            BuildComposite(root.transform, buffer, composite);

            DataScreenPresenter presenter = root.AddComponent<DataScreenPresenter>();
            SetReference(presenter, "m_centrePanel", centrePanel);
            SetReference(presenter, "m_centreField", centreField);
            SetReference(presenter, "m_centreLabel", label);
            SetReference(presenter, "m_leftField", leftField);
            SetReference(presenter, "m_rightField", rightField);

            // §1 — the reference's host name is a trademark, and a placeholder would survive to
            // submission. This keeps its slash-and-four-digits rhythm and none of its words.
            SetString(presenter, "m_bootLabel", "SYSTEM BOOT");
            SetString(presenter, "m_hostLabel", "ROOT/NET 0447");
            SetColor(presenter, "m_floodColor", k_Flood);

            // §13 — the field ticks at 6 Hz, not the warm screen's 15.
            SetFloat(presenter, "m_motion.m_stepSeconds", 1f / 6f);
            SetInt(presenter, "m_motion.m_populateSteps", 10);

            GameObject prefab = PrefabUtility.SaveAsPrefabAsset(root, path);
            Object.DestroyImmediate(root);

            return prefab;
        }

        // §10 rule 1: the field outside the panels measures an exact zero, so the camera clears to
        // black rather than to a ground colour, and _GrainGate keeps it there through the composite.
        private static Camera BuildSignalCamera(Transform parent, RenderTexture buffer)
        {
            GameObject go = new GameObject("SignalCamera", typeof(Camera));
            go.transform.SetParent(parent, false);
            go.transform.localPosition = new Vector3(0f, 0f, -10f);

            Camera camera = go.GetComponent<Camera>();
            camera.orthographic = true;
            camera.orthographicSize = 5f;
            camera.nearClipPlane = 0.1f;
            camera.farClipPlane = 100f;
            camera.clearFlags = CameraClearFlags.SolidColor;
            camera.backgroundColor = k_Surround;
            camera.cullingMask = 1 << LayerMask.NameToLayer("UI");
            camera.targetTexture = buffer;
            camera.allowHDR = false;
            camera.allowMSAA = false;

            return camera;
        }

        private static RectTransform BuildLowResCanvas(Transform parent, Camera camera)
        {
            GameObject go = new GameObject("LowResCanvas", typeof(RectTransform), typeof(Canvas),
                typeof(CanvasScaler));
            go.layer = LayerMask.NameToLayer("UI");
            go.transform.SetParent(parent, false);

            Canvas canvas = go.GetComponent<Canvas>();
            canvas.renderMode = RenderMode.ScreenSpaceCamera;
            canvas.worldCamera = camera;
            canvas.planeDistance = 10f;

            CanvasScaler scaler = go.GetComponent<CanvasScaler>();
            scaler.uiScaleMode = CanvasScaler.ScaleMode.ConstantPixelSize;
            scaler.scaleFactor = 1f;

            return (RectTransform)go.transform;
        }

        /// <summary>
        /// A panel: flat ground colour, no border of any kind, and a RectMask2D so the field inside it
        /// cannot spill. §10 — the panel edge is a hard cut, not a fade, and the reference shows
        /// nothing at all outside it.
        /// </summary>
        private static Image BuildPanel(RectTransform parent, string name, Color ground, Vector2 size,
            float offsetX, float topInset)
        {
            Image panel = CreateImage(parent, name, ground);
            RectTransform rect = panel.rectTransform;
            rect.anchorMin = new Vector2(0.5f, 1f);
            rect.anchorMax = new Vector2(0.5f, 1f);
            rect.pivot = new Vector2(0.5f, 1f);
            rect.sizeDelta = size;
            rect.anchoredPosition = new Vector2(offsetX, -topInset);

            panel.gameObject.AddComponent<RectMask2D>();

            return panel;
        }

        private static TerminalDataField BuildField(RectTransform panel, string name, int columns,
            int rows, int dotScale, Vector2Int pitch, float occupancy, Color dim, Color bright, int seed,
            RectInt blank = default)
        {
            GameObject go = new GameObject(name, typeof(RectTransform), typeof(RawImage),
                typeof(TerminalDataField));
            go.layer = LayerMask.NameToLayer("UI");
            go.transform.SetParent(panel, false);
            go.GetComponent<RawImage>().raycastTarget = false;

            TerminalDataField field = go.GetComponent<TerminalDataField>();
            SerializedObject serialized = new SerializedObject(field);
            serialized.FindProperty("m_columns").intValue = columns;
            serialized.FindProperty("m_rows").intValue = rows;
            serialized.FindProperty("m_dotScale").intValue = dotScale;
            serialized.FindProperty("m_cellPitch").vector2IntValue = pitch;
            serialized.FindProperty("m_occupancy").floatValue = occupancy;
            serialized.FindProperty("m_dimColor").colorValue = dim;
            serialized.FindProperty("m_brightColor").colorValue = bright;
            serialized.FindProperty("m_seed").intValue = seed;
            serialized.FindProperty("m_blankRegion.x").intValue = blank.xMin;
            serialized.FindProperty("m_blankRegion.y").intValue = blank.yMin;
            serialized.FindProperty("m_blankRegion.width").intValue = blank.width;
            serialized.FindProperty("m_blankRegion.height").intValue = blank.height;
            serialized.ApplyModifiedPropertiesWithoutUndo();
            field.Rebuild();

            // Pinned to the panel's top-left with an even margin, so a field taller than its panel
            // runs off the bottom the way the centre panel does rather than being centred in it.
            RectTransform rect = field.RectTransform;
            rect.anchorMin = new Vector2(0f, 1f);
            rect.anchorMax = new Vector2(0f, 1f);
            rect.pivot = new Vector2(0f, 1f);
            rect.anchoredPosition = new Vector2(
                (panel.sizeDelta.x - columns * pitch.x * dotScale) * 0.5f,
                -pitch.y * dotScale * 0.5f);

            return field;
        }

        private static void BuildComposite(Transform parent, RenderTexture buffer, Material material)
        {
            GameObject go = new GameObject("CompositeCanvas", typeof(RectTransform), typeof(Canvas));
            go.layer = LayerMask.NameToLayer("UI");
            go.transform.SetParent(parent, false);

            Canvas canvas = go.GetComponent<Canvas>();
            canvas.renderMode = RenderMode.ScreenSpaceOverlay;
            canvas.sortingOrder = 10;

            RawImage screen = CreateRawImage((RectTransform)go.transform, "Screen", buffer);
            screen.material = material;
            StretchFull(screen.rectTransform);
        }

        private static RenderTexture BuildBuffer(string path)
        {
            RenderTexture buffer = AssetDatabase.LoadAssetAtPath<RenderTexture>(path);

            if (buffer == null)
            {
                buffer = new RenderTexture(k_BufferWidth, k_BufferHeight, 16, RenderTextureFormat.ARGB32);
                AssetDatabase.CreateAsset(buffer, path);
            }

            // Size and mip mode can only be set before the texture is created, and a rebuild finds it
            // already live from the previous run; releasing it first is what makes the tool re-runnable
            // without three errors in the console.
            if (buffer.IsCreated())
            {
                buffer.Release();
            }

            buffer.width = k_BufferWidth;
            buffer.height = k_BufferHeight;
            buffer.filterMode = FilterMode.Bilinear;
            buffer.wrapMode = TextureWrapMode.Clamp;
            buffer.antiAliasing = 1;
            buffer.useMipMap = false;
            EditorUtility.SetDirty(buffer);

            return buffer;
        }

        /// <summary>
        /// The composite tuned for the B-roll, which is where §10's four reversals actually land: the
        /// grain is gated to the panels and drops to a twelfth of the warm screen's strength, and the
        /// scanlines and the vignette go to zero because the reference has neither.
        /// </summary>
        private static Material BuildCompositeMaterial(string path)
        {
            Shader shader = Shader.Find(k_CompositeShader);

            if (shader == null)
            {
                Debug.LogError($"Shader {k_CompositeShader} not found; falling back to UI/Default.");
                shader = Shader.Find("UI/Default");
            }

            Material material = AssetDatabase.LoadAssetAtPath<Material>(path);

            if (material == null)
            {
                material = new Material(shader);
                AssetDatabase.CreateAsset(material, path);
            }

            material.shader = shader;
            material.SetFloat("_GrainGate", 1f);
            material.SetFloat("_GrainPerceptual", 1f);

            // Measured grain sigma is about 3 levels out of 255 on the panel ground. Uniform noise
            // over a range r has sigma r/sqrt(12), so 0.041 reproduces it - but only because
            // _GrainPerceptual puts the swing in display space, where "3 levels" is what the number
            // means. Read as a linear-space amplitude the same value is roughly ten times too loud.
            material.SetFloat("_GrainStrength", 0.041f);
            material.SetFloat("_ScanlineStrength", 0f);
            material.SetFloat("_VignetteStrength", 0f);

            // The panel ground has to stay out of the bright pass or the whole rect blooms; only type
            // glows. The ceiling is well under white: the brightest thing measured is L 197.
            material.SetFloat("_GlowThreshold", 0.15f);
            material.SetFloat("_GlowStrength", 1.5f);
            material.SetFloat("_GlowRadius", 1.4f);
            material.SetFloat("_LumaCeiling", 0.8f);
            EditorUtility.SetDirty(material);

            return material;
        }

        private static void BuildScene(string path, GameObject prefab)
        {
            Scene scene = EditorSceneManager.NewScene(NewSceneSetup.DefaultGameObjects, NewSceneMode.Single);

            GameObject eventSystem = new GameObject("EventSystem", typeof(EventSystem),
                typeof(InputSystemUIInputModule));
            SceneManager.MoveGameObjectToScene(eventSystem, scene);

            GameObject instance = (GameObject)PrefabUtility.InstantiatePrefab(prefab, scene);
            instance.name = prefab.name;

            EditorSceneManager.SaveScene(scene, path);
        }

        private static Image CreateImage(RectTransform parent, string name, Color color)
        {
            GameObject go = new GameObject(name, typeof(RectTransform), typeof(Image));
            go.layer = LayerMask.NameToLayer("UI");
            go.transform.SetParent(parent, false);

            Image image = go.GetComponent<Image>();
            image.color = color;
            image.raycastTarget = false;

            return image;
        }

        private static RawImage CreateRawImage(RectTransform parent, string name, Texture texture)
        {
            GameObject go = new GameObject(name, typeof(RectTransform), typeof(RawImage));
            go.layer = LayerMask.NameToLayer("UI");
            go.transform.SetParent(parent, false);

            RawImage image = go.GetComponent<RawImage>();
            image.texture = texture;
            image.raycastTarget = false;

            return image;
        }

        private static DotMatrixText CreateDotText(RectTransform parent, string name, string text,
            int dotScale, int tracking, Color color)
        {
            GameObject go = new GameObject(name, typeof(RectTransform), typeof(RawImage),
                typeof(DotMatrixText));
            go.layer = LayerMask.NameToLayer("UI");
            go.transform.SetParent(parent, false);

            go.GetComponent<RawImage>().raycastTarget = false;

            DotMatrixText label = go.GetComponent<DotMatrixText>();
            SerializedObject serialized = new SerializedObject(label);
            serialized.FindProperty("m_text").stringValue = text;
            serialized.FindProperty("m_dotScale").intValue = dotScale;
            serialized.FindProperty("m_tracking").intValue = tracking;
            serialized.FindProperty("m_color").colorValue = color;
            serialized.ApplyModifiedPropertiesWithoutUndo();
            label.Rebuild();

            return label;
        }

        private static void StretchFull(RectTransform rect)
        {
            rect.anchorMin = Vector2.zero;
            rect.anchorMax = Vector2.one;
            rect.offsetMin = Vector2.zero;
            rect.offsetMax = Vector2.zero;
        }

        private static void Centre(RectTransform rect, Vector2 offset)
        {
            rect.anchorMin = new Vector2(0.5f, 0.5f);
            rect.anchorMax = new Vector2(0.5f, 0.5f);
            rect.pivot = new Vector2(0.5f, 0.5f);
            rect.anchoredPosition = offset;
        }

        private static Color Hex(int rgb)
        {
            return new Color(((rgb >> 16) & 0xFF) / 255f, ((rgb >> 8) & 0xFF) / 255f, (rgb & 0xFF) / 255f);
        }

        private static void EnsureFolder(string folder)
        {
            if (!AssetDatabase.IsValidFolder(folder))
            {
                AssetDatabase.CreateFolder(Path.GetDirectoryName(folder), Path.GetFileName(folder));
            }
        }

        private static void SetReference(Object target, string field, Object value)
        {
            Apply(target, field, property => property.objectReferenceValue = value);
        }

        private static void SetString(Object target, string field, string value)
        {
            Apply(target, field, property => property.stringValue = value);
        }

        private static void SetColor(Object target, string field, Color value)
        {
            Apply(target, field, property => property.colorValue = value);
        }

        private static void SetFloat(Object target, string field, float value)
        {
            Apply(target, field, property => property.floatValue = value);
        }

        private static void SetInt(Object target, string field, int value)
        {
            Apply(target, field, property => property.intValue = value);
        }

        private static void Apply(Object target, string field, System.Action<SerializedProperty> write)
        {
            SerializedObject serialized = new SerializedObject(target);
            SerializedProperty property = serialized.FindProperty(field);

            if (property == null)
            {
                Debug.LogError($"{target.GetType().Name} has no serialized field {field}.");
                return;
            }

            write(property);
            serialized.ApplyModifiedPropertiesWithoutUndo();
        }
    }
}
