using NUnit.Framework;
using RootsDance.Data;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Data
{
    public sealed class ControlSettingsSOTests
    {
        private const string k_MouseSensitivityMultiplierKey = "controls.mouseSensitivityMultiplier";
        private const string k_InvertYAxisKey = "controls.invertY";

        private ControlSettingsSO m_settings;
        private bool m_hadMouseSensitivityMultiplier;
        private bool m_hadInvertYAxis;
        private float m_savedMouseSensitivityMultiplier;
        private int m_savedInvertYAxis;

        [SetUp]
        public void SetUp()
        {
            m_hadMouseSensitivityMultiplier = PlayerPrefs.HasKey(k_MouseSensitivityMultiplierKey);
            m_hadInvertYAxis = PlayerPrefs.HasKey(k_InvertYAxisKey);
            m_savedMouseSensitivityMultiplier = PlayerPrefs.GetFloat(k_MouseSensitivityMultiplierKey, 0f);
            m_savedInvertYAxis = PlayerPrefs.GetInt(k_InvertYAxisKey, 0);
            PlayerPrefs.DeleteKey(k_MouseSensitivityMultiplierKey);
            PlayerPrefs.DeleteKey(k_InvertYAxisKey);
            m_settings = ScriptableObject.CreateInstance<ControlSettingsSO>();
        }

        [TearDown]
        public void TearDown()
        {
            if (m_settings != null)
            {
                Object.DestroyImmediate(m_settings);
            }

            RestoreFloat(
                k_MouseSensitivityMultiplierKey,
                m_hadMouseSensitivityMultiplier,
                m_savedMouseSensitivityMultiplier);
            RestoreInt(k_InvertYAxisKey, m_hadInvertYAxis, m_savedInvertYAxis);
        }

        [Test]
        public void Properties_NoSavedPreferences_ReturnDefaults()
        {
            // Arrange

            // Act
            float multiplier = m_settings.MouseSensitivityMultiplier;
            bool isInverted = m_settings.IsYAxisInverted;

            // Assert
            Assert.That(multiplier, Is.EqualTo(ControlSettingsSO.k_DefaultMouseSensitivityMultiplier));
            Assert.That(isInverted, Is.False);
        }

        [Test]
        public void SetMouseSensitivityMultiplier_OutOfRange_ClampsAndRaisesOnlyOnRealChanges()
        {
            // Arrange
            int changedCount = 0;
            m_settings.Changed += () => changedCount++;

            // Act
            m_settings.SetMouseSensitivityMultiplier(0f);
            m_settings.SetMouseSensitivityMultiplier(-10f);
            m_settings.SetMouseSensitivityMultiplier(10f);
            m_settings.SetMouseSensitivityMultiplier(float.PositiveInfinity);

            // Assert
            Assert.That(
                m_settings.MouseSensitivityMultiplier,
                Is.EqualTo(ControlSettingsSO.k_MaxMouseSensitivityMultiplier));
            Assert.That(changedCount, Is.EqualTo(2));
            Assert.That(
                PlayerPrefs.GetFloat(k_MouseSensitivityMultiplierKey),
                Is.EqualTo(ControlSettingsSO.k_MaxMouseSensitivityMultiplier));
        }

        [Test]
        public void SetMouseSensitivityMultiplier_NotANumber_UsesDefault()
        {
            // Arrange
            m_settings.SetMouseSensitivityMultiplier(2f);

            // Act
            m_settings.SetMouseSensitivityMultiplier(float.NaN);

            // Assert
            Assert.That(
                m_settings.MouseSensitivityMultiplier,
                Is.EqualTo(ControlSettingsSO.k_DefaultMouseSensitivityMultiplier));
        }

        [Test]
        public void SetYAxisInverted_SameValueTwice_RaisesChangedOnceAndPersists()
        {
            // Arrange
            int changedCount = 0;
            m_settings.Changed += () => changedCount++;

            // Act
            m_settings.SetYAxisInverted(true);
            m_settings.SetYAxisInverted(true);

            // Assert
            Assert.That(m_settings.IsYAxisInverted, Is.True);
            Assert.That(changedCount, Is.EqualTo(1));
            Assert.That(PlayerPrefs.GetInt(k_InvertYAxisKey), Is.EqualTo(1));
        }

        [Test]
        public void Properties_SavedPreferencesExist_LoadsPersistedValues()
        {
            // Arrange
            m_settings.SetMouseSensitivityMultiplier(1.75f);
            m_settings.SetYAxisInverted(true);
            ControlSettingsSO reloadedSettings = ScriptableObject.CreateInstance<ControlSettingsSO>();

            try
            {
                // Act
                float multiplier = reloadedSettings.MouseSensitivityMultiplier;
                bool isInverted = reloadedSettings.IsYAxisInverted;

                // Assert
                Assert.That(multiplier, Is.EqualTo(1.75f));
                Assert.That(isInverted, Is.True);
            }
            finally
            {
                Object.DestroyImmediate(reloadedSettings);
            }
        }

        [Test]
        public void MouseSensitivityMultiplier_SavedValueIsInvalid_ClampsOnLoad()
        {
            // Arrange
            PlayerPrefs.SetFloat(k_MouseSensitivityMultiplierKey, 100f);
            ControlSettingsSO reloadedSettings = ScriptableObject.CreateInstance<ControlSettingsSO>();

            try
            {
                // Act
                float multiplier = reloadedSettings.MouseSensitivityMultiplier;

                // Assert
                Assert.That(multiplier, Is.EqualTo(ControlSettingsSO.k_MaxMouseSensitivityMultiplier));
            }
            finally
            {
                Object.DestroyImmediate(reloadedSettings);
            }
        }

        private static void RestoreFloat(string key, bool existed, float value)
        {
            if (existed)
            {
                PlayerPrefs.SetFloat(key, value);
            }
            else
            {
                PlayerPrefs.DeleteKey(key);
            }
        }

        private static void RestoreInt(string key, bool existed, int value)
        {
            if (existed)
            {
                PlayerPrefs.SetInt(key, value);
            }
            else
            {
                PlayerPrefs.DeleteKey(key);
            }
        }
    }
}
