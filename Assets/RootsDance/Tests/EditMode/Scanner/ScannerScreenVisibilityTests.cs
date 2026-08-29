using System.Reflection;
using NUnit.Framework;
using RootsDance.Scanner;
using RootsDance.UI;
using RootsDance.UI.Kit;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Scanner
{
    /// <summary>
    /// The report has to be <i>visible</i>, not merely present: on the outward face of the plate,
    /// and once magnified, in front of the player's eye, facing it, inside the frustum and carrying
    /// text.
    /// <para>
    /// <see cref="ScannerScreenFitTests"/> already checks that the canvas is the size of the plate,
    /// but a canvas can be exactly the right size and still draw nothing a player ever sees — behind
    /// the plate, behind the eye, or empty. Each assertion here corresponds to one way the screen
    /// has gone blank in play, and every one of them logs the numbers it measured, so a failure says
    /// which of them it was.
    /// </para>
    /// </summary>
    public class ScannerScreenVisibilityTests
    {
        private const string k_Prefab = "Assets/RootsDance/Prefabs/Props/Scanner.prefab";

        private GameObject m_instance;
        private GameObject m_eyeObject;
        private Camera m_eye;

        [SetUp]
        public void SetUp()
        {
            GameObject prefab = AssetDatabase.LoadAssetAtPath<GameObject>(k_Prefab);
            Assert.IsNotNull(prefab, "The scanner prefab is missing; build it first.");

            m_instance = (GameObject)PrefabUtility.InstantiatePrefab(prefab);

            // The surface is [ExecuteAlways] but its OnEnable does not run on an editor
            // instantiate, so the pose is the one serialized in the prefab until it is asked for
            // again. Asking is the point: a stale serialized pose that disagrees with the code is
            // exactly the bug class under test.
            Surface().Apply();

            m_eyeObject = new GameObject("Eye");
            m_eye = m_eyeObject.AddComponent<Camera>();
            m_eye.fieldOfView = 60f;
            m_eye.aspect = 16f / 9f;
        }

        [TearDown]
        public void TearDown()
        {
            if (m_eyeObject != null)
            {
                Object.DestroyImmediate(m_eyeObject);
            }

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
        public void Magnified_SitsInFrontOfTheEyeAndFacesIt()
        {
            Magnifier().MagnifyImmediate(m_eye);

            Transform canvas = Surface().transform;
            Transform eye = m_eye.transform;

            Vector3 local = eye.InverseTransformPoint(canvas.position);
            float facing = Vector3.Dot(canvas.forward, eye.forward);

            Debug.Log($"[scanner] magnified at {local:F4} m in view, facing {facing:F4}, "
                + $"fov {m_eye.fieldOfView}");

            Assert.Greater(local.z, m_eye.nearClipPlane,
                "The report is closer than the near clip plane, so it is clipped away.");
            Assert.Less(new Vector2(local.x, local.y).magnitude, 1e-3f,
                "The report is off to one side of the view rather than centred in it.");
            Assert.Greater(facing, 0.999f,
                "The eye is behind the canvas, so it sees the back of the report.");
        }

        [Test]
        public void Magnified_FillsMostOfTheViewportWithoutOverflowingIt()
        {
            ScannerScreenMagnifier magnifier = Magnifier();
            magnifier.MagnifyImmediate(m_eye);

            Transform eye = m_eye.transform;
            var rect = (RectTransform)Surface().transform;
            var corners = new Vector3[4];
            rect.GetWorldCorners(corners);

            float halfFov = m_eye.fieldOfView * 0.5f * Mathf.Deg2Rad;
            float worst = 0f;

            for (int i = 0; i < corners.Length; i++)
            {
                Vector3 local = eye.InverseTransformPoint(corners[i]);
                Assert.Greater(local.z, 0f, $"Corner {i} is behind the eye.");

                float angle = Mathf.Atan2(Mathf.Abs(local.y), local.z);
                worst = Mathf.Max(worst, angle / halfFov);
            }

            Debug.Log($"[scanner] worst corner fills {worst * 100f:F1}% of the half-viewport, "
                + $"asked for {magnifier.ScreenFill * 100f:F1}%");

            Assert.Less(worst, 1f, "The magnified report overflows the viewport.");
            Assert.AreEqual(magnifier.ScreenFill, worst, 1e-2f,
                "The report did not grow to the fill ratio it is set to, so it reads small.");
        }

        [Test]
        public void Magnified_ReadsUprightHoweverTheScannerIsHeld()
        {
            // The scanner is held in a hand, so the plate is never level with the world. Lifting
            // the report to the eye is what squares it to the player: on the plate it is at
            // whatever angle the wrist is.
            m_instance.transform.rotation = Quaternion.Euler(23f, 41f, 57f);

            Magnifier().MagnifyImmediate(m_eye);

            Transform eye = m_eye.transform;
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

        private ScannerScreenMagnifier Magnifier()
        {
            var magnifier = m_instance.GetComponentInChildren<ScannerScreenMagnifier>(true);
            Assert.IsNotNull(magnifier, "The scanner prefab has no screen magnifier.");
            return magnifier;
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
