using NUnit.Framework;
using RootsDance.Tests.EditMode.Player;
using RootsDance.Scanner;
using Unity.Cinemachine;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Scanner
{
    /// <summary>
    /// The inspect camera has to face the screen without taking the arm's roll with it.
    /// <para>
    /// The screen anchor sits on the arm, so it is held at whatever angle the hand happens to be
    /// at. A camera parented to it with an identity local rotation inherits that whole orientation,
    /// roll included, and Cinemachine then blends the view over on the way in — which reads as the
    /// player lying down rather than raising something to look at.
    /// </para>
    /// </summary>
    public class ScannerInspectFramingTests
    {
        private static ScannerInspectFraming Build(Quaternion anchorRotation, out Transform camera,
            out GameObject root)
        {
            root = new GameObject("FramingTest");

            GameObject anchor = new GameObject("ScreenAnchor");
            anchor.transform.SetParent(root.transform, false);
            anchor.transform.rotation = anchorRotation;

            GameObject cameraObject = new GameObject("InspectCamera");
            CinemachineCamera cinemachine = cameraObject.AddComponent<CinemachineCamera>();
            camera = cameraObject.transform;

            ScannerInspectFraming framing = root.AddComponent<ScannerInspectFraming>();
            SerializedFieldSetter.Set(framing, "m_screenAnchor", anchor.transform);
            SerializedFieldSetter.Set(framing, "m_camera", cinemachine);

            return framing;
        }

        [TestCase(0f)]
        [TestCase(25f)]
        [TestCase(-40f)]
        [TestCase(80f)]
        public void Apply_AnchorRolled_LeavesTheHorizonLevel(float rollDegrees)
        {
            // Yawed and pitched like a held forearm, then rolled by the amount under test.
            Quaternion held = Quaternion.Euler(18f, 35f, rollDegrees);
            ScannerInspectFraming framing = Build(held, out Transform camera, out GameObject root);

            try
            {
                framing.Apply();

                // The camera's right stays horizontal: that is what "the horizon is level" means,
                // and it is true whatever the anchor's roll.
                Assert.AreEqual(0f, Vector3.Dot(camera.right, Vector3.up), 1e-3f,
                    $"Anchor rolled {rollDegrees} deg and the camera rolled with it.");
            }
            finally
            {
                Object.DestroyImmediate(root);
            }
        }

        [Test]
        public void Apply_AlwaysLooksAtTheScreen()
        {
            Quaternion held = Quaternion.Euler(18f, 35f, 30f);
            ScannerInspectFraming framing = Build(held, out Transform camera, out GameObject root);

            try
            {
                framing.Apply();

                // Levelling the camera must not turn it away from what it is meant to be reading.
                Assert.Greater(Vector3.Dot(camera.forward, held * Vector3.forward), 0.99f);
            }
            finally
            {
                Object.DestroyImmediate(root);
            }
        }

        [Test]
        public void Apply_ScreenHeldFlat_StillProducesAUsableRotation()
        {
            // Face-up: world up is parallel to the view direction and says nothing about which way
            // is up on the screen. A degenerate look rotation here would come back as NaN.
            ScannerInspectFraming framing = Build(Quaternion.Euler(90f, 0f, 0f),
                out Transform camera, out GameObject root);

            try
            {
                framing.Apply();

                Assert.IsFalse(float.IsNaN(camera.rotation.x) || float.IsNaN(camera.rotation.w),
                    "A screen held flat produced a degenerate camera rotation.");
            }
            finally
            {
                Object.DestroyImmediate(root);
            }
        }
    }
}
