using UnityEngine;

namespace RootsDance.UI
{
    /// <summary>
    /// Adds restrained, unscaled-time movement to the menu's authored camera pose.
    /// </summary>
    public class MainMenuCameraDrift : MonoBehaviour
    {
        private const float k_HorizontalAmplitude = 0.035f;
        private const float k_VerticalAmplitude = 0.025f;
        private const float k_PitchAmplitude = 0.12f;
        private const float k_YawAmplitude = 0.18f;

        private Vector3 m_basePosition;
        private Quaternion m_baseRotation;

        private void OnEnable()
        {
            m_basePosition = transform.position;
            m_baseRotation = transform.rotation;
        }

        private void Update()
        {
            float time = Time.unscaledTime;
            Vector3 localOffset = new Vector3(
                Mathf.Sin(time * 0.11f) * k_HorizontalAmplitude,
                Mathf.Sin((time * 0.17f) + 1.3f) * k_VerticalAmplitude,
                0f);
            Quaternion localRotation = Quaternion.Euler(
                Mathf.Sin((time * 0.13f) + 0.7f) * k_PitchAmplitude,
                Mathf.Sin(time * 0.09f) * k_YawAmplitude,
                0f);

            transform.SetPositionAndRotation(
                m_basePosition + (m_baseRotation * localOffset),
                m_baseRotation * localRotation);
        }

        private void OnDisable()
        {
            transform.SetPositionAndRotation(m_basePosition, m_baseRotation);
        }
    }
}
