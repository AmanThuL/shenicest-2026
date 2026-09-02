using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using NUnit.Framework;
using RootsDance.Data;
using RootsDance.Player;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.TestTools;

namespace RootsDance.Tests.PlayMode.Player
{
    /// <summary>
    /// Drives PlayerLook through the real Input System (device events and real action resolution)
    /// so pointer-delta and stick-rate semantics are covered at their binding boundary.
    /// </summary>
    public class PlayerLookTests : InputTestFixture
    {
        private const string k_MouseSensitivityMultiplierKey = "controls.mouseSensitivityMultiplier";
        private const string k_InvertYAxisKey = "controls.invertY";

        private Mouse m_mouse;
        private Gamepad m_gamepad;
        private GameObject m_playerObject;
        private PlayerLook m_look;
        private ControlSettingsSO m_controlSettings;
        private bool m_hadMouseSensitivityMultiplier;
        private bool m_hadInvertYAxis;
        private float m_savedMouseSensitivityMultiplier;
        private int m_savedInvertYAxis;
        private readonly List<GameObject> m_extraObjects = new List<GameObject>();

        public override void Setup()
        {
            base.Setup();

            m_hadMouseSensitivityMultiplier = PlayerPrefs.HasKey(k_MouseSensitivityMultiplierKey);
            m_hadInvertYAxis = PlayerPrefs.HasKey(k_InvertYAxisKey);
            m_savedMouseSensitivityMultiplier = PlayerPrefs.GetFloat(k_MouseSensitivityMultiplierKey, 0f);
            m_savedInvertYAxis = PlayerPrefs.GetInt(k_InvertYAxisKey, 0);
            PlayerPrefs.DeleteKey(k_MouseSensitivityMultiplierKey);
            PlayerPrefs.DeleteKey(k_InvertYAxisKey);

            m_mouse = InputSystem.AddDevice<Mouse>();
            m_gamepad = InputSystem.AddDevice<Gamepad>();
            m_controlSettings = ScriptableObject.CreateInstance<ControlSettingsSO>();

            // The direct-input assertions use exact per-frame values, which only hold when raw
            // pointer delta passes straight through without smoothing.
            m_look = CreatePlayer(lookSensitivity: 1f, lookSmoothTime: 0f, out m_playerObject);
        }

        public override void TearDown()
        {
            if (m_playerObject != null)
            {
                Object.Destroy(m_playerObject);
            }

            if (m_controlSettings != null)
            {
                Object.Destroy(m_controlSettings);
            }

            for (int i = 0; i < m_extraObjects.Count; i++)
            {
                if (m_extraObjects[i] != null)
                {
                    Object.Destroy(m_extraObjects[i]);
                }
            }

            m_extraObjects.Clear();
            RestoreFloat(
                k_MouseSensitivityMultiplierKey,
                m_hadMouseSensitivityMultiplier,
                m_savedMouseSensitivityMultiplier);
            RestoreInt(k_InvertYAxisKey, m_hadInvertYAxis, m_savedInvertYAxis);
            base.TearDown();
        }

        [UnityTest]
        public IEnumerator Update_MouseDeltaWithoutButtonHeld_RotatesYaw()
        {
            Set(m_mouse.delta, new Vector2(10f, 0f));
            yield return null;

            Assert.AreEqual(10f, m_playerObject.transform.eulerAngles.y, 0.01f,
                "Moving the mouse must rotate yaw without a look-hold button.");
        }

        [UnityTest]
        public IEnumerator Update_MouseSensitivityMultiplier_ScalesYaw()
        {
            m_controlSettings.SetMouseSensitivityMultiplier(2f);
            Set(m_mouse.delta, new Vector2(10f, 0f));
            yield return null;

            Assert.AreEqual(20f, m_playerObject.transform.eulerAngles.y, 0.01f,
                "The persisted mouse multiplier must scale pointer delta.");
        }

        [UnityTest]
        public IEnumerator Update_InvertedYAxis_MouseUpPitchesDown()
        {
            m_controlSettings.SetYAxisInverted(true);
            yield return null;

            Set(m_mouse.delta, new Vector2(0f, 10f));
            yield return null;

            Transform head = m_playerObject.transform.Find("m_head");
            Assert.AreEqual(10f, head.localEulerAngles.x, 0.01f,
                "Inverted Y must turn upward mouse delta into downward pitch.");
        }

