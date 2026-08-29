using RootsDance.Data;
using UnityEngine;

namespace RootsDance.Player
{
    /// <summary>
    /// Walking on a CharacterController with hand-integrated gravity. No Rigidbody: this character
    /// is never pushed by physics, and mixing the two on one object is a project rule violation.
    /// </summary>
    [RequireComponent(typeof(CharacterController), typeof(PlayerInputReader))]
    public class FirstPersonController : MonoBehaviour
    {
        [SerializeField] private PlayerConfigSO m_config;

        private CharacterController m_controller;
        private PlayerInputReader m_input;
        private Vector3 m_horizontalVelocity;
        private float m_verticalVelocity;
        private bool m_isGrounded;

        public bool IsGrounded => m_isGrounded;

        /// <summary>Metres per second on the ground plane; drives head bob and footstep cadence.</summary>
        public float HorizontalSpeed => m_horizontalVelocity.magnitude;

        /// <summary>Metres per second along Y, negative while falling; drives the free-fall camera.</summary>
        public float VerticalVelocity => m_verticalVelocity;

        private void Awake()
        {
            m_controller = GetComponent<CharacterController>();
            m_input = GetComponent<PlayerInputReader>();
        }

        private void Update()
        {
            if (m_config == null)
            {
                return;
            }

            float deltaTime = Time.deltaTime;

            UpdateGrounded();
            UpdateHorizontalVelocity(deltaTime);
            UpdateVerticalVelocity(deltaTime);

            Vector3 motion = m_horizontalVelocity;
            motion.y = m_verticalVelocity;
            m_controller.Move(motion * deltaTime);
        }

        private void UpdateGrounded()
        {
            // CharacterController.isGrounded is unreliable on the frame after a move; a sphere cast
            // just below the capsule is stable and lets us pick the layers that count as ground.
            Vector3 origin = transform.TransformPoint(m_controller.center)
                + Vector3.down * (m_controller.height * 0.5f - m_controller.radius);
            float radius = m_controller.radius * m_config.GroundCheckRadiusScale;

            m_isGrounded = Physics.CheckSphere(
                origin + Vector3.down * m_config.GroundCheckDistance,
                radius,
                m_config.GroundLayers,
                QueryTriggerInteraction.Ignore);
        }

        private void UpdateHorizontalVelocity(float deltaTime)
        {
            Vector2 input = Vector2.ClampMagnitude(m_input.MoveInput, 1f);
            Vector3 wish = transform.right * input.x + transform.forward * input.y;

            float targetSpeed = m_input.IsSprinting ? m_config.SprintSpeed : m_config.WalkSpeed;
            Vector3 target = wish * targetSpeed;

            float rate = input.sqrMagnitude > 0.0001f ? m_config.Acceleration : m_config.Deceleration;
            m_horizontalVelocity = Vector3.MoveTowards(m_horizontalVelocity, target, rate * deltaTime);
        }

        private void UpdateVerticalVelocity(float deltaTime)
        {
            if (m_isGrounded && m_verticalVelocity <= 0f)
            {
                // A small downward bias keeps the capsule glued to slopes and steps.
                m_verticalVelocity = m_config.GroundedStickVelocity;
                return;
            }

            m_verticalVelocity += m_config.Gravity * deltaTime;

            // Terminal velocity. Without a cap a long drop keeps accelerating and reads as being
            // thrown at the floor; a real body stops accelerating once drag balances gravity.
            m_verticalVelocity = Mathf.Max(m_verticalVelocity, -m_config.MaxFallSpeed);
        }
    }
}
