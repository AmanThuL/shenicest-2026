using UnityEngine;

namespace RootsDance.Environment
{
    /// <summary>
    /// Breathes an emissive material — the mycelium under the corridor's observation window, which
    /// has to read as alive without the player doing anything to it.
    /// <para>
    /// Writes to <c>renderer.material</c>, which instantiates the material, rather than to a
    /// MaterialPropertyBlock. That is the presentation contract's call and it is about batching:
    /// with the same shader and the same <c>UnityPerMaterial</c> layout the SRP Batcher still
    /// batches material instances, while an MPB breaks the batch outright.
    /// </para>
    /// </summary>
    public class EmissivePulse : MonoBehaviour
    {
        [Tooltip("What glows. Empty uses the Renderer on this object.")]
        [SerializeField] private Renderer m_renderer;

        [Tooltip("HDRP Lit's emissive slot. Named here so a custom shader can be pointed at too.")]
        [SerializeField] private string m_colorProperty = "_EmissiveColor";

        [Header("Pulse")]
        [Tooltip("The colour at the bottom of the breath.")]
        [ColorUsage(false, true)]
        [SerializeField] private Color m_low = new Color(0.10f, 0.42f, 0.28f, 1f);

        [Tooltip("The colour at the top of it.")]
        [ColorUsage(false, true)]
        [SerializeField] private Color m_high = new Color(0.28f, 0.95f, 0.62f, 1f);

        [Tooltip("Breaths per second. Slow: this is a plant, not a warning light.")]
        [SerializeField] private float m_frequency = 0.22f;

        [Tooltip("Seconds of offset, so a row of them does not pulse in unison.")]
        [SerializeField] private float m_phaseOffset;

        private Material m_material;
        private int m_colorId;

        private void Awake()
        {
            if (m_renderer == null)
            {
                m_renderer = GetComponent<Renderer>();
            }

            m_colorId = Shader.PropertyToID(m_colorProperty);

            if (m_renderer != null)
            {
                m_material = m_renderer.material;
            }
        }

        private void OnDestroy()
        {
            // renderer.material instantiated it, so this object owns it and has to clean it up.
            if (m_material != null)
            {
                Destroy(m_material);
            }
        }

        private void Update()
        {
            if (m_material == null)
            {
                return;
            }

            // 0..1 rather than -1..1: a breath spends longer near its ends than a raw sine does.
            float t = 0.5f + 0.5f * Mathf.Sin((Time.time + m_phaseOffset) * m_frequency * 2f * Mathf.PI);

            m_material.SetColor(m_colorId, Color.Lerp(m_low, m_high, t));
        }
    }
}
