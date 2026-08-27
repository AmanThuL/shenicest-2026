using System.IO;
using RootsDance.UI.Kit;
using TMPro;
using UnityEditor;
using UnityEngine;
using UnityEngine.UI;
using Object = UnityEngine.Object;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Generates the electronic UI kit of docs/effects/电子类UI组件库规范.md: the theme assets, the
    /// dither material, procedural source plates, and the drag-and-drop prefab library.
    /// <para>
    /// The same private helpers build both the library prefabs and the demo screens
    /// (<see cref="ElectronicUIKitDemoBuilder"/>), which is the point: if a screen needed anything the
    /// library cannot express, the library would be wrong.
    /// </para>
    /// </summary>
    public static class ElectronicUIKitBuilder
    {
        public const string KitFolder = "Assets/RootsDance/Prefabs/UI/ElectronicKit";
        public const string ThemeFolder = "Assets/RootsDance/Data/Config/UIThemes";
        public const string DitherShader = "RootsDance/UI/Dither";

        [MenuItem("RootsDance/Build Electronic UI Kit")]
        public static void Build()
        {
            EnsureFolder("Assets/RootsDance/Prefabs/UI");
            EnsureFolder(KitFolder);
            EnsureFolder("Assets/RootsDance/Data/Config");
            EnsureFolder(ThemeFolder);

            BuildThemes();
            BuildDitherMaterial();
            BuildSourceTextures();

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            BuildPrefabLibrary();

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
            Debug.Log($"Electronic UI kit built in {KitFolder} and {ThemeFolder}.");
        }

        // §2A. Three ramps taken from the references' palettes, not their layouts. Violet's accent is
        // deliberately equal to its Ink4: that reference has no alarm state, and the spec would rather
        // a theme say so than have a red forced into it.
        private static void BuildThemes()
        {
            BuildTheme("Precinct", new[]
            {
                Hex(0x03090D), Hex(0x151D21), Hex(0x2D3E46), Hex(0x46505A), Hex(0x5C7489), Hex(0x8597A5)
            }, Hex(0x893429));

            BuildTheme("Violet", new[]
            {
                Hex(0x1A1820), Hex(0x2C2A4A), Hex(0x4F5080), Hex(0x8689BC), Hex(0xC7CFF2), Hex(0xF4F7FF)
            }, Hex(0xC7CFF2));

            BuildTheme("Phosphor", new[]
            {
                Hex(0x040F04), Hex(0x32422F), Hex(0x598E47), Hex(0x8DB081), Hex(0xB9D4A0), Hex(0xD7EFA0)
            }, Hex(0xEDFA4F));
        }

        private static ElectronicUITheme BuildTheme(string name, Color[] ramp, Color accent)
        {
            string path = $"{ThemeFolder}/UITheme_{name}.asset";
            ElectronicUITheme theme = AssetDatabase.LoadAssetAtPath<ElectronicUITheme>(path);

            if (theme == null)
            {
                theme = ScriptableObject.CreateInstance<ElectronicUITheme>();
                AssetDatabase.CreateAsset(theme, path);
            }

            SerializedObject serialized = new SerializedObject(theme);
            SerializedProperty rampProperty = serialized.FindProperty("m_ramp");
            rampProperty.arraySize = ramp.Length;

            for (int i = 0; i < ramp.Length; i++)
            {
                rampProperty.GetArrayElementAtIndex(i).colorValue = ramp[i];
            }

            serialized.FindProperty("m_accent").colorValue = accent;
            serialized.FindProperty("m_font").objectReferenceValue = LoadFont();
            serialized.ApplyModifiedPropertiesWithoutUndo();
            EditorUtility.SetDirty(theme);

            return theme;
        }

        private static TMP_FontAsset LoadFont()
        {
            return AssetDatabase.LoadAssetAtPath<TMP_FontAsset>(
                "Assets/TextMesh Pro/Resources/Fonts & Materials/LiberationSans SDF.asset");
        }

        private static Material BuildDitherMaterial()
        {
            string path = $"{KitFolder}/M_Dither.mat";
            Shader shader = Shader.Find(DitherShader);

            if (shader == null)
            {
                Debug.LogError($"Shader {DitherShader} not found.");
                return null;
            }

            Material material = AssetDatabase.LoadAssetAtPath<Material>(path);

            if (material == null)
            {
                material = new Material(shader);
                AssetDatabase.CreateAsset(material, path);
            }

            material.shader = shader;
            EditorUtility.SetDirty(material);

            return material;
        }

        // Procedural greyscale sources, so nothing in the kit is traced from the references and the
        // dither modes have something with real tonal range to chew on. Deliberately abstract: what
        // matters is that the plate has highlights, midtones and shadow, not what it depicts.
        private static void BuildSourceTextures()
        {
            BuildTexture("T_PlateIris", 256, (u, v) =>
            {
                float d = Mathf.Sqrt((u - 0.5f) * (u - 0.5f) + (v - 0.5f) * (v - 0.5f)) * 2f;
                float iris = Mathf.SmoothStep(1f, 0f, Mathf.Abs(d - 0.55f) * 4f);
                float pupil = Mathf.SmoothStep(0f, 1f, (d - 0.22f) * 8f);
                float grain = Mathf.PerlinNoise(u * 22f, v * 22f) * 0.28f;

                return Mathf.Clamp01(pupil * (0.35f + iris * 0.5f + grain));
            });

            BuildTexture("T_PlateRoot", 256, (u, v) =>
            {
                float trunk = Mathf.SmoothStep(1f, 0f, Mathf.Abs(u - 0.5f - Mathf.Sin(v * 5f) * 0.1f) * 9f);
                float branch = Mathf.SmoothStep(1f, 0f, Mathf.Abs(v - 0.5f - Mathf.Sin(u * 7f) * 0.16f) * 7f);
                float field = Mathf.PerlinNoise(u * 6f, v * 6f);

                return Mathf.Clamp01(Mathf.Max(trunk, branch * 0.7f) * 0.8f + field * 0.35f);
            });

            BuildTexture("T_PlateCircuit", 256, (u, v) =>
            {
                float gx = Mathf.Abs(Mathf.Repeat(u * 8f, 1f) - 0.5f);
                float gy = Mathf.Abs(Mathf.Repeat(v * 8f, 1f) - 0.5f);
                float trace = Mathf.SmoothStep(1f, 0f, Mathf.Min(gx, gy) * 12f);
                float pad = Mathf.PerlinNoise(u * 9f, v * 9f) > 0.62f ? 0.7f : 0f;

                return Mathf.Clamp01(trace * 0.75f + pad + 0.08f);
            });
        }

        private static void BuildTexture(string name, int size, System.Func<float, float, float> sample)
        {
            string path = $"{KitFolder}/{name}.png";
            Texture2D texture = new Texture2D(size, size, TextureFormat.RGBA32, false);
            Color32[] pixels = new Color32[size * size];

            for (int y = 0; y < size; y++)
            {
                for (int x = 0; x < size; x++)
                {
                    byte v = (byte)Mathf.Clamp(Mathf.RoundToInt(sample(x / (float)size, y / (float)size) * 255f), 0, 255);
                    pixels[y * size + x] = new Color32(v, v, v, 255);
                }
            }

            texture.SetPixels32(pixels);
            texture.Apply();
            File.WriteAllBytes(path, texture.EncodeToPNG());
            Object.DestroyImmediate(texture);

            AssetDatabase.ImportAsset(path);
            TextureImporter importer = AssetImporter.GetAtPath(path) as TextureImporter;

            if (importer != null)
            {
                importer.textureType = TextureImporterType.Default;
                importer.mipmapEnabled = false;
                importer.filterMode = FilterMode.Bilinear;
                importer.SaveAndReimport();
            }
        }

        // ---------------------------------------------------------------- prefab library

        private static void BuildPrefabLibrary()
        {
            SavePrefab(MakePanel("Panel", new Vector2(320f, 200f)), "Panel");
            SavePrefab(MakeTitleBar("TitleBar", "SECTION", "STATUS"), "TitleBar");
            SavePrefab(MakeDataRow("DataRow", "LABEL", "VALUE", false), "DataRow");
            SavePrefab(MakeDataTable("DataTable", new[] { "LABEL A", "LABEL B", "LABEL C" },
                new[] { "VALUE A", "VALUE B", "VALUE C" }, -1), "DataTable");
            SavePrefab(MakePlate("ImagePlate", "T_PlateIris", KitDitherPlate.DitherMode.Bayer4, 2, 3f, true),
                "ImagePlate");
            SavePrefab(MakeSegmentBar("SegmentBar", 6, 0.66f), "SegmentBar");
            SavePrefab(MakeBarcode("BarcodeRows", 4), "BarcodeRows");
            SavePrefab(MakeWaveform("Waveform"), "Waveform");
            SavePrefab(MakeChipMosaic("ChipMosaic", 8, 4), "ChipMosaic");
            SavePrefab(MakeButton("Button", "ACTION", false), "Button");
            SavePrefab(MakeButton("ButtonSolid", "CONFIRM", true), "ButtonSolid");
            SavePrefab(MakeReadout("Readout", "0447", "ID"), "Readout");
            SavePrefab(MakeCornerMarks("CornerMarks"), "CornerMarks");
        }

        private static void SavePrefab(GameObject go, string name)
        {
            PrefabUtility.SaveAsPrefabAsset(go, $"{KitFolder}/{name}.prefab");
            Object.DestroyImmediate(go);
        }

        // ---------------------------------------------------------------- component factories

        internal static GameObject MakePanel(string name, Vector2 size)
        {
            GameObject go = NewRect(name, size);
            AddFill(go, KitInk.Ink0);
            AddBorder(go, KitInk.Ink4, false);

            GameObject content = NewRect("Content", size);
            content.transform.SetParent(go.transform, false);
            Stretch(content.GetComponent<RectTransform>(), 12f);

            return go;
        }

        internal static GameObject MakeTitleBar(string name, string title, string status)
        {
            GameObject go = NewRect(name, new Vector2(640f, 40f));
            AddFill(go, KitInk.Ink0);
            AddBorder(go, KitInk.Ink4, false);

            GameObject left = MakeLabel("Title", title, KitInk.Ink5, KitType.Body, TextAlignmentOptions.Left);
            left.transform.SetParent(go.transform, false);
            Stretch(left.GetComponent<RectTransform>(), 12f);

            GameObject right = MakeLabel("Status", status, KitInk.Ink3, KitType.Micro,
                TextAlignmentOptions.Right);
            right.transform.SetParent(go.transform, false);
            Stretch(right.GetComponent<RectTransform>(), 12f);

            return go;
        }

        internal static GameObject MakeDataRow(string name, string label, string value, bool alarm)
        {
            GameObject go = NewRect(name, new Vector2(400f, 40f));

            GameObject l = MakeLabel("Label", label, KitInk.Ink3, KitType.Body, TextAlignmentOptions.Left);
            l.transform.SetParent(go.transform, false);
            Stretch(l.GetComponent<RectTransform>(), 0f);

            GameObject v = MakeLabel("Value", value, KitInk.Ink5, KitType.Body, TextAlignmentOptions.Right);
            v.transform.SetParent(go.transform, false);
            Stretch(v.GetComponent<RectTransform>(), 0f);

            KitDataRow row = go.AddComponent<KitDataRow>();
            SerializedObject serialized = new SerializedObject(row);
            serialized.FindProperty("m_label").objectReferenceValue = l.GetComponent<ThemedText>();
            serialized.FindProperty("m_value").objectReferenceValue = v.GetComponent<ThemedText>();
            serialized.FindProperty("m_labelText").stringValue = label;
            serialized.FindProperty("m_valueText").stringValue = value;
            serialized.FindProperty("m_alarm").boolValue = alarm;
            serialized.ApplyModifiedPropertiesWithoutUndo();

            LayoutElement layout = go.AddComponent<LayoutElement>();
            layout.preferredHeight = 40f;

            return go;
        }

        internal static GameObject MakeDataTable(string name, string[] labels, string[] values,
            int alarmFrom)
        {
            GameObject go = NewRect(name, new Vector2(400f, labels.Length * 40f));
            VerticalLayoutGroup layout = go.AddComponent<VerticalLayoutGroup>();
            layout.childControlWidth = true;
            layout.childControlHeight = true;
            layout.childForceExpandWidth = true;
            layout.childForceExpandHeight = false;
            layout.spacing = 0f;

            for (int i = 0; i < labels.Length; i++)
            {
                bool alarm = alarmFrom >= 0 && i >= alarmFrom;
                GameObject row = MakeDataRow($"Row{i}", labels[i], values[i], alarm);
                row.transform.SetParent(go.transform, false);

                if (i <= 0)
                {
                    continue;
                }

                GameObject divider = NewRect("Divider", new Vector2(400f, 1f));
                divider.transform.SetParent(row.transform, false);
                RectTransform rect = divider.GetComponent<RectTransform>();
                rect.anchorMin = new Vector2(0f, 1f);
                rect.anchorMax = new Vector2(1f, 1f);
                rect.pivot = new Vector2(0.5f, 1f);
                rect.offsetMin = new Vector2(0f, -1f);
                rect.offsetMax = Vector2.zero;
                AddFill(divider, KitInk.Ink2);
            }

            return go;
        }

        internal static GameObject MakePlate(string name, string texture,
            KitDitherPlate.DitherMode mode, int levels, float pixelSize, bool reticle)
        {
            GameObject go = NewRect(name, new Vector2(280f, 200f));
            AddFill(go, KitInk.Ink0);

            GameObject image = NewRect("Image", new Vector2(280f, 200f));
            image.transform.SetParent(go.transform, false);
            Stretch(image.GetComponent<RectTransform>(), 0f);

            RawImage raw = image.AddComponent<RawImage>();
            raw.raycastTarget = false;
            raw.texture = AssetDatabase.LoadAssetAtPath<Texture2D>($"{KitFolder}/{texture}.png");
            raw.material = AssetDatabase.LoadAssetAtPath<Material>($"{KitFolder}/M_Dither.mat");

            KitDitherPlate plate = image.AddComponent<KitDitherPlate>();
            SerializedObject serialized = new SerializedObject(plate);
            serialized.FindProperty("m_mode").enumValueIndex = (int)mode;
            serialized.FindProperty("m_levels").intValue = levels;
            serialized.FindProperty("m_pixelSize").floatValue = pixelSize;
            serialized.ApplyModifiedPropertiesWithoutUndo();

            if (reticle)
            {
                GameObject grid = NewRect("Reticle", new Vector2(280f, 200f));
                grid.transform.SetParent(go.transform, false);
                Stretch(grid.GetComponent<RectTransform>(), 0f);
                KitReticle r = grid.AddComponent<KitReticle>();
                SetInk(r, KitInk.Ink2);
                r.raycastTarget = false;
            }

            AddBorder(go, KitInk.Ink4, false);

            return go;
        }

        internal static GameObject MakeSegmentBar(string name, int segments, float value)
        {
            GameObject go = NewRect(name, new Vector2(120f, 16f));
            KitSegmentBar bar = go.AddComponent<KitSegmentBar>();
            bar.raycastTarget = false;
            SetInk(bar, KitInk.Ink5);
            SerializedObject serialized = new SerializedObject(bar);
            serialized.FindProperty("m_segments").intValue = segments;
            serialized.FindProperty("m_value").floatValue = value;
            serialized.ApplyModifiedPropertiesWithoutUndo();

            return go;
        }

        internal static GameObject MakeBarcode(string name, int rows)
        {
            GameObject go = NewRect(name, new Vector2(320f, 90f));
            KitBarcodeRows bars = go.AddComponent<KitBarcodeRows>();
            bars.raycastTarget = false;
            SetInk(bars, KitInk.Ink4);
            SerializedObject serialized = new SerializedObject(bars);
            serialized.FindProperty("m_rows").intValue = rows;
            serialized.ApplyModifiedPropertiesWithoutUndo();

            return go;
        }

        internal static GameObject MakeWaveform(string name)
        {
            GameObject go = NewRect(name, new Vector2(400f, 120f));
            KitWaveform wave = go.AddComponent<KitWaveform>();
            wave.raycastTarget = false;
            SetInk(wave, KitInk.Ink5);

            return go;
        }

        internal static GameObject MakeChipMosaic(string name, int columns, int rows)
        {
            GameObject go = NewRect(name, new Vector2(220f, 110f));
            KitChipMosaic chips = go.AddComponent<KitChipMosaic>();
            chips.raycastTarget = false;
            SetInk(chips, KitInk.Ink3);
            SerializedObject serialized = new SerializedObject(chips);
            serialized.FindProperty("m_columns").intValue = columns;
            serialized.FindProperty("m_rows").intValue = rows;
            serialized.ApplyModifiedPropertiesWithoutUndo();

            return go;
        }

        internal static GameObject MakeButton(string name, string label, bool solid)
        {
            GameObject go = NewRect(name, new Vector2(180f, 40f));

            if (solid)
            {
                AddFill(go, KitInk.Ink4);
            }

            AddBorder(go, KitInk.Ink4, false);

            GameObject text = MakeLabel("Label", label, solid ? KitInk.Ink0 : KitInk.Ink5, KitType.Body,
                TextAlignmentOptions.Center);
            text.transform.SetParent(go.transform, false);
            Stretch(text.GetComponent<RectTransform>(), 6f);

            LayoutElement layout = go.AddComponent<LayoutElement>();
            layout.preferredHeight = 40f;

            return go;
        }

        internal static GameObject MakeReadout(string name, string value, string caption)
        {
            GameObject go = NewRect(name, new Vector2(200f, 60f));

            GameObject big = MakeLabel("Value", value, KitInk.Ink5, KitType.Display,
                TextAlignmentOptions.Left);
            big.transform.SetParent(go.transform, false);
            Stretch(big.GetComponent<RectTransform>(), 0f);

            GameObject small = MakeLabel("Caption", caption, KitInk.Ink3, KitType.Micro,
                TextAlignmentOptions.TopRight);
            small.transform.SetParent(go.transform, false);
            Stretch(small.GetComponent<RectTransform>(), 0f);

            return go;
        }

        internal static GameObject MakeCornerMarks(string name)
        {
            GameObject go = NewRect(name, new Vector2(200f, 200f));
            KitCornerMarks marks = go.AddComponent<KitCornerMarks>();
            marks.raycastTarget = false;
            SetInk(marks, KitInk.Ink4);

            return go;
        }

        internal static GameObject MakeLabel(string name, string text, KitInk ink, KitType role,
            TextAlignmentOptions alignment)
        {
            GameObject go = NewRect(name, new Vector2(200f, 24f));
            TextMeshProUGUI label = go.AddComponent<TextMeshProUGUI>();
            label.text = text;
            label.alignment = alignment;
            label.raycastTarget = false;
            label.enableWordWrapping = false;

            ThemedText themed = go.AddComponent<ThemedText>();
            SerializedObject serialized = new SerializedObject(themed);
            serialized.FindProperty("m_ink").enumValueIndex = (int)ink;
            serialized.FindProperty("m_role").enumValueIndex = (int)role;
            serialized.FindProperty("m_text").stringValue = text;
            serialized.ApplyModifiedPropertiesWithoutUndo();

            return go;
        }

        // ---------------------------------------------------------------- primitives

        internal static GameObject NewRect(string name, Vector2 size)
        {
            GameObject go = new GameObject(name, typeof(RectTransform));
            go.layer = LayerMask.NameToLayer("UI");
            go.GetComponent<RectTransform>().sizeDelta = size;

            return go;
        }

        internal static void AddFill(GameObject go, KitInk ink)
        {
            GameObject fill = NewRect("Fill", Vector2.zero);
            fill.transform.SetParent(go.transform, false);
            fill.transform.SetAsFirstSibling();
            Stretch(fill.GetComponent<RectTransform>(), 0f);

            Image image = fill.AddComponent<Image>();
            image.raycastTarget = false;

            ThemedGraphic themed = fill.AddComponent<ThemedGraphic>();
            SerializedObject serialized = new SerializedObject(themed);
            serialized.FindProperty("m_ink").enumValueIndex = (int)ink;
            serialized.ApplyModifiedPropertiesWithoutUndo();
        }

        internal static void AddBorder(GameObject go, KitInk ink, bool strong)
        {
            GameObject border = NewRect("Border", Vector2.zero);
            border.transform.SetParent(go.transform, false);
            border.transform.SetAsLastSibling();
            Stretch(border.GetComponent<RectTransform>(), 0f);

            KitBorder kitBorder = border.AddComponent<KitBorder>();
            kitBorder.raycastTarget = false;
            SetInk(kitBorder, ink);
            SerializedObject serialized = new SerializedObject(kitBorder);
            serialized.FindProperty("m_strong").boolValue = strong;
            serialized.ApplyModifiedPropertiesWithoutUndo();
        }

        internal static void SetInk(KitElement element, KitInk ink)
        {
            SerializedObject serialized = new SerializedObject(element);
            serialized.FindProperty("m_ink").enumValueIndex = (int)ink;
            serialized.ApplyModifiedPropertiesWithoutUndo();
        }

        internal static void Stretch(RectTransform rect, float inset)
        {
            rect.anchorMin = Vector2.zero;
            rect.anchorMax = Vector2.one;
            rect.offsetMin = new Vector2(inset, inset);
            rect.offsetMax = new Vector2(-inset, -inset);
        }

        internal static Color Hex(int rgb)
        {
            return new Color(((rgb >> 16) & 0xFF) / 255f, ((rgb >> 8) & 0xFF) / 255f, (rgb & 0xFF) / 255f);
        }

        internal static void EnsureFolder(string folder)
        {
            if (!AssetDatabase.IsValidFolder(folder))
            {
                AssetDatabase.CreateFolder(Path.GetDirectoryName(folder), Path.GetFileName(folder));
            }
        }
    }
}
