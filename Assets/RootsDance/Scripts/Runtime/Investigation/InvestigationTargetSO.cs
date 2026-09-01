using RootsDance.Core;
using RootsDance.Data;
using Sirenix.OdinInspector;
using UnityEngine;

namespace RootsDance.Investigation
{
    /// <summary>
    /// One investigable object, authored by the designer. Programmers write the flow once; every
    /// sample and species in the game is one of these assets under Data/Investigation/.
    /// </summary>
    [CreateAssetMenu(fileName = "InvestigationTarget", menuName = "RootsDance/Investigation/Target")]
    [TypeInfoBox("One investigation node: a sample or species the player can act on. IDs follow "
        + "PREFIX-NNN or DOMAIN-PREFIX-NNN (e.g. SO-001, BOT-FL-041). Sections: Basic Info → "
        + "Interaction → Result → Scene Change.")]
    public class InvestigationTargetSO : ScriptableObject
    {
        // ---- Basic Info -----------------------------------------------------------------------
        [SerializeField, TitleGroup("Basic Info"), Required,
            ValidateInput("IsValidId", "Use the form SO-001, FL-001, or BOT-FL-041.")]
        [Tooltip("Stable id printed in the report, for example SO-001 or BOT-FL-041.")]
        private string m_id;

        [SerializeField, TitleGroup("Basic Info"), EnumToggleButtons]
        [Tooltip("Which tool applies.")]
        private InvestigationKind m_kind = InvestigationKind.Sample;

        [SerializeField, TitleGroup("Basic Info"), EnumToggleButtons]
        [Tooltip("Which section of the official report this lands in.")]
        private ReportCategory m_category = ReportCategory.EnvironmentSample;

        [SerializeField, TitleGroup("Basic Info"), Required]
        [Tooltip("Short label, for example 土壤 or 毯茅.")]
        private string m_title;

        // ---- Interaction ------------------------------------------------------------------------
        [SerializeField, TitleGroup("Interaction")]
        [Tooltip("Prompt shown while the object is focused, for example 采样 or 识别.")]
        private string m_promptText = string.Empty;

        // ---- Result -----------------------------------------------------------------------------
        [SerializeField, TitleGroup("Result"), TextArea(3, 10)]
        [Tooltip("The full result block: sample type, area, contamination, state, advice.")]
        private string m_resultBody;

        [SerializeField, TitleGroup("Result"), TextArea(1, 3)]
        [Tooltip("Inner monologue lines played after the result, in order.")]
        private string[] m_monologueLines;

        // ---- Scene Change -----------------------------------------------------------------------
        [SerializeField, TitleGroup("Scene Change")]
        [Tooltip("Optional extra world flag raised once this target is recorded. May be empty.")]
        private string m_flagOnRecorded;

        public string Id => m_id;
        public InvestigationKind Kind => m_kind;
        public ReportCategory Category => m_category;
        public string Title => m_title;
        public string PromptText => m_promptText;
        public string ResultBody => m_resultBody;
        public string[] MonologueLines => m_monologueLines;
        public string FlagOnRecorded => m_flagOnRecorded;

        public ReportEntry ToReportEntry()
        {
            return new ReportEntry(m_category, m_id, m_title, m_resultBody);
        }

        [Button("Fill Id From Asset Name"), ButtonGroup("Basic Info/Tools")]
        private void FillIdFromAssetName()
        {
            // Idempotent: derives the id from the asset file name, never touches gameplay state.
            m_id = ContentId.FromAssetName(name);
        }

        // Odin calls this in the Editor with the field's current value; the rule itself is testable C#.
        private static bool IsValidId(string value)
        {
            return ContentId.IsValid(value);
        }
    }
}
