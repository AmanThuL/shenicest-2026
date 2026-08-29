using System;
using UnityEngine;

namespace RootsDance.Environment
{
    /// <summary>
    /// Opens standing flowers in step with the growth climbing the statue.
    /// <para>
    /// The wrapped clumps read as cover, not as flowers: they are geometry lying on the robe, and
    /// from the few metres the player actually stands in they look like what they are. These are
    /// the ones with a silhouette — a few dozen real stems at the places a player looks at, opening
    /// as the same front reaches them.
    /// </para>
    /// <para>
    /// Each flower's moment comes from the clump it was planted on, so the standing flowers and the
    /// cover underneath them cannot drift apart: <see cref="StatueBloomBuilder"/> reads the growth
    /// order out of the clump mesh's vertex colour and bakes it in here.
    /// </para>
    /// <para>
    /// Scale, not enable/disable. Toggling a GameObject costs a hierarchy change and pops; scaling
    /// from zero is one transform write and reads as opening.
    /// </para>
    /// </summary>
    public class BloomBurst : MonoBehaviour
    {
        /// <summary>One planted flower: what to scale, when it opens and how big it ends up.</summary>
        [Serializable]
        public struct Flower
        {
            [SerializeField] private Transform m_transform;
            [SerializeField] private float m_order;
            [SerializeField] private float m_scale;

            public Flower(Transform transform, float order, float scale)
            {
                m_transform = transform;
                m_order = order;
                m_scale = scale;
            }

            /// <summary>The stem to scale.</summary>
            public Transform Transform => m_transform;

            /// <summary>Growth value at which this one starts opening, 0..1.</summary>
            public float Order => m_order;

            /// <summary>Its local scale once fully open.</summary>
            public float Scale => m_scale;
        }

        [Tooltip("Where the growth is. Empty uses the GrowthDriver on this object.")]
        [SerializeField] private GrowthDriver m_driver;

        [Tooltip("The planted flowers. Written by StatueBloomBuilder.")]
        [SerializeField] private Flower[] m_flowers = Array.Empty<Flower>();

        [Tooltip("How much growth one flower takes to open. Small: a flower opens far faster " +
                 "than the front crosses the statue.")]
        [Range(0.01f, 0.5f)]
        [SerializeField] private float m_openSpan = 0.08f;

        [Tooltip("Shape of one flower opening. Overshoot past 1 reads as a flower springing open.")]
        [SerializeField] private AnimationCurve m_openCurve =
            new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(0.7f, 1.08f), new Keyframe(1f, 1f));

        private float m_lastGrowth = -1f;

        /// <summary>
        /// How far open a flower is, given where the growth has reached.
        /// <para>
        /// This is the arithmetic StatueBloom.hlsl runs on the cover, deliberately: the (1 + span)
        /// factor is what makes growth 1 finish every flower. Without it a stem whose order is
        /// near the end only ever reaches (1 - order) / span open — a flower at 0.95 stops at
        /// 0.625 and the statue never finishes blooming. Matching the shader also keeps a stem and
        /// the patch it stands in from drifting apart mid-animation.
        /// </para>
        /// <para>
        /// Pure so the ordering can be tested without a scene.
        /// </para>
        /// </summary>
        public static float OpenAmount(float growth, float order, float span)
        {
            if (span <= 0f)
            {
                return growth >= order ? 1f : 0f;
            }

            return Mathf.Clamp01((growth * (1f + span) - order) / span);
        }

        private void Awake()
        {
            if (m_driver == null)
            {
                m_driver = GetComponent<GrowthDriver>();
            }
        }

        private void OnEnable()
        {
            // Force the first write. Otherwise a re-enable at the same growth leaves every flower
            // at whatever scale the prefab was saved with, which is fully open.
            m_lastGrowth = -1f;
            Apply();
        }

        private void Update()
        {
            Apply();
        }

        private void Apply()
        {
            if (m_driver == null || m_flowers == null)
            {
                return;
            }

            float growth = m_driver.Growth;

            // The front only moves while the driver runs, and it stops for long stretches either
            // side. Skipping an unchanged frame keeps this off the profiler entirely once the
            // bloom finishes rather than writing sixty transforms forever.
            if (Mathf.Approximately(growth, m_lastGrowth))
            {
                return;
            }

            m_lastGrowth = growth;

            for (int i = 0; i < m_flowers.Length; i++)
            {
                Transform t = m_flowers[i].Transform;

                if (t == null)
                {
                    continue;
                }

                float open = OpenAmount(growth, m_flowers[i].Order, m_openSpan);
                float s = m_openCurve.Evaluate(open) * m_flowers[i].Scale;
                t.localScale = new Vector3(s, s, s);
            }
        }
    }
}
