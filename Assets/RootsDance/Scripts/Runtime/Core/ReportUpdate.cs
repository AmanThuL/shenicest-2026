namespace RootsDance.Core
{
    /// <summary>
    /// What the UI needs to render one report update: the entry plus the running count of its
    /// section. Carrying the count here means presentation code never has to read the world state,
    /// which keeps the UI assembly boundary one-directional.
    /// </summary>
    public readonly struct ReportUpdate
    {
        private readonly ReportEntry m_entry;
        private readonly int m_categoryCount;

        public ReportUpdate(ReportEntry entry, int categoryCount)
        {
            m_entry = entry;
            m_categoryCount = categoryCount;
        }

        public ReportEntry Entry => m_entry;

        /// <summary>How many entries the entry's category now holds — the "01" in 土壤样本：01.</summary>
        public int CategoryCount => m_categoryCount;
    }
}
