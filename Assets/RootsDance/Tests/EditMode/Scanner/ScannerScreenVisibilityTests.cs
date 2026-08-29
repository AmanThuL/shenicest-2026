using System.Reflection;
using NUnit.Framework;
using RootsDance.Scanner;
using RootsDance.UI;
using RootsDance.UI.Kit;
using Unity.Cinemachine;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Scanner
{
    /// <summary>
    /// The report has to be <i>visible</i>, not merely present: on the outward face of the plate,
    /// inside the inspect camera's frustum, facing it, and carrying text once the report is opened.
    /// <para>
    /// <see cref="ScannerScreenFitTests"/> already checks that the canvas is the size of the plate,
    /// but a canvas can be exactly the right size and still draw nothing a player ever sees — behind
    /// the plate, behind the camera, or empty. Each assertion here corresponds to one way the screen
    /// has gone blank in play, and every one of them logs the numbers it measured, so a failure says
    /// which of the four it was.
    /// </para>
    /// </summary>
    public class ScannerScreenVisibilityTests
    {
        private const string k_Prefab = "Assets/RootsDance/Prefabs/Props/Scanner.prefab";

        private GameObject m_instance;

        [SetUp]
        public void SetUp()
        {
            GameObject prefab = AssetDatabase.LoadAssetAtPath<GameObject>(k_Prefab);
            Assert.IsNotNull(prefab, "The scanner prefab is missing; build it first.");

            m_instance = (GameObject)PrefabUtility.InstantiatePrefab(prefab);

            // The two components that write the pose are [ExecuteAlways] but their OnEnable does
            // not run on an editor instantiate, so the poses are the ones serialized in the prefab
            // until they are asked for again. Asking is the point: a stale serialized pose that
            // disagrees with the code is exactly the bug class under test.
            Surface().Apply();
            Framing().Apply();
        }

        [TearDown]
        public void TearDown()
        {
            if (m_instance != null)
            {
                Object.DestroyImmediate(m_instance);
            }
        }

        [Test]
        public void Canvas_SitsOnTheLitSideOfThePlate()
        {
            Transform plate = Plate();
            Vector3 outward = OutwardNormal(plate);
            Transform canvas = Surface().transform;

            float standoff = Vector3.Dot(canvas.position - plate.position, outward);

            Debug.Log($"[scanner] outward {outward} standoff {standoff * 1000f:F3} mm "
                + $"canvas forward·outward {Vector3.Dot(canvas.forward, outward):F3}");

            Assert.Greater(standoff, 0f,
                "The report canvas is on the far side of the plate, so the plate hides it.");

            // A world-space canvas is read from its forward: forward has to point away from the
            // viewer, into the plate, or the screen renders mirrored.
            Assert.Less(Vector3.Dot(canvas.forward, outward), -0.9f,
                "The canvas faces out of the plate, so the report draws mirrored.");
        }

        [Test]
        public void InspectCamera_LooksAtTheFrontOfTheCanvas()
        {
            CinemachineCamera camera = Camera();
            Transform canvas = Surface().transform;
            Transform eye = camera.transform;

            Vector3 toCanvas = canvas.position - eye.position;
            float distance = toCanvas.magnitude;
            float alignment = Vector3.Dot(toCanvas.normalized, eye.forward);
            float facing = Vector3.Dot(canvas.forward, eye.forward);

            Debug.Log($"[scanner] camera at {eye.position} distance {distance:F4} m "
                + $"alignment {alignment:F4} facing {facing:F4} fov {camera.Lens.FieldOfView}");

            Assert.Greater(alignment, 0.999f,
                "The inspect camera is not pointed at the middle of the screen.");
            Assert.Greater(facing, 0.9f,
                "The camera is behind the canvas, so it sees the back of the report.");
            Assert.Greater(distance, camera.Lens.NearClipPlane,
                "The screen is closer than the near clip plane, so it is clipped away.");
        }

        [Test]
        public void Canvas_FitsInsideTheInspectCameraViewport()
        {
            CinemachineCamera camera = Camera();
            Transform eye = camera.transform;
            var rect = (RectTransform)Surface().transform;
            var corners = new Vector3[4];
            rect.GetWorldCorners(corners);

            float halfFov = camera.Lens.FieldOfView * 0.5f * Mathf.Deg2Rad;
            float worst = 0f;

            for (int i = 0; i < corners.Length; i++)
            {
                Vector3 local = eye.InverseTransformPoint(corners[i]);
                Assert.Greater(local.z, 0f, $"Corner {i} is behind the camera.");

                float angle = Mathf.Atan2(Mathf.Abs(local.y), local.z);
                worst = Mathf.Max(worst, angle / halfFov);
            }

            Debug.Log($"[scanner] worst corner fills {worst * 100f:F1}% of the half-viewport");

            Assert.Less(worst, 1f, "The screen overflows the viewport it is framed for.");
        }

        [Test]
        public void InspectCamera_ReadsTheReportUprightHoweverTheScannerIsHeld()
        {
            // The scanner is held in a hand, so the plate is never level with the world. A camera
            // that keeps the world horizon level instead of the screen's own up lands with the
            // report turned on its side — which is what a player sees as having to tilt their head.
            m_instance.transform.rotation = Quaternion.Euler(23f, 41f, 57f);

            ScannerInspectFraming framing = Framing();
            framing.Apply();

            CinemachineCamera camera = Camera();
            Transform eye = camera.transform;
            Vector3 screenUp = eye.InverseTransformDirection(Surface().transform.up);
            float tilt = Vector3.Angle(new Vector3(screenUp.x, screenUp.y, 0f), Vector3.up);

            Debug.Log($"[scanner] report tilt in view {tilt:F2}°");

            Assert.Less(tilt, 1f,
                "The report is turned in the viewport: up on the screen is not up on the display.");
        }

        [Test]
        public void Open_ActivatesTheReportAndPrintsAPage()
        {
            ScannerReportPresenter presenter =
                m_instance.GetComponentInChildren<ScannerReportPresenter>(true);
            Assert.IsNotNull(presenter, "The scanner carries no report presenter.");

            var root = (GameObject)Field(presenter, "m_root");
            Assert.IsNotNull(root, "The presenter has no root to switch on.");

            presenter.Open();

            Assert.IsTrue(root.activeInHierarchy,
                "Opening the report left its root switched off, so the screen stays blank.");

            var title = (ThemedText)Field(presenter, "m_titleLabel");
            var body = (ThemedText)Field(presenter, "m_bodyLabel");

            Debug.Log($"[scanner] title '{(title == null ? "<none>" : title.Text)}' "
                + $"body {(body == null ? 0 : body.Text.Length)} chars");

            Assert.IsNotNull(title, "The page has no title label.");
            Assert.IsNotEmpty(title.Text, "The first page printed no title.");

            // A label can hold text and still submit nothing: TMP needs the canvas to carry the
            // extra vertex channels its SDF shaders read.
            var canvas = m_instance.GetComponentInChildren<Canvas>(true);
            Assert.IsNotNull(canvas, "The report has no canvas.");

            const AdditionalCanvasShaderChannels k_Needed = AdditionalCanvasShaderChannels.TexCoord1
                | AdditionalCanvasShaderChannels.Normal
                | AdditionalCanvasShaderChannels.Tangent;

            Debug.Log($"[scanner] canvas channels {canvas.additionalShaderChannels}");

            Assert.AreEqual(k_Needed, canvas.additionalShaderChannels & k_Needed,
                "The canvas drops the vertex channels TextMeshPro reads, so no glyph is drawn.");
        }

        private ScannerScreenSurface Surface()
        {
            var surface = m_instance.GetComponentInChildren<ScannerScreenSurface>(true);
            Assert.IsNotNull(surface, "The scanner prefab has no screen surface.");
            return surface;
        }

        private ScannerInspectFraming Framing()
        {
            var framing = m_instance.GetComponentInChildren<ScannerInspectFraming>(true);
            Assert.IsNotNull(framing, "The scanner prefab has no inspect framing.");
            return framing;
        }

        private CinemachineCamera Camera()
        {
            var camera = m_instance.GetComponentInChildren<CinemachineCamera>(true);
            Assert.IsNotNull(camera, "The scanner prefab has no inspect camera.");
            return camera;
        }

        private Transform Plate()
        {
            foreach (Renderer renderer in m_instance.GetComponentsInChildren<Renderer>(true))
            {
                if (renderer.gameObject.name == "Screen")
                {
                    return renderer.transform;
                }
            }

            Assert.Fail("No 'Screen' plate under the scanner.");
            return null;
        }

        /// <summary>
        /// Which way the plate faces, taken from its own mesh normals — the same cue the builder
        /// used, so a re-export that flips them shows up here rather than in play.
        /// </summary>
        private static Vector3 OutwardNormal(Transform plate)
        {
            var filter = plate.GetComponent<MeshFilter>();
            Assert.IsNotNull(filter, "The plate carries no mesh.");

            Vector3[] normals = filter.sharedMesh.normals;
            Vector3 sum = Vector3.zero;

            for (int i = 0; i < normals.Length; i++)
            {
                sum += normals[i];
            }

            return plate.TransformDirection(sum.normalized).normalized;
        }

        private static object Field(object target, string name)
        {
            FieldInfo info = target.GetType().GetField(
                name, BindingFlags.Instance | BindingFlags.NonPublic);

            Assert.IsNotNull(info, $"No field '{name}' on {target.GetType().Name}.");

            return info.GetValue(target);
        }
    }
}
