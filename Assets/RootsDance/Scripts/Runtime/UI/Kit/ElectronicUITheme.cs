using TMPro;
using UnityEngine;

namespace RootsDance.UI.Kit
{
    /// <summary>Ramp slot a themed element takes its colour from. See the kit spec §2A.</summary>
    public enum KitInk
    {
        Ink0 = 0,
        Ink1 = 1,
        Ink2 = 2,
        Ink3 = 3,
        Ink4 = 4,
        Ink5 = 5,
        Accent = 6
    }

    /// <summary>Type size role. Three steps at 1 : 1.25 : 2, spec §2C.</summary>
    public enum KitType
    {
        Micro = 0,
        Body = 1,
        Display = 2
    }

    /// <summary>
    /// The palette and metrics one screen is built from (docs/effects/电子类UI组件库规范.md §2).
    /// Nothing in the kit is allowed to hard-code a colour or a size; every component asks a theme.
    /// That indirection is the only reason swapping one asset reference restyles a whole screen, and
    /// it is what makes the kit a kit rather than three screens that happen to share a folder.
    /// <para>
    /// The ramp is deliberately not evenly spaced. How lit a screen looks is decided almost entirely
    /// by <c>Ink0</c>: the violet reference has no true black anywhere and reads as powered up, the
    /// police one drops to luma 8 and reads as switched off.
    /// </para>
    /// </summary>
    [CreateAssetMenu(menuName = "RootsDance/UI/Electronic UI Theme", fileName = "UITheme")]
    public class ElectronicUITheme : ScriptableObject
    {
        [Header("Ramp (spec §2A) — ground to key, six steps")]
        [Tooltip("Ink0 ground, Ink1 secondary fill, Ink2 dividers, Ink3 labels, Ink4 rules, Ink5 text.")]
        [SerializeField] private Color[] m_ramp = new Color[6];

        [Tooltip("Alarm only, never decoration. A theme with no alarm state sets this equal to Ink4.")]
        [SerializeField] private Color m_accent = Color.red;

        [Header("Metrics (spec §2B) — all sizes are multiples of Unit")]
        [Min(1f)]
        [SerializeField] private float m_unit = 4f;

        [Tooltip("Rule width. Constant in pixels at every component size — that is the whole point.")]
        [Min(1f)]
        [SerializeField] private float m_rule = 1f;

        [Min(1f)]
        [SerializeField] private float m_ruleStrong = 2f;

        [Tooltip("Panel inner padding, in units.")]
        [Min(0f)]
        [SerializeField] private float m_padUnits = 3f;

        [Tooltip("Space between sibling blocks, in units.")]
        [Min(0f)]
        [SerializeField] private float m_gutterUnits = 4f;

        [Tooltip("Data row height, in units. Measured 39-41 px across the references.")]
        [Min(1f)]
        [SerializeField] private float m_rowUnits = 10f;

        [Tooltip("Outer frame inset from the screen edge, in units. Measured 7-8% of width.")]
        [Min(0f)]
        [SerializeField] private float m_insetUnits = 16f;

        [Tooltip("Corner bracket arm length, in units.")]
        [Min(1f)]
        [SerializeField] private float m_cornerUnits = 4f;

        [Header("Type (spec §2C)")]
        [Tooltip("Any font asset; monospacing is imposed below rather than by shipping a mono font.")]
        [SerializeField] private TMP_FontAsset m_font;

        [Tooltip("Fixed advance in ems, via TMP's mspace tag. ~0.6 matches a typical mono face.")]
        [SerializeField] private float m_monoSpacing = 0.62f;

        [SerializeField] private float m_microSize = 12f;

        [SerializeField] private float m_bodySize = 15f;

        [SerializeField] private float m_displaySize = 24f;

        [Tooltip("Extra tracking, in ems. The references run wide; this is the period giveaway.")]
        [SerializeField] private float m_tracking = 0.06f;

        public Color Accent
        {
            get { return m_accent; }
        }

        public float Unit
        {
            get { return Mathf.Max(1f, m_unit); }
        }

        public float Rule
        {
            get { return Mathf.Max(1f, m_rule); }
        }

        public float RuleStrong
        {
            get { return Mathf.Max(1f, m_ruleStrong); }
        }

        public float Pad
        {
            get { return m_padUnits * Unit; }
        }

        public float Gutter
        {
            get { return m_gutterUnits * Unit; }
        }

        public float Row
        {
            get { return m_rowUnits * Unit; }
        }

        public float Inset
        {
            get { return m_insetUnits * Unit; }
        }

        public float Corner
        {
            get { return m_cornerUnits * Unit; }
        }

        public TMP_FontAsset Font
        {
            get { return m_font; }
        }

        public float MonoSpacing
        {
            get { return m_monoSpacing; }
        }

        public float Tracking
        {
            get { return m_tracking; }
        }

        /// <summary>Colour for a ramp slot. Out-of-range slots fall back to the brightest ink.</summary>
        public Color Ink(KitInk slot)
        {
            if (slot == KitInk.Accent)
            {
                return m_accent;
            }

            int index = (int)slot;

            if (m_ramp == null || m_ramp.Length == 0)
            {
                return Color.magenta;
            }

            return m_ramp[Mathf.Clamp(index, 0, m_ramp.Length - 1)];
        }

        public float Size(KitType role)
        {
            if (role == KitType.Micro)
            {
                return m_microSize;
            }

            return role == KitType.Display ? m_displaySize : m_bodySize;
        }

        private void OnValidate()
        {
            if (m_ramp == null || m_ramp.Length != 6)
            {
                Color[] resized = new Color[6];

                for (int i = 0; i < 6; i++)
                {
                    resized[i] = m_ramp != null && i < m_ramp.Length
                        ? m_ramp[i]
                        : Color.Lerp(Color.black, Color.white, i / 5f);
                }

                m_ramp = resized;
            }
        }
    }
}
