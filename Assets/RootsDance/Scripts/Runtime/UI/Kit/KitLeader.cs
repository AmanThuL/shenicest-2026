using UnityEngine;
using UnityEngine.UI;

namespace RootsDance.UI.Kit
{
    /// <summary>
    /// A leader line (spec §4C): a polyline from an annotation to a point inside an image, with a
    /// filled square at the start and a small open box around the target. The police reference runs
    /// two of them in its accent red from the sample chips into the eye — the kit's only sanctioned
    /// diagonal, and one of its two sanctioned accent uses.
    /// <para>
    /// Points are authored in the element's local rect space, top-left origin, so a builder can copy
    /// coordinates straight off a measured reference.
    /// </para>
    /// </summary>
    public class KitLeader : KitElement
    {
        [Tooltip("Polyline in local pixels, top-left origin. First point gets the filled square, " +
            "last point gets the open target box.")]
        [SerializeField] private Vector2[] m_points = { new Vector2(0f, 0f), new Vector2(80f, 0f) };

        [Tooltip("Line thickness in pixels. Zero takes the theme rule width.")]
        [Min(0f)]
        [SerializeField] private float m_widthOverride;

        [Tooltip("Edge length of the filled square at the start.")]
        [Min(0f)]
        [SerializeField] private float m_startSquare = 12f;

        [Tooltip("Edge length of the open box at the target. Zero for none.")]
        [Min(0f)]
        [SerializeField] private float m_targetBox = 16f;

        public void SetPoints(Vector2[] points)
        {
            m_points = points;
            SetVerticesDirty();
        }

        protected override void OnPopulateMesh(VertexHelper helper)
        {
            helper.Clear();

            if (m_points == null || m_points.Length < 2)
            {
                return;
            }

            Rect rect = GetPixelAdjustedRect();
            float w = m_widthOverride > 0f ? m_widthOverride : Mathf.Max(RuleWidth, 2f);

            for (int i = 0; i < m_points.Length - 1; i++)
            {
                AddSegment(helper, ToLocal(rect, m_points[i]), ToLocal(rect, m_points[i + 1]), w);
            }

            Vector2 start = ToLocal(rect, m_points[0]);
            AddRect(helper, start.x - m_startSquare * 0.5f, start.y - m_startSquare * 0.5f,
                m_startSquare, m_startSquare);

            if (m_targetBox > 0f)
            {
                Vector2 end = ToLocal(rect, m_points[m_points.Length - 1]);
                float half = m_targetBox * 0.5f;
                AddRect(helper, end.x - half, end.y - half, m_targetBox, w);
                AddRect(helper, end.x - half, end.y + half - w, m_targetBox, w);
                AddRect(helper, end.x - half, end.y - half, w, m_targetBox);
                AddRect(helper, end.x + half - w, end.y - half, w, m_targetBox);
                AddRect(helper, end.x - w, end.y - w, w * 2f, w * 2f);
            }
        }

        private static Vector2 ToLocal(Rect rect, Vector2 authored)
        {
            return new Vector2(rect.xMin + authored.x, rect.yMax - authored.y);
        }

        private void AddSegment(VertexHelper helper, Vector2 a, Vector2 b, float width)
        {
            Vector2 dir = b - a;

            if (dir.sqrMagnitude < 1e-4f)
            {
                return;
            }

            Vector2 normal = new Vector2(-dir.y, dir.x).normalized * (width * 0.5f);
            int start = helper.currentVertCount;

            UIVertex vertex = UIVertex.simpleVert;
            vertex.color = color;
            vertex.uv0 = Vector2.zero;

            vertex.position = a - normal;
            helper.AddVert(vertex);
            vertex.position = a + normal;
            helper.AddVert(vertex);
            vertex.position = b + normal;
            helper.AddVert(vertex);
            vertex.position = b - normal;
            helper.AddVert(vertex);

            helper.AddTriangle(start, start + 1, start + 2);
            helper.AddTriangle(start + 2, start + 3, start);
        }
    }
}
