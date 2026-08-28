using System.IO;
using RootsDance.UI.Kit;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem.UI;
using UnityEngine.Rendering;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using Object = UnityEngine.Object;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Rebuilds the Test_ElectronicUI sandbox from the three §5B template prefabs, one per reference,
    /// each under its own measured theme — the acceptance test of the 2026-08-27 spec revision. The
    /// capture entry renders each template to a PNG at its native size so the cut, the seams and the
    /// type can be laid next to the reference images directly.
    /// </summary>
    public static class ElectronicUIKitDemoBuilder
    {
        private const string k_Folder = "Assets/_Sandbox/UISandboxDemo";
        private const string k_ShotFolder = "Logs/UIKitShots";

        private static readonly string[] k_Templates =
        {
            "Template_Archive", "Template_Dossier", "Template_Browser"
        };

        /// <summary>Batch entry: kit, templates, sandbox scene, screenshots, in one run.</summary>
        public static void BuildAll()
        {
            ElectronicUIKitBuilder.Build();
            Build();
            Capture();
        }

        [MenuItem("RootsDance/Build Electronic UI Demos")]
        public static void Build()
        {
            ElectronicUIKitBuilder.EnsureFolder(k_Folder);

            // The scene has to exist before the screens do: NewScene destroys everything in the open
            // scene, and screens built beforehand would be dead by the time they were parented.
            Scene scene = NewScene();
            RectTransform canvas = BuildCanvas(scene);

            float x = 40f;

            for (int i = 0; i < k_Templates.Length; i++)
            {
                GameObject instance = Instantiate(k_Templates[i]);

                if (instance == null)
                {
                    continue;
                }

                RectTransform rect = (RectTransform)instance.transform;
                Vector2 size = rect.sizeDelta;
                rect.SetParent(canvas, false);
                rect.anchorMin = new Vector2(0f, 1f);
                rect.anchorMax = new Vector2(0f, 1f);
                rect.pivot = new Vector2(0f, 1f);
                rect.anchoredPosition = new Vector2(x, -40f);
                rect.sizeDelta = size;
                x += size.x + 40f;

                ElectronicUIRoot root = instance.GetComponent<ElectronicUIRoot>();

                if (root != null)
                {
                    root.ApplyTheme();
                }
            }

            EditorSceneManager.SaveScene(scene, $"{k_Folder}/Test_ElectronicUI.unity");

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
            Debug.Log("Electronic UI sandbox rebuilt from the templates. Open Test_ElectronicUI.unity.");
        }

        /// <summary>
        /// Renders each template prefab to Logs/UIKitShots/&lt;name&gt;.png at its native pixel size,
        /// through a screen-space-camera canvas into a RenderTexture, so the output is comparable
        /// one-to-one with the reference images.
        /// </summary>
        [MenuItem("RootsDance/Capture Electronic UI Shots")]
        public static void Capture()
        {
            Directory.CreateDirectory(k_ShotFolder);

            Scene scene = NewScene();

            GameObject cameraObject = new GameObject("CaptureCamera", typeof(Camera));
            SceneManager.MoveGameObjectToScene(cameraObject, scene);
            Camera camera = cameraObject.GetComponent<Camera>();
            camera.transform.position = new Vector3(0f, 0f, -10f);

            GameObject canvasObject = new GameObject("CaptureCanvas", typeof(RectTransform),
                typeof(Canvas), typeof(CanvasScaler));
            canvasObject.layer = LayerMask.NameToLayer("UI");
            SceneManager.MoveGameObjectToScene(canvasObject, scene);

            Canvas canvas = canvasObject.GetComponent<Canvas>();
            canvas.renderMode = RenderMode.ScreenSpaceCamera;
            canvas.worldCamera = camera;
            canvas.planeDistance = 1f;

            CanvasScaler scaler = canvasObject.GetComponent<CanvasScaler>();
            scaler.uiScaleMode = CanvasScaler.ScaleMode.ConstantPixelSize;
            scaler.scaleFactor = 1f;

            for (int i = 0; i < k_Templates.Length; i++)
            {
                GameObject instance = Instantiate(k_Templates[i]);

                if (instance == null)
                {
                    continue;
                }

                RectTransform rect = (RectTransform)instance.transform;
                Vector2 size = rect.sizeDelta;
                rect.SetParent(canvas.transform, false);

                ElectronicUIRoot root = instance.GetComponent<ElectronicUIRoot>();

                if (root != null)
                {
                    root.ApplyTheme();
                }

                int width = Mathf.RoundToInt(size.x);
                int height = Mathf.RoundToInt(size.y);
                RenderTexture target = new RenderTexture(width, height, 24,
                    RenderTextureFormat.ARGB32, RenderTextureReadWrite.sRGB);
                camera.targetTexture = target;

                // With the target bound, the camera's pixel rect is the texture, so the canvas snaps
                // to the template's native size; centre-anchored, the screen fills it edge to edge.
                rect.anchorMin = new Vector2(0.5f, 0.5f);
                rect.anchorMax = new Vector2(0.5f, 0.5f);
                rect.pivot = new Vector2(0.5f, 0.5f);
                rect.anchoredPosition = Vector2.zero;
                rect.sizeDelta = size;

                Canvas.ForceUpdateCanvases();

                RenderPipeline.StandardRequest request = new RenderPipeline.StandardRequest();
                request.destination = target;

                // Warm-up submissions: HDRP's automatic exposure adapts over frames, and a single
                // cold render comes out several stops dark (the first capture of a batch was nearly
                // black while later ones were correct).
                for (int pass = 0; pass < 8; pass++)
                {
                    camera.SubmitRenderRequest(request);
                }

                Texture2D readback = new Texture2D(width, height, TextureFormat.RGBA32, false);
                RenderTexture previous = RenderTexture.active;
                RenderTexture.active = target;
                readback.ReadPixels(new Rect(0f, 0f, width, height), 0, 0);
                readback.Apply();
                RenderTexture.active = previous;

                string path = $"{k_ShotFolder}/{k_Templates[i]}.png";
                File.WriteAllBytes(path, readback.EncodeToPNG());
                Debug.Log($"Captured {path}");

                camera.targetTexture = null;
                Object.DestroyImmediate(readback);
                Object.DestroyImmediate(target);
                Object.DestroyImmediate(instance);
            }

            // Leave the capture rig out of anyone's way: reopen an empty untitled scene.
            EditorSceneManager.NewScene(NewSceneSetup.EmptyScene, NewSceneMode.Single);
        }

        private static GameObject Instantiate(string template)
        {
            string path = $"{ElectronicUIKitBuilder.TemplateFolder}/{template}.prefab";
            GameObject asset = AssetDatabase.LoadAssetAtPath<GameObject>(path);

            if (asset == null)
            {
                Debug.LogError($"{path} missing — run RootsDance > Build Electronic UI Kit first.");
                return null;
            }

            return (GameObject)PrefabUtility.InstantiatePrefab(asset);
        }

        private static Scene NewScene()
        {
            Scene scene = EditorSceneManager.NewScene(NewSceneSetup.DefaultGameObjects,
                NewSceneMode.Single);

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
