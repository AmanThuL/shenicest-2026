using UnityEngine;
using UnityEngine.UI;

namespace RootsDance.UI.Kit
{
    /// <summary>
    /// The shape under an interactive element — button, tab, input field (spec §4B, §5C). One graphic
    /// draws the optional fill and the hairline outline, and the corners come from the theme's family:
    /// Terminal rounds them at a small fixed radius, Archive is all right angles. No component ever
    /// chooses to be rounded; it can only choose which corners follow the family, which is how a tab
    /// rounds its top edge while its base sits flush.
    /// <para>
    /// Panels and frames must not use this. Rounding is an interactive-element trait, and a rounded
    /// panel is one of §7's outright rejections.
    /// </para>
    /// </summary>
    public class KitBox : KitElement
    {
        [System.Flags]
        public enum CornerMask
        {
            None = 0,
            BottomLeft = 1,
            BottomRight = 2,
            TopLeft = 4,
            TopRight = 8,
            All = 15
        }

        private const int k_ArcSegments = 4;

        [Tooltip("Hairline outline in the element's ink. Ghost buttons and inputs keep it on; a solid " +
            "button is usually fill only.")]
        [SerializeField] private bool m_outline = true;

        [SerializeField] private bool m_fill;

        [SerializeField] private KitInk m_fillInk = KitInk.Ink1;

        [Tooltip("Which corners follow the family radius. Tabs round only their top corners.")]
        [SerializeField] private CornerMask m_roundedCorners = CornerMask.All;

        [Tooltip("Explicit radius in pixels, ignoring the family. For the dossier reference's " +
            "three round status dots — the one measured circle on an Archive screen.")]
        [Min(0f)]
        [SerializeField] private float m_radiusOverride;

        public bool Fill
        {
            get { return m_fill; }
            set
            {
                m_fill = value;
                SetVerticesDirty();
            }
        }

        private float Radius
        {
            get
            {
                if (m_radiusOverride > 0f)
                {
                    return m_radiusOverride;
                }

                if (ActiveTheme == null)
                {
                    return 0f;
                }

                return ActiveTheme.InteractiveCornerRadius;
            }
        }

        protected override void OnPopulateMesh(VertexHelper helper)
        {
            helper.Clear();

            Rect rect = GetPixelAdjustedRect();
            float radius = Mathf.Min(Radius, Mathf.Min(rect.width, rect.height) * 0.5f);
            Vector2[] outer = BuildPath(rect, radius, 0f);

            if (m_fill)
            {
                Color32 fill = ActiveTheme != null ? (Color32)ActiveTheme.Ink(m_fillInk) : (Color32)color;
                AddFan(helper, outer, rect.center, fill);
            }

            if (m_outline)
            {
                Vector2[] inner = BuildPath(rect, radius, RuleWidth);
                AddStrip(helper, outer, inner, color);
            }
        }

        /// <summary>
        /// The rect's perimeter, walked counter-clockwise from the bottom-left corner, with the masked
        /// corners swept as small arcs. <paramref name="inset"/> shrinks the path towards the centre,
        /// which is how the outline's inner edge reuses the same walk and the same point count.
        /// </summary>
        private Vector2[] BuildPath(Rect rect, float radius, float inset)
        {
            float x0 = rect.xMin + inset;
            float x1 = rect.xMax - inset;
            float y0 = rect.yMin + inset;
            float y1 = rect.yMax - inset;
            float r = Mathf.Max(0f, radius - inset);

            Vector2[] path = new Vector2[4 * (k_ArcSegments + 1)];
            int index = 0;

            // Corner centres sit radius inside the un-inset rect, so outer and inner paths share them
            // and the outline keeps a constant width around the bend.
            AddCorner(path, ref index, new Vector2(rect.xMin + radius, rect.yMin + radius), r, 180f,
                (m_roundedCorners & CornerMask.BottomLeft) != 0, new Vector2(x0, y0));
            AddCorner(path, ref index, new Vector2(rect.xMax - radius, rect.yMin + radius), r, 270f,
                (m_roundedCorners & CornerMask.BottomRight) != 0, new Vector2(x1, y0));
            AddCorner(path, ref index, new Vector2(rect.xMax - radius, rect.yMax - radius), r, 0f,
                (m_roundedCorners & CornerMask.TopRight) != 0, new Vector2(x1, y1));
            AddCorner(path, ref index, new Vector2(rect.xMin + radius, rect.yMax - radius), r, 90f,
                (m_roundedCorners & CornerMask.TopLeft) != 0, new Vector2(x0, y1));

            return path;
        }

        private static void AddCorner(Vector2[] path, ref int index, Vector2 centre, float radius,
            float startDegrees, bool rounded, Vector2 square)
        {
            for (int i = 0; i <= k_ArcSegments; i++)
            {
                if (!rounded || radius <= 0f)
                {
                    path[index++] = square;
                    continue;
                }

                float a = (startDegrees + 90f * i / k_ArcSegments) * Mathf.Deg2Rad;
                path[index++] = centre + new Vector2(Mathf.Cos(a), Mathf.Sin(a)) * radius;
            }
        }

        private static void AddFan(VertexHelper helper, Vector2[] path, Vector2 centre, Color32 fill)
        {
            int start = helper.currentVertCount;

            UIVertex vertex = UIVertex.simpleVert;
            vertex.color = fill;
            vertex.uv0 = Vector2.zero;

            vertex.position = centre;
            helper.AddVert(vertex);

            for (int i = 0; i < path.Length; i++)
            {
                vertex.position = path[i];
                helper.AddVert(vertex);
            }

            for (int i = 0; i < path.Length; i++)
            {
                int next = (i + 1) % path.Length;
                helper.AddTriangle(start, start + 1 + i, start + 1 + next);
            }
        }

        private static void AddStrip(VertexHelper helper, Vector2[] outer, Vector2[] inner, Color32 ink)
        {
            int start = helper.currentVertCount;

            UIVertex vertex = UIVertex.simpleVert;
            vertex.color = ink;
            vertex.uv0 = Vector2.zero;

            for (int i = 0; i < outer.Length; i++)
            {
                vertex.position = outer[i];
                helper.AddVert(vertex);
                vertex.position = inner[i];
                helper.AddVert(vertex);
            }

            for (int i = 0; i < outer.Length; i++)
            {
                int a = start + i * 2;
                int next = start + (i + 1) % outer.Length * 2;
                helper.AddTriangle(a, next, next + 1);
                helper.AddTriangle(next + 1, a + 1, a);
            }
        }
    }
}
