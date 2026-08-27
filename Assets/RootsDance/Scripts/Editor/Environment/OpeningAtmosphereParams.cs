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
                        FogAttenuationDistance = 28f, FogBaseHeight = 0f, FogMaximumHeight = 25f,
                        FogTint = new Color(0.92f, 0.86f, 0.66f), FogAlbedo = new Color(0.84f, 0.80f, 0.64f),
                        FogAnisotropy = 0.20f, AmbientDimmer = 0.35f,
                        SkyTop = new Color(0.36f, 0.35f, 0.27f), SkyMiddle = new Color(0.58f, 0.55f, 0.41f),
                        SkyBottom = new Color(0.66f, 0.62f, 0.47f), SkyDiffusion = 1.6f, SkyExposure = 12f,
                        FixedExposure = 12.7f, Contrast = 6f, Saturation = -28f,
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
                        FogAttenuationDistance = 45f, FogBaseHeight = 2f, FogMaximumHeight = 30f,
                        FogTint = new Color(0.88f, 0.86f, 0.72f), FogAlbedo = new Color(0.82f, 0.81f, 0.70f),
                        FogAnisotropy = 0.15f, AmbientDimmer = 0.35f,
                        SkyTop = new Color(0.36f, 0.38f, 0.31f), SkyMiddle = new Color(0.57f, 0.57f, 0.46f),
                        SkyBottom = new Color(0.64f, 0.64f, 0.52f), SkyDiffusion = 1.5f, SkyExposure = 12f,
                        FixedExposure = 12.6f, Contrast = 6f, Saturation = -24f,
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
                        FogAttenuationDistance = 60f, FogBaseHeight = -1f, FogMaximumHeight = 22f,
                        FogTint = new Color(0.74f, 0.78f, 0.72f), FogAlbedo = new Color(0.70f, 0.74f, 0.70f),
                        FogAnisotropy = 0.10f, AmbientDimmer = 0.45f,
                        SkyTop = new Color(0.30f, 0.34f, 0.32f), SkyMiddle = new Color(0.48f, 0.52f, 0.47f),
                        SkyBottom = new Color(0.55f, 0.58f, 0.52f), SkyDiffusion = 1.4f, SkyExposure = 12f,
                        FixedExposure = 12.9f, Contrast = 8f, Saturation = -20f,
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
                        FogAttenuationDistance = 90f, FogBaseHeight = 3f, FogMaximumHeight = 40f,
                        FogTint = new Color(0.80f, 0.88f, 0.82f), FogAlbedo = new Color(0.76f, 0.84f, 0.78f),
                        FogAnisotropy = 0.10f, AmbientDimmer = 0.20f,
                        SkyTop = new Color(0.42f, 0.50f, 0.48f), SkyMiddle = new Color(0.62f, 0.70f, 0.66f),
                        SkyBottom = new Color(0.68f, 0.74f, 0.68f), SkyDiffusion = 1.3f, SkyExposure = 12f,
                        FixedExposure = 12.4f, Contrast = 4f, Saturation = -12f,
                        ColorFilter = new Color(0.92f, 0.98f, 0.94f),
                        VignetteIntensity = 0.24f, GrainIntensity = 0.25f, BloomIntensity = 0.08f,
                        PsxIntensity = 1f, PsxPixelScale = 3, PsxColorLevels = 32, PsxDither = 0.5f,
                    },
                },
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
                    Center = new Vector3(0f, 5f, -10f), Size = new Vector3(22f, 5f, 18f), RateOverTime = 5f,
                },
                new OpeningVfxEmitter
                {
                    Name = "Motes_S1", Kind = OpeningVfxKind.ContaminationMotes,
                    Center = new Vector3(-7f, 8f, 4f), Size = new Vector3(16f, 5f, 12f), RateOverTime = 3f,
                },
                new OpeningVfxEmitter
                {
                    Name = "Motes_S2", Kind = OpeningVfxKind.ContaminationMotes,
                    Center = new Vector3(-12f, 6f, 12f), Size = new Vector3(14f, 5f, 10f), RateOverTime = 1.5f,
                },
                new OpeningVfxEmitter
                {
                    Name = "Spores_S6", Kind = OpeningVfxKind.AnomalousSpores,
                    Center = new Vector3(-12f, 7f, 40f), Size = new Vector3(16f, 5f, 10f), RateOverTime = 1.2f,
                },
            };

            return p;
        }
    }
}
