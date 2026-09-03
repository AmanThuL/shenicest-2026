using System;

namespace RootsDance.Data
{
    /// <summary>
    /// The screen elements a developer can take off the screen while recording footage. One bit
    /// per group, so a recording can keep the dialogue and lose the hints, or the other way round.
    /// </summary>
    [Flags]
    public enum RecordingHiddenUi
    {
        None = 0,

        /// <summary>The "press E" prompt and the one-line story notices that share its canvas.</summary>
        InteractionHints = 1 << 0,

        /// <summary>The conversation screen: speaker, line, subtitle and choice buttons.</summary>
        Dialogue = 1 << 1,

        /// <summary>The radio / monologue / device subtitle line.</summary>
        Subtitles = 1 << 2,

        /// <summary>The visor chrome and the suit's own notices, on the levels that still wear it.</summary>
        HelmetHud = 1 << 3,

        All = InteractionHints | Dialogue | Subtitles | HelmetHud
    }
}
