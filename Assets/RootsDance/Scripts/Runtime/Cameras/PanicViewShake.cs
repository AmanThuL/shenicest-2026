using RootsDance.Events;
using RootsDance.Player;
using Unity.Cinemachine;
using UnityEngine;

namespace RootsDance.Cameras
{
    /// <summary>
    /// The wrong-cycle chase, done with the camera instead of an AI: the view starts running —
    /// footfall bob, sway, and a panic jitter on top — and can be told to snap round and check what
    /// is behind before turning back.
    /// <para>
    /// Written as a <see cref="CinemachineExtension"/> rather than as a component that moves a
    /// transform, because every transform in the view is already owned: <c>PlayerLook</c> owns the
    /// root's yaw and the head's pitch, <c>CameraBoneViewBob</c> owns the head's position, and this
    /// project's rule is one owner per axis. An extension adds its offset in the camera pipeline's
    /// correction channel after all of them, so nothing fights and nothing has to be rewired — the
    /// camera is a hard lock to the head (<c>CinemachineHardLockToTarget</c> +
    /// <c>CinemachineRotateWithFollowTarget</c>) and stays that way.
    /// </para>
    /// <para>
    /// Everything is evaluated from <see cref="Time.time"/> rather than accumulated per call. The
    /// pipeline callback can run more than once in a frame during a blend, and an accumulating
    /// clock would run the bob at double speed exactly when the camera is already busy.
    /// </para>
    /// </summary>
    [SaveDuringPlay]
    [AddComponentMenu("Cinemachine/Procedural/Extensions/Panic View Shake")]
    public class PanicViewShake : CinemachineExtension
    {
        [Header("Listens to")]
        [Tooltip("The bootstrap's FlagRaised channel, so a CueSequence's Raise Flag step can drive "
            + "this without holding a reference to the camera.")]
        [SerializeField] private StringEventChannelSO m_flagRaised;

        [Tooltip("Flag that starts the panic run.")]
        [SerializeField] private string m_panicOnFlag;

        [Tooltip("Flag that ends it.")]
        [SerializeField] private string m_calmOnFlag;

        [Tooltip("Flag that fires one shoulder check.")]
        [SerializeField] private string m_lookBackOnFlag;

        // ---- Locomotion ------------------------------------------------------------------------
        [Header("Locomotion")]
        [Tooltip("The player, so the run cycle only plays while the player is actually running. "
            + "Left empty this is resolved once from the loaded scenes.")]
        [SerializeField] private FirstPersonController m_controller;

        [Tooltip("Horizontal speed at which the run cycle plays at full strength, in m/s. Match "
            + "the sprint speed in PlayerConfig — panicked running is sprinting.")]
        [Min(0.1f)]
        [SerializeField] private float m_fullStrideSpeed = 4.4f;

        [Tooltip("Horizontal speed at which the run cycle starts coming in, in m/s. Match the walk "
            + "speed in PlayerConfig: walking is not running, so a walking player gets no bob at "
            + "all and the layer belongs entirely to the sprint.")]
        [Min(0f)]
        [SerializeField] private float m_runOnsetSpeed = 2.6f;

        // ---- Run --------------------------------------------------------------------------------
        [Header("Run")]
        [Tooltip("Footfalls per second. A frightened run down a corridor is around 2.6-3.2; the "
            + "vertical bob is at this rate and the sway at half it, because the body leans onto "
            + "alternate feet — one sway per stride, one bob per step.")]
        [Range(1.5f, 4.5f)]
        [SerializeField] private float m_stepsPerSecond = 2.9f;

        [Tooltip("Vertical travel, in metres either side of centre. A real head moves 5-9 cm "
            + "peak-to-peak at a run; taking about a third of that is the difference between "
            + "'running' and 'nauseating', because the player's own head is not moving with it.")]
        [Range(0f, 0.08f)]
        [SerializeField] private float m_verticalMeters = 0.025f;

        [Tooltip("Side-to-side travel, in metres either side of centre.")]
        [Range(0f, 0.06f)]
        [SerializeField] private float m_lateralMeters = 0.018f;

        [Tooltip("Roll either side of level, in degrees. Roll is the single biggest cause of "
            + "simulator sickness in first person — keep it under about 3.")]
        [Range(0f, 4f)]
        [SerializeField] private float m_rollDegrees = 1.8f;

        [Tooltip("Pitch nod either side of level, in degrees.")]
        [Range(0f, 3f)]
        [SerializeField] private float m_pitchDegrees = 1f;

