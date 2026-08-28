namespace RootsDance.Sequencing
{
    /// <summary>One thing a <see cref="CueSequence"/> can do at a point in time.</summary>
    public enum CueStepKind
    {
        /// <summary>Do nothing for a while. The spacing between the others.</summary>
        Wait = 0,

        /// <summary>Raise a world flag. Everything else in the game listens to those already.</summary>
        RaiseFlag = 1,

        /// <summary>Switch a scene object on or off — a light, a VFX, a grown plant.</summary>
        SetActive = 2,

        /// <summary>Ask for an audio cue.</summary>
        PlayAudio = 3,

        /// <summary>Ask for a conversation. The sequence does not wait for it to finish.</summary>
        PlayDialogue = 4
    }
}
