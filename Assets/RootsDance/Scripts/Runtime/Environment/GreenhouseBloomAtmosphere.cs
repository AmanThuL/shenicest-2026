using UnityEngine;
using UnityEngine.Rendering;

namespace RootsDance.Environment
{
    [DisallowMultipleComponent]
    public sealed class GreenhouseBloomAtmosphere : MonoBehaviour
    {
        [SerializeField] private GrowthDriver m_growthDriver;
        [SerializeField] private Volume m_bloomVolume;
        [SerializeField] private Light m_sun;
        [SerializeField] private float m_initialSunLux = 65000f;
        [SerializeField] private float m_bloomSunLux = 100000f;

        private void OnEnable()
        {
            ApplyAtmosphere();
        }

        private void Update()
        {
            ApplyAtmosphere();
        }

        private void ApplyAtmosphere()
        {
            if (m_growthDriver == null)
            {
                return;
            }

            float progress = Mathf.Clamp01(m_growthDriver.Growth);

            if (m_bloomVolume != null)
            {
                m_bloomVolume.weight = progress;
            }

            if (m_sun != null)
            {
                m_sun.intensity = Mathf.Lerp(m_initialSunLux, m_bloomSunLux, progress);
            }
        }
    }
}
