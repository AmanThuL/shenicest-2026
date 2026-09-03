using RootsDance.Core;
using RootsDance.Data;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace RootsDance.UI
{
    /// <summary>
    /// Switches the main menu between its primary actions and control settings, and keeps the
    /// widgets synchronized with the player's persisted control preferences.
    /// </summary>
    public sealed class MainMenuSettingsPresenter : MonoBehaviour
    {
        [Header("Settings")]
        [SerializeField] private ControlSettingsSO m_controlSettings;

        [Header("Panels")]
        [SerializeField] private GameObject[] m_mainMenuObjects;
        [SerializeField] private GameObject m_settingsPanel;

        [Header("Widgets")]
        [SerializeField] private Button m_settingsButton;
        [SerializeField] private Button m_backButton;
        [SerializeField] private Slider m_mouseSensitivitySlider;
        [SerializeField] private TextMeshProUGUI m_mouseSensitivityValueLabel;
        [SerializeField] private Toggle m_invertYAxisToggle;

        private bool m_areListenersRegistered;

        private void OnEnable()
        {
            if (!HasRequiredReferences())
            {
                Log.Error("MainMenuSettingsPresenter is missing a required assignment.", this);
                return;
            }

            m_mouseSensitivitySlider.minValue = ControlSettingsSO.k_MinMouseSensitivityMultiplier;
            m_mouseSensitivitySlider.maxValue = ControlSettingsSO.k_MaxMouseSensitivityMultiplier;
            m_settingsButton.onClick.AddListener(OnSettingsClicked);
            m_backButton.onClick.AddListener(OnBackClicked);
            m_mouseSensitivitySlider.onValueChanged.AddListener(OnMouseSensitivityChanged);
            m_invertYAxisToggle.onValueChanged.AddListener(OnInvertYAxisChanged);
            m_controlSettings.Changed += ControlSettings_Changed;
            m_areListenersRegistered = true;

            RefreshWidgets();
            SetSettingsVisible(false);
        }

        private void OnDisable()
        {
            if (!m_areListenersRegistered)
            {
                return;
            }

            m_settingsButton.onClick.RemoveListener(OnSettingsClicked);
            m_backButton.onClick.RemoveListener(OnBackClicked);
            m_mouseSensitivitySlider.onValueChanged.RemoveListener(OnMouseSensitivityChanged);
            m_invertYAxisToggle.onValueChanged.RemoveListener(OnInvertYAxisChanged);
            m_controlSettings.Changed -= ControlSettings_Changed;
            m_areListenersRegistered = false;
        }

        private void OnSettingsClicked()
        {
            RefreshWidgets();
            SetSettingsVisible(true);
        }

        private void OnBackClicked()
        {
            SetSettingsVisible(false);
        }

        private void OnMouseSensitivityChanged(float multiplier)
        {
            m_controlSettings.SetMouseSensitivityMultiplier(multiplier);
        }

        private void OnInvertYAxisChanged(bool isInverted)
        {
            m_controlSettings.SetYAxisInverted(isInverted);
        }

        private void ControlSettings_Changed()
        {
            RefreshWidgets();
        }

        private void RefreshWidgets()
        {
            float multiplier = m_controlSettings.MouseSensitivityMultiplier;
            m_mouseSensitivitySlider.SetValueWithoutNotify(multiplier);
            m_invertYAxisToggle.SetIsOnWithoutNotify(m_controlSettings.IsYAxisInverted);
            m_mouseSensitivityValueLabel.SetText("{0:0}%", multiplier * 100f);
        }

        private void SetSettingsVisible(bool isVisible)
        {
            for (int i = 0; i < m_mainMenuObjects.Length; i++)
            {
                if (m_mainMenuObjects[i] != null)
                {
                    m_mainMenuObjects[i].SetActive(!isVisible);
                }
            }

            m_settingsPanel.SetActive(isVisible);
        }

        private bool HasRequiredReferences()
        {
            if (m_controlSettings == null || m_mainMenuObjects == null || m_mainMenuObjects.Length == 0)
            {
                return false;
            }

            return m_settingsPanel != null
                && m_settingsButton != null
                && m_backButton != null
                && m_mouseSensitivitySlider != null
                && m_mouseSensitivityValueLabel != null
                && m_invertYAxisToggle != null;
        }
    }
}
