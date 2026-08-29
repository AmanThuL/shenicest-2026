using System.IO;
using RootsDance.Scanner;
using RootsDance.UI;
using TMPro;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.SceneManagement;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Renders the scanner prop headlessly so the screen, its framing and the prop's orientation can
    /// be checked without an interactive Editor — the same trick
    /// <see cref="RootsDance.Editor.Environment.OpeningAtmosphereCapture"/> uses for the opening
    /// route. Two shots: what the player sees while reading, and a three-quarter view of the prop.
    /// <para>
    /// Opens a throwaway scene and never saves anything.
    /// </para>
    /// Menu: RootsDance > Capture Scanner Screen.
    /// </summary>
    public static class ScannerScreenCapture
    {
        public const string k_OutputFolder = "Logs/Captures";

        private const string k_Prefab = "Assets/RootsDance/Prefabs/Props/Scanner.prefab";
        private const int k_Width = 1280;
        private const int k_Height = 720;
        private const int k_WarmUpFrames = 6;

        [MenuItem("RootsDance/Capture Scanner Screen")]
        public static void CaptureFromMenu()
        {
            Capture();
        }

        /// <summary>Batch entry point. Throws so the Editor exits non-zero when anything fails.</summary>
        public static void CaptureFromCommandLine()
        {
            if (!Capture())
            {
                throw new System.InvalidOperationException(
                    "ScannerScreenCapture: capture failed — see the log above.");
            }
        }

        public static bool Capture()
        {
            GameObject prefab = AssetDatabase.LoadAssetAtPath<GameObject>(k_Prefab);

            if (prefab == null)
            {
                Debug.LogError($"ScannerScreenCapture: {k_Prefab} not found.");
                return false;
            }

            Scene scene = EditorSceneManager.NewScene(NewSceneSetup.EmptyScene, NewSceneMode.Single);
            Directory.CreateDirectory(k_OutputFolder);

            GameObject prop = (GameObject)PrefabUtility.InstantiatePrefab(prefab, scene);
            prop.transform.position = Vector3.zero;
            prop.transform.rotation = Quaternion.identity;

            GameObject lightObject = new GameObject("Key");
            Light light = lightObject.AddComponent<Light>();
            light.type = LightType.Directional;
            lightObject.AddComponent<HDAdditionalLightData>();
            lightObject.transform.rotation = Quaternion.Euler(38f, -140f, 0f);

            GameObject cameraObject = new GameObject("ScannerCaptureCamera");
            Camera camera = cameraObject.AddComponent<Camera>();
            camera.nearClipPlane = 0.005f;
            camera.farClipPlane = 20f;
            cameraObject.AddComponent<HDAdditionalCameraData>();

            RenderTexture target = new RenderTexture(k_Width, k_Height, 24, RenderTextureFormat.ARGB32);
            Texture2D readback = new Texture2D(k_Width, k_Height, TextureFormat.RGB24, false);
            bool ok = true;

            try
            {
                // The screen is only powered up while the player reads, so power it up by hand here.
                ScannerReportPresenter presenter = prop.GetComponentInChildren<ScannerReportPresenter>(true);

                if (presenter != null)
                {
                    presenter.Open();
                }

                // Nothing has ticked, so the labels still carry whatever mesh was serialized with
                // the prefab: without this the shot shows the authored text rather than the text
                // the report just wrote, which is worse than no witness at all.
                Canvas.ForceUpdateCanvases();

                foreach (TMP_Text label in prop.GetComponentsInChildren<TMP_Text>(true))
                {
                    label.ForceMeshUpdate();
                }

                Transform inspect = FindInspectCamera(prop.transform);

                if (inspect == null)
                {
                    Debug.LogError("ScannerScreenCapture: no InspectCamera under the prop.");
                    ok = false;
                }
                else
                {
                    ScannerInspectFraming framing = prop.GetComponent<ScannerInspectFraming>();

                    if (framing != null)
                    {
                        framing.Apply();
                    }

                    camera.fieldOfView = 34f;
                    Shoot(camera, target, readback, inspect.position, inspect.forward,
                        "scanner_inspect");
                }

                // Straight on to the screen from outside, far enough back to see the prop around
                // it: this is the shot that says whether the anchor faces out or into the body.
                if (inspect != null)
                {
                    Transform anchor = inspect.parent;
                    camera.fieldOfView = 40f;
                    Vector3 front = anchor.position - anchor.forward * 0.32f;
                    Shoot(camera, target, readback, front, anchor.forward, "scanner_screen_front");
                    Report(prop, anchor);
                }

                // Three-quarter view of the whole prop, framed on its bounds.
                Bounds bounds = Bound(prop);
                camera.fieldOfView = 40f;
                float radius = Mathf.Max(bounds.extents.magnitude, 0.05f);
                float distance = radius / Mathf.Tan(camera.fieldOfView * 0.5f * Mathf.Deg2Rad) * 1.6f;
                Vector3 eye = bounds.center
                    + new Vector3(0.6f, 0.45f, 0.66f).normalized * distance;
                Shoot(camera, target, readback, eye, (bounds.center - eye).normalized, "scanner_prop");
            }
            finally
            {
                RenderTexture.active = null;
                Object.DestroyImmediate(readback);
                target.Release();
                Object.DestroyImmediate(target);
            }

            Debug.Log($"ScannerScreenCapture: wrote captures to {k_OutputFolder}.");

            return ok;
        }

        private static void Shoot(Camera camera, RenderTexture target, Texture2D readback,
            Vector3 position, Vector3 forward, string name)
        {
            camera.transform.position = position;
            camera.transform.rotation = Quaternion.LookRotation(forward, Vector3.up);
            camera.targetTexture = target;

            // HDRP settles over a few frames; one Render() gives a half-lit first frame.
            for (int i = 0; i < k_WarmUpFrames; i++)
            {
                camera.Render();
            }

            RenderTexture previous = RenderTexture.active;
            RenderTexture.active = target;
            readback.ReadPixels(new Rect(0f, 0f, target.width, target.height), 0, 0);
            readback.Apply();
            RenderTexture.active = previous;
            camera.targetTexture = null;

            File.WriteAllBytes(Path.Combine(k_OutputFolder, name + ".png"), readback.EncodeToPNG());
        }

        /// <summary>
        /// Prints the numbers that decide whether the screen faces the right way: the anchor's world
        /// basis, its handedness, and the scale the model import left on the screen object. A
        /// negative scale anywhere up the chain mirrors the UI, which is otherwise hard to tell from
        /// a wrong normal.
        /// </summary>
        private static void Report(GameObject prop, Transform anchor)
        {
            Transform screen = anchor.parent;
            Bounds bounds = Bound(prop);
            float handedness = Vector3.Dot(Vector3.Cross(anchor.right, anchor.up), anchor.forward);
            Vector3 outward = anchor.position - bounds.center;

            Debug.Log("ScannerScreenCapture diagnostics:\n"
                + $"  screen lossyScale  {screen.lossyScale:F4}\n"
                + $"  anchor fwd/up/right {anchor.forward:F3} {anchor.up:F3} {anchor.right:F3}\n"
                + $"  handedness (want +1) {handedness:F3}\n"
                + $"  anchor->bodyCentre  {outward:F4}, dot(fwd, outward) "
                + $"{Vector3.Dot(anchor.forward, outward.normalized):F3} (want < 0 = reads inward)\n"
                + $"  canvas lossyScale   {anchor.GetChild(0).lossyScale:F6}");

            Renderer[] renderers = prop.GetComponentsInChildren<Renderer>(true);
            System.Text.StringBuilder materials = new System.Text.StringBuilder("  materials:\n");

            for (int i = 0; i < Mathf.Min(renderers.Length, 6); i++)
            {
                Material material = renderers[i].sharedMaterial;
                materials.Append($"    {renderers[i].name} -> ")
                    .Append(material == null ? "<none>" : material.name)
                    .Append(" / ")
                    .Append(material == null || material.shader == null ? "<none>" : material.shader.name)
                    .Append('\n');
            }

            Debug.Log(materials.ToString());
            ReportLabels(prop);
        }

        /// <summary>
        /// Prints what every label on the screen is actually drawn with. A diegetic screen fails
        /// silently: the glyphs are laid out and submitted whatever material they carry, so a label
        /// on TextMeshPro's own SDF shader is invisible at this canvas scale and looks like missing
        /// content. The sub-meshes are listed too — they are the objects TMP spawns for glyphs the
        /// primary face does not have, which on this screen is every Chinese character.
        /// </summary>
        private static void ReportLabels(GameObject prop)
        {
            var report = new System.Text.StringBuilder("  labels:\n");

            foreach (TMP_Text label in prop.GetComponentsInChildren<TMP_Text>(true))
            {
                label.ForceMeshUpdate();

                report.Append($"    {label.name} '{Trim(label.text)}' font ")
                    .Append(label.font == null ? "<none>" : label.font.name)
                    .Append(" / ")
                    .Append(Shader(label.fontSharedMaterial))
                    .Append('\n');
            }

            foreach (TMP_SubMeshUI sub in prop.GetComponentsInChildren<TMP_SubMeshUI>(true))
            {
                report.Append($"    ↳ sub {sub.name} font ")
                    .Append(sub.fontAsset == null ? "<none>" : sub.fontAsset.name)
                    .Append(" / ")
                    .Append(Shader(sub.sharedMaterial))
                    .Append('\n');
            }

            Debug.Log(report.ToString());
        }

        private static string Shader(Material material)
        {
            return material == null || material.shader == null
                ? "<none>"
                : material.shader.name;
        }

        private static string Trim(string text)
        {
            if (string.IsNullOrEmpty(text))
            {
                return string.Empty;
            }

            return text.Length <= 12 ? text : text.Substring(0, 12) + "…";
        }

        private static Transform FindInspectCamera(Transform root)
        {
            Transform[] all = root.GetComponentsInChildren<Transform>(true);

            for (int i = 0; i < all.Length; i++)
            {
                if (all[i].name == "InspectCamera")
                {
                    return all[i];
                }
            }

            return null;
        }

        private static Bounds Bound(GameObject prop)
        {
            Renderer[] renderers = prop.GetComponentsInChildren<Renderer>(true);
            Bounds bounds = new Bounds(prop.transform.position, Vector3.one * 0.1f);

            for (int i = 0; i < renderers.Length; i++)
            {
                if (i == 0)
                {
                    bounds = renderers[i].bounds;
                    continue;
                }

                bounds.Encapsulate(renderers[i].bounds);
            }

            return bounds;
        }
    }
}
