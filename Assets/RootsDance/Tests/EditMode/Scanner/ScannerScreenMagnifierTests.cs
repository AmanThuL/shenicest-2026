using NUnit.Framework;
using RootsDance.Scanner;
using RootsDance.Tests.EditMode.Player;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Scanner
{
    /// <summary>
    /// Reading the scanner must not move the player's head. The report is made readable by growing
    /// the screen in front of the eye, so what is under test is the pose of the canvas, not of the
    /// camera: it ends up centred in the view, upright however the scanner is held, covering the
    /// asked-for fraction of the viewport — and it goes back onto the plate afterwards.
    /// </summary>
    public class ScannerScreenMagnifierTests
    {
        private const float k_Fill = 0.86f;
        private const float k_Fov = 60f;
        private const float k_Aspect = 16f / 9f;

        private GameObject m_root;
        private Camera m_eye;
        private Transform m_anchor;
        private RectTransform m_canvas;
        private ScannerScreenMagnifier m_magnifier;

        [SetUp]
        public void SetUp()
        {
            m_root = new GameObject("MagnifierTest");

            var eyeObject = new GameObject("Eye");
            m_eye = eyeObject.AddComponent<Camera>();
            m_eye.fieldOfView = k_Fov;
            m_eye.aspect = k_Aspect;
            m_eye.transform.position = new Vector3(3f, 1.6f, -2f);
            m_eye.transform.rotation = Quaternion.Euler(8f, 47f, 0f);

            // The scanner rides a hand, so the anchor is held at an arbitrary angle and the
            // imported model carries a hundredfold scale up its chain — both of which the read
            // pose has to survive.
            var rig = new GameObject("Rig");
            rig.transform.SetParent(m_root.transform, false);
            rig.transform.localScale = Vector3.one * 100f;
            rig.transform.rotation = Quaternion.Euler(23f, 41f, 57f);
            rig.transform.position = new Vector3(2.7f, 1.3f, -1.7f);
            m_anchor = rig.transform;

            var canvasObject = new GameObject("ReportCanvas",
                typeof(RectTransform), typeof(Canvas), typeof(ScannerScreenSurface));
            canvasObject.transform.SetParent(m_anchor, false);
            m_canvas = (RectTransform)canvasObject.transform;

            // Overlay is the default and it drives the RectTransform off the screen rect, which
            // would overwrite every pose under test. The report is a world-space canvas.
            canvasObject.GetComponent<Canvas>().renderMode = RenderMode.WorldSpace;

            var surface = canvasObject.GetComponent<ScannerScreenSurface>();
            surface.Apply();

            m_magnifier = m_root.AddComponent<ScannerScreenMagnifier>();
            SerializedFieldSetter.Set(m_magnifier, "m_screenAnchor", m_anchor);
            SerializedFieldSetter.Set(m_magnifier, "m_surface", surface);
            SerializedFieldSetter.Set(m_magnifier, "m_screenFill", k_Fill);
            SerializedFieldSetter.Set(m_magnifier, "m_readDistanceMeters", 0.6f);
            SerializedFieldSetter.Set(m_magnifier, "m_liftSeconds", 0f);
        }

        [TearDown]
        public void TearDown()
        {
            Object.DestroyImmediate(m_eye.gameObject);
            Object.DestroyImmediate(m_root);
        }

        [Test]
        public void Magnify_LeavesTheCameraWhereThePlayerLeftIt()
        {
            Vector3 position = m_eye.transform.position;
            Quaternion rotation = m_eye.transform.rotation;
            float fov = m_eye.fieldOfView;

            m_magnifier.MagnifyImmediate(m_eye);

            Assert.That(Vector3.Distance(m_eye.transform.position, position), Is.LessThan(1e-5f),
                "The read moved the camera; it is meant to move the UI.");
            Assert.That(Quaternion.Angle(m_eye.transform.rotation, rotation), Is.LessThan(1e-3f),
                "The read turned the camera; it is meant to move the UI.");
            Assert.That(m_eye.fieldOfView, Is.EqualTo(fov).Within(1e-4f),
                "The read changed the lens, which is a camera move by another name.");
        }

        [Test]
        public void Magnify_CentresTheReportInTheViewAndFacesIt()
        {
            m_magnifier.MagnifyImmediate(m_eye);

            Vector3 local = m_eye.transform.InverseTransformPoint(m_canvas.position);

            Assert.That(local.z, Is.GreaterThan(m_eye.nearClipPlane),
                "The report is closer than the near clip plane, so it is clipped away.");
            Assert.That(new Vector2(local.x, local.y).magnitude, Is.LessThan(1e-3f),
                "The report is off to one side of the view rather than centred in it.");

            // A world-space canvas is read from its forward, so facing the player means the
            // canvas's forward matches the eye's.
            Assert.That(Vector3.Dot(m_canvas.forward, m_eye.transform.forward),
                Is.GreaterThan(0.999f), "The report is turned away from the eye.");
        }

        [Test]
        public void Magnify_CoversTheAskedForFractionOfTheViewport()
        {
            m_magnifier.MagnifyImmediate(m_eye);

            var corners = new Vector3[4];
            m_canvas.GetWorldCorners(corners);

            Vector3 bottomLeft = m_eye.transform.InverseTransformPoint(corners[0]);
            Vector3 topRight = m_eye.transform.InverseTransformPoint(corners[2]);

            Vector2 viewport = ScreenFraming.ViewportSizeAt(bottomLeft.z, k_Fov, k_Aspect);
            float height = Mathf.Abs(topRight.y - bottomLeft.y);
            float width = Mathf.Abs(topRight.x - bottomLeft.x);

            Debug.Log($"[scanner] magnified {width:F3} x {height:F3} m in a "
                + $"{viewport.x:F3} x {viewport.y:F3} m viewport at {bottomLeft.z:F3} m");

            // The report is wider than it is tall and the viewport wider still, so height is the
            // tight axis: it is the one that lands on the fill ratio, with width inside the view.
            Assert.That(height / viewport.y, Is.EqualTo(k_Fill).Within(1e-3f));
            Assert.That(width, Is.LessThanOrEqualTo(viewport.x));
        }

        [Test]
        public void Magnify_ReportStaysUprightHoweverTheScannerIsHeld()
        {
            // Rolled hard: on the plate the report is at whatever angle the wrist is, and the whole
            // point of magnifying rather than flying a camera in is that the page comes up square
            // to the player anyway.
            m_anchor.rotation = Quaternion.Euler(-64f, 118f, 83f);

            m_magnifier.MagnifyImmediate(m_eye);

            Vector3 up = m_eye.transform.InverseTransformDirection(m_canvas.up);
            float tilt = Vector3.Angle(new Vector3(up.x, up.y, 0f), Vector3.up);

            Assert.That(tilt, Is.LessThan(1f),
                "The report came up turned in the viewport, so the page reads on its side.");
        }

        [Test]
        public void ResetForRescue_MagnifiedReport_DetachesFromPersistentCamera()
        {
            m_magnifier.MagnifyImmediate(m_eye);

            m_magnifier.ResetForRescue();

            Assert.IsFalse(m_magnifier.IsMagnified);
            Assert.AreEqual(m_anchor, m_canvas.parent);
            Assert.DoesNotThrow(m_magnifier.ResetForRescue);
        }

        [Test]
        public void Restore_PutsTheReportBackOnThePlate()
        {
            Vector3 position = m_canvas.position;
            Quaternion rotation = m_canvas.rotation;
            Vector3 scale = m_canvas.lossyScale;

            m_magnifier.MagnifyImmediate(m_eye);
            Assert.That(m_magnifier.IsMagnified, Is.True);

            m_magnifier.RestoreImmediate();

            Assert.That(m_magnifier.IsMagnified, Is.False);
            Assert.That(m_canvas.parent, Is.EqualTo(m_anchor),
                "The report was left hanging off the camera instead of going back to the plate.");
            Assert.That(Vector3.Distance(m_canvas.position, position), Is.LessThan(1e-5f));
            Assert.That(Quaternion.Angle(m_canvas.rotation, rotation), Is.LessThan(1e-3f));
            Assert.That(Vector3.Distance(m_canvas.lossyScale, scale), Is.LessThan(1e-6f),
                "The report went back to the plate at the size it was read at.");
        }
    }
}
