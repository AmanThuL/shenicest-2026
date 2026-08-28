namespace RootsDance.Core
{
    /// <summary>
    /// Sections of the official exploration report.
    /// <para>
    /// The numbers are written down and new values are only ever <b>appended</b>. Unity serializes
    /// an enum field by its integer value, so reordering these would silently re-file every
    /// investigation asset already authored — a soil sample would come back as a facility record.
    /// </para>
    /// </summary>
    public enum ReportCategory
    {
        /// <summary>环境采样记录 — soil, water and other environment samples.</summary>
        EnvironmentSample = 0,

        /// <summary>已确认物种 — identified against the species database.</summary>
        BiologicalRecord = 1,

        /// <summary>待确认物种 — no database match at all; the entry is the absence of one.</summary>
        UnconfirmedSpecies = 2,

        /// <summary>异常物种 — a known species whose form has drifted away from its record.</summary>
        AnomalousSpecies = 3,

        /// <summary>环境异常记录 — an ANM-numbered anomaly, such as the linked root systems.</summary>
        AnomalyRecord = 4,

        /// <summary>设施记录 — a room or system of the station: what it was for, what state it is in.</summary>
        FacilityRecord = 5,

        /// <summary>区域结构 — which areas have been reached and how they connect.</summary>
        AreaStructure = 6
    }
}
