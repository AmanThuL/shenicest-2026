using System.IO;
using RootsDance.UI.Kit;
using TMPro;
using UnityEditor;
using UnityEngine;
using UnityEngine.TextCore.LowLevel;
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
        public const string TemplateFolder = KitFolder + "/Templates";
        public const string ThemeFolder = "Assets/RootsDance/Data/Config/UIThemes";
        public const string FontFolder = "Assets/RootsDance/Fonts";
        public const string DitherShader = "RootsDance/UI/Dither";

        [MenuItem("RootsDance/Build Electronic UI Kit")]
        public static void Build()
        {
            EnsureFolder("Assets/RootsDance/Prefabs/UI");
            EnsureFolder(KitFolder);
            EnsureFolder(TemplateFolder);
            EnsureFolder("Assets/RootsDance/Data/Config");
            EnsureFolder(ThemeFolder);

            BuildThemes();
            BuildDitherMaterial();
            BuildSourceTextures();

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            BuildPrefabLibrary();
            ElectronicUIKitTemplateBuilder.BuildTemplates();

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
            Debug.Log($"Electronic UI kit built in {KitFolder} and {ThemeFolder}.");
        }

        /// <summary>
        /// Rebuilds only the theme assets. Split out of <see cref="Build"/> so a palette can be
        /// added or corrected without regenerating every prefab in the kit and putting that churn
        /// in front of a reviewer.
        /// </summary>
        [MenuItem("RootsDance/Build Electronic UI Themes")]
        public static void BuildThemesOnly()
        {
            EnsureFolder(ThemeFolder);
            BuildThemes();
            AssetDatabase.SaveAssets();
            Debug.Log($"Electronic UI themes written to {ThemeFolder}.");
        }

        // §2A. Three ramps taken from the references' palettes, not their layouts. Violet's accent is
        // deliberately equal to its Ink4: that reference has no alarm state, and the spec would rather
        // a theme say so than have a red forced into it.
        // Ramps re-measured 2026-08-27 directly off the reference pixels (probe medians with the
        // bloom's top percentile as the ink). The first pass was far too dark at the top: the police
        // screen's rules and values sit near white, which is most of why it reads as an instrument.
        private static void BuildThemes()
        {
            BuildTheme("Precinct", new[]
            {
                Hex(0x020809), Hex(0x0D1519), Hex(0x22343A), Hex(0x4E626B), Hex(0x84949C), Hex(0xC6D2D8)
            }, Hex(0xA83428), Hex(0x4E7A80), KitFamily.Archive, 24f, 40f, 56f, false);

            BuildTheme("Violet", new[]
            {
                Hex(0x131117), Hex(0x201E26), Hex(0x3A3862), Hex(0x7478AC), Hex(0x9BA0D8), Hex(0xE8ECFF)
            }, Hex(0x9BA0D8), Hex(0x9BA0D8), KitFamily.Archive, 18f, 36f, 46f, true);

            BuildTheme("Phosphor", new[]
            {
                Hex(0x040F04), Hex(0x32422F), Hex(0x598E47), Hex(0x8DB081), Hex(0xB9D4A0), Hex(0xD7EFA0)
            }, Hex(0xEDFA4F), Hex(0x598E47), KitFamily.Terminal, 16f, 24f, 40f, false);

            // Amber is the odd one out on purpose: its ramp runs bright to dark, because it is
            // matched to a physical object rather than to a reference image. The scanner prop's
            // baked screen is a positive display — a lit amber field with near-black text — and the
            // whole point of the theme is that the live UI and the baked bezel around it read as
            // one machine. Values resampled from game_1001_BaseColor.jpeg over the screen island:
            // field #A8822D at the 50th percentile, ink #060407 at the 1st, the transitional brown
            // #523200 at the 10th, and the accent taken from the prop's own red buttons.
            BuildTheme("Amber", new[]
            {
                Hex(0xA8822D), Hex(0x9A7529), Hex(0x6E5219), Hex(0x4A3610), Hex(0x2A1D08), Hex(0x0A0705)
            }, Hex(0x7F2725), Hex(0x523200), KitFamily.Archive, 24f, 40f, 56f, false);
        }

        private static ElectronicUITheme BuildTheme(string name, Color[] ramp, Color accent,
            Color accentAlt, KitFamily family, float micro, float body, float display, bool bold)
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
            serialized.FindProperty("m_accentAlt").colorValue = accentAlt;
            serialized.FindProperty("m_family").enumValueIndex = (int)family;
            serialized.FindProperty("m_font").objectReferenceValue = EnsureFont();
            serialized.FindProperty("m_boldText").boolValue = bold;

            // Sizes are measured per reference: cap heights of 20-22 px on 40 px rows put the body at
            // 36-40 pt for VT323 (caps ≈ 0.55 em). Set explicitly so old assets migrate too.
            serialized.FindProperty("m_microSize").floatValue = micro;
            serialized.FindProperty("m_bodySize").floatValue = body;
            serialized.FindProperty("m_displaySize").floatValue = display;
            serialized.ApplyModifiedPropertiesWithoutUndo();
            EditorUtility.SetDirty(theme);

            return theme;
        }

        /// <summary>
        /// The kit's one font asset: an SDF TMP asset generated from the Fusion Pixel ttf (spec
        /// §2C). Dynamic population, so the atlas grows with whatever the screens actually set.
        /// Faking a mono face with LiberationSans plus an mspace tag — the old spec's approach — is
        /// exactly the giveaway the revision bans; this asset is what replaced it.
        /// <para>
        /// VT323 was the original choice and has no CJK coverage at all — every Chinese character
        /// on a kit screen rendered as a tofu box. Fusion Pixel's zh_hans variant
        /// (TakWolf/fusion-pixel-font, OFL-1.1, <c>Assets/RootsDance/Fonts/FusionPixel-OFL.txt</c>)
        /// is a pixel-grid mono face like VT323 but ships Latin and Simplified Chinese in the same
        /// file, which this project's copy is heaviest on.
        /// </para>
        /// </summary>
        internal static TMP_FontAsset EnsureFont()
        {
            string path = $"{FontFolder}/FusionPixel-12px SDF.asset";
            TMP_FontAsset asset = AssetDatabase.LoadAssetAtPath<TMP_FontAsset>(path);

            if (asset != null)
            {
                return asset;
            }

            Font source = AssetDatabase.LoadAssetAtPath<Font>(
                $"{FontFolder}/FusionPixel-12px-Zh_Hans.ttf");

            if (source == null)
            {
                Debug.LogError($"{FontFolder}/FusionPixel-12px-Zh_Hans.ttf missing — cannot build "
                    + "the kit font.");
                return null;
            }

            // Larger atlas than VT323 needed: CJK glyphs are denser and there are far more of them
            // once a screen mixes English and Chinese labels.
            asset = TMP_FontAsset.CreateFontAsset(source, 90, 9, GlyphRenderMode.SDFAA, 2048, 2048);

            if (asset == null)
            {
                Debug.LogError("TMP_FontAsset.CreateFontAsset failed for FusionPixel-12px-Zh_Hans.ttf.");
                return null;
            }

            asset.name = "FusionPixel-12px SDF";
            AssetDatabase.CreateAsset(asset, path);

            asset.material.name = asset.name + " Material";
            AssetDatabase.AddObjectToAsset(asset.material, asset);
            asset.atlasTexture.name = asset.name + " Atlas";
            AssetDatabase.AddObjectToAsset(asset.atlasTexture, asset);

            AssetDatabase.SaveAssets();
            AssetDatabase.ImportAsset(path);

            return AssetDatabase.LoadAssetAtPath<TMP_FontAsset>(path);
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

        // Procedural greyscale sources, so nothing in the kit is traced from the references. What the
        // references dither is hard-contrast content — an eye with real highlights and a black pupil,
        // fingerprints that are literal ridge lines, circuits that are line art. The first pass fed
        // the shader smooth Perlin blobs and no dither can save a source with no edges in it, so
        // these are drawn crisp: line weights, thresholds, hard masks.
        private static void BuildSourceTextures()
        {
            // An eye filling the frame: bright sclera, streaked iris ring, black pupil with one
            // specular dot, lids crushing the corners to dark.
            BuildTexture("T_PlateIris", 512, (u, v) =>
            {
                float dx = u - 0.5f;
                float dy = (v - 0.5f) * 1.25f;
                float d = Mathf.Sqrt(dx * dx + dy * dy) * 2f;
                float angle = Mathf.Atan2(dy, dx);

                float lid = Mathf.Abs(v - 0.5f) * 2.6f - Mathf.Cos(dx * 3.4f) * 0.55f;
                if (lid > 0.62f)
                {
                    return 0.06f;
                }

                if (d < 0.30f)
                {
                    bool spark = dx > 0.03f && dx < 0.10f && dy < -0.02f && dy > -0.09f;
                    return spark ? 0.95f : 0.02f;
                }

                if (d < 0.78f)
                {
                    float streak = Mathf.Sin(angle * 26f) * 0.5f + Mathf.Sin(angle * 9f + d * 14f) * 0.5f;
                    float ring = Mathf.InverseLerp(0.30f, 0.78f, d);
                    return Mathf.Clamp01(0.22f + ring * 0.30f + (streak > 0.15f ? 0.28f : 0f));
                }

                return 0.85f - Mathf.Max(0f, lid - 0.30f) * 1.6f;
            });

            // A fingerprint: concentric warped ridge lines inside an elliptical mask, 1 bit by
            // construction — the references' prints are line art, not tone.
            BuildTexture("T_PlateFinger", 256, (u, v) =>
            {
                float dx = (u - 0.5f) * 1.35f;
                float dy = (v - 0.52f) * 1.05f;
                float d = Mathf.Sqrt(dx * dx + dy * dy);

                if (d > 0.46f)
                {
                    return 0.02f;
                }

                float warp = Mathf.PerlinNoise(u * 5f, v * 5f) * 0.16f;
                float ridge = Mathf.Sin((d + warp) * 88f + dx * 9f);
                float core = Mathf.PerlinNoise(u * 13f + 4f, v * 13f) - 0.5f;

                return ridge + core * 0.9f > 0.15f ? 0.85f : 0.05f;
            });

            // A circuit blueprint: manhattan traces snapped to a grid, solder pads, a central IC
            // block with a pin fringe. Pure line art for the dossier's right plate.
            BuildTexture("T_PlateCircuit", 512, (u, v) =>
            {
                // Central IC block with a pin fringe.
                float ax = Mathf.Abs(u - 0.5f);
                float ay = Mathf.Abs(v - 0.5f);

                if (ax < 0.14f && ay < 0.14f)
                {
                    return ax > 0.125f || ay > 0.125f ? 0.9f : 0.06f;
                }

                if (ax < 0.2f && ay < 0.2f)
                {
                    float pins = Mathf.Repeat((ax > ay ? v : u) * 40f, 1f);
                    return pins < 0.45f ? 0.8f : 0.04f;
                }

                // Grid-following traces: one horizontal and one vertical run per grid lane, present
                // or absent by hash, plus pads at some crossings.
                float cell = 24f;
                float fx = Mathf.Repeat(u * cell, 1f);
                float fy = Mathf.Repeat(v * cell, 1f);
                int ix = (int)(u * cell);
                int iy = (int)(v * cell);

                bool laneH = Hash(iy, 3) > 0.45f && Mathf.Abs(fy - 0.5f) < 0.09f;
                bool laneV = Hash(ix, 7) > 0.45f && Mathf.Abs(fx - 0.5f) < 0.09f;
                bool pad = Hash(ix * 31 + iy, 11) > 0.88f
                    && Mathf.Abs(fx - 0.5f) < 0.3f && Mathf.Abs(fy - 0.5f) < 0.3f;

                return laneH || laneV || pad ? 0.78f : 0.05f;
            });

            // A standing figure read as scattered strokes — the dossier's character-art plate. A
            // hard silhouette mask filled with sparse dashes, on black.
            BuildTexture("T_PlateFigure", 256, (u, v) =>
            {
                float y = 1f - v;
                float cx = 0.5f + Mathf.Sin(y * 5f) * 0.02f;
                float half;

                if (y < 0.16f)
                {
                    half = 0.10f * Mathf.Sqrt(Mathf.Max(0f, 1f - Mathf.Pow((y - 0.09f) / 0.08f, 2f)));
                }
                else if (y < 0.5f)
                {
                    half = 0.16f - (y - 0.16f) * 0.12f;
                }
                else
                {
                    half = 0.12f + Mathf.PerlinNoise(0f, y * 6f) * 0.05f;
                }

                if (Mathf.Abs(u - cx) > half)
                {
                    return 0.02f;
                }

                float dash = Mathf.PerlinNoise(u * 30f, v * 46f);
                return dash > 0.52f ? 0.8f : 0.05f;
            });

            // Kept for the browser template's plates.
            BuildTexture("T_PlateRoot", 256, (u, v) =>
            {
                float trunk = Mathf.Abs(u - 0.5f - Mathf.Sin(v * 5f) * 0.1f) < 0.05f ? 1f : 0f;
                float branch = Mathf.Abs(v - 0.5f - Mathf.Sin(u * 7f) * 0.16f) < 0.06f ? 0.8f : 0f;
                float field = Mathf.PerlinNoise(u * 6f, v * 6f) > 0.62f ? 0.5f : 0f;

                return Mathf.Clamp01(Mathf.Max(trunk, Mathf.Max(branch, field)));
            });
        }

        private static float Hash(int n, int seed)
        {
            unchecked
            {
                uint x = (uint)(n * 374761393 + seed * 668265263);
                x = (x ^ (x >> 13)) * 1274126177u;
                return ((x ^ (x >> 16)) & 0xFFFFFFu) / 16777216f;
            }
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
            SavePrefab(MakeSplit("Split", new Vector2(400f, 300f), KitSplit.SplitAxis.Columns,
                new[] { 1f, 1f }, KitSplit.SeamStyle.Rule, -1, 0f), "Split");
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
            return MakeDataRow(name, label, value, alarm, KitInk.Ink3, KitInk.Ink5);
        }

        internal static GameObject MakeDataRow(string name, string label, string value, bool alarm,
            KitInk labelInk, KitInk valueInk)
        {
            GameObject go = NewRect(name, new Vector2(400f, 40f));

            GameObject l = MakeLabel("Label", label, labelInk, KitType.Body, TextAlignmentOptions.Left);
            l.transform.SetParent(go.transform, false);
            Stretch(l.GetComponent<RectTransform>(), 0f);

            GameObject v = MakeLabel("Value", value, valueInk, KitType.Body, TextAlignmentOptions.Right);
            v.transform.SetParent(go.transform, false);
            Stretch(v.GetComponent<RectTransform>(), 0f);

            KitDataRow row = go.AddComponent<KitDataRow>();
            SerializedObject serialized = new SerializedObject(row);
            serialized.FindProperty("m_label").objectReferenceValue = l.GetComponent<ThemedText>();
            serialized.FindProperty("m_value").objectReferenceValue = v.GetComponent<ThemedText>();
            serialized.FindProperty("m_labelText").stringValue = label;
            serialized.FindProperty("m_valueText").stringValue = value;
            serialized.FindProperty("m_alarm").boolValue = alarm;
            serialized.FindProperty("m_labelInk").enumValueIndex = (int)labelInk;
            serialized.FindProperty("m_valueInk").enumValueIndex = (int)valueInk;
            serialized.ApplyModifiedPropertiesWithoutUndo();

            LayoutElement layout = go.AddComponent<LayoutElement>();
            layout.preferredHeight = 40f;

            return go;
        }

        internal static GameObject MakeDataTable(string name, string[] labels, string[] values,
            int alarmFrom)
        {
            return MakeDataTable(name, labels, values, alarmFrom, KitInk.Ink3, KitInk.Ink5);
        }

        internal static GameObject MakeDataTable(string name, string[] labels, string[] values,
            int alarmFrom, KitInk labelInk, KitInk valueInk)
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
                GameObject row = MakeDataRow($"Row{i}", labels[i], values[i], alarm, labelInk,
                    valueInk);
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
            return MakePlate(name, texture, mode, levels, pixelSize, reticle, KitInk.Ink4, 7, true);
        }

        internal static GameObject MakePlate(string name, string texture,
            KitDitherPlate.DitherMode mode, int levels, float pixelSize, bool reticle,
            KitInk highInk, int reticleDivisions, bool border)
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
            serialized.FindProperty("m_highInk").enumValueIndex = (int)highInk;
            serialized.ApplyModifiedPropertiesWithoutUndo();

            if (reticle)
            {
                GameObject grid = NewRect("Reticle", new Vector2(280f, 200f));
                grid.transform.SetParent(go.transform, false);
                Stretch(grid.GetComponent<RectTransform>(), 0f);
                KitReticle r = grid.AddComponent<KitReticle>();
                SetInk(r, KitInk.Ink3);
                r.raycastTarget = false;

                SerializedObject gridSerialized = new SerializedObject(r);
                gridSerialized.FindProperty("m_columns").intValue = reticleDivisions;
                gridSerialized.FindProperty("m_rows").intValue = reticleDivisions;
                gridSerialized.ApplyModifiedPropertiesWithoutUndo();
            }

            if (border)
            {
                AddBorder(go, KitInk.Ink4, false);
            }

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
            return MakeButton(name, label, solid, KitBox.CornerMask.All);
        }

        // The shape is a KitBox, so the corners come from the theme's family (spec §5C): fixed small
        // radii under a Terminal theme, right angles under an Archive one. The button itself has no say.
        internal static GameObject MakeButton(string name, string label, bool solid,
            KitBox.CornerMask corners)
        {
            GameObject go = MakeBox(name, new Vector2(180f, 40f), solid, corners);

            GameObject text = MakeLabel("Label", label, solid ? KitInk.Ink0 : KitInk.Ink5, KitType.Body,
                TextAlignmentOptions.Center);
            text.transform.SetParent(go.transform, false);
            Stretch(text.GetComponent<RectTransform>(), 6f);

            LayoutElement layout = go.AddComponent<LayoutElement>();
            layout.preferredHeight = 40f;

            return go;
        }

        internal static GameObject MakeBox(string name, Vector2 size, bool solid,
            KitBox.CornerMask corners)
        {
            GameObject go = NewRect(name, size);
            KitBox box = go.AddComponent<KitBox>();
            box.raycastTarget = false;
            SetInk(box, KitInk.Ink4);

            SerializedObject serialized = new SerializedObject(box);
            serialized.FindProperty("m_outline").boolValue = !solid;
            serialized.FindProperty("m_fill").boolValue = solid;
            serialized.FindProperty("m_fillInk").enumValueIndex = (int)KitInk.Ink4;
            serialized.FindProperty("m_roundedCorners").intValue = (int)corners;
            serialized.ApplyModifiedPropertiesWithoutUndo();

            return go;
        }

        /// <summary>
        /// A split container (spec §4A): the given weights become that many empty cell children with
        /// one shared rule on every seam. <paramref name="gutterAfter"/> marks the screen's one
        /// sanctioned gutter seam; pass Rule for everything else, or None for Terminal-family zones
        /// separated by fill steps alone.
        /// </summary>
        internal static GameObject MakeSplit(string name, Vector2 size, KitSplit.SplitAxis axis,
            float[] weights, KitSplit.SeamStyle seam, int gutterAfter, float gutterOverride,
            bool endDots = false)
        {
            GameObject go = NewRect(name, size);
            KitSplit split = go.AddComponent<KitSplit>();
            split.raycastTarget = false;
            SetInk(split, KitInk.Ink4);

            SerializedObject serialized = new SerializedObject(split);
            serialized.FindProperty("m_axis").enumValueIndex = (int)axis;
            serialized.FindProperty("m_seam").enumValueIndex = (int)seam;
            serialized.FindProperty("m_gutterAfter").intValue = gutterAfter;
            serialized.FindProperty("m_gutterOverride").floatValue = gutterOverride;
            serialized.FindProperty("m_endDots").boolValue = endDots;

            SerializedProperty weightList = serialized.FindProperty("m_weights");
            weightList.arraySize = weights.Length;

            for (int i = 0; i < weights.Length; i++)
            {
                weightList.GetArrayElementAtIndex(i).floatValue = weights[i];
            }

            serialized.ApplyModifiedPropertiesWithoutUndo();

            for (int i = 0; i < weights.Length; i++)
            {
                GameObject cell = NewRect($"Cell{i}", Vector2.zero);
                cell.transform.SetParent(go.transform, false);
            }

            split.Relayout();

            return go;
        }

        /// <summary>Cell <paramref name="index"/> of a split built by <see cref="MakeSplit"/>.</summary>
        internal static RectTransform Cell(GameObject split, int index)
        {
            return (RectTransform)split.transform.GetChild(index);
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
            TextAlignmentOptions alignment, KitCase casing = KitCase.Family, bool italic = false,
            bool wrap = false)
        {
            GameObject go = NewRect(name, new Vector2(200f, 24f));
            TextMeshProUGUI label = go.AddComponent<TextMeshProUGUI>();
            label.text = text;
            label.alignment = alignment;
            label.raycastTarget = false;
            label.enableWordWrapping = wrap;

            ThemedText themed = go.AddComponent<ThemedText>();
            SerializedObject serialized = new SerializedObject(themed);
            serialized.FindProperty("m_ink").enumValueIndex = (int)ink;
            serialized.FindProperty("m_role").enumValueIndex = (int)role;
            serialized.FindProperty("m_text").stringValue = text;
            serialized.FindProperty("m_case").enumValueIndex = (int)casing;
            serialized.FindProperty("m_italic").boolValue = italic;
            serialized.ApplyModifiedPropertiesWithoutUndo();

            return go;
        }

        // ---------------------------------------------------------------- primitives

        internal static GameObject NewRect(string name, Vector2 size)
        {
            // CanvasRenderer up front: RequireComponent on Graphic subclasses was observed not to
            // auto-add it under AddComponent, and a Graphic without one silently draws nothing.
            GameObject go = new GameObject(name, typeof(RectTransform), typeof(CanvasRenderer));
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
