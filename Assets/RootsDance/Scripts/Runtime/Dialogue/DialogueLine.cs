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
        [Tooltip("Seconds the line stays up. 0 falls back to the runner's reading-speed estimate, "
            + "which is what most lines should use — a hand-tuned hold per line is work that only "
            + "pays off for a deliberate pause.")]
        private float m_holdSeconds;

        [SerializeField]
        [Tooltip("The recorded voice for this line. Optional: an unvoiced line just reads. With a "
            + "clip, the line stays up at least until the voice finishes, and skipping the line "
            + "cuts the voice with it.")]
        private AudioClip m_voice;

        public DialogueSpeaker Speaker => m_speaker;
        public string Chinese => m_chinese;
        public string English => m_english;

        /// <summary>0 means "decide from the length of the text".</summary>
        public float HoldSeconds => m_holdSeconds;

        /// <summary>The recorded line, or null for a text-only line.</summary>
        public AudioClip Voice => m_voice;
    }
}
