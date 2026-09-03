using RootsDance.App;
using RootsDance.Core;
using RootsDance.Events;
using RootsDance.Interaction;
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

        [Tooltip("Where the beam leaves from — the torch's emitter, or the hand socket itself. " +
                 "Leave empty and the beam sits on the eye instead.")]
        [SerializeField] private Transform m_beamAnchor;

        [Header("Tuning")]
        [Tooltip("Night switches the beam on and daylight switches it off. Off = the button is the only control.")]
        [SerializeField] private bool m_autoOnAtNight;

        [Tooltip("On for the corridor torch: the beam stays dark, however the switch is used, " +
                 "until the flag below is raised. Off keeps every other torch working the moment " +
                 "it is switched on.")]
        [SerializeField] private bool m_needsPowerSource;

        [Tooltip("World flag that powers the torch. Only read while the box above is ticked.")]
        [SerializeField] private string m_powerFlag = WorldFlags.k_FlashlightPowered;

        [Tooltip("Seconds for the beam to fade from off to full brightness, and back.")]
        [SerializeField] private float m_fadeSeconds = 0.15f;

        [Tooltip("Metres out along the view ray that a hand-held beam is aimed at. Larger is " +
                 "closer to parallel with the view — and a rounder pool. 0 points the beam " +
                 "straight down the anchor's own forward instead.")]
        [Range(0f, 40f)][SerializeField] private float m_aimDistance = 7f;

        [Header("Listens to")]
        [Tooltip("Time-of-day channel raised by GameBootstrap when the world phase changes.")]
        [SerializeField] private TimeOfDayEventChannelSO m_timeOfDayChanged;

        [Header("Teaching")]
        [Tooltip("Interaction hint channel (Data/Events/InteractionPrompt). While the torch is "
            + "held with its switch off, offers the line below until the player first turns it on.")]
        [SerializeField] private StringEventChannelSO m_promptChanged;

        [Tooltip("The flashlight key's one-time teaching line.")]
        [SerializeField] private string m_switchHint = "[F] 打开手电";

        /// <summary>Metres past which a "hand" anchor cannot be a hand, so the eye is used.</summary>
        private const float k_MaxHandReach = 1.5f;

        /// <summary>
        /// Below every other offer: any contextual line — a pickup, the throw, a swap — outranks
        /// the standing teacher, which is only there while nothing better is being said.
        /// </summary>
        private const int k_SwitchHintPriority = -5;

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

                // By kind, not by identity: any of the torches lying around the level lights the
                // beam, and nothing else does — a hand full of helmet is still a dark corridor.
                CarriedItem carried = m_holdSocket.Carried;

                return carried != null && carried.Kind == CarriedKind.Torch;
            }
        }

        /// <summary>
        /// The player's torch, or null while no player rig is enabled. Props that react to the
        /// carried light — the archive sheets above all — resolve it here at runtime: the torch
        /// lives on the persistent player prefab, so nothing saved in a level scene can hold a
        /// serialized reference to it (guideline 03).
        /// </summary>
        public static FlashlightController Active { get; private set; }

        /// <summary>The Light the torch shines with. Disabled whenever the beam is dark.</summary>
        public Light BeamLight => m_light;

        /// <summary>
        /// The hint channel the torch teaches on. Shared with the sheet-reading hint so the two
        /// lines about light can never talk over each other.
        /// </summary>
        public StringEventChannelSO PromptChannel => m_promptChanged;

        /// <summary>The line taught while <see cref="SwitchHintWanted"/> is true.</summary>
        public string SwitchHint => m_switchHint;

        /// <summary>
        /// True while a torch is in the hand with power and its switch off — the moment the [F]
        /// line has something to teach. A held-up mode that owns the hint line folds this line
        /// into its own while it is true, because its mode priority would otherwise silence the
        /// teacher.
        /// </summary>
        public bool SwitchHintWanted => IsHeld && State.HasPower && !State.IsOn;

        /// <summary>
        /// The switch model, rebuilt in place if a domain reload in Play threw it away: it is not
        /// serialized and Awake does not run again, so the first Update after the reload would
        /// otherwise dereference null sixty times a second and freeze the beam (same shape as the
        /// chase trail's rebuild). The rebuilt state re-seeds from the world on the next Update.
        /// </summary>
        private FlashlightState State
        {
            get
            {
                if (m_state == null)
                {
                    m_state = new FlashlightState(m_autoOnAtNight);
                    m_isSeeded = false;
                }

                return m_state;
            }
        }

        private void Awake()
        {
            // Parent-inclusive, and checked. The reader normally sits on the same object, but a
            // rig that puts the torch on a child leaves this null, and Update dereferences it every
            // frame — one missing reference then throws 60 times a second and takes the rest of
            // Update with it, including the power gate and the fade. The beam is left frozen at
            // whatever the previous frame set, which reads as the gate not working at all.
            m_input = GetComponentInParent<PlayerInputReader>();

            if (m_input == null)
            {
                Log.Error("FlashlightController found no PlayerInputReader on itself or a parent; "
                    + "the switch will not respond.", this);
            }

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
            Active = this;

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

            // Converge on the surface actually being looked at, not on a fixed point out along
            // the ray. The hand is a metre below the eye, so a fixed far convergence leaves the
            // pool that far below the look point on any close surface — at poster distance the
            // bright cone lands at knee height, off the bottom of the view, and an eye-level mark
            // sits outside the cone entirely. The fixed distance remains the aim when nothing is
            // within it.
            Vector3 aim = cameraTransform.position + cameraTransform.forward * m_aimDistance;

            if (m_aimDistance > 0f && Physics.Raycast(cameraTransform.position,
                    cameraTransform.forward, out RaycastHit lookHit, m_aimDistance,
                    Physics.DefaultRaycastLayers, QueryTriggerInteraction.Ignore))
            {
                aim = lookHit.point;
            }

            Vector3 forward = m_aimDistance > 0f ? aim - origin : m_beamAnchor.forward;

            if (forward.sqrMagnitude < 1e-6f)
            {
                forward = cameraTransform.forward;
            }

            m_light.transform.SetPositionAndRotation(origin,
                Quaternion.LookRotation(forward.normalized, cameraTransform.up));
        }

        private void Update()
        {
            // Non-serialized, so a domain reload in Play also resets this to false and the torch
            // would go dark for the rest of the session; re-derived from the one serialized fact.
            m_hasLight = m_light != null;

            if (!m_hasLight)
            {
                return;
            }

            if (m_state == null)
            {
                _ = State;
            }

            if (m_input == null)
            {
                m_input = GetComponentInParent<PlayerInputReader>();
            }

            SeedFromWorldState();
            m_state.SetHeld(IsHeld);
            m_state.SetPower(ReadPower());

            if (m_input != null && m_input.FlashlightPressedThisFrame)
            {
                m_state.Toggle();
            }

            OfferSwitchHint();
            Fade();
        }

        /// <summary>
        /// The one hint this component owns: a torch in the hand whose switch is off says which
        /// key turns it on — every time, for as long as that is true. It hides while the beam is
        /// lit (nothing left to say) and comes back when the switch goes off again; its low
        /// priority means any contextual offer speaks over it.
        /// </summary>
        private void OfferSwitchHint()
        {
            if (m_promptChanged == null)
            {
                return;
            }

            InteractionPrompts.Set(this, m_promptChanged,
                SwitchHintWanted ? m_switchHint : string.Empty, k_SwitchHintPriority);
        }

        private void OnDisable()
        {
            if (Active == this)
            {
                Active = null;
            }

            RenderPipelineManager.beginCameraRendering -= OnBeginCameraRendering;

            if (m_timeOfDayChanged != null)
            {
                m_timeOfDayChanged.EventRaised -= OnTimeOfDayChanged;
            }

            InteractionPrompts.Clear(this, m_promptChanged);
        }

        private void OnTimeOfDayChanged(TimeOfDay phase)
        {
            // The channel carries the same truth the seed would read, so a phase change also counts
            // as seeded — otherwise the seed would undo a toggle made before the bootstrap arrived.
            m_isSeeded = true;
            State.OnPhase(phase);
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
            State.OnPhase(state.TimeOfDay);
        }

        /// <summary>
        /// Whether the torch has a light source in it. A torch that was never meant to run dry is
        /// always powered; the corridor one waits on its flag. Read every frame rather than latched,
        /// so loading a checkpoint on either side of the moment lands in the right state.
        /// </summary>
        private bool ReadPower()
        {
            if (!m_needsPowerSource || string.IsNullOrEmpty(m_powerFlag))
            {
                return true;
            }

            IWorldStateReader state = WorldAccess.State;

            return state != null && state.HasFlag(m_powerFlag);
        }

        private void Fade()
        {
            float target = State.IsLit ? m_fullIntensity : 0f;
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
