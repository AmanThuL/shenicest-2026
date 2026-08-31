using System;
using RootsDance.Core;
using RootsDance.Player;
using Unity.Cinemachine;
using UnityEngine;

namespace RootsDance.World
{
    /// <summary>
    /// Steps the player up to a wall terminal and back again.
    /// <para>
    /// The read half of <see cref="RootsDance.Scanner.ScannerInspectController"/>, with the arm and
    /// the beam taken out: raise the terminal's own Cinemachine camera above the first-person one
    /// and the brain flies the view onto the screen, suspend the look and the move so the eye is
    /// not fighting that camera for the same axes, release the cursor so the panel's buttons can be
    /// pressed. The same key steps back out.
    /// </para>
    /// <para>
    /// The camera lives on the terminal rather than here, framed where it was built, because
    /// framing is a property of the panel — a wider screen wants the camera further back — and
    /// because two terminals in one room would otherwise fight over one camera.
    /// </para>
    /// </summary>
    public class TerminalInspectController : MonoBehaviour, IRescueResetParticipant
    {
        public enum ReadState
        {
            Idle = 0,

            /// <summary>The camera is on the screen and the mouse belongs to it.</summary>
            Reading = 1,
        }

        [Header("Wiring")]
        [Tooltip("Reads the interact button — the same key opens the terminal and steps back.")]
        [SerializeField] private PlayerInputReader m_input;

        [Tooltip("Suspended while reading — the look, the move and the interaction ray. One owner "
            + "per axis: the terminal's camera owns the view for as long as it is up.")]
        [SerializeField] private Behaviour[] m_suspendedWhileReading = Array.Empty<Behaviour>();

        [Header("Framing")]
        [Tooltip("Priority given to the terminal's camera while it is up. Above the first-person "
            + "camera, below anything cinematic. Matches the scanner's.")]
        [SerializeField] private int m_activePriority = 30;

        [Tooltip("Seconds the camera takes to fly in and back out. Short: this is the player "
            + "leaning in to read a panel, not a cutscene.")]
        [Range(0.1f, 4f)]
        [SerializeField] private float m_zoomSeconds = 0.4f;

        [Tooltip("Show and unlock the cursor while reading, so the screen's controls are clickable.")]
        [SerializeField] private bool m_releaseCursorWhileReading = true;

        [Tooltip("Seconds after the camera arrives before the key will step back out. Without it "
            + "the press that opened the terminal closes it again on the very next frame.")]
        [Range(0f, 1f)]
        [SerializeField] private float m_exitLockoutSeconds = 0.25f;

        private ReadState m_state = ReadState.Idle;
        private WallTerminal m_terminal;
        private ITerminalScreenView m_screen;
        private CinemachineBrain m_brain;
        private CinemachineBlendDefinition m_previousBlend;
        private bool m_hasStoredBlend;
        private float m_exitAllowedAt;

        public ReadState State => m_state;

        /// <summary>True while a terminal is up. The proximity hint stays quiet meanwhile.</summary>
        public bool IsBusy => m_state != ReadState.Idle;

        /// <summary>The terminal being read, or null.</summary>
        public WallTerminal Current => m_terminal;

        public event Action ReadingStarted;

        public event Action ReadingEnded;

        private void Awake()
        {
            if (m_input == null)
            {
                m_input = GetComponentInParent<PlayerInputReader>();
            }

        }

        private void OnDisable()
        {
            EndRead();
        }

        private void Update()
        {
            if (m_state != ReadState.Reading)
            {
                return;
            }

            if (m_input == null || !m_input.InteractPressedThisFrame)
            {
                return;
            }

            if (Time.unscaledTime < m_exitAllowedAt)
            {
                return;
            }

            EndRead();
        }

        /// <summary>Steps up to <paramref name="terminal"/>. Ignored if one is already up.</summary>
        public bool BeginRead(WallTerminal terminal)
        {
            if (IsBusy || terminal == null || !terminal.CanInteract)
            {
                return false;
            }

            CinemachineCamera camera = terminal.InspectCamera;

            if (camera == null)
            {
                return false;
            }

            m_terminal = terminal;
            m_state = ReadState.Reading;
            m_exitAllowedAt = Time.unscaledTime + m_exitLockoutSeconds;

            // Initialisation-time lookup: the brain lives in the bootstrap scene, so a level scene
            // cannot hold a serialized reference to it.
            m_brain = CinemachineCore.FindPotentialTargetBrain(camera);
            SetBlend(m_zoomSeconds);

            // Switched on rather than promoted. The priority is set once, where the camera is
            // built; an inactive camera is simply not a candidate, which is one less piece of
            // state to put back if something goes wrong halfway.
            camera.Priority = m_activePriority;
            camera.gameObject.SetActive(true);

            // The canvas raycasts through whatever camera it was told about. Point it at the one
            // that is about to be looking at it, or the buttons answer to a cursor somewhere else.
            terminal.SetReadCamera(Camera.main);

            SuspendPlayer(true);
            m_screen = terminal.Screen;

            if (m_screen != null)
            {
                m_screen.Closed += EndRead;
                m_screen.Open();
            }

            ReadingStarted?.Invoke();
            return true;
        }

        /// <summary>Steps back. Safe to call when nothing is up.</summary>
        public void EndRead()
        {
            if (m_state == ReadState.Idle)
            {
                return;
            }

            if (m_screen != null)
            {
                // Close also raises Closed. Unsubscribe first so manual exit cannot recurse.
                m_screen.Closed -= EndRead;
                m_screen.Close();
                m_screen = null;
            }

            if (m_terminal != null && m_terminal.InspectCamera != null)
            {
                m_terminal.InspectCamera.gameObject.SetActive(false);
            }

            SuspendPlayer(false);
            RestoreBlend();

            m_terminal = null;
            m_state = ReadState.Idle;
            ReadingEnded?.Invoke();
        }

        /// <summary>Restore the persistent camera's blend before the terminal's scene is discarded.</summary>
        public void ResetForRescue()
        {
            EndRead();
        }

        private void SuspendPlayer(bool suspended)
        {
            for (int i = 0; i < m_suspendedWhileReading.Length; i++)
            {
                Behaviour behaviour = m_suspendedWhileReading[i];

                if (behaviour == null)
                {
                    continue;
                }

                behaviour.enabled = !suspended;
            }

            if (!m_releaseCursorWhileReading)
            {
                return;
            }

            Cursor.lockState = suspended ? CursorLockMode.None : CursorLockMode.Locked;
            Cursor.visible = suspended;
        }

        /// <summary>
        /// The fly-in and fly-out are brain blends, so the only place their duration lives is the
        /// brain's default blend. Stored and put back rather than left changed: the brain is shared
        /// with every other camera in the game.
        /// </summary>
        private void SetBlend(float seconds)
        {
            if (m_brain == null || m_hasStoredBlend)
            {
                return;
            }

            m_previousBlend = m_brain.DefaultBlend;
            m_hasStoredBlend = true;
            m_brain.DefaultBlend = new CinemachineBlendDefinition(
                CinemachineBlendDefinition.Styles.EaseInOut, seconds);
        }

        private void RestoreBlend()
        {
            if (m_brain == null || !m_hasStoredBlend)
            {
                return;
            }

            m_brain.DefaultBlend = m_previousBlend;
            m_hasStoredBlend = false;
        }
    }
}
