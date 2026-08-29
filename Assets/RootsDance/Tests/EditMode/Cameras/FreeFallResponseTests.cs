using NUnit.Framework;
using RootsDance.Cameras;

namespace RootsDance.Tests.EditMode.Cameras
{
    public class FreeFallResponseTests
    {
        // ---- Lift -------------------------------------------------------------------------------

        [Test]
        public void Lift01_BeforeTheFallAndLongAfter_IsZero()
        {
            Assert.AreEqual(0f, FreeFallResponse.Lift01(-0.5f, 0.2f, 0.6f), 0.001f);
            Assert.AreEqual(0f, FreeFallResponse.Lift01(0f, 0.2f, 0.6f), 0.001f);
            Assert.AreEqual(0f, FreeFallResponse.Lift01(5f, 0.2f, 0.6f), 0.001f);
        }

        [Test]
        public void Lift01_PeaksAtTheEndOfTheRise_ThenFadesOut()
        {
            Assert.AreEqual(1f, FreeFallResponse.Lift01(0.2f, 0.2f, 0.6f), 0.001f);
            Assert.Greater(FreeFallResponse.Lift01(0.3f, 0.2f, 0.6f),
                FreeFallResponse.Lift01(0.6f, 0.2f, 0.6f));
            Assert.AreEqual(0f, FreeFallResponse.Lift01(0.8f, 0.2f, 0.6f), 0.001f);
        }

        [Test]
        public void Lift01_IsATransient_NotAHeldPose()
        {
            // The stomach lift must be gone well before a long fall ends, or the whole drop
            // plays with the camera floating above the head.
            Assert.Less(FreeFallResponse.Lift01(1.5f, 0.22f, 0.6f), 0.001f);
        }

        [Test]
        public void Lift01_ZeroDurations_DoNotDivideByZero()
        {
            Assert.AreEqual(0f, FreeFallResponse.Lift01(0.1f, 0f, 0f), 0.001f);
        }

        // ---- Wind -------------------------------------------------------------------------------

        [Test]
        public void Wind01_BelowMinIsSilent_AboveMaxIsFull()
        {
            Assert.AreEqual(0f, FreeFallResponse.Wind01(1f, 2.5f, 10f), 0.001f);
            Assert.AreEqual(1f, FreeFallResponse.Wind01(12f, 2.5f, 10f), 0.001f);
        }

        [Test]
        public void Wind01_GrowsWithFallSpeed()
        {
            Assert.Greater(FreeFallResponse.Wind01(8f, 2.5f, 10f),
                FreeFallResponse.Wind01(5f, 2.5f, 10f));
        }

        [Test]
        public void Wind01_DegenerateRange_SnapsInsteadOfExploding()
        {
            Assert.AreEqual(0f, FreeFallResponse.Wind01(4f, 5f, 5f), 0.001f);
            Assert.AreEqual(1f, FreeFallResponse.Wind01(6f, 5f, 5f), 0.001f);
        }

        // ---- Landing ----------------------------------------------------------------------------

        [Test]
        public void LandingDip01_OutsideTheWindow_IsZero()
        {
            Assert.AreEqual(0f, FreeFallResponse.LandingDip01(-0.1f, 0.5f), 0.001f);
            Assert.AreEqual(0f, FreeFallResponse.LandingDip01(0.5f, 0.5f), 0.001f);
            Assert.AreEqual(0f, FreeFallResponse.LandingDip01(2f, 0.5f), 0.001f);
        }

        [Test]
        public void LandingDip01_HitsFullDepthEarly_ThenRecoversSlowly()
        {
            // Full depth a fifth of the way in: the drop is faster than the recovery.
            Assert.AreEqual(1f, FreeFallResponse.LandingDip01(0.1f, 0.5f), 0.001f);
            Assert.Greater(FreeFallResponse.LandingDip01(0.2f, 0.5f),
                FreeFallResponse.LandingDip01(0.4f, 0.5f));
        }

        [Test]
        public void LandingDip01_ZeroDuration_IsZero()
        {
            Assert.AreEqual(0f, FreeFallResponse.LandingDip01(0.1f, 0f), 0.001f);
        }

        [Test]
        public void Impact01_ScalesBetweenTheSpeeds_AndClampsOutside()
        {
            Assert.AreEqual(0f, FreeFallResponse.Impact01(2f, 4f, 11f), 0.001f);
            Assert.AreEqual(0.5f, FreeFallResponse.Impact01(7.5f, 4f, 11f), 0.001f);
            Assert.AreEqual(1f, FreeFallResponse.Impact01(20f, 4f, 11f), 0.001f);
        }

        [Test]
        public void Impact01_DegenerateRange_SnapsInsteadOfExploding()
        {
            Assert.AreEqual(0f, FreeFallResponse.Impact01(3f, 4f, 4f), 0.001f);
            Assert.AreEqual(1f, FreeFallResponse.Impact01(5f, 4f, 4f), 0.001f);
        }
    }
}
