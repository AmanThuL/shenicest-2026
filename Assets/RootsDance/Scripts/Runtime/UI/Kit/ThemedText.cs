using TMPro;
using UnityEngine;

namespace RootsDance.UI.Kit
{
    /// <summary>
    /// Owns one label completely: its ramp slot, its size role, its case and its string (spec §2C).
    /// <para>
    /// Case is a family rule, not a per-label choice: Archive screens are all caps, Terminal screens
    /// keep the authored string. The label defers to the theme by default and only overrides for the
    /// rare string that must not follow its family. The face is always the theme's — m5x7 for
    /// Latin, Fusion Pixel behind it for CJK, both real pixel faces. There is no monospacing fakery
    /// here any more: imposing a fixed advance on a proportional face was the old spec's approach,
    /// and it is exactly the giveaway §2C now bans.
    /// </para>
    /// </summary>
    [ExecuteAlways]
    [RequireComponent(typeof(TMP_Text))]
    public class ThemedText : MonoBehaviour
    {
        [SerializeField] private KitInk m_ink = KitInk.Ink5;

        [SerializeField] private KitType m_role = KitType.Body;

        [TextArea(1, 3)]
        [SerializeField] private string m_text = string.Empty;

        [Tooltip("Family defers to the theme: Archive upper-cases, Terminal keeps the string. Spec §2C.")]
        [SerializeField] private KitCase m_case = KitCase.Family;

        [Tooltip("TMP synthetic italic. Terminal-family Display titles only — both kit faces have " +
            "one weight and no italic cut, and the spec allows faking the slant but never the weight.")]
        [SerializeField] private bool m_italic;

        private ElectronicUITheme m_theme;
        private ElectronicUIRoot m_root;
        private bool m_hasRoot;

        /// <summary>Ramp slot this label paints from. KitDataRow flips it to drive its alarm state.</summary>
        public KitInk Ink
        {
            get { return m_ink; }
            set
            {
                m_ink = value;
                Apply(m_theme);
            }
        }

        /// <summary>The label's content, exactly as authored; case is applied at render time.</summary>
        public string Text
        {
            get { return m_text; }
            set
            {
                m_text = value == null ? string.Empty : value;
                Apply(m_theme);
            }
        }

        private void OnEnable()
        {
            Apply(m_theme);
        }

        private void OnValidate()
        {
            Apply(m_theme);
        }

        public void Apply(ElectronicUITheme theme)
        {
            if (theme != null)
            {
                m_theme = theme;
            }

            TMP_Text label = GetComponent<TMP_Text>();

            if (label == null)
            {
                return;
            }

            label.text = m_text;

            if (m_theme == null)
            {
                return;
            }

            label.color = m_theme.Ink(m_ink);
            label.fontSize = m_theme.Size(m_role);

            bool upper = m_case == KitCase.Upper
                || m_case == KitCase.Family && m_theme.Family == KitFamily.Archive;

            FontStyles style = upper ? FontStyles.UpperCase : FontStyles.Normal;

            if (m_italic)
            {
                style |= FontStyles.Italic;
            }

            if (m_theme.BoldText)
            {
                style |= FontStyles.Bold;
            }

            label.fontStyle = style;

            TMP_FontAsset face = ResolveFace();

            if (face != null)
            {
                label.font = face;
            }
        }

        /// <summary>
        /// The face this label prints in: its screen's override when it has one, the theme's
        /// otherwise. The screen is asked rather than the theme because the reason to differ is a
        /// property of the screen — a diegetic panel written in Chinese cannot go through a
        /// fallback font, since the fallback draws on its own material and the panel's material is
        /// the only one that renders at its scale.
        /// </summary>
        private TMP_FontAsset ResolveFace()
        {
            if (!m_hasRoot)
            {
                m_root = GetComponentInParent<ElectronicUIRoot>(true);
                m_hasRoot = true;
            }

            TMP_FontAsset over = m_root == null ? null : m_root.FontOverride;

            return over != null ? over : m_theme.Font;
        }
    }
}
