using System;
using System.Collections;
using System.Reflection;
using NUnit.Framework;
using RootsDance.Scanner;
using UnityEngine;
using UnityEngine.TestTools;

namespace RootsDance.Tests.PlayMode.Scanner
{
    /// <summary>
    /// The scan loop as the player meets it: nothing on offer until a sample is close enough, then
    /// raise, sweep, read, and only then back down. These run in Play mode because the loop is made
    /// of frames and awaits — the order the states arrive in is the thing under test, and it cannot
    /// be observed from an EditMode call.
    /// </summary>
    public class ScannerFlowTests
    {
        /// <summary>Stand-in for the arms. Reports each performance finished on the next frame.</summary>
        private class StubScannerView : MonoBehaviour, IScannerView
        {
            public int RaiseCount;
            public int LowerCount;

            public event Action RaiseFinished;

            public event Action LowerFinished;

            public void PlayRaise()
            {
                RaiseCount++;
                StartCoroutine(NextFrame(() => RaiseFinished?.Invoke()));
            }

            public void PlayLower()
            {
                LowerCount++;
                StartCoroutine(NextFrame(() => LowerFinished?.Invoke()));
            }

            private IEnumerator NextFrame(Action action)
            {
                yield return null;
                action();
            }
        }

        private GameObject m_root;
        private ScannerInspectController m_controller;
        private ScannerProximityTrigger m_trigger;
        private ScannableTarget m_target;
        private StubScannerView m_view;
        private Transform m_player;

        private static void SetPrivate(object target, string field, object value)
        {
            FieldInfo info = target.GetType().GetField(
                field, BindingFlags.Instance | BindingFlags.NonPublic);

            Assert.IsNotNull(info, $"No field '{field}' on {target.GetType().Name}.");
            info.SetValue(target, value);
        }

        [SetUp]
        public void SetUp()
        {
            m_root = new GameObject("ScannerFlowTest");

            var playerObject = new GameObject("Player");
            playerObject.transform.SetParent(m_root.transform);
            playerObject.transform.position = Vector3.zero;
            m_player = playerObject.transform;

            var targetObject = new GameObject("Sample");
            targetObject.transform.SetParent(m_root.transform);
            targetObject.transform.position = new Vector3(0f, 0f, 10f);
            m_target = targetObject.AddComponent<ScannableTarget>();

            var loopObject = new GameObject("ScannerLoop");
            loopObject.transform.SetParent(m_root.transform);
            m_view = loopObject.AddComponent<StubScannerView>();
            m_controller = loopObject.AddComponent<ScannerInspectController>();
            SetPrivate(m_controller, "m_viewBehaviour", m_view);

            m_trigger = loopObject.AddComponent<ScannerProximityTrigger>();
            SetPrivate(m_trigger, "m_controller", m_controller);
            SetPrivate(m_trigger, "m_player", m_player);
            SetPrivate(m_trigger, "m_range", 3f);
        }

        [TearDown]
        public void TearDown()
        {
            UnityEngine.Object.DestroyImmediate(m_root);
        }

        [UnityTest]
        public IEnumerator Trigger_OffersNothingUntilTheSampleIsInRange()
        {
            yield return null;
            Assert.IsNull(m_trigger.InReach, "A sample 10 m away must not offer a scan.");

            m_target.transform.position = new Vector3(0f, 0f, 2f);
            yield return null;

            Assert.AreSame(m_target, m_trigger.InReach, "A sample 2 m away is within the 3 m range.");

            m_target.transform.position = new Vector3(0f, 0f, 10f);
            yield return null;

            Assert.IsNull(m_trigger.InReach, "Walking away withdraws the offer again.");
        }

        [UnityTest]
        public IEnumerator BeginInspect_RunsRaiseThenReadThenLower()
        {
            Assert.AreEqual(ScannerInspectController.ScannerState.Idle, m_controller.State);

            Assert.IsTrue(m_controller.BeginInspect(m_target));
            Assert.AreEqual(ScannerInspectController.ScannerState.Raising, m_controller.State);
            Assert.AreEqual(1, m_view.RaiseCount, "The arm is asked to raise exactly once.");

            // With no beam assigned the scan stage is skipped, so reading follows the raise.
            yield return null;
            yield return null;
            Assert.AreEqual(ScannerInspectController.ScannerState.Reading, m_controller.State);

            m_controller.RequestExit();
            Assert.AreEqual(ScannerInspectController.ScannerState.Lowering, m_controller.State);
            Assert.AreEqual(1, m_view.LowerCount, "The arm is asked to lower exactly once.");

            yield return null;
            yield return null;
            Assert.AreEqual(ScannerInspectController.ScannerState.Idle, m_controller.State);
            Assert.IsNull(m_controller.Target, "The target is released when the loop ends.");
        }

        [UnityTest]
        public IEnumerator BeginInspect_WhileRunning_IsDropped()
        {
            Assert.IsTrue(m_controller.BeginInspect(m_target));
            Assert.IsFalse(m_controller.BeginInspect(m_target),
                "A second trigger during the loop is dropped rather than queued.");

            yield return null;
            yield return null;
            Assert.AreEqual(1, m_view.RaiseCount);
        }

        [UnityTest]
        public IEnumerator Trigger_OffersNothingWhileTheLoopIsRunning()
        {
            m_target.transform.position = new Vector3(0f, 0f, 2f);
            yield return null;
            Assert.AreSame(m_target, m_trigger.InReach);

            m_controller.BeginInspect(m_target);
            yield return null;

            Assert.IsNull(m_trigger.InReach,
                "The hint is withdrawn while the scanner is busy, so the key cannot re-enter.");
        }

        [UnityTest]
        public IEnumerator Target_MarkedScanned_StopsOfferingWhenNotRepeatable()
        {
            SetPrivate(m_target, "m_repeatable", false);
            m_target.transform.position = new Vector3(0f, 0f, 2f);
            yield return null;
            Assert.AreSame(m_target, m_trigger.InReach);

            m_target.MarkScanned();
            yield return null;

            Assert.IsNull(m_trigger.InReach, "A one-shot sample stops offering once it is read.");
        }
    }
}
