using NUnit.Framework;
using RootsDance.Dialogue;

namespace RootsDance.Tests.EditMode.Dialogue
{
    public class DialogueTimingTests
    {
        [Test]
        public void HoldSecondsFor_EmptyLine_IsTheMinimumNotZero()
        {
            float hold = DialogueTiming.HoldSecondsFor(string.Empty, string.Empty);

            Assert.AreEqual(DialogueTiming.k_DefaultMinimumSeconds, hold, 0.001f);
        }

        [Test]
        public void HoldSecondsFor_NullLine_IsTheMinimum()
        {
            Assert.AreEqual(DialogueTiming.k_DefaultMinimumSeconds,
                DialogueTiming.HoldSecondsFor(null, null), 0.001f);
        }

        [Test]
        public void HoldSecondsFor_ChineseLine_ScalesWithLength()
        {
            // 20 characters at the default 5/s is 4 s, inside the 1.2..7 window.
            float hold = DialogueTiming.HoldSecondsFor(new string('字', 20), string.Empty);

            Assert.AreEqual(4f, hold, 0.001f);
        }

        [Test]
        public void HoldSecondsFor_BothLanguages_TakesTheSlowerNotTheSum()
        {
            // The English sits under the Chinese and is read alongside it, so a line must not hold
            // for as long as reading both one after the other would take.
            string chinese = new string('字', 20);   // 4.0 s at 5 chars/s
            string english = new string('a', 30);    // 2.0 s at 15 chars/s

            float hold = DialogueTiming.HoldSecondsFor(chinese, english);

            Assert.AreEqual(4f, hold, 0.001f);
            Assert.Less(hold, 6f, "summing the two languages would have given 6 s");
        }

        [Test]
        public void HoldSecondsFor_EnglishOnly_UsesTheLatinRate()
        {
            // 45 Latin characters at 15/s is 3 s; at the CJK rate it would be 9 s and clamp to 7.
            float hold = DialogueTiming.HoldSecondsFor(string.Empty, new string('a', 45));

            Assert.AreEqual(3f, hold, 0.001f);
        }

        [Test]
        public void HoldSecondsFor_VeryLongLine_IsCappedAtTheMaximum()
        {
            float hold = DialogueTiming.HoldSecondsFor(new string('字', 400), string.Empty);

            Assert.AreEqual(DialogueTiming.k_DefaultMaximumSeconds, hold, 0.001f);
        }

        [Test]
        public void HoldSecondsFor_InvertedWindow_StillReturnsAFiniteHold()
        {
            // A misconfigured component must not produce a line that never advances.
            float hold = DialogueTiming.HoldSecondsFor(new string('字', 20), string.Empty,
                minimumSeconds: 9f, maximumSeconds: 2f);

            Assert.AreEqual(9f, hold, 0.001f);
        }

        [Test]
        public void HoldSecondsFor_ZeroReadingSpeed_DoesNotDivideByZero()
        {
            float hold = DialogueTiming.HoldSecondsFor(new string('字', 20), string.Empty,
                cjkCharsPerSecond: 0f);

            Assert.AreEqual(DialogueTiming.k_DefaultMinimumSeconds, hold, 0.001f);
        }

        [Test]
        public void VoicedHoldSeconds_LongRecording_ExtendsTheHoldPastTheTextEstimate()
        {
            // A 6-second recording under a 2-second subtitle: the voice must finish, plus a tail.
            Assert.AreEqual(6.35f, DialogueTiming.VoicedHoldSeconds(2f, 6f, 0.35f), 0.001f);
        }

        [Test]
        public void VoicedHoldSeconds_ShortRecording_KeepsTheReadingTime()
        {
            // A one-word recording under a long subtitle: the reader still gets their time.
            Assert.AreEqual(5f, DialogueTiming.VoicedHoldSeconds(5f, 1f, 0.35f), 0.001f);
        }

        [Test]
        public void VoicedHoldSeconds_NoRecording_ChangesNothing()
        {
            Assert.AreEqual(3f, DialogueTiming.VoicedHoldSeconds(3f, 0f), 0.001f);
            Assert.AreEqual(3f, DialogueTiming.VoicedHoldSeconds(3f, -1f), 0.001f);
        }

        [Test]
        public void VoicedHoldSeconds_NegativeTail_IsTreatedAsZero()
        {
            Assert.AreEqual(6f, DialogueTiming.VoicedHoldSeconds(2f, 6f, -5f), 0.001f);
        }
    }
}
