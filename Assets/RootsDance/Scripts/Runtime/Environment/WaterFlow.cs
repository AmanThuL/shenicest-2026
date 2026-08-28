using UnityEngine;

namespace RootsDance.Environment
{
    /// <summary>
    /// Scrolls a water surface's maps so a trough or a runnel reads as moving.
    /// <para>
    /// This is the project's water, and it is deliberately not HDRP's Water System. That system is
    /// off in <c>HDRP_Desktop.asset</c> (<c>supportWater: 0</c>); turning it on is a pipeline-wide
    /// change that costs every machine a shader-variant rebuild, and what it buys — simulated
    /// swell across bands of wavelength — is for oceans and rivers. What the greenhouse needs is a
    /// stopped trough with standing water in it, and a thread of water down a statue for a few
    /// seconds at the end. A Lit surface with its normal map crawling is the whole effect.
    /// </para>
    /// <para>
    /// Offsets are pushed onto <c>renderer.material</c>, not a MaterialPropertyBlock, for the same
    /// batching reason as <see cref="EmissivePulse"/>.
    /// </para>
    /// </summary>
    public class WaterFlow : MonoBehaviour
    {
        [Tooltip("The water surface. Empty uses the Renderer on this object.")]
        [SerializeField] private Renderer m_renderer;

        [Tooltip("Texture properties whose offset is scrolled. The normal map alone already reads "
            + "as flow; adding the base map as well makes debris travel with it.")]
        [SerializeField] private string[] m_textureProperties = { "_NormalMap" };

        [Tooltip("UV units per second. Small: at 0.05 a two-metre trough takes forty seconds to "
            + "cycle, which is what slow water looks like.")]
        [SerializeField] private Vector2 m_speed = new Vector2(0f, 0.05f);

        [Tooltip("Off until the circulation system is running again. A CueSequence step switching "
            + "this component's object on is how the ending starts the water.")]
        [SerializeField] private bool m_isFlowing = true;

        private Material m_material;
        private Vector2 m_offset;

        /// <summary>Turns the flow on or off without disabling the component.</summary>
        public bool IsFlowing
        {
            get { return m_isFlowing; }
            set { m_isFlowing = value; }
        }

        private void Awake()
        {
            if (m_renderer == null)
            {
                m_renderer = GetComponent<Renderer>();
            }

            if (m_renderer != null)
            {
                m_material = m_renderer.material;
            }
        }

        private void OnDestroy()
        {
            if (m_material != null)
            {
                Destroy(m_material);
            }
        }

        private void Update()
        {
            if (m_material == null || !m_isFlowing)
            {
                return;
            }

            m_offset += m_speed * Time.deltaTime;

            // Wrapped, so the offset cannot drift into the float range where UV precision falls
            // apart after a long session.
            m_offset.x -= Mathf.Floor(m_offset.x);
            m_offset.y -= Mathf.Floor(m_offset.y);

            for (int i = 0; i < m_textureProperties.Length; i++)
            {
                if (!string.IsNullOrEmpty(m_textureProperties[i]))
                {
                    m_material.SetTextureOffset(m_textureProperties[i], m_offset);
                }
            }
        }
    }
}
