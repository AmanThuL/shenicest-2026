using NUnit.Framework;
using RootsDance.Core;
using RootsDance.Events;
using RootsDance.Scanner;
using RootsDance.Tests.EditMode.Player;
using RootsDance.UI;
using UnityEditor;
using UnityEngine;
using UnityEngine.TestTools;

namespace RootsDance.Tests.EditMode.Scanner
{
    /// <summary>
    /// "Scan a thing, the report opens on that thing." It is the behaviour the screen exists for,
    /// it was asked for repeatedly, and it kept coming back wrong while the code that implements
    /// it read as correct — the presenter was deaf to the record while the report was closed, so
    /// it always fell back to the first section. These drive the real prefab through the real
    /// channel so that can never be true again without a red test.
    /// </summary>
    public class ScannerReportOpensOnScannedRecordTests
    {
        private const string k_Screen = "Assets/RootsDance/Prefabs/UI/ScannerReportScreen.prefab";

        private GameObject m_instance;
        private ScannerReportPresenter m_presenter;
        private ReportUpdateEventChannelSO m_channel;

        [SetUp]
        public void SetUp()
        {
            LogAssert.ignoreFailingMessages = true;

            GameObject asset = AssetDatabase.LoadAssetAtPath<GameObject>(k_Screen);
            Assert.That(asset, Is.Not.Null, $"Missing {k_Screen}");

            m_channel = ScriptableObject.CreateInstance<ReportUpdateEventChannelSO>();
            m_instance = Object.Instantiate(asset);
            m_presenter = m_instance.GetComponentInChildren<ScannerReportPresenter>(true);

            Assert.That(m_presenter, Is.Not.Null, "No ScannerReportPresenter on the screen prefab.");

            // The rest of this fixture re-points the presenter at a channel it owns, so it never
            // notices if the shipped prefab's own reference is empty — and that emptiness is
            // exactly what left the report deaf in the real game while every test here stayed
            // green. Caught before the rewire, on the prefab as loaded from disk.
            Assert.That(SerializedFieldSetter.Get(m_presenter, "m_reportUpdated"), Is.Not.Null,
                $"{k_Screen} ships with m_reportUpdated unassigned — the presenter never "
                + "subscribes to the real channel in the running game, so it never learns what "
                + "was scanned. Wire it to Assets/RootsDance/Data/Events/ReportUpdated.asset in "
                + "the Inspector.");

            // Re-point the presenter at a channel this test owns, the way the Inspector would.
            SerializedFieldSetter.Set(m_presenter, "m_reportUpdated", m_channel);

            // Edit mode does not run OnEnable for a script without [ExecuteAlways], so the
            // subscription the presenter makes there has to be started by hand. The subject of
            // these tests is where the report opens, not Unity's lifecycle — the lifecycle half is
            // covered by PresenterStaysListeningTests, which checks the presenter is still enabled
            // (and so still subscribed) once the report has been closed.
            Invoke("OnEnable");
        }

        [TearDown]
        public void TearDown()
        {
            LogAssert.ignoreFailingMessages = false;

            if (m_presenter != null)
            {
                Invoke("OnDisable");
            }

            if (m_instance != null)
            {
                Object.DestroyImmediate(m_instance);
            }

            if (m_channel != null)
            {
                Object.DestroyImmediate(m_channel);
            }
        }

        private void Invoke(string method)
        {
            System.Reflection.MethodInfo info = typeof(ScannerReportPresenter).GetMethod(method,
                System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.NonPublic);

            Assert.That(info, Is.Not.Null, $"ScannerReportPresenter has no {method}().");
            info.Invoke(m_presenter, null);
        }

        private int RailIndexOf(ReportCategory category)
        {
            for (int i = 0; i < m_presenter.VisibleSections.Count; i++)
            {
                ScannerReportSectionSO section = m_presenter.VisibleSections[i];

                if (section != null && section.FeedsFromReport && section.Category == category)
                {
                    return i;
                }
            }

            return -1;
        }

        private void Scan(ReportCategory category, string id)
        {
            m_channel.RaiseEvent(new ReportUpdate(new ReportEntry(category, id, id, "…"), 3));
        }

        /// <summary>
        /// The exact reported failure: scan the 毯茅, open the report, and it should be on 生物记录,
        /// not on 调查概况.
        /// </summary>
        [Test]
        public void Open_AfterScanningWhileClosed_LandsOnTheScannedRecordsSection()
        {
            m_presenter.Close();

            Scan(ReportCategory.BiologicalRecord, "tanmao");

            m_presenter.Open();

            int expected = RailIndexOf(ReportCategory.BiologicalRecord);
            Assert.That(expected, Is.GreaterThanOrEqualTo(0), "No 生物记录 section on the rail.");
            Assert.That(m_presenter.CurrentSectionIndex, Is.EqualTo(expected));
        }

        [Test]
        public void Open_AfterScanningAnEnvironmentSample_LandsOnTheEnvironmentSection()
        {
            m_presenter.Close();

            Scan(ReportCategory.EnvironmentSample, "soil");

            m_presenter.Open();

            int expected = RailIndexOf(ReportCategory.EnvironmentSample);
            Assert.That(expected, Is.GreaterThanOrEqualTo(0), "No 环境采样 section on the rail.");
            Assert.That(m_presenter.CurrentSectionIndex, Is.EqualTo(expected));
        }

        /// <summary>
        /// The presenter has to still be listening while the report is shut, which is the state it
        /// is in for the whole of the time the player is out scanning things.
        /// </summary>
        [Test]
        public void Close_ThenScan_ThePresenterIsStillSubscribed()
        {
            m_presenter.Close();

            Scan(ReportCategory.BiologicalRecord, "tanmao");
            m_presenter.Open();

            Assert.That(m_presenter.CurrentSectionIndex,
                Is.EqualTo(RailIndexOf(ReportCategory.BiologicalRecord)),
                "The record raised while the report was closed never reached the presenter.");
        }

        /// <summary>
        /// Re-opening with nothing new scanned is re-reading, and comes back where the player left
        /// off rather than jumping them somewhere.
        /// </summary>
        [Test]
        public void Open_SecondTimeWithNothingNewScanned_StaysWhereItWasLeft()
        {
            m_presenter.Close();
            Scan(ReportCategory.BiologicalRecord, "tanmao");
            m_presenter.Open();

            int landed = m_presenter.CurrentSectionIndex;

            m_presenter.Close();
            m_presenter.Open();

            Assert.That(m_presenter.CurrentSectionIndex, Is.EqualTo(landed));
        }

        [Test]
        public void SectionTabs_DoNotRepeatTheSectionNumber()
        {
            m_presenter.Open();

            Assert.That(m_presenter.VisibleSections.Count, Is.GreaterThan(0),
                "The rail is empty, so this test would pass without checking anything.");

            foreach (ScannerReportSectionSO section in m_presenter.VisibleSections)
            {
                Assert.That(section.TabLabel, Is.EqualTo(section.DisplayName),
                    $"Tab '{section.TabLabel}' still carries its number.");
                Assert.That(section.TabLabel, Does.Not.Match(@"^\d"),
                    "Section tabs are named, not numbered.");
            }
        }
    }
}
