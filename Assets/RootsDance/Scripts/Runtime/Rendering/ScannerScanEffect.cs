using UnityEngine;
using UnityEngine.Rendering.HighDefinition;

namespace RootsDance.Rendering
{
    /// <summary>
    /// Drives the structured-light scan stripes in <c>RootsDance/Props/ScannerLines</c>.
    /// </summary>
    /// <remarks>
    /// The shader runs as the override material of a DrawRenderersCustomPass, so there is nothing
    /// per-object to talk to: every parameter is a shader global, and this component is the only
    /// thing that writes them. One scanner at a time, which is what the game has.
    /// <para>
    /// Scene setup: a <see cref="CustomPassVolume"/> (Global, Injection Point = Before Post Process)
    /// holding a DrawRenderersCustomPass filtered to the Scannable layer, Queue = Opaque, with
    /// Material = ScannerLines and Pass Name = ForwardOnly. Point <see cref="m_volume"/> at it and
    /// the volume is enabled only while a scan is running.
    /// </para>
    /// </remarks>
    public class ScannerScanEffect : MonoBehaviour
    {
        /// <summary>Name of the shader this effect drives; must match the .shader file's Shader block.</summary>
        public const string k_ShaderName = "RootsDance/Props/ScannerLines";

        [Header("Wiring")]
        [Tooltip("Where the beam comes from and which way it points. Falls back to this transform.")]
        [SerializeField] private Transform m_emitter;

        [Tooltip("The custom pass volume that draws the stripes. Enabled only while scanning.")]
        [SerializeField] private CustomPassVolume m_volume;

        [Header("Sweep")]
        [Tooltip("Seconds for one sweep from the emitter out to Max Range.")]
        [SerializeField] private float m_duration = 2.5f;

        [Tooltip("Metres the sweep travels, and the distance at which the stripes have faded out.")]
        [SerializeField] private float m_maxRange = 6f;

        [Tooltip("Head position over the sweep, 0..1 in and out. Linear is a constant-speed sweep.")]
        [SerializeField] private AnimationCurve m_sweep = AnimationCurve.Linear(0f, 0f, 1f, 1f);

        [Tooltip("Seconds to fade the stripes in at the start of a scan and out after it ends.")]
        [SerializeField] private float m_fadeIn = 0.12f;
        [SerializeField] private float m_fadeOut = 0.35f;

        [Header("Stripes")]
        [Tooltip("Metres between stripe centres. Band Width divided by this is the number of stripes.")]
        [SerializeField] private float m_lineSpacing = 0.06f;

        [Tooltip("Stripe thickness as a fraction of half the spacing. Small values read as lasers.")]
        [Range(0.01f, 1f)][SerializeField] private float m_lineWidth = 0.12f;

        [Tooltip("Metres of stripes travelling behind the head. 0.35 at 0.06 spacing is about 6 lines.")]
        [SerializeField] private float m_bandWidth = 0.35f;

        [Tooltip("Metres of smooth residue left behind the band on surfaces already crossed.")]
        [SerializeField] private float m_trailLength = 1.2f;

        [Header("Look")]
        [ColorUsage(false, true)]
        [SerializeField] private Color m_lineColor = new Color(1f, 0.06f, 0.06f, 1f);

        [ColorUsage(false, true)]
        [SerializeField] private Color m_trailColor = new Color(0.35f, 0.02f, 0.02f, 1f);

        [Tooltip("Overall brightness, in exposure-compensated units. Push past 1 to make bloom bite.")]
        [SerializeField] private float m_intensity = 6f;

        [Tooltip("Extra brightness at grazing angles, so silhouettes read against a dark scene.")]
        [Range(0f, 8f)][SerializeField] private float m_edgeBoost = 2f;

        [Tooltip("0 = parallel planes, as if thrown by a projector. 1 = shells around the emitter.")]
        [Range(0f, 1f)][SerializeField] private float m_radial = 0.15f;

        [Tooltip("Half-angle of the emission cone, in degrees.")]
        [Range(5f, 89f)][SerializeField] private float m_coneAngle = 35f;

        [Tooltip("Softness of the cone edge, in degrees.")]
        [Range(0.5f, 40f)][SerializeField] private float m_coneSoftness = 12f;

