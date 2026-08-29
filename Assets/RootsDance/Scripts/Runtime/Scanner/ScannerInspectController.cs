using System;
using RootsDance.Core;
using RootsDance.Player;
using RootsDance.Rendering;
using Unity.Cinemachine;
using UnityEngine;

namespace RootsDance.Scanner
{
    /// <summary>
    /// The read-the-scanner loop, start to finish: raise the arm, sweep the beam over the target,
    /// fly the camera onto the screen, hand control to the UI, and on the player's word fly back
    /// and lower the arm.
    /// <para>
    /// Five states and one gate. Nothing else may drive the left arm between
    /// <see cref="ScannerState.Raising"/> and <see cref="ScannerState.Lowering"/> — the arms
    /// contract says raise must be followed by lower — and the player's own movement and look are
    /// suspended while reading, or the eye would fight the inspect camera for the same axes.
    /// </para>
    /// </summary>
    public class ScannerInspectController : MonoBehaviour
    {
        /// <summary>Where the read loop is. Public so a debug trigger can show it.</summary>
        public enum ScannerState
        {
            Idle = 0,
            Raising = 1,

            /// <summary>The beam is sweeping the target. The screen is not up yet.</summary>
            Scanning = 2,
            Reading = 3,
            Lowering = 4
        }

        [Header("Wiring")]
        [Tooltip("Art component implementing IScannerView (the arms rig). Empty = instant raise.")]
        [SerializeField] private MonoBehaviour m_viewBehaviour;

        [Tooltip("Component implementing IScannerScreenView (the report canvas). Optional.")]
        [SerializeField] private MonoBehaviour m_screenBehaviour;

        [Tooltip("The camera parked in front of the screen. Disabled until the player reads.")]
        [SerializeField] private CinemachineCamera m_inspectCamera;

        [Tooltip("Recomputes the camera pose from the fill ratio when reading starts.")]
        [SerializeField] private ScannerInspectFraming m_framing;

        [Tooltip("The beam. Empty = the scan stage is skipped and the screen comes straight up.")]
        [SerializeField] private ScannerScanEffect m_scanEffect;

        [Tooltip("Reads the interact button. Also exits the screen when the player has no mouse "
            + "on the close control.")]
        [SerializeField] private PlayerInputReader m_input;

        [Tooltip("Suspended while reading — the look and move components on the player. One owner "
            + "per axis: the inspect camera owns the view for as long as it is up.")]
        [SerializeField] private Behaviour[] m_suspendedWhileReading = Array.Empty<Behaviour>();

        [Header("Timing")]
        [Tooltip("Seconds the camera takes to fly in, and to fly back out. Short on purpose: this "
            + "is the player raising something to look at it, not a cutscene.")]
        [Range(0.1f, 4f)]
        [SerializeField] private float m_zoomSeconds = 0.4f;

        [Tooltip("Extra seconds to hold on the finished sweep before the camera flies in, so the "
            + "beam is seen landing rather than being cut off by the zoom.")]
        [Range(0f, 2f)]
        [SerializeField] private float m_scanHoldSeconds = 0.25f;

        [Tooltip("Priority given to the inspect camera while it is up. Above the first-person "
            + "camera, below anything cinematic.")]
        [SerializeField] private int m_activePriority = 30;

        [Tooltip("Show and unlock the cursor while reading, so the screen's controls are clickable.")]
        [SerializeField] private bool m_releaseCursorWhileReading = true;

        private IScannerView m_view;
        private IScannerScreenView m_screen;
        private CinemachineBrain m_brain;
        private CinemachineBlendDefinition m_previousBlend;
        private bool m_hasStoredBlend;
        private ScannerState m_state = ScannerState.Idle;
        private ScannableTarget m_target;

        /// <summary>Where the read loop is right now.</summary>
        public ScannerState State => m_state;

        /// <summary>True while anything other than idle is running.</summary>
        public bool IsBusy => m_state != ScannerState.Idle;

        /// <summary>The object this run is reading, or null for a targetless debug run.</summary>
        public ScannableTarget Target => m_target;

        /// <summary>Raised when the camera has arrived and the screen is readable.</summary>
        public event Action ReadingStarted;

        /// <summary>Raised once the arm is back down and control is the player's again.</summary>
        public event Action ReadingEnded;

        private void Awake()
        {
            m_view = m_viewBehaviour as IScannerView;
            m_screen = m_screenBehaviour as IScannerScreenView;

            if (m_viewBehaviour != null && m_view == null)
            {
                Log.Error("ScannerInspectController's view does not implement IScannerView.", this);
            }

            if (m_screenBehaviour != null && m_screen == null)
            {
                Log.Error("ScannerInspectController's screen does not implement IScannerScreenView.",
                    this);
            }
        }

