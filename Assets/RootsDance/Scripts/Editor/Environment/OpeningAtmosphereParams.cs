using System;
using RootsDance.App;
using UnityEngine;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Every Volume override value one Opening profile carries. Colours are linear-space LDR unless noted.
    /// </summary>
    [Serializable]
    public class OpeningLook
    {
        /// <summary>Fog override: Fog Attenuation Distance (mean free path), in metres.</summary>
        public float FogAttenuationDistance;
        public float FogBaseHeight;
        public float FogMaximumHeight;
        /// <summary>Fog override Tint (multiplies the sky colour, Sky Color mode).</summary>
        public Color FogTint;
        /// <summary>Volumetric fog single-scattering albedo.</summary>
        public Color FogAlbedo;
        public float FogAnisotropy;
        /// <summary>Fog override Ambient Light Probe Dimmer, 0 = no dimming.</summary>
        public float AmbientDimmer;
        /// <summary>Fog override Volumetric Fog Distance (depth extent of the volumetric buffer), in metres.</summary>
        public float FogVolumetricDistance;
        /// <summary>
        /// Fog override Multiple Scattering Intensity (0..2); dense single-scattering fog reads too dark.
        /// </summary>
        public float FogMultipleScattering;
        public Color SkyTop;
        public Color SkyMiddle;
        public Color SkyBottom;
        public float SkyDiffusion;
        /// <summary>Gradient Sky exposure (Intensity Mode = Exposure), EV.</summary>
        public float SkyExposure;
        /// <summary>Exposure override, Fixed mode, EV100.</summary>
        public float FixedExposure;
        public float Contrast;
        public float Saturation;
        public Color ColorFilter;
        public float VignetteIntensity;
        public float GrainIntensity;
        public float BloomIntensity;
        public float PsxIntensity;
        public int PsxPixelScale;
        public int PsxColorLevels;
        public float PsxDither;
    }

    /// <summary>One local Box Volume along the route and the profile it drives.</summary>
    [Serializable]
    public class OpeningSegment
    {
        /// <summary>GameObject name of the Volume, e.g. <c>OpeningVolume_Wake</c>.</summary>
        public string Name;
        /// <summary>Profile asset name without extension, e.g. <c>OpeningWakeProfile</c>.</summary>
        public string ProfileName;
        /// <summary>Box centre in world space, metres.</summary>
        public Vector3 Center;
        /// <summary>Box size in world space, metres.</summary>
        public Vector3 Size;
        /// <summary>Volume Blend Distance outside the box, metres.</summary>
        public float BlendDistance;
        /// <summary>Volume Priority; must be above the level Global Volume (0).</summary>
        public float Priority;
        public OpeningLook Look;
    }

    /// <summary>
    /// Fog the level's MainProfile carries north of the opening, so the haze continues (milder) up to the lab
    /// instead of stopping at the Threshold volume. Only the Fog override of MainProfile is written.
    /// </summary>
    [Serializable]
    public class OpeningBeyondFog
    {
        public float AttenuationDistance;
        public float BaseHeight;
        public float MaximumHeight;
        public Color Albedo;
        public float Anisotropy;
        public float AmbientDimmer;
        public float VolumetricDistance;
        public float MultipleScattering;
    }

    [Serializable]
    public class OpeningSunSettings
    {
        public float IntensityLux;
        public Color Color;
        /// <summary>HDAdditionalLightData.angularDiameter, degrees.</summary>
        public float AngularDiameter;
        /// <summary>HDAdditionalLightData.shadowDimmer, 0..1.</summary>
        public float ShadowDimmer;
    }

    public enum OpeningVfxKind
    {
        ContaminationMotes = 0,
        AnomalousSpores = 1,
    }

    /// <summary>One placed instance of a VFX prefab.</summary>
    [Serializable]
    public class OpeningVfxEmitter
    {
        public string Name;
        public OpeningVfxKind Kind;
        public Vector3 Center;
        /// <summary>
        /// Emission box size, metres (applied as the instance's local scale; prefabs use Shape scaling).
        /// </summary>
        public Vector3 Size;
        public float RateOverTime;
    }

    /// <summary>
    /// Value object holding every tunable of the opening atmosphere. Pure data, no Unity object references, so
    /// the builder and the EditMode tests share one definition.
    /// </summary>
    [Serializable]
    public class OpeningAtmosphereParams
    {
        public const string k_DefaultProfileFolder = "Assets/RootsDance/Settings/VolumeProfiles";
        public const string k_VolumeRootName = "OpeningAtmosphere";
        public const string k_VfxRootName = "OpeningVFX";
        public const float k_EyeHeight = 1.7f;

        public string ScenePath = ScenePaths.k_MainEnvironment;
        public string ProfileFolder = k_DefaultProfileFolder;

        /// <summary>
        /// Camera positions along the doc's route, wake → grass platform edge (eye height included).
        /// </summary>
        public Vector3[] RouteNodes;
        public OpeningSegment[] Segments;
        public OpeningSunSettings Sun;
        /// <summary>MainProfile fog for the rest of the level (applied on overwrite only).</summary>
        public OpeningBeyondFog BeyondFog;
        public OpeningVfxEmitter[] Emitters;

        public static OpeningAtmosphereParams CreateDefault()
        {
            OpeningAtmosphereParams p = new OpeningAtmosphereParams();

            // Greybox mainRoute nodes (TerrainGreyboxParams.CreateDefault) + eye height.
            p.RouteNodes = new[]
            {
                new Vector3(0f, 3f + k_EyeHeight, -10f),      // S0 wake lowland
                new Vector3(-7f, 7f + k_EyeHeight, 4f),       // S2/S3 outer ridge top
                new Vector3(-15f, 4f + k_EyeHeight, 18f),     // S4 survey camp valley
                new Vector3(-16f, 5.2f + k_EyeHeight, 28f),   // S5 rising slope
                new Vector3(-12f, 6f + k_EyeHeight, 39f),     // S6 grass platform edge
            };

            p.Segments = new[]
            {
                new OpeningSegment
                {
                    Name = "OpeningVolume_Wake", ProfileName = "OpeningWakeProfile",
                    Center = new Vector3(0f, 6f, -10f), Size = new Vector3(26f, 16f, 20f),
                    BlendDistance = 6f, Priority = 10f,
                    Look = new OpeningLook
                    {
                        FogAttenuationDistance = 8f, FogBaseHeight = 12f, FogMaximumHeight = 40f,
                        FogTint = Color.white, FogAlbedo = new Color(0.95f, 0.90f, 0.74f),
                        FogAnisotropy = 0.20f, AmbientDimmer = 0f, FogVolumetricDistance = 100f,
                        FogMultipleScattering = 1.2f,
                        SkyTop = new Color(0.50f, 0.48f, 0.38f), SkyMiddle = new Color(0.78f, 0.74f, 0.56f),
                        SkyBottom = new Color(0.86f, 0.82f, 0.62f), SkyDiffusion = 1.6f, SkyExposure = 12f,
                        FixedExposure = 12.3f, Contrast = 6f, Saturation = -28f,
                        ColorFilter = new Color(0.96f, 0.92f, 0.80f),
                        VignetteIntensity = 0.34f, GrainIntensity = 0.35f, BloomIntensity = 0.04f,
                        PsxIntensity = 1f, PsxPixelScale = 3, PsxColorLevels = 20, PsxDither = 0.6f,
                    },
                },
                new OpeningSegment
                {
                    Name = "OpeningVolume_Ridge", ProfileName = "OpeningRidgeProfile",
                    Center = new Vector3(-7f, 8f, 5f), Size = new Vector3(24f, 16f, 14f),
                    BlendDistance = 6f, Priority = 11f,
                    Look = new OpeningLook
                    {
                        FogAttenuationDistance = 12f, FogBaseHeight = 12f, FogMaximumHeight = 40f,
                        FogTint = Color.white, FogAlbedo = new Color(0.94f, 0.92f, 0.80f),
                        FogAnisotropy = 0.15f, AmbientDimmer = 0f, FogVolumetricDistance = 100f,
                        FogMultipleScattering = 1.1f,
                        SkyTop = new Color(0.50f, 0.52f, 0.44f), SkyMiddle = new Color(0.76f, 0.76f, 0.62f),
                        SkyBottom = new Color(0.84f, 0.84f, 0.70f), SkyDiffusion = 1.5f, SkyExposure = 12f,
                        FixedExposure = 12.2f, Contrast = 6f, Saturation = -24f,
                        ColorFilter = new Color(0.95f, 0.94f, 0.85f),
                        VignetteIntensity = 0.30f, GrainIntensity = 0.30f, BloomIntensity = 0.05f,
                        PsxIntensity = 1f, PsxPixelScale = 3, PsxColorLevels = 24, PsxDither = 0.6f,
                    },
                },
                new OpeningSegment
                {
                    Name = "OpeningVolume_Camp", ProfileName = "OpeningCampProfile",
                    Center = new Vector3(-15f, 6f, 19f), Size = new Vector3(22f, 16f, 14f),
                    BlendDistance = 5f, Priority = 12f,
                    Look = new OpeningLook
                    {
                        FogAttenuationDistance = 16f, FogBaseHeight = 12f, FogMaximumHeight = 40f,
                        FogTint = Color.white, FogAlbedo = new Color(0.86f, 0.90f, 0.86f),
                        FogAnisotropy = 0.10f, AmbientDimmer = 0.15f, FogVolumetricDistance = 100f,
                        FogMultipleScattering = 0.8f,
                        SkyTop = new Color(0.38f, 0.42f, 0.40f), SkyMiddle = new Color(0.60f, 0.64f, 0.58f),
                        SkyBottom = new Color(0.68f, 0.72f, 0.64f), SkyDiffusion = 1.4f, SkyExposure = 12f,
                        FixedExposure = 12.5f, Contrast = 8f, Saturation = -20f,
                        ColorFilter = new Color(0.90f, 0.94f, 0.90f),
                        VignetteIntensity = 0.30f, GrainIntensity = 0.30f, BloomIntensity = 0.06f,
                        PsxIntensity = 1f, PsxPixelScale = 3, PsxColorLevels = 28, PsxDither = 0.55f,
                    },
                },
                new OpeningSegment
                {
                    Name = "OpeningVolume_Threshold", ProfileName = "OpeningThresholdProfile",
                    Center = new Vector3(-14f, 7f, 33f), Size = new Vector3(22f, 16f, 16f),
                    BlendDistance = 6f, Priority = 13f,
                    Look = new OpeningLook
                    {
                        FogAttenuationDistance = 22f, FogBaseHeight = 12f, FogMaximumHeight = 45f,
                        FogTint = Color.white, FogAlbedo = new Color(0.90f, 0.96f, 0.92f),
                        FogAnisotropy = 0.10f, AmbientDimmer = 0f, FogVolumetricDistance = 100f,
                        FogMultipleScattering = 1.0f,
                        SkyTop = new Color(0.50f, 0.58f, 0.56f), SkyMiddle = new Color(0.72f, 0.80f, 0.76f),
                        SkyBottom = new Color(0.78f, 0.84f, 0.78f), SkyDiffusion = 1.3f, SkyExposure = 12f,
                        FixedExposure = 12.0f, Contrast = 4f, Saturation = -12f,
                        ColorFilter = new Color(0.92f, 0.98f, 0.94f),
                        VignetteIntensity = 0.24f, GrainIntensity = 0.25f, BloomIntensity = 0.08f,
                        PsxIntensity = 1f, PsxPixelScale = 3, PsxColorLevels = 32, PsxDither = 0.5f,
                    },
                },
            };

            p.BeyondFog = new OpeningBeyondFog
            {
                AttenuationDistance = 40f, BaseHeight = 12f, MaximumHeight = 50f,
                Albedo = new Color(0.90f, 0.94f, 0.90f), Anisotropy = 0.10f, AmbientDimmer = 0f,
                VolumetricDistance = 100f, MultipleScattering = 0.8f,
            };

            p.Sun = new OpeningSunSettings
            {
                IntensityLux = 12000f,
                Color = new Color(1.00f, 0.96f, 0.88f),
                AngularDiameter = 6f,
                ShadowDimmer = 0.7f,
            };

            p.Emitters = new[]
            {
                new OpeningVfxEmitter
                {
                    Name = "Motes_S0", Kind = OpeningVfxKind.ContaminationMotes,
                    Center = new Vector3(0f, 5f, -10f), Size = new Vector3(22f, 5f, 18f), RateOverTime = 15f,
                },
                new OpeningVfxEmitter
                {
                    Name = "Motes_S1", Kind = OpeningVfxKind.ContaminationMotes,
                    Center = new Vector3(-7f, 8f, 4f), Size = new Vector3(16f, 5f, 12f), RateOverTime = 9f,
                },
                new OpeningVfxEmitter
                {
                    Name = "Motes_S2", Kind = OpeningVfxKind.ContaminationMotes,
                    Center = new Vector3(-12f, 6f, 12f), Size = new Vector3(14f, 5f, 10f), RateOverTime = 5f,
                },
                new OpeningVfxEmitter
                {
                    Name = "Spores_S6", Kind = OpeningVfxKind.AnomalousSpores,
                    Center = new Vector3(-12f, 7f, 40f), Size = new Vector3(16f, 5f, 10f), RateOverTime = 4f,
                },
            };

            return p;
        }
    }
}
