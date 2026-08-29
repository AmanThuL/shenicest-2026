using UnityEngine;

namespace RootsDance.Rendering
{
    /// <summary>Drives a full-screen texture offset while the corridor rune gate activates.</summary>
    [DisallowMultipleComponent]
    public sealed class GateFullscreenShake : MonoBehaviour
    {
        [Min(0.01f)]
        [SerializeField] private float m_riseDuration = 0.16f;

        [Min(0.01f)]
        [SerializeField] private float m_fallDuration = 0.2f;

        [Min(0f)]
        [SerializeField] private float m_amplitudePixels = 7f;

        [Min(0.01f)]
        [SerializeField] private float m_frequency = 18f;

        private static Vector2 s_offsetPixels;
        private static float s_strength;

        private float m_startedAt = float.NegativeInfinity;
        private float m_stoppedAt = float.NegativeInfinity;
        private float m_stopIntensity;
        private float m_seed;
        private bool m_isPlaying;

        public static Vector2 OffsetPixels
        {
            get { return s_offsetPixels; }
        }

        public static float Strength
        {
            get { return s_strength; }
        }

        /// <summary>Starts or restarts the full-screen shake.</summary>
        public void Play()
        {
            m_startedAt = Time.time;
            m_stoppedAt = float.NegativeInfinity;
            m_stopIntensity = 0f;
            m_seed = Mathf.Repeat(Time.time * 17.31f + 4.73f, 100f);
            m_isPlaying = true;
        }

        /// <summary>Ends the shake with a short falloff after the door reaches its open position.</summary>
        public void Stop()
        {
            if (!m_isPlaying)
            {
                return;
            }

            float now = Time.time;
            m_stopIntensity = EvaluateRise(now);
            m_stoppedAt = now;
            m_isPlaying = false;
        }

        private void Update()
        {
            float now = Time.time;
            float intensity = EvaluateIntensity(now);
            float sampleTime = now * m_frequency;
            s_offsetPixels = new Vector2(
                SampleNoise(sampleTime, m_seed),
                SampleNoise(m_seed, sampleTime)) * (m_amplitudePixels * intensity);
            s_strength = intensity;
        }

        private void OnDisable()
        {
            ResetState();
            m_isPlaying = false;
        }

        private void OnValidate()
        {
            m_riseDuration = Mathf.Max(0.01f, m_riseDuration);
            m_fallDuration = Mathf.Max(0.01f, m_fallDuration);
            m_amplitudePixels = Mathf.Max(0f, m_amplitudePixels);
            m_frequency = Mathf.Max(0.01f, m_frequency);
        }

        [RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.SubsystemRegistration)]
        private static void ResetState()
        {
            s_offsetPixels = Vector2.zero;
            s_strength = 0f;
        }

        private float EvaluateIntensity(float now)
        {
            if (m_isPlaying)
            {
                return EvaluateRise(now);
            }

            float fallProgress = (now - m_stoppedAt) / m_fallDuration;

            if (fallProgress < 0f || fallProgress >= 1f)
            {
                return 0f;
            }

            return m_stopIntensity * (1f - Mathf.SmoothStep(0f, 1f, fallProgress));
        }

        private float EvaluateRise(float now)
        {
            float riseProgress = Mathf.Clamp01((now - m_startedAt) / m_riseDuration);
            return Mathf.SmoothStep(0f, 1f, riseProgress);
        }

        private static float SampleNoise(float x, float y)
        {
            return (Mathf.PerlinNoise(x, y) - 0.5f) * 2f;
        }
    }
}
