using NUnit.Framework;
using RootsDance.Audio;

namespace RootsDance.Tests.EditMode.Audio
{
    /// <summary>
    /// Footsteps are counted by distance, and the two failures that matter are both silent in the
    /// Inspector: a stride of zero, and a position that jumped.
    /// </summary>
    public class FootstepCadenceTests
    {
        [Test]
        public void Advance_ShortOfAStride_TakesNoStep()
        {
            float carried = 0f;

            Assert.AreEqual(0, FootstepCadence.Advance(ref carried, 0.5f, 1.9f));
            Assert.AreEqual(0.5f, carried, 0.0001f);
        }

        [Test]
        public void Advance_OneStride_TakesOneStepAndKeepsTheRemainder()
        {
            float carried = 0f;

            Assert.AreEqual(1, FootstepCadence.Advance(ref carried, 2.1f, 1.9f));
            Assert.AreEqual(0.2f, carried, 0.0001f);
        }

        [Test]
        public void Advance_AcrossCalls_KeepsCadenceEvenWhenFramesDiffer()
        {
            // The same ground covered in ten small frames and in one large one has to sound the
            // same, or the cadence would depend on the frame rate.
            float carried = 0f;
            int steps = 0;

            for (int i = 0; i < 10; i++)
            {
                steps += FootstepCadence.Advance(ref carried, 0.38f, 1.9f);
            }

            Assert.AreEqual(2, steps);
        }

        [Test]
        public void Advance_ZeroStride_TakesNoStepInsteadOfEveryStep()
        {
            // A stride of zero is an unconfigured Inspector, not a request for infinite footsteps.
            float carried = 3f;

            Assert.AreEqual(0, FootstepCadence.Advance(ref carried, 5f, 0f));
            Assert.AreEqual(0f, carried, 0.0001f);
        }

        [Test]
        public void Advance_Teleport_IsCappedAndDoesNotBankABacklog()
        {
            // A checkpoint jump covers 200 m in one frame. Two steps, then nothing owed — footsteps
            // paid off over the following frames would sound like someone walking away.
            float carried = 0f;

            Assert.AreEqual(FootstepCadence.k_MaxStepsPerCall,
                FootstepCadence.Advance(ref carried, 200f, 1.9f));
            Assert.AreEqual(0f, carried, 0.0001f);
            Assert.AreEqual(0, FootstepCadence.Advance(ref carried, 0f, 1.9f));
        }

        [Test]
        public void Advance_BackwardsDistance_IsIgnored()
        {
            float carried = 1f;

            Assert.AreEqual(0, FootstepCadence.Advance(ref carried, -5f, 1.9f));
            Assert.AreEqual(1f, carried, 0.0001f);
        }
    }
}
