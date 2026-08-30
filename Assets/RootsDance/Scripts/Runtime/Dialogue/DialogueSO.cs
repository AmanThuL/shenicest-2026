using RootsDance.Data;
using Sirenix.OdinInspector;
using UnityEngine;

namespace RootsDance.Dialogue
{
    /// <summary>
    /// One conversation: some lines, and optionally a set of things the player may say back.
    /// Authored under <c>Assets/RootsDance/Data/Dialogue/</c>.
    /// <para>
    /// The whole script of chapter 02 fits this shape — a run of lines, then two or three options,
    /// each with a short reply, one of which may open a further exchange. There is deliberately no
    /// node graph: a graph editor is a week of work, and the writing it would buy is a branching
    /// structure the script does not have.
    /// </para>
    /// </summary>
    [CreateAssetMenu(fileName = "Dialogue", menuName = "RootsDance/Dialogue/Conversation")]
    [TypeInfoBox("One conversation. Lines play in order, then the options come up. IDs follow "
        + "DLG-001. A conversation with no options is just a run of lines.")]
    public class DialogueSO : ScriptableObject
    {
        // ---- Basic Info -------------------------------------------------------------------------
        [SerializeField, TitleGroup("Basic Info"), Required]
        [ValidateInput("IsValidId", "Use the form DLG-001.")]
        [Tooltip("Stable id used by flags and save data, for example DLG-001.")]
        private string m_id;

        [SerializeField, TitleGroup("Basic Info"), Required]
        [Tooltip("What this exchange is, for the person scrolling the folder: 初次相遇, 合照追问.")]
        private string m_title;

        // ---- Interaction ------------------------------------------------------------------------
        [SerializeField, TitleGroup("Interaction")]
        [Tooltip("What the player may say once the lines are done. Empty just ends the conversation.")]
        private DialogueChoice[] m_choices = new DialogueChoice[0];

        [SerializeField, TitleGroup("Interaction")]
        [Tooltip("On: after a reply the remaining options come back, so the player can ask "
            + "everything. Off: the first choice ends the conversation.")]
        private bool m_choicesRepeat = true;

        // ---- Conditions -------------------------------------------------------------------------
        [SerializeField, TitleGroup("Conditions")]
        [Tooltip("World flag that has to be raised before this may play. Empty = always.")]
        private string m_requiredFlag;

        [SerializeField, TitleGroup("Conditions")]
        [Tooltip("On: plays at most once per session. Off: may be replayed, for an idle remark.")]
        private bool m_playsOnce = true;

        // ---- Result -----------------------------------------------------------------------------
        [SerializeField, TitleGroup("Result")]
        [Tooltip("The lines, in order, before any options come up.")]
        private DialogueLine[] m_lines = new DialogueLine[0];

        // ---- Scene Change -----------------------------------------------------------------------
        [SerializeField, TitleGroup("Scene Change")]
        [Tooltip("World flag raised once the conversation ends, whichever way it went.")]
        private string m_flagOnComplete;

        public string Id => m_id;
        public string Title => m_title;
        public DialogueChoice[] Choices => m_choices;
        public bool ChoicesRepeat => m_choicesRepeat;
        public string RequiredFlag => m_requiredFlag;
        public bool PlaysOnce => m_playsOnce;
        public DialogueLine[] Lines => m_lines;
        public string FlagOnComplete => m_flagOnComplete;

        [Button("Fill Id From Asset Name"), ButtonGroup("Basic Info/Tools")]
        private void FillIdFromAssetName()
        {
            m_id = ContentId.FromAssetName(name);
        }

        private static bool IsValidId(string value)
        {
            return ContentId.IsValid(value);
        }
    }
}