        [Header("Panic on top of the run")]
        [Tooltip("Irregular wobble, in degrees. This is the part that reads as fear rather than "
            + "exercise: the run cycle alone is too regular to be frightening.")]
        [Range(0f, 3f)]
        [SerializeField] private float m_jitterDegrees = 0.9f;

        [Tooltip("How fast the jitter wanders, in Hz. Well above the step rate, so it does not "
            + "beat against the bob.")]
        [Range(1f, 15f)]
        [SerializeField] private float m_jitterHz = 7f;

        [Header("Envelope")]
        [Tooltip("Seconds to reach full intensity. Panic arrives fast.")]
        [SerializeField] private float m_riseSeconds = 0.35f;

        [Tooltip("Seconds to fall back to nothing. Longer than the rise: it leaves slowly.")]
        [SerializeField] private float m_fallSeconds = 1.2f;

        // ---- Shoulder check ---------------------------------------------------------------------
        [Header("Shoulder check")]
        [Tooltip("How far round the view turns. 180 loses every forward reference and reads as a "
            + "cut; under about 120 does not read as looking behind at all.")]
        [Range(90f, 180f)]
        [SerializeField] private float m_lookBackDegrees = 150f;

        [Tooltip("Over the left shoulder when on. Which side barely matters, but it must be the "
            + "same side every time or the two checks read as two different events.")]
        [SerializeField] private bool m_overLeftShoulder = true;

        [Tooltip("Seconds to turn out. At 150 degrees this peaks near 600 deg/s, which is about as "
            + "fast as a person actually turns their head when something is behind them.")]
        [Range(0.15f, 1.2f)]
        [SerializeField] private float m_turnOutSeconds = 0.5f;

        [Tooltip("Seconds held at the far end. THIS is the parameter that decides whether the "
            + "player sees anything. Recognising that something is there takes about 100 ms, but "
            + "finding it and judging how close it is takes 300-500. Shortening this is what makes "
            + "a look back useless — not the speed of the turn.")]
        [Range(0.1f, 1.5f)]
        [SerializeField] private float m_holdSeconds = 0.45f;

        [Tooltip("Seconds to turn back.")]
        [Range(0.15f, 1.2f)]
        [SerializeField] private float m_returnSeconds = 0.4f;

        [Tooltip("The run shake is scaled by this while looking back. A person steadies their head "
            + "to look at something, and an unsteadied image at this angular speed is unreadable.")]
        [Range(0f, 1f)]
        [SerializeField] private float m_shakeWhileLookingBack = 0.45f;

        private bool m_isLookingBack;
        private float m_lookBackStartTime;
        private float m_intensity;
        private float m_intensityTarget;
        private float m_lastEvaluationTime;
        private float m_seed;
        private bool m_controllerSearched;

        /// <summary>0..1 — how far into the panic the view currently is. Read by tests and tools.</summary>
        public float Intensity => m_intensity;

        /// <summary>True while a shoulder check is playing; a second request is ignored.</summary>
        public bool IsLookingBack => m_isLookingBack;

        /// <summary>
        /// How long the current settings leave the view turned far enough to read, in seconds.
        /// Under about 0.3 the check shows the player nothing — see <see cref="ShoulderCheckCurve"/>.
        /// </summary>
        public float ReadableSeconds => ShoulderCheckCurve.ReadableSeconds(
            m_turnOutSeconds, m_holdSeconds, m_returnSeconds);

        protected override void Awake()
        {
            base.Awake();

            // Per-instance, so two cameras in one scene do not wobble in step.
            m_seed = Random.value * 100f;
            m_lastEvaluationTime = Time.time;
        }

        protected override void OnEnable()
        {
            base.OnEnable();
            EnsureController();

            if (m_flagRaised != null)
            {
                m_flagRaised.EventRaised += OnFlagRaised;
            }
        }

        private void OnDisable()
        {
            if (m_flagRaised != null)
            {
                m_flagRaised.EventRaised -= OnFlagRaised;
            }
        }

        /// <summary>Starts or ends the panic run. The change is eased, not instant.</summary>
        public void SetPanic(bool isPanicking)
        {
            if (isPanicking)
            {
                // The player can load after this camera does, so try once more on the way in.
                EnsureController();
            }

            m_intensityTarget = isPanicking ? 1f : 0f;
        }

        /// <summary>
        /// Finds the player once when the reference was left unwired. Searched at most once: a
        /// miss must not turn into a per-frame scene scan.
        /// </summary>
        private void EnsureController()
        {
            if (m_controller != null || m_controllerSearched)
            {
                return;
            }

            m_controllerSearched = true;
            m_controller = FindFirstObjectByType<FirstPersonController>();
        }

