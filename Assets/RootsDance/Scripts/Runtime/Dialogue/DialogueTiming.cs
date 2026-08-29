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
        /// Breathing room after a recorded line ends, so the next one does not start on its tail.
        /// </summary>
        public const float k_VoiceTailSeconds = 0.35f;

        /// <summary>
        /// How long one line — spoken or not — stays up. The three inputs are in priority order and
        /// each answers a different question, which is why this is one function rather than a
        /// choice the callers each make for themselves:
        /// <list type="bullet">
        /// <item>a recorded line is never cut off, whatever the writer typed: the hold is at least
        /// the clip plus a tail, because a truncated word is a bug the player hears;</item>
        /// <item>an authored hold is honoured when it is longer, which is how a deliberate pause is
        /// written;</item>
        /// <item>with neither, the length of the text decides — see
        /// <see cref="HoldSecondsFor(string, string, float, float, float, float)"/>.</item>
        /// </list>
        /// This is also why the reading estimate is not applied on top of a voice clip: a line read
        /// aloud has already been paced by whoever recorded it.
        /// </summary>
        public static float HoldSecondsForLine(float authoredSeconds, float voiceSeconds,
            string chinese, string english,
            float cjkCharsPerSecond = k_DefaultCjkCharsPerSecond,
            float latinCharsPerSecond = k_DefaultLatinCharsPerSecond,
            float minimumSeconds = k_DefaultMinimumSeconds,
            float maximumSeconds = k_DefaultMaximumSeconds)
        {
            if (voiceSeconds > 0f)
            {
                return Mathf.Max(authoredSeconds, voiceSeconds + k_VoiceTailSeconds);
            }

            if (authoredSeconds > 0f)
            {
                return authoredSeconds;
            }

            return HoldSecondsFor(chinese, english, cjkCharsPerSecond, latinCharsPerSecond,
                minimumSeconds, maximumSeconds);
        }

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
