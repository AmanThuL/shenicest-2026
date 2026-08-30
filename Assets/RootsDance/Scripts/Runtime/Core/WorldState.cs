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

        // Left at its default, RootsDance.Core.TimeOfDay.Day: every session starts in daylight and a
        // level, checkpoint or trigger switches it from there.
        private TimeOfDay m_timeOfDay;
        private bool m_timeOfDaySet;

        /// <summary>Report entries in the order they were recorded.</summary>
        public IReadOnlyList<ReportEntry> Report => m_report;

        /// <summary>The discrete story time the world is currently in. Starts at Day.</summary>
        public TimeOfDay TimeOfDay => m_timeOfDay;

        /// <summary>True once anything has chosen a time of day this session, even the current one.</summary>
        public bool IsTimeOfDaySet => m_timeOfDaySet;

        /// <summary>Raised once per flag, the first time it is set.</summary>
        public event Action<string> FlagRaised;

        /// <summary>Raised once per accepted report entry.</summary>
        public event Action<ReportEntry> ReportEntryAdded;

        /// <summary>Raised whenever the time of day actually changes, with the new phase.</summary>
        public event Action<TimeOfDay> TimeOfDayChanged;

        public bool HasFlag(string id)
        {
            return m_flags.Contains(id);
        }

        /// <summary>
        /// Replaces progress without broadcasting historical events. New scenes read this snapshot
        /// in Start; completed dialogue, sounds and cinematics must not be replayed while seeding.
        /// </summary>
        public void RestoreSnapshot(IReadOnlyList<string> flags, IReadOnlyList<ReportEntry> report,
            bool hasTimeOfDay, TimeOfDay timeOfDay)
        {
            m_flags.Clear();
            m_report.Clear();
            m_timeOfDaySet = hasTimeOfDay;
            m_timeOfDay = hasTimeOfDay ? timeOfDay : TimeOfDay.Day;

            if (flags != null)
            {
                for (int i = 0; i < flags.Count; i++)
                {
                    if (!string.IsNullOrWhiteSpace(flags[i]))
                    {
                        m_flags.Add(flags[i]);
                    }
                }
            }

            if (report != null)
            {
                for (int i = 0; i < report.Count; i++)
                {
                    if (!string.IsNullOrWhiteSpace(report[i].Id) && !HasReportEntry(report[i].Id))
                    {
                        m_report.Add(report[i]);
                    }
                }
            }
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

        /// <summary>
        /// Switches the discrete story time. Unlike <see cref="RaiseFlag"/> this is <b>not monotonic</b>
        /// — Night may go back to Day. Setting the value it already holds changes nothing, returns false
        /// and raises no event, so a re-entered trigger volume cannot restart a lighting blend.
        /// </summary>
        public bool SetTimeOfDay(TimeOfDay value)
        {
            // Explicitly choosing the current value still counts as a choice: a Day checkpoint must be able
            // to pin Day before the level's own Night seed arrives (see SeedTimeOfDayCommand).
            m_timeOfDaySet = true;

            if (m_timeOfDay == value)
            {
                return false;
            }

            m_timeOfDay = value;
            TimeOfDayChanged?.Invoke(value);
            return true;
        }
    }
}
