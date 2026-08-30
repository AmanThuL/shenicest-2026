using UnityEngine;
using UnityEngine.UI;

namespace RootsDance.UI.Kit
{
    /// <summary>
    /// The split container (spec §4A, §5A): cuts its rect into weighted cells along one axis, with
    /// adjacent cells sharing a single rule. This is the piece the skeleton is built from — nesting
    /// splits is nesting cuts — and it is what makes a screen read as one rectangle cut to pieces
    /// instead of cards floating on a ground. Every seam is either one shared <c>Rule</c>, the one
    /// sanctioned <see cref="GutterAfter"/> gap (§5C), or nothing at all for the Terminal family,
    /// whose zones are told apart by fill steps rather than lines (§5B).
    /// <para>
    /// The first <c>weights.Length</c> children are the cells, in order; children after those are
    /// overlays (node dots, corner marks) and are left alone. The component draws the seams itself,
    /// so a rule between two cells exists exactly once — two cells each drawing their own edge is the
    /// card look the 2026-08-27 revision threw out.
    /// </para>
    /// </summary>
    [ExecuteAlways]
    public class KitSplit : KitElement
    {
        /// <summary>Cut direction: Rows stacks cells top to bottom, Columns left to right.</summary>
        public enum SplitAxis
        {
            Rows = 0,
            Columns = 1
        }

        /// <summary>What sits between two cells. Rule is the default shared hairline; None butts the
        /// cells together for fill-separated Terminal zones.</summary>
        public enum SeamStyle
        {
            Rule = 0,
            None = 1
        }

        [SerializeField] private SplitAxis m_axis = SplitAxis.Rows;

        [Tooltip("One entry per cell. Cells get the remaining space in proportion, after seams.")]
        [SerializeField] private float[] m_weights = { 1f, 1f };

        [SerializeField] private SeamStyle m_seam = SeamStyle.Rule;

        [Tooltip("Index of the seam that is a gutter gap instead of a shared rule; -1 for none. " +
            "The skeleton allows at most one gutter seam per screen (spec §5C).")]
        [SerializeField] private int m_gutterAfter = -1;

        [Tooltip("Gutter seam width in pixels. Zero takes the theme's Gutter metric.")]
        [Min(0f)]
        [SerializeField] private float m_gutterOverride;

        [Tooltip("Bright node dots where each seam meets the container edge — both archive " +
            "references pin every rule junction with one.")]
        [SerializeField] private bool m_endDots;

        [SerializeField] private KitInk m_dotInk = KitInk.Ink5;

        public int GutterAfter
        {
            get { return m_gutterAfter; }
            set
            {
                m_gutterAfter = value;
                Relayout();
                SetVerticesDirty();
            }
        }

        private int CellCount
        {
            get { return m_weights == null ? 0 : m_weights.Length; }
        }

        private float GutterWidth
        {
            get
            {
                if (m_gutterOverride > 0f)
                {
                    return m_gutterOverride;
                }

                return ActiveTheme != null ? ActiveTheme.Gutter : 16f;
            }
        }

        private float SeamWidth(int seam)
        {
            if (seam == m_gutterAfter)
            {
                return GutterWidth;
            }

            return m_seam == SeamStyle.Rule ? RuleWidth : 0f;
        }

        protected override void OnEnable()
        {
            base.OnEnable();
            Relayout();
        }

        protected override void OnRectTransformDimensionsChange()
        {
            base.OnRectTransformDimensionsChange();
            Relayout();
        }

        private void OnTransformChildrenChanged()
        {
            Relayout();
        }

#if UNITY_EDITOR
        protected override void OnValidate()
        {
            base.OnValidate();
            Relayout();
        }
#endif

