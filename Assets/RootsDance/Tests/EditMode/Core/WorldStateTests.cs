using NUnit.Framework;
using RootsDance.Core;

namespace RootsDance.Tests.EditMode.Core
{
    /// <summary>
    /// The world state is the only layer with unit tests: feed it changes, check what comes out.
    /// No Play mode, no scene, no Unity objects involved.
    /// </summary>
    public class WorldStateTests
    {
        private const string k_Flag = "flow.test_flag";

        [Test]
        public void RestoreSnapshot_LaterProgressExists_ReplacesWithoutHistoricalEvents()
        {
            var state = new WorldState();
            state.RaiseFlag("later");
            state.AddReportEntry(new ReportEntry(ReportCategory.EnvironmentSample, "later", "Later", ""));
            state.SetTimeOfDay(TimeOfDay.Night);
            int notifications = 0;
            state.FlagRaised += _ => notifications++;
            state.ReportEntryAdded += _ => notifications++;
            state.TimeOfDayChanged += _ => notifications++;
            var report = new[] { new ReportEntry(ReportCategory.EnvironmentSample, "early", "Early", "") };

            state.RestoreSnapshot(new[] { "early" }, report, true, TimeOfDay.Day);

            Assert.That(state.HasFlag("later"), Is.False);
            Assert.That(state.HasFlag("early"), Is.True);
            Assert.That(state.HasReportEntry("later"), Is.False);
            Assert.That(state.HasReportEntry("early"), Is.True);
            Assert.That(state.TimeOfDay, Is.EqualTo(TimeOfDay.Day));
            Assert.That(state.IsTimeOfDaySet, Is.True);
            Assert.That(notifications, Is.Zero);
        }

        [Test]
        public void RestoreSnapshot_LevelDefault_ClearsTimeChoiceAndReport()
        {
            var state = new WorldState();
            state.SetTimeOfDay(TimeOfDay.Night);

            state.RestoreSnapshot(null, null, false, TimeOfDay.Night);

            Assert.That(state.IsTimeOfDaySet, Is.False);
            Assert.That(state.TimeOfDay, Is.EqualTo(TimeOfDay.Day));
            Assert.That(state.Report, Is.Empty);
        }

        [Test]
        public void RestoreSnapshot_DuplicateAndEmptyIds_AcceptsOnlyUniqueValidEntries()
        {
            var state = new WorldState();
            var entry = new ReportEntry(ReportCategory.EnvironmentSample, "sample", "Sample", "");

            state.RestoreSnapshot(new[] { null, "", " ", "early", "early" },
                new[] { entry, entry, default(ReportEntry) }, false, TimeOfDay.Day);

            Assert.That(state.Report.Count, Is.EqualTo(1));
            Assert.That(state.HasFlag("early"), Is.True);
            Assert.That(state.HasFlag(" "), Is.False);
            Assert.That(state.RaiseFlag("early"), Is.False);
        }

        [Test]
        public void RaiseFlag_FirstTime_SetsFlagAndAnnouncesIt()
        {
            WorldState state = new WorldState();
            int raisedCount = 0;
            state.FlagRaised += _ => raisedCount++;

            bool accepted = state.RaiseFlag(k_Flag);

            Assert.IsTrue(accepted);
            Assert.IsTrue(state.HasFlag(k_Flag));
            Assert.AreEqual(1, raisedCount);
        }

        [Test]
        public void RaiseFlag_SecondTime_ChangesNothing()
        {
            WorldState state = new WorldState();
            int raisedCount = 0;
            state.RaiseFlag(k_Flag);
            state.FlagRaised += _ => raisedCount++;

            bool accepted = state.RaiseFlag(k_Flag);

            Assert.IsFalse(accepted, "Re-entering a trigger volume must not re-raise its flag.");
            Assert.AreEqual(0, raisedCount);
        }

        [Test]
        public void RaiseFlag_EmptyId_IsRejected()
        {
            WorldState state = new WorldState();

            Assert.IsFalse(state.RaiseFlag(string.Empty));
            Assert.IsFalse(state.RaiseFlag(null));
        }

        [Test]
        public void AddReportEntry_SameIdTwice_RecordsOnce()
        {
            WorldState state = new WorldState();
            ReportEntry entry = new ReportEntry(ReportCategory.EnvironmentSample, "SO-001", "土壤", "稳定");

            Assert.IsTrue(state.AddReportEntry(entry));
            Assert.IsFalse(state.AddReportEntry(entry));
            Assert.AreEqual(1, state.Report.Count);
        }

        [Test]
        public void CountReportEntries_CountsPerCategory()
        {
            WorldState state = new WorldState();
            state.AddReportEntry(new ReportEntry(ReportCategory.EnvironmentSample, "SO-001", "土壤", ""));
            state.AddReportEntry(new ReportEntry(ReportCategory.EnvironmentSample, "SO-002", "水样", ""));
            state.AddReportEntry(new ReportEntry(ReportCategory.BiologicalRecord, "FL-001", "毯茅", ""));

            Assert.AreEqual(2, state.CountReportEntries(ReportCategory.EnvironmentSample));
            Assert.AreEqual(1, state.CountReportEntries(ReportCategory.BiologicalRecord));
        }
    }
}
