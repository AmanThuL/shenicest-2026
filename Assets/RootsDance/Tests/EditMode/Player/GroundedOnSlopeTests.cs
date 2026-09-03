using NUnit.Framework;
using RootsDance.Player;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Player
{
    /// <summary>
    /// What counts as ground under the player. The controller's own CollisionFlags.Below is raised
    /// by any touch on the capsule's lower half, so after the greenhouse deck fell the player stood
    /// in mid-air on the edge of a frame beam: the capsule's rim rested against the beam's
    /// near-vertical side, the flag said "below", gravity was reset every frame. Ground is a surface
    /// the slope limit allows, and nothing else.
    /// </summary>
    public class GroundedOnSlopeTests
    {
        private const float k_SlopeLimit = 45f;

        [Test]
        public void Floor_IsWalkable()
        {
            Assert.That(FirstPersonController.IsWalkable(Vector3.up, k_SlopeLimit), Is.True);
        }

        [Test]
        public void SlopeUnderTheLimit_IsWalkable()
        {
            Vector3 normal = Quaternion.AngleAxis(30f, Vector3.right) * Vector3.up;

            Assert.That(FirstPersonController.IsWalkable(normal, k_SlopeLimit), Is.True);
        }

        [Test]
        public void SlopeAtTheLimit_IsStillWalkable()
        {
            Vector3 normal = Quaternion.AngleAxis(k_SlopeLimit, Vector3.right) * Vector3.up;

            Assert.That(FirstPersonController.IsWalkable(normal, k_SlopeLimit), Is.True,
                "A surface authored exactly at the limit must not flicker between grounded and not.");
        }

        /// <summary>The frame beam the player perched on: normal (0.91, 0.23, -0.34), about 77° off vertical.</summary>
        [Test]
        public void BeamSide_IsNotWalkable()
        {
            Vector3 normal = new Vector3(0.91f, 0.23f, -0.34f).normalized;

            Assert.That(FirstPersonController.IsWalkable(normal, k_SlopeLimit), Is.False,
                "Resting the capsule's rim against a near-vertical face is a perch, not ground; "
                + "counting it as ground leaves the player standing in mid-air.");
        }

        [Test]
        public void Wall_IsNotWalkable()
        {
            Assert.That(FirstPersonController.IsWalkable(Vector3.forward, k_SlopeLimit), Is.False);
        }
    }
}
