using RootsDance.Core;
using Sirenix.OdinInspector;
using UnityEngine;

namespace RootsDance.Scanner
{
    /// <summary>
    /// One section of the survey report — the second level of the screen, the numbered strip down
    /// its left edge (01 调查概况, 02, 03 …).
    /// <para>
    /// A section is either authored or fed. An authored one carries its pages in this asset and
    /// never changes at runtime; a fed one has no pages here at all and grows a page per report
    /// entry of its category as the player scans. That is the whole difference, and it is one
    /// toggle, so a designer can turn the overview into a live index without touching code.
    /// </para>
    /// </summary>
    [CreateAssetMenu(fileName = "ScannerReportSection", menuName = "RootsDance/Scanner/Report Section")]
    [TypeInfoBox("One section of the scanner's survey report. Authored sections carry their own "
        + "pages; fed sections take one page per report entry of their category.")]
    public class ScannerReportSectionSO : ScriptableObject
    {
        // ---- Basic Info -------------------------------------------------------------------------
        [SerializeField, TitleGroup("Basic Info"), Required]
        [ValidateInput("IsValidId", "Use two digits, for example 01.")]
        [Tooltip("Two-digit section number printed on the tab and used as the page index prefix.")]
        private string m_number = "01";

        [SerializeField, TitleGroup("Basic Info"), Required]
        [Tooltip("Section name printed next to the number, for example 调查概况.")]
        private string m_displayName = "调查概况";

        // ---- Interaction ------------------------------------------------------------------------
        [SerializeField, TitleGroup("Interaction")]
        [Tooltip("On: pages come from the world state's report entries of the category below. "
            + "Off: pages come from the authored list in Result.")]
        private bool m_feedsFromReport;

        [SerializeField, TitleGroup("Interaction"), EnumToggleButtons, ShowIf("m_feedsFromReport")]
        [Tooltip("Which report category feeds this section.")]
        private ReportCategory m_category = ReportCategory.BiologicalRecord;

        // ---- Conditions -------------------------------------------------------------------------
        [SerializeField, TitleGroup("Conditions")]
        [Tooltip("World flag that has to be raised before the section appears. Empty = always.")]
        private string m_requiredFlag;

        // ---- Result -----------------------------------------------------------------------------
        [SerializeField, TitleGroup("Result"), HideIf("m_feedsFromReport")]
        [Tooltip("Authored pages, in order.")]
        private ScannerReportPage[] m_pages = new ScannerReportPage[0];

        /// <summary>Two-digit section number, also the prefix of every page index in it.</summary>
        public string Number => m_number;

        public string DisplayName => m_displayName;

        /// <summary>The tab caption: number and name, as the brief prints them.</summary>
        public string TabLabel => m_number + " " + m_displayName;

        public bool FeedsFromReport => m_feedsFromReport;

        public ReportCategory Category => m_category;

        public string RequiredFlag => m_requiredFlag;

        public ScannerReportPage[] Pages => m_pages;

        private bool IsValidId(string value)
        {
            return !string.IsNullOrEmpty(value) && value.Length == 2
                && char.IsDigit(value[0]) && char.IsDigit(value[1]);
        }
    }
}
