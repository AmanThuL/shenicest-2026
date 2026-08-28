using NUnit.Framework;
using RootsDance.Player;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Player
{
    /// <summary>
    /// The CPU twin of the reveal shader's BeamEnergy. These lock the behaviour the shader is
    /// meant to match, so a change on one side shows up here rather than only on screen.
    /// </summary>
    public class FlashlightBeamTests
    {
        private const float k_Outer = 26f;
        private const float k_Inner = 13f;
        private const float k_Spill = 18f;
        private const float k_SpillLevel = 0.22f;

        private static FlashlightBeam Beam(float strength = 1f, float spillLevel = k_SpillLevel)
        {
            return new FlashlightBeam(
                Vector3.zero,
                Vector3.forward,
                Mathf.Cos(k_Outer * Mathf.Deg2Rad),
                Mathf.Cos(k_Inner * Mathf.Deg2Rad),
                20f,
                strength,
                Mathf.Cos((k_Outer + k_Spill) * Mathf.Deg2Rad),
                spillLevel);
        }

        /// <summary>A point that many degrees off the axis, five metres out.</summary>
        private static Vector3 OffAxis(float degrees)
        {
            return Quaternion.Euler(0f, degrees, 0f) * Vector3.forward * 5f;
        }

        [Test]
        public void Energy_OnAxis_IsFull()
        {
            Assert.That(Beam().Energy(OffAxis(0f)), Is.EqualTo(1f).Within(1e-3f));
        }

        [Test]
        public void Energy_NotHeld_IsZero()
        {
            Assert.That(Beam(strength: 0f).Energy(OffAxis(0f)), Is.EqualTo(0f));
        }

        [Test]
        public void Energy_JustOutsideTheCone_IsDimButVisible()
        {
            float energy = Beam().Energy(OffAxis(k_Outer + 4f));

            Assert.That(energy, Is.GreaterThan(0f), "the wash has to reach past the bright cone");
            Assert.That(energy, Is.LessThan(k_SpillLevel + 1e-3f), "and stay well under the beam");
        }

        [Test]
        public void Energy_OutsideTheCone_IsBrighterNearerTheBeam()
        {
            FlashlightBeam beam = Beam();

            Assert.That(beam.Energy(OffAxis(k_Outer + 3f)),
                Is.GreaterThan(beam.Energy(OffAxis(k_Outer + 14f))));
        }

        [Test]
        public void Energy_BeyondTheSpill_IsZero()
        {
            Assert.That(Beam().Energy(OffAxis(k_Outer + k_Spill + 5f)), Is.EqualTo(0f));
        }

        [Test]
        public void Energy_WithNoSpill_StopsAtTheCone()
        {
            Assert.That(Beam(spillLevel: 0f).Energy(OffAxis(k_Outer + 4f)), Is.EqualTo(0f));
        }

        [Test]
        public void Energy_InsideTheCone_IsUnchangedByTheSpill()
        {
            Assert.That(Beam().Energy(OffAxis(6f)),
                Is.EqualTo(Beam(spillLevel: 0f).Energy(OffAxis(6f))).Within(1e-4f));
        }

        [Test]
        public void Energy_BeyondRange_IsZero()
        {
            Assert.That(Beam().Energy(Vector3.forward * 25f), Is.EqualTo(0f));
        }
    }
}
