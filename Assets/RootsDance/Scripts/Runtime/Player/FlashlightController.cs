using RootsDance.App;
using RootsDance.Core;
using RootsDance.Events;
using RootsDance.Player.Arms;
using UnityEngine;
using UnityEngine.Rendering;

namespace RootsDance.Player
{
    /// <summary>
    /// Drives the first-person flashlight: the world's time of day switches it on, the flashlight
    /// button flips it, and the beam fades in and out instead of popping.
    /// <para>
    /// With no beam anchor wired the Light sits exactly on the eye, which keeps the cone centred on
    /// screen and never parallaxing against the view — the cheapest thing that reads correctly in
    /// the volumetric fog, and still the fallback.
    /// </para>
    /// <para>
    /// With a beam anchor wired the torch emits from the hand that holds it instead. That is what
    /// makes the pool of light read as a carried object: the cone leaves from below and to one side
    /// of the eye, so it meets a wall obliquely and lands as an ellipse rather than as the perfect
    /// circle an eye-mounted light always draws. The axis is aimed at a point out along the view
    /// ray rather than straight down the hand bone, so the torch still lights what the player is
    /// looking at while keeping that off-axis angle.
    /// </para>
    /// <para>
    /// Nothing is lit while no hand holds the torch. The switch keeps its setting, but the Light is
    /// off and <see cref="FlashlightBeamBroadcaster"/> publishes a dead beam, so no surface in any
    /// scene reacts to a torch that is not in a hand.
    /// </para>
    /// </summary>
    [RequireComponent(typeof(PlayerInputReader))]
    public class FlashlightController : MonoBehaviour
    {
        [Header("Wiring")]
        [Tooltip("The Spot light on Head/Flashlight. Its authored intensity is the 'on' brightness.")]
        [SerializeField] private Light m_light;

        [Tooltip("The hand socket that carries the torch. Leave empty and the torch counts as " +
                 "always held, which is the behaviour from before hands existed.")]
        [SerializeField] private HandSocket m_holdSocket;

        [Tooltip("The torch itself, as a carried item. With a socket wired but no item, any " +
                 "occupied hand counts — which would light the beam while holding the helmet.")]
        [SerializeField] private CarriedItem m_torchItem;

        [Tooltip("Where the beam leaves from — the torch's emitter, or the hand socket itself. " +
                 "Leave empty and the beam sits on the eye instead.")]
        [SerializeField] private Transform m_beamAnchor;

        [Header("Tuning")]
        [Tooltip("Night switches the beam on and day switches it off. Off = the button is the only control.")]
        [SerializeField] private bool m_autoOnAtNight = true;

        [Tooltip("Seconds for the beam to fade from off to full brightness, and back.")]
        [SerializeField] private float m_fadeSeconds = 0.15f;

        [Tooltip("Metres out along the view ray that a hand-held beam is aimed at. Larger is " +
                 "closer to parallel with the view — and a rounder pool. 0 points the beam " +
                 "straight down the anchor's own forward instead.")]
        [Range(0f, 40f)][SerializeField] private float m_aimDistance = 7f;

        [Header("Listens to")]
        [Tooltip("Time-of-day channel raised by GameBootstrap when the world phase changes.")]
        [SerializeField] private TimeOfDayEventChannelSO m_timeOfDayChanged;

        /// <summary>Metres past which a "hand" anchor cannot be a hand, so the eye is used.</summary>
        private const float k_MaxHandReach = 1.5f;

        private PlayerInputReader m_input;
        private FlashlightState m_state;
        private float m_fullIntensity;
        private bool m_hasLight;
        private bool m_isSeeded;

        /// <summary>
        /// How far the beam has faded up, 0 while it is off and 1 at the authored intensity.
        /// <see cref="FlashlightBeamBroadcaster"/> publishes this so surfaces that react to the
        /// beam fade with it instead of popping on at the first frame of the fade.
        /// </summary>
        public float BeamStrength =>
            m_hasLight && m_fullIntensity > 0f ? m_light.intensity / m_fullIntensity : 0f;

        /// <summary>
        /// Whether a hand is holding the torch. With no socket wired this is always true, so a
        /// scene built before the arms existed still lights up.
        /// </summary>
        public bool IsHeld
        {
            get
            {
                if (m_holdSocket == null)
                {
                    return true;
                }

                // With an item named, only that item counts. Any occupied hand would otherwise
                // light the torch while the hand is holding the helmet.
                return m_torchItem == null
                    ? m_holdSocket.IsCarrying
                    : m_holdSocket.Carried == m_torchItem;
            }
        }

