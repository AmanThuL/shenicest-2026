using UnityEngine;
using UnityEngine.Rendering;

namespace RootsDance.Rendering
{
    /// <summary>
    /// Publishes the level's Sun as shader globals, so hand-written unlit materials can be lit by
    /// the same light everything else is.
    /// </summary>
    /// <remarks>
    /// <para>
    /// Shader globals rather than serialized references, for the reason
    /// <see cref="RootsDance.Player.FlashlightBeamBroadcaster"/> gives: the Sun lives in the
    /// lighting rig and the surfaces that read it are dressed into other scenes, which no
    /// serialized field reaches across. There is one Sun, so one set of globals is the whole state.
    /// </para>
    /// <para>
    /// Why this exists at all: HDRP keeps its lights in <c>_DirectionalLightDatas</c>, which an
    /// unlit pass has no light loop to read. A material that wants a key light without paying for
    /// twenty Lit passes has to be handed one, and being handed the real Sun is what keeps
    /// <see cref="RootsDance.Environment.TimeOfDayController"/>'s changes visible on it.
    /// </para>
    /// <para>
    /// Written per camera rather than per frame, so a Sun animated between renders is read at the
    /// point its pose matters.
    /// </para>
    /// </remarks>
    public class SunBroadcaster : MonoBehaviour
    {
        /// <summary>xyz: the direction the light travels, normalised. <c>w</c> unused.</summary>
        public const string k_DirectionProperty = "_RootsSunDirection";

        /// <summary>rgb: colour times intensity. Black means nothing has broadcast a sun.</summary>
        public const string k_ColorProperty = "_RootsSunColor";

        /// <summary>rgb: the ambient the surfaces sit in.</summary>
        public const string k_SkyProperty = "_RootsSkyColor";

        [Tooltip("The level's directional Sun — the same Light TimeOfDayController drives. " +
                 "Empty uses the Light on this object.")]
        [SerializeField] private Light m_sun;

        [Tooltip("Scales the published sun. HDRP intensities are in lux and reach the thousands, " +
                 "which would blow out a material that multiplies by them directly.")]
        [SerializeField] private float m_intensityScale = 0.0008f;

        [Tooltip("Ceiling on the published sun, after scaling. Noon should not white out the " +
                 "surfaces that read this.")]
        [SerializeField] private float m_maxIntensity = 3f;

        [Tooltip("Ambient the surfaces sit in when no probe is a better answer.")]
        [ColorUsage(false, true)]
        [SerializeField] private Color m_sky = new Color(0.32f, 0.38f, 0.45f, 1f);

        private static readonly int k_DirectionId = Shader.PropertyToID(k_DirectionProperty);
        private static readonly int k_ColorId = Shader.PropertyToID(k_ColorProperty);
        private static readonly int k_SkyId = Shader.PropertyToID(k_SkyProperty);

        private void Awake()
        {
            if (m_sun == null)
            {
                m_sun = GetComponent<Light>();
            }
        }

        private void OnEnable()
        {
            RenderPipelineManager.beginCameraRendering += OnBeginCameraRendering;
        }

        private void OnDisable()
        {
            RenderPipelineManager.beginCameraRendering -= OnBeginCameraRendering;

            // Clear to black on the way out. A material that reads a stale sun after the rig is
            // unloaded is lit by a light that is no longer in the level; black is the signal every
            // reader already treats as "none broadcast" and falls back from.
            Shader.SetGlobalVector(k_ColorId, Vector4.zero);
        }

        private void OnBeginCameraRendering(ScriptableRenderContext context, Camera camera)
        {
            if (m_sun == null || !m_sun.isActiveAndEnabled)
            {
                Shader.SetGlobalVector(k_ColorId, Vector4.zero);
                return;
            }

            Vector3 direction = m_sun.transform.forward;
            float intensity = Mathf.Min(m_sun.intensity * m_intensityScale, m_maxIntensity);
            Color sun = m_sun.color * intensity;

            Shader.SetGlobalVector(k_DirectionId, direction.normalized);
            Shader.SetGlobalVector(k_ColorId, new Vector4(sun.r, sun.g, sun.b, 1f));
            Shader.SetGlobalVector(k_SkyId, new Vector4(m_sky.r, m_sky.g, m_sky.b, 1f));
        }
    }
}
