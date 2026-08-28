using NUnit.Framework;
using RootsDance.Cameras;

namespace RootsDance.Tests.EditMode.Cameras
{
    public class ShoulderCheckCurveTests
    {
        private const float k_Out = 0.5f;
        private const float k_Hold = 0.45f;
        private const float k_Back = 0.4f;

        [Test]
        public void Evaluate_AtStartAndEnd_FacesForward()
        {
            Assert.AreEqual(0f, ShoulderCheckCurve.Evaluate(0f, k_Out, k_Hold, k_Back), 0.001f);
            Assert.AreEqual(0f, ShoulderCheckCurve.Evaluate(
                ShoulderCheckCurve.TotalSeconds(k_Out, k_Hold, k_Back), k_Out, k_Hold, k_Back), 0.001f);
        }

        [Test]
        public void Evaluate_ThroughTheHold_IsFullyTurned()
        {
            Assert.AreEqual(1f, ShoulderCheckCurve.Evaluate(k_Out + 0.01f, k_Out, k_Hold, k_Back), 0.001f);
            Assert.AreEqual(1f, ShoulderCheckCurve.Evaluate(k_Out + k_Hold - 0.01f, k_Out, k_Hold, k_Back), 0.001f);
        }

        [Test]
        public void Evaluate_TurningOut_RisesWithoutGoingBackwards()
        {
            float previous = -1f;

            for (int i = 0; i <= 50; i++)
            {
                float value = ShoulderCheckCurve.Evaluate(k_Out * i / 50f, k_Out, k_Hold, k_Back);

                Assert.GreaterOrEqual(value, previous, $"step {i} turned back on itself");
                Assert.LessOrEqual(value, 1.001f);
                previous = value;
            }
        }

        [Test]
        public void Evaluate_DeceleratesIntoTheHold()
        {
            // The point of the smoothstep: the last stretch of the turn is the slowest, so the
            // image has settled before the hold begins. A linear turn arrives at full speed.
            float lastQuarter = ShoulderCheckCurve.Evaluate(k_Out, k_Out, k_Hold, k_Back)
                - ShoulderCheckCurve.Evaluate(k_Out * 0.75f, k_Out, k_Hold, k_Back);
            float middleQuarter = ShoulderCheckCurve.Evaluate(k_Out * 0.5f, k_Out, k_Hold, k_Back)
                - ShoulderCheckCurve.Evaluate(k_Out * 0.25f, k_Out, k_Hold, k_Back);

            Assert.Less(lastQuarter, middleQuarter,
                "the turn must slow down as it arrives, not speed up");
        }

        [Test]
        public void Evaluate_PastTheEnd_StaysForward()
        {
            float total = ShoulderCheckCurve.TotalSeconds(k_Out, k_Hold, k_Back);

            Assert.AreEqual(0f, ShoulderCheckCurve.Evaluate(total + 5f, k_Out, k_Hold, k_Back), 0.001f);
        }

        [Test]
        public void ReadableSeconds_AtTheAuthoredSettings_IsLongEnoughToSeeSomething()
        {
            // Finding a pursuer and judging its distance takes 300-500 ms. This is the assertion
            // the whole class exists for: a look back shorter than this shows the player nothing,
            // however dramatic it feels to author.
            float readable = ShoulderCheckCurve.ReadableSeconds(k_Out, k_Hold, k_Back);

            Assert.GreaterOrEqual(readable, 0.3f,
                $"only {readable:F3}s at full deflection — the player cannot read that");
        }

        [Test]
        public void ReadableSeconds_IsLongerThanTheHoldBecauseTheEasedEndsLinger()
        {
            float readable = ShoulderCheckCurve.ReadableSeconds(k_Out, k_Hold, k_Back);

            Assert.Greater(readable, k_Hold);
        }

        [Test]
        public void ReadableSeconds_WithNoHold_CollapsesBelowWhatCanBeRead()
        {
            // The failure case, stated: a turn that goes out and comes straight back.
            float readable = ShoulderCheckCurve.ReadableSeconds(0.25f, 0f, 0.25f);

            Assert.Less(readable, 0.3f);
        }

        [Test]
        public void TotalSeconds_IsTheThreeStagesAdded()
        {
            Assert.AreEqual(1.35f, ShoulderCheckCurve.TotalSeconds(k_Out, k_Hold, k_Back), 0.001f);
        }

        [Test]
        public void Evaluate_NegativeDurations_DoNotProduceNaN()
        {
            float value = ShoulderCheckCurve.Evaluate(0.1f, -1f, -1f, -1f);

            Assert.IsFalse(float.IsNaN(value));
            Assert.AreEqual(0f, value, 0.001f);
        }
    }
}
