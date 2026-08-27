using UnityEngine;
using UnityEngine.UI;

namespace RootsDance.UI.Kit
{
    /// <summary>
    /// The measuring grid laid over an image plate (spec §4B, §4C). It is what turns a picture into a
    /// reading: the same dithered eye with and without a reticle is the difference between an
    /// illustration and a sample under an instrument.
    /// </summary>
    public class KitReticle : KitElement
    {
        [Min(1)]
        [SerializeField] private int m_columns = 4;

        [Min(1)]
        [SerializeField] private int m_rows = 4;

        [Tooltip("Draws the outer edge as well as the interior divisions.")]
        [SerializeField] private bool m_includeEdges;

        protected override void OnPopulateMesh(VertexHelper helper)
        {
            helper.Clear();

            Rect rect = GetPixelAdjustedRect();
            float w = RuleWidth;
            int first = m_includeEdges ? 0 : 1;

            for (int c = first; c <= m_columns - first; c++)
            {
                float x = rect.xMin + rect.width * c / m_columns;
                AddRect(helper, Mathf.Min(x, rect.xMax - w), rect.yMin, w, rect.height);
            }

            for (int r = first; r <= m_rows - first; r++)
            {
                float y = rect.yMin + rect.height * r / m_rows;
                AddRect(helper, rect.xMin, Mathf.Min(y, rect.yMax - w), rect.width, w);
            }
        }
    }
}
