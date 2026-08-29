using NUnit.Framework;
using RootsDance.Environment;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Environment
{
    public class GrowthDriverTests
    {
        private static AnimationCurve Linear()
        {
            return AnimationCurve.Linear(0f, 0f, 1f, 1f);
        }

        [Test]
        public void Progress_AtZeroElapsed_IsTheStartValue()
        {
            Assert.AreEqual(0.4f, GrowthDriver.Progress(Linear(), 0f, 10f, 0.4f), 0.0001f);
        }

        [Test]
        public void Progress_AtTheFullDuration_IsFullyGrown()
        {
            Assert.AreEqual(1f, GrowthDriver.Progress(Linear(), 10f, 10f, 0f), 0.0001f);
        }

        [Test]
        public void Progress_ResumedHalfGrown_StillFinishesAtOne()
        {
            // The offset applies to the output, not the clock: a run resumed at 0.5 covers the
            // remaining half over the whole remaining duration rather than ending early.
            Assert.AreEqual(0.75f, GrowthDriver.Progress(Linear(), 5f, 10f, 0.5f), 0.0001f);
            Assert.AreEqual(1f, GrowthDriver.Progress(Linear(), 10f, 10f, 0.5f), 0.0001f);
        }

        [Test]
        public void Progress_PastTheDuration_ClampsToOne()
        {
            Assert.AreEqual(1f, GrowthDriver.Progress(Linear(), 999f, 10f, 0f), 0.0001f);
        }

        [Test]
        public void Progress_WithZeroDuration_IsFullyGrownRatherThanDividingByZero()
        {
            Assert.AreEqual(1f, GrowthDriver.Progress(Linear(), 0f, 0f, 0f), 0.0001f);
        }

        [Test]
        public void Progress_WithNegativeElapsed_ClampsToTheStartValue()
        {
            Assert.AreEqual(0.25f, GrowthDriver.Progress(Linear(), -5f, 10f, 0.25f), 0.0001f);
        }

        [Test]
        public void Progress_WithNoCurve_FallsBackToLinearTime()
        {
            Assert.AreEqual(0.5f, GrowthDriver.Progress(null, 5f, 10f, 0f), 0.0001f);
        }

        [Test]
        public void Progress_WithACurveThatOvershoots_StaysWithinZeroToOne()
        {
            // An ease authored with sharp tangents can evaluate above 1 between its keys; the
            // shader reads this straight, so it must never leave the range.
            AnimationCurve overshoot = new AnimationCurve(
                new Keyframe(0f, 0f, 0f, 8f),
                new Keyframe(1f, 1f, 8f, 0f));

            for (int i = 0; i <= 20; i++)
            {
                float g = GrowthDriver.Progress(overshoot, i * 0.5f, 10f, 0f);
                Assert.GreaterOrEqual(g, 0f);
                Assert.LessOrEqual(g, 1f);
            }
        }

        [Test]
        public void Progress_IsMonotonicUnderALinearCurve()
        {
            float previous = -1f;

            for (int i = 0; i <= 20; i++)
            {
                float g = GrowthDriver.Progress(Linear(), i * 0.5f, 10f, 0.1f);
                Assert.GreaterOrEqual(g, previous);
                previous = g;
            }
        }
    }
}
