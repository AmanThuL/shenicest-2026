using NUnit.Framework;
using RootsDance.Audio;

namespace RootsDance.Tests.EditMode.Audio
{
    public class AudioMathTests
    {
        [Test]
        public void LinearToDecibels_FullVolume_IsUnityGain()
        {
            Assert.AreEqual(0f, AudioMath.LinearToDecibels(1f), 0.001f);
        }

        [Test]
        public void LinearToDecibels_Silence_IsTheFloorNotNegativeInfinity()
        {
            // The mixer rejects -Infinity, which is what a naive log10(0) produces.
            Assert.AreEqual(AudioMath.k_MinDecibels, AudioMath.LinearToDecibels(0f), 0.001f);
        }

        [Test]
        public void LinearToDecibels_HalfSlider_IsAboutMinusSixDecibels()
        {
            // The whole point of the log mapping: half the slider is a perceptible step down,
            // not the -40 dB (inaudible) a linear mapping onto the dB range would give.
            Assert.AreEqual(-6.02f, AudioMath.LinearToDecibels(0.5f), 0.05f);
        }

        [TestCase(-100f)]
        [TestCase(-80f)]
        public void DecibelsToLinear_AtOrBelowFloor_IsZero(float decibels)
        {
            Assert.AreEqual(0f, AudioMath.DecibelsToLinear(decibels), 0.0001f);
        }

        [TestCase(0.05f)]
        [TestCase(0.25f)]
        [TestCase(0.5f)]
        [TestCase(1f)]
        public void DecibelsToLinear_RoundTripsLinearToDecibels(float linear)
        {
            float roundTripped = AudioMath.DecibelsToLinear(AudioMath.LinearToDecibels(linear));

            Assert.AreEqual(linear, roundTripped, 0.001f);
        }

        [Test]
        public void LinearToDecibels_LouderInput_IsNeverQuieter()
        {
            float previous = AudioMath.k_MinDecibels - 1f;

            for (int i = 0; i <= 20; i++)
            {
                float decibels = AudioMath.LinearToDecibels(i / 20f);

                Assert.GreaterOrEqual(decibels, previous, $"step {i} went backwards");
                previous = decibels;
            }
        }
    }
}
