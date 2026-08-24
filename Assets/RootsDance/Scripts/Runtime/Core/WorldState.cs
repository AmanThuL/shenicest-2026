using System;
using System.Collections.Generic;

namespace RootsDance.Core
{
    /// <summary>
    /// The single ground truth of a play session: which flags have been raised and what the official
    /// report contains. Plain C# on purpose — it holds mutable progress, so it must not be a
    /// ScriptableObject (asset writes persist in the Editor) and it must stay EditMode-testable.
    /// Everything outside <see cref="CommandQueue.Drain"/> only ever sees
    /// <see cref="IWorldStateReader"/>, so no other layer can reach the mutating methods below.
    /// </summary>
    public sealed class WorldState : IWorldStateReader
    {
        private readonly HashSet<string> m_flags = new HashSet<string>();
        private readonly List<ReportEntry> m_report = new List<ReportEntry>();

        /// <summary>Report entries in the order they were recorded.</summary>
        public IReadOnlyList<ReportEntry> Report => m_report;

        /// <summary>Raised once per flag, the first time it is set.</summary>
        public event Action<string> FlagRaised;

        /// <summary>Raised once per accepted report entry.</summary>
        public event Action<ReportEntry> ReportEntryAdded;

        public bool HasFlag(string id)
        {
            return m_flags.Contains(id);
        }

        /// <summary>
        /// Idempotent: the second and later calls for the same <paramref name="id"/> change nothing
        /// and return false. This is what makes trigger volumes safe to re-enter.
        /// </summary>
        public bool RaiseFlag(string id)
        {
            if (string.IsNullOrEmpty(id) || !m_flags.Add(id))
            {
                return false;
            }

            FlagRaised?.Invoke(id);
            return true;
        }

        /// <summary>
        /// Idempotent by <see cref="ReportEntry.Id"/>: investigating the same target twice records once.
        /// </summary>
        public bool AddReportEntry(ReportEntry entry)
        {
            if (HasReportEntry(entry.Id))
            {
                return false;
            }

            m_report.Add(entry);
            ReportEntryAdded?.Invoke(entry);
            return true;
        }

        public bool HasReportEntry(string id)
        {
            for (int i = 0; i < m_report.Count; i++)
            {
                if (m_report[i].Id == id)
                {
                    return true;
                }
            }

            return false;
        }

        /// <summary>Feeds the "土壤样本：01" / "已确认物种：01" counters in the report UI.</summary>
        public int CountReportEntries(ReportCategory category)
        {
            int count = 0;

            for (int i = 0; i < m_report.Count; i++)
            {
                if (m_report[i].Category == category)
                {
                    count++;
                }
            }

            return count;
        }
    }
}
