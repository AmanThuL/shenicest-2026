using RootsDance.Player;
using Unity.Cinemachine;
using UnityEngine;

namespace RootsDance.Cameras
{
    /// <summary>
    /// The camera's half of a fall — the greenhouse jump off the stair top, or any other drop. It
    /// watches the <see cref="FirstPersonController"/>'s vertical velocity, so nothing has to be
    /// scripted: leave the ground fast enough and the view plays weightlessness (a brief upward
    /// float and a pitch toward where the body is going), a wind that grows with fall speed
    /// (jitter, slow roll, a touch of FOV), and on touchdown a dip whose depth follows the impact
    /// speed. Curve shapes live in <see cref="FreeFallResponse"/>, EditMode-tested. It also
    /// carries the tremor that precedes a fall — the floor going — as an input
    /// (<see cref="SetTremor"/>) for whatever is shaking it, because the camera has one owner
    /// per axis and this extension already owns the fall's.
    /// <para>
    /// Same contract as <see cref="PanicViewShake"/>: a <see cref="CinemachineExtension"/> adding
    /// offsets in the pipeline's Finalize stage, because every transform already has an owner.
    /// Everything is evaluated from <see cref="Time.time"/>; state transitions are guarded so a
    /// blend calling the pipeline twice a frame cannot double-land a landing.
    /// </para>
    /// </summary>
    [SaveDuringPlay]
    [AddComponentMenu("Cinemachine/Procedural/Extensions/Free Fall View")]
    public class FreeFallView : CinemachineExtension
    {
        [Header("Watches")]
        [Tooltip("The player whose vertical velocity decides everything here. Found in the scene "
            + "at enable when left empty.")]
        [SerializeField] private FirstPersonController m_controller;

        [Header("Fall detection")]
        [Tooltip("Downward speed, in m/s, at which being airborne starts to count as falling. "
            + "Below it, stairs and kerbs stay silent.")]
        [Min(0.5f)]
        [SerializeField] private float m_fallSpeedThreshold = 2.5f;

        [Tooltip("Seconds airborne before the fall response starts. Filters the one-frame air "
            + "moments a CharacterController has on every step edge.")]
        [Range(0f, 0.5f)]
        [SerializeField] private float m_minAirSeconds = 0.12f;

        [Header("Weightlessness")]
        [Tooltip("How far the view floats up as the ground goes away, in metres. The body drops "
            + "out from under the head for a beat — this is the stomach lift.")]
        [Range(0f, 0.15f)]
        [SerializeField] private float m_liftMeters = 0.055f;

        [Tooltip("Seconds for the lift to reach full height.")]
        [Range(0.05f, 0.6f)]
        [SerializeField] private float m_liftRiseSeconds = 0.22f;

        [Tooltip("Seconds for the lift to fade once the fall is established.")]
        [Range(0.1f, 1.5f)]
        [SerializeField] private float m_liftDecaySeconds = 0.6f;

        [Tooltip("Degrees of pitch toward the drop at full fall. People look where they are "
            + "going to land.")]
        [Range(0f, 10f)]
        [SerializeField] private float m_pitchDownDegrees = 4f;

        [Header("Wind")]
        [Tooltip("Fall speed, in m/s, at which the wind response is at full strength. Keep at or "
            + "under the player's terminal velocity or the top of the response is unreachable.")]
        [Min(3f)]
        [SerializeField] private float m_fullWindFallSpeed = 10f;

        [Tooltip("Irregular buffet at full wind, in degrees. Perlin, like the panic jitter.")]
        [Range(0f, 3f)]
        [SerializeField] private float m_windDegrees = 1.1f;

        [Tooltip("How fast the buffet wanders, in Hz.")]
        [Range(2f, 15f)]
        [SerializeField] private float m_windHz = 9f;

        [Tooltip("Slow roll sway at full wind, in degrees — the body is no longer held level by "
            + "its feet.")]
        [Range(0f, 4f)]
        [SerializeField] private float m_rollDegrees = 1.6f;

        [Tooltip("Roll sway rate, in Hz. Well under the buffet so the two read separately.")]
        [Range(0.2f, 2f)]
        [SerializeField] private float m_rollHz = 0.7f;

        [Tooltip("Degrees of FOV added at full wind. Speed reads as widened vision; keep it "
            + "subtle or the lens change itself becomes visible.")]
        [Range(0f, 12f)]
        [SerializeField] private float m_fovBoostDegrees = 5f;

        [Tooltip("Seconds for the wind response to ease in and out, so touchdown does not snap "
            + "the lens back.")]
        [Range(0.05f, 0.8f)]
        [SerializeField] private float m_windSmoothSeconds = 0.25f;

        [Header("Tremor")]
        [Tooltip("Rotational jitter at full tremor, degrees. Driven by whatever is shaking the floor "
            + "(the deck collapse) through SetTremor; sits at zero otherwise. Past the panic jitter "
            + "(0.9°): a structure about to go has to be unmistakable, not felt.")]
        [Min(0f)]
        [SerializeField] private float m_tremorDegrees = 2.6f;

