using UnityEngine;
using UnityEngine.Rendering;

namespace RootsDance.Environment
{
    /// <summary>
    /// Drives the greenhouse's ending look from the statue's growth: the bloom Volume fades up and
    /// the sun warms and brightens as the ecology comes back.
    /// <para>
    /// The sun's <em>colour</em> matters as much as its intensity. The reference is late, low sun
    /// raking across pale tile: the lit faces go peach, the faces the sun misses stay a cool grey
    /// green. That split is what reads as sunset — a global warm grade cannot produce it, because a
    /// grade lifts the shadows with everything else. So the warmth is carried here, on the one
    /// directional light, and the cool is left to the sky and fog in the bloom profile.
    /// </para>
    /// <para>
    /// Both endpoints are serialized rather than constant because the ending is tuned by eye. The
    /// defaults are the authored look; a scene that has never stored these fields picks them up on
    /// deserialization, so retuning needs no rebuild.
    /// </para>
    /// </summary>
    [DisallowMultipleComponent]
    public sealed class GreenhouseBloomAtmosphere : MonoBehaviour
    {
        [SerializeField] private GrowthDriver m_growthDriver;
        [SerializeField] private Volume m_bloomVolume;
        [SerializeField] private Light m_sun;
        [SerializeField] private float m_initialSunLux = 65000f;
        [SerializeField] private float m_bloomSunLux = 125000f;

        [Tooltip("Sun filter colour before the statue blooms. Neutral: the interior reads as overcast.")]
        [SerializeField] private Color m_initialSunColor = Color.white;

        [Tooltip("Sun filter colour at full bloom. Roughly 3300 K — the peach that lit tile takes on.")]
        [SerializeField] private Color m_bloomSunColor = new Color(1f, 0.72f, 0.52f, 1f);

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
                m_sun.color = Color.Lerp(m_initialSunColor, m_bloomSunColor, progress);
            }
        }
    }
}
