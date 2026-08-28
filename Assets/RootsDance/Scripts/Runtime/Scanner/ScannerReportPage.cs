using System;
using Sirenix.OdinInspector;
using UnityEngine;

namespace RootsDance.Scanner
{
    /// <summary>
    /// One authored page of the survey report — the third level of the screen's hierarchy, the one
    /// the page tabs along the top select between.
    /// <para>
    /// The body is TMP rich text on purpose. The brief marks key passages with a highlight and an
    /// underline, and <c>&lt;mark&gt;</c> / <c>&lt;u&gt;</c> put that in the writer's hands instead
    /// of asking the presenter to guess which sentence matters.
    /// </para>
    /// </summary>
    [Serializable]
    public class ScannerReportPage
    {
        [Tooltip("Printed in the index box, for example 1.1. Empty numbers itself from its "
            + "position in the section.")]
        [SerializeField] private string m_index;

        [Required]
        [Tooltip("The 名称 field: what this page is about.")]
        [SerializeField] private string m_title;

        [Tooltip("Body copy. TMP rich text: <mark=#RRGGBBAA> for the highlight, <u> for the rule "
            + "under a line.")]
        [TextArea(3, 12)]
        [SerializeField] private string m_body;

        [Tooltip("Labels of the small tabs above the body panel. Empty hides the row.")]
        [SerializeField] private string[] m_functionTabs = Array.Empty<string>();

        [Tooltip("Model shown turning in the left slot. Empty leaves the slot dark.")]
        [SerializeField] private GameObject m_preview;

        public string Index => m_index;

        public string Title => m_title;

        public string Body => m_body;

        public string[] FunctionTabs => m_functionTabs;

        public GameObject Preview => m_preview;

        /// <summary>Builds a page out of a world-state report entry, for report-fed sections.</summary>
        public static ScannerReportPage FromReport(string index, string title, string body)
        {
            return Create(index, title, body, Array.Empty<string>());
        }

        /// <summary>
        /// Builds a page from plain values. The fields are private and serialized, so this is how
        /// anything outside Unity's own deserializer — the content seeder, a test — makes one.
        /// </summary>
        public static ScannerReportPage Create(string index, string title, string body,
            string[] functionTabs)
        {
            return new ScannerReportPage
            {
                m_index = index,
                m_title = title,
                m_body = body,
                m_functionTabs = functionTabs == null ? Array.Empty<string>() : functionTabs
            };
        }
    }
}
