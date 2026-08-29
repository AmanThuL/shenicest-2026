using UnityEngine;

namespace RootsDance.Dialogue
{
    /// <summary>
    /// How long a line stays up when the writer did not say. Pure arithmetic, so the rule can be
    /// tested without a scene — and it is the rule most worth testing, because getting it wrong is
    /// invisible in the Inspector and infuriating in play.
    /// </summary>
    public static class DialogueTiming
    {
        /// <summary>Comfortable subtitle speed for Chinese, in characters per second.</summary>
        public const float k_DefaultCjkCharsPerSecond = 5f;

        /// <summary>The same for Latin text, which is read in far smaller units.</summary>
        public const float k_DefaultLatinCharsPerSecond = 15f;

        /// <summary>No line flashes past, however short.</summary>
        public const float k_DefaultMinimumSeconds = 1.2f;

        /// <summary>No line holds the conversation hostage, however long.</summary>
        public const float k_DefaultMaximumSeconds = 7f;

        /// <summary>
        /// Seconds a line lingers after its voice finishes. A subtitle that vanishes on the last
        /// syllable feels snatched away; a beat of silence lets the line land.
        /// </summary>
        public const float k_DefaultVoiceTailSeconds = 0.35f;

        /// <summary>
        /// Reading time for a bilingual line. The two languages are read in parallel — the English
        /// sits under the Chinese as a subtitle, not after it — so this is the slower of the two,
        /// not their sum.
        /// </summary>
        public static float HoldSecondsFor(string chinese, string english,
            float cjkCharsPerSecond = k_DefaultCjkCharsPerSecond,
            float latinCharsPerSecond = k_DefaultLatinCharsPerSecond,
            float minimumSeconds = k_DefaultMinimumSeconds,
            float maximumSeconds = k_DefaultMaximumSeconds)
        {
            float cjkSeconds = Seconds(chinese, cjkCharsPerSecond);
            float latinSeconds = Seconds(english, latinCharsPerSecond);
            float slower = Mathf.Max(cjkSeconds, latinSeconds);

            // A clamp, written out: the maximum wins over the minimum if a caller inverts them,
            // which keeps a bad configuration from producing a line that never advances.
            float ceiling = Mathf.Max(minimumSeconds, maximumSeconds);

            return Mathf.Clamp(slower, Mathf.Min(minimumSeconds, ceiling), ceiling);
        }

        /// <summary>
        /// Hold for a voiced line: the text hold, extended to cover the recording plus a settling
        /// tail. The voice never gets cut off by a short subtitle, and a long subtitle still gets
        /// its full reading time over a short recording. The text hold arrives already clamped, so
        /// no ceiling applies here — a recording is as long as it is.
        /// </summary>
        public static float VoicedHoldSeconds(float textHoldSeconds, float voiceSeconds,
            float tailSeconds = k_DefaultVoiceTailSeconds)
        {
            if (voiceSeconds <= 0f)
            {
                return textHoldSeconds;
            }

            return Mathf.Max(textHoldSeconds, voiceSeconds + Mathf.Max(0f, tailSeconds));
        }

        private static float Seconds(string text, float charsPerSecond)
        {
            if (string.IsNullOrEmpty(text) || charsPerSecond <= 0f)
            {
                return 0f;
            }

            return text.Length / charsPerSecond;
        }
    }
}
