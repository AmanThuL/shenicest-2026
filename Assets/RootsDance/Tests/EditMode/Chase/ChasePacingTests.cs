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
    }
}
