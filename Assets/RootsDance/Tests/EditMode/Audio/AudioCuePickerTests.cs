using NUnit.Framework;
using RootsDance.Audio;

namespace RootsDance.Tests.EditMode.Audio
{
    public class AudioCuePickerTests
    {
        [Test]
        public void Next_NoClips_ReturnsNone()
        {
            Assert.AreEqual(AudioCuePicker.k_None, AudioCuePicker.Next(0, AudioCuePicker.k_None, 0.5f));
        }

        [TestCase(0f)]
        [TestCase(0.5f)]
        [TestCase(0.999f)]
        public void Next_OneClip_AlwaysReturnsIt(float random01)
        {
            Assert.AreEqual(0, AudioCuePicker.Next(1, 0, random01));
        }

        [Test]
        public void Next_FirstPlay_CanReturnAnyIndex()
        {
            Assert.AreEqual(0, AudioCuePicker.Next(3, AudioCuePicker.k_None, 0f));
            Assert.AreEqual(1, AudioCuePicker.Next(3, AudioCuePicker.k_None, 0.5f));
            Assert.AreEqual(2, AudioCuePicker.Next(3, AudioCuePicker.k_None, 0.99f));
        }

        [Test]
        public void Next_SeveralClips_NeverRepeatsTheLastOne()
        {
            for (int clipCount = 2; clipCount <= 6; clipCount++)
            {
                for (int last = 0; last < clipCount; last++)
                {
                    for (int step = 0; step < 40; step++)
                    {
                        int picked = AudioCuePicker.Next(clipCount, last, step / 40f);

                        Assert.AreNotEqual(last, picked,
                            $"{clipCount} clips, last {last}, random {step / 40f}");
                        Assert.GreaterOrEqual(picked, 0);
                        Assert.Less(picked, clipCount);
                    }
                }
            }
        }

        [Test]
        public void Next_SeveralClips_ReachesEveryOtherIndex()
        {
            // Shifting past the last index must not make one clip unreachable.
            bool[] seen = new bool[4];

            for (int step = 0; step < 300; step++)
            {
                seen[AudioCuePicker.Next(4, 2, step / 300f)] = true;
            }

            Assert.IsTrue(seen[0]);
            Assert.IsTrue(seen[1]);
            Assert.IsFalse(seen[2], "the last-played clip must not come back immediately");
            Assert.IsTrue(seen[3]);
        }

        [TestCase(1f)]
        [TestCase(1.5f)]
        [TestCase(-0.5f)]
        public void Next_RandomOutsideTheHalfOpenRange_StaysInBounds(float random01)
        {
            int picked = AudioCuePicker.Next(3, 0, random01);

            Assert.GreaterOrEqual(picked, 0);
            Assert.Less(picked, 3);
            Assert.AreNotEqual(0, picked);
        }

        [Test]
        public void Next_LastIndexOutOfRange_IsTreatedAsNoHistory()
        {
            // A cue whose clip list shrank must not throw or return a stale index.
            int picked = AudioCuePicker.Next(2, 7, 0.9f);

            Assert.GreaterOrEqual(picked, 0);
            Assert.Less(picked, 2);
        }
    }
}
