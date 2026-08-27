using UnityEngine;

namespace RootsDance.UI.Kit
{
    /// <summary>
    /// One label-left / value-right line of a data table (spec §4B). No leader dots and no centring:
    /// the references have neither, and both are the fastest way to make the table read as a menu.
    /// <para>
    /// <see cref="Alarm"/> moves the whole row to the accent, which is the only sanctioned use of that
    /// colour (spec §5C) and the reason it lives on the row rather than on a free-standing text.
    /// </para>
    /// </summary>
    [ExecuteAlways]
    public class KitDataRow : MonoBehaviour
    {
        [SerializeField] private ThemedText m_label;

        [SerializeField] private ThemedText m_value;

        [SerializeField] private string m_labelText = "LABEL";

        [SerializeField] private string m_valueText = "VALUE";

        [Tooltip("Moves the row to the accent. Alarm only — spec §5C caps a screen at two.")]
        [SerializeField] private bool m_alarm;

        public bool Alarm
        {
            get { return m_alarm; }
            set
            {
                m_alarm = value;
                Refresh();
            }
        }

        public string Value
        {
            get { return m_valueText; }
            set
            {
                m_valueText = value;
                Refresh();
            }
        }

        private void OnEnable()
        {
            Refresh();
        }

        private void OnValidate()
        {
            Refresh();
        }

        /// <summary>Pushes the strings and the alarm state onto the two labels.</summary>
        public void Refresh()
        {
            if (m_label != null)
            {
                m_label.Ink = m_alarm ? KitInk.Accent : KitInk.Ink3;
                m_label.Text = m_labelText;
            }

            if (m_value != null)
            {
                m_value.Ink = m_alarm ? KitInk.Accent : KitInk.Ink5;
                m_value.Text = m_valueText;
            }
        }
    }
}
