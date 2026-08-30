using System;
using RootsDance.UI.Kit;
using UnityEngine;
using UnityEngine.UI;

namespace RootsDance.UI
{
    /// <summary>
    /// One clickable tab on the scanner's report screen — a section tab down the left rail, a page
    /// tab across the top, or a function tab over the body panel. Three rows of the same widget, so
    /// the presenter drives all three through one type instead of three near-identical blocks.
    /// <para>
    /// The selected state is a child object rather than a colour swap: the kit forbids components
    /// carrying literal colours, and toggling a themed fill keeps the ramp in the theme's hands.
    /// </para>
    /// </summary>
    [DisallowMultipleComponent]
    public class ScannerReportTab : MonoBehaviour
    {
        [SerializeField] private Button m_button;

        [Tooltip("The tab's caption. A ThemedText, not a raw TMP label: the kit owns the string, "
            + "its case and its ramp slot.")]
        [SerializeField] private ThemedText m_label;

        [Tooltip("Shown while this tab is the current one. Usually a themed fill behind the label.")]
        [SerializeField] private GameObject m_selectedMark;

        [Tooltip("Shown when this tab holds something the player has not read yet.")]
        [SerializeField] private GameObject m_updateDot;

        private int m_index;
        private Action<int> m_onClicked;

        private void Awake()
        {
            if (m_button != null)
            {
                m_button.onClick.AddListener(OnClicked);
            }
        }

        private void OnDestroy()
        {
            if (m_button != null)
            {
                m_button.onClick.RemoveListener(OnClicked);
            }
        }

        /// <summary>Fills the tab in and hands it the callback it reports its index to.</summary>
        public void Bind(int index, string label, Action<int> onClicked)
        {
            m_index = index;
            m_onClicked = onClicked;

            if (m_label != null)
            {
                m_label.Text = label;
            }
        }

        public void SetSelected(bool selected)
        {
            if (m_selectedMark != null)
            {
                m_selectedMark.SetActive(selected);
            }
        }

        public void SetUnread(bool unread)
        {
            if (m_updateDot != null)
            {
                m_updateDot.SetActive(unread);
            }
        }

        private void OnClicked()
        {
            m_onClicked?.Invoke(m_index);
        }
    }
}
