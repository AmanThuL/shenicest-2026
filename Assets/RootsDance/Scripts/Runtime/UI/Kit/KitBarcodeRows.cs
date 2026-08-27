using UnityEngine;
using UnityEngine.UI;

namespace RootsDance.UI.Kit
{
    /// <summary>
    /// Stacked rows of uneven vertical bars (spec §4B) — the spectrum block on the police reference.
    /// Content is generated from a seed rather than authored: it is texture, not data, and the moment
    /// it has to mean something it should be a <see cref="KitWaveform"/> instead.
    /// </summary>
    public class KitBarcodeRows : KitElement
    {
        [Min(1)]
        [SerializeField] private int m_rows = 4;

        [Tooltip("Bars per row, before the seed drops some of them.")]
        [Min(2)]
        [SerializeField] private int m_density = 26;

        [Range(0f, 1f)]
        [SerializeField] private float m_fill = 0.55f;

        [Min(0f)]
        [SerializeField] private float m_rowGap = 3f;

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

            float slot = rect.width / Mathf.Max(2, m_density);

            for (int r = 0; r < rows; r++)
            {
                float y = rect.yMax - (r + 1) * rowHeight - r * m_rowGap;

                for (int c = 0; c < m_density; c++)
                {
                    if (Hash01(r, c, m_seed) > m_fill)
                    {
                        continue;
                    }

                    float width = Mathf.Max(RuleWidth, slot * (0.2f + 0.5f * Hash01(c, r, m_seed + 7)));
                    AddRect(helper, rect.xMin + c * slot, y, width, rowHeight);
                }
            }
        }
    }
}
