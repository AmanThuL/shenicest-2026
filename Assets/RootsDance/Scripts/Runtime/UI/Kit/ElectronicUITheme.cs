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
        Accent = 6,

        /// <summary>Second measured accent — the police reference's teal chips and sample bars. A
        /// theme without one sets it equal to Ink2.</summary>
        AccentAlt = 7
    }

    /// <summary>Type size role. Three steps at 1 : 1.5 : 2.5, spec §2C.</summary>
    public enum KitType
    {
        Micro = 0,
        Body = 1,
        Display = 2
    }

    /// <summary>
    /// Which of the spec's two screen families a theme belongs to (spec §2A, §2C, §5C). The family is
    /// a property of the theme, not of a component: Archive screens are all-caps and all right angles,
    /// Terminal screens allow lower case, italic display titles and small fixed radii on interactive
    /// elements only. Components read this instead of carrying their own switches.
    /// </summary>
    public enum KitFamily
    {
        Archive = 0,
        Terminal = 1
    }

    /// <summary>
    /// How a label decides its case (spec §2C). Family defers to the theme: Archive forces upper case,
    /// Terminal keeps the authored string. Upper and Mixed override for the rare label that must not
    /// follow the family, e.g. a URL on an Archive screen.
    /// </summary>
    public enum KitCase
    {
        Family = 0,
        Upper = 1,
        Mixed = 2
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

        [Tooltip("Second accent for data texture — the police reference's teal chips and bars. " +
            "A theme without one sets this equal to Ink2.")]
        [SerializeField] private Color m_accentAlt = Color.cyan;

        [Tooltip("Archive: all caps, right angles everywhere. Terminal: lower case allowed, small " +
            "fixed radii on interactive elements. Spec §2C, §5C.")]
        [SerializeField] private KitFamily m_family = KitFamily.Archive;

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

        [Tooltip("The one skeleton seam a screen may have, and space between in-cell siblings. In units.")]
        [Min(0f)]
        [SerializeField] private float m_gutterUnits = 4f;

        [Tooltip("Data row height, in units. Measured 39-41 px across the references.")]
        [Min(1f)]
        [SerializeField] private float m_rowUnits = 10f;

        [Tooltip("Outer frame inset from the screen edge, in units. Measured 6-8% of width.")]
        [Min(0f)]
        [SerializeField] private float m_insetUnits = 16f;

        [Tooltip("Corner bracket arm length, in units.")]
        [Min(1f)]
        [SerializeField] private float m_cornerUnits = 4f;

        [Tooltip("Corner radius of Terminal-family interactive elements, in units. Spec allows 1-1.5u; " +
            "panels and frames never round, and the Archive family ignores this entirely.")]
        [Range(1f, 1.5f)]
        [SerializeField] private float m_interactiveRadiusUnits = 1.5f;

        [Header("Type (spec §2C) — Fusion Pixel, a real pixel mono face; no mspace fakery")]
        [SerializeField] private TMP_FontAsset m_font;

        [Tooltip("Synthetic bold on every label. The dossier reference's face is a heavy slab pixel " +
            "font; until a true bold pixel face is added this is the closest Fusion Pixel gets.")]
        [SerializeField] private bool m_boldText;

        [SerializeField] private float m_microSize = 16f;

        [SerializeField] private float m_bodySize = 24f;

        [SerializeField] private float m_displaySize = 40f;

        public Color Accent
        {
            get { return m_accent; }
        }

        public KitFamily Family
        {
            get { return m_family; }
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

        /// <summary>Radius for interactive elements. Zero on the Archive family — its screens are all
        /// right angles, and that difference lives here rather than on every button.</summary>
        public float InteractiveCornerRadius
        {
            get { return m_family == KitFamily.Terminal ? m_interactiveRadiusUnits * Unit : 0f; }
        }

        public TMP_FontAsset Font
        {
            get { return m_font; }
        }

        public bool BoldText
        {
            get { return m_boldText; }
        }

        /// <summary>Colour for a ramp slot. Out-of-range slots fall back to the brightest ink.</summary>
        public Color Ink(KitInk slot)
        {
            if (slot == KitInk.Accent)
            {
                return m_accent;
            }

            if (slot == KitInk.AccentAlt)
            {
                return m_accentAlt;
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
