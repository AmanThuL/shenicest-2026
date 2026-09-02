using System;
using UnityEngine;

namespace RootsDance.Data
{
    /// <summary>
    /// The player's first-person control preferences, persisted independently from the project's
    /// authored look tuning in <see cref="PlayerConfigSO"/>.
    /// </summary>
    [CreateAssetMenu(fileName = "ControlSettings", menuName = "RootsDance/Settings/Controls")]
    public sealed class ControlSettingsSO : ScriptableObject
    {
        public const float k_MinMouseSensitivityMultiplier = 0.25f;
        public const float k_MaxMouseSensitivityMultiplier = 2.5f;
        public const float k_DefaultMouseSensitivityMultiplier = 1f;

        private const string k_MouseSensitivityMultiplierKey = "controls.mouseSensitivityMultiplier";
        private const string k_InvertYAxisKey = "controls.invertY";

        [NonSerialized] private bool m_isLoaded;
        [NonSerialized] private float m_mouseSensitivityMultiplier;
        [NonSerialized] private bool m_isYAxisInverted;

        /// <summary>Raised after a control preference actually changes.</summary>
        public event Action Changed;

        /// <summary>
        /// Multiplier applied to the project's authored mouse sensitivity. One is 100 percent.
        /// </summary>
        public float MouseSensitivityMultiplier
        {
            get
            {
                EnsureLoaded();
                return m_mouseSensitivityMultiplier;
            }
        }

        /// <summary>Whether upward mouse movement pitches the view down.</summary>
        public bool IsYAxisInverted
        {
            get
            {
                EnsureLoaded();
                return m_isYAxisInverted;
            }
        }

        public void SetMouseSensitivityMultiplier(float multiplier)
        {
            EnsureLoaded();
            float clampedMultiplier = ClampMouseSensitivityMultiplier(multiplier);

            if (Mathf.Approximately(m_mouseSensitivityMultiplier, clampedMultiplier))
            {
                return;
            }

            m_mouseSensitivityMultiplier = clampedMultiplier;
            PlayerPrefs.SetFloat(k_MouseSensitivityMultiplierKey, clampedMultiplier);
            Changed?.Invoke();
        }

        public void SetYAxisInverted(bool isInverted)
        {
            EnsureLoaded();

            if (m_isYAxisInverted == isInverted)
            {
                return;
            }

            m_isYAxisInverted = isInverted;
            PlayerPrefs.SetInt(k_InvertYAxisKey, isInverted ? 1 : 0);
            Changed?.Invoke();
        }

        private void OnEnable()
        {
            // Re-read after a domain reload or re-import so this asset never retains stale prefs.
            m_isLoaded = false;
        }

        private void OnDisable()
        {
            m_isLoaded = false;
        }

        private void EnsureLoaded()
        {
            if (m_isLoaded)
            {
                return;
            }

            m_isLoaded = true;
            float savedMultiplier = PlayerPrefs.GetFloat(
                k_MouseSensitivityMultiplierKey,
                k_DefaultMouseSensitivityMultiplier);
            m_mouseSensitivityMultiplier = ClampMouseSensitivityMultiplier(savedMultiplier);
            m_isYAxisInverted = PlayerPrefs.GetInt(k_InvertYAxisKey, 0) != 0;
        }

        private static float ClampMouseSensitivityMultiplier(float multiplier)
        {
            if (float.IsNaN(multiplier))
            {
                return k_DefaultMouseSensitivityMultiplier;
            }

            return Mathf.Clamp(
                multiplier,
                k_MinMouseSensitivityMultiplier,
                k_MaxMouseSensitivityMultiplier);
        }
    }
}
