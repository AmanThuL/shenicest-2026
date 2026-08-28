using NUnit.Framework;
using RootsDance.Player;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Player
{
    /// <summary>
    /// The light must follow exactly one camera: the one the player looks through. Any other
    /// camera type rendering the scene would otherwise yank the beam off the eye mid-frame.
    /// </summary>
    public class FlashlightCameraLockTests
    {
        [Test]
        public void ShouldFollow_GameCamera_IsTrue()
        {
            Assert.IsTrue(FlashlightCameraLock.ShouldFollow(CameraType.Game));
        }

        [TestCase(CameraType.SceneView)]
        [TestCase(CameraType.Preview)]
        [TestCase(CameraType.Reflection)]
        [TestCase(CameraType.VR)]
        public void ShouldFollow_OtherCameras_IsFalse(CameraType cameraType)
        {
            Assert.IsFalse(FlashlightCameraLock.ShouldFollow(cameraType));
        }
    }
}
