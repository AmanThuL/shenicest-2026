using RootsDance.Core;
using RootsDance.Player.Arms;
using UnityEngine;

namespace RootsDance.Interaction
{
    /// <summary>
    /// Carries a thrown prop from the hand to a <see cref="ThrowTarget"/> along a real ballistic
    /// arc, and breaks it there.
    /// <para>
    /// The arc is solved rather than simulated, and that is the point. Letting the released prop
    /// fall to <see cref="Rigidbody"/> physics with the hand's own velocity — which is what
    /// <see cref="HandSocket.Detach"/> hands it, and what a dropped torch wants — throws it
    /// wherever the animation happened to be pointing, and the lab is full of glassware and iron
    /// stands for it to clip a corner off on the way. Here the flight time comes from the distance
    /// and the launch velocity comes from the flight time, so the prop leaves the hand on a curve
    /// that looks thrown and lands on the rune every single time. A story beat that fails one
    /// throw in five is not a beat.
    /// </para>
    /// <para>
    /// Kinematic for the whole flight, colliders off: nothing it passes can deflect it, and it
    /// cannot shove the player on the way past. The prop is destroyed on impact, so it never needs
    /// its physics back.
    /// </para>
    /// </summary>
    [DisallowMultipleComponent]
    [RequireComponent(typeof(CarriedItem))]
    public class ThrownItemFlight : MonoBehaviour
    {
        [Tooltip("Metres per second across the ground. The flight time is the horizontal distance "
            + "divided by this, so a longer throw takes longer rather than going faster.")]
        [Range(1f, 30f)]
        [SerializeField] private float m_horizontalSpeed = 9f;

        [Tooltip("Shortest flight, in seconds. Guards the arc solve against a throw at arm's "
            + "length, where a tiny time would ask for an enormous launch velocity.")]
        [Range(0.05f, 2f)]
        [SerializeField] private float m_minFlightSeconds = 0.25f;

        [Tooltip("Longest flight, in seconds.")]
        [Range(0.2f, 6f)]
        [SerializeField] private float m_maxFlightSeconds = 2f;

        [Tooltip("Downward acceleration for the arc, in m/s². The scene's own gravity by default; "
            + "raise it for a flatter, harder-looking throw.")]
        [SerializeField] private float m_gravity = 9.81f;

        [Tooltip("Degrees per second the prop tumbles at while it is in the air, in its own axes.")]
        [SerializeField] private Vector3 m_spinDegreesPerSecond = new Vector3(180f, 90f, 420f);

        private CarriedItem m_item;
        private ThrowTarget m_target;
        private Vector3 m_origin;
        private Vector3 m_launchVelocity;
        private float m_elapsed;
        private float m_duration;
        private bool m_isFlying;

        /// <summary>True between leaving the hand and breaking.</summary>
        public bool IsFlying => m_isFlying;

        private void Awake()
        {
            m_item = GetComponent<CarriedItem>();
        }

        /// <summary>
        /// Sends this prop at <paramref name="target"/> from wherever it is right now. Called on
        /// the frame the throw animation opens the hand.
        /// </summary>
        public void Launch(ThrowTarget target)
        {
            if (target == null)
            {
                Log.Warning($"ThrownItemFlight on '{name}' was launched at nothing.", this);
                return;
            }

            m_target = target;
            m_origin = transform.position;

            Vector3 impact = target.ImpactPosition;
            Vector3 delta = impact - m_origin;
            float horizontal = new Vector2(delta.x, delta.z).magnitude;

            m_duration = Mathf.Clamp(
                horizontal / Mathf.Max(m_horizontalSpeed, 0.01f),
                m_minFlightSeconds,
                m_maxFlightSeconds);

            // The launch velocity that puts a body under constant gravity exactly on the impact
            // point after m_duration seconds: p1 = p0 + v0·t + ½·g·t², solved for v0.
            Vector3 gravity = Vector3.down * m_gravity;
            m_launchVelocity = (delta - 0.5f * gravity * (m_duration * m_duration)) / m_duration;

            m_elapsed = 0f;
            m_isFlying = true;

            // Physics off and colliders off, the same state the prop is in while it is held. The
            // socket has already handed it back to physics by the time this runs, so this takes it
            // away again rather than preventing it.
            if (m_item != null)
            {
                m_item.EnterCarried();
            }
        }

        private void Update()
        {
            if (!m_isFlying)
            {
                return;
            }

            m_elapsed += Time.deltaTime;
            float t = Mathf.Min(m_elapsed, m_duration);
            Vector3 gravity = Vector3.down * m_gravity;

            transform.position = m_origin + m_launchVelocity * t + 0.5f * gravity * (t * t);
            transform.Rotate(m_spinDegreesPerSecond * Time.deltaTime, Space.Self);

            if (m_elapsed < m_duration)
            {
                return;
            }

            // Cleared before Shatter, which destroys this object: nothing here may run again.
            m_isFlying = false;
            ThrowTarget target = m_target;
            m_target = null;
            target.Shatter(gameObject);
        }

        private void OnValidate()
        {
            m_maxFlightSeconds = Mathf.Max(m_maxFlightSeconds, m_minFlightSeconds);
        }
    }
}
