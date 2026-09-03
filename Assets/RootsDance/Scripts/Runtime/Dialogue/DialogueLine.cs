using System;
using UnityEngine;

namespace RootsDance.Dialogue
{
    /// <summary>
    /// One spoken line, in both languages, and how long it stays up.
    /// <para>
    /// The two languages are separate fields rather than one string with a separator, for the same
    /// reason <see cref="RootsDance.Archive.ArchiveDocumentSO"/> keeps them apart: they are set
    /// differently. The Chinese is the line; the English is a subtitle under it, smaller.
    /// </para>
    /// <para>
    /// The recording sits on the line, not in an audio cue of its own: a conversation is a run of
    /// lines that differ in nothing but their clip, and one cue asset each would be a folder of
    /// near-identical files. The runner's voice cue carries the mix for all of them.
    /// </para>
    /// </summary>
    [Serializable]
    public struct DialogueLine
    {
        [SerializeField]
        [Tooltip("Who says it.")]
        private DialogueSpeaker m_speaker;

        [SerializeField, TextArea(1, 4)]
        [Tooltip("The line as written, in Chinese.")]
        private string m_chinese;

        [SerializeField, TextArea(1, 4)]
        [Tooltip("The English subtitle. May be empty for a line that needs none.")]
        private string m_english;

        [SerializeField]
        [Tooltip("The recording of this line. Empty is a silent line — the subtitle still plays, "
            + "which is how a conversation stays testable before the voice work exists.")]
        private AudioClip m_voice;

        [SerializeField]
        [Tooltip("Seconds the line stays up. 0 falls back to the recording's length, or to the "
            + "runner's reading-speed estimate when there is none — which is what most lines "
            + "should use. A recorded line is never cut short by a value typed here.")]
        private float m_holdSeconds;

        [SerializeField]
        [Tooltip("World flag raised the moment this line comes up. Empty for most lines. This is "
            + "how something in the world can start under a particular line rather than after the "
            + "whole conversation — the deck's warning under the end of the outburst.")]
        private string m_flagOnShown;

        public DialogueSpeaker Speaker => m_speaker;
        public string Chinese => m_chinese;
        public string English => m_english;
        public AudioClip Voice => m_voice;

        /// <summary>0 means "decide from the recording, or from the length of the text".</summary>
        public float HoldSeconds => m_holdSeconds;

        /// <summary>Flag raised as the line is shown; empty for none.</summary>
        public string FlagOnShown => m_flagOnShown;
    }
}
