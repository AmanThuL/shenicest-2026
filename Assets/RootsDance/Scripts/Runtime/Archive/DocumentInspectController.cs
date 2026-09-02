using System;
using System.Threading;
using RootsDance.App;
using RootsDance.Core;
using RootsDance.Interaction;
using RootsDance.Player;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Archive
{
    /// <summary>
    /// The pick-up-and-read loop for a sheet of paper, start to finish: lift it off the desk, hold
    /// it up to the player's face, let them wipe it, turn it and lean in, and on their word lay it
    /// back down exactly where it was.
    /// <para>
    /// Four states and one gate. The sheet is a real object moved through the world, not a
    /// full-screen UI: the camera never moves, the paper comes to the eye. That is why the player's
    /// own look and move are suspended for the duration — the mouse is turning the page while it is
    /// up, so it cannot also be turning the head. One owner per axis.
    /// </para>
    /// </summary>
    public class DocumentInspectController : MonoBehaviour, IRescueResetParticipant
    {
        /// <summary>Where the read loop is. Public so a debug trigger can show it.</summary>
        public enum ReadState
        {
            Idle = 0,

            /// <summary>The sheet is travelling from where it lay to the reading pose.</summary>
            Raising = 1,
            Reading = 2,

            /// <summary>The sheet is travelling back to where it lay.</summary>
            Lowering = 3
        }

        [Header("Wiring")]
        [Tooltip("Where the sheet is held, normally a child of the head. Its forward is the "
            + "direction the player is looking; the sheet stands off along that axis.")]
        [SerializeField] private Transform m_holdAnchor;

        [Tooltip("Reads the interact button (put the sheet down), the look axes (turn it) and the "
            + "move axes (lean in and out).")]
        [SerializeField] private PlayerInputReader m_input;

        [Tooltip("Suspended while reading — normally the look, the move and the interaction ray. "
            + "One owner per axis: the sheet owns the mouse for as long as it is up.")]
        [SerializeField] private Behaviour[] m_suspendedWhileReading = Array.Empty<Behaviour>();

        [Header("Framing")]
        [Tooltip("Fraction of the view the sheet covers when first raised — held at arm's length, "
            + "so the shape of the page reads before any of the writing does.")]
        [Range(0.2f, 1f)]
        [SerializeField] private float m_restFill = 0.55f;

        [Tooltip("Fraction of the view it covers leaned all the way in, close enough to read the "
            + "handwriting. Must be larger than Rest Fill.")]
        [Range(0.2f, 1f)]
        [SerializeField] private float m_zoomedFill = 0.92f;

        [Tooltip("How fast the sheet travels towards and away from the eye, metres per second.")]
        [Range(0.05f, 2f)]
        [SerializeField] private float m_zoomMetresPerSecond = 0.35f;

        [Tooltip("Field of view used to work out the hold distance while no camera can be found.")]
        [Range(10f, 100f)]
        [SerializeField] private float m_fallbackFieldOfView = 60f;

        [Header("Handling")]
        [Tooltip("How far the sheet turns per pixel of pointer movement.")]
        [Range(0.01f, 1f)]
        [SerializeField] private float m_degreesPerPixel = 0.12f;

        [Tooltip("Largest tip away from the reader, either way, in degrees.")]
        [Range(0f, 80f)]
        [SerializeField] private float m_maxPitchDegrees = 26f;

        [Tooltip("Largest turn about the page's up axis, either way, in degrees.")]
        [Range(0f, 80f)]
        [SerializeField] private float m_maxYawDegrees = 30f;

        [Tooltip("How fast the sheet turns over when the player flips it, degrees per second.")]
        [Range(90f, 1440f)]
        [SerializeField] private float m_flipDegreesPerSecond = 480f;

        [Header("Pose")]
        [Tooltip("Rotation of the sheet in the anchor's space when it faces the reader squarely. "
            + "A canvas is read from behind its forward axis — the same way the default camera "
            + "looks along +Z at a canvas at the origin — so square-on is no turn at all.")]
        [SerializeField] private Vector3 m_readEulerOffset = Vector3.zero;

        [Header("Timing")]
        [Tooltip("Seconds the sheet takes to come up off the desk.")]
        [Range(0.05f, 3f)]
        [SerializeField] private float m_raiseSeconds = 0.45f;

        [Tooltip("Seconds it takes to go back down.")]
        [Range(0.05f, 3f)]
        [SerializeField] private float m_lowerSeconds = 0.35f;

        [Header("Reading light")]
        [Tooltip("Shown while the raised sheet is too dark to read and no torch is in hand. With "
            + "a torch in hand the torch's own [F] teaching line speaks instead.")]
        [SerializeField] private string m_tooDarkHint = "太暗了，看不清……";

        [Tooltip("Page luminance below which the raised sheet counts as unreadable.")]
        [Range(0f, 1f)]
        [SerializeField] private float m_darkReadLuminance = 0.25f;

        /// <summary>Above the torch's standing [F] teacher, below every contextual offer.</summary>
        private const int k_DarkHintPriority = -4;

        private Camera m_camera;
        private ReadState m_state = ReadState.Idle;
        private ArchivePaperLighting m_paperLighting;
        private ArchiveDocumentPickup m_pickup;
        private IArchiveDocumentPageView m_page;
        private Transform m_sheet;
        private Transform m_originParent;
        private Scene m_originScene;
        private Vector3 m_originLocalScale;
        private Vector3 m_originWorldPosition;
        private Quaternion m_originWorldRotation;
        private Vector2 m_tilt;
        private float m_distance;
        private float m_nearDistance;
        private float m_farDistance;
        private float m_flipAngle;
        private float m_flipTarget;
        private CancellationTokenSource m_readCancellation;

        /// <summary>Where the read loop is right now.</summary>
        public ReadState State => m_state;

        /// <summary>True while anything other than idle is running.</summary>
        public bool IsBusy => m_state != ReadState.Idle;

        /// <summary>The sheet this run is reading, or null when idle.</summary>
        public ArchiveDocumentPickup Current => m_pickup;

        /// <summary>Raised when the sheet is up and readable.</summary>
        public event Action ReadingStarted;

        /// <summary>Raised once the sheet is down and control is the player's again.</summary>
        public event Action ReadingEnded;

        private void Start()
        {
            // Initialisation-time lookup: the single camera lives in the bootstrap scene, so it
            // cannot be a serialized reference from a level scene (guideline 03).
            m_camera = Camera.main;

            if (m_camera == null)
            {
                Log.Warning("No main camera found; the hold distance falls back to the serialized "
                    + "field of view.", this);
            }
        }

        private void Update()
        {
            if (m_state != ReadState.Reading || m_sheet == null)
            {
                return;
            }

            if (m_input != null)
            {
                if (m_input.InteractPressedThisFrame)
                {
                    RequestPutDown();
                    return;
                }

                m_tilt = DocumentInspectMath.Tilt(m_tilt, m_input.LookInput, m_degreesPerPixel,
                    m_maxPitchDegrees, m_maxYawDegrees);

                m_distance = DocumentInspectMath.Zoom(m_distance, m_input.MoveInput.y,
                    m_zoomMetresPerSecond, Time.deltaTime, m_nearDistance, m_farDistance);

                if (m_input.FlipPressedThisFrame && m_pickup != null && m_pickup.HasBackFace)
                {
                    m_flipTarget = Mathf.Approximately(m_flipTarget, 0f) ? 180f : 0f;
                }
            }

            m_flipAngle = Mathf.MoveTowards(m_flipAngle, m_flipTarget,
                m_flipDegreesPerSecond * Time.deltaTime);

            OfferDarkHint();
            ApplyReadPose();
        }

        private void OnDestroy()
        {
            CancelRead();
            ClearDarkHint();

            // Mid-read scene unload: the loop will never reach idle, so the gate is opened here.
            WorldAccess.EndExclusiveInteraction(this);
        }

        /// <summary>Returns the sheet to its outgoing scene without marking it read or raising story flags.</summary>
        public void ResetForRescue()
        {
            CancelRead();
            if (m_state == ReadState.Idle)
            {
                return;
            }

            m_page?.EndReading();
            RestoreSheetOrigin();
            ClearDarkHint();
            m_state = ReadState.Idle;
            m_pickup = null;
            m_page = null;
            m_sheet = null;
            m_paperLighting = null;
            m_originParent = null;
            WorldAccess.EndExclusiveInteraction(this);
        }

        /// <summary>
        /// Lifts <paramref name="pickup"/> off the desk. Returns false when a sheet is already up,
        /// which is how a second press in the same frame is dropped rather than queued.
        /// </summary>
        public bool BeginRead(ArchiveDocumentPickup pickup)
        {
            if (m_state != ReadState.Idle || pickup == null)
            {
                return false;
            }

            Transform sheet = pickup.Sheet;

            if (sheet == null || m_holdAnchor == null)
            {
                Log.Error("DocumentInspectController needs a hold anchor and a sheet transform.", this);
                return false;
            }

            if (!WorldAccess.TryBeginExclusiveInteraction(this))
            {
                return false;
            }

            m_pickup = pickup;
            m_page = pickup.PageView;
            m_sheet = sheet;
            m_paperLighting = sheet.GetComponentInChildren<ArchivePaperLighting>(true);
            m_originParent = sheet.parent;
            m_originScene = sheet.gameObject.scene;
            m_originLocalScale = sheet.localScale;
            m_originWorldPosition = sheet.position;
            m_originWorldRotation = sheet.rotation;

            m_tilt = Vector2.zero;
            m_flipAngle = 0f;
            m_flipTarget = 0f;
            MeasureHoldDistances(pickup);
            m_distance = m_farDistance;

            // Parenting to the anchor first means every pose below is a local one, so the sheet
            // rides with the head for free instead of being chased in world space each frame.
            sheet.SetParent(m_holdAnchor, true);

            m_state = ReadState.Raising;
            SuspendPlayer(true);
            CancelRead();
            m_readCancellation = CancellationTokenSource.CreateLinkedTokenSource(destroyCancellationToken);
            RaiseEntryAsync(m_readCancellation.Token);

            return true;
        }

        /// <summary>Lays the sheet back down. Safe to call when nothing is up.</summary>
        public void RequestPutDown()
        {
            if (m_state != ReadState.Reading)
            {
                return;
            }

            m_state = ReadState.Lowering;
            ClearDarkHint();

            if (m_page != null)
            {
                m_page.EndReading();
            }

            LowerEntryAsync(m_readCancellation.Token);
        }

        /// <summary>
        /// Fire-and-forget entry point: an un-awaited <c>async Awaitable</c> swallows its
        /// exceptions, so the body is wrapped here (guideline 04).
        /// </summary>
        private async void RaiseEntryAsync(CancellationToken cancellationToken)
        {
            try
            {
                await TweenToReadPoseAsync(m_raiseSeconds, cancellationToken);

                if (m_state != ReadState.Raising)
                {
                    return;
                }

                m_state = ReadState.Reading;

                if (m_page != null)
                {
                    m_page.BeginReading();
                }

                ReadingStarted?.Invoke();
            }
            catch (OperationCanceledException)
            {
                // The player object went away mid-tween; nothing left to put back.
            }
            catch (Exception exception)
            {
                Log.Exception(exception, this);
            }
        }

        /// <summary>Fire-and-forget entry point; see <see cref="RaiseEntryAsync"/>.</summary>
        private async void LowerEntryAsync(CancellationToken cancellationToken)
        {
            try
            {
                await TweenToOriginAsync(m_lowerSeconds, cancellationToken);

                if (m_state != ReadState.Lowering)
                {
                    return;
                }

                ArchiveDocumentPickup pickup = m_pickup;

                RestoreSheetOrigin();

                m_state = ReadState.Idle;
                m_pickup = null;
                m_page = null;
                m_sheet = null;
                m_paperLighting = null;
                m_originParent = null;

                SuspendPlayer(false);
                WorldAccess.EndExclusiveInteraction(this);

                if (pickup != null)
                {
                    pickup.OnReadFinished();
                }

                ReadingEnded?.Invoke();
            }
            catch (OperationCanceledException)
            {
                // See above.
            }
            catch (Exception exception)
            {
                Log.Exception(exception, this);
            }
        }

        /// <summary>Eases the sheet from wherever it is to the reading pose.</summary>
        private async Awaitable TweenToReadPoseAsync(float seconds, CancellationToken cancellationToken)
        {
            Vector3 fromPosition = m_sheet.localPosition;
            Quaternion fromRotation = m_sheet.localRotation;

            for (float elapsed = 0f; elapsed < seconds; elapsed += Time.deltaTime)
            {
                float t = Smooth(elapsed / seconds);
                m_sheet.localPosition = Vector3.Lerp(fromPosition, ReadPosition(), t);
                m_sheet.localRotation = Quaternion.Slerp(fromRotation, ReadRotation(), t);

                await Awaitable.NextFrameAsync(cancellationToken);
            }

            ApplyReadPose();
        }

        /// <summary>
        /// Eases the sheet back to the pose it was found in. The target is recomputed from the
        /// stored world pose every frame, so the sheet still lands correctly if the anchor moves.
        /// </summary>
        private async Awaitable TweenToOriginAsync(float seconds, CancellationToken cancellationToken)
        {
            Vector3 fromPosition = m_sheet.localPosition;
            Quaternion fromRotation = m_sheet.localRotation;

            for (float elapsed = 0f; elapsed < seconds; elapsed += Time.deltaTime)
            {
                float t = Smooth(elapsed / seconds);
                Vector3 toPosition = m_holdAnchor.InverseTransformPoint(m_originWorldPosition);
                Quaternion toRotation = Quaternion.Inverse(m_holdAnchor.rotation) * m_originWorldRotation;

                m_sheet.localPosition = Vector3.Lerp(fromPosition, toPosition, t);
                m_sheet.localRotation = Quaternion.Slerp(fromRotation, toRotation, t);

                await Awaitable.NextFrameAsync(cancellationToken);
            }
        }

        private void ApplyReadPose()
        {
            m_sheet.localPosition = ReadPosition();
            m_sheet.localRotation = ReadRotation();
        }

        private void RestoreSheetOrigin()
        {
            if (m_sheet == null)
            {
                return;
            }

            m_sheet.SetParent(m_originParent, true);
            if (m_originParent == null && m_originScene.IsValid() && m_originScene.isLoaded)
            {
                SceneManager.MoveGameObjectToScene(m_sheet.gameObject, m_originScene);
            }

            m_sheet.SetPositionAndRotation(m_originWorldPosition, m_originWorldRotation);
            m_sheet.localScale = m_originLocalScale;
        }

        private void CancelRead()
        {
            CancellationTokenSource cancellation = m_readCancellation;
            m_readCancellation = null;
            if (cancellation != null)
            {
                cancellation.Cancel();
                cancellation.Dispose();
            }
        }

        private Vector3 ReadPosition()
        {
            return new Vector3(0f, 0f, m_distance);
        }

        private Quaternion ReadRotation()
        {
            return Quaternion.Euler(
                m_readEulerOffset.x + m_tilt.x,
                m_readEulerOffset.y + m_tilt.y + m_flipAngle,
                m_readEulerOffset.z);
        }

        /// <summary>
        /// Works out the two ends of the zoom for this sheet. Both come from the same framing sum,
        /// so a small note and a large sheet each end up filling the same fraction of the view.
        /// </summary>
        private void MeasureHoldDistances(ArchiveDocumentPickup pickup)
        {
            Vector2 size = pickup.PageSizeMeters;
            float fov = m_camera == null ? m_fallbackFieldOfView : m_camera.fieldOfView;
            float aspect = m_camera == null
                ? (Screen.height > 0 ? (float)Screen.width / Screen.height : 16f / 9f)
                : m_camera.aspect;

            m_nearDistance = DocumentInspectMath.HoldDistance(size, fov, aspect, m_zoomedFill);
            m_farDistance = DocumentInspectMath.HoldDistance(size, fov, aspect, m_restFill);
        }

        /// <summary>
        /// A sheet held up in the dark says so. The line rides the torch's own hint channel — the
        /// torch already owns the channel asset, and this controller is saved once per level
        /// scene, where a cross-scene reference to it cannot be (guideline 03). With a torch in
        /// hand this stands down and the torch's own [F] teacher speaks; with none there is
        /// nothing to press, so the line just names the problem.
        /// </summary>
        private void OfferDarkHint()
        {
            FlashlightController torch = FlashlightController.Active;

            if (torch == null || torch.PromptChannel == null)
            {
                return;
            }

            bool dark = m_paperLighting != null && m_paperLighting.Luminance < m_darkReadLuminance;
            bool wanted = m_state == ReadState.Reading && dark && !torch.IsHeld;

            InteractionPrompts.Set(this, torch.PromptChannel,
                wanted ? m_tooDarkHint : string.Empty, k_DarkHintPriority);
        }

        private void ClearDarkHint()
        {
            FlashlightController torch = FlashlightController.Active;

            if (torch != null && torch.PromptChannel != null)
            {
                InteractionPrompts.Clear(this, torch.PromptChannel);
            }
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
        }

        /// <summary>Smoothstep on 0..1, so the sheet neither jumps off the desk nor slams to a stop.</summary>
        private static float Smooth(float t)
        {
            float clamped = Mathf.Clamp01(t);

            return clamped * clamped * (3f - 2f * clamped);
        }
    }
}
