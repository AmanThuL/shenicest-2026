using Sirenix.OdinInspector;
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
        [SerializeField, TitleGroup("Movement")]
        [Tooltip("Metres per second at full walk input.")]
        private float m_walkSpeed = 2.6f;

        [SerializeField, TitleGroup("Movement")]
        [Tooltip("Metres per second while the sprint action is held.")]
        private float m_sprintSpeed = 4.4f;

        [SerializeField, TitleGroup("Movement")]
        [Tooltip("How fast the horizontal velocity reaches the target speed, in metres per second squared.")]
        private float m_acceleration = 18f;

        [SerializeField, TitleGroup("Movement")]
        [Tooltip("How fast the horizontal velocity decays to zero when there is no input.")]
        private float m_deceleration = 24f;

        [SerializeField, TitleGroup("Gravity")]
        [Tooltip("Downward acceleration in metres per second squared. Negative.")]
        private float m_gravity = -19.6f;

        [SerializeField, TitleGroup("Gravity")]
        [Tooltip("Fastest the player can fall, in metres per second. This is what keeps the "
            + "greenhouse drop readable: gravity sets how fast a fall starts, this caps where it "
            + "ends. A human's real terminal velocity is far higher, but past about 12 m/s a "
            + "first-person fall reads as a cut, not a fall.")]
        private float m_maxFallSpeed = 11f;

        [SerializeField, TitleGroup("Gravity")]
        [Tooltip("Downward velocity kept while grounded so the controller stays glued to slopes.")]
        private float m_groundedStickVelocity = -2f;

        [SerializeField, TitleGroup("Gravity"), Range(0.1f, 1f)]
        [Tooltip("Radius of the sphere used for the ground check, relative to the controller radius.")]
        private float m_groundCheckRadiusScale = 0.9f;

        [SerializeField, TitleGroup("Gravity")]
        [Tooltip("How far below the controller's feet the ground check reaches, in metres.")]
        private float m_groundCheckDistance = 0.15f;

        [SerializeField, TitleGroup("Gravity")]
        [Tooltip("Layers that count as walkable ground.")]
        private LayerMask m_groundLayers = ~0;

        [SerializeField, TitleGroup("Look")]
        [Tooltip("Degrees of pitch/yaw per unit of pointer-delta input.")]
        private float m_lookSensitivity = 0.12f;

        [SerializeField, TitleGroup("Look")]
        [Tooltip("Degrees per second at full gamepad-stick deflection.")]
        private float m_gamepadLookSpeed = 180f;

        [SerializeField, TitleGroup("Look")]
        [Tooltip("Degrees of pitch/yaw per unit of two-finger trackpad scroll.")]
        private float m_trackpadLookSensitivity = 0.1f;

        [SerializeField, TitleGroup("Look"), Range(20f, 90f)]
        [Tooltip("How far down the camera can pitch, in degrees from level.")]
        private float m_pitchLimitDown = 25f;

        [SerializeField, TitleGroup("Look"), Range(20f, 90f)]
        [Tooltip("How far up the camera can pitch, in degrees from level.")]
        private float m_pitchLimitUp = 80f;

        [SerializeField, TitleGroup("Look")]
        [Tooltip("Exponential smoothing time, in seconds, applied to raw mouse look input. A mouse "
            + "reports movement at its own polling rate, not the render frame rate, so the raw "
            + "per-frame delta arrives in an uneven stair-step; this removes it without adding "
            + "perceptible input lag. 0 disables smoothing.")]
        private float m_lookSmoothTime;

        public float WalkSpeed => m_walkSpeed;
        public float SprintSpeed => m_sprintSpeed;
        public float Acceleration => m_acceleration;
        public float Deceleration => m_deceleration;
        public float Gravity => m_gravity;
        public float MaxFallSpeed => m_maxFallSpeed;
        public float GroundedStickVelocity => m_groundedStickVelocity;
        public float GroundCheckRadiusScale => m_groundCheckRadiusScale;
        public float GroundCheckDistance => m_groundCheckDistance;
        public LayerMask GroundLayers => m_groundLayers;
        public float LookSensitivity => m_lookSensitivity;
        public float GamepadLookSpeed => m_gamepadLookSpeed;
        public float TrackpadLookSensitivity => m_trackpadLookSensitivity;
        public float PitchLimitDown => m_pitchLimitDown;
        public float PitchLimitUp => m_pitchLimitUp;
        public float LookSmoothTime => m_lookSmoothTime;
    }
}
