using NUnit.Framework;
using RootsDance.Audio;

namespace RootsDance.Tests.EditMode.Audio
{
    /// <summary>
    /// The rule every looping bed shares: reach the target in the authored time, never overshoot,
    /// and never stall.
    /// </summary>
    public class AudioBedFadeTests
    {
        [Test]
        public void Step_ZeroFadeSeconds_SnapsToTheTarget()
        {
            Assert.AreEqual(0.8f, AudioBedFade.Step(0f, 0.8f, 0.8f, 0.016f, 0f), 0.0001f);
        }

        [Test]
        public void Step_AcrossTheFadeTime_ReachesFullVolumeAndStops()
        {
            float volume = 0f;

            // Two seconds of 100 ms frames against a two-second fade.
            for (int i = 0; i < 20; i++)
            {
                volume = AudioBedFade.Step(volume, 1f, 1f, 0.1f, 2f);
            }

            Assert.AreEqual(1f, volume, 0.0001f);
        }

        [Test]
        public void Step_HalfWayThroughTheFade_IsHalfWayUp()
        {
            float volume = 0f;

            for (int i = 0; i < 10; i++)
            {
                volume = AudioBedFade.Step(volume, 1f, 1f, 0.1f, 2f);
            }

            Assert.AreEqual(0.5f, volume, 0.0001f);
        }

        [Test]
        public void Step_LongFrame_DoesNotOvershootTheTarget()
        {
            Assert.AreEqual(0.6f, AudioBedFade.Step(0f, 0.6f, 0.6f, 10f, 1.5f), 0.0001f);
        }

        [Test]
        public void Step_FadingDown_ApproachesSilenceAtTheSameRate()
        {
            // A bed mixed to 0.4 crosses its own range in the fade time, not the full 0..1 range:
            // otherwise a quiet bed would take longer to disappear than a loud one.
            float volume = 0.4f;

            for (int i = 0; i < 10; i++)
            {
                volume = AudioBedFade.Step(volume, 0f, 0.4f, 0.1f, 1f);
            }

            Assert.AreEqual(0f, volume, 0.0001f);
        }

        [Test]
        public void Step_BedMixedToSilence_DoesNotStall()
        {
            // A full volume of 0 makes the per-frame step 0; without the guard the bed would sit
            // between its current value and its target for ever.
            Assert.AreEqual(0f, AudioBedFade.Step(0.3f, 0f, 0f, 0.016f, 1.5f), 0.0001f);
        }

        [Test]
        public void Step_PausedGame_HoldsItsVolume()
        {
            Assert.AreEqual(0.25f, AudioBedFade.Step(0.25f, 1f, 1f, 0f, 1.5f), 0.0001f);
        }
    }
}
