using System.Collections;
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
    /// Regression guard for the ground-stick jitter: GroundedStickVelocity used to be large enough
    /// (-2) that the CharacterController visibly bounced against the ground every idle frame.
    /// </summary>
    public class FirstPersonControllerTests : InputTestFixture
    {
        private const float k_RestingPivotY = 1f; // height 2, radius 0.5, center 0 -> rests one half-height up

        private GameObject m_ground;
        private GameObject m_playerObject;

        public override void Setup()
        {
            base.Setup();

            m_ground = GameObject.CreatePrimitive(PrimitiveType.Cube);
            m_ground.transform.position = new Vector3(0f, -5f, 0f);
            m_ground.transform.localScale = new Vector3(50f, 10f, 50f); // top surface at world y = 0

            PlayerConfigSO config = ScriptableObject.CreateInstance<PlayerConfigSO>();
            SetPrivateField(config, "m_walkSpeed", 2.6f);
            SetPrivateField(config, "m_sprintSpeed", 4.4f);
            SetPrivateField(config, "m_acceleration", 18f);
            SetPrivateField(config, "m_deceleration", 24f);
            SetPrivateField(config, "m_gravity", -19.6f);
            SetPrivateField(config, "m_groundedStickVelocity", -0.2f);
            SetPrivateField(config, "m_groundCheckRadiusScale", 0.9f);
            SetPrivateField(config, "m_groundCheckDistance", 0.15f);
            SetPrivateField(config, "m_groundLayers", (LayerMask)~0);

            m_playerObject = new GameObject(
                "Player", typeof(CharacterController), typeof(PlayerInputReader), typeof(FirstPersonController));
            m_playerObject.transform.position = new Vector3(0f, k_RestingPivotY + 0.05f, 0f);

            FirstPersonController controller = m_playerObject.GetComponent<FirstPersonController>();
            SetPrivateField(controller, "m_config", config);
        }

        public override void TearDown()
        {
            if (m_playerObject != null)
            {
                Object.Destroy(m_playerObject);
            }

            if (m_ground != null)
            {
                Object.Destroy(m_ground);
            }

            base.TearDown();
        }

        [UnityTest]
        public IEnumerator Update_IdleWhileGrounded_YPositionDoesNotOscillate()
        {
            // Let the controller fall the last few centimetres and settle before measuring.
            for (int i = 0; i < 30; i++)
            {
                yield return null;
            }

            float maxFrameDelta = 0f;
            float previousY = m_playerObject.transform.position.y;

            for (int i = 0; i < 30; i++)
            {
                yield return null;

                float currentY = m_playerObject.transform.position.y;
                maxFrameDelta = Mathf.Max(maxFrameDelta, Mathf.Abs(currentY - previousY));
                previousY = currentY;
            }

            Assert.Less(maxFrameDelta, 0.02f,
                "Standing still and grounded, per-frame Y movement should be imperceptible. A large "
                + "value means GroundedStickVelocity pushes the capsule into the ground hard enough "
                + "for collision resolution to visibly bounce it back out — the camera jitter bug.");
        }

        private static void SetPrivateField(object target, string fieldName, object value)
        {
            FieldInfo field = target.GetType().GetField(fieldName, BindingFlags.NonPublic | BindingFlags.Instance);
            Assert.IsNotNull(field, $"Field '{fieldName}' not found on {target.GetType().Name}.");
            field.SetValue(target, value);
        }
    }
}
