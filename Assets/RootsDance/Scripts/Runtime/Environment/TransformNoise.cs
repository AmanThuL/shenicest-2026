using UnityEngine;

namespace RootsDance.Environment
{
    /// <summary>
    /// Shakes a transform for a few seconds — the leaves moving by the wall in node 02-03, when
    /// there is still nothing there to see.
    /// <para>
    /// The one thing a <see cref="RootsDance.Sequencing.CueSequence"/> cannot express, since a step
    /// can switch an object on but not animate it. Switching this component's object on is what a
    /// sequence does; the movement is here.
    /// </para>
    /// <para>
    /// Perlin noise rather than a sine or a random walk: a sine reads as machinery, and random
    /// per-frame offsets read as a rendering fault. Noise sampled along time gives the continuous,
    /// unrepeating drift that a plant being pushed actually has.
    /// </para>
    /// </summary>
    public class TransformNoise : MonoBehaviour
    {
        [Tooltip("What moves. Empty uses this object.")]
        [SerializeField] private Transform m_target;

        [Header("Shape")]
        [Tooltip("Peak offset in metres. A leaf being brushed is a couple of centimetres.")]
        [SerializeField] private float m_positionAmplitude = 0.03f;

        [Tooltip("Peak rotation in degrees.")]
        [SerializeField] private float m_rotationAmplitude = 4f;

        [Tooltip("How fast the noise is walked. Higher is more agitated, not larger.")]
        [SerializeField] private float m_frequency = 3.2f;

        [Header("Life")]
        [Tooltip("Seconds of movement before it settles back. 0 shakes for as long as the object "
            + "is active, which is what a permanently restless plant wants.")]
        [SerializeField] private float m_durationSeconds = 1.4f;

        [Tooltip("Seconds spent easing back to rest at the end.")]
        [SerializeField] private float m_settleSeconds = 0.6f;

        private Vector3 m_restPosition;
        private Quaternion m_restRotation;
        private float m_elapsed;
        private float m_seed;

        private void Awake()
        {
            if (m_target == null)
            {
                m_target = transform;
            }

            m_restPosition = m_target.localPosition;
            m_restRotation = m_target.localRotation;
            m_seed = Mathf.Abs(m_target.position.x * 7.13f + m_target.position.z * 3.71f) % 100f;
        }

        private void OnEnable()
        {
            m_elapsed = 0f;
        }

        private void OnDisable()
        {
            // Always put it back: a sequence that switches this off mid-shake must not leave the
            // plant leaning.
            if (m_target != null)
            {
                m_target.localPosition = m_restPosition;
                m_target.localRotation = m_restRotation;
            }
        }

        private void Update()
        {
            m_elapsed += Time.deltaTime;

            float strength = 1f;

            if (m_durationSeconds > 0f)
            {
                if (m_elapsed >= m_durationSeconds + m_settleSeconds)
                {
                    enabled = false;
                    return;
                }

                if (m_elapsed > m_durationSeconds && m_settleSeconds > 0f)
                {
                    strength = 1f - (m_elapsed - m_durationSeconds) / m_settleSeconds;
                }
            }

            float t = m_seed + m_elapsed * m_frequency;

            // Three decorrelated samples: the same noise field read at points far enough apart that
            // the axes do not move together, which is what makes it read as a push rather than a slide.
            Vector3 offset = new Vector3(
                Mathf.PerlinNoise(t, 0f) - 0.5f,
                Mathf.PerlinNoise(0f, t) - 0.5f,
                Mathf.PerlinNoise(t, t) - 0.5f) * (2f * strength);

            m_target.localPosition = m_restPosition + offset * m_positionAmplitude;
            m_target.localRotation = m_restRotation * Quaternion.Euler(offset * m_rotationAmplitude);
        }
    }
}
