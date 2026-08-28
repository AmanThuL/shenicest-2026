namespace RootsDance.Audio
{
    /// <summary>
    /// Which clip of a cue plays next. Pure arithmetic, no Unity types, so the one rule that
    /// matters — a cue with several clips never plays the same one twice in a row — is testable.
    /// <para>
    /// The immediate-repeat rule is what makes a footstep or a leaf rustle stop sounding like a
    /// sample being triggered. Picking uniformly at random is not enough: with three clips, a
    /// uniform draw repeats a third of the time, which is exactly often enough to hear.
    /// </para>
    /// </summary>
    public static class AudioCuePicker
    {
        /// <summary>Returned when there is nothing to play.</summary>
        public const int k_None = -1;

        /// <summary>
        /// Picks an index in <paramref name="clipCount"/>, avoiding <paramref name="lastIndex"/>
        /// when there is more than one clip to choose from.
        /// </summary>
        /// <param name="clipCount">How many clips the cue carries.</param>
        /// <param name="lastIndex">What played last, or <see cref="k_None"/> for the first play.</param>
        /// <param name="random01">A uniform sample in [0, 1).</param>
        public static int Next(int clipCount, int lastIndex, float random01)
        {
            if (clipCount <= 0)
            {
                return k_None;
            }

            if (clipCount == 1)
            {
                return 0;
            }

            if (random01 < 0f)
            {
                random01 = 0f;
            }
            else if (random01 >= 1f)
            {
                // Guards the caller's half-open contract: Random.Range(0f, 1f) can return 1f.
                random01 = 0.9999f;
            }

            if (lastIndex < 0 || lastIndex >= clipCount)
            {
                return (int)(random01 * clipCount);
            }

            // Draw from the clipCount - 1 clips that are not the last one, then shift past it.
            // This keeps every other clip equally likely instead of re-rolling until one differs.
            int picked = (int)(random01 * (clipCount - 1));

            return picked >= lastIndex ? picked + 1 : picked;
        }
    }
}
