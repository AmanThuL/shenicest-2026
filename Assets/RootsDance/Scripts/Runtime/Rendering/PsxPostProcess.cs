using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace RootsDance.Rendering
{
    /// <summary>
    /// Selectable full-screen treatment: either a PSX-style coarse pixel grid, colour quantisation, ordered
    /// Bayer dither and interlacing, or grain alone. Injected After Post Process so it works on the tone-mapped
    /// image. Register it once via RootsDance > Rendering > Register PSX Post Process, then add it as a Volume
    /// override (guideline 07 §4).
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

        [Tooltip("Off = PSX pixelation, colour depth, dithering and interlacing. On = grain only.")]
        public BoolParameter grainMode = new BoolParameter(false);

        [Tooltip("Screen pixels per virtual pixel at 1080p. Scales with output height so the PSX grid keeps "
            + "the same visual granularity.")]
        public ClampedIntParameter pixelScale = new ClampedIntParameter(4, 1, 8);

        [Tooltip("Colour steps per channel after tone mapping. 32 reads as 15-bit PSX colour.")]
        public ClampedIntParameter colorLevels = new ClampedIntParameter(32, 4, 256);

        [Tooltip("Ordered (Bayer 4x4) dither amplitude, in colour steps.")]
        public ClampedFloatParameter ditherStrength = new ClampedFloatParameter(0.6f, 0f, 1f);

        [Tooltip("How much to dim every other horizontal band. Multiplied by Intensity; 0 disables interlacing.")]
        public ClampedFloatParameter interlaceStrength = new ClampedFloatParameter(0.12f, 0f, 1f);

        [Tooltip("Height of one interlaced band in virtual pixels.")]
        public ClampedIntParameter interlaceSize = new ClampedIntParameter(1, 1, 8);

        [Tooltip("Grain amplitude. 1 = +/-25 % of the sRGB range on the pixels the shadow bias lets through. "
            + "Used only when Grain Mode is enabled.")]
        public ClampedFloatParameter grainIntensity = new ClampedFloatParameter(0f, 0f, 1f);

        [Tooltip("Grain cell edge in virtual pixels (one grain cell = Grain Size x Pixel Scale screen pixels).")]
        public ClampedIntParameter grainSize = new ClampedIntParameter(1, 1, 8);

        [Tooltip("How many times per second the grain pattern re-seeds. 0 = a new pattern every frame.")]
        public ClampedFloatParameter grainRate = new ClampedFloatParameter(15f, 0f, 60f);

        [Tooltip("0 = the same grain everywhere; 1 = full grain in the blacks, none in the whites.")]
        public ClampedFloatParameter grainShadowBias = new ClampedFloatParameter(0.6f, 0f, 1f);

        private static readonly int k_IntensityId = Shader.PropertyToID("_Intensity");
        private static readonly int k_PixelScaleId = Shader.PropertyToID("_PixelScale");
        private static readonly int k_ColorLevelsId = Shader.PropertyToID("_ColorLevels");
        private static readonly int k_DitherStrengthId = Shader.PropertyToID("_DitherStrength");
        private static readonly int k_InterlaceStrengthId = Shader.PropertyToID("_InterlaceStrength");
        private static readonly int k_InterlaceSizeId = Shader.PropertyToID("_InterlaceSize");
        private static readonly int k_GrainIntensityId = Shader.PropertyToID("_GrainIntensity");
        private static readonly int k_GrainSizeId = Shader.PropertyToID("_GrainSize");
        private static readonly int k_GrainSeedId = Shader.PropertyToID("_GrainSeed");
        private static readonly int k_GrainShadowBiasId = Shader.PropertyToID("_GrainShadowBias");
        private static readonly int k_ShakeOffsetPixelsId = Shader.PropertyToID("_ShakeOffsetPixels");
        private static readonly int k_ShakeOverscanId = Shader.PropertyToID("_ShakeOverscan");
        private static readonly int k_MainTexId = Shader.PropertyToID("_MainTex");

        private Material m_material;

        public override CustomPostProcessInjectionPoint injectionPoint
        {
            get { return CustomPostProcessInjectionPoint.AfterPostProcess; }
        }

        public bool IsActive()
        {
            if (m_material == null)
            {
                return false;
            }

            return GateFullscreenShake.Strength > 0f
                || (grainMode.value ? grainIntensity.value > 0f : intensity.value > 0f);
        }

        /// <summary>
        /// Seed the grain hash uses this frame. A positive <paramref name="rate"/> holds one pattern for
        /// 1/rate seconds (the low-frame-rate video flicker); rate 0 re-seeds every frame. Pure so it is unit
        /// tested; unscaled time keeps the grain moving while the game is paused.
        /// </summary>
        public static float ComputeGrainSeed(float unscaledTime, float rate, int frameCount)
        {
            if (rate <= 0f)
            {
                return frameCount;
            }

            return Mathf.Floor(unscaledTime * rate);
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

            bool useGrain = grainMode.value;
            m_material.SetFloat(k_IntensityId, useGrain ? 0f : intensity.value);
            m_material.SetFloat(k_PixelScaleId, pixelScale.value);
            m_material.SetFloat(k_ColorLevelsId, colorLevels.value);
            m_material.SetFloat(k_DitherStrengthId, ditherStrength.value);
            m_material.SetFloat(k_InterlaceStrengthId, useGrain ? 0f : interlaceStrength.value);
            m_material.SetFloat(k_InterlaceSizeId, interlaceSize.value);
            m_material.SetFloat(k_GrainIntensityId, useGrain ? grainIntensity.value : 0f);
            m_material.SetFloat(k_GrainSizeId, grainSize.value);
            m_material.SetFloat(k_GrainSeedId,
                ComputeGrainSeed(Time.unscaledTime, grainRate.value, Time.frameCount));
            m_material.SetFloat(k_GrainShadowBiasId, grainShadowBias.value);
            Vector2 shakeOffset = GateFullscreenShake.OffsetPixels;
            m_material.SetVector(
                k_ShakeOffsetPixelsId,
                new Vector4(shakeOffset.x, shakeOffset.y, 0f, 0f));
            m_material.SetFloat(k_ShakeOverscanId, GateFullscreenShake.Strength * 0.018f);
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