        [Tooltip("Reject stripes on pixels the opaque pass never wrote. Keeps alpha-cutout foliage " +
                 "from being striped across the holes in its leaf cards. Turn off only to debug.")]
        [SerializeField] private bool m_matchSceneDepth = true;

        private static readonly int k_OriginId = Shader.PropertyToID("_ScanOrigin");
        private static readonly int k_AxisId = Shader.PropertyToID("_ScanAxis");
        private static readonly int k_LineColorId = Shader.PropertyToID("_ScanLineColor");
        private static readonly int k_TrailColorId = Shader.PropertyToID("_ScanTrailColor");
        private static readonly int k_HeadId = Shader.PropertyToID("_ScanHead");
        private static readonly int k_StrengthId = Shader.PropertyToID("_ScanStrength");
        private static readonly int k_BandWidthId = Shader.PropertyToID("_ScanBandWidth");
        private static readonly int k_LineSpacingId = Shader.PropertyToID("_ScanLineSpacing");
        private static readonly int k_LineWidthId = Shader.PropertyToID("_ScanLineWidth");
        private static readonly int k_TrailLengthId = Shader.PropertyToID("_ScanTrailLength");
        private static readonly int k_IntensityId = Shader.PropertyToID("_ScanIntensity");
        private static readonly int k_EdgeBoostId = Shader.PropertyToID("_ScanEdgeBoost");
        private static readonly int k_RadialId = Shader.PropertyToID("_ScanRadial");
        private static readonly int k_ConeCosId = Shader.PropertyToID("_ScanConeCos");
        private static readonly int k_ConeSoftnessId = Shader.PropertyToID("_ScanConeSoftness");
        private static readonly int k_MaxRangeId = Shader.PropertyToID("_ScanMaxRange");
        private static readonly int k_DepthMatchId = Shader.PropertyToID("_ScanDepthMatch");

        private float m_elapsed;
        private float m_strength;
        private bool m_sweeping;

        /// <summary>True while the sweep is running or its trail is still fading out.</summary>
        public bool IsPlaying => m_sweeping || m_strength > 0f;

        /// <summary>Sweep progress, 0 at the emitter and 1 at the end of the sweep.</summary>
        public float Progress => m_duration > 0f ? Mathf.Clamp01(m_elapsed / m_duration) : 1f;

        /// <summary>Seconds one sweep takes. Match the scan animation to this, or set it from there.</summary>
        public float Duration
        {
            get => m_duration;
            set => m_duration = Mathf.Max(0.01f, value);
        }

        private void Awake()
        {
            if (m_emitter == null)
            {
                m_emitter = transform;
            }
        }

        private void OnEnable()
        {
            SetVolumeEnabled(false);
            PushLook();
        }

        private void OnDisable()
        {
            m_sweeping = false;
            m_strength = 0f;
            Shader.SetGlobalFloat(k_StrengthId, 0f);
            SetVolumeEnabled(false);
        }

        /// <summary>
        /// The transform the beam is thrown from. Falls back to this object when none is assigned,
        /// which is why a scene can leave the field empty and still get a sweep.
        /// </summary>
        public Transform Emitter => m_emitter == null ? transform : m_emitter;

        /// <summary>
        /// Points the emitter at a world position and sweeps from there. Only meaningful when the
        /// emitter is a transform this effect owns — aiming the held scanner itself would fight the
        /// hand socket that poses it every late update.
        /// </summary>
        public void PlayToward(Vector3 worldPoint)
        {
            Transform emitter = Emitter;
            Vector3 toTarget = worldPoint - emitter.position;

            if (toTarget.sqrMagnitude > 1e-6f)
            {
                emitter.rotation = Quaternion.LookRotation(toTarget.normalized, Vector3.up);
            }

            Play();
        }

        /// <summary>Starts a sweep from the emitter. Restarts cleanly if one is already running.</summary>
        [ContextMenu("Play Scan")]
        public void Play()
        {
            m_elapsed = 0f;
            m_sweeping = true;
            SetVolumeEnabled(true);
            PushLook();
        }

