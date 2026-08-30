using NUnit.Framework;
using RootsDance.UI;
using UnityEngine;
using UnityEngine.InputSystem;

namespace RootsDance.Tests.EditMode.UI
{
    public sealed class RescueModalStateTests
    {
        private InputActionAsset m_actions;
        private RescueModalState m_state;
        private float m_timeScale;
        private bool m_audioPaused;
        private bool m_cursorVisible;
        private CursorLockMode m_cursorLock;

        [SetUp]
        public void SetUp()
        {
            m_timeScale = Time.timeScale;
            m_audioPaused = AudioListener.pause;
            m_cursorVisible = Cursor.visible;
            m_cursorLock = Cursor.lockState;
            m_actions = ScriptableObject.CreateInstance<InputActionAsset>();
        }

        [TearDown]
        public void TearDown()
        {
            m_state?.Restore();
            Object.DestroyImmediate(m_actions);
            Time.timeScale = m_timeScale;
            AudioListener.pause = m_audioPaused;
            Cursor.lockState = m_cursorLock;
            Cursor.visible = m_cursorVisible;
        }

        [Test]
        public void Restore_PartiallyEnabledGameplayMap_RestoresExactActionState()
        {
            InputActionMap player = m_actions.AddActionMap("Player");
            InputAction move = player.AddAction("Move");
            InputAction interact = player.AddAction("Interact");
            move.Enable();
            m_state = new RescueModalState(m_actions);

            Assert.That(move.enabled, Is.False);
            Assert.That(interact.enabled, Is.False);

            m_state.Restore();

            Assert.That(move.enabled, Is.True);
            Assert.That(interact.enabled, Is.False);
        }

        [Test]
        public void Capture_UiAndDebugMaps_LeavesBothUsable()
        {
            InputAction click = m_actions.AddActionMap("UI").AddAction("Click");
            InputAction toggle = m_actions.AddActionMap("Debug").AddAction("ToggleCheckpointRescue");
            click.Enable();
            toggle.Enable();

            m_state = new RescueModalState(m_actions);

            Assert.That(click.enabled, Is.True);
            Assert.That(toggle.enabled, Is.True);
            Assert.That(Time.timeScale, Is.Zero);
            Assert.That(AudioListener.pause, Is.True);
        }

        [TestCase(0f, true)]
        [TestCase(0.5f, false)]
        public void Restore_ExistingPause_PreservesOriginalState(float scale, bool audioPaused)
        {
            Time.timeScale = scale;
            AudioListener.pause = audioPaused;
            m_state = new RescueModalState(m_actions);

            m_state.Restore();

            Assert.That(Time.timeScale, Is.EqualTo(scale));
            Assert.That(AudioListener.pause, Is.EqualTo(audioPaused));
        }

        [Test]
        public void Enforce_ReenabledGameplayAction_DisablesUntilRestore()
        {
            InputAction move = m_actions.AddActionMap("Player").AddAction("Move");
            move.Enable();
            m_state = new RescueModalState(m_actions);
            move.Enable();

            m_state.Enforce();

            Assert.That(move.enabled, Is.False);
            m_state.Restore();
            Assert.That(move.enabled, Is.True);
        }

        [Test]
        public void Restore_CalledTwice_DoesNotOverwriteNewWorldPause()
        {
            m_state = new RescueModalState(m_actions);
            m_state.Restore();
            Time.timeScale = 0.25f;

            m_state.Restore();
            m_state.Enforce();

            Assert.That(Time.timeScale, Is.EqualTo(0.25f));
        }
    }
}
