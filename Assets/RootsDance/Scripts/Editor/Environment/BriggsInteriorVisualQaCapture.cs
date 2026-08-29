using System.Collections.Generic;
using System.IO;
using UnityEditor;
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
        private const string k_OutputFolder = "Logs/VisualQA/briggs-interior-cleanup";
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
                Capture(camera, target, readback, "01_inside_entrance",
                    new Vector3(3f, 1.65f, -5.8f), new Vector3(0.1f, 1.05f, 0.4f));
                Capture(camera, target, readback, "02_inside_northwest_reverse",
                    new Vector3(-7.2f, 1.8f, 5.4f), new Vector3(0.2f, 1.1f, 0f));
                Capture(camera, target, readback, "03_inside_east_to_archives",
                    new Vector3(7.4f, 1.75f, -4.2f), new Vector3(-1.5f, 1.05f, 0.3f));
                Capture(camera, target, readback, "04_inside_ceiling_light_axis",
                    new Vector3(-4.5f, 1.6f, -4.8f), new Vector3(0f, 3.6f, 1.2f));

                Light exteriorQaFill = cameraObject.AddComponent<Light>();
                exteriorQaFill.type = LightType.Point;
                exteriorQaFill.intensity = 50000f;
                exteriorQaFill.range = 50f;
                exteriorQaFill.shadows = LightShadows.None;
                Capture(camera, target, readback, "05_outside_southwest",
                    new Vector3(-15f, 3.5f, -12f), new Vector3(0f, 2f, -2f));
                Capture(camera, target, readback, "06_outside_northeast",
                    new Vector3(15f, 3.5f, 12f), new Vector3(0f, 2f, 0f));
                exteriorQaFill.enabled = false;
                AuditPwbBounds(scene);
                Debug.Log($"BriggsInteriorVisualQaCapture: wrote six views to '{k_OutputFolder}'.");
            }
            finally
            {
                camera.targetTexture = null;
                Object.DestroyImmediate(readback);
                target.Release();
                Object.DestroyImmediate(target);
                Object.DestroyImmediate(cameraObject);
            }

            if (Application.isBatchMode)
            {
                EditorApplication.Exit(0);
            }
        }

        private static void AuditPwbBounds(Scene scene)
        {
            Transform pwb = null;
            GameObject[] roots = scene.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                if (roots[i].name == "Prefab World Builder")
                {
                    pwb = roots[i].transform;
                    break;
                }
            }

            if (pwb == null)
            {
                throw new System.InvalidOperationException("Briggs QA: Prefab World Builder root is missing.");
            }

            int checkedCount = 0;
            List<string> violations = new List<string>();

            for (int paletteIndex = 0; paletteIndex < pwb.childCount; paletteIndex++)
            {
                Transform pin = pwb.GetChild(paletteIndex).Find("PIN");

                if (pin == null)
                {
                    continue;
                }

                for (int instanceIndex = 0; instanceIndex < pin.childCount; instanceIndex++)
                {
                    Transform instance = pin.GetChild(instanceIndex);
                    Renderer[] renderers = instance.GetComponentsInChildren<Renderer>(true);

                    if (renderers.Length == 0)
                    {
                        continue;
                    }

                    Bounds bounds = renderers[0].bounds;

                    for (int rendererIndex = 1; rendererIndex < renderers.Length; rendererIndex++)
                    {
                        bounds.Encapsulate(renderers[rendererIndex].bounds);
                    }

                    bool outsideRoom = bounds.min.x < -9.5f || bounds.max.x > 9.5f
                        || bounds.min.y < -0.25f || bounds.max.y > 6f
                        || bounds.min.z < -7.5f || bounds.max.z > 7.5f;
                    bool oversized = bounds.size.x > 12f || bounds.size.y > 6f || bounds.size.z > 12f;

                    if (outsideRoom || oversized)
                    {
                        violations.Add($"{instance.name}: {bounds}");
                    }

                    checkedCount++;
                }
            }

            if (violations.Count > 0)
            {
                throw new System.InvalidOperationException(
                    "Briggs QA: PWB instances have invalid bounds:\n" + string.Join("\n", violations));
            }

            Debug.Log($"BriggsInteriorVisualQaCapture: PWB bounds audit passed for {checkedCount} instances.");
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
