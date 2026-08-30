using System.Collections.Generic;
using System.IO;
using System.Text;
using RootsDance.Editor.DevPlay;
using RootsDance.Editor.Terrain;
using RootsDance.Environment;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Renders the Main level at every Dev Play checkpoint with the Night preset applied and a stand-in
    /// flashlight on the camera, headlessly (batch mode or menu), so the night look and the fog cone can be
    /// checked without an interactive Editor. Edit-mode only: the TimeOfDayController does not run here, so
    /// the preset is applied by hand to the same Volume and Sun it drives in Play. Never saves the scene.
    /// </summary>
    public static class TimeOfDayCapture
    {
        public const string k_DefaultOutputFolder = "Logs/Captures/TimeOfDay";

        private const string k_LogPrefix = "TimeOfDayCapture";
        private const string k_ScenePath = "Assets/RootsDance/Scenes/Levels/Main/Main_Environment.unity";
        private const string k_NightPresetPath = "Assets/RootsDance/Data/Config/TimeOfDay/Night.asset";
        private const string k_PlayerPrefabPath = "Assets/RootsDance/Prefabs/Characters/Player.prefab";
        private const string k_CheckpointFolder = "Assets/RootsDance/Data/DevPlay";
        private const string k_LightingRootName = "_Lighting";
        private const string k_TimeOfDayName = "TimeOfDay";
        private const string k_SunName = "Sun";
        private const string k_HeadName = "Head";
        private const string k_FlashlightPath = "Head/Flashlight";
        private const string k_AnchorsRootName = "_Anchors";
        private const string k_CameraName = "TimeOfDayCaptureCamera";
        private const int k_Width = 1280;
        private const int k_Height = 720;
        private const int k_WarmUpFrames = 6;
        private const float k_FieldOfView = 70f;
        private const float k_RayStart = 50f;
        private const float k_RayLength = 200f;

        [MenuItem("RootsDance/Environment/Capture Time Of Day Viewpoints")]
        public static void CaptureFromMenu()
        {
            Capture(k_DefaultOutputFolder);
        }

        /// <summary>
        /// Batch entry point:
        /// <c>-executeMethod RootsDance.Editor.Environment.TimeOfDayCapture.CaptureFromCommandLine</c>.
        /// Throws so the Editor exits with code 1 when anything fails.
        /// </summary>
        public static void CaptureFromCommandLine()
        {
            if (!Capture(k_DefaultOutputFolder))
            {
                throw new System.InvalidOperationException($"{k_LogPrefix}: capture failed — see the log above.");
            }
        }

        /// <summary>
        /// Batch tuning loop in one Editor session: reset NightProfile and the presets to the seed values in
        /// TimeOfDayBuilder, then capture.
        /// <c>-executeMethod RootsDance.Editor.Environment.TimeOfDayCapture.RebuildAndCaptureFromCommandLine</c>.
        /// </summary>
        public static void RebuildAndCaptureFromCommandLine()
        {
            TimeOfDayBuilder.RebuildFromCommandLine();
            CaptureFromCommandLine();
        }

        /// <summary>Renders every checkpoint into <paramref name="outputFolder"/>. Returns false after logging.</summary>
        public static bool Capture(string outputFolder)
        {
            Scene scene;

            if (!TerrainSceneUtility.TryOpenTargetScene(k_ScenePath, k_LogPrefix, out scene))
            {
                return false;
            }

            TimeOfDayPresetSO night = AssetDatabase.LoadAssetAtPath<TimeOfDayPresetSO>(k_NightPresetPath);

            if (night == null)
            {
                Debug.LogError($"{k_LogPrefix}: '{k_NightPresetPath}' not found; run Build Time Of Day first.");
                return false;
            }

            Volume volume;
            Light sun;

            if (!TryFindLighting(scene, out volume, out sun))
            {
                return false;
            }

            List<DevCheckpointSO> checkpoints = LoadCheckpoints();

            if (checkpoints.Count == 0)
            {
                Debug.LogError($"{k_LogPrefix}: no DevCheckpointSO assets under {k_CheckpointFolder}.");
                return false;
            }

            Directory.CreateDirectory(outputFolder);

            GameObject cameraObject = new GameObject(k_CameraName);
            Camera camera = cameraObject.AddComponent<Camera>();
            camera.fieldOfView = k_FieldOfView;
            camera.nearClipPlane = 0.1f;
            camera.farClipPlane = 1000f;
            cameraObject.AddComponent<HDAdditionalCameraData>();

            Light flashlight = CreateFlashlight(cameraObject.transform);
            RenderTexture target = new RenderTexture(k_Width, k_Height, 24, RenderTextureFormat.ARGB32);
            Texture2D readback = new Texture2D(k_Width, k_Height, TextureFormat.RGB24, false);
            StringBuilder report = new StringBuilder();
            LightingSnapshot authored = LightingSnapshot.Take(volume, sun);
            Vector3 eyeOffset = ReadHeadOffset();
            Transform anchors = FindRoot(scene, k_AnchorsRootName);

            try
            {
                ApplyNight(night, volume, sun);
                Physics.SyncTransforms();

                for (int i = 0; i < checkpoints.Count; i++)
                {
                    DevCheckpointSO checkpoint = checkpoints[i];
                    Vector3 eye = ResolveEye(checkpoint, anchors) + eyeOffset;
                    Quaternion facing = Quaternion.Euler(0f, checkpoint.Yaw, 0f);
                    string name = $"{i:00}_{checkpoint.name}";

                    flashlight.enabled = true;
                    CaptureOne(camera, target, readback, eye, facing, name + "_torch", outputFolder, report);

                    if (i == 0)
                    {
                        // One dark reference at the wake: what the moon and sky alone give.
                        flashlight.enabled = false;
                        CaptureOne(camera, target, readback, eye, facing, name + "_dark", outputFolder, report);
                    }
                }

                File.WriteAllText(Path.Combine(outputFolder, "captures.txt"), report.ToString());
                Debug.Log($"{k_LogPrefix}: wrote captures to {outputFolder}\n{report}");
                return true;
            }
            finally
            {
                // Put the authored (day) lighting back so the open scene is left exactly as found — the night
                // look must never be baked into Main_Environment at weight 1 (TimeOfDayBuilder.EnsureVolume).
                authored.Restore(volume, sun);
                camera.targetTexture = null;
                Object.DestroyImmediate(readback);
                target.Release();
                Object.DestroyImmediate(target);
                Object.DestroyImmediate(cameraObject);
            }
        }

        /// <summary>The scene-authored values ApplyNight overwrites, so they can be restored afterwards.</summary>
        private struct LightingSnapshot
        {
            private VolumeProfile m_profile;
            private float m_weight;
            private LightUnit m_unit;
            private float m_intensity;
            private Color m_color;
            private float m_volumetricDimmer;

            public static LightingSnapshot Take(Volume volume, Light sun)
            {
                LightingSnapshot snapshot = new LightingSnapshot();
                snapshot.m_profile = volume.sharedProfile;
                snapshot.m_weight = volume.weight;
                snapshot.m_unit = sun.lightUnit;
                snapshot.m_intensity = sun.intensity;
                snapshot.m_color = sun.color;
                HDAdditionalLightData sunData = sun.GetComponent<HDAdditionalLightData>();
                snapshot.m_volumetricDimmer = sunData == null ? 1f : sunData.volumetricDimmer;
                return snapshot;
            }

            public void Restore(Volume volume, Light sun)
            {
                volume.sharedProfile = m_profile;
                volume.weight = m_weight;
                sun.lightUnit = m_unit;
                sun.intensity = m_intensity;
                sun.color = m_color;
                HDAdditionalLightData sunData = sun.GetComponent<HDAdditionalLightData>();

                if (sunData != null)
                {
                    sunData.volumetricDimmer = m_volumetricDimmer;
                }
            }
        }

        private static Transform FindRoot(Scene scene, string name)
        {
            GameObject[] roots = scene.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                if (roots[i].name == name)
                {
                    return roots[i].transform;
                }
            }

            return null;
        }

        /// <summary>Where the eye sits relative to the Player root: the prefab's Head local position.</summary>
        private static Vector3 ReadHeadOffset()
        {
            GameObject player = AssetDatabase.LoadAssetAtPath<GameObject>(k_PlayerPrefabPath);
            Transform head = player == null ? null : player.transform.Find(k_HeadName);
            return head == null ? Vector3.zero : head.localPosition;
        }

        private static bool TryFindLighting(Scene scene, out Volume volume, out Light sun)
        {
            volume = null;
            sun = null;
            GameObject[] roots = scene.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                if (roots[i].name != k_LightingRootName)
                {
                    continue;
                }

                Transform timeOfDay = roots[i].transform.Find(k_TimeOfDayName);
                Transform sunTransform = roots[i].transform.Find(k_SunName);
                volume = timeOfDay == null ? null : timeOfDay.GetComponent<Volume>();
                sun = sunTransform == null ? null : sunTransform.GetComponent<Light>();
            }

            if (volume == null || sun == null)
            {
                Debug.LogError($"{k_LogPrefix}: '{k_LightingRootName}/{k_TimeOfDayName}' Volume or "
                    + $"'{k_LightingRootName}/{k_SunName}' Light missing; run Build Time Of Day first.");
                return false;
            }

            return true;
        }

        private static List<DevCheckpointSO> LoadCheckpoints()
        {
            string[] guids = AssetDatabase.FindAssets("t:DevCheckpointSO", new[] { k_CheckpointFolder });
            List<DevCheckpointSO> checkpoints = new List<DevCheckpointSO>(guids.Length);

            for (int i = 0; i < guids.Length; i++)
            {
                DevCheckpointSO checkpoint =
                    AssetDatabase.LoadAssetAtPath<DevCheckpointSO>(AssetDatabase.GUIDToAssetPath(guids[i]));

                if (checkpoint != null)
                {
                    checkpoints.Add(checkpoint);
                }
            }

            checkpoints.Sort((a, b) => string.CompareOrdinal(a.name, b.name));
            return checkpoints;
        }

        /// <summary>Same as the controller's ApplyImmediate, done by hand because components do not run here.</summary>
        private static void ApplyNight(TimeOfDayPresetSO night, Volume volume, Light sun)
        {
            volume.sharedProfile = night.Profile;
            volume.weight = night.HasProfile ? 1f : 0f;
            sun.lightUnit = LightUnit.Lux;
            sun.intensity = night.SunIntensityLux;
            sun.color = night.SunColor;

            HDAdditionalLightData sunData = sun.GetComponent<HDAdditionalLightData>();

            if (sunData != null)
            {
                sunData.volumetricDimmer = night.SunVolumetricMultiplier;
            }
        }

        /// <summary>
        /// Copies the Player prefab's flashlight so the capture matches Play; falls back to the spec values when
        /// the installer has not run yet.
        /// </summary>
        private static Light CreateFlashlight(Transform parent)
        {
            GameObject flashlightObject = new GameObject("CaptureFlashlight");
            flashlightObject.transform.SetParent(parent, false);
            Light light = flashlightObject.AddComponent<Light>();
            HDAdditionalLightData data = flashlightObject.AddComponent<HDAdditionalLightData>();

            GameObject player = AssetDatabase.LoadAssetAtPath<GameObject>(k_PlayerPrefabPath);
            Transform source = player == null ? null : player.transform.Find(k_FlashlightPath);
            Light sourceLight = source == null ? null : source.GetComponent<Light>();

            if (sourceLight != null)
            {
                EditorUtility.CopySerialized(sourceLight, light);
                HDAdditionalLightData sourceData = source.GetComponent<HDAdditionalLightData>();

                if (sourceData != null)
                {
                    EditorUtility.CopySerialized(sourceData, data);
                }

                light.enabled = true;
                return light;
            }

            Debug.LogWarning($"{k_LogPrefix}: no '{k_FlashlightPath}' on the Player prefab; using stand-in values.");
            light.type = LightType.Spot;
            light.spotAngle = 36f;
            light.innerSpotAngle = 20f;
            light.range = 30f;
            light.enableSpotReflector = true;
            light.lightUnit = LightUnit.Lumen;
            // Light.intensity is natively candela for a spot; convert like PlayerFlashlightInstaller does.
            light.intensity = LightUnitUtils.ConvertIntensity(light, 2200f, LightUnit.Lumen, LightUnit.Candela);
            light.useColorTemperature = true;
            light.colorTemperature = 5000f;
            light.color = Color.white;
            light.shadows = LightShadows.Soft;
            data.volumetricDimmer = 1f;
            data.volumetricShadowDimmer = 0f;
            return light;
        }

        /// <summary>Same placement rule as DevPlaySession: the named _Anchors child wins, then Position.</summary>
        private static Vector3 ResolveEye(DevCheckpointSO checkpoint, Transform anchors)
        {
            Vector3 root = checkpoint.Position;

            if (!string.IsNullOrEmpty(checkpoint.AnchorName) && anchors != null)
            {
                Transform anchor = anchors.Find(checkpoint.AnchorName);

                if (anchor != null)
                {
                    root = anchor.position;
                }
            }

            if (checkpoint.SnapToGround)
            {
                RaycastHit hit;
                Vector3 origin = new Vector3(root.x, root.y + k_RayStart, root.z);

                if (Physics.Raycast(origin, Vector3.down, out hit, k_RayLength, ~0, QueryTriggerInteraction.Ignore))
                {
                    root.y = hit.point.y + checkpoint.GroundClearance;
                }
            }

            return root;
        }

        private static void CaptureOne(Camera camera, RenderTexture target, Texture2D readback, Vector3 position,
            Quaternion rotation, string name, string outputFolder, StringBuilder report)
        {
            camera.transform.SetPositionAndRotation(position, rotation);
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

            VolumeStack stack = VolumeManager.instance.CreateStack();

            try
            {
                HDAdditionalCameraData cameraData = camera.GetComponent<HDAdditionalCameraData>();
                VolumeManager.instance.Update(stack, camera.transform, cameraData.volumeLayerMask);
                Fog fog = stack.GetComponent<Fog>();
                Exposure exposure = stack.GetComponent<Exposure>();
                report.Append(name).Append(" pos=").Append(position.ToString("F1"))
                    .Append(" fogAttenuation=").Append(fog.meanFreePath.value.ToString("F1"))
                    .Append(" albedo=").Append(fog.albedo.value.ToString("F2"))
                    .Append(" anisotropy=").Append(fog.anisotropy.value.ToString("F2"))
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
