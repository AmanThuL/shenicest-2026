using UnityEngine;

namespace RootsDance.Environment
{
    /// <summary>
    /// Fills a standing pool and spills it once the pool is full — the statue's fall landing on the
    /// stone, the stone holding what it can, and the rest running off into the soil.
    /// <para>
    /// A component rather than a <see cref="RootsDance.Sequencing.CueStepKind"/> for the reason
    /// <see cref="GrowthDriver"/> gives: a cue step can switch an object on and nothing else, and a
    /// filling pool is a continuous value. The sequence switches this on with <c>SetActive</c> and
    /// it owns the level from there.
    /// </para>
    /// <para>
    /// The pool is a flat surface that rises and widens, not a simulation, for the reason
    /// <see cref="WaterFlow"/> gives about the whole project's water. Rising alone reads as a slab
    /// growing out of the rock; widening alone reads as a stain spreading. Together they read as a
    /// hollow filling, which is the only thing the shot has to say.
    /// </para>
    /// <para>
    /// Spilling is a threshold rather than a second timer. The overflow is not an event that
    /// happens after the fill, it is what being full looks like, so it hangs off the level and
    /// comes back on its own when a checkpoint restores a level that was already past the lip.
    /// </para>
    /// </summary>
    public class RockPoolOverflow : MonoBehaviour
    {
        [Tooltip("The flat water surface that rises and widens. Empty uses this object.")]
        [SerializeField] private Transform m_surface;

        [Tooltip("Hidden until there is water. An empty hollow has nothing in it, not a film.")]
        [SerializeField] private Renderer m_surfaceRenderer;

        [Header("Level")]
        [Tooltip("The surface's local height when the pool is empty.")]
        [SerializeField] private float m_emptyHeight;

        [Tooltip("The surface's local height when the pool is full — the lip it spills over.")]
        [SerializeField] private float m_fullHeight = 0.04f;

        [Tooltip("The surface's local width when the pool is empty: the first splash, not a puddle.")]
        [SerializeField] private float m_emptyWidth = 0.08f;

        [Tooltip("The surface's local width when the pool is full, across the hollow.")]
        [SerializeField] private float m_fullWidth = 0.44f;

        [Header("Timing")]
        [Tooltip("Seconds from the first splash to the pool going over its lip.")]
        [SerializeField] private float m_fillSeconds = 14f;

        [Tooltip("How the fill paces itself. X is normalised time, Y is level. A hollow that is "
            + "wider at the top fills fast and then slows, which is what the default says.")]
        [SerializeField] private AnimationCurve m_shape = AnimationCurve.EaseInOut(0f, 0f, 1f, 1f);

        [Tooltip("Where to start. A checkpoint that resumes with the pool part full sets this "
            + "before enabling.")]
        [Range(0f, 1f)]
        [SerializeField] private float m_startAt;

        [Tooltip("Fill as soon as this is switched on. Off leaves the pool parked at Start at.")]
        [SerializeField] private bool m_playOnEnable = true;

        [Header("Overflow")]
        [Tooltip("The level the pool spills at. Below 1 the run-off starts before the surface has "
            + "finished rising, which is what a hollow with one low side does.")]
        [Range(0f, 1f)]
        [SerializeField] private float m_spillsAt = 0.92f;

        [Tooltip("The run-off. Switched on while the pool is at or past Spills at, off below it.")]
        [SerializeField] private GameObject[] m_spillways = System.Array.Empty<GameObject>();

        private float m_elapsed;
        private bool m_running;

        /// <summary>How full the pool is, 0 dry and 1 at the lip.</summary>
        public float FillLevel { get; private set; }

        /// <summary>True while the pool is still filling.</summary>
        public bool IsFilling => m_running;

        /// <summary>True while the pool is over its lip and the run-off is going.</summary>
        public bool IsSpilling => FillLevel >= m_spillsAt;

        private void Awake()
        {
            if (m_surface == null)
            {
                m_surface = transform;
            }

            if (m_surfaceRenderer == null)
            {
                m_surfaceRenderer = m_surface.GetComponent<Renderer>();
            }
        }

        private void OnEnable()
        {
            m_elapsed = 0f;
            m_running = m_playOnEnable;

            // Write the starting level immediately, or the pool shows one frame of whatever width
            // and height it was authored at, which is full.
            Apply(GrowthDriver.Progress(m_shape, 0f, m_fillSeconds, m_startAt));
        }

        /// <summary>Start filling from wherever the pool currently is.</summary>
        public void Play()
        {
            m_startAt = FillLevel;
            m_elapsed = 0f;
            m_running = true;
        }

        /// <summary>Stop filling and hold. The pool keeps the level it reached.</summary>
        public void Pause()
        {
            m_running = false;
        }

        /// <summary>Jump straight to <paramref name="level"/> and hold there.</summary>
        public void SetFillLevel(float level)
        {
            m_running = false;
            m_startAt = Mathf.Clamp01(level);
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

            // Shared with the bloom rather than written twice: the resume-from-a-checkpoint
            // arithmetic is the awkward part, and one of it is easier to trust than two.
            Apply(GrowthDriver.Progress(m_shape, m_elapsed, m_fillSeconds, m_startAt));

            if (m_elapsed >= m_fillSeconds)
            {
                m_running = false;
            }
        }

        private void Apply(float level)
        {
            FillLevel = level;

            if (m_surface != null)
            {
                float width = Mathf.Lerp(m_emptyWidth, m_fullWidth, level);
                Vector3 scale = m_surface.localScale;
                m_surface.localScale = new Vector3(width, scale.y, width);

                Vector3 position = m_surface.localPosition;
                m_surface.localPosition = new Vector3(
                    position.x,
                    Mathf.Lerp(m_emptyHeight, m_fullHeight, level),
                    position.z);
            }

            // A pool that has not started is dry rock, not a sheet of water at zero width.
            bool wet = m_running || level > 0f;

            if (m_surfaceRenderer != null && m_surfaceRenderer.enabled != wet)
            {
                m_surfaceRenderer.enabled = wet;
            }

            bool spilling = level >= m_spillsAt;

            for (int i = 0; i < m_spillways.Length; i++)
            {
                if (m_spillways[i] != null && m_spillways[i].activeSelf != spilling)
                {
                    m_spillways[i].SetActive(spilling);
                }
            }
        }
    }
}
