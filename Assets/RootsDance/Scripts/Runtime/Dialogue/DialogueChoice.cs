using System;
using UnityEngine;

namespace RootsDance.Dialogue
{
    /// <summary>
    /// One thing the player may say, what it gets in return, and where it may lead.
    /// <para>
    /// A choice carries its own answer inline instead of pointing at another asset, because almost
    /// every choice in the script is a two-line exchange and one asset per exchange would bury the
    /// conversation in files. <see cref="Follow"/> is the escape hatch for the case that actually
    /// branches — 02-04's "她是谁？", which opens a further question of its own.
    /// </para>
    /// </summary>
    [Serializable]
    public class DialogueChoice
    {
        [SerializeField, TextArea(1, 3)]
        [Tooltip("The option as the player reads it, in Chinese.")]
        private string m_chinese;

        [SerializeField, TextArea(1, 3)]
        [Tooltip("The option's English subtitle.")]
        private string m_english;

        [SerializeField]
        [Tooltip("What is said in reply, in order.")]
        private DialogueLine[] m_response = new DialogueLine[0];

        [SerializeField]
        [Tooltip("A conversation that opens after the reply. Empty ends the exchange here.")]
        private DialogueSO m_follow;

        [SerializeField]
        [Tooltip("World flag raised when this option is taken. Empty raises nothing.")]
        private string m_flagOnChosen;

        [SerializeField]
        [Tooltip("The player saying this option aloud. Optional: plays after the pick, before the "
            + "reply — the question is heard, then answered.")]
        private AudioClip m_voice;

        public string Chinese => m_chinese;
        public string English => m_english;
        public DialogueLine[] Response => m_response;
        public DialogueSO Follow => m_follow;
        public string FlagOnChosen => m_flagOnChosen;

        /// <summary>The spoken option, or null for a silent pick.</summary>
        public AudioClip Voice => m_voice;
    }
}
