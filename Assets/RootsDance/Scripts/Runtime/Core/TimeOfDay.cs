namespace RootsDance.Core
{
    /// <summary>
    /// Discrete story time, not a clock: the world is either in its day look or its night look, and
    /// nothing in between is simulated. Unlike world flags this value is <b>not monotonic</b> — a
    /// checkpoint, a trigger or a later level may set it back to <see cref="Day"/> at any time.
    /// </summary>
    public enum TimeOfDay
    {
        /// <summary>The scene-authored daylight look; the value a session starts in.</summary>
        Day = 0,

        /// <summary>Night: dim blue sun, the night volume profile, the flashlight matters.</summary>
        Night = 1
    }
}
