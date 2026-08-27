using UnityEngine;
using UnityEngine.UI;

namespace RootsDance.UI.Kit
{
    /// <summary>
    /// A gridded plot with a polyline through it (spec §4B). Unlike <see cref="KitBarcodeRows"/> this
    /// one carries real values: <see cref="SetSamples"/> takes an array in 0..1 and the trace follows
    /// it, so a presenter can drive it. With no samples set it draws a seeded standing wave, which is
    /// what makes it useful as a static prop straight out of the prefab.
    /// </summary>
    public class KitWaveform : KitElement
    {
        [Min(2)]
        [SerializeField] private int m_gridColumns = 12;

        [Min(1)]
        [SerializeField] private int m_gridRows = 4;

        [SerializeField] private KitInk m_gridInk = KitInk.Ink2;

        [Tooltip("Trace thickness in pixels.")]
        [Min(1f)]
        [SerializeField] private float m_traceWidth = 2f;

        [Min(4)]
        [SerializeField] private int m_resolution = 96;

        [Tooltip("Seeded traces drawn when no samples are set. The dossier reference plots two.")]
        [Range(1, 3)]
        [SerializeField] private int m_traces = 2;

        [SerializeField] private int m_seed = 5;

        private float[] m_samples;

        /// <summary>Drives the trace from real values, each 0..1. Null restores the seeded wave.</summary>
        public void SetSamples(float[] samples)
        {
            m_samples = samples;
            SetVerticesDirty();
        }

        private float Sample(int i, int count, int trace)
        {
            if (m_samples != null && m_samples.Length > 1)
            {
                float t = i / (float)(count - 1) * (m_samples.Length - 1);
                int a = Mathf.Clamp(Mathf.FloorToInt(t), 0, m_samples.Length - 1);
                int b = Mathf.Clamp(a + 1, 0, m_samples.Length - 1);

                return Mathf.Lerp(m_samples[a], m_samples[b], t - a);
            }

            int seed = m_seed + trace * 17;
            float x = i / (float)(count - 1);
            float wave = Mathf.Sin(x * Mathf.PI * (5f + trace * 2f) + Hash01(seed, 0, 1) * 6.28f) * 0.32f
                + Mathf.Sin(x * Mathf.PI * 13f + Hash01(seed, 1, 2) * 6.28f) * 0.14f;

            return 0.5f + wave;
        }

        protected override void OnPopulateMesh(VertexHelper helper)
        {
            helper.Clear();

            Rect rect = GetPixelAdjustedRect();
            float w = RuleWidth;
            Color32 grid = ActiveTheme != null ? ActiveTheme.Ink(m_gridInk) : (Color)color * 0.4f;

            for (int c = 0; c <= m_gridColumns; c++)
            {
                float x = rect.xMin + rect.width * c / m_gridColumns;
                AddRect(helper, Mathf.Min(x, rect.xMax - w), rect.yMin, w, rect.height, grid);
            }

            for (int r = 0; r <= m_gridRows; r++)
            {
                float y = rect.yMin + rect.height * r / m_gridRows;
                AddRect(helper, rect.xMin, Mathf.Min(y, rect.yMax - w), rect.width, w, grid);
            }

            int count = Mathf.Max(4, m_resolution);
            float step = rect.width / (count - 1);
            int traces = m_samples != null && m_samples.Length > 1 ? 1 : Mathf.Max(1, m_traces);

            // Each trace is drawn as one short bar per segment rather than a stroked path: at these
            // thicknesses the difference is invisible and it keeps the whole element to one draw call.
            for (int trace = 0; trace < traces; trace++)
            {
                Color32 ink = color;

                if (trace > 0 && ActiveTheme != null)
                {
                    ink = ActiveTheme.Ink(KitInk.Ink3);
                }

                for (int i = 0; i < count - 1; i++)
                {
                    float y0 = rect.yMin + Mathf.Clamp01(Sample(i, count, trace)) * rect.height;
                    float y1 = rect.yMin + Mathf.Clamp01(Sample(i + 1, count, trace)) * rect.height;
                    float low = Mathf.Min(y0, y1);
                    float height = Mathf.Max(Mathf.Abs(y1 - y0), m_traceWidth);

                    AddRect(helper, rect.xMin + i * step,
                        Mathf.Clamp(low, rect.yMin, rect.yMax - height),
                        Mathf.Max(step, m_traceWidth), height, ink);
                }
            }
        }
    }
}
