namespace RootsDance.Core
{
    /// <summary>
    /// One line of the official exploration report. Immutable: the report only ever grows.
    /// </summary>
    public readonly struct ReportEntry
    {
        private readonly ReportCategory m_category;
        private readonly string m_id;
        private readonly string m_title;
        private readonly string m_body;

        public ReportEntry(ReportCategory category, string id, string title, string body)
        {
            m_category = category;
            m_id = id;
            m_title = title;
            m_body = body;
        }

        /// <summary>Which section of the report this belongs to.</summary>
        public ReportCategory Category => m_category;

        /// <summary>Stable identifier written by the designer, for example "SO-001" or "FL-001".</summary>
        public string Id => m_id;

        /// <summary>Short label, for example "土壤样本" or "毯茅".</summary>
        public string Title => m_title;

        /// <summary>The full result text shown when the report is opened.</summary>
        public string Body => m_body;
    }
}
