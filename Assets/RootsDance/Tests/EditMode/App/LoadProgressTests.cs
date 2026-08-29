using NUnit.Framework;
using RootsDance.Core;

namespace RootsDance.Tests.EditMode.App
{
    public class LoadProgressTests
    {
        [Test]
        public void Fraction_NoSteps_IsComplete()
        {
            Assert.AreEqual(1f, LoadProgress.Fraction(0, 0, 0f));
        }

        [Test]
        public void Fraction_NothingDone_IsZero()
        {
            Assert.AreEqual(0f, LoadProgress.Fraction(0, 4, 0f));
        }

        [Test]
        public void Fraction_AllStepsDone_IsComplete()
        {
            Assert.AreEqual(1f, LoadProgress.Fraction(4, 4, 0f));
        }

        [Test]
        public void Fraction_HalfwayThroughSecondOfFour_IsThreeEighths()
        {
            Assert.AreEqual(0.375f, LoadProgress.Fraction(1, 4, 0.5f), 1e-5f);
        }

        [Test]
        public void Fraction_StepProgressAboveOne_ClampsToStepBoundary()
        {
            // AsyncOperation.progress is the engine's guess and is not contractually 0..1.
            Assert.AreEqual(0.5f, LoadProgress.Fraction(1, 4, 4f), 1e-5f);
        }

        [Test]
        public void Fraction_NegativeInputs_ClampToZero()
        {
            Assert.AreEqual(0f, LoadProgress.Fraction(-3, 4, -1f));
        }

        [Test]
        public void Fraction_MoreCompletedThanTotal_IsComplete()
        {
            Assert.AreEqual(1f, LoadProgress.Fraction(9, 4, 0f));
        }

        [Test]
        public void Fraction_AcrossAWholeLoad_NeverGoesBackwards()
        {
            const int k_StepCount = 5;
            float previous = -1f;

            for (int step = 0; step < k_StepCount; step++)
            {
                for (int tick = 0; tick <= 10; tick++)
                {
                    float fraction = LoadProgress.Fraction(step, k_StepCount, tick / 10f);

                    Assert.GreaterOrEqual(fraction, previous, $"step {step}, tick {tick}");
                    previous = fraction;
                }
            }
        }

        [Test]
        public void LitSegments_NoSegments_IsZero()
        {
            Assert.AreEqual(0, LoadProgress.LitSegments(1f, 0));
        }

        [Test]
        public void LitSegments_JustUnderACell_DoesNotLightIt()
        {
            Assert.AreEqual(7, LoadProgress.LitSegments(0.249f, 32));
        }

        [Test]
        public void LitSegments_Complete_LightsEveryCell()
        {
            Assert.AreEqual(32, LoadProgress.LitSegments(1f, 32));
        }

        [Test]
        public void LitSegments_AlmostComplete_LeavesTheLastCellDark()
        {
            Assert.AreEqual(31, LoadProgress.LitSegments(0.999f, 32));
        }
    }
}
