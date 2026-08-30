using NUnit.Framework;
using RootsDance.Cameras;

namespace RootsDance.Tests.EditMode.Cameras
{
    /// <summary>
    /// The bug this exists to stop coming back: a player standing still with the panic camera on,
    /// watching the view bob at 2.9 footfalls a second. The run cycle is locomotion and has to be
    /// gated by locomotion; only the jitter belongs to the fear.
    /// </summary>
    public class PanicRunGateTests
    {
        private const float k_Sprint = 4.4f;
        private const float k_Walk = 2.6f;

        [Test]
        public void StrideFactor_StandingStill_IsZero()
        {
            Assert.That(PanicRunGate.StrideFactor(0f, k_Sprint, k_Walk), Is.EqualTo(0f).Within(1e-5f));
        }

        [Test]
        public void StrideFactor_AtAWalk_IsZeroBecauseWalkingIsNotRunning()
        {
            Assert.That(
                PanicRunGate.StrideFactor(k_Walk, k_Sprint, k_Walk), Is.EqualTo(0f).Within(1e-5f));
        }

        [Test]
        public void StrideFactor_AtSprintSpeed_IsFull()
        {
            Assert.That(PanicRunGate.StrideFactor(k_Sprint, k_Sprint, k_Walk), Is.EqualTo(1f).Within(1e-5f));
        }

        [Test]
        public void StrideFactor_AboveSprintSpeed_DoesNotOvershoot()
        {
            Assert.That(
                PanicRunGate.StrideFactor(k_Sprint * 3f, k_Sprint, k_Walk), Is.EqualTo(1f).Within(1e-5f));
        }

        [Test]
        public void StrideFactor_BetweenWalkAndSprint_IsPartialAndRises()
        {
            float jog = PanicRunGate.StrideFactor(3.2f, k_Sprint, k_Walk);

            Assert.That(jog, Is.GreaterThan(0f));
            Assert.That(jog, Is.LessThan(1f));
            Assert.That(PanicRunGate.StrideFactor(3.9f, k_Sprint, k_Walk), Is.GreaterThan(jog));
        }

        [Test]
        public void StrideFactor_IsMonotonicAcrossTheRamp()
        {
            float previous = -1f;

            for (int i = 0; i <= 20; i++)
            {
                float speed = k_Sprint * i / 20f;
                float value = PanicRunGate.StrideFactor(speed, k_Sprint, k_Walk);

                Assert.That(value, Is.GreaterThanOrEqualTo(previous), "speed " + speed);
                previous = value;
            }
        }

        [Test]
        public void StrideFactor_WithDegenerateBounds_ReadsAsMovingOrNot()
        {
            Assert.That(PanicRunGate.StrideFactor(0f, 1f, 1f), Is.EqualTo(0f).Within(1e-5f));
            Assert.That(PanicRunGate.StrideFactor(5f, 1f, 1f), Is.EqualTo(1f).Within(1e-5f));
        }
        // ---- StrideFactorOrSilent -----------------------------------------------------------
        // Regression: the first fix fell back to full strength when the player reference was
        // unwired, so the view still bobbed while standing still. Silence is the only safe answer.

        [Test]
        public void StrideFactorOrSilent_WithNoController_IsSilentEvenAtSprintSpeed()
        {
            Assert.That(
                PanicRunGate.StrideFactorOrSilent(false, k_Sprint, k_Sprint, k_Walk),
                Is.EqualTo(0f).Within(1e-5f));
        }

        [Test]
        public void StrideFactorOrSilent_WithAController_MatchesTheGate()
        {
            Assert.That(
                PanicRunGate.StrideFactorOrSilent(true, k_Sprint, k_Sprint, k_Walk),
                Is.EqualTo(PanicRunGate.StrideFactor(k_Sprint, k_Sprint, k_Walk)).Within(1e-5f));
            Assert.That(
                PanicRunGate.StrideFactorOrSilent(true, 0f, k_Sprint, k_Walk),
                Is.EqualTo(0f).Within(1e-5f));
        }

    }
}
