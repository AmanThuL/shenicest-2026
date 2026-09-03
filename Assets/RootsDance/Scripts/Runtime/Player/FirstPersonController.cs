using RootsDance.Core;
using RootsDance.Data;
using UnityEngine;

namespace RootsDance.Player
{
    /// <summary>
    /// Walking on a CharacterController with hand-integrated gravity. No Rigidbody: this character
    /// is never pushed by physics, and mixing the two on one object is a project rule violation.
    /// </summary>
    [RequireComponent(typeof(CharacterController), typeof(PlayerInputReader))]
    public class FirstPersonController : MonoBehaviour, ICheckpointSpawnTarget
    {
        /// <summary>
        /// Degrees past the slope limit a contact may still count as ground. The controller itself
        /// walks up to the limit exactly; the tolerance only keeps a surface authored right at it
        /// from flickering between grounded and not.
        /// </summary>
        private const float k_SlopeToleranceDegrees = 1f;

        [SerializeField] private PlayerConfigSO m_config;

        private CharacterController m_controller;
        private PlayerInputReader m_input;
        private Vector3 m_horizontalVelocity;
        private float m_verticalVelocity;
        private bool m_isGrounded;
        private bool m_hasWalkableContactBelow;

        public bool IsGrounded => m_isGrounded;

        /// <summary>Metres per second on the ground plane; drives head bob and footstep cadence.</summary>
        public float HorizontalSpeed => m_horizontalVelocity.magnitude;

        /// <summary>Metres per second along Y, negative while falling; drives the free-fall camera.</summary>
        public float VerticalVelocity => m_verticalVelocity;
        public Transform SpawnTransform => transform;

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

            // Cleared right before the move so the flag only ever describes the contacts this
            // move made; OnControllerColliderHit fills it in while Move runs.
            m_hasWalkableContactBelow = false;
            m_controller.Move(motion * deltaTime);
        }

        /// <summary>
        /// Whether a surface with this normal can carry the player, by the controller's own slope
        /// limit. Pure so the rule is testable without a scene.
        /// </summary>
        public static bool IsWalkable(Vector3 normal, float slopeLimitDegrees)
        {
            return Vector3.Angle(normal, Vector3.up) <= slopeLimitDegrees + k_SlopeToleranceDegrees;
        }

        private void OnControllerColliderHit(ControllerColliderHit hit)
        {
            // Only contacts under the capsule count, and only walkable ones. The controller reports
            // CollisionFlags.Below for any touch on its lower half — including the side of a beam
            // it is perched on — and a perch is exactly what must not read as ground.
            if (hit.moveDirection.y <= 0f && IsWalkable(hit.normal, m_controller.slopeLimit))
            {
                m_hasWalkableContactBelow = true;
            }
        }

        public void ApplyCheckpoint(Vector3 position, float yaw)
        {
            bool wasEnabled = m_controller.enabled;
            m_controller.enabled = false;
            m_horizontalVelocity = Vector3.zero;
            m_verticalVelocity = 0f;
            m_isGrounded = false;
            transform.SetPositionAndRotation(position, Quaternion.Euler(0f, yaw, 0f));
            m_controller.enabled = wasEnabled;
            Physics.SyncTransforms();
        }

        private void UpdateGrounded()
        {
            // CharacterController.isGrounded is unreliable on the frame after a move; a sphere cast
            // just below the capsule is stable and lets us pick the layers that count as ground.
            Vector3 origin = transform.TransformPoint(m_controller.center)
                + Vector3.down * (m_controller.height * 0.5f - m_controller.radius);
            float radius = m_controller.radius * m_config.GroundCheckRadiusScale;

            bool sphereFoundGround = Physics.CheckSphere(
                origin + Vector3.down * m_config.GroundCheckDistance,
                radius,
                m_config.GroundLayers,
                QueryTriggerInteraction.Ignore);

            // ...but the sphere can still miss ground the capsule is demonstrably standing on: on
            // the main terrain it sits about 13 cm short, so the check said "falling" while the
            // capsule rested on the surface. Gravity then accumulated to Max Fall Speed and stayed
            // there, which reads to FreeFallView as an endless terminal-velocity drop and shakes
            // the view everywhere, forever, with the player standing still.
            //
            // A downward contact reported by the controller itself is proof of *something* under
            // the capsule — but not proof of ground. CollisionFlags.Below is raised by any touch on
            // the lower hemisphere, including the near-vertical side of a beam the capsule's edge
            // is resting against: after the greenhouse deck fell, the player stayed standing in
            // mid-air on the frame's edge, grounded by this flag, gravity reset every frame. So the
            // flag only counts when the move also touched a surface the slope limit allows, which
            // OnControllerColliderHit records; a perch then reads as airborne and Move slides off it.
            bool restingOnSomething = (m_controller.collisionFlags & CollisionFlags.Below) != 0
                && m_hasWalkableContactBelow;

            m_isGrounded = sphereFoundGround || restingOnSomething;
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
