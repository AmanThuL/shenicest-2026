namespace RootsDance.Audio
{
    /// <summary>Where a cue raised by a scene component is heard from.</summary>
    public enum AudioCuePlacement
    {
        /// <summary>Flat, at the listener. Interface sounds and narration.</summary>
        Flat,

        /// <summary>At the emitter's position when it fires, then stays put.</summary>
        AtPoint,

        /// <summary>At the emitter, and keeps up with it while the clip sounds.</summary>
        Following
    }
}