        private void Awake()
        {
            m_input = GetComponent<PlayerInputReader>();
            m_state = new FlashlightState(m_autoOnAtNight);
            m_hasLight = m_light != null;

            if (!m_hasLight)
            {
                Log.Error("FlashlightController has no Light assigned; the flashlight is disabled.", this);
                return;
            }

            // The authored intensity is the design value; the beam starts dark and fades up from there.
            m_fullIntensity = m_light.intensity;
            m_light.intensity = 0f;
            m_light.enabled = false;
        }

        private void OnEnable()
        {
            if (m_timeOfDayChanged != null)
            {
                m_timeOfDayChanged.EventRaised += OnTimeOfDayChanged;
            }

            RenderPipelineManager.beginCameraRendering += OnBeginCameraRendering;
        }

        /// <summary>
        /// Glues the Light to the camera that is about to render. The camera follows Head through
        /// Cinemachine with a little damping, so while walking it trails Head by a centimetre or
        /// two — enough to put the light's origin in front of the near plane, where HDRP's volumetric
        /// fog integrates the near-singular irradiance around it and the whole view goes white. At
        /// the camera's exact pose that region is never rendered. Done right before rendering (after
        /// every LateUpdate, including the CinemachineBrain's) so the pose can never be a frame stale.
        /// </summary>
        private void OnBeginCameraRendering(ScriptableRenderContext context, Camera camera)
        {
            if (!m_hasLight || !FlashlightCameraLock.ShouldFollow(camera.cameraType))
            {
                return;
            }

            Transform cameraTransform = camera.transform;

            if (m_beamAnchor == null || !IsHeld)
            {
                m_light.transform.SetPositionAndRotation(cameraTransform.position,
                    cameraTransform.rotation);
                return;
            }

            // Origin from the hand, axis toward what the eye is looking at. Aiming straight down
            // the hand bone would send the beam wherever the animation happens to point the wrist,
            // which is unplayable; converging on the view ray keeps the light useful and still
            // leaves the few degrees of offset that turn the pool into an ellipse.
            Vector3 origin = m_beamAnchor.position;

            // A torch in a hand is never further from the eye than arm's length. Anything more
            // means the rig is not posed - an unplayed animator, a scene without arms - and the
            // beam would be left somewhere across the level. Fall back to the eye rather than
            // ship a flashlight that lights the floor behind the player.
            if ((origin - cameraTransform.position).sqrMagnitude > k_MaxHandReach * k_MaxHandReach)
            {
                m_light.transform.SetPositionAndRotation(cameraTransform.position,
                    cameraTransform.rotation);
                return;
            }

            Vector3 forward = m_aimDistance > 0f
                ? cameraTransform.position + cameraTransform.forward * m_aimDistance - origin
                : m_beamAnchor.forward;

            if (forward.sqrMagnitude < 1e-6f)
            {
                forward = cameraTransform.forward;
            }

            m_light.transform.SetPositionAndRotation(origin,
                Quaternion.LookRotation(forward.normalized, cameraTransform.up));
        }

        private void Update()
        {
            if (!m_hasLight)
            {
                return;
            }

            SeedFromWorldState();
            m_state.SetHeld(IsHeld);

            if (m_input.FlashlightPressedThisFrame)
            {
                m_state.Toggle();
            }

            Fade();
        }

        private void OnDisable()
        {
            RenderPipelineManager.beginCameraRendering -= OnBeginCameraRendering;

            if (m_timeOfDayChanged != null)
            {
                m_timeOfDayChanged.EventRaised -= OnTimeOfDayChanged;
            }
        }

        private void OnTimeOfDayChanged(TimeOfDay phase)
        {
            // The channel carries the same truth the seed would read, so a phase change also counts
            // as seeded — otherwise the seed would undo a toggle made before the bootstrap arrived.
            m_isSeeded = true;
            m_state.OnPhase(phase);
        }

        /// <summary>
        /// Reads the starting phase once the bootstrap exists. Play started from a level scene brings
        /// it up a frame late, which is why this is here and not in Start.
        /// </summary>
        private void SeedFromWorldState()
        {
            if (m_isSeeded)
            {
                return;
            }

            IWorldStateReader state = WorldAccess.State;

            if (state == null)
            {
                return;
            }

            m_isSeeded = true;
            m_state.OnPhase(state.TimeOfDay);
        }

        private void Fade()
        {
            float target = m_state.IsLit ? m_fullIntensity : 0f;
            float maxDelta = m_fadeSeconds <= 0f
                ? m_fullIntensity
                : m_fullIntensity * Time.deltaTime / m_fadeSeconds;

            float intensity = FlashlightState.StepIntensity(m_light.intensity, target, maxDelta);
            m_light.intensity = intensity;

            // A Light at zero intensity still costs culling and a shadow slot, so switch the component
            // off outright; only assign when it actually changes to keep the native call off every frame.
            bool shouldBeLit = intensity > 0f;

            if (m_light.enabled != shouldBeLit)
            {
                m_light.enabled = shouldBeLit;
            }
        }
    }
}
