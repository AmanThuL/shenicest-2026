using System;
using System.Threading;
using RootsDance.App;
using RootsDance.Core;
using RootsDance.Player;
using RootsDance.Rendering;
using Unity.Cinemachine;
using UnityEngine;

namespace RootsDance.Scanner
{
    /// <summary>
    /// The read-the-scanner loop, start to finish: raise the arm, sweep the beam over the target,
    /// blow the report up in front of the player, hand control to the UI, and on the player's word
    /// shrink it back onto the plate and lower the arm.
    /// <para>
    /// The camera never moves. An earlier version flew a Cinemachine camera onto the screen, which
    /// took the view off the player's head and read as a cutscene; the read now magnifies the UI
    /// instead — see <see cref="ScannerScreenMagnifier"/> — and the eye stays where the player put
    /// it.
    /// </para>
    /// <para>
    /// Five states and one gate. Nothing else may drive the left arm between
    /// <see cref="ScannerState.Raising"/> and <see cref="ScannerState.Lowering"/> — the arms
    /// contract says raise must be followed by lower — and the player's own movement and look are
    /// suspended while reading, so a stray mouse move cannot swing the world about behind a screen
    /// that fills it.
    /// </para>
    /// </summary>
    public class ScannerInspectController : MonoBehaviour, IRescueResetParticipant
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

        [Tooltip("Retired: the camera the read used to fly in. Kept wired only so it can be held "
            + "switched off — a live Cinemachine camera on the prop would take the view for good.")]
        [SerializeField] private CinemachineCamera m_inspectCamera;

        [Tooltip("Lifts the report off the plate and scales it up to fill the view while reading.")]
        [SerializeField] private ScannerScreenMagnifier m_framing;

        [Tooltip("The beam. Empty = the scan stage is skipped and the screen comes straight up.")]
        [SerializeField] private ScannerScanEffect m_scanEffect;

        [Tooltip("Reads the interact button. Also exits the screen when the player has no mouse "
            + "on the close control.")]
        [SerializeField] private PlayerInputReader m_input;

        [Tooltip("Suspended while reading — the look and move components on the player. The report "
            + "covers the view, so nothing behind it is worth aiming at.")]
        [SerializeField] private Behaviour[] m_suspendedWhileReading = Array.Empty<Behaviour>();

        [Header("Timing")]
        [Tooltip("Extra seconds to hold on the finished sweep before the report comes up, so the "
            + "beam is seen landing rather than being cut off by the screen.")]
        [Range(0f, 2f)]
        [SerializeField] private float m_scanHoldSeconds = 0.25f;

        [Tooltip("Show and unlock the cursor while reading, so the screen's controls are clickable.")]
        [SerializeField] private bool m_releaseCursorWhileReading = true;

        private IScannerView m_view;
        private IScannerScreenView m_screen;
        private ScannerState m_state = ScannerState.Idle;
        private ScannableTarget m_target;
        private CancellationTokenSource m_scanCancellation;

        /// <summary>Where the read loop is right now.</summary>
        public ScannerState State => m_state;

        /// <summary>True while anything other than idle is running.</summary>
        public bool IsBusy => m_state != ScannerState.Idle;

        /// <summary>The object this run is reading, or null for a targetless debug run.</summary>
        public ScannableTarget Target => m_target;

        /// <summary>Raised when the report is up and readable.</summary>
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
            // The prop still carries the old fly-in camera. Nothing activates it any more, but a
            // Cinemachine camera that is merely present and enabled outranks the first-person one
            // and parks the view on the scanner for the rest of the session, so it is switched off
            // here rather than left to whatever the prefab happens to be serialized with.
            if (m_inspectCamera != null)
            {
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
            CancelScan();
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
            if (m_state != ScannerState.Idle)
            {
                Rendering.CloseUpFocus.HoldThisFrame();
            }

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

            if (!WorldAccess.TryBeginExclusiveInteraction(this))
            {
                return false;
            }

            m_target = target;
            m_state = ScannerState.Raising;

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

            if (m_framing != null)
            {
                m_framing.Restore();
            }

            SuspendPlayer(false);

            if (m_view == null)
            {
                OnLowerFinished();
                return;
            }

            m_view.PlayLower();
        }

        /// <summary>Stops unfinished scans without recording them and removes camera-parented report UI.</summary>
        public void ResetForRescue()
        {
            CancelScan();
            WorldAccess.EndExclusiveInteraction(this);
            m_state = ScannerState.Idle;
            m_target = null;
            m_screen?.Close();
            if (m_scanEffect != null)
            {
                m_scanEffect.Stop();
            }

            if (m_framing != null)
            {
                m_framing.ResetForRescue();
            }
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
            CancelScan();
            m_scanCancellation = CancellationTokenSource.CreateLinkedTokenSource(destroyCancellationToken);
            _ = ScanThenReadAsync(m_scanCancellation.Token);
        }

        private async Awaitable ScanThenReadAsync(CancellationToken cancellationToken)
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
                    m_scanEffect.Duration + m_scanHoldSeconds, cancellationToken);
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
                    await Awaitable.NextFrameAsync(cancellationToken);
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
                m_framing.Magnify();
            }

            SuspendPlayer(true);

            if (m_screen != null)
            {
                m_screen.Open();
            }

            ReadingStarted?.Invoke();
        }

        private void CancelScan()
        {
            CancellationTokenSource cancellation = m_scanCancellation;
            m_scanCancellation = null;
            if (cancellation != null)
            {
                cancellation.Cancel();
                cancellation.Dispose();
            }
        }

        private void OnLowerFinished()
        {
            if (m_state != ScannerState.Lowering)
            {
                return;
            }

            m_state = ScannerState.Idle;
            m_target = null;
            WorldAccess.EndExclusiveInteraction(this);
            ReadingEnded?.Invoke();
        }

        private void OnDestroy()
        {
            // Mid-read scene unload: the loop will never reach idle, so the gate is opened here.
            WorldAccess.EndExclusiveInteraction(this);
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
    }
}
