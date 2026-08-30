using RootsDance.Core;
using UnityEngine;

namespace RootsDance.Player.Arms
{
    /// <summary>
    /// Rides one hand bone of the arms rig and carries whatever that hand is holding.
    /// <para>
    /// It tracks the bone's world position and rotation but deliberately never writes a scale.
    /// The reason is specific: the imported rig's bones carry a decomposed local scale of about
    /// 100 (Blender's metre-to-centimetre factor baked into the node transforms, cancelled again by
    /// the importer's 0.01 file scale). Bone positions and rotations import correctly, so tracking
    /// those is safe — but a prop parented into that hierarchy inherits the ~100 as a real scale.
    /// The component this replaces assigned an intended <em>world</em> scale to
    /// <c>transform.localScale</c>, which under a bone at lossy scale 100 rendered the scanner
    /// roughly a hundred times too large. A held prop's size belongs to its own prefab; nothing
    /// here scales it.
    /// </para>
    /// Place the socket outside the imported model hierarchy so its own parent is unscaled.
    /// </summary>
    [ExecuteAlways]
    [DisallowMultipleComponent]
    public class HandSocket : MonoBehaviour
    {
        [Tooltip("Which hand this socket is. Only used for logging and inspector clarity.")]
        [SerializeField] private HandSide m_hand = HandSide.Right;

        [Tooltip("The hand.L / hand.R bone this socket rides.")]
        [SerializeField] private Transform m_handBone;

        [Tooltip("Grip offset from the bone origin, in the bone's own rotated axes, in metres.")]
        [SerializeField] private Vector3 m_holdPositionOffset;

        [Tooltip("Grip orientation relative to the bone's own rotation.")]
        [SerializeField] private Quaternion m_holdRotationOffset = Quaternion.identity;

        [Tooltip("Item the next Attach hand event will take hold of. Gameplay sets this before "
            + "asking for the pick-up animation.")]
        [SerializeField] private CarriedItem m_pending;

        private CarriedItem m_carried;
        private Vector3 m_previousPosition;
        private Quaternion m_previousRotation;
        private Vector3 m_velocity;
        private Vector3 m_angularVelocity;

        public HandSide Hand => m_hand;

        /// <summary>What the hand is holding, or null.</summary>
        public CarriedItem Carried => m_carried;

        public bool IsCarrying => m_carried != null;

        /// <summary>Queues the item the next Attach event should take. Does not move it yet.</summary>
        public void SetPending(CarriedItem item)
        {
            m_pending = item;
        }

        /// <summary>Takes the queued item into the hand. Called from an authored Attach moment.</summary>
        public void AttachPending()
        {
            if (m_pending == null)
            {
                return;
            }

            Attach(m_pending);
            m_pending = null;
        }

        /// <summary>Takes an item into the hand immediately.</summary>
        public void Attach(CarriedItem item)
        {
            if (item == null)
            {
                return;
            }

            if (m_carried != null)
            {
                Log.Warning($"HandSocket ({m_hand}) was given '{item.name}' while already holding "
                    + $"'{m_carried.name}'; the previous item was dropped.", this);
                Detach();
            }

            m_carried = item;
            item.EnterCarried();
            item.transform.SetParent(transform, false);
            item.transform.SetLocalPositionAndRotation(item.GripPosition, item.GripRotation);
        }

        /// <summary>Lets go. The item keeps the hand's current motion. Called from a Detach moment.</summary>
        public CarriedItem Detach()
        {
            if (m_carried == null)
            {
                return null;
            }

            CarriedItem item = m_carried;
            m_carried = null;
            item.transform.SetParent(null, true);
            item.ExitCarried(m_velocity, m_angularVelocity);
            return item;
        }

        private void LateUpdate()
        {
            if (m_handBone == null)
            {
                return;
            }

            Vector3 position = m_handBone.position + m_handBone.rotation * m_holdPositionOffset;
            Quaternion rotation = m_handBone.rotation * m_holdRotationOffset;

            MeasureMotion(position, rotation);
            transform.SetPositionAndRotation(position, rotation);
        }

        /// <summary>Keeps the hand's own velocity so a released prop inherits the throw.</summary>
        private void MeasureMotion(Vector3 position, Quaternion rotation)
        {
            float dt = Time.deltaTime;

            if (dt > 0f && Application.isPlaying)
            {
                m_velocity = (position - m_previousPosition) / dt;

                Quaternion delta = rotation * Quaternion.Inverse(m_previousRotation);
                delta.ToAngleAxis(out float angle, out Vector3 axis);

                if (angle > 180f)
                {
                    angle -= 360f;
                }

                m_angularVelocity = axis.sqrMagnitude < 0.0001f || float.IsInfinity(axis.x)
                    ? Vector3.zero
                    : axis.normalized * (angle * Mathf.Deg2Rad / dt);
            }

            m_previousPosition = position;
            m_previousRotation = rotation;
        }

        public void Configure(HandSide hand, Transform handBone, Vector3 holdPositionOffset,
            Quaternion holdRotationOffset)
        {
            m_hand = hand;
            m_handBone = handBone;
            m_holdPositionOffset = holdPositionOffset;
            m_holdRotationOffset = holdRotationOffset;
        }
    }
}
