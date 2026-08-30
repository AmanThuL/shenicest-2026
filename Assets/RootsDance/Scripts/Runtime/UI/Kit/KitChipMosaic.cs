using UnityEngine;
using UnityEngine.UI;

namespace RootsDance.UI.Kit
{
    /// <summary>
    /// A grid of small filled chips taking random steps of the ramp (spec §4B), with a few cells
    /// pushed to the top of the ramp. The police reference uses it as a sample readout; it is the
    /// kit's one piece of pure texture, and the only place a colour is chosen at random — which is
    /// safe precisely because the choice is constrained to the ramp.
    /// </summary>
    public class KitChipMosaic : KitElement
    {
        [Min(1)]
        [SerializeField] private int m_columns = 8;

        [Min(1)]
        [SerializeField] private int m_rows = 4;

        [Min(0f)]
        [SerializeField] private float m_gap = 3f;

        [Tooltip("Chance a cell is drawn at all. Empty cells are part of the pattern.")]
        [Range(0f, 1f)]
        [SerializeField] private float m_occupancy = 0.7f;

        [Tooltip("Chance an occupied cell is pushed to the brightest ink.")]
        [Range(0f, 1f)]
        [SerializeField] private float m_highlightChance = 0.08f;

        [SerializeField] private int m_seed = 3;

        protected override void OnPopulateMesh(VertexHelper helper)
        {
            helper.Clear();

            Rect rect = GetPixelAdjustedRect();
            float cellW = (rect.width - m_gap * (m_columns - 1)) / m_columns;
            float cellH = (rect.height - m_gap * (m_rows - 1)) / m_rows;

            if (cellW <= 0f || cellH <= 0f)
            {
                return;
            }

            for (int r = 0; r < m_rows; r++)
            {
                for (int c = 0; c < m_columns; c++)
                {
                    if (Hash01(r, c, m_seed) > m_occupancy)
                    {
                        continue;
                    }

                    Color32 fill = color;

                    if (ActiveTheme != null)
                    {
                        // Measured off the police reference's chip block: mostly mid-greys, a run of
                        // teal (the second accent), and one or two cells blown to full white.
                        float pick = Hash01(c, r, m_seed + 11);
                        KitInk ink;

                        if (pick < m_highlightChance)
                        {
                            ink = KitInk.Ink5;
                        }
                        else if (pick < m_highlightChance + 0.25f)
                        {
                            ink = KitInk.AccentAlt;
                        }
                        else
                        {
                            ink = pick < 0.66f ? KitInk.Ink3 : KitInk.Ink2;
                        }

                        fill = ActiveTheme.Ink(ink);
                    }

                    AddRect(helper,
                        rect.xMin + c * (cellW + m_gap),
                        rect.yMax - (r + 1) * cellH - r * m_gap,
                        cellW, cellH, fill);
                }
            }
        }
    }
}
