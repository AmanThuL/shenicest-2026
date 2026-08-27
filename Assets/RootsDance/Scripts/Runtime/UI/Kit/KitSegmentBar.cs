using UnityEngine;
using UnityEngine.UI;

namespace RootsDance.UI.Kit
{
    /// <summary>
    /// A row of discrete segments filled to a value (spec §4B) — the battery meter, a signal strength,
    /// a level readout. Discrete on purpose: a continuous fill bar reads as a progress bar from a
    /// modern app, while counted segments read as an instrument.
    /// </summary>
    public class KitSegmentBar : KitElement
    {
        [Min(1)]
        [SerializeField] private int m_segments = 4;

        [Range(0f, 1f)]
        [SerializeField] private float m_value = 1f;

        [Tooltip("Slot the unfilled segments take. Filled ones use this element's own Ink.")]
        [SerializeField] private KitInk m_emptyInk = KitInk.Ink2;

        [Tooltip("Gap between segments, in pixels.")]
        [Min(0f)]
        [SerializeField] private float m_gap = 2f;

        [SerializeField] private bool m_vertical;

        public float Value
        {
            get { return m_value; }
            set
            {
                m_value = Mathf.Clamp01(value);
                SetVerticesDirty();
            }
        }

        protected override void OnPopulateMesh(VertexHelper helper)
        {
            helper.Clear();

            Rect rect = GetPixelAdjustedRect();
            int count = Mathf.Max(1, m_segments);
            int filled = Mathf.RoundToInt(Mathf.Clamp01(m_value) * count);

            Color32 on = color;
            Color32 off = ActiveTheme != null ? ActiveTheme.Ink(m_emptyInk) : (Color)color * 0.3f;

            float span = m_vertical ? rect.height : rect.width;
            float size = (span - m_gap * (count - 1)) / count;

            if (size <= 0f)
            {
                return;
            }

            for (int i = 0; i < count; i++)
            {
                float offset = i * (size + m_gap);
                Color32 fill = i < filled ? on : off;

                if (m_vertical)
                {
                    AddRect(helper, rect.xMin, rect.yMin + offset, rect.width, size, fill);
                }
                else
                {
                    AddRect(helper, rect.xMin + offset, rect.yMin, size, rect.height, fill);
                }
            }
        }
    }
}
