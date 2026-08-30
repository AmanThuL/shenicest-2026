using NUnit.Framework;
using RootsDance.Chase;

namespace RootsDance.Tests.EditMode.Chase
{
    public class ChasePacingTests
    {
        private const float k_DesiredGap = 9f;
        private const float k_BaseSpeed = 4.2f;
        private const float k_Catchup = 0.35f;
        private const float k_MaxSpeed = 6.5f;

        [Test]
        public void SpeedForGap_AtTheDesiredGap_RunsAtBaseSpeed()
        {
            Assert.AreEqual(k_BaseSpeed,
                ChasePacing.SpeedForGap(k_DesiredGap, k_DesiredGap, k_BaseSpeed, k_Catchup, k_MaxSpeed),
                0.001f);
        }

        [Test]
        public void SpeedForGap_FallenBehind_SpeedsUpButNeverPastTheCap()
        {
            float slightlyBehind = ChasePacing.SpeedForGap(
                k_DesiredGap + 2f, k_DesiredGap, k_BaseSpeed, k_Catchup, k_MaxSpeed);
            float farBehind = ChasePacing.SpeedForGap(
                k_DesiredGap + 100f, k_DesiredGap, k_BaseSpeed, k_Catchup, k_MaxSpeed);

            Assert.Greater(slightlyBehind, k_BaseSpeed);
            Assert.AreEqual(k_MaxSpeed, farBehind, 0.001f);
        }

        [Test]
        public void SpeedForGap_TooClose_SlowsDownSoItNeverActuallyCatches()
        {
            float close = ChasePacing.SpeedForGap(
                k_DesiredGap - 4f, k_DesiredGap, k_BaseSpeed, k_Catchup, k_MaxSpeed);

            Assert.Less(close, k_BaseSpeed);
        }

        [Test]
        public void SpeedForGap_RightOnTopOfThePlayer_NeverGoesNegative()
        {
            float onTop = ChasePacing.SpeedForGap(0f, 100f, 1f, 10f, k_MaxSpeed);

            Assert.AreEqual(0f, onTop, 0.001f);
        }
        // ---- StepDistance -------------------------------------------------------------------
        // The reported bug: the boss stood at its spawn while the player ran, so nothing chased
        // anyone. Off the trail the pursuit point is the boss's own position, so a step of
        // speed * dt towards it is zero — these pin the replacement.

        [Test]
        public void StepDistance_OnTheTrail_IsJustSpeedByTime()
        {
            Assert.That(
                ChasePacing.StepDistance(4.2f, 0.5f, true, 3f, 9f), Is.EqualTo(2.1f).Within(1e-4f));
        }

        [Test]
        public void StepDistance_OffTheTrailAndFarBehind_StillMoves()
        {
            // A leg that resumes with an empty trail: 20 m back, it must close, not freeze.
            Assert.That(ChasePacing.StepDistance(4.2f, 0.5f, false, 20f, 9f), Is.EqualTo(2.1f).Within(1e-4f));
        }

        [Test]
        public void StepDistance_OffTheTrail_NeverClosesPastTheDesiredGap()
        {
            // 10 m back, moving fast enough to cover 4 m: it may only take the 1 m to its mark.
            Assert.That(ChasePacing.StepDistance(8f, 0.5f, false, 10f, 9f), Is.EqualTo(1f).Within(1e-4f));
        }

        [Test]
        public void StepDistance_OffTheTrailAndAlreadyTooClose_HoldsStill()
        {
            Assert.That(ChasePacing.StepDistance(4.2f, 0.5f, false, 3.5f, 9f), Is.EqualTo(0f).Within(1e-4f));
        }

        [Test]
        public void StepDistance_IsNeverNegative()
        {
            Assert.That(ChasePacing.StepDistance(-5f, 0.5f, true, 3f, 9f), Is.EqualTo(0f).Within(1e-4f));
            Assert.That(ChasePacing.StepDistance(4.2f, -0.5f, true, 3f, 9f), Is.EqualTo(0f).Within(1e-4f));
        }

    }
}
