using RootsDance.Data;
using UnityEngine;
using UnityEngine.UI;

namespace RootsDance.UI
{
    /// <summary>
    /// One checkbox of the rescue panel's recording section, bound to either the master switch
    /// or one hidden group of <see cref="RecordingModeSO"/>. Self-contained so the panel only has
    /// to know the toggles exist for keyboard navigation.
    /// </summary>
    public sealed class RecordingModeToggle : MonoBehaviour
    {
        [SerializeField] private RecordingModeSO m_mode;

        [Tooltip("On: this box is the master switch and the group below is ignored.")]
        [SerializeField] private bool m_isMasterSwitch;

        [SerializeField] private RecordingHiddenUi m_group = RecordingHiddenUi.InteractionHints;

        [SerializeField] private Toggle m_toggle;

        public Toggle Toggle => m_toggle;

        private void OnEnable()
        {
            m_toggle.onValueChanged.AddListener(OnToggled);

            if (m_mode != null)
            {
                m_mode.Changed += Sync;
            }

            Sync();
        }

        private void OnDisable()
        {
            m_toggle.onValueChanged.RemoveListener(OnToggled);

            if (m_mode != null)
            {
                m_mode.Changed -= Sync;
            }
        }

        private void Sync()
        {
            if (m_mode == null)
            {
                m_toggle.interactable = false;
                return;
            }

            m_toggle.SetIsOnWithoutNotify(m_isMasterSwitch
                ? m_mode.IsActive : (m_mode.Hidden & m_group) != 0);
        }

        private void OnToggled(bool isOn)
        {
            if (m_mode == null)
            {
                return;
            }

            if (m_isMasterSwitch)
            {
                m_mode.SetActive(isOn);
            }
            else
            {
                m_mode.SetHidden(m_group, isOn);
            }
        }
    }
}
