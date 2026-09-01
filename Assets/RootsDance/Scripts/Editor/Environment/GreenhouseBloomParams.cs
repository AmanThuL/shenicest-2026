using System;
using UnityEngine;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Every Volume override value the greenhouse bloom profile carries. Colours are linear-space
    /// LDR unless noted. Change a number here and re-run
    /// <c>RootsDance > Environment > Apply Greenhouse Bloom Look</c>; nothing else has to move.
    /// </summary>
    [Serializable]
    public class GreenhouseBloomLook
    {
        // ---- sky ---------------------------------------------------------------------------------

        /// <summary>
        /// HDRI Sky exposure (Intensity Mode = Exposure), EV. Read this together with
        /// <see cref="FixedExposure"/> — what the player sees is the difference between the two, so
        /// raising this alone does not brighten the sky, it only clips it.
        /// </summary>
        public float SkyExposure;

        /// <summary>HDRI Sky rotation, degrees. Chooses which part of the sunset sits over the glass.</summary>
        public float SkyRotation;

        // ---- exposure ----------------------------------------------------------------------------

        /// <summary>
        /// Exposure override, Fixed mode, EV100. Lower = brighter image. The sunset only holds its
        /// colour while <c>SkyExposure - FixedExposure</c> stays near zero; push it past about +2 and
        /// the sky turns to white paper.
        /// </summary>
        public float FixedExposure;

        // ---- grade -------------------------------------------------------------------------------

        /// <summary>
        /// ColorAdjustments Color Filter. Deliberately close to neutral: the warmth belongs to the
        /// sun, not to a full-screen tint. A filter warm enough to read as sunset on its own would
        /// also warm the shadows and flatten the split that makes the reference work.
        /// </summary>
        public Color ColorFilter;

        /// <summary>ColorAdjustments Post Exposure, EV, applied after tonemapping.</summary>
        public float PostExposure;

        public float Contrast;
        public float Saturation;

        /// <summary>Bloom intensity. Low on purpose — the glow is haze, not a filter.</summary>
        public float BloomIntensity;

        public float BloomScatter;

        // ---- fog ---------------------------------------------------------------------------------

        /// <summary>Fog Attenuation Distance (mean free path), metres. Lower = hazier.</summary>
        public float FogAttenuationDistance;

        /// <summary>
        /// Volumetric fog single-scattering albedo. Held slightly green so the surfaces the sun
        /// misses stay cool against the peach.
        /// </summary>
        public Color FogAlbedo;

        public float FogAnisotropy;
    }

    /// <summary>
    /// The authored looks. <see cref="Bloom"/> is the good ending — statue in flower, water running.
    /// </summary>
    public static class GreenhouseBloomParams
    {
        /// <summary>
        /// Sunset ending. Starting point for tuning, not a measured match: the reference is a
        /// photograph of low sun on tile, and how it lands here depends on the greenhouse materials.
        /// <para>
        /// The numbers to reach for first are <see cref="GreenhouseBloomLook.SkyExposure"/> and
        /// <see cref="GreenhouseBloomLook.FixedExposure"/> — their difference sets whether the sunset
        /// shows as colour or as glare, and it dominates everything else in this table.
        /// </para>
        /// </summary>
        public static GreenhouseBloomLook Bloom()
        {
            return new GreenhouseBloomLook
            {
                // Base profile sits at sky 10.8 / camera 12.5, i.e. -1.7 EV. Landing both at 11.2
                // brightens the glass by 1.7 EV while keeping the difference at zero, so the orange
                // band over the horizon stays orange instead of clipping to white.
                SkyExposure = 11.2f,
                SkyRotation = 332f,
                FixedExposure = 11.2f,

                ColorFilter = new Color(1f, 0.96f, 0.91f, 1f),
                PostExposure = 0.15f,
                Contrast = 0f,
                Saturation = -18f,
                BloomIntensity = 0.1f,
                BloomScatter = 0.7f,

                FogAttenuationDistance = 90f,
                FogAlbedo = new Color(0.88f, 0.92f, 0.89f, 1f),
                FogAnisotropy = 0.3f,
            };
        }
    }
}