        private void Start()
        {
            // Initialisation-time lookup: the brain lives in the bootstrap scene, so it cannot be a
            // serialized reference from a level scene.
            if (m_inspectCamera != null)
            {
                m_brain = CinemachineCore.FindPotentialTargetBrain(m_inspectCamera);
                m_inspectCamera.Priority = m_activePriority;
                m_inspectCamera.gameObject.SetActive(false);
            }

            if (m_screen != null)
            {
                m_screen.Close();
            }
        }

        private void OnEnable()
        {
            if (m_view != null)
            {
                m_view.RaiseFinished += OnRaiseFinished;
                m_view.LowerFinished += OnLowerFinished;
            }

            if (m_screen != null)
            {
                m_screen.CloseRequested += RequestExit;
            }
        }

        private void OnDisable()
        {
            if (m_view != null)
            {
                m_view.RaiseFinished -= OnRaiseFinished;
                m_view.LowerFinished -= OnLowerFinished;
            }

            if (m_screen != null)
            {
                m_screen.CloseRequested -= RequestExit;
            }
        }

        private void Update()
        {
            if (m_state != ScannerState.Reading || m_input == null)
            {
                return;
            }

            if (m_input.InteractPressedThisFrame)
            {
                RequestExit();
            }
        }

        /// <summary>
        /// Starts the loop. Returns false when it is already running, which is how a second trigger
        /// in the same frame is dropped rather than queued.
        /// </summary>
        public bool BeginInspect()
        {
            return BeginInspect(null);
        }

        /// <summary>
        /// Starts the loop on one target. Returns false when it is already running, which is how a
        /// second trigger in the same frame is dropped rather than queued.
        /// </summary>
        public bool BeginInspect(ScannableTarget target)
        {
            if (m_state != ScannerState.Idle)
            {
                return false;
            }

            m_target = target;
            m_state = ScannerState.Raising;
            SetBlend(m_zoomSeconds);

            if (m_view == null)
            {
                OnRaiseFinished();
                return true;
            }

            m_view.PlayRaise();

            return true;
        }

        /// <summary>Leaves the screen. Safe to call from a UI button or from the interact key.</summary>
        public void RequestExit()
        {
            if (m_state != ScannerState.Reading)
            {
                return;
            }

            m_state = ScannerState.Lowering;

            if (m_screen != null)
            {
                m_screen.Close();
            }

            SetCameraActive(false);
            SuspendPlayer(false);

            if (m_view == null)
            {
                OnLowerFinished();
                return;
            }

            m_view.PlayLower();
        }

        /// <summary>
        /// The arm is up. Sweep the beam over the target before the screen comes on: the reading is
        /// meant to be the result of the scan, so the two cannot happen at once.
        /// </summary>
        private void OnRaiseFinished()
        {
            if (m_state != ScannerState.Raising)
            {
                return;
            }

            if (m_scanEffect == null)
            {
                EnterReading();
                return;
            }

            m_state = ScannerState.Scanning;
            _ = ScanThenReadAsync();
        }

        private async Awaitable ScanThenReadAsync()
        {
            if (m_target == null)
            {
                m_scanEffect.Play();
            }
            else
            {
                m_scanEffect.PlayToward(m_target.AimPosition);
            }

            try
            {
                await Awaitable.WaitForSecondsAsync(
                    m_scanEffect.Duration + m_scanHoldSeconds, destroyCancellationToken);
            }
            catch (OperationCanceledException)
            {
                return;
            }

            m_scanEffect.Stop();

            if (m_target != null)
            {
                m_target.MarkScanned();

                // Scan result bridges enqueue report/flag commands. Let GameBootstrap drain them before the
                // report presenter opens, so the page revealed by this scan is visible on the first frame.
                try
                {
                    await Awaitable.NextFrameAsync(destroyCancellationToken);
                }
                catch (OperationCanceledException)
                {
                    return;
                }
            }

            if (m_state == ScannerState.Scanning)
            {
                EnterReading();
            }
        }

        private void EnterReading()
        {
            m_state = ScannerState.Reading;

            if (m_framing != null)
            {
                m_framing.Apply();
            }

            SetCameraActive(true);
            SuspendPlayer(true);

            if (m_screen != null)
            {
                m_screen.Open();
            }

            ReadingStarted?.Invoke();
        }

        private void OnLowerFinished()
        {
            if (m_state != ScannerState.Lowering)
            {
                return;
            }

            m_state = ScannerState.Idle;
            m_target = null;
            RestoreBlend();
            ReadingEnded?.Invoke();
        }

        private void SetCameraActive(bool active)
        {
            if (m_inspectCamera == null)
            {
                return;
            }

            m_inspectCamera.gameObject.SetActive(active);
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
        /// The fly-in and fly-out are Cinemachine blends, so the only place their duration lives is
        /// the brain's default blend. It is stored and put back rather than left changed, because
        /// the brain is shared with every other camera in the game.
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
