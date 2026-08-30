namespace RootsDance.Core
{
    /// <summary>
    /// Discrete story time, not a clock: the world selects one authored environment look and does not
    /// simulate a continuous clock. Unlike world flags this value is <b>not monotonic</b> — a checkpoint,
    /// a trigger or a later level may restore any earlier look.
    /// </summary>
    public enum TimeOfDay
    {
        /// <summary>The scene-authored daylight look; the value a session starts in.</summary>
        Day = 0,

        /// <summary>Night: dim blue sun and the night volume profile.</summary>
        Night = 1,

        /// <summary>Main's yellow-grey polluted daylight: hopeful at first glance, hazardous in context.</summary>
        PollutedDay = 2
    }
}
