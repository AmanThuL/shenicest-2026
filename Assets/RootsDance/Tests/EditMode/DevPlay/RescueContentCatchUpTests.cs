using System.Reflection;
using NUnit.Framework;
using RootsDance.Archive;
using RootsDance.Core;
using RootsDance.Investigation;
using RootsDance.Scanner;
using UnityEngine;

namespace RootsDance.Tests.EditMode.DevPlay
{
    public class RescueContentCatchUpTests
    {
        [Test]
        public void RestoreFromWorldState_ReportWithoutExtraFlag_MarksTargetScannedSilently()
        {
            var host = new GameObject("RescueScanCatchUpTest");
            InvestigationTargetSO record = ScriptableObject.CreateInstance<InvestigationTargetSO>();
            try
            {
                SetField(record, "m_id", "BOT-FL-041");
                var target = host.AddComponent<ScannableTarget>();
                var bridge = host.AddComponent<ScannerWorldStateResult>();
                SetField(bridge, "m_target", target);
                SetField(bridge, "m_reportTarget", record);
                var state = new WorldState();
                state.AddReportEntry(record.ToReportEntry());
                int scanEvents = 0;
                target.Scanned += _ => scanEvents++;

                bridge.RestoreFromWorldState(state);

                Assert.IsTrue(target.HasBeenScanned);
                Assert.AreEqual(0, scanEvents);
            }
            finally
            {
                Object.DestroyImmediate(host);
                Object.DestroyImmediate(record);
            }
        }

        [TestCase(false)]
        [TestCase(true)]
        public void RestoreFromWorldState_ReadFlag_RestoresCollectedStateSilently(bool collected)
        {
            var host = new GameObject("RescueArchiveCatchUpTest");
            ArchiveDocumentSO document = ScriptableObject.CreateInstance<ArchiveDocumentSO>();
            try
            {
                SetField(document, "m_flagOnRead", "archive.test_read");
                SetField(document, "m_isCollected", collected);
                var pickup = host.AddComponent<ArchiveDocumentPickup>();
                SetField(pickup, "m_document", document);
                var state = new WorldState();
                state.RaiseFlag("archive.test_read");
                int flagEvents = 0;
                state.FlagRaised += _ => flagEvents++;

                pickup.RestoreFromWorldState(state);

                Assert.IsTrue(pickup.HasBeenRead);
                Assert.AreEqual(!collected, host.activeSelf);
                Assert.AreEqual(0, flagEvents);
            }
            finally
            {
                Object.DestroyImmediate(host);
                Object.DestroyImmediate(document);
            }
        }

        private static void SetField(object owner, string name, object value)
        {
            FieldInfo field = owner.GetType().GetField(name, BindingFlags.Instance | BindingFlags.NonPublic);
            Assert.IsNotNull(field, name);
            field.SetValue(owner, value);
        }
    }
}