        /// <summary>Ends the sweep early. The stripes fade out over Fade Out rather than popping.</summary>
        [ContextMenu("Stop Scan")]
        public void Stop()
        {
            m_sweeping = false;
        }

        private void Update()
        {
            if (!IsPlaying)
            {
                return;
            }

            float target = 0f;

            if (m_sweeping)
            {
                m_elapsed += Time.deltaTime;
                target = 1f;

                if (m_elapsed >= m_duration)
                {
                    m_elapsed = m_duration;
                    m_sweeping = false;
                }
            }

            float fade = target > m_strength ? m_fadeIn : m_fadeOut;
            m_strength = fade > 0f
                ? Mathf.MoveTowards(m_strength, target, Time.deltaTime / fade)
                : target;

            PushSweep();

            if (!m_sweeping && m_strength <= 0f)
            {
                SetVolumeEnabled(false);
            }
        }

        private void PushSweep()
        {
            Transform emitter = m_emitter == null ? transform : m_emitter;

            Shader.SetGlobalVector(k_OriginId, emitter.position);
            Shader.SetGlobalVector(k_AxisId, emitter.forward);
            Shader.SetGlobalFloat(k_HeadId, m_sweep.Evaluate(Progress) * m_maxRange);
            Shader.SetGlobalFloat(k_StrengthId, m_strength);
        }

        /// <summary>
        /// Pushes the tunables that do not change during a sweep. Called on enable, at the start of
        /// every scan and from <c>OnValidate</c>, so Inspector edits land live in Play mode.
        /// </summary>
        private void PushLook()
        {
            Shader.SetGlobalVector(k_LineColorId, m_lineColor);
            Shader.SetGlobalVector(k_TrailColorId, m_trailColor);
            Shader.SetGlobalFloat(k_BandWidthId, Mathf.Max(0.001f, m_bandWidth));
            Shader.SetGlobalFloat(k_LineSpacingId, Mathf.Max(0.001f, m_lineSpacing));
            Shader.SetGlobalFloat(k_LineWidthId, m_lineWidth);
            Shader.SetGlobalFloat(k_TrailLengthId, Mathf.Max(0.001f, m_trailLength));
            Shader.SetGlobalFloat(k_IntensityId, m_intensity);
            Shader.SetGlobalFloat(k_EdgeBoostId, m_edgeBoost);
            Shader.SetGlobalFloat(k_RadialId, m_radial);
            Shader.SetGlobalFloat(k_ConeCosId, Mathf.Cos(m_coneAngle * Mathf.Deg2Rad));
            Shader.SetGlobalFloat(k_ConeSoftnessId, Mathf.Max(0.0001f, ConeSoftnessCosineWidth()));
            Shader.SetGlobalFloat(k_MaxRangeId, Mathf.Max(0.01f, m_maxRange));
            Shader.SetGlobalFloat(k_DepthMatchId, m_matchSceneDepth ? 1f : 0f);
        }

        /// <summary>
        /// The shader softens the cone in cosine units, but the Inspector asks for degrees; convert
        /// by measuring how much the cosine moves across that many degrees at the cone's own angle.
        /// </summary>
        private float ConeSoftnessCosineWidth()
        {
            float inner = Mathf.Cos(Mathf.Max(0f, m_coneAngle - m_coneSoftness) * Mathf.Deg2Rad);
            return inner - Mathf.Cos(m_coneAngle * Mathf.Deg2Rad);
        }

        private void SetVolumeEnabled(bool value)
        {
            if (m_volume != null)
            {
                m_volume.enabled = value;
            }
        }

        private void OnValidate()
        {
            m_duration = Mathf.Max(0.01f, m_duration);
            m_maxRange = Mathf.Max(0.01f, m_maxRange);
            m_fadeIn = Mathf.Max(0f, m_fadeIn);
            m_fadeOut = Mathf.Max(0f, m_fadeOut);
            m_lineSpacing = Mathf.Max(0.001f, m_lineSpacing);
            m_bandWidth = Mathf.Max(0.001f, m_bandWidth);
            m_trailLength = Mathf.Max(0.001f, m_trailLength);
            m_intensity = Mathf.Max(0f, m_intensity);

            if (Application.isPlaying)
            {
                PushLook();
            }
        }
    }
}
