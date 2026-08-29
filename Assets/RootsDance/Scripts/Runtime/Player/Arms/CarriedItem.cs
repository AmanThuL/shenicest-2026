using UnityEngine;

namespace RootsDance.Player.Arms
{
    /// <summary>
    /// A prop that can be picked up, held and dropped: the scanner, the helmet once it comes off,
    /// anything gathered off the ground. Carries its own grip offset so a
    /// <see cref="HandSocket"/> stays generic — the socket knows where the hand is, the item knows
    /// how it sits in that hand.
    /// </summary>
    [DisallowMultipleComponent]
    public class CarriedItem : MonoBehaviour
    {
        [Tooltip("Which hand this item is meant for.")]
        [SerializeField] private HandSide m_hand = HandSide.Right;

        [Tooltip("What this is, for systems that care which prop is in the hand — a torch lights "
            + "the beam whichever of the ones lying around the level it happens to be.")]
        [SerializeField] private CarriedKind m_kind = CarriedKind.Prop;

        [Tooltip("Grip position relative to the socket, in metres.")]
        [SerializeField] private Vector3 m_gripPosition;

        [Tooltip("Grip orientation relative to the socket.")]
        [SerializeField] private Quaternion m_gripRotation = Quaternion.identity;

        [Tooltip("Rigidbody suspended while carried. Optional — a prop with no physics is fine.")]
        [SerializeField] private Rigidbody m_body;

        [Tooltip("Colliders disabled while carried, so a held prop cannot shove the player.")]
        [SerializeField] private Collider[] m_colliders;

        public HandSide Hand => m_hand;

        public CarriedKind Kind => m_kind;

        public Vector3 GripPosition => m_gripPosition;
        public Quaternion GripRotation => m_gripRotation;

        private void Reset()
        {
            m_body = GetComponentInChildren<Rigidbody>();
            m_colliders = GetComponentsInChildren<Collider>();
        }

        /// <summary>Physics off; the socket takes over the transform from here.</summary>
        public void EnterCarried()
        {
            if (m_body != null)
            {
                m_body.linearVelocity = Vector3.zero;
                m_body.angularVelocity = Vector3.zero;
                m_body.isKinematic = true;
            }

            SetCollidersEnabled(false);
        }

        /// <summary>
        /// Physics back on, inheriting the hand's motion so a dropped prop carries on along the arc
        /// the hand was already describing instead of falling straight down.
        /// </summary>
        public void ExitCarried(Vector3 velocity, Vector3 angularVelocity)
        {
            SetCollidersEnabled(true);

            if (m_body == null)
            {
                return;
            }

            m_body.isKinematic = false;
            m_body.linearVelocity = velocity;
            m_body.angularVelocity = angularVelocity;
        }

        private void SetCollidersEnabled(bool enabled)
        {
            if (m_colliders == null)
            {
                return;
            }

            for (int i = 0; i < m_colliders.Length; i++)
            {
                if (m_colliders[i] != null)
                {
                    m_colliders[i].enabled = enabled;
                }
            }
        }
    }
}
