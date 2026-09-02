using System.Collections.Generic;
using RootsDance.Player;
using UnityEngine;

namespace RootsDance.Environment
{
    /// <summary>
    /// A pair of hinged leaves that swing outward while a player trigger probe is nearby, and swing
    /// shut again once nobody is left standing in the trigger.
    /// </summary>
    [DisallowMultipleComponent]
    [RequireComponent(typeof(BoxCollider))]
    public sealed class SwingingDoor : MonoBehaviour
    {
        [Header("Hinges")]
        [SerializeField] private Transform m_leftHinge;
        [SerializeField] private Transform m_rightHinge;

        [Header("Motion")]
        [SerializeField] private float m_openAngle = 100f;

        [Min(0.01f)]
        [SerializeField] private float m_speedDegreesPerSecond = 120f;

        private readonly HashSet<PlayerTriggerProbe> m_occupants = new HashSet<PlayerTriggerProbe>();
        private Quaternion m_leftClosedRotation;
        private Quaternion m_rightClosedRotation;
        private bool m_isOpen;

        private void Awake()
        {
            CacheClosedRotations();
        }

        private void Update()
        {
            if (m_leftHinge == null || m_rightHinge == null)
            {
                return;
            }

            m_isOpen = m_occupants.Count > 0;

            float leftTargetAngle = m_isOpen ? -m_openAngle : 0f;
            float rightTargetAngle = m_isOpen ? m_openAngle : 0f;
            float step = m_speedDegreesPerSecond * Time.deltaTime;

            m_leftHinge.localRotation = Quaternion.RotateTowards(
                m_leftHinge.localRotation,
                m_leftClosedRotation * Quaternion.Euler(0f, leftTargetAngle, 0f),
                step);

            m_rightHinge.localRotation = Quaternion.RotateTowards(
                m_rightHinge.localRotation,
                m_rightClosedRotation * Quaternion.Euler(0f, rightTargetAngle, 0f),
                step);
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
            m_isOpen = false;

            if (m_leftHinge != null)
            {
                m_leftHinge.localRotation = m_leftClosedRotation;
            }

            if (m_rightHinge != null)
            {
                m_rightHinge.localRotation = m_rightClosedRotation;
            }
        }

        private void Reset()
        {
            BoxCollider trigger = GetComponent<BoxCollider>();
            trigger.isTrigger = true;
        }

        private void OnValidate()
        {
            m_openAngle = Mathf.Clamp(m_openAngle, 0f, 170f);
            m_speedDegreesPerSecond = Mathf.Max(0.01f, m_speedDegreesPerSecond);
            BoxCollider trigger = GetComponent<BoxCollider>();

            if (trigger != null)
            {
                trigger.isTrigger = true;
            }
        }

        public void Configure(Transform leftHinge, Transform rightHinge, float openAngle, float speedDegreesPerSecond)
        {
            m_leftHinge = leftHinge;
            m_rightHinge = rightHinge;
            m_openAngle = Mathf.Clamp(openAngle, 0f, 170f);
            m_speedDegreesPerSecond = Mathf.Max(0.01f, speedDegreesPerSecond);
            CacheClosedRotations();
        }

        private void CacheClosedRotations()
        {
            if (m_leftHinge != null)
            {
                m_leftClosedRotation = m_leftHinge.localRotation;
            }

            if (m_rightHinge != null)
            {
                m_rightClosedRotation = m_rightHinge.localRotation;
            }
        }
    }
}
