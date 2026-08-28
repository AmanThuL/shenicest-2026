using RootsDance.App;
using RootsDance.Core;
using RootsDance.Events;
using UnityEngine;
using UnityEngine.Rendering;

namespace RootsDance.Player
{
    /// <summary>
    /// Drives the first-person flashlight: the world's time of day switches it on, the flashlight
    /// button flips it, and the beam fades in and out instead of popping.
    /// <para>
    /// The Light lives on the Player's <c>Head</c> child at a zero position/rotation offset, which is
    /// the transform the Cinemachine first-person camera hard-locks to. Sitting exactly on the eye
    /// means the cone is centred on the screen and never parallaxes against the view, so the beam
    /// always lights what the player is looking at — the cheapest thing that reads correctly in the
    /// volumetric fog. Arms and a torch model come later; when they do, the Light moves onto the
    /// torch bone and picks up a small offset, and only the prefab wiring changes, not this script.
    /// </para>
    /// </summary>
    [RequireComponent(typeof(PlayerInputReader))]
    public class FlashlightController : MonoBehaviour
    {
        [Header("Wiring")]
        [Tooltip("The Spot light on Head/Flashlight. Its authored intensity is the 'on' brightness.")]
        [SerializeField] private Light m_light;

        [Header("Tuning")]
        [Tooltip("Night switches the beam on and day switches it off. Off = the button is the only control.")]
        [SerializeField] private bool m_autoOnAtNight = true;

        [Tooltip("Seconds for the beam to fade from off to full brightness, and back.")]
        [SerializeField] private float m_fadeSeconds = 0.15f;

        [Header("Listens to")]
        [Tooltip("Time-of-day channel raised by GameBootstrap when the world phase changes.")]
        [SerializeField] private TimeOfDayEventChannelSO m_timeOfDayChanged;

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
            m_light.transform.SetPositionAndRotation(cameraTransform.position, cameraTransform.rotation);
        }

        private void Update()
        {
            if (!m_hasLight)
            {
                return;
            }

            SeedFromWorldState();

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
            float target = m_state.IsOn ? m_fullIntensity : 0f;
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
