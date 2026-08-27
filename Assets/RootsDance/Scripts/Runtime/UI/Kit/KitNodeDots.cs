using UnityEngine;
using UnityEngine.UI;

namespace RootsDance.UI.Kit
{
    /// <summary>
    /// Small squares on a rect's corners and edge midpoints (spec §4C) — the dossier reference's
    /// signature element. They sit on the seams of the skeleton and read as the fasteners holding the
    /// cut together, which is why they belong to the screen's structure and never to a content block.
    /// </summary>
    public class KitNodeDots : KitElement
    {
        [Tooltip("Dot edge length in pixels. Zero means one theme unit.")]
        [Min(0f)]
        [SerializeField] private float m_dotSize;

        [Tooltip("Also mark the midpoint of each edge, as the dossier reference does.")]
        [SerializeField] private bool m_midpoints = true;

        protected override void OnPopulateMesh(VertexHelper helper)
        {
            helper.Clear();

            Rect rect = GetPixelAdjustedRect();
            float size = m_dotSize > 0f ? m_dotSize : Unit;
            float half = size * 0.5f;

            AddDot(helper, rect.xMin, rect.yMin, half);
            AddDot(helper, rect.xMax, rect.yMin, half);
            AddDot(helper, rect.xMin, rect.yMax, half);
            AddDot(helper, rect.xMax, rect.yMax, half);

            if (!m_midpoints)
            {
                return;
            }

            AddDot(helper, rect.center.x, rect.yMin, half);
            AddDot(helper, rect.center.x, rect.yMax, half);
            AddDot(helper, rect.xMin, rect.center.y, half);
            AddDot(helper, rect.xMax, rect.center.y, half);
        }

        private void AddDot(VertexHelper helper, float x, float y, float half)
        {
            AddRect(helper, x - half, y - half, half * 2f, half * 2f);
        }
    }
}
