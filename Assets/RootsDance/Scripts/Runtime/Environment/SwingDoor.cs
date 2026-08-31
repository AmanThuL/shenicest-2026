using System.Collections.Generic;
using RootsDance.Player;
using UnityEngine;

namespace RootsDance.Environment
{
    /// <summary>
    /// Swings a single hinged leaf open while a player trigger probe is inside this object's own
    /// trigger, and lets it swing back shut once the last one leaves.
    /// <para>
    /// The root holds the trigger; <see cref="m_leaf"/> is the thing that actually rotates, because
    /// the leaf's pivot has to sit exactly on the hinge edge (its local position is the hinge) while
    /// the trigger volume covers the whole approach, not just the leaf's footprint — one transform
    /// cannot be both.
    /// </para>
    /// </summary>
    [DisallowMultipleComponent]
    [RequireComponent(typeof(BoxCollider))]
    public sealed class SwingDoor : MonoBehaviour
    {
        [SerializeField] private Transform m_leaf;

        [Tooltip("Degrees around the leaf's local Y axis. Sign picks which way it swings — "
            + "flip it in the Inspector if the door opens into a wall.")]
        [SerializeField] private float m_openAngle = 100f;

        [Min(1f)]
        [SerializeField] private float m_degreesPerSecond = 140f;

        private readonly HashSet<PlayerTriggerProbe> m_occupants = new HashSet<PlayerTriggerProbe>();
        private Quaternion m_closedRotation;
        private Quaternion m_openRotation;

        private void Awake()
        {
            CacheRotations();
        }

        private void Update()
        {
            if (m_leaf == null)
            {
                return;
            }

            Quaternion target = m_occupants.Count > 0 ? m_openRotation : m_closedRotation;
            m_leaf.localRotation = Quaternion.RotateTowards(
                m_leaf.localRotation, target, m_degreesPerSecond * Time.deltaTime);
        }

        private void OnTriggerEnter(Collider other)
        {
            PlayerTriggerProbe probe = other.GetComponentInParent<PlayerTriggerProbe>();

            if (probe != null)
            {
                m_occupants.Add(probe);
            }
        }

        private void OnTriggerExit(Collider other)
        {
            PlayerTriggerProbe probe = other.GetComponentInParent<PlayerTriggerProbe>();

            if (probe != null)
            {
                m_occupants.Remove(probe);
            }
        }

        private void OnDisable()
        {
            m_occupants.Clear();

            if (m_leaf != null)
            {
                m_leaf.localRotation = m_closedRotation;
            }
        }

        private void Reset()
        {
            BoxCollider trigger = GetComponent<BoxCollider>();
            trigger.isTrigger = true;
        }

        private void OnValidate()
        {
            m_degreesPerSecond = Mathf.Max(1f, m_degreesPerSecond);
        }

        public void Configure(Transform leaf, float openAngle, float degreesPerSecond)
        {
            m_leaf = leaf;
            m_openAngle = openAngle;
            m_degreesPerSecond = Mathf.Max(1f, degreesPerSecond);
            CacheRotations();
        }

        private void CacheRotations()
        {
            if (m_leaf == null)
            {
                return;
            }

            m_closedRotation = m_leaf.localRotation;
            m_openRotation = m_closedRotation * Quaternion.Euler(0f, m_openAngle, 0f);
        }
    }
}