        [Tooltip("Vertical jitter at full tremor, metres.")]
        [Min(0f)]
        [SerializeField] private float m_tremorMeters = 0.07f;

        [Tooltip("Tremor noise rate, Hz. Higher than the wind: a structure buzzes before it goes.")]
        [Min(0.1f)]
        [SerializeField] private float m_tremorHz = 13f;

        [Tooltip("Seconds for the tremor to follow a new level. Long enough that a stage change "
            + "swells rather than steps.")]
        [Min(0f)]
        [SerializeField] private float m_tremorSmoothSeconds = 0.5f;

        [Tooltip("Slow roll under the jitter at full tremor, degrees: the whole structure swaying, "
            + "not just the floor buzzing.")]
        [Min(0f)]
        [SerializeField] private float m_swayDegrees = 1.6f;

        [Tooltip("Sway rate, Hz.")]
        [Min(0.05f)]
        [SerializeField] private float m_swayHz = 0.8f;

        [Tooltip("Longest a debris kick lasts, seconds. The dip and pitch of a landing, scaled by "
            + "how hard and how near the hit was.")]
        [Min(0.05f)]
        [SerializeField] private float m_kickSeconds = 0.35f;

        [Header("Landing")]
        [Tooltip("How deep the view dips on a full-strength landing, in metres.")]
        [Range(0f, 0.3f)]
        [SerializeField] private float m_landDipMeters = 0.13f;

        [Tooltip("Degrees of forward pitch at the bottom of a full-strength landing.")]
        [Range(0f, 12f)]
        [SerializeField] private float m_landPitchDegrees = 5f;

        [Tooltip("Seconds from touchdown to standing steady again.")]
        [Range(0.1f, 1.2f)]
        [SerializeField] private float m_landSeconds = 0.5f;

        [Tooltip("Impact speed, in m/s, below which a landing costs nothing.")]
        [Min(0f)]
        [SerializeField] private float m_minImpactSpeed = 4f;

        [Tooltip("Impact speed, in m/s, at which the landing dip is at full depth.")]
        [Min(1f)]
        [SerializeField] private float m_maxImpactSpeed = 11f;

        private bool m_isAirborne;
        private float m_airStartTime;
        private float m_peakFallSpeed;
        private float m_landingTime = float.NegativeInfinity;
        private float m_landingStrength;
        private float m_windSmoothed;
        private float m_lastStateTime = float.NegativeInfinity;
        private float m_seed;

        private float m_tremorTarget;
        private float m_tremorSmoothed;
        private float m_kickTime = float.NegativeInfinity;
        private float m_kickStrength;

        /// <summary>0..1 — how hard the fall currently reads. Read by tests and tools.</summary>
        public float WindStrength => m_windSmoothed;

        /// <summary>0..1 — the smoothed tremor level currently applied.</summary>
        public float Tremor => m_tremorSmoothed;

        /// <summary>
        /// Sets how hard the floor is shaking, 0..1. The view eases toward it over
        /// <see cref="m_tremorSmoothSeconds"/>; call again with 0 when the shaking is over.
        /// </summary>
        public void SetTremor(float amount01)
        {
            m_tremorTarget = Mathf.Clamp01(amount01);
        }

        /// <summary>
        /// Something heavy just hit the ground near the player: a short dip and nod, the landing's
        /// own shape at <paramref name="strength01"/> of its depth. A harder kick replaces a softer
        /// one still playing; a softer one waits its turn.
        /// </summary>
        public void Kick(float strength01)
        {
            strength01 = Mathf.Clamp01(strength01);
            float now = Time.time;
            bool playing = now - m_kickTime < m_kickSeconds;

            if (playing && strength01 <= m_kickStrength)
            {
                return;
            }

            m_kickTime = now;
            m_kickStrength = strength01;
        }

        protected override void Awake()
        {
            base.Awake();
            m_seed = Random.value * 100f;
        }

        protected override void OnEnable()
        {
            base.OnEnable();

            // Initialisation-time lookup, permitted by the project rules; the builder normally
            // wires the reference so this is only the safety net.
            if (m_controller == null)
            {
                m_controller = FindFirstObjectByType<FirstPersonController>();
            }
        }

