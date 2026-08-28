using System.IO;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>Creates deterministic review images for the authored Briggs Interior environment.</summary>
    public static class BriggsInteriorVisualQaCapture
    {
        private const string k_ScenePath =
            "Assets/RootsDance/Scenes/Levels/BriggsInterior/BriggsInterior_Environment.unity";
        private const string k_OutputFolder = "Logs/VisualQA/artist-table-pass";
        private const int k_Width = 1600;
        private const int k_Height = 900;

        public static void CaptureFromCommandLine()
        {
            Scene scene = EditorSceneManager.OpenScene(k_ScenePath, OpenSceneMode.Single);
            Directory.CreateDirectory(k_OutputFolder);

            GameObject cameraObject = new GameObject("BriggsInteriorQaCamera");
            SceneManager.MoveGameObjectToScene(cameraObject, scene);
            Camera camera = cameraObject.AddComponent<Camera>();
            camera.fieldOfView = 58f;
            camera.nearClipPlane = 0.08f;
            camera.farClipPlane = 100f;
            HDAdditionalCameraData cameraData = cameraObject.AddComponent<HDAdditionalCameraData>();
            cameraData.volumeLayerMask = ~0;

            RenderTexture target = new RenderTexture(k_Width, k_Height, 24, RenderTextureFormat.ARGB32);
            Texture2D readback = new Texture2D(k_Width, k_Height, TextureFormat.RGB24, false);

            try
            {
                Capture(camera, target, readback, "01_entrance",
                    new Vector3(3f, 1.65f, -5.8f), new Vector3(0.1f, 1.05f, 0.3f));
                Capture(camera, target, readback, "02_central_island",
                    new Vector3(3.8f, 2.05f, -3.8f), new Vector3(0.1f, 0.92f, 0.3f));
                Capture(camera, target, readback, "03_west_archives",
                    new Vector3(-2.5f, 1.9f, -0.6f), new Vector3(-7.2f, 1.15f, -2.2f));
                Capture(camera, target, readback, "04_topdown",
                    new Vector3(0f, 12f, 0f), Vector3.zero);
                Debug.Log($"BriggsInteriorVisualQaCapture: wrote four views to '{k_OutputFolder}'.");
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

        private static void Capture(
            Camera camera,
            RenderTexture target,
            Texture2D readback,
            string name,
            Vector3 position,
            Vector3 lookAt)
        {
            camera.transform.SetPositionAndRotation(
                position,
                Quaternion.LookRotation((lookAt - position).normalized, Vector3.up));
            camera.targetTexture = target;

            for (int frame = 0; frame < 4; frame++)
            {
                camera.Render();
            }

            RenderTexture previous = RenderTexture.active;
            RenderTexture.active = target;
            readback.ReadPixels(new Rect(0f, 0f, k_Width, k_Height), 0, 0);
            readback.Apply();
            RenderTexture.active = previous;
            File.WriteAllBytes(Path.Combine(k_OutputFolder, name + ".png"), readback.EncodeToPNG());
        }
    }
}
