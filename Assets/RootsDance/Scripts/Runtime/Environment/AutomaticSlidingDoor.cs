using System.Collections.Generic;
using RootsDance.Player;
using UnityEngine;

namespace RootsDance.Environment
{
    /// <summary>
    /// Opens a pair of door leaves away from their centre seam while a player trigger probe is nearby.
    /// </summary>
    [DisallowMultipleComponent]
    [RequireComponent(typeof(BoxCollider))]
    public sealed class AutomaticSlidingDoor : MonoBehaviour
    {
        [Header("Door Leaves")]
        [SerializeField] private Transform m_leftLeaf;
        [SerializeField] private Transform m_rightLeaf;

        [Header("Motion")]
        [Min(0f)]
        [SerializeField] private float m_openDistance = 2.5f;

        [Min(0.01f)]
        [SerializeField] private float m_speed = 2.2f;

        private readonly HashSet<PlayerTriggerProbe> m_occupants = new HashSet<PlayerTriggerProbe>();
        private Vector3 m_leftClosedPosition;
        private Vector3 m_rightClosedPosition;

        private void Awake()
        {
            CacheClosedPositions();
        }

        private void Update()
        {
            if (m_leftLeaf == null || m_rightLeaf == null)
            {
                return;
            }

            bool shouldOpen = m_occupants.Count > 0;
            Vector3 leftTarget = m_leftClosedPosition + Vector3.left * (shouldOpen ? m_openDistance : 0f);
            Vector3 rightTarget = m_rightClosedPosition + Vector3.right * (shouldOpen ? m_openDistance : 0f);
            float step = m_speed * Time.deltaTime;
            m_leftLeaf.localPosition = Vector3.MoveTowards(m_leftLeaf.localPosition, leftTarget, step);
            m_rightLeaf.localPosition = Vector3.MoveTowards(m_rightLeaf.localPosition, rightTarget, step);
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
        }

        private void Reset()
        {
            BoxCollider trigger = GetComponent<BoxCollider>();
            trigger.isTrigger = true;
        }

        private void OnValidate()
        {
            m_openDistance = Mathf.Max(0f, m_openDistance);
            m_speed = Mathf.Max(0.01f, m_speed);
            BoxCollider trigger = GetComponent<BoxCollider>();

            if (trigger != null)
            {
                trigger.isTrigger = true;
            }
        }

        public void Configure(Transform leftLeaf, Transform rightLeaf, float openDistance, float speed)
        {
            m_leftLeaf = leftLeaf;
            m_rightLeaf = rightLeaf;
            m_openDistance = Mathf.Max(0f, openDistance);
            m_speed = Mathf.Max(0.01f, speed);
            CacheClosedPositions();
        }

        private void CacheClosedPositions()
        {
            if (m_leftLeaf != null)
            {
                m_leftClosedPosition = m_leftLeaf.localPosition;
            }

            if (m_rightLeaf != null)
            {
                m_rightClosedPosition = m_rightLeaf.localPosition;
            }
        }
    }
}