        protected override void PostPipelineStageCallback(CinemachineVirtualCameraBase vcam,
            CinemachineCore.Stage stage, ref CameraState state, float deltaTime)
        {
            if (stage != CinemachineCore.Stage.Finalize || deltaTime < 0f || m_controller == null)
            {
                return;
            }

            float now = Time.time;

            if (now > m_lastStateTime)
            {
                AdvanceState(now, now - Mathf.Max(m_lastStateTime, now - 0.1f));
                m_lastStateTime = now;
            }

            float lift = 0f;
            float pitch = 0f;
            float roll = 0f;
            float yaw = 0f;

            if (m_isAirborne)
            {
                float established = now - m_airStartTime - m_minAirSeconds;
                lift = FreeFallResponse.Lift01(established, m_liftRiseSeconds, m_liftDecaySeconds)
                    * m_liftMeters;
            }

            if (m_windSmoothed > 0.0001f)
            {
                float windTime = now * m_windHz;
                yaw = (Mathf.PerlinNoise(windTime, m_seed) - 0.5f) * 2f * m_windDegrees * m_windSmoothed;
                pitch += (Mathf.PerlinNoise(m_seed, windTime) - 0.5f) * 2f * m_windDegrees * m_windSmoothed;
                pitch += m_pitchDownDegrees * m_windSmoothed;
                roll = Mathf.Sin(now * m_rollHz * 2f * Mathf.PI) * m_rollDegrees * m_windSmoothed;

                LensSettings lens = state.Lens;
                lens.FieldOfView += m_fovBoostDegrees * m_windSmoothed;
                state.Lens = lens;
            }

            float dip = FreeFallResponse.LandingDip01(now - m_landingTime, m_landSeconds)
                * m_landingStrength;

            float tremorLift = 0f;
            float tremorSide = 0f;

            if (m_tremorSmoothed > 0.0001f)
            {
                // Perlin sits in roughly 0.3..0.7, so the jitter is scaled up to reach its
                // authored degrees rather than a third of them.
                float tremorTime = now * m_tremorHz;
                float gain = 4f * m_tremorDegrees * m_tremorSmoothed;
                yaw += (Mathf.PerlinNoise(tremorTime, m_seed + 7f) - 0.5f) * gain;
                pitch += (Mathf.PerlinNoise(m_seed + 7f, tremorTime) - 0.5f) * gain;
                roll += (Mathf.PerlinNoise(tremorTime, m_seed + 13f) - 0.5f) * gain * 0.6f;
                roll += Mathf.Sin(now * m_swayHz * 2f * Mathf.PI) * m_swayDegrees * m_tremorSmoothed;
                pitch += Mathf.Sin(now * m_swayHz * 2f * Mathf.PI * 0.5f + 1.3f) * m_swayDegrees * 0.5f * m_tremorSmoothed;
                tremorLift = (Mathf.PerlinNoise(m_seed + 13f, tremorTime) - 0.5f) * 4f * m_tremorMeters * m_tremorSmoothed;
                tremorSide = (Mathf.PerlinNoise(m_seed + 19f, tremorTime) - 0.5f) * 2f * m_tremorMeters * m_tremorSmoothed;
            }

            float kick = FreeFallResponse.LandingDip01(now - m_kickTime, m_kickSeconds) * m_kickStrength;

            if (lift <= 0.0001f && dip <= 0.0001f && m_windSmoothed <= 0.0001f && m_tremorSmoothed <= 0.0001f
                && kick <= 0.0001f)
            {
                return;
            }

            pitch += (dip + kick) * m_landPitchDegrees;
            Vector3 offset = new Vector3(tremorSide, lift - (dip + kick) * m_landDipMeters + tremorLift, 0f);

            state.PositionCorrection += state.RawOrientation * offset;
            state.OrientationCorrection = state.OrientationCorrection * Quaternion.Euler(pitch, yaw, roll);
        }

        /// <summary>Grounded/airborne edges and the wind envelope. Runs once per rendered frame.</summary>
        private void AdvanceState(float now, float elapsed)
        {
            bool grounded = m_controller.IsGrounded;
            float fallSpeed = -m_controller.VerticalVelocity;

            if (m_isAirborne)
            {
                m_peakFallSpeed = Mathf.Max(m_peakFallSpeed, fallSpeed);

                if (grounded)
                {
                    m_isAirborne = false;

                    if (m_peakFallSpeed >= m_minImpactSpeed)
                    {
                        m_landingTime = now;
                        m_landingStrength = FreeFallResponse.Impact01(
                            m_peakFallSpeed, m_minImpactSpeed, m_maxImpactSpeed);
                    }
                }
            }
            else if (!grounded && fallSpeed >= m_fallSpeedThreshold)
            {
                m_isAirborne = true;
                m_airStartTime = now;
                m_peakFallSpeed = fallSpeed;
            }

            float windTarget = 0f;

            if (m_isAirborne && now - m_airStartTime >= m_minAirSeconds)
            {
                windTarget = FreeFallResponse.Wind01(fallSpeed, m_fallSpeedThreshold, m_fullWindFallSpeed);
            }

            float step = m_windSmoothSeconds <= 0f ? 1f : elapsed / m_windSmoothSeconds;
            m_windSmoothed = Mathf.MoveTowards(m_windSmoothed, windTarget, step);

            float tremorStep = m_tremorSmoothSeconds <= 0f ? 1f : elapsed / m_tremorSmoothSeconds;
            m_tremorSmoothed = Mathf.MoveTowards(m_tremorSmoothed, m_tremorTarget, tremorStep);
        }
    }
}
