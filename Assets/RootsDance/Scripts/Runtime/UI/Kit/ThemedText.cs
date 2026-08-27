using TMPro;
using UnityEngine;

namespace RootsDance.UI.Kit
{
    /// <summary>
    /// Owns one label completely: its ramp slot, its size role and its string (spec §2C).
    /// <para>
    /// It owns the string because monospacing has no public API on <see cref="TMP_Text"/> — the
    /// protected field is only reachable through the <c>mspace</c> rich-text tag, which has to be
    /// re-prefixed every time the content changes. Routing all kit text through here keeps that in one
    /// place, and means the kit gets a fixed advance out of whatever face is assigned instead of
    /// shipping a mono font binary. Assigning a real mono font to the theme is still one field.
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

        [Tooltip("Upper case is a rule of the style, not a preference. Spec §2C.")]
        [SerializeField] private bool m_forceUpperCase = true;

        private ElectronicUITheme m_theme;

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

        /// <summary>The label's content, without the monospacing prefix.</summary>
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

            label.richText = true;
            label.text = m_theme != null && m_theme.MonoSpacing > 0f
                ? "<mspace=" + m_theme.MonoSpacing.ToString("0.###") + "em>" + m_text
                : m_text;

            if (m_theme == null)
            {
                return;
            }

            label.color = m_theme.Ink(m_ink);
            label.fontSize = m_theme.Size(m_role);
            label.characterSpacing = m_theme.Tracking * 100f;
            label.fontStyle = m_forceUpperCase ? FontStyles.UpperCase : FontStyles.Normal;

            if (m_theme.Font != null)
            {
                label.font = m_theme.Font;
            }
        }
    }
}
