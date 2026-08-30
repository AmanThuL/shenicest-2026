using NUnit.Framework;
using RootsDance.Rendering;

namespace RootsDance.Tests.EditMode.Rendering
{
    /// <summary>The grain re-seed cadence is the "low frame-rate video" part of the look; keep it exact.</summary>
    public sealed class PsxGrainSeedTests
    {
        [Test]
        public void ComputeGrainSeed_RateZero_ChangesEveryFrame()
        {
            float a = PsxPostProcess.ComputeGrainSeed(1.0f, 0f, 10);
            float b = PsxPostProcess.ComputeGrainSeed(1.0f, 0f, 11);
            Assert.AreNotEqual(a, b);
        }

        [Test]
        public void ComputeGrainSeed_WithinOneTick_HoldsTheSameSeedAcrossFrames()
        {
            float a = PsxPostProcess.ComputeGrainSeed(2.00f, 15f, 100);
            float b = PsxPostProcess.ComputeGrainSeed(2.06f, 15f, 104);
            Assert.AreEqual(a, b, "1/15 s has not elapsed, the pattern must hold");
        }

        [Test]
        public void ComputeGrainSeed_AfterOneTick_AdvancesByOne()
        {
            float a = PsxPostProcess.ComputeGrainSeed(2.00f, 15f, 100);
            float b = PsxPostProcess.ComputeGrainSeed(2.00f + 1f / 15f + 1e-3f, 15f, 104);
            Assert.AreEqual(a + 1f, b);
        }

        [Test]
        public void ComputeGrainSeed_IsNonNegative()
        {
            Assert.GreaterOrEqual(PsxPostProcess.ComputeGrainSeed(0f, 15f, 0), 0f);
            Assert.GreaterOrEqual(PsxPostProcess.ComputeGrainSeed(0f, 0f, 0), 0f);
        }
    }
}
