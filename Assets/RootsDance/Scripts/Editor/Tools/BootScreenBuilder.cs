using System.IO;
using RootsDance.UI;
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
    /// Builds the reproduction of docs/effects/低保真终端式UI规范.md as a prefab plus a scene.
    /// <para>
    /// The screen is one signal, not a UI with a filtered panel in it: chrome, dot-matrix text and the
    /// stage bitmap are all drawn into a 640x360 RenderTexture by a dedicated camera, and one
    /// full-screen RawImage blits that buffer through TerminalComposite (glow, scanlines, grain,
    /// vignette, gamut ceiling). Every edge therefore comes out as a glow ramp, and the text bleeds,
    /// which is what the reference frames actually measure — a rail is a 1 px core reading 159 with a
    /// ramp down to 76 eight pixels away, not a 9 px bar.
    /// </para>
    /// Everything it writes is prefixed Test_ and lives under Assets/_Sandbox/UISandboxDemo/.
    /// The two generated textures (title-bar strip, stage bitmap) are ours; no mark from the reference
    /// sequence is reproduced.
    /// Menu: RootsDance > Build Boot Screen (Test).
    /// </summary>
    public static class BootScreenBuilder
    {
        private const string k_SandboxFolder = "Assets/_Sandbox/UISandboxDemo";
        private const string k_StageShader = "RootsDance/UI/TerminalStage";
        private const string k_CompositeShader = "RootsDance/UI/TerminalComposite";

        // The buffer everything is drawn into. Chosen so the reference's smallest text (~20 px cap
        // height on a 1116-tall frame) lands on this face's 5-dot cap height.
        private const int k_BufferWidth = 640;
        private const int k_BufferHeight = 360;

        // §2, rescaled from the 1544x1116 reference frame into the buffer. The reference is 4:3 and
        // this screen is 16:9, so the stage keeps its share of screen HEIGHT (47.5%) and stays 16:9,
        // while the rails stay near the screen edges as they do there.
        private const float k_RailInset = 10f;
        private const float k_TitleBarTop = 4f;
        private const float k_TitleBarHeight = 17f;
        private const float k_StageHeight = 171f;
        private const float k_StageWidth = k_StageHeight * 16f / 9f;
        private const float k_StageTop = 90f;
        private const float k_CaptionGap = 7f;
        private const float k_OuterLine = 1f;
        private const float k_Channel = 4f;
        private const float k_InnerLine = 1f;

        // §3, re-sampled as stroke PEAKS rather than as row averages. The first pass took area means,
        // which built every label about half as bright as the reference and turned them muddy.
        private static readonly Color k_Field = Hex(0x271E18);
        private static readonly Color k_RailCore = Hex(0x9F797C);
        private static readonly Color k_TitleLineTop = Hex(0xB67B76);
        private static readonly Color k_TitleLineBottom = Hex(0xA57471);
        private static readonly Color k_TitleFillTop = Hex(0x803A31);
        private static readonly Color k_TitleFillBottom = Hex(0x623026);
        private static readonly Color k_TitleLabel = Hex(0xB76A62);
        private static readonly Color k_RuleOuter = Hex(0x9E7971);
        private static readonly Color k_BorderChannel = Hex(0x76483F);
        private static readonly Color k_RuleInner = Hex(0x956D68);
        private static readonly Color k_StageInterior = Hex(0x221B16);
        private static readonly Color k_Headline = Hex(0xD8A29E);
        private static readonly Color k_CaptionRed = Hex(0xCD8D87);
        private static readonly Color k_CaptionBone = Hex(0xCAB898);
        private static readonly Color k_StagePeak = Hex(0xE4D5B3);

        [MenuItem("RootsDance/Build Boot Screen (Test)")]
        public static void Build()
        {
            if (!EditorSceneManager.SaveCurrentModifiedScenesIfUserWantsTo())
            {
                Debug.LogWarning("Build cancelled: current scenes have unsaved changes.");
                return;
            }

            EnsureFolder(k_SandboxFolder);

            RenderTexture buffer = BuildBuffer(k_SandboxFolder + "/Test_SignalBuffer.renderTexture");
            Texture2D titleStrip = BuildTitleBarTexture(k_SandboxFolder + "/Test_TitleBarStrip.png");
            Texture2D stageImage = BuildStageTexture(k_SandboxFolder + "/Test_StageImage.png");
            Material stageMaterial = BuildMaterial(k_SandboxFolder + "/Test_TerminalStage.mat", k_StageShader);
            Material compositeMaterial = BuildMaterial(k_SandboxFolder + "/Test_TerminalComposite.mat",
                k_CompositeShader);

            TuneMaterials(stageMaterial, compositeMaterial);

            GameObject prefab = BuildPrefab(k_SandboxFolder + "/Test_BootScreen.prefab", buffer, titleStrip,
                stageImage, stageMaterial, compositeMaterial);
            BuildScene(k_SandboxFolder + "/Test_BootScreen.unity", prefab);

            AssetDatabase.SaveAssets();
            Debug.Log($"Boot screen built in {k_SandboxFolder}. Open Test_BootScreen.unity and press Play.");
        }

        private static GameObject BuildPrefab(string path, RenderTexture buffer, Texture2D titleStrip,
            Texture2D stageImage, Material stageMaterial, Material compositeMaterial)
        {
            GameObject root = new GameObject("Test_BootScreen");

            // The signal rig sits far from the origin so no other camera in the scene can see the
            // low-resolution canvas; only its own camera renders it, into the buffer.
            GameObject rig = new GameObject("Signal");
            rig.transform.SetParent(root.transform, false);
            rig.transform.position = new Vector3(10000f, 0f, 0f);

            Camera camera = BuildSignalCamera(rig.transform, buffer);
            RectTransform lowRes = BuildLowResCanvas(rig.transform, camera);

            BuildRails(lowRes);
            BuildTitleBar(lowRes, titleStrip);

            RectTransform stageWindow = BuildStageWindow(lowRes, stageImage, stageMaterial,
                out RawImage stage, out DotMatrixText headline, out DotMatrixText tagline);

            CanvasGroup captionGroup = BuildCaptionBlock(lowRes);

            BuildComposite(root.transform, buffer, compositeMaterial);

            BootScreenPresenter presenter = root.AddComponent<BootScreenPresenter>();
            SetReference(presenter, "m_stageWindow", stageWindow);
            SetReference(presenter, "m_stage", stage);
            SetReference(presenter, "m_stageGroup", TerminalMotion.EnsureCanvasGroup(stageWindow.gameObject));
            SetReference(presenter, "m_backdrop", stage.rectTransform);
            SetReference(presenter, "m_captionGroup", captionGroup);
            SetReference(presenter, "m_headline", headline);
            SetReference(presenter, "m_tagline", tagline);

            // §1 — our own wordmark, never a placeholder trademark: placeholders survive to submission.
            SetString(presenter, "m_headlineText", "ROOTS");
            SetString(presenter, "m_taglineText", "WHERE THE ROOTS DANCE");

            // §7 — the measured drift, -131 px across against +20 px down on the reference frame,
            // rescaled into the buffer. UI y points up, so the vertical component flips sign.
            SetVector2(presenter, "m_parallaxOffset", new Vector2(-54f, -6.5f));

            GameObject prefab = PrefabUtility.SaveAsPrefabAsset(root, path);
            Object.DestroyImmediate(root);

            return prefab;
        }

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
            camera.backgroundColor = k_Field;
            camera.cullingMask = 1 << LayerMask.NameToLayer("UI");
            camera.targetTexture = buffer;
            camera.allowHDR = false;
            camera.allowMSAA = false;

            // URP attaches its own UniversalAdditionalCameraData the first time it renders this
            // camera, so the editor assembly needs no reference to the pipeline package.
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

            // One canvas unit must equal one buffer pixel, so no scaling of any kind.
            CanvasScaler scaler = go.GetComponent<CanvasScaler>();
            scaler.uiScaleMode = CanvasScaler.ScaleMode.ConstantPixelSize;
            scaler.scaleFactor = 1f;

            return (RectTransform)go.transform;
        }

        // §5A — two vertical rails, no bottom rail. One pixel of core: the width the reference measures
        // is the glow, and the glow is added by the composite pass.
        private static void BuildRails(RectTransform parent)
        {
            for (int i = 0; i < 2; i++)
            {
                bool isLeft = i == 0;
                Image rail = CreateImage(parent, isLeft ? "RailLeft" : "RailRight", k_RailCore);
                RectTransform rect = rail.rectTransform;
                rect.anchorMin = new Vector2(isLeft ? 0f : 1f, 0f);
                rect.anchorMax = new Vector2(isLeft ? 0f : 1f, 1f);
                rect.pivot = new Vector2(isLeft ? 0f : 1f, 0.5f);
                rect.offsetMin = new Vector2(rect.offsetMin.x, 0f);
                rect.offsetMax = new Vector2(rect.offsetMax.x, 0f);
                rect.sizeDelta = new Vector2(1f, 0f);
                rect.anchoredPosition = new Vector2(isLeft ? k_RailInset : -k_RailInset, 0f);
            }
        }

        // §5B — a bright line, a fill that ramps downwards, a second bright line. Baked into a
        // one-pixel-wide strip so the construction survives any stretch.
        private static void BuildTitleBar(RectTransform parent, Texture2D strip)
        {
            RawImage bar = CreateRawImage(parent, "TitleBar", strip);
            RectTransform rect = bar.rectTransform;
            rect.anchorMin = new Vector2(0f, 1f);
            rect.anchorMax = new Vector2(1f, 1f);
            rect.pivot = new Vector2(0.5f, 1f);
            rect.offsetMin = new Vector2(k_RailInset, rect.offsetMin.y);
            rect.offsetMax = new Vector2(-k_RailInset, rect.offsetMax.y);
            rect.sizeDelta = new Vector2(rect.sizeDelta.x, k_TitleBarHeight);
            rect.anchoredPosition = new Vector2(0f, -k_TitleBarTop);

            // §4 — the label is tracked out to about one glyph width. At three dots per glyph that is
            // three dots of tracking, which is the single most period-carrying setting on the screen.
            DotMatrixText label = CreateDotText(rect, "Label", "SYSTEM ONLINE", 1, 3, k_TitleLabel);
            Centre(label.RectTransform, new Vector2(0f, 0f));
        }

        private static RectTransform BuildStageWindow(RectTransform parent, Texture2D stageImage,
            Material stageMaterial, out RawImage stage, out DotMatrixText headline,
            out DotMatrixText tagline)
        {
            // §5C — outer line, filled channel, inner line. The outer line is the brighter of the two:
            // the light comes from outside the window.
            Image outer = CreateImage(parent, "StageWindow", k_RuleOuter);
            RectTransform window = outer.rectTransform;
            window.anchorMin = new Vector2(0.5f, 1f);
            window.anchorMax = new Vector2(0.5f, 1f);
            window.pivot = new Vector2(0.5f, 1f);
            window.sizeDelta = new Vector2(k_StageWidth, k_StageHeight);
            window.anchoredPosition = new Vector2(0f, -k_StageTop);

            Image channel = CreateImage(window, "BorderChannel", k_BorderChannel);
            Inset(channel.rectTransform, k_OuterLine);

            Image inner = CreateImage(channel.rectTransform, "BorderInner", k_RuleInner);
            Inset(inner.rectTransform, k_Channel);

            GameObject contentGo = new GameObject("StageContent", typeof(RectTransform), typeof(Image),
                typeof(RectMask2D));
            contentGo.layer = LayerMask.NameToLayer("UI");
            RectTransform content = (RectTransform)contentGo.transform;
            content.SetParent(inner.rectTransform, false);
            Inset(content, k_InnerLine);
            contentGo.GetComponent<Image>().color = k_StageInterior;

            // Oversized and clipped, so the §7 parallax has somewhere to drift from.
            stage = CreateRawImage(content, "Backdrop", stageImage);
            stage.material = stageMaterial;
            RectTransform stageRect = stage.rectTransform;
            Centre(stageRect, new Vector2(24f, -4f));
            stageRect.sizeDelta = new Vector2(k_StageWidth * 1.3f, k_StageHeight * 1.3f);

            headline = CreateDotText(content, "Headline", string.Empty, 3, 1, k_Headline);
            Centre(headline.RectTransform, new Vector2(0f, 12f));

            tagline = CreateDotText(content, "Tagline", string.Empty, 2, 3, k_Headline);
            Centre(tagline.RectTransform, new Vector2(0f, -18f));

            return window;
        }

        // §5D — two lines under the stage, complete from P2 onwards and never animated again. Level is
        // encoded by colour, not by size: phosphor red over bone.
        private static CanvasGroup BuildCaptionBlock(RectTransform parent)
        {
            GameObject blockGo = new GameObject("CaptionBlock", typeof(RectTransform), typeof(CanvasGroup));
            blockGo.layer = LayerMask.NameToLayer("UI");
            RectTransform block = (RectTransform)blockGo.transform;
            block.SetParent(parent, false);
            block.anchorMin = new Vector2(0.5f, 1f);
            block.anchorMax = new Vector2(0.5f, 1f);
            block.pivot = new Vector2(0.5f, 1f);
            block.sizeDelta = new Vector2(k_StageWidth, 24f);
            block.anchoredPosition = new Vector2(0f, -(k_StageTop + k_StageHeight + k_CaptionGap));

            DotMatrixText line1 = CreateDotText(block, "CaptionLine1", "ROOTS 0.1", 2, 2, k_CaptionRed);
            line1.RectTransform.anchorMin = new Vector2(0.5f, 1f);
            line1.RectTransform.anchorMax = new Vector2(0.5f, 1f);
            line1.RectTransform.pivot = new Vector2(0.5f, 1f);
            line1.RectTransform.anchoredPosition = Vector2.zero;

            // §4 — the second line is a compressed face at half the step, and the two lines touch: no
            // leading between them.
            DotMatrixText line2 = CreateDotText(block, "CaptionLine2", "WHERE THE ROOTS DANCE", 1, 2,
                k_CaptionBone);
            line2.RectTransform.anchorMin = new Vector2(0.5f, 1f);
            line2.RectTransform.anchorMax = new Vector2(0.5f, 1f);
            line2.RectTransform.pivot = new Vector2(0.5f, 1f);
            line2.RectTransform.anchoredPosition = new Vector2(0f, -11f);

            return blockGo.GetComponent<CanvasGroup>();
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

            buffer.width = k_BufferWidth;
            buffer.height = k_BufferHeight;

            // Bilinear, not point: the reference is a filmed tube, soft everywhere. Point sampling here
            // is what makes a low-resolution buffer read as "pixel art" instead of as a CRT.
            buffer.filterMode = FilterMode.Bilinear;
            buffer.wrapMode = TextureWrapMode.Clamp;
            buffer.antiAliasing = 1;
            buffer.useMipMap = false;
            EditorUtility.SetDirty(buffer);

            return buffer;
        }

        private static Material BuildMaterial(string path, string shaderName)
        {
            Shader shader = Shader.Find(shaderName);

            if (shader == null)
            {
                Debug.LogError($"Shader {shaderName} not found; falling back to UI/Default.");
                shader = Shader.Find("UI/Default");
            }

            Material material = AssetDatabase.LoadAssetAtPath<Material>(path);

            if (material == null)
            {
                material = new Material(shader);
                AssetDatabase.CreateAsset(material, path);
            }

            material.shader = shader;

            return material;
        }

        private static void TuneMaterials(Material stage, Material composite)
        {
            stage.SetColor("_InteriorColor", k_StageInterior);
            stage.SetColor("_RasterColor", k_BorderChannel);
            stage.SetVector("_DitherCell", new Vector4(1f, 1f, 0f, 0f));
            stage.SetFloat("_QuantSteps", 24f);
            stage.SetFloat("_RasterSpacing", 26f);
            stage.SetFloat("_BlockSize", 4f);
            EditorUtility.SetDirty(stage);

            composite.SetFloat("_GlowStrength", 1.35f);
            composite.SetFloat("_GlowRadius", 1.6f);
            composite.SetFloat("_ScanlinePeriod", 4.2f);
            composite.SetFloat("_GlowThreshold", 0.26f);
            EditorUtility.SetDirty(composite);
        }

        // §5B — one column carrying the band construction, in buffer pixels.
        private static Texture2D BuildTitleBarTexture(string path)
        {
            int height = Mathf.RoundToInt(k_TitleBarHeight);
            Color[] pixels = new Color[height];

            for (int y = 0; y < height; y++)
            {
                int row = height - 1 - y; // Texture row 0 is the bottom of the bar.
                float t = Mathf.InverseLerp(1f, height - 2f, row);

                if (row == 0)
                {
                    pixels[y] = k_TitleLineTop;
                }
                else if (row == height - 1)
                {
                    pixels[y] = k_TitleLineBottom;
                }
                else
                {
                    pixels[y] = Color.Lerp(k_TitleFillTop, k_TitleFillBottom, t);
                }

                pixels[y].a = 1f;
            }

            Texture2D texture = new Texture2D(1, height, TextureFormat.RGBA32, false);
            texture.SetPixels(pixels);
            texture.Apply();

            return WritePng(texture, path);
        }

        // §5E — the stage bitmap, authored at the buffer's own resolution: sparse single-pixel stars
        // and a planet whose vertical gradient peaks about 60% down, dithered on the measured cell.
        private static Texture2D BuildStageTexture(string path)
        {
            int width = Mathf.RoundToInt(k_StageWidth * 1.3f);
            int height = Mathf.RoundToInt(k_StageHeight * 1.3f);

            Color[] pixels = new Color[width * height];

            for (int i = 0; i < pixels.Length; i++)
            {
                pixels[i] = k_StageInterior;
            }

            Random.State state = Random.state;
            Random.InitState(20260827);

            // §5E — 23 discrete blocks in the visible area, sparse and irregular. A few are two dots
            // wide; most are one. Anything denser stops reading as a star field.
            for (int i = 0; i < 34; i++)
            {
                int x = Random.Range(1, width - 2);
                int y = Random.Range(1, height - 2);
                int run = Random.value > 0.7f ? 2 : 1;
                Color star = Color.Lerp(k_StageInterior, k_StagePeak, Random.Range(0.75f, 1f));

                for (int dx = 0; dx < run; dx++)
                {
                    pixels[y * width + x + dx] = star;
                }
            }

            Random.state = state;

            // The reference's planet is a partial disc leaning in from the lower left, dark and
            // mostly out of frame — not a bright ball in the middle of the window.
            Vector2 centre = new Vector2(width * 0.13f, height * 0.02f);
            float radius = height * 0.42f;

            for (int y = 0; y < height; y++)
            {
                for (int x = 0; x < width; x++)
                {
                    Vector2 offset = new Vector2(x - centre.x, y - centre.y);

                    if (offset.sqrMagnitude > radius * radius)
                    {
                        continue;
                    }

                    float t = 1f - (y - (centre.y - radius)) / (radius * 2f);
                    float bright = 1f - Mathf.Abs(t - 0.6f) * 1.6f;
                    Color planet = Color.Lerp(Hex(0x483A32), Hex(0xC0AC8E), Mathf.Clamp01(bright));

                    // Ordered dither at the measured period, rescaled: this is the cross-hatch that
                    // makes the planet read as part of the same signal as everything else.
                    bool lit = (x % 3) < 2 && (y % 3) < 2;
                    pixels[y * width + x] = lit ? planet : Color.Lerp(k_StageInterior, planet, 0.25f);
                }
            }

            Texture2D texture = new Texture2D(width, height, TextureFormat.RGBA32, false);
            texture.SetPixels(pixels);
            texture.Apply();

            return WritePng(texture, path);
        }

        private static Texture2D WritePng(Texture2D texture, string path)
        {
            File.WriteAllBytes(path, texture.EncodeToPNG());
            Object.DestroyImmediate(texture);
            AssetDatabase.ImportAsset(path, ImportAssetOptions.ForceUpdate);

            TextureImporter importer = (TextureImporter)AssetImporter.GetAtPath(path);

            if (importer != null)
            {
                importer.textureType = TextureImporterType.Default;
                importer.mipmapEnabled = false;
                importer.filterMode = FilterMode.Point;
                importer.wrapMode = TextureWrapMode.Clamp;
                importer.textureCompression = TextureImporterCompression.Uncompressed;
                importer.SaveAndReimport();
            }

            return AssetDatabase.LoadAssetAtPath<Texture2D>(path);
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

        private static void Inset(RectTransform rect, float amount)
        {
            rect.anchorMin = Vector2.zero;
            rect.anchorMax = Vector2.one;
            rect.offsetMin = new Vector2(amount, amount);
            rect.offsetMax = new Vector2(-amount, -amount);
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

        private static void SetVector2(Object target, string field, Vector2 value)
        {
            Apply(target, field, property => property.vector2Value = value);
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
