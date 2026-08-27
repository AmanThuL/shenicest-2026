using System.IO;
using RootsDance.UI.Kit;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using Object = UnityEngine.Object;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Throwaway evidence gathering for the electronic UI kit: renders each kit primitive alone in a
    /// minimal capture rig, runs the dither shader over a photographic test card via Blit (no canvas,
    /// no theme, no prefab in the path), and dumps the theme assets' actual serialized colours.
    /// Outputs to Logs/UIKitShots/Diag_*.png.
    /// </summary>
    /// <summary>Minimal custom Graphic: one quad, Image-identical vertex layout. If this fails to
    /// render where Image succeeds, every custom-mesh Graphic fails in this environment.</summary>
    public class DiagQuad : Graphic
    {
        protected override void OnPopulateMesh(VertexHelper vh)
        {
            vh.Clear();
            Rect r = GetPixelAdjustedRect();

            UIVertex v = UIVertex.simpleVert;
            v.color = color;
            v.position = new Vector3(r.xMin, r.yMin);
            v.uv0 = Vector2.zero;
            vh.AddVert(v);
            v.position = new Vector3(r.xMin, r.yMax);
            v.uv0 = new Vector2(0f, 1f);
            vh.AddVert(v);
            v.position = new Vector3(r.xMax, r.yMax);
            v.uv0 = new Vector2(1f, 1f);
            vh.AddVert(v);
            v.position = new Vector3(r.xMax, r.yMin);
            v.uv0 = new Vector2(1f, 0f);
            vh.AddVert(v);
            vh.AddTriangle(0, 1, 2);
            vh.AddTriangle(2, 3, 0);
            Debug.Log($"DIAG DiagQuad populated verts={vh.currentVertCount} rect={r}");
        }
    }

    /// <summary>KitBorder that reports its generated vertex count.</summary>
    public class DiagBorder : KitBorder
    {
        protected override void OnPopulateMesh(VertexHelper vh)
        {
            base.OnPopulateMesh(vh);
            Debug.Log($"DIAG DiagBorder populated verts={vh.currentVertCount} rect=" +
                GetPixelAdjustedRect() + " color=" + color);
        }
    }

    public static class KitDiagnostics
    {
        private const string k_Folder = "Logs/UIKitShots";

        public static void Run()
        {
            Directory.CreateDirectory(k_Folder);
            DumpThemes();
            TestDitherBlit();
            TestPrimitives();
            EditorSceneManager.NewScene(NewSceneSetup.EmptyScene, NewSceneMode.Single);
        }

        private static void DumpThemes()
        {
            foreach (string name in new[] { "Precinct", "Violet", "Phosphor" })
            {
                ElectronicUITheme theme = AssetDatabase.LoadAssetAtPath<ElectronicUITheme>(
                    $"{ElectronicUIKitBuilder.ThemeFolder}/UITheme_{name}.asset");

                if (theme == null)
                {
                    Debug.Log($"DIAG theme {name}: MISSING");
                    continue;
                }

                string ramp = string.Empty;

                for (int i = 0; i <= 5; i++)
                {
                    ramp += ColorUtility.ToHtmlStringRGB(theme.Ink((KitInk)i)) + " ";
                }

                Debug.Log($"DIAG theme {name}: ramp {ramp} accent " +
                    ColorUtility.ToHtmlStringRGB(theme.Ink(KitInk.Accent)) + " sizes " +
                    theme.Size(KitType.Micro) + "/" + theme.Size(KitType.Body) + "/" +
                    theme.Size(KitType.Display) + " font " +
                    (theme.Font != null ? theme.Font.name : "NULL"));
            }
        }

        // A photographic test card: smooth gradients, a sphere, bands — if the dither shader works,
        // every output is pure hard pattern with zero smooth gradients left.
        private static Texture2D TestCard()
        {
            const int size = 512;
            Texture2D card = new Texture2D(size, size, TextureFormat.RGBA32, false);

            for (int y = 0; y < size; y++)
            {
                for (int x = 0; x < size; x++)
                {
                    float u = x / (float)size;
                    float v = y / (float)size;
                    float g;

                    if (v > 0.75f)
                    {
                        g = u;                                    // linear ramp
                    }
                    else if (v > 0.5f)
                    {
                        g = Mathf.Floor(u * 8f) / 7f;             // 8 hard steps
                    }
                    else
                    {
                        float dx = u - 0.5f;
                        float dy = (v - 0.25f) * 2f;
                        float d = Mathf.Sqrt(dx * dx + dy * dy) * 2.4f;
                        g = Mathf.Clamp01(1f - d) * 1.2f;         // soft sphere
                        g += Mathf.PerlinNoise(u * 18f, v * 18f) * 0.15f;
                    }

                    card.SetPixel(x, y, new Color(g, g, g, 1f));
                }
            }

            card.Apply();

            return card;
        }

        private static void TestDitherBlit()
        {
            Shader shader = Shader.Find("RootsDance/UI/Dither");
            Debug.Log($"DIAG dither shader found: {shader != null}, supported: " +
                (shader != null ? shader.isSupported.ToString() : "n/a"));

            if (shader == null)
            {
                return;
            }

            Texture2D card = TestCard();
            SavePng(card, $"{k_Folder}/Diag_TestCard.png");

            for (int mode = 0; mode <= 6; mode++)
            {
                Material material = new Material(shader);
                material.SetFloat("_Mode", mode);
                material.SetFloat("_Levels", mode <= 2 ? 4 : 2);
                material.SetFloat("_PixelSize", 3f);
                material.SetFloat("_Contrast", 1.2f);
                material.SetColor("_ColorLow", Color.black);
                material.SetColor("_ColorHigh", Color.white);

                RenderTexture rt = new RenderTexture(512, 512, 0, RenderTextureFormat.ARGB32,
                    RenderTextureReadWrite.sRGB);
                Graphics.Blit(card, rt, material);

                Texture2D read = new Texture2D(512, 512, TextureFormat.RGBA32, false);
                RenderTexture previous = RenderTexture.active;
                RenderTexture.active = rt;
                read.ReadPixels(new Rect(0, 0, 512, 512), 0, 0);
                read.Apply();
                RenderTexture.active = previous;

                SavePng(read, $"{k_Folder}/Diag_Dither_Mode{mode}.png");
                Object.DestroyImmediate(read);
                Object.DestroyImmediate(rt);
                Object.DestroyImmediate(material);
            }

            Object.DestroyImmediate(card);
        }

        private static void TestPrimitives()
        {
            Scene scene = EditorSceneManager.NewScene(NewSceneSetup.DefaultGameObjects,
                NewSceneMode.Single);

            GameObject cameraObject = new GameObject("Cam", typeof(Camera));
            SceneManager.MoveGameObjectToScene(cameraObject, scene);
            Camera camera = cameraObject.GetComponent<Camera>();
            camera.transform.position = new Vector3(0f, 0f, -10f);

            GameObject canvasObject = new GameObject("Canvas", typeof(RectTransform), typeof(Canvas),
                typeof(CanvasScaler));
            SceneManager.MoveGameObjectToScene(canvasObject, scene);
            Canvas canvas = canvasObject.GetComponent<Canvas>();
            canvas.renderMode = RenderMode.ScreenSpaceCamera;
            canvas.worldCamera = camera;
            canvas.planeDistance = 1f;
            CanvasScaler scaler = canvasObject.GetComponent<CanvasScaler>();
            scaler.uiScaleMode = CanvasScaler.ScaleMode.ConstantPixelSize;
            scaler.scaleFactor = 1f;

            // Ground so we can see the canvas extent.
            GameObject ground = new GameObject("Ground", typeof(RectTransform), typeof(Image));
            ground.transform.SetParent(canvas.transform, false);
            Stretch(ground);
            ground.GetComponent<Image>().color = new Color(0.1f, 0.1f, 0.12f, 1f);

            // Control: plain Image.
            Add<Image>(canvas, "Image", new Rect(20f, 20f, 120f, 30f),
                g => g.color = Color.white);

            // Each custom primitive, colours set directly — no theme in the path.
            Add<KitBorder>(canvas, "Border", new Rect(20f, 70f, 120f, 60f),
                g => g.color = Color.white);
            Add<KitSegmentBar>(canvas, "SegBar", new Rect(20f, 150f, 120f, 20f),
                g => g.color = Color.green);
            Add<KitWaveform>(canvas, "Wave", new Rect(20f, 190f, 200f, 80f),
                g => g.color = Color.cyan);
            Add<KitBarcodeRows>(canvas, "Bars", new Rect(20f, 290f, 200f, 80f),
                g => g.color = Color.yellow);
            Add<KitChipMosaic>(canvas, "Chips", new Rect(20f, 390f, 200f, 60f),
                g => g.color = Color.magenta);
            Add<KitSplit>(canvas, "Split", new Rect(260f, 70f, 200f, 120f),
                g => g.color = Color.white);
            Add<KitCornerMarks>(canvas, "Marks", new Rect(260f, 210f, 120f, 80f),
                g => g.color = Color.white);
            Add<KitNodeDots>(canvas, "Dots", new Rect(260f, 310f, 120f, 60f),
                g => g.color = Color.white);
            Add<KitBox>(canvas, "Box", new Rect(260f, 390f, 120f, 40f),
                g => g.color = Color.white);
            Add<KitLeader>(canvas, "Leader", new Rect(420f, 210f, 200f, 100f),
                g => g.color = Color.red);
            Add<DiagQuad>(canvas, "Quad", new Rect(420f, 20f, 160f, 120f),
                g => g.color = Color.white);
            Add<DiagBorder>(canvas, "DiagBorder", new Rect(420f, 350f, 160f, 100f),
                g => g.color = Color.white);

            RenderTexture target = new RenderTexture(700, 500, 24, RenderTextureFormat.ARGB32,
                RenderTextureReadWrite.sRGB);
            camera.targetTexture = target;
            Canvas.ForceUpdateCanvases();

            foreach (Graphic graphic in canvasObject.GetComponentsInChildren<Graphic>())
            {
                CanvasRenderer renderer = graphic.canvasRenderer;
                Debug.Log($"DIAG state {graphic.name}: cull={renderer.cull} " +
                    $"matCount={renderer.materialCount} depth={renderer.absoluteDepth} " +
                    $"alpha={renderer.GetAlpha()} mat={(graphic.materialForRendering != null ? graphic.materialForRendering.shader.name : "null")}");
            }

            RenderPipeline.StandardRequest request = new RenderPipeline.StandardRequest();
            request.destination = target;

            // Several warm-up submissions: HDRP's automatic exposure adapts over frames, and a single
            // cold render comes out crushed several stops dark.
            for (int i = 0; i < 8; i++)
            {
                camera.SubmitRenderRequest(request);
            }

            Texture2D read = new Texture2D(700, 500, TextureFormat.RGBA32, false);
            RenderTexture previous = RenderTexture.active;
            RenderTexture.active = target;
            read.ReadPixels(new Rect(0, 0, 700, 500), 0, 0);
            read.Apply();
            RenderTexture.active = previous;

            File.WriteAllBytes($"{k_Folder}/Diag_Primitives.png", read.EncodeToPNG());
            Debug.Log("DIAG primitives captured");

            camera.targetTexture = null;
            Object.DestroyImmediate(read);
            Object.DestroyImmediate(target);
        }

        private static void Add<T>(Canvas canvas, string name, Rect area,
            System.Action<Graphic> setup) where T : Graphic
        {
            GameObject go = new GameObject(name, typeof(RectTransform), typeof(CanvasRenderer));
            go.transform.SetParent(canvas.transform, false);
            RectTransform rect = (RectTransform)go.transform;
            rect.anchorMin = new Vector2(0f, 1f);
            rect.anchorMax = new Vector2(0f, 1f);
            rect.pivot = new Vector2(0f, 1f);
            rect.sizeDelta = area.size;
            rect.anchoredPosition = new Vector2(area.x, -area.y);

            T graphic = go.AddComponent<T>();
            graphic.raycastTarget = false;
            setup(graphic);
        }

        private static void Stretch(GameObject go)
        {
            RectTransform rect = (RectTransform)go.transform;
            rect.anchorMin = Vector2.zero;
            rect.anchorMax = Vector2.one;
            rect.offsetMin = Vector2.zero;
            rect.offsetMax = Vector2.zero;
        }

        private static void SavePng(Texture2D texture, string path)
        {
            File.WriteAllBytes(path, texture.EncodeToPNG());
        }
    }
}
