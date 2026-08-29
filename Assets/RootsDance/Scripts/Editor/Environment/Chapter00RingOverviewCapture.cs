using System.IO;
using RootsDance.Editor.Terrain;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Captures one square, orthographic Editor overview of every Chapter-00 terrain ring.
    /// The scene is never saved and the temporary camera is destroyed after readback.
    /// </summary>
    public static class Chapter00RingOverviewCapture
    {
        private const string k_EnvironmentScene =
            "Assets/RootsDance/Scenes/Levels/Main/Main_Environment.unity";

        private const string k_EnvironmentScene2 =
            "Assets/RootsDance/Scenes/Levels/Main/Main_Environment_2.unity";

        private const string k_OutputFolder = "Logs/Captures/Chapter00RingOverview";
        private const string k_OutputPath = k_OutputFolder + "/chapter00_all_rings_topdown.png";
        private const int k_Size = 2048;
        private const float k_OrthographicHalfSize = 148f;

        [MenuItem("RootsDance/Environment/Capture Chapter 00 Ring Overview")]
        public static void CaptureFromMenu()
        {
            CaptureFromCommandLine();
        }

        [MenuItem("RootsDance/Environment/Capture Chapter 00 Facility Close Overview")]
        public static void CaptureFacilityCloseFromMenu()
        {
            CaptureFacilityCloseFromCommandLine();
        }

        [MenuItem("RootsDance/Environment/Capture Chapter 00 A-E Review Set")]
        public static void CaptureReviewSetFromMenu()
        {
            CaptureReviewSetFromCommandLine();
        }

        public static void CaptureFromCommandLine()
        {
            Capture(new Vector3(0f, 320f, 112f), k_OrthographicHalfSize, k_OutputPath);
        }

        public static void CaptureFacilityCloseFromCommandLine()
        {
            Capture(new Vector3(10f, 320f, 112f), 62f,
                k_OutputFolder + "/chapter00_facility_close_topdown.png");
        }

        /// <summary>Captures the unified overhead plus representative player-height C, D and E views.</summary>
        public static void CaptureReviewSetFromCommandLine()
        {
            CaptureFromCommandLine();
            CapturePerspective("chapter00_zone_c_grass_band.png",
                new Vector3(-12f, 7.7f, 39f), new Vector3(-5f, 6.2f, 52f), 62f);
            CapturePerspective("chapter00_zone_d_dome_reveal.png",
                new Vector3(1.5f, 8.5f, 73.5f), new Vector3(0f, 20f, 126f), 58f);
            CapturePerspective("chapter00_zone_e_corridor1.png",
                new Vector3(30f, 8.9f, 96.2f), new Vector3(34.2f, 10.5f, 108.8f), 62f);
            CaptureFacilityCloseFromCommandLine();
        }

        private static void Capture(Vector3 cameraPosition, float orthographicHalfSize, string outputPath)
        {
            Scene scene = EnsureSceneSet();

            Directory.CreateDirectory(Path.GetDirectoryName(outputPath) ?? k_OutputFolder);
            GameObject cameraObject = new GameObject("Chapter00RingOverviewCamera");
            SceneManager.MoveGameObjectToScene(cameraObject, scene);
            Camera camera = cameraObject.AddComponent<Camera>();
            camera.orthographic = true;
            camera.orthographicSize = orthographicHalfSize;
            camera.nearClipPlane = 0.1f;
            camera.farClipPlane = 800f;
            camera.clearFlags = CameraClearFlags.Skybox;
            camera.allowHDR = true;
            camera.transform.SetPositionAndRotation(
                cameraPosition,
                Quaternion.Euler(90f, 0f, 0f));
            cameraObject.AddComponent<HDAdditionalCameraData>();

            RenderTexture target = new RenderTexture(
                k_Size, k_Size, 24, RenderTextureFormat.ARGB32, RenderTextureReadWrite.sRGB);
            Texture2D readback = new Texture2D(k_Size, k_Size, TextureFormat.RGB24, false);

            try
            {
                camera.targetTexture = target;

                RenderPipeline.StandardRequest request = new RenderPipeline.StandardRequest
                {
                    destination = target
                };

                for (int frame = 0; frame < 8; frame++)
                {
                    camera.SubmitRenderRequest(request);
                }

                RenderTexture previous = RenderTexture.active;
                RenderTexture.active = target;
                readback.ReadPixels(new Rect(0f, 0f, k_Size, k_Size), 0, 0);
                readback.Apply();
                RenderTexture.active = previous;
                File.WriteAllBytes(outputPath, readback.EncodeToPNG());
                Debug.Log($"Chapter00RingOverviewCapture: wrote {outputPath}; "
                    + $"center=({cameraPosition.x},{cameraPosition.z}), world coverage="
                    + $"{orthographicHalfSize * 2f}m x {orthographicHalfSize * 2f}m, north=top.");
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

        private static void CapturePerspective(
            string fileName,
            Vector3 cameraPosition,
            Vector3 target,
            float fieldOfView)
        {
            Scene scene = EnsureSceneSet();
            const int width = 1600;
            const int height = 900;
            string outputPath = k_OutputFolder + "/" + fileName;
            Directory.CreateDirectory(k_OutputFolder);
            GameObject cameraObject = new GameObject("Chapter00ReviewCamera");
            SceneManager.MoveGameObjectToScene(cameraObject, scene);
            Camera camera = cameraObject.AddComponent<Camera>();
            camera.fieldOfView = fieldOfView;
            camera.nearClipPlane = 0.08f;
            camera.farClipPlane = 500f;
            camera.clearFlags = CameraClearFlags.Skybox;
            camera.allowHDR = true;
            camera.transform.SetPositionAndRotation(
                cameraPosition,
                Quaternion.LookRotation((target - cameraPosition).normalized, Vector3.up));
            cameraObject.AddComponent<HDAdditionalCameraData>();
            RenderTexture render = new RenderTexture(
                width, height, 24, RenderTextureFormat.ARGB32, RenderTextureReadWrite.sRGB);
            Texture2D readback = new Texture2D(width, height, TextureFormat.RGB24, false);

            try
            {
                camera.targetTexture = render;
                RenderPipeline.StandardRequest request = new RenderPipeline.StandardRequest { destination = render };
                for (int frame = 0; frame < 8; frame++) camera.SubmitRenderRequest(request);
                RenderTexture previous = RenderTexture.active;
                RenderTexture.active = render;
                readback.ReadPixels(new Rect(0f, 0f, width, height), 0, 0);
                readback.Apply();
                RenderTexture.active = previous;
                File.WriteAllBytes(outputPath, readback.EncodeToPNG());
                Debug.Log($"Chapter00RingOverviewCapture: wrote {outputPath}; camera={cameraPosition}, "
                    + $"target={target}, FOV={fieldOfView:F0}.");
            }
            finally
            {
                camera.targetTexture = null;
                Object.DestroyImmediate(readback);
                render.Release();
                Object.DestroyImmediate(render);
                Object.DestroyImmediate(cameraObject);
            }
        }

        private static Scene EnsureSceneSet()
        {
            Scene scene;
            if (!TerrainSceneUtility.TryOpenTargetScene(
                    k_EnvironmentScene, nameof(Chapter00RingOverviewCapture), out scene))
            {
                throw new System.InvalidOperationException("Could not open Main_Environment.");
            }

            Scene secondary = SceneManager.GetSceneByPath(k_EnvironmentScene2);
            if (File.Exists(k_EnvironmentScene2) && (!secondary.IsValid() || !secondary.isLoaded))
            {
                EditorSceneManager.OpenScene(k_EnvironmentScene2, OpenSceneMode.Additive);
            }
            return scene;
        }
    }
}
