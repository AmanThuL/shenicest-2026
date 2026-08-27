using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace RootsDance.Rendering
{
    /// <summary>
    /// PSX-style full-screen treatment: renders the frame on a coarse pixel grid, quantises colour per channel
    /// and breaks the banding with an ordered 4x4 Bayer dither. Injected After Post Process so it works on the
    /// tone-mapped image. Register it once via RootsDance > Rendering > Register PSX Post Process, then add it
    /// as a Volume override (guideline 07 §4).
    /// </summary>
    /// <remarks>
    /// The parameters are public fields because that is the Volume system's contract for every override
    /// (HDRP's own components do the same); this is the documented exception to the m_ naming rule.
    /// </remarks>
    [Serializable, VolumeComponentMenu("Post-processing/Custom/RootsDance PSX")]
    public sealed class PsxPostProcess : CustomPostProcessVolumeComponent, IPostProcessComponent
    {
        /// <summary>Name of the shader this effect draws with; must match the .shader file's Shader block.</summary>
        public const string k_ShaderName = "Hidden/RootsDance/PsxPostProcess";

        [Tooltip("0 = off, 1 = the full PSX treatment. Blends per Volume like any other override.")]
        public ClampedFloatParameter intensity = new ClampedFloatParameter(0f, 0f, 1f);

        [Tooltip("Screen pixels per virtual pixel. 1 keeps the native resolution; 3 renders a 1080p frame as 640x360.")]
        public ClampedIntParameter pixelScale = new ClampedIntParameter(3, 1, 8);

        [Tooltip("Colour steps per channel after tone mapping. 32 reads as 15-bit PSX colour.")]
        public ClampedIntParameter colorLevels = new ClampedIntParameter(32, 4, 256);

        [Tooltip("Ordered (Bayer 4x4) dither amplitude, in colour steps.")]
        public ClampedFloatParameter ditherStrength = new ClampedFloatParameter(0.6f, 0f, 1f);

        private static readonly int k_IntensityId = Shader.PropertyToID("_Intensity");
        private static readonly int k_PixelScaleId = Shader.PropertyToID("_PixelScale");
        private static readonly int k_ColorLevelsId = Shader.PropertyToID("_ColorLevels");
        private static readonly int k_DitherStrengthId = Shader.PropertyToID("_DitherStrength");
        private static readonly int k_MainTexId = Shader.PropertyToID("_MainTex");

        private Material m_material;

        public override CustomPostProcessInjectionPoint injectionPoint
        {
            get { return CustomPostProcessInjectionPoint.AfterPostProcess; }
        }

        public bool IsActive()
        {
            return m_material != null && intensity.value > 0f;
        }

        public override void Setup()
        {
            Shader shader = Shader.Find(k_ShaderName);

            if (shader == null)
            {
                Debug.LogError(
                    $"PsxPostProcess: shader '{k_ShaderName}' not found; the effect is disabled. "
                    + "Check Assets/RootsDance/Shaders/PostProcess/PsxPostProcess.shader "
                    + "and the Always Included Shaders list.");
                return;
            }

            m_material = CoreUtils.CreateEngineMaterial(shader);
        }

        public override void Render(CommandBuffer cmd, HDCamera camera, RTHandle source, RTHandle destination)
        {
            if (m_material == null)
            {
                return;
            }

            m_material.SetFloat(k_IntensityId, intensity.value);
            m_material.SetFloat(k_PixelScaleId, pixelScale.value);
            m_material.SetFloat(k_ColorLevelsId, colorLevels.value);
            m_material.SetFloat(k_DitherStrengthId, ditherStrength.value);
            m_material.SetTexture(k_MainTexId, source);
            HDUtils.DrawFullScreen(cmd, m_material, destination, shaderPassId: 0);
        }

        public override void Cleanup()
        {
            CoreUtils.Destroy(m_material);
            m_material = null;
        }
    }
}
