namespace RootsDance.Core
{
    /// <summary>
    /// Content a scene brings in over the frames after it is live instead of inside its load frame —
    /// a streamed prop set spawning a few hundred items per frame, for example. The scene loader
    /// asks these two things: whether it may drop the loading cover, and how much of the frame the
    /// content is allowed to eat while a cover is still up (all of it) versus while the player is
    /// looking (almost none of it).
    /// </summary>
    public interface IDeferredContent
    {
        bool IsComplete { get; }

        /// <summary>0..1, monotonic while spawning; 1 once complete.</summary>
        float Progress { get; }

        /// <summary>
        /// True while a loading cover hides the frame. Covered content should catch up as fast as it
        /// can; uncovered content must stay under the frame budget whatever it costs in wall time.
        /// </summary>
        void SetCovered(bool covered);
    }
}
