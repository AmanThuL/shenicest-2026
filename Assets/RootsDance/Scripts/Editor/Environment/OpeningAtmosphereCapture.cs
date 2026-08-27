using System.IO;
using System.Text;
using RootsDance.Editor.Terrain;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Renders the opening route's viewpoints headlessly (batch mode or menu) so the atmosphere can be checked
    /// without an interactive Editor: one PNG per route node looking along the route, one elevated shot, and a
    /// text file with the fog values HDRP actually blended at each camera position. Never saves the scene.
    /// </summary>
    public static class OpeningAtmosphereCapture
    {
        public const string k_DefaultOutputFolder = "Logs/Captures";

        private const string k_LogPrefix = "OpeningAtmosphereCapture";
        private const string k_CameraName = "OpeningCaptureCamera";
        private const int k_Width = 1280;
        private const int k_Height = 720;
        private const int k_WarmUpFrames = 4;
        private const float k_FieldOfView = 70f;

        [MenuItem("RootsDance/Environment/Capture Opening Viewpoints")]
        public static void CaptureFromMenu()
        {
            Capture(OpeningAtmosphereParams.CreateDefault(), k_DefaultOutputFolder);
        }

        /// <summary>
        /// Batch entry point:
        /// <c>-executeMethod RootsDance.Editor.Environment.OpeningAtmosphereCapture.CaptureFromCommandLine</c>.
        /// Throws so the Editor exits with code 1 when anything fails.
        /// </summary>
        public static void CaptureFromCommandLine()
        {
            if (!Capture(OpeningAtmosphereParams.CreateDefault(), k_DefaultOutputFolder))
            {
                throw new System.InvalidOperationException($"{k_LogPrefix}: capture failed — see the log above.");
            }
        }

        /// <summary>
        /// Batch tuning loop in one Editor session: rebuild with profile overwrite, then capture.
        /// <c>-executeMethod
        /// RootsDance.Editor.Environment.OpeningAtmosphereCapture.RebuildAndCaptureFromCommandLine</c>.
        /// </summary>
        public static void RebuildAndCaptureFromCommandLine()
        {
            OpeningAtmosphereBuilder.RebuildFromCommandLine();
            CaptureFromCommandLine();
        }

        /// <summary>
        /// Renders every viewpoint into <paramref name="outputFolder"/>. Returns false after logging on failure.
        /// </summary>
        public static bool Capture(OpeningAtmosphereParams p, string outputFolder)
        {
            Scene scene;

            if (!TerrainSceneUtility.TryOpenTargetScene(p.ScenePath, k_LogPrefix, out scene))
            {
                return false;
            }

            Directory.CreateDirectory(outputFolder);

            GameObject cameraObject = new GameObject(k_CameraName);
            Camera camera = cameraObject.AddComponent<Camera>();
            camera.fieldOfView = k_FieldOfView;
            camera.nearClipPlane = 0.1f;
            camera.farClipPlane = 1000f;
            cameraObject.AddComponent<HDAdditionalCameraData>();

            RenderTexture target = new RenderTexture(k_Width, k_Height, 24, RenderTextureFormat.ARGB32);
            Texture2D readback = new Texture2D(k_Width, k_Height, TextureFormat.RGB24, false);
            StringBuilder report = new StringBuilder();

            try
            {
                for (int i = 0; i < p.RouteNodes.Length; i++)
                {
                    Vector3 position = p.RouteNodes[i];
                    Vector3 lookTarget = i + 1 < p.RouteNodes.Length ? p.RouteNodes[i + 1] : position + Vector3.forward;
                    CaptureOne(camera, target, readback, position, lookTarget, $"{i:00}_route", outputFolder, report);
                }

                // Elevated shot above the wake, looking north: shows how the height fog thins with altitude.
                Vector3 wake = p.RouteNodes[0];
                CaptureOne(camera, target, readback, wake + Vector3.up * 20f, wake + Vector3.forward * 60f,
                    "90_elevated", outputFolder, report);

                // Looking back south from the wake: the closed side must read denser than the exit.
                CaptureOne(camera, target, readback, wake, wake + Vector3.back * 10f, "91_wake_back",
                    outputFolder, report);

                File.WriteAllText(Path.Combine(outputFolder, "captures.txt"), report.ToString());
                Debug.Log($"{k_LogPrefix}: wrote captures to {outputFolder}\n{report}");
                return true;
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

        private static void CaptureOne(Camera camera, RenderTexture target, Texture2D readback, Vector3 position,
            Vector3 lookTarget, string name, string outputFolder, StringBuilder report)
        {
            camera.transform.position = position;
            Vector3 direction = lookTarget - position;
            direction.y = 0f;

            if (direction.sqrMagnitude < 0.001f)
            {
                direction = Vector3.forward;
            }

            camera.transform.rotation = Quaternion.LookRotation(direction.normalized, Vector3.up);
            camera.targetTexture = target;

            // Volumetric fog reprojects over frames; render a few times so the last frame is settled.
            for (int frame = 0; frame < k_WarmUpFrames; frame++)
            {
                camera.Render();
            }

            RenderTexture previous = RenderTexture.active;
            RenderTexture.active = target;
            readback.ReadPixels(new Rect(0, 0, k_Width, k_Height), 0, 0);
            readback.Apply();
            RenderTexture.active = previous;

            string path = Path.Combine(outputFolder, name + ".png");
            File.WriteAllBytes(path, readback.EncodeToPNG());

            // HDRP keeps a stack per camera; the manager's default stack is not this camera's. Blend the volumes
            // for this position into a scratch stack to report what the camera actually rendered with.
            VolumeStack stack = VolumeManager.instance.CreateStack();

            try
            {
                HDAdditionalCameraData cameraData = camera.GetComponent<HDAdditionalCameraData>();
                VolumeManager.instance.Update(stack, camera.transform, cameraData.volumeLayerMask);
                Fog fog = stack.GetComponent<Fog>();
                Exposure exposure = stack.GetComponent<Exposure>();
                report.Append(name).Append(" pos=").Append(position.ToString("F1"))
                    .Append(" fogAttenuation=").Append(fog.meanFreePath.value.ToString("F1"))
                    .Append(" baseHeight=").Append(fog.baseHeight.value.ToString("F1"))
                    .Append(" maxHeight=").Append(fog.maximumHeight.value.ToString("F1"))
                    .Append(" volumetric=").Append(fog.enableVolumetricFog.value)
                    .Append(" fixedEV=").Append(exposure.fixedExposure.value.ToString("F2"))
                    .Append('\n');
            }
            finally
            {
                VolumeManager.instance.DestroyStack(stack);
            }
        }
    }
}
