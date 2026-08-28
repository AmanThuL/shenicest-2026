using System;
using System.Collections.Generic;
using RootsDance.Editor.Rendering;
using RootsDance.Editor.Terrain;
using RootsDance.Rendering;
using UnityEditor;
using UnityEditor.Rendering;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Builds the 00章前段 atmosphere into Main_Environment: one Volume Profile and one local Box Volume per
    /// route segment, the overcast Sun values, and the placeholder mote/spore emitters. Re-runnable: volumes and
    /// emitters are rebuilt from the params every time; profiles are only seeded when missing (or with the
    /// explicit overwrite entry) so hand tuning in the Inspector survives a rebuild. The Sun follows the same
    /// rule — a plain re-run only touches it while it still carries its pre-branch value (see
    /// <see cref="SunIsUntouched"/>); once it has been seeded or hand-tuned, only the overwrite entry resets it.
    /// </summary>
    public static class OpeningAtmosphereBuilder
    {
        private const string k_LogPrefix = "OpeningAtmosphereBuilder";
        private const string k_LightingRootName = "_Lighting";
        private const string k_PropsRootName = "_Props";
        private const string k_SunName = "Sun";
        private const float k_UntouchedSunIntensityLux = 20000f;
        private const string k_MainProfilePath = "Assets/RootsDance/Settings/VolumeProfiles/MainProfile.asset";

        // Volumetric fog grid quality shared by every fogged profile: the default Medium preset (12.5 % screen
        // resolution, 64 slices) shows as blocky smears once the fog is this dense.
        private const float k_FogScreenResolutionPercentage = 33f;
        private const int k_FogSliceCount = 128;
        private const float k_FogSliceUniformity = 0.5f;

        [MenuItem("RootsDance/Environment/Build Opening Atmosphere")]
        public static void BuildKeepingProfiles()
        {
            Build(OpeningAtmosphereParams.CreateDefault(), overwriteTuned: false);
        }

        [MenuItem("RootsDance/Environment/Rebuild Opening Atmosphere Profiles (overwrite)")]
        public static void BuildOverwritingProfiles()
        {
            if (!EditorUtility.DisplayDialog("Rebuild Opening Atmosphere Profiles",
                "This resets every Opening*Profile and the Sun to the seed values in OpeningAtmosphereParams, "
                    + "discarding hand tuning. Continue?",
                "Overwrite", "Cancel"))
            {
                return;
            }

            Build(OpeningAtmosphereParams.CreateDefault(), overwriteTuned: true);
        }

        /// <summary>
        /// Writes only the PSX override: the level-wide baseline onto MainProfile and each segment's values onto
        /// its Opening profile. The component selects either PSX or grain, and stock Film Grain is removed so
        /// the alternative grain mode cannot stack with it.
        /// Nothing else on any profile is touched, so hand-tuned fog, sky and exposure survive. Registers the
        /// effect first so a fresh checkout gets a working override.
        /// </summary>
        [MenuItem("RootsDance/Rendering/Apply PSX Baseline")]
        public static void ApplyPsxBaselineFromMenu()
        {
            if (ApplyPsxOnly(OpeningAtmosphereParams.CreateDefault()))
            {
                Debug.Log($"{k_LogPrefix}: PSX baseline applied.");
            }
        }

        /// <summary>
        /// Batch entry point:
        /// <c>-executeMethod
        /// RootsDance.Editor.Environment.OpeningAtmosphereBuilder.ApplyPsxBaselineFromCommandLine</c>.
        /// </summary>
        public static void ApplyPsxBaselineFromCommandLine()
        {
            if (!ApplyPsxOnly(OpeningAtmosphereParams.CreateDefault()))
            {
                throw new InvalidOperationException($"{k_LogPrefix}: PSX baseline failed — see the log above.");
            }
        }

        /// <summary>
        /// Batch equivalent of the overwrite menu entry (no dialog):
        /// <c>-executeMethod RootsDance.Editor.Environment.OpeningAtmosphereBuilder.RebuildFromCommandLine</c>.
        /// Resets every Opening profile and the Sun to the seed values. Throws on failure.
        /// </summary>
        public static void RebuildFromCommandLine()
        {
            if (!Build(OpeningAtmosphereParams.CreateDefault(), overwriteTuned: true))
            {
                throw new InvalidOperationException($"{k_LogPrefix}: rebuild failed — see the log above.");
            }
        }

        /// <summary>
        /// Batch entry point:
        /// <c>-executeMethod RootsDance.Editor.Environment.OpeningAtmosphereBuilder.BuildFromCommandLine</c>.
        /// Throws so the Editor exits with code 1 when anything fails.
        /// </summary>
        public static void BuildFromCommandLine()
        {
            if (!Build(OpeningAtmosphereParams.CreateDefault(), overwriteTuned: false))
            {
                throw new InvalidOperationException($"{k_LogPrefix}: build failed — see the log above.");
            }
        }

        public static string ProfilePath(OpeningAtmosphereParams p, OpeningSegment segment)
        {
            return $"{p.ProfileFolder}/{segment.ProfileName}.asset";
        }

        /// <summary>
        /// Builds everything into the target scene and saves it. Returns false after logging on failure.
        /// </summary>
        public static bool Build(OpeningAtmosphereParams p, bool overwriteTuned)
        {
            if (p == null || p.Segments == null || p.Segments.Length == 0)
            {
                Debug.LogError($"{k_LogPrefix}: no segments — nothing to build.");
                return false;
            }

            PsxPostProcessRegistrar.Register();

            Scene scene;

            if (!TerrainSceneUtility.TryOpenTargetScene(p.ScenePath, k_LogPrefix, out scene))
            {
                return false;
            }

            VolumeProfile[] profiles = new VolumeProfile[p.Segments.Length];

            for (int i = 0; i < p.Segments.Length; i++)
            {
                profiles[i] = EnsureProfile(p, p.Segments[i], overwriteTuned);

                if (profiles[i] == null)
                {
                    return false;
                }
            }

            if (overwriteTuned)
            {
                ApplyBeyondFog(p.BeyondFog);
                ApplyPsxBaseline(p.PsxBaseline);
            }

            AssetDatabase.SaveAssets();

            Transform lighting = TerrainSceneUtility.EnsureRoot(scene, k_LightingRootName);
            EnsureVolumes(p, profiles, EnsureChild(lighting, OpeningAtmosphereParams.k_VolumeRootName));
            ApplySunIfNeeded(p.Sun, lighting, overwriteTuned);

            Transform props = TerrainSceneUtility.EnsureRoot(scene, k_PropsRootName);

            if (!EnsureEmitters(p, EnsureChild(props, OpeningAtmosphereParams.k_VfxRootName), scene))
            {
                return false;
            }

            EditorSceneManager.MarkSceneDirty(scene);

            if (!EditorSceneManager.SaveScene(scene))
            {
                Debug.LogError($"{k_LogPrefix}: failed to save '{p.ScenePath}'.");
                return false;
            }

            AssetDatabase.SaveAssets();
            Debug.Log($"{k_LogPrefix}: built {p.Segments.Length} volumes, {p.Emitters.Length} emitters "
                + $"into {p.ScenePath}.");
            return true;
        }

        // ---- profiles -------------------------------------------------------------------------------------

        private static VolumeProfile EnsureProfile(
            OpeningAtmosphereParams p, OpeningSegment segment, bool overwriteTuned)
        {
            string path = ProfilePath(p, segment);
            VolumeProfile profile = AssetDatabase.LoadAssetAtPath<VolumeProfile>(path);
            bool created = false;

            if (profile == null)
            {
                TerrainSceneUtility.EnsureFolder(p.ProfileFolder);
                profile = VolumeProfileFactory.CreateVolumeProfileAtPath(path);
                created = true;
            }

            if (profile == null)
            {
                Debug.LogError($"{k_LogPrefix}: could not create '{path}'.");
                return null;
            }

            if (created || overwriteTuned)
            {
                ApplyLook(profile, segment.Look);
                EditorUtility.SetDirty(profile);
                Debug.Log($"{k_LogPrefix}: {(created ? "created" : "overwrote")} {path}.");
            }

            return profile;
        }

        /// <summary>
        /// Writes only the Fog override of MainProfile so the haze continues north of the opening. Overwrite-only:
        /// MainProfile is the level artist's asset and a plain re-run must not touch it.
        /// </summary>
        private static void ApplyBeyondFog(OpeningBeyondFog beyond)
        {
            VolumeProfile main = AssetDatabase.LoadAssetAtPath<VolumeProfile>(k_MainProfilePath);

            if (main == null || beyond == null)
            {
                Debug.LogWarning($"{k_LogPrefix}: '{k_MainProfilePath}' not found; beyond-threshold fog not applied.");
                return;
            }

            Fog fog = GetOrAdd<Fog>(main);
            Set(fog.enabled, true);
            Set(fog.colorMode, FogColorMode.SkyColor);
            Set(fog.tint, Color.white);
            Set(fog.meanFreePath, beyond.AttenuationDistance);
            Set(fog.baseHeight, beyond.BaseHeight);
            Set(fog.maximumHeight, beyond.MaximumHeight);
            Set(fog.enableVolumetricFog, true);
            Set(fog.albedo, beyond.Albedo);
            Set(fog.anisotropy, beyond.Anisotropy);
            Set(fog.globalLightProbeDimmer, beyond.AmbientDimmer);
            Set(fog.depthExtent, beyond.VolumetricDistance);
            Set(fog.multipleScatteringIntensity, beyond.MultipleScattering);
            ApplyFogQuality(fog);
            EditorUtility.SetDirty(main);
            Debug.Log($"{k_LogPrefix}: applied the beyond-threshold fog to {k_MainProfilePath}.");
        }

        /// <summary>See <see cref="ApplyPsxBaselineFromMenu"/>. Returns false after logging on failure.</summary>
        public static bool ApplyPsxOnly(OpeningAtmosphereParams p)
        {
            if (p == null || p.Segments == null || p.PsxBaseline == null)
            {
                Debug.LogError($"{k_LogPrefix}: no params — nothing to apply.");
                return false;
            }

            PsxPostProcessRegistrar.Register();

            if (!ApplyPsxBaseline(p.PsxBaseline))
            {
                return false;
            }

            foreach (OpeningSegment segment in p.Segments)
            {
                string path = ProfilePath(p, segment);
                VolumeProfile profile = AssetDatabase.LoadAssetAtPath<VolumeProfile>(path);

                if (profile == null)
                {
                    Debug.LogError($"{k_LogPrefix}: '{path}' not found — run Build Opening Atmosphere first.");
                    return false;
                }

                ApplyPsx(profile, segment.Look.Psx);
                EditorUtility.SetDirty(profile);
            }

            AssetDatabase.SaveAssets();
            return true;
        }

        /// <summary>Writes the always-on PSX look onto MainProfile. Returns false after logging on failure.</summary>
        private static bool ApplyPsxBaseline(PsxLook baseline)
        {
            VolumeProfile main = AssetDatabase.LoadAssetAtPath<VolumeProfile>(k_MainProfilePath);

            if (main == null || baseline == null)
            {
                Debug.LogError($"{k_LogPrefix}: '{k_MainProfilePath}' not found; PSX baseline not applied.");
                return false;
            }

            ApplyPsx(main, baseline);
            EditorUtility.SetDirty(main);
            Debug.Log($"{k_LogPrefix}: applied the PSX baseline to {k_MainProfilePath}.");
            return true;
        }

        /// <summary>
        /// Writes every <see cref="PsxPostProcess"/> parameter and removes HDRP's Film Grain from the profile:
        /// two grain layers stack into mud, and the PSX grain is the one that survives the quantiser.
        /// </summary>
        private static void ApplyPsx(VolumeProfile profile, PsxLook look)
        {
            PsxPostProcess psx = GetOrAdd<PsxPostProcess>(profile);
            Set(psx.intensity, look.Intensity);
            Set(psx.grainMode, look.GrainMode);
            Set(psx.pixelScale, look.PixelScale);
            Set(psx.colorLevels, look.ColorLevels);
            Set(psx.ditherStrength, look.Dither);
            Set(psx.interlaceStrength, look.InterlaceStrength);
            Set(psx.interlaceSize, look.InterlaceSize);
            Set(psx.grainIntensity, look.GrainIntensity);
            Set(psx.grainSize, look.GrainSize);
            Set(psx.grainRate, look.GrainRate);
            Set(psx.grainShadowBias, look.GrainShadowBias);
            RemoveComponent<FilmGrain>(profile);
        }

        /// <summary>
        /// VolumeProfile.Remove only unlists the component; the sub-asset stays in the file until it is also
        /// removed from the asset and destroyed (what the Volume Inspector's "Remove" does).
        /// </summary>
        private static void RemoveComponent<T>(VolumeProfile profile) where T : VolumeComponent
        {
            T component;

            if (!profile.TryGet(out component))
            {
                return;
            }

            profile.Remove<T>();
            AssetDatabase.RemoveObjectFromAsset(component);
            UnityEngine.Object.DestroyImmediate(component, true);
        }

        /// <summary>Custom quality level with a manual, denser volumetric grid (see the constants above).</summary>
        private static void ApplyFogQuality(Fog fog)
        {
            Set(fog.quality, ScalableSettingLevelParameter.LevelCount); // LevelCount == the Custom level
            fog.fogControlMode = FogControl.Manual;
            Set(fog.screenResolutionPercentage, k_FogScreenResolutionPercentage);
            Set(fog.volumeSliceCount, k_FogSliceCount);
            Set(fog.sliceDistributionUniformity, k_FogSliceUniformity);
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

        private static void ApplyLook(VolumeProfile profile, OpeningLook look)
        {
            VisualEnvironment environment = GetOrAdd<VisualEnvironment>(profile);
            Set(environment.skyType, (int)SkyType.Gradient);
            Set(environment.cloudType, 0); // 0 = no cloud layer (CloudType has no None member)
            Set(environment.skyAmbientMode, SkyAmbientMode.Dynamic);

            GradientSky sky = GetOrAdd<GradientSky>(profile);
            Set(sky.top, look.SkyTop);
            Set(sky.middle, look.SkyMiddle);
            Set(sky.bottom, look.SkyBottom);
            Set(sky.gradientDiffusion, look.SkyDiffusion);
            Set(sky.skyIntensityMode, SkyIntensityMode.Exposure);
            Set(sky.exposure, look.SkyExposure);
            Set(sky.multiplier, 1f);

            Fog fog = GetOrAdd<Fog>(profile);
            Set(fog.enabled, true);
            Set(fog.colorMode, FogColorMode.SkyColor);
            Set(fog.tint, look.FogTint);
            Set(fog.maxFogDistance, 5000f);
            Set(fog.meanFreePath, look.FogAttenuationDistance);
            Set(fog.baseHeight, look.FogBaseHeight);
            Set(fog.maximumHeight, look.FogMaximumHeight);
            Set(fog.enableVolumetricFog, true);
            Set(fog.albedo, look.FogAlbedo);
            Set(fog.anisotropy, look.FogAnisotropy);
            Set(fog.globalLightProbeDimmer, look.AmbientDimmer);
            Set(fog.depthExtent, look.FogVolumetricDistance);
            Set(fog.multipleScatteringIntensity, look.FogMultipleScattering);
            Set(fog.denoisingMode, FogDenoisingMode.Gaussian);
            ApplyFogQuality(fog);

            Exposure exposure = GetOrAdd<Exposure>(profile);
            Set(exposure.mode, ExposureMode.Fixed);
            Set(exposure.fixedExposure, look.FixedExposure);

            Tonemapping tonemapping = GetOrAdd<Tonemapping>(profile);
            Set(tonemapping.mode, TonemappingMode.Neutral);

            Bloom bloom = GetOrAdd<Bloom>(profile);
            Set(bloom.threshold, 0f);
            Set(bloom.intensity, look.BloomIntensity);
            Set(bloom.scatter, 0.7f);
            bloom.highQualityFiltering = true;

            ColorAdjustments grading = GetOrAdd<ColorAdjustments>(profile);
            Set(grading.postExposure, 0f);
            Set(grading.contrast, look.Contrast);
            Set(grading.saturation, look.Saturation);
            Set(grading.colorFilter, look.ColorFilter);

            Vignette vignette = GetOrAdd<Vignette>(profile);
            Set(vignette.mode, VignetteMode.Procedural);
            Set(vignette.intensity, look.VignetteIntensity);
            Set(vignette.smoothness, 0.45f);
            Set(vignette.roundness, 1f);
            Set(vignette.rounded, false);

            ApplyPsx(profile, look.Psx);
        }

        // ---- scene objects ---------------------------------------------------------------------------------

        private static Transform EnsureChild(Transform parent, string name)
        {
            Transform child = parent.Find(name);

            if (child != null)
            {
                return child;
            }

            GameObject created = new GameObject(name);
            created.transform.SetParent(parent, false);
            Undo.RegisterCreatedObjectUndo(created, "Create " + name);
            return created.transform;
        }

        private static void RemoveChildrenNotNamed(Transform parent, string[] keep)
        {
            for (int i = parent.childCount - 1; i >= 0; i--)
            {
                Transform child = parent.GetChild(i);

                if (Array.IndexOf(keep, child.name) < 0)
                {
                    Undo.DestroyObjectImmediate(child.gameObject);
                }
            }
        }

        private static void EnsureVolumes(OpeningAtmosphereParams p, VolumeProfile[] profiles, Transform root)
        {
            string[] names = new string[p.Segments.Length];

            for (int i = 0; i < p.Segments.Length; i++)
            {
                names[i] = p.Segments[i].Name;
            }

            RemoveChildrenNotNamed(root, names);

            for (int i = 0; i < p.Segments.Length; i++)
            {
                OpeningSegment segment = p.Segments[i];
                Transform child = EnsureChild(root, segment.Name);
                child.position = segment.Center;
                child.rotation = Quaternion.identity;
                child.localScale = Vector3.one;

                BoxCollider collider = child.GetComponent<BoxCollider>();

                if (collider == null)
                {
                    collider = child.gameObject.AddComponent<BoxCollider>();
                }

                collider.isTrigger = true;
                collider.center = Vector3.zero;
                collider.size = segment.Size;

                Volume volume = child.GetComponent<Volume>();

                if (volume == null)
                {
                    volume = child.gameObject.AddComponent<Volume>();
                }

                volume.isGlobal = false;
                volume.priority = segment.Priority;
                volume.blendDistance = segment.BlendDistance;
                volume.weight = 1f;
                volume.sharedProfile = profiles[i];
            }
        }

        /// <summary>
        /// Applies the Sun seed values only when explicitly asked to, or the Sun still carries its pre-branch
        /// value (see <see cref="SunIsUntouched"/>) — so a plain re-run never clobbers hand tuning done after the
        /// first seed. Logs which of the two branches (or neither) fired.
        /// </summary>
        private static void ApplySunIfNeeded(OpeningSunSettings sun, Transform lighting, bool overwriteTuned)
        {
            Light light = FindSunLight(lighting);

            if (light == null)
            {
                return;
            }

            if (overwriteTuned)
            {
                Debug.Log($"{k_LogPrefix}: overwriteTuned is set — applying Sun seed values.");
            }
            else if (SunIsUntouched(light))
            {
                Debug.Log($"{k_LogPrefix}: Sun is still untouched ({light.intensity} lux) — applying seed values.");
            }
            else
            {
                Debug.Log($"{k_LogPrefix}: Sun already tuned ({light.intensity} lux) — leaving it alone.");
                return;
            }

            ApplySun(sun, light);
        }

        private static Light FindSunLight(Transform lighting)
        {
            Transform sunTransform = lighting.Find(k_SunName);

            if (sunTransform == null)
            {
                Debug.LogWarning($"{k_LogPrefix}: no '{k_LightingRootName}/{k_SunName}' in the scene; "
                    + "sun values not applied.");
                return null;
            }

            Light light = sunTransform.GetComponent<Light>();

            if (light == null)
            {
                Debug.LogWarning($"{k_LogPrefix}: '{k_SunName}' has no Light component; sun values not applied.");
            }

            return light;
        }

        /// <summary>
        /// True when the Sun still carries the value it had before this builder ever touched it (20 000 lux,
        /// Lux unit — the pre-branch <c>PlayerTest</c>-style default), i.e. neither seeded nor hand-tuned yet.
        /// </summary>
        private static bool SunIsUntouched(Light light)
        {
            return light.lightUnit == LightUnit.Lux
                && Mathf.Approximately(light.intensity, k_UntouchedSunIntensityLux);
        }

        private static void ApplySun(OpeningSunSettings sun, Light light)
        {
            Transform sunTransform = light.transform;
            HDAdditionalLightData hdLight = sunTransform.GetComponent<HDAdditionalLightData>();

            if (hdLight == null)
            {
                hdLight = sunTransform.gameObject.AddComponent<HDAdditionalLightData>();
            }

            light.lightUnit = LightUnit.Lux;
            light.intensity = sun.IntensityLux;
            light.color = sun.Color;
            light.useColorTemperature = false;
            hdLight.angularDiameter = sun.AngularDiameter;
            hdLight.shadowDimmer = sun.ShadowDimmer;
            EditorUtility.SetDirty(light);
            EditorUtility.SetDirty(hdLight);
        }

        private static bool EnsureEmitters(OpeningAtmosphereParams p, Transform root, Scene scene)
        {
            string[] names = new string[p.Emitters.Length];

            for (int i = 0; i < p.Emitters.Length; i++)
            {
                names[i] = p.Emitters[i].Name;
            }

            RemoveChildrenNotNamed(root, names);

            // One material/prefab per kind: ensure (and re-apply the recipe to) each kind once per build.
            Dictionary<OpeningVfxKind, GameObject> prefabs = new Dictionary<OpeningVfxKind, GameObject>();

            for (int i = 0; i < p.Emitters.Length; i++)
            {
                OpeningVfxEmitter emitter = p.Emitters[i];
                GameObject prefab;

                if (!prefabs.TryGetValue(emitter.Kind, out prefab))
                {
                    prefab = OpeningVfxPrefabBuilder.EnsurePrefab(emitter.Kind);
                    prefabs[emitter.Kind] = prefab;
                }

                if (prefab == null)
                {
                    return false;
                }

                Transform existing = root.Find(emitter.Name);

                if (existing != null && PrefabUtility.GetCorrespondingObjectFromSource(existing.gameObject) != prefab)
                {
                    Undo.DestroyObjectImmediate(existing.gameObject);
                    existing = null;
                }

                if (existing == null)
                {
                    GameObject instance = (GameObject)PrefabUtility.InstantiatePrefab(prefab, scene);
                    instance.name = emitter.Name;
                    instance.transform.SetParent(root, false);
                    Undo.RegisterCreatedObjectUndo(instance, "Create " + emitter.Name);
                    existing = instance.transform;
                }

                existing.position = emitter.Center;
                existing.rotation = Quaternion.identity;
                existing.localScale = emitter.Size;

                ParticleSystem system = existing.GetComponent<ParticleSystem>();

                if (system != null)
                {
                    ParticleSystem.EmissionModule emission = system.emission;
                    emission.rateOverTime = emitter.RateOverTime;
                }
            }

            return true;
        }
    }
}
