using System;
using System.Collections.Generic;

namespace RootsDance.Core
{
    /// <summary>
    /// Read-only view of the ground truth. This is the only shape the interaction and presentation
    /// layers can ever get hold of: the mutating <see cref="WorldState"/> is reachable only from
    /// <see cref="CommandQueue.Drain"/>, so "presentation never writes the truth" is enforced by the
    /// compiler rather than by review.
    /// </summary>
    public interface IWorldStateReader
    {
        IReadOnlyList<ReportEntry> Report { get; }

        /// <summary>The discrete story time. Not monotonic: it may change back and forth.</summary>
        TimeOfDay TimeOfDay { get; }

        /// <summary>True once anything has chosen a time of day this session, even the current one.</summary>
        bool IsTimeOfDaySet { get; }

        event Action<string> FlagRaised;

        event Action<ReportEntry> ReportEntryAdded;

        event Action<TimeOfDay> TimeOfDayChanged;

        bool HasFlag(string id);

        bool HasReportEntry(string id);

        int CountReportEntries(ReportCategory category);
    }
}
