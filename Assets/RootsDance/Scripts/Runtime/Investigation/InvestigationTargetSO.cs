using RootsDance.Core;
using UnityEngine;

namespace RootsDance.Investigation
{
    /// <summary>
    /// One investigable object, authored by the designer. Programmers write the flow once; every
    /// sample and species in the game is one of these assets under Data/Investigation/.
    /// </summary>
    [CreateAssetMenu(fileName = "InvestigationTarget", menuName = "RootsDance/Investigation/Target")]
    public class InvestigationTargetSO : ScriptableObject
    {
        [Tooltip("Stable id printed in the report, for example SO-001 or FL-001.")]
        [SerializeField] private string m_id;

        [Tooltip("Which tool applies.")]
        [SerializeField] private InvestigationKind m_kind = InvestigationKind.Sample;

        [Tooltip("Which section of the official report this lands in.")]
        [SerializeField] private ReportCategory m_category = ReportCategory.EnvironmentSample;

        [Tooltip("Short label, for example 土壤 or 毯茅.")]
        [SerializeField] private string m_title;

        [Tooltip("Prompt shown while the object is focused, for example 采样 or 识别.")]
        [SerializeField] private string m_promptText = "调查";

        [Tooltip("The full result block: sample type, area, contamination, state, advice.")]
        [TextArea(3, 10)]
        [SerializeField] private string m_resultBody;

        [Tooltip("Inner monologue lines played after the result, in order.")]
        [TextArea(1, 3)]
        [SerializeField] private string[] m_monologueLines;

        [Tooltip("Optional extra world flag raised once this target is recorded. May be empty.")]
        [SerializeField] private string m_flagOnRecorded;

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
    }
}
