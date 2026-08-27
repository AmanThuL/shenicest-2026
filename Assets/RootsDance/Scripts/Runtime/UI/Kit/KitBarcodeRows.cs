using UnityEngine;
using UnityEngine.UI;

namespace RootsDance.UI.Kit
{
    /// <summary>
    /// The police reference's sample readout (spec §4B): stacked full-width bars on a dark tinted
    /// ground with sparse bright ticks — a G/C/A/T strip read off an instrument, not a barcode label.
    /// Each row is one solid bar in <see cref="m_barInk"/> with tick marks in the element's own ink;
    /// the seeded layout is texture, not data — the moment it has to mean something it should be a
    /// <see cref="KitWaveform"/> instead.
    /// </summary>
    public class KitBarcodeRows : KitElement
    {
        [Min(1)]
        [SerializeField] private int m_rows = 4;

        [Tooltip("Tick slots per row; the seed leaves most of them empty.")]
        [Min(2)]
        [SerializeField] private int m_density = 40;

        [Tooltip("Chance a slot carries a tick. The references run sparse.")]
        [Range(0f, 1f)]
        [SerializeField] private float m_fill = 0.22f;

        [Tooltip("Bar ground behind the ticks.")]
        [SerializeField] private KitInk m_barInk = KitInk.Ink2;

        [Min(0f)]
        [SerializeField] private float m_rowGap = 4f;

        [Tooltip("Tick width in pixels.")]
        [Min(1f)]
        [SerializeField] private float m_tickWidth = 3f;

        [SerializeField] private int m_seed = 1;

        protected override void OnPopulateMesh(VertexHelper helper)
        {
            helper.Clear();

            Rect rect = GetPixelAdjustedRect();
            int rows = Mathf.Max(1, m_rows);
            float rowHeight = (rect.height - m_rowGap * (rows - 1)) / rows;

            if (rowHeight <= 0f)
            {
                return;
            }

            Color32 bar = ActiveTheme != null ? (Color32)ActiveTheme.Ink(m_barInk)
                : (Color32)((Color)color * 0.3f);
            float slot = rect.width / Mathf.Max(2, m_density);

            for (int r = 0; r < rows; r++)
            {
                float y = rect.yMax - (r + 1) * rowHeight - r * m_rowGap;
                AddRect(helper, rect.xMin, y, rect.width, rowHeight, bar);

                for (int c = 0; c < m_density; c++)
                {
                    if (Hash01(r, c, m_seed) > m_fill)
                    {
                        continue;
                    }

                    float wide = Hash01(c, r, m_seed + 7) < 0.2f ? 2f : 1f;
                    AddRect(helper, rect.xMin + c * slot, y + 1f, m_tickWidth * wide, rowHeight - 2f);
                }

                // The references close every bar with a tick hard against its right edge.
                AddRect(helper, rect.xMax - m_tickWidth, y + 1f, m_tickWidth, rowHeight - 2f);
            }
        }
    }
}
