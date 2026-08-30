using UnityEngine;
using UnityEngine.UI;

namespace RootsDance.UI.Kit
{
    /// <summary>
    /// Four corner brackets around a rect (spec §4C). Cheaper on the eye than a full border when a
    /// block needs to be delimited without being boxed in — the kit uses it on outer frames and on
    /// image plates, where a closed border would fight the plate's own edge.
    /// </summary>
    public class KitCornerMarks : KitElement
    {
        [Tooltip("Arm length in pixels. Zero means take the theme's Corner metric.")]
        [Min(0f)]
        [SerializeField] private float m_armOverride;

        [Tooltip("Draws the marks outside the rect instead of inside it.")]
        [SerializeField] private bool m_outside;

        protected override void OnPopulateMesh(VertexHelper helper)
        {
            helper.Clear();

            Rect rect = GetPixelAdjustedRect();
            float arm = m_armOverride > 0f
                ? m_armOverride
                : ActiveTheme != null ? ActiveTheme.Corner : 16f;
            float w = RuleWidth;
            float o = m_outside ? w : 0f;

            float x0 = rect.xMin - o;
            float x1 = rect.xMax + o;
            float y0 = rect.yMin - o;
            float y1 = rect.yMax + o;

            // Bottom left
            AddRect(helper, x0, y0, arm, w);
            AddRect(helper, x0, y0, w, arm);

            // Bottom right
            AddRect(helper, x1 - arm, y0, arm, w);
            AddRect(helper, x1 - w, y0, w, arm);

            // Top left
            AddRect(helper, x0, y1 - w, arm, w);
            AddRect(helper, x0, y1 - arm, w, arm);

            // Top right
            AddRect(helper, x1 - arm, y1 - w, arm, w);
            AddRect(helper, x1 - w, y1 - arm, w, arm);
        }
    }
}
