using System;
using System.Reflection;
using System.Threading;
using NUnit.Framework;
using RootsDance.Archive;
using RootsDance.Interaction;
using RootsDance.Scanner;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;
using Object = UnityEngine.Object;

namespace RootsDance.Tests.EditMode.DevPlay
{
    public class RescueInspectionCleanupTests
    {
        private Scene m_originScene;
        private Scene m_cameraScene;
        private GameObject m_cameraRoot;
        private GameObject m_prop;

        [SetUp]
        public void SetUp()
        {
            // Preview scenes do not require saving the Test Runner's untitled active scene.
            m_originScene = EditorSceneManager.NewPreviewScene();
            m_cameraScene = EditorSceneManager.NewPreviewScene();
            m_cameraRoot = new GameObject("RescueTestCamera");
            SceneManager.MoveGameObjectToScene(m_cameraRoot, m_cameraScene);
            m_prop = new GameObject("RescueTestProp");
            SceneManager.MoveGameObjectToScene(m_prop, m_originScene);
        }

        [TearDown]
        public void TearDown()
        {
            if (m_prop != null)
            {
                Object.DestroyImmediate(m_prop);
            }

            Object.DestroyImmediate(m_cameraRoot);
            if (m_cameraScene.IsValid())
            {
                EditorSceneManager.ClosePreviewScene(m_cameraScene);
            }

            if (m_originScene.IsValid())
            {
                EditorSceneManager.ClosePreviewScene(m_originScene);
            }
        }

        [Test]
        public void ResetForRescue_ZoomedKeypad_LeavesWallMountTransformUnchanged()
        {
            var keypad = m_prop.AddComponent<RuneKeypadInteractable>();
            Vector3 position = new Vector3(2f, 3f, 4f);
            Quaternion rotation = Quaternion.Euler(10f, 20f, 30f);
            Vector3 scale = new Vector3(0.8f, 0.9f, 1.1f);
            m_prop.transform.SetPositionAndRotation(position, rotation);
            m_prop.transform.localScale = scale;
            SetState(keypad, "m_state", "Reading");
            var cancellation = new CancellationTokenSource();
            CancellationToken token = cancellation.Token;
            SetField(keypad, "m_inspectionCancellation", cancellation);

            keypad.ResetForRescue();

            Assert.IsTrue(token.IsCancellationRequested);
            Assert.AreEqual(m_originScene, m_prop.scene);
            Assert.IsNull(m_prop.transform.parent);
            Assert.AreEqual(position, m_prop.transform.position);
            Assert.That(Quaternion.Angle(rotation, m_prop.transform.rotation), Is.LessThan(0.001f));
            Assert.AreEqual(scale, m_prop.transform.localScale);
            Assert.IsTrue(keypad.CanInteract);
            Assert.DoesNotThrow(keypad.ResetForRescue);
        }

        [Test]
        public void ResetForRescue_HeldDocument_ReturnsSheetWithoutCompletingRead()
        {
            var pickup = m_prop.AddComponent<ArchiveDocumentPickup>();
            var controller = m_cameraRoot.AddComponent<DocumentInspectController>();
            SetField(controller, "m_sheet", m_prop.transform);
            SetField(controller, "m_pickup", pickup);
            SetField(controller, "m_originScene", m_originScene);
            SetField(controller, "m_originWorldPosition", new Vector3(6f, 2f, 9f));
            SetField(controller, "m_originWorldRotation", Quaternion.identity);
            SetField(controller, "m_originLocalScale", Vector3.one);
            SetState(controller, "m_state", "Reading");
            var cancellation = new CancellationTokenSource();
            CancellationToken token = cancellation.Token;
            SetField(controller, "m_readCancellation", cancellation);
            m_prop.transform.SetParent(m_cameraRoot.transform, true);

            controller.ResetForRescue();

            Assert.IsTrue(token.IsCancellationRequested);
            Assert.AreEqual(m_originScene, m_prop.scene);
            Assert.IsNull(m_prop.transform.parent);
            Assert.AreEqual(new Vector3(6f, 2f, 9f), m_prop.transform.position);
            Assert.IsFalse(pickup.HasBeenRead);
            Assert.IsFalse(controller.IsBusy);
            Assert.IsNull(controller.Current);
            Assert.DoesNotThrow(controller.ResetForRescue);
        }

        [Test]
        public void ResetForRescue_UnfinishedScan_DoesNotRecordTarget()
        {
            var target = m_prop.AddComponent<ScannableTarget>();
            var controller = m_cameraRoot.AddComponent<ScannerInspectController>();
            SetField(controller, "m_target", target);
            SetState(controller, "m_state", "Scanning");
            var cancellation = new CancellationTokenSource();
            CancellationToken token = cancellation.Token;
            SetField(controller, "m_scanCancellation", cancellation);

            controller.ResetForRescue();

            Assert.IsTrue(token.IsCancellationRequested);
            Assert.IsFalse(target.HasBeenScanned);
            Assert.IsFalse(controller.IsBusy);
            Assert.IsNull(controller.Target);
        }

        private static void SetField(object owner, string name, object value)
        {
            FieldInfo field = owner.GetType().GetField(name, BindingFlags.Instance | BindingFlags.NonPublic);
            Assert.IsNotNull(field, name);
            field.SetValue(owner, value);
        }

        private static void SetState(object owner, string name, string value)
        {
            FieldInfo field = owner.GetType().GetField(name, BindingFlags.Instance | BindingFlags.NonPublic);
            Assert.IsNotNull(field, name);
            field.SetValue(owner, Enum.Parse(field.FieldType, value));
        }
    }
}
