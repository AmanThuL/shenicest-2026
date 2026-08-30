using System;
using UnityEngine;

namespace RootsDance.Narrative
{
    /// <summary>
    /// One radio line: what is said, what the subtitle reads in both languages, and the recording
    /// of it.
    /// <para>
    /// The clip sits on the line rather than in an <see cref="RootsDance.Audio.AudioCueSO"/> of its
    /// own, because a transmission is a run of lines that differ in nothing but their recording —
    /// one cue asset each would be a folder of near-identical files, and the sequence would still
    /// have to say which one belongs to which line. The sequence's voice cue carries the mix for
    /// all of them; see <c>AudioCueRequest.Voice</c>.
    /// </para>
    /// <para>
    /// The field is still called <c>m_text</c> in the serialized data: renaming it would silently
    /// blank the transmission that is already authored, and the label the writer sees is set by the
    /// tooltip anyway.
    /// </para>
    /// </summary>
    [Serializable]
    public struct RadioLine
    {
        [TextArea(1, 4)]
        [Tooltip("The line as written, in Chinese.")]
        [SerializeField] private string m_text;

        [TextArea(1, 4)]
        [Tooltip("The English subtitle under it. May be empty for a line that needs none.")]
        [SerializeField] private string m_english;

        [Tooltip("The recording of this line. Empty is a silent line — the subtitle still plays, "
            + "which is how the flow stays testable before the voice work exists.")]
        [SerializeField] private AudioClip m_voice;

        [Tooltip("Seconds this line stays up before the next one. 0 reads it from the recording, "
            + "or from the length of the text when there is none. A recorded line is never cut "
            + "short by a value typed here.")]
        [SerializeField] private float m_holdSeconds;

        public string Text => m_text;
        public string English => m_english;
        public AudioClip Voice => m_voice;

        /// <summary>0 means "decide from the recording, or from the length of the text".</summary>
        public float HoldSeconds => m_holdSeconds;
    }
}
