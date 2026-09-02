using UnityEngine;

namespace RootsDance.Environment
{
    /// <summary>
    /// Walks a growth shader's <c>_Growth</c> scalar from 0 to 1 — the statue going from bare
    /// stone to fully flowered.
    /// <para>
    /// This is a component rather than a <see cref="RootsDance.Sequencing.CueStepKind"/> because a
    /// cue step cannot express a continuous value: the sequence can raise a flag, switch an object
    /// on, ask for audio or a line, and nothing else. So the sequence switches this on with
    /// <c>SetActive</c> and it owns the curve from there. Extending CueStepKind for one tween would
    /// put a tween engine inside the narrative data.
    /// </para>
    /// <para>
    /// The progress arithmetic is <see cref="Progress"/>, a pure static, so the resume and clamp
    /// behaviour can be tested without a Renderer, a material or a frame.
    /// </para>
    /// <para>
    /// Writes to <c>renderer.material</c>, which instantiates the material, rather than to a
    /// MaterialPropertyBlock — the same call <see cref="EmissivePulse"/> makes and for the same
    /// reason: with one shader and one UnityPerMaterial layout the SRP Batcher still batches
    /// material instances, while an MPB breaks the batch outright.
    /// </para>
    /// <para>
    /// Several renderers, one clock. The statue grows two meshes — the cover wrapped on the robe
    /// and the field of flowers standing out of it — and they have to advance on exactly the same
    /// value. Two drivers with matching settings would agree on the first frame and drift by a
    /// frame of <c>deltaTime</c> forever after, which shows up as flowers opening on stone the
    /// cover has not reached.
    /// </para>
    /// </summary>
    public class GrowthDriver : MonoBehaviour
    {
        [Tooltip("What grows. Empty uses the Renderer on this object.")]
        [SerializeField] private Renderer[] m_renderers = System.Array.Empty<Renderer>();

        [Tooltip("The shader's growth scalar. Named here so another growth shader can be driven.")]
        [SerializeField] private string m_growthProperty = "_Growth";

        [Header("Timing")]
        [Tooltip("Seconds from bare stone to fully grown.")]
        [SerializeField] private float m_duration = 45f;

        [Tooltip("How the front paces itself. X is normalised time, Y is growth.")]
        [SerializeField] private AnimationCurve m_shape = AnimationCurve.EaseInOut(0f, 0f, 1f, 1f);

        [Tooltip("Where to start. A checkpoint that resumes mid-bloom sets this before enabling.")]
        [Range(0f, 1f)]
        [SerializeField] private float m_startAt;

        [Tooltip("Run as soon as this is switched on. Off leaves the growth parked at Start at.")]
        [SerializeField] private bool m_playOnEnable = true;

        [Tooltip("Switched off entirely until growth actually begins, instead of sitting visible in "
            + "its bare/bud pose. The flower field on the statue: there is nothing there before the "
            + "story starts it, not an unopened bud.")]
        [SerializeField] private Renderer[] m_hiddenUntilStarted = System.Array.Empty<Renderer>();

        private Material[] m_materials = System.Array.Empty<Material>();
        private int m_growthId;
        private float m_elapsed;
        private bool m_running;

        /// <summary>Where the bloom currently is, 0 bare and 1 complete.</summary>
        public float Growth { get; private set; }

        /// <summary>True while the front is still advancing.</summary>
        public bool IsRunning => m_running;

        /// <summary>
        /// Growth after <paramref name="elapsed"/> seconds, starting from <paramref name="startAt"/>.
        /// <para>
        /// The start offset is applied to the *output*, not to the clock: resuming at 0.5 means the
        /// statue is already half grown and the remaining time covers the rest, rather than the
        /// curve being sampled from its midpoint and finishing early.
        /// </para>
        /// </summary>
        public static float Progress(AnimationCurve shape, float elapsed, float duration, float startAt)
        {
            float from = Mathf.Clamp01(startAt);

            // A zero or negative duration means "already done" rather than a division by zero. It
            // is what a designer means by leaving the field at 0, and what a skipped cutscene wants.
            if (duration <= 0f)
            {
                return 1f;
            }

            float t = Mathf.Clamp01(elapsed / duration);
            float shaped = shape == null ? t : Mathf.Clamp01(shape.Evaluate(t));

            return Mathf.Clamp01(from + (1f - from) * shaped);
        }

        private void Awake()
        {
            if (m_renderers == null || m_renderers.Length == 0)
            {
                Renderer own = GetComponent<Renderer>();
                m_renderers = own == null ? System.Array.Empty<Renderer>() : new[] { own };
            }

            m_growthId = Shader.PropertyToID(m_growthProperty);

            m_materials = new Material[m_renderers.Length];

            for (int i = 0; i < m_renderers.Length; i++)
            {
                m_materials[i] = m_renderers[i] == null ? null : m_renderers[i].material;
            }
        }

        private void OnEnable()
        {
            m_elapsed = 0f;
            m_running = m_playOnEnable;

            // Write the starting value immediately. Without this the statue shows one frame of
            // whatever the material was authored with, which is fully grown.
            Apply(Progress(m_shape, 0f, m_duration, m_startAt));
        }

        private void OnDestroy()
        {
            // renderer.material instantiated each of these, so this object owns them and has to
            // clean them up.
            for (int i = 0; i < m_materials.Length; i++)
            {
                if (m_materials[i] != null)
                {
                    Destroy(m_materials[i]);
                }
            }
        }

        /// <summary>Start advancing from wherever the growth currently is.</summary>
        public void Play()
        {
            m_startAt = Growth;
            m_elapsed = 0f;
            m_running = true;
        }

        /// <summary>Stop advancing and hold. The material keeps the value it reached.</summary>
        public void Pause()
        {
            m_running = false;
        }

        /// <summary>Jump straight to <paramref name="growth"/> and hold there.</summary>
        public void SetGrowth(float growth)
        {
            m_running = false;
            m_startAt = Mathf.Clamp01(growth);
            m_elapsed = 0f;
            Apply(m_startAt);
        }

        private void Update()
        {
            if (!m_running)
            {
                return;
            }

            m_elapsed += Time.deltaTime;
            Apply(Progress(m_shape, m_elapsed, m_duration, m_startAt));

            if (m_elapsed >= m_duration)
            {
                m_running = false;
            }
        }

        private void Apply(float growth)
        {
            Growth = growth;

            for (int i = 0; i < m_materials.Length; i++)
            {
                if (m_materials[i] != null)
                {
                    m_materials[i].SetFloat(m_growthId, growth);
                }
            }

            // Nothing stands on the statue before the bloom begins — not even a bud. A driver that
            // is running counts as begun so the field appears on the bloom's first frame.
            bool started = m_running || growth > 0f;

            for (int i = 0; i < m_hiddenUntilStarted.Length; i++)
            {
                if (m_hiddenUntilStarted[i] != null && m_hiddenUntilStarted[i].enabled != started)
                {
                    m_hiddenUntilStarted[i].enabled = started;
                }
            }
        }
    }
}
