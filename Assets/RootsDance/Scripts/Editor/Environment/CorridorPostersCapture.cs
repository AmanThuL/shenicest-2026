using System.IO;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Renders the corridor posters headlessly so the dressing can be checked without an
    /// interactive Editor: one shot per marked sheet with the beam aimed at it, plus a look down
    /// the corridor. Opens Main_Environment and Main_Environment_2 to read and never saves either.
    /// </summary>
    /// <remarks>
    /// The reveal is driven by shader globals that FlashlightBeamBroadcaster normally writes each
    /// frame from the player's torch. There is no player in a capture, so the globals are written
    /// here instead - without them every mark stays dark and the shot proves nothing.
    /// </remarks>
    public static class CorridorPostersCapture
    {
        private const string k_Environment = "Assets/RootsDance/Scenes/Levels/Main/Main_Environment.unity";
        private const string k_Scene = "Assets/RootsDance/Scenes/Levels/Main/Main_Environment_2.unity";
        private const string k_OutputFolder = "Logs/Captures/CorridorPosters";

        /// <summary>The hand-placed group node whose children are the corridor's posters.</summary>
        private const string k_GroupName = "LabCorridorPosters";

        private const int k_Width = 1280;
        private const int k_Height = 720;
        private const int k_WarmUpFrames = 4;
        private const float k_FieldOfView = 70f;

        /// <summary>Metres the camera stands back from a sheet, and the beam's reach and cone.</summary>
        private const float k_StandBack = 1.7f;
        private const float k_BeamRange = 12f;
        private const float k_OuterDegrees = 26f;
        private const float k_InnerDegrees = 13f;

        private static readonly int k_PositionId = Shader.PropertyToID("_RootsFlashlightPosition");
        private static readonly int k_DirectionId = Shader.PropertyToID("_RootsFlashlightDirection");
        private static readonly int k_ConeId = Shader.PropertyToID("_RootsFlashlightCone");

        [MenuItem("RootsDance/Environment/Capture Corridor Posters")]
        public static void Capture()
        {
            EditorSceneManager.OpenScene(k_Environment, OpenSceneMode.Single);
            EditorSceneManager.OpenScene(k_Scene, OpenSceneMode.Additive);

            Directory.CreateDirectory(k_OutputFolder);

            GameObject cameraObject = new GameObject("CorridorCaptureCamera");
            Camera camera = cameraObject.AddComponent<Camera>();
            camera.fieldOfView = k_FieldOfView;
            camera.nearClipPlane = 0.05f;
            camera.farClipPlane = 500f;
            cameraObject.AddComponent<HDAdditionalCameraData>();

            RenderTexture target = new RenderTexture(k_Width, k_Height, 24, RenderTextureFormat.ARGB32);
            Texture2D readback = new Texture2D(k_Width, k_Height, TextureFormat.RGB24, false);

            try
            {
                Bounds all = new Bounds();
                bool first = true;
                int shot = 0;

                foreach (GameObject poster in Posters())
                {
                    Renderer renderer = poster.GetComponentInChildren<Renderer>();

                    if (renderer == null)
                    {
                        continue;
                    }

                    if (first)
                    {
                        all = renderer.bounds;
                        first = false;
                    }
                    else
                    {
                        all.Encapsulate(renderer.bounds);
                    }

                    // The sheet's face is its thinnest axis; stand off it along whichever end of
                    // that axis is not buried in the wall.
                    Vector3 face = Face(poster, renderer);
                    Vector3 eye = renderer.bounds.center + face * k_StandBack;

                    Aim(eye, renderer.bounds.center);
                    Shoot(camera, target, readback, eye, renderer.bounds.center,
                        $"{shot:00}_{poster.name.Replace(' ', '_')}");
                    shot++;
                }

                if (first)
                {
                    Debug.LogError("CorridorPostersCapture: no corridor posters in the scene.");
                    return;
                }

                // One look down the whole run, from outside the sheets rather than among them.
                Vector3 along = all.size.z >= all.size.x ? Vector3.forward : Vector3.right;
                Vector3 wide = all.center - along * (all.size.magnitude * 0.5f + 3f);
                wide.y = all.center.y;

                Aim(wide, all.center);
                Shoot(camera, target, readback, wide, all.center, "99_along_corridor");

                Debug.Log($"CorridorPostersCapture: wrote {shot + 1} shots to {k_OutputFolder}.");
            }
            finally
            {
                Object.DestroyImmediate(cameraObject);
                target.Release();
                Object.DestroyImmediate(target);
                Object.DestroyImmediate(readback);
            }
        }

        /// <summary>Points the stand-in torch from the camera at what the camera is looking at.</summary>
        private static void Aim(Vector3 eye, Vector3 at)
        {
            Vector3 direction = (at - eye).normalized;

            Shader.SetGlobalVector(k_PositionId, eye);
            Shader.SetGlobalVector(k_DirectionId, direction);
            Shader.SetGlobalVector(k_ConeId, new Vector4(
                Mathf.Cos(k_OuterDegrees * Mathf.Deg2Rad),
                Mathf.Cos(k_InnerDegrees * Mathf.Deg2Rad),
                k_BeamRange,
                1f));
        }

        /// <summary>Which way a hung sheet looks: the end of its thin axis that faces the room.</summary>
        private static Vector3 Face(GameObject poster, Renderer renderer)
        {
            MeshFilter filter = poster.GetComponentInChildren<MeshFilter>();
            Bounds local = filter.sharedMesh.bounds;
            int axis = local.extents.x <= local.extents.y && local.extents.x <= local.extents.z
                ? 0
                : local.extents.y <= local.extents.z ? 1 : 2;

            Vector3 normal = filter.transform.TransformDirection(
                axis == 0 ? Vector3.right : axis == 1 ? Vector3.up : Vector3.forward).normalized;

            // A rune overlay only exists on the printed side, so it settles which end is the front.
            Transform glow = FindGlow(poster.transform);

            if (glow != null
                && Vector3.Dot(glow.position - renderer.bounds.center, normal) < 0f)
            {
                normal = -normal;
            }

            return normal;
        }

        private static void Shoot(Camera camera, RenderTexture target, Texture2D readback,
            Vector3 eye, Vector3 at, string name)
        {
            camera.transform.position = eye;
            camera.transform.rotation = Quaternion.LookRotation((at - eye).normalized, Vector3.up);
            camera.targetTexture = target;

            // HDRP settles volumetrics and exposure over a few frames; one render is still black.
            for (int i = 0; i < k_WarmUpFrames; i++)
            {
                camera.Render();
            }

            RenderTexture previous = RenderTexture.active;
            RenderTexture.active = target;
            readback.ReadPixels(new Rect(0, 0, k_Width, k_Height), 0, 0);
            readback.Apply();
            RenderTexture.active = previous;
            camera.targetTexture = null;

            File.WriteAllBytes(Path.Combine(k_OutputFolder, name + ".png"), readback.EncodeToPNG());
        }

        /// <summary>The marked sheets under the group node, in the order the builder marked them.</summary>
        private static System.Collections.Generic.List<GameObject> Posters()
        {
            System.Collections.Generic.List<GameObject> found =
                new System.Collections.Generic.List<GameObject>();

            for (int i = 0; i < SceneManager.sceneCount; i++)
            {
                foreach (GameObject root in SceneManager.GetSceneAt(i).GetRootGameObjects())
                {
                    if (root.name != k_GroupName)
                    {
                        continue;
                    }

                    foreach (Transform child in root.transform)
                    {
                        // Only what actually carries a mark: an unmarked prop in the group has
                        // nothing for this capture to prove.
                        if (child.GetComponentInChildren<MeshFilter>() != null
                            && FindGlow(child) != null)
                        {
                            found.Add(child.gameObject);
                        }
                    }
                }
            }

            found.Sort((a, b) => string.CompareOrdinal(a.name, b.name));

            return found;
        }

        private static Transform FindGlow(Transform poster)
        {
            foreach (Transform t in poster.GetComponentsInChildren<Transform>())
            {
                if (t.name == "RuneGlow")
                {
                    return t;
                }
            }

            return null;
        }
    }
}
