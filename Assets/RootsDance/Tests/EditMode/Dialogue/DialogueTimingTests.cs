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
        public void HoldSecondsForLine_RecordedLine_LastsAtLeastTheRecording()
        {
            // The rule that matters once voice work lands: whatever the writer typed, a line is
            // never cut off mid-word.
            float hold = DialogueTiming.HoldSecondsForLine(2f, 5f, "很短", "Short");

            Assert.AreEqual(5f + DialogueTiming.k_VoiceTailSeconds, hold, 0.0001f);
        }

        [Test]
        public void HoldSecondsForLine_AuthoredPauseLongerThanTheRecording_IsHonoured()
        {
            // A deliberate silence after a line is written as a hold longer than the clip.
            Assert.AreEqual(8f, DialogueTiming.HoldSecondsForLine(8f, 2f, "很短", "Short"), 0.0001f);
        }

        [Test]
        public void HoldSecondsForLine_RecordedLine_IgnoresTheReadingEstimate()
        {
            // A long subtitle over a short recording still advances with the recording: the pacing
            // of a line read aloud belongs to whoever read it.
            float hold = DialogueTiming.HoldSecondsForLine(0f, 1f,
                "这是一句很长很长的台词，长到按阅读速度估算会远远超过录音本身的长度", string.Empty);

            Assert.AreEqual(1f + DialogueTiming.k_VoiceTailSeconds, hold, 0.0001f);
        }

        [Test]
        public void HoldSecondsForLine_NoRecording_FallsBackToTheAuthoredHold()
        {
            Assert.AreEqual(3.5f, DialogueTiming.HoldSecondsForLine(3.5f, 0f, "继续向前。", "Keep going."),
                0.0001f);
        }

        [Test]
        public void HoldSecondsForLine_NeitherRecordingNorHold_ReadsTheText()
        {
            string chinese = "监测数据显示前方污染浓度正在下降。";

            Assert.AreEqual(DialogueTiming.HoldSecondsFor(chinese, string.Empty),
                DialogueTiming.HoldSecondsForLine(0f, 0f, chinese, string.Empty), 0.0001f);
        }

    }
}
