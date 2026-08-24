using UnityEngine;

namespace RootsDance.Data
{
    /// <summary>
    /// Every first-person feel value. Tuning happens in this asset, never on the scene component,
    /// so a designer can retune without opening a scene.
    /// </summary>
    [CreateAssetMenu(fileName = "PlayerConfig", menuName = "RootsDance/Config/Player")]
    public class PlayerConfigSO : ScriptableObject
    {
        [Header("Movement")]
        [Tooltip("Metres per second at full walk input.")]
        [SerializeField] private float m_walkSpeed = 2.6f;

        [Tooltip("Metres per second while the sprint action is held.")]
        [SerializeField] private float m_sprintSpeed = 4.4f;

        [Tooltip("How fast the horizontal velocity reaches the target speed, in metres per second squared.")]
        [SerializeField] private float m_acceleration = 18f;

        [Tooltip("How fast the horizontal velocity decays to zero when there is no input.")]
        [SerializeField] private float m_deceleration = 24f;

        [Header("Gravity")]
        [Tooltip("Downward acceleration in metres per second squared. Negative.")]
        [SerializeField] private float m_gravity = -19.6f;

        [Tooltip("Downward velocity kept while grounded so the controller stays glued to slopes.")]
        [SerializeField] private float m_groundedStickVelocity = -2f;

        [Tooltip("Radius of the sphere used for the ground check, relative to the controller radius.")]
        [Range(0.1f, 1f)]
        [SerializeField] private float m_groundCheckRadiusScale = 0.9f;

        [Tooltip("How far below the controller's feet the ground check reaches, in metres.")]
        [SerializeField] private float m_groundCheckDistance = 0.15f;

        [Tooltip("Layers that count as walkable ground.")]
        [SerializeField] private LayerMask m_groundLayers = ~0;

        [Header("Look")]
        [Tooltip("Degrees of pitch/yaw per unit of look input.")]
        [SerializeField] private float m_lookSensitivity = 0.12f;

        [Tooltip("Pitch clamp in degrees, applied symmetrically up and down.")]
        [Range(20f, 89f)]
        [SerializeField] private float m_pitchLimit = 85f;

        [Tooltip("Exponential smoothing time, in seconds, applied to raw mouse look input. A mouse "
            + "reports movement at its own polling rate, not the render frame rate, so the raw "
            + "per-frame delta arrives in an uneven stair-step; this removes it without adding "
            + "perceptible input lag. 0 disables smoothing.")]
        [SerializeField] private float m_lookSmoothTime = 0.03f;

        public float WalkSpeed => m_walkSpeed;
        public float SprintSpeed => m_sprintSpeed;
        public float Acceleration => m_acceleration;
        public float Deceleration => m_deceleration;
        public float Gravity => m_gravity;
        public float GroundedStickVelocity => m_groundedStickVelocity;
        public float GroundCheckRadiusScale => m_groundCheckRadiusScale;
        public float GroundCheckDistance => m_groundCheckDistance;
        public LayerMask GroundLayers => m_groundLayers;
        public float LookSensitivity => m_lookSensitivity;
        public float PitchLimit => m_pitchLimit;
        public float LookSmoothTime => m_lookSmoothTime;
    }
}
