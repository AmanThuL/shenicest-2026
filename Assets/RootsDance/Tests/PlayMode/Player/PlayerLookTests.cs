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
    /// Drives PlayerLook through the real Input System (device events, real action resolution)
    /// instead of unit-testing its math in isolation — the LookHold regression was an action-binding
    /// wiring bug, which a pure-logic test over rotation math would not have caught.
    /// </summary>
    public class PlayerLookTests : InputTestFixture
    {
        private Mouse m_mouse;
        private GameObject m_playerObject;
        private PlayerLook m_look;
        private readonly List<GameObject> m_extraObjects = new List<GameObject>();

        public override void Setup()
        {
            base.Setup();

            m_mouse = InputSystem.AddDevice<Mouse>();

            // No smoothing here: these two tests assert exact per-frame values, which only holds
            // when the raw delta passes straight through.
            m_look = CreatePlayer(lookSensitivity: 1f, lookSmoothTime: 0f, out m_playerObject);
        }

        public override void TearDown()
        {
            if (m_playerObject != null)
            {
                Object.Destroy(m_playerObject);
            }

            for (int i = 0; i < m_extraObjects.Count; i++)
            {
                if (m_extraObjects[i] != null)
                {
                    Object.Destroy(m_extraObjects[i]);
                }
            }

            m_extraObjects.Clear();
            base.TearDown();
        }

        [UnityTest]
        public IEnumerator Update_MouseDeltaWhileLookHoldPressed_RotatesYaw()
        {
            Press(m_mouse.rightButton);
            yield return null;

            Set(m_mouse.delta, new Vector2(10f, 0f));
            yield return null;

            Assert.AreEqual(10f, m_playerObject.transform.eulerAngles.y, 0.01f,
                "Holding LookHold and moving the mouse must rotate yaw by look.x degrees.");
        }

        [UnityTest]
        public IEnumerator Update_MouseDeltaWithoutLookHold_DoesNotRotateYaw()
        {
            yield return null;

            Set(m_mouse.delta, new Vector2(10f, 0f));
            yield return null;

            Assert.AreEqual(0f, m_playerObject.transform.eulerAngles.y, 0.01f,
                "Without LookHold pressed, mouse movement must not rotate yaw.");
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

            Press(m_mouse.rightButton);
            yield return null;

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
    }
}
