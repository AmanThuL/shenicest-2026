using UnityEngine;
using UnityEngine.UI;

namespace RootsDance.UI.Kit
{
    /// <summary>
    /// An image shown through the kit's dither shader (spec §3, §4B). The plate owns a material
    /// instance so two plates on one screen can run different modes, and it takes the two mapped
    /// colours from the theme rather than the inspector, so a dithered image restyles with everything
    /// else.
    /// <para>
    /// Only image content is dithered. Rules, labels and chips stay crisp — putting the pattern on the
    /// chrome, or over the whole screen, is what turns this from an instrument into an aged filter.
    /// </para>
    /// </summary>
    [ExecuteAlways]
    [RequireComponent(typeof(RawImage))]
    public class KitDitherPlate : MonoBehaviour
    {
        /// <summary>Mirrors the shader's _Mode enum so the inspector reads in words.</summary>
        public enum DitherMode
        {
            Bayer2 = 0,
            Bayer4 = 1,
            Bayer8 = 2,
            HalftoneRound = 3,
            HalftoneDiamond = 4,
            HalftoneLine = 5,
            BlueNoise = 6
        }

        private static readonly int k_ModeId = Shader.PropertyToID("_Mode");
        private static readonly int k_LevelsId = Shader.PropertyToID("_Levels");
        private static readonly int k_PixelSizeId = Shader.PropertyToID("_PixelSize");
        private static readonly int k_AngleId = Shader.PropertyToID("_Angle");
        private static readonly int k_ContrastId = Shader.PropertyToID("_Contrast");
        private static readonly int k_BrightnessId = Shader.PropertyToID("_Brightness");
        private static readonly int k_LowId = Shader.PropertyToID("_ColorLow");
        private static readonly int k_HighId = Shader.PropertyToID("_ColorHigh");

        [SerializeField] private DitherMode m_mode = DitherMode.Bayer4;

        [Range(2, 16)]
        [SerializeField] private int m_levels = 2;

        [Tooltip("Pattern cell in screen pixels. Measured 2-3 on the references; 1 is invisible.")]
        [Range(1f, 12f)]
        [SerializeField] private float m_pixelSize = 3f;

        [Range(0f, 90f)]
        [SerializeField] private float m_angle = 45f;

        [Tooltip("Applied before the pattern. Without a hard crush the plate is one flat field.")]
        [Range(0.1f, 6f)]
        [SerializeField] private float m_contrast = 2.2f;

        [Range(-1f, 1f)]
        [SerializeField] private float m_brightness;

        [SerializeField] private KitInk m_lowInk = KitInk.Ink0;

        [SerializeField] private KitInk m_highInk = KitInk.Ink4;

        private Material m_material;

        public DitherMode Mode
        {
            get { return m_mode; }
            set
            {
                m_mode = value;
                PushToMaterial();
            }
        }

        private void OnEnable()
        {
            PushToMaterial();
        }

        private void OnValidate()
        {
            PushToMaterial();
        }

        private void OnDestroy()
        {
            if (m_material == null)
            {
                return;
            }

            if (Application.isPlaying)
            {
                Destroy(m_material);
            }
            else
            {
                DestroyImmediate(m_material);
            }

            m_material = null;
        }

        /// <summary>Called by the root's theme walk; also safe to call directly.</summary>
        public void Apply(ElectronicUITheme theme)
        {
            Material material = EnsureMaterial();

            if (material == null || theme == null)
            {
                return;
            }

            material.SetColor(k_LowId, theme.Ink(m_lowInk));
            material.SetColor(k_HighId, theme.Ink(m_highInk));
            PushToMaterial();
        }

        private Material EnsureMaterial()
        {
            RawImage image = GetComponent<RawImage>();

            if (image == null)
            {
                return null;
            }

            if (m_material != null)
            {
                return m_material;
            }

            // Each plate needs its own instance: the mode and cell size are per-plate, and sharing the
            // asset would make the last one edited win across the whole screen. Built from the shader
            // directly when no dither material was assigned, so a plate can never silently fall back
            // to the default UI material and render its source smooth — the one look the kit bans.
            if (image.material != null && image.material.shader != null
                && image.material.shader.name.Contains("Dither"))
            {
                m_material = new Material(image.material);
            }
            else
            {
                Shader shader = Shader.Find("RootsDance/UI/Dither");

                if (shader == null)
                {
                    Debug.LogWarning("RootsDance/UI/Dither shader missing; plate renders undithered.",
                        this);
                    return null;
                }

                m_material = new Material(shader);
            }

            image.material = m_material;

            return m_material;
        }

        private void PushToMaterial()
        {
            Material material = EnsureMaterial();

            if (material == null)
            {
                return;
            }

            material.SetFloat(k_ModeId, (int)m_mode);
            material.SetFloat(k_LevelsId, m_levels);
            material.SetFloat(k_PixelSizeId, m_pixelSize);
            material.SetFloat(k_AngleId, m_angle);
            material.SetFloat(k_ContrastId, m_contrast);
            material.SetFloat(k_BrightnessId, m_brightness);
        }
    }
}
