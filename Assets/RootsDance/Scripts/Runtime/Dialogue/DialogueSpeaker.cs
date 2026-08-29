namespace RootsDance.Dialogue
{
    /// <summary>
    /// Who is speaking. The presenter styles a line by this — the protagonist's own voice, the
    /// flower's, and the suit's readouts do not look alike, and the player has to be able to tell
    /// them apart without reading a name tag.
    /// </summary>
    public enum DialogueSpeaker
    {
        /// <summary>主角 — the player character, thinking aloud or answering.</summary>
        Protagonist = 0,

        /// <summary>小花 — the flower sprite.</summary>
        Flower = 1,

        /// <summary>设备 — the suit, the scanner, a terminal. Machine voice, no name.</summary>
        Device = 2
    }
}
