using UnityEngine;
using UnityEngine.UI;

namespace RootsDance.UI.Kit
{
    /// <summary>
    /// A rectangle outline drawn as four bars of an exact pixel width (spec §2B, §4A). Everything in
    /// the kit that reads as a panel, a frame or a chip is one of these.
    /// <para>
    /// It generates its own mesh rather than tinting a nine-sliced sprite because the rule has to stay
    /// the same width whether it encloses an 800 px panel or an 80 px chip. That decoupling of line
    /// weight from component size is where the instrument feel comes from; a sprite border scales with
    /// the rect and the screen immediately reads as a stack of cards.
    /// </para>
    /// </summary>
    public class KitBorder : KitElement
    {
        [Tooltip("Use the theme's strong rule instead of the normal one. Outer frames and current items.")]
        [SerializeField] private bool m_strong;

        [Tooltip("Override in pixels. Zero means take the width from the theme.")]
        [Min(0f)]
        [SerializeField] private float m_widthOverride;

        [Header("Sides")]
        [SerializeField] private bool m_top = true;

        [SerializeField] private bool m_bottom = true;

        [SerializeField] private bool m_left = true;

        [SerializeField] private bool m_right = true;

        public bool Strong
        {
            get { return m_strong; }
            set
            {
                m_strong = value;
                SetVerticesDirty();
            }
        }

        private float Width
        {
            get
            {
                if (m_widthOverride > 0f)
                {
                    return m_widthOverride;
                }

                if (ActiveTheme == null)
                {
                    return m_strong ? 2f : 1f;
                }

                return m_strong ? ActiveTheme.RuleStrong : ActiveTheme.Rule;
            }
        }

        protected override void OnPopulateMesh(VertexHelper helper)
        {
            helper.Clear();

            Rect rect = GetPixelAdjustedRect();
            float w = Width;

            if (m_bottom)
            {
                AddRect(helper, rect.xMin, rect.yMin, rect.width, w);
            }

            if (m_top)
            {
                AddRect(helper, rect.xMin, rect.yMax - w, rect.width, w);
            }

            if (m_left)
            {
                AddRect(helper, rect.xMin, rect.yMin, w, rect.height);
            }

            if (m_right)
            {
                AddRect(helper, rect.xMax - w, rect.yMin, w, rect.height);
            }
        }
    }
}
