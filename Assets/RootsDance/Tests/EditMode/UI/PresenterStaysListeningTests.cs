using NUnit.Framework;
using RootsDance.UI;
using UnityEditor;
using UnityEngine;
using UnityEngine.TestTools;

namespace RootsDance.Tests.EditMode.UI
{
    /// <summary>
    /// The as-built half of <see cref="UiRootVisibilityTests"/>: the shipped assets, not the rule
    /// in isolation. Both bugs this pins were invisible in code review — the feature code was
    /// right, and only the wiring made it unreachable.
    /// </summary>
    public class PresenterStaysListeningTests
    {
        private const string k_ScannerReportScreen =
            "Assets/RootsDance/Prefabs/UI/ScannerReportScreen.prefab";

        private const string k_Bootstrap = "Assets/RootsDance/Scenes/Bootstrap.unity";

        private GameObject m_instance;

        [SetUp]
        public void SetUp()
        {
            // These prefabs wake up outside the bootstrap they expect and complain about missing
            // wiring. The complaint is not what is under test here.
            LogAssert.ignoreFailingMessages = true;
        }

        [TearDown]
        public void TearDown()
        {
            LogAssert.ignoreFailingMessages = false;

            if (m_instance != null)
            {
                Object.DestroyImmediate(m_instance);
            }
        }

        /// <summary>
        /// The report is closed for the whole of the time the player is out scanning things, which
        /// is exactly when it has to be hearing what was scanned — that record is what decides the
        /// section and page it opens on. A presenter that closes by switching its own object off
        /// hears none of them and reopens on page one every time.
        /// </summary>
        [Test]
        public void ScannerReportScreen_Closed_PresenterIsStillEnabled()
        {
            GameObject asset = AssetDatabase.LoadAssetAtPath<GameObject>(k_ScannerReportScreen);
            Assert.That(asset, Is.Not.Null, $"Missing {k_ScannerReportScreen}");

            m_instance = Object.Instantiate(asset);

            ScannerReportPresenter presenter =
                m_instance.GetComponentInChildren<ScannerReportPresenter>(true);
            Assert.That(presenter, Is.Not.Null, "No ScannerReportPresenter on the screen prefab.");

            presenter.Close();

            Assert.That(presenter.isActiveAndEnabled, Is.True,
                "The report presenter switched itself off on Close(); while closed it can no "
                + "longer hear the report channel, so it can never know what was scanned last.");
        }

        [Test]
        public void ScannerReportScreen_ClosedThenOpened_PresenterIsStillEnabled()
        {
            GameObject asset = AssetDatabase.LoadAssetAtPath<GameObject>(k_ScannerReportScreen);
            m_instance = Object.Instantiate(asset);

            ScannerReportPresenter presenter =
                m_instance.GetComponentInChildren<ScannerReportPresenter>(true);

            presenter.Close();
            presenter.Open();
            presenter.Close();

            Assert.That(presenter.isActiveAndEnabled, Is.True);
        }

        /// <summary>
        /// A presenter that ships on an inactive GameObject never runs <c>OnEnable</c>, so it never
        /// subscribes to anything — no amount of correct code downstream can rescue it. The
        /// corridor's "荧光藻已装入手电筒" line shipped this way and never once appeared.
        /// </summary>
        [Test]
        public void Bootstrap_FlagNotice_ShipsActiveSoItSubscribes()
        {
            string text = System.IO.File.ReadAllText(k_Bootstrap);
            int marker = text.IndexOf("m_Name: FlagNotice", System.StringComparison.Ordinal);

            Assert.That(marker, Is.GreaterThanOrEqualTo(0), "No FlagNotice object in the bootstrap.");

            int active = text.IndexOf("m_IsActive:", marker, System.StringComparison.Ordinal);
            Assert.That(active, Is.GreaterThanOrEqualTo(0));

            string value = text.Substring(active + "m_IsActive:".Length, 2).Trim();

            Assert.That(value, Is.EqualTo("1"),
                "FlagNotice ships inactive, so FlagNoticePresenter.OnEnable never runs and the "
                + "notice never subscribes to the FlagRaised channel.");
        }

        /// <summary>
        /// The line itself: bound to the flag the algae raises, with text, and held for the three
        /// seconds the beat was specified at before the signal breaks up.
        /// </summary>
        [Test]
        public void Bootstrap_FlagNotice_SaysTheAlgaeLineForThreeSeconds()
        {
            string text = System.IO.File.ReadAllText(k_Bootstrap);
            int marker = text.IndexOf("RootsDance.UI.FlagNoticePresenter", System.StringComparison.Ordinal);

            Assert.That(marker, Is.GreaterThanOrEqualTo(0), "No FlagNoticePresenter in the bootstrap.");

            string block = text.Substring(marker, Mathf.Min(1200, text.Length - marker));

            Assert.That(block, Does.Contain("flow.flashlight_powered"),
                "The notice is not bound to the flag the algae raises.");
            Assert.That(block, Does.Contain("m_visibleSeconds: 3"),
                "The notice does not hold for the three seconds the beat asks for.");
        }
    }
}
