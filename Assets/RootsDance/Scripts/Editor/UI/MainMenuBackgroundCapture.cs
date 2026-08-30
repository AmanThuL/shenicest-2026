using System.IO;
using RootsDance.App;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;

namespace RootsDance.Editor.UI
{
    /// <summary>Renders the generated background without requiring a running game.</summary>
    public static class MainMenuBackgroundCapture
    {
        private const string k_OutputPath = "Logs/MainMenu/BackgroundValidation.png";
        private const int k_Width = 1920;
        private const int k_Height = 1080;
        private const int k_WarmUpFrames = 8;

        [MenuItem("RootsDance/UI/Capture Dynamic Main Menu Background")]
        public static void CaptureFromCommandLine()
        {
            EditorSceneManager.OpenScene(ScenePaths.k_MainMenuBackground, OpenSceneMode.Single);
            Capture(k_OutputPath);
        }

        public static void CaptureSourceFromCommandLine()
        {
            EditorSceneManager.OpenScene(ScenePaths.k_MainEnvironment, OpenSceneMode.Single);
            EditorSceneManager.OpenScene(ScenePaths.k_MainEnvironment2, OpenSceneMode.Additive);
            Capture("Logs/MainMenu/SourceValidation.png");
        }

        private static void Capture(string outputPath)
        {
            Directory.CreateDirectory(Path.GetDirectoryName(k_OutputPath));

            GameObject cameraObject = new GameObject("MainMenuValidationCamera");
            cameraObject.transform.SetPositionAndRotation(
                new Vector3(28.3285f, 8.549451f, 94.99633f),
                Quaternion.Euler(-9.287f, -29.826f, 0f));
            Camera camera = cameraObject.AddComponent<Camera>();
            camera.fieldOfView = 40f;
            camera.nearClipPlane = 0.1f;
            camera.farClipPlane = 250f;
            cameraObject.AddComponent<HDAdditionalCameraData>();

            RenderTexture target = new RenderTexture(k_Width, k_Height, 24, RenderTextureFormat.ARGB32);
            Texture2D readback = new Texture2D(k_Width, k_Height, TextureFormat.RGB24, false);

            try
            {
                camera.targetTexture = target;

                for (int i = 0; i < k_WarmUpFrames; i++)
                {
                    camera.Render();
                }

                RenderTexture previous = RenderTexture.active;
                RenderTexture.active = target;
                readback.ReadPixels(new Rect(0f, 0f, k_Width, k_Height), 0, 0);
                readback.Apply();
                RenderTexture.active = previous;
                File.WriteAllBytes(outputPath, readback.EncodeToPNG());
                Debug.Log("MainMenuBackgroundCapture: wrote " + outputPath);
            }
            finally
            {
                camera.targetTexture = null;
                Object.DestroyImmediate(readback);
                target.Release();
                Object.DestroyImmediate(target);
                Object.DestroyImmediate(cameraObject);
            }
        }
    }
}