        [UnityTest]
        public IEnumerator Update_GamepadStick_UsesDegreesPerSecond()
        {
            Set(m_gamepad.rightStick, Vector2.right);
            yield return null;

            float yaw = m_playerObject.transform.eulerAngles.y;
            Assert.Greater(yaw, 0f, "The right stick must rotate without a mouse-only hold gate.");
            Assert.Less(yaw, 20f, "Stick input must be a frame-scaled rate, not degrees per frame.");
        }

        /// <summary>
        /// A mouse polls at its own rate, not the render frame rate, so a real capture shows the
        /// raw per-frame delta alternating between a full step and zero rather than a smooth
        /// trickle. Reproduces exactly that pattern and checks LookSmoothTime actually flattens the
        /// resulting per-frame yaw variance instead of just adding a knob nobody validated.
        /// </summary>
        [UnityTest]
        public IEnumerator Update_QuantizedMouseInput_SmoothingReducesPerFrameYawVariance()
        {
            const float step = 6f;
            const int frames = 20;

            PlayerLook raw = CreatePlayer(lookSensitivity: 1f, lookSmoothTime: 0f, out _, track: true);
            PlayerLook smoothed = CreatePlayer(lookSensitivity: 1f, lookSmoothTime: 0.03f, out _, track: true);

            float rawPrev = raw.transform.eulerAngles.y;
            float smoothedPrev = smoothed.transform.eulerAngles.y;
            float rawSpread = 0f;
            float smoothedSpread = 0f;

            for (int i = 0; i < frames; i++)
            {
                Set(m_mouse.delta, i % 2 == 0 ? new Vector2(step, 0f) : Vector2.zero);
                yield return null;

                float rawNow = raw.transform.eulerAngles.y;
                float smoothedNow = smoothed.transform.eulerAngles.y;

                rawSpread = Mathf.Max(rawSpread, Mathf.Abs(rawNow - rawPrev));
                smoothedSpread = Mathf.Max(smoothedSpread, Mathf.Abs(smoothedNow - smoothedPrev));

                rawPrev = rawNow;
                smoothedPrev = smoothedNow;
            }

            Assert.AreEqual(step, rawSpread, 0.01f,
                "Sanity check: with no smoothing the per-frame yaw step should exactly reproduce the "
                + "quantized input pattern (this pins down what 'raw' means for the comparison below).");
            Assert.Less(smoothedSpread, rawSpread * 0.8f,
                "LookSmoothTime should meaningfully flatten the per-frame yaw step caused by a mouse's "
                + "own polling cadence not lining up with the render frame rate.");
        }

        private PlayerLook CreatePlayer(float lookSensitivity, float lookSmoothTime, out GameObject playerObject,
            bool track = false)
        {
            PlayerConfigSO config = ScriptableObject.CreateInstance<PlayerConfigSO>();
            SetPrivateField(config, "m_lookSensitivity", lookSensitivity);
            SetPrivateField(config, "m_pitchLimitDown", 85f);
            SetPrivateField(config, "m_pitchLimitUp", 85f);
            SetPrivateField(config, "m_lookSmoothTime", lookSmoothTime);

            playerObject = new GameObject("Player", typeof(PlayerInputReader), typeof(PlayerLook));

            Transform head = new GameObject("m_head").transform;
            head.SetParent(playerObject.transform, false);

            PlayerLook look = playerObject.GetComponent<PlayerLook>();
            SetPrivateField(look, "m_head", head);
            SetPrivateField(look, "m_config", config);
            SetPrivateField(look, "m_controlSettings", m_controlSettings);
            SetPrivateField(look, "m_lockCursor", false);

            if (track)
            {
                m_extraObjects.Add(playerObject);
            }

            return look;
        }

        private static void SetPrivateField(object target, string fieldName, object value)
        {
            FieldInfo field = target.GetType().GetField(fieldName, BindingFlags.NonPublic | BindingFlags.Instance);
            Assert.IsNotNull(field, $"Field '{fieldName}' not found on {target.GetType().Name}.");
            field.SetValue(target, value);
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