        /// <summary>Repositions the cell children from the weights. Called from the layout hooks and
        /// from the theme walk; safe to call at any time.</summary>
        public void Relayout()
        {
            int count = CellCount;

            if (count == 0)
            {
                return;
            }

            Rect rect = rectTransform.rect;
            float total = m_axis == SplitAxis.Rows ? rect.height : rect.width;
            float weightSum = 0f;

            for (int i = 0; i < count; i++)
            {
                weightSum += Mathf.Max(0f, m_weights[i]);
            }

            if (weightSum <= 0f || total <= 0f)
            {
                return;
            }

            float seams = 0f;

            for (int i = 0; i < count - 1; i++)
            {
                seams += SeamWidth(i);
            }

            float space = Mathf.Max(0f, total - seams);
            float cursor = 0f;
            int cell = 0;

            for (int i = 0; i < transform.childCount && cell < count; i++)
            {
                RectTransform child = transform.GetChild(i) as RectTransform;

                if (child == null)
                {
                    continue;
                }

                float size = space * Mathf.Max(0f, m_weights[cell]) / weightSum;

                if (m_axis == SplitAxis.Rows)
                {
                    child.anchorMin = new Vector2(0f, 1f);
                    child.anchorMax = new Vector2(1f, 1f);
                    child.pivot = new Vector2(0.5f, 1f);
                    child.sizeDelta = new Vector2(0f, size);
                    child.anchoredPosition = new Vector2(0f, -cursor);
                }
                else
                {
                    child.anchorMin = new Vector2(0f, 0f);
                    child.anchorMax = new Vector2(0f, 1f);
                    child.pivot = new Vector2(0f, 0.5f);
                    child.sizeDelta = new Vector2(size, 0f);
                    child.anchoredPosition = new Vector2(cursor, 0f);
                }

                cursor += size;

                if (cell < count - 1)
                {
                    cursor += SeamWidth(cell);
                }

                cell++;
            }
        }

        public override void Apply(ElectronicUITheme theme)
        {
            base.Apply(theme);
            Relayout();
        }

        protected override void OnPopulateMesh(VertexHelper helper)
        {
            helper.Clear();

            int count = CellCount;

            if (count < 2)
            {
                return;
            }

            Rect rect = GetPixelAdjustedRect();
            float total = m_axis == SplitAxis.Rows ? rect.height : rect.width;
            float weightSum = 0f;

            for (int i = 0; i < count; i++)
            {
                weightSum += Mathf.Max(0f, m_weights[i]);
            }

            if (weightSum <= 0f || total <= 0f)
            {
                return;
            }

            float seams = 0f;

            for (int i = 0; i < count - 1; i++)
            {
                seams += SeamWidth(i);
            }

            float space = Mathf.Max(0f, total - seams);
            float cursor = 0f;

            Color32 dot = ActiveTheme != null ? (Color32)ActiveTheme.Ink(m_dotInk) : (Color32)color;
            float dotSize = Unit;

            for (int i = 0; i < count - 1; i++)
            {
                cursor += space * Mathf.Max(0f, m_weights[i]) / weightSum;
                float width = SeamWidth(i);
                bool drawn = m_seam == SeamStyle.Rule && i != m_gutterAfter;

                if (drawn)
                {
                    if (m_axis == SplitAxis.Rows)
                    {
                        AddRect(helper, rect.xMin, rect.yMax - cursor - width, rect.width, width);
                    }
                    else
                    {
                        AddRect(helper, rect.xMin + cursor, rect.yMin, width, rect.height);
                    }
                }

                if (m_endDots)
                {
                    float centre = cursor + width * 0.5f;
                    float half = dotSize * 0.5f;

                    if (m_axis == SplitAxis.Rows)
                    {
                        float y = rect.yMax - centre;
                        AddRect(helper, rect.xMin - half, y - half, dotSize, dotSize, dot);
                        AddRect(helper, rect.xMax - half, y - half, dotSize, dotSize, dot);
                    }
                    else
                    {
                        float x = rect.xMin + centre;
                        AddRect(helper, x - half, rect.yMin - half, dotSize, dotSize, dot);
                        AddRect(helper, x - half, rect.yMax - half, dotSize, dotSize, dot);
                    }
                }

                cursor += width;
            }
        }
    }
}