        /// <summary>Fires one shoulder check. Ignored while one is already playing.</summary>
        public void LookBack()
        {
            if (m_isLookingBack)
            {
                return;
            }

            m_isLookingBack = true;
            m_lookBackStartTime = Time.time;
        }

        private void OnFlagRaised(string flagId)
        {
            if (!string.IsNullOrEmpty(m_panicOnFlag) && flagId == m_panicOnFlag)
            {
                SetPanic(true);
            }

            if (!string.IsNullOrEmpty(m_calmOnFlag) && flagId == m_calmOnFlag)
            {
                SetPanic(false);
            }

            if (!string.IsNullOrEmpty(m_lookBackOnFlag) && flagId == m_lookBackOnFlag)
            {
                LookBack();
            }
        }

        protected override void PostPipelineStageCallback(CinemachineVirtualCameraBase vcam,
            CinemachineCore.Stage stage, ref CameraState state, float deltaTime)
        {
            // Finalize: after body and aim have placed the camera on the head, so this is a pure
            // offset from wherever the player is actually looking.
            if (stage != CinemachineCore.Stage.Finalize || deltaTime < 0f)
            {
                return;
            }

            float now = Time.time;
            AdvanceEnvelope(now);
            float lookBackYaw = AdvanceLookBack(now);

            float shake = m_intensity * (m_isLookingBack ? m_shakeWhileLookingBack : 1f);

            // Every part of this layer is something a running body does, so all of it is gated on
            // the player actually running. Panic alone used to be enough, which meant that once the
            // chase started the view kept bobbing at 2.9 footfalls a second everywhere the player
            // went, standing still included, for the rest of the session — the panic only stands
            // down on the escape. A stopped player gets a still camera.
            float stride = m_controller != null
                ? PanicRunGate.StrideFactor(m_controller.HorizontalSpeed, m_fullStrideSpeed, m_runOnsetSpeed)
                : 1f;
            float run = shake * stride;

            // The shoulder check still turns the view while standing: it is a head turn, not a step.
            if (run <= 0.0001f && Mathf.Abs(lookBackYaw) <= 0.0001f)
            {
                return;
            }

            float stepPhase = now * m_stepsPerSecond * 2f * Mathf.PI;

            // Half the step rate: the body sways onto one foot, then the other — one sway per
            // stride, two footfalls per stride.
            float stridePhase = stepPhase * 0.5f;

            Vector3 offset = new Vector3(
                Mathf.Sin(stridePhase) * m_lateralMeters,
                Mathf.Sin(stepPhase) * m_verticalMeters,
                0f) * run;

            // A quarter turn out of phase with the bob, so the nod happens between footfalls
            // instead of on them, which is what stops the two reading as one motion.
            float pitch = Mathf.Sin(stepPhase + Mathf.PI * 0.5f) * m_pitchDegrees;
            float roll = Mathf.Sin(stridePhase) * m_rollDegrees;

            float jitterTime = now * m_jitterHz;
            float jitterYaw = (Mathf.PerlinNoise(jitterTime, m_seed) - 0.5f) * 2f * m_jitterDegrees;
            float jitterPitch = (Mathf.PerlinNoise(m_seed, jitterTime) - 0.5f) * 2f * m_jitterDegrees;

            Quaternion rotation = Quaternion.Euler(
                (pitch + jitterPitch) * run,
                jitterYaw * run + lookBackYaw,
                roll * run);

            state.PositionCorrection += state.RawOrientation * offset;
            state.OrientationCorrection = state.OrientationCorrection * rotation;
        }

        private void AdvanceEnvelope(float now)
        {
            float elapsed = Mathf.Max(0f, now - m_lastEvaluationTime);
            m_lastEvaluationTime = now;

            float duration = m_intensityTarget > m_intensity ? m_riseSeconds : m_fallSeconds;
            float step = duration <= 0f ? 1f : elapsed / duration;

            m_intensity = Mathf.MoveTowards(m_intensity, m_intensityTarget, step);
        }

        /// <summary>The shoulder check's yaw offset in degrees; also retires it when it ends.</summary>
        private float AdvanceLookBack(float now)
        {
            if (!m_isLookingBack)
            {
                return 0f;
            }

            float elapsed = now - m_lookBackStartTime;

            if (elapsed >= ShoulderCheckCurve.TotalSeconds(m_turnOutSeconds, m_holdSeconds, m_returnSeconds))
            {
                m_isLookingBack = false;
                return 0f;
            }

            float deflection = ShoulderCheckCurve.Evaluate(elapsed, m_turnOutSeconds, m_holdSeconds,
                m_returnSeconds);

            return deflection * m_lookBackDegrees * (m_overLeftShoulder ? -1f : 1f);
        }
    }
}
