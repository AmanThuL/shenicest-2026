using NUnit.Framework;
using RootsDance.Environment;

namespace RootsDance.Tests.EditMode.Environment
{
    /// <summary>
    /// The drag model the roof's clumps fall with: they must actually come down (gravity wins over
    /// drag at rest) and must not drop like stones (a terminal speed exists and is honoured).
    /// </summary>
    public class RoofSheddingFallTests
    {
        private const float k_Gravity = 9.81f;
        private const float k_Drag = 1.1f;
        private const float k_Step = 1f / 60f;

        [Test]
        public void FallStep_FromRest_GainsDownwardSpeed()
        {
            Assert.That(GreenhouseRoofShedding.FallStep(0f, k_Gravity, k_Drag, k_Step), Is.GreaterThan(0f));
        }

        [Test]
        public void FallStep_NeverExceedsTerminalSpeed()
        {
            float terminal = k_Gravity / k_Drag;
            float speed = 0f;

            for (int i = 0; i < 60 * 30; i++)
            {
                speed = GreenhouseRoofShedding.FallStep(speed, k_Gravity, k_Drag, k_Step);
                Assert.That(speed, Is.LessThanOrEqualTo(terminal + 1e-4f));
            }

            Assert.That(speed, Is.EqualTo(terminal).Within(0.05f),
                "Half a minute of falling should have settled at the terminal speed.");
        }

        [Test]
        public void FallStep_WithoutDrag_IsPlainGravity()
        {
            Assert.That(GreenhouseRoofShedding.FallStep(2f, k_Gravity, 0f, k_Step),
                Is.EqualTo(2f + k_Gravity * k_Step).Within(1e-5f));
        }
    }
}
