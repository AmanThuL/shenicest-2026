using UnityEditor;
using UnityEditor.Rendering;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Writes <see cref="GreenhouseBloomParams"/> into the greenhouse bloom Volume profile — the look
    /// the level fades to while the statue flowers.
    /// <para>
    /// Profile only. The sun this look depends on lives in
    /// <c>GreenhouseInterior_Environment</c>, and its warm and cool endpoints are serialized on
    /// <see cref="RootsDance.Environment.GreenhouseBloomAtmosphere"/> instead of being written from
    /// here, so applying the look never opens or saves a scene.
    /// </para>
    /// <para>
    /// Overwrite-only and idempotent: every override this tool owns is set on each run, and the
    /// overrides it does not name (PSX, ambient occlusion, shadow settings) are left exactly as
    /// authored. Menu: RootsDance > Environment > Apply Greenhouse Bloom Look.
    /// </para>
    /// </summary>
    public static class GreenhouseBloomLookBuilder
    {
        private const string k_LogPrefix = "GreenhouseBloomLook";

        private const string k_ProfilePath =
            "Assets/RootsDance/Settings/VolumeProfiles/GreenhouseInteriorBloomProfile.asset";

        private const string k_SkyCubemapPath =
            "Assets/RootsDance/Textures/Environment/GreenhouseFantasySunsetCubemap.png";

        [MenuItem("RootsDance/Environment/Apply Greenhouse Bloom Look")]
        private static void ApplyFromMenu()
        {
            Apply();
        }

        /// <summary>Applies the authored bloom look and saves the profile asset.</summary>
        public static void Apply()
        {
            VolumeProfile profile = AssetDatabase.LoadAssetAtPath<VolumeProfile>(k_ProfilePath);

            if (profile == null)
            {
                throw new System.InvalidOperationException(
                    "Missing the greenhouse bloom profile at " + k_ProfilePath + ".");
            }

            ApplyLook(profile, GreenhouseBloomParams.Bloom());

            EditorUtility.SetDirty(profile);
            AssetDatabase.SaveAssets();
            Debug.Log("[" + k_LogPrefix + "] Applied the sunset ending look to " + k_ProfilePath + ".");
        }

        private static void ApplyLook(VolumeProfile profile, GreenhouseBloomLook look)
        {
            // The base profile already renders this sky; the bloom profile only re-times it. Naming
            // HDRI here keeps the two profiles on one sky type, so the fade never swaps skies — an
            // HDRI cubemap does not interpolate, it would cut at weight 0.5.
            VisualEnvironment environment = GetOrAdd<VisualEnvironment>(profile);
            Set(environment.skyType, (int)SkyType.HDRI);
            Set(environment.skyAmbientMode, SkyAmbientMode.Dynamic);

            HDRISky sky = GetOrAdd<HDRISky>(profile);
            Set(sky.hdriSky, LoadSkyCubemap());
            Set(sky.skyIntensityMode, SkyIntensityMode.Exposure);
            Set(sky.exposure, look.SkyExposure);
            Set(sky.rotation, look.SkyRotation);
            Set(sky.multiplier, 1f);

            Exposure exposure = GetOrAdd<Exposure>(profile);
            Set(exposure.mode, ExposureMode.Fixed);
            Set(exposure.fixedExposure, look.FixedExposure);

            Tonemapping tonemapping = GetOrAdd<Tonemapping>(profile);
            Set(tonemapping.mode, TonemappingMode.Neutral);

            ColorAdjustments grading = GetOrAdd<ColorAdjustments>(profile);
            Set(grading.colorFilter, look.ColorFilter);
            Set(grading.postExposure, look.PostExposure);
            Set(grading.contrast, look.Contrast);
            Set(grading.saturation, look.Saturation);

            Bloom bloom = GetOrAdd<Bloom>(profile);
            Set(bloom.intensity, look.BloomIntensity);
            Set(bloom.scatter, look.BloomScatter);

            Fog fog = GetOrAdd<Fog>(profile);
            Set(fog.enabled, true);
            Set(fog.meanFreePath, look.FogAttenuationDistance);
            Set(fog.enableVolumetricFog, true);
            Set(fog.albedo, look.FogAlbedo);
            Set(fog.anisotropy, look.FogAnisotropy);
        }

        private static Cubemap LoadSkyCubemap()
        {
            Cubemap cubemap = AssetDatabase.LoadAssetAtPath<Cubemap>(k_SkyCubemapPath);

            if (cubemap == null)
            {
                throw new System.InvalidOperationException(
                    "Missing the greenhouse sunset cubemap at " + k_SkyCubemapPath + ".");
            }

            return cubemap;
        }

        private static T GetOrAdd<T>(VolumeProfile profile) where T : VolumeComponent
        {
            T component;

            if (profile.TryGet(out component))
            {
                return component;
            }

            return VolumeProfileFactory.CreateVolumeComponent<T>(profile, overrides: false, saveAsset: false);
        }

        private static void Set<T>(VolumeParameter<T> parameter, T value)
        {
            parameter.overrideState = true;
            parameter.value = value;
        }
    }
}
