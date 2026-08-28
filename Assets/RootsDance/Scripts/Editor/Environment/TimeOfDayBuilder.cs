using RootsDance.App;
using RootsDance.Core;
using RootsDance.Editor.Terrain;
using RootsDance.Environment;
using RootsDance.Events;
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
    /// Builds the discrete time-of-day presentation into Main_Environment: the TimeOfDayChanged event
    /// channel, the NightProfile volume profile, one preset asset per <see cref="TimeOfDay"/> value, and the
    /// <c>_Lighting/TimeOfDay</c> GameObject carrying the global Volume the controller fades. Re-runnable:
    /// the scene objects and their wiring are rebuilt every time, while NightProfile and the two presets are
    /// only seeded when missing — hand tuning in the Inspector survives a plain re-run and is reset only by
    /// the explicit overwrite entry, the same rule the Opening profiles follow.
    /// </summary>
    public static class TimeOfDayBuilder
    {
        private const string k_LogPrefix = "TimeOfDayBuilder";

        // ---- asset paths ---------------------------------------------------------------------------------

        private const string k_EventsFolder = "Assets/RootsDance/Data/Events";
        private const string k_TimeOfDayChangedPath = k_EventsFolder + "/TimeOfDayChanged.asset";
        private const string k_ProfileFolder = "Assets/RootsDance/Settings/VolumeProfiles";
        private const string k_NightProfilePath = k_ProfileFolder + "/NightProfile.asset";
        private const string k_PresetFolder = "Assets/RootsDance/Data/Config/TimeOfDay";
        private const string k_DayPresetPath = k_PresetFolder + "/Day.asset";
        private const string k_NightPresetPath = k_PresetFolder + "/Night.asset";

        // ---- scene object names --------------------------------------------------------------------------

        private const string k_LightingRootName = "_Lighting";
        private const string k_SunName = "Sun";
        private const string k_TimeOfDayName = "TimeOfDay";

        // ---- NightProfile seed values (design doc §2) ----------------------------------------------------
        // Only the parameters written here end up overridden. Deliberately absent: VisualEnvironment (the sky
        // type stays Gradient from MainProfile) and the Fog density block (meanFreePath, baseHeight,
        // maximumHeight, depthExtent, quality) — the opening volumes' 8 → 22 → 40 m ramp must survive at night.

        /// <summary>Fixed exposure in EV100 — guideline 07 §5.2's "dark corridor / dusk" bracket.</summary>
        private const float k_NightFixedExposure = 5f;

        // Second pass (playtest 2026-08-28): a readable night — silhouettes and ground visible without the
        // torch, the torch still ~2 stops above the ambient so it reveals detail rather than just brightness.
        private static readonly Color k_NightSkyTop = new Color(0.03f, 0.05f, 0.10f);
        private static readonly Color k_NightSkyMiddle = new Color(0.08f, 0.11f, 0.18f);
        private static readonly Color k_NightSkyBottom = new Color(0.06f, 0.07f, 0.09f);
        private const float k_NightSkyExposure = 3.5f;
        private const float k_NightSkyMultiplier = 1f;

        /// <summary>Single-scattering albedo: a cold blue haze instead of MainProfile's neutral grey.</summary>
        private static readonly Color k_NightFogAlbedo = new Color(0.72f, 0.80f, 0.95f);

        /// <summary>Forward-biased scattering so the flashlight cone reads as a beam in the fog.</summary>
        private const float k_NightFogAnisotropy = 0.35f;

        private const float k_NightFogMultipleScattering = 1f;

        // ---- preset seed values (design doc §2) ----------------------------------------------------------
        // Day mirrors whatever the scene's Sun already carries, so "Day" means "the authored look"; these
        // constants are only the fallback for a scene without a Sun.

        private const float k_DayFallbackSunLux = 12000f;
        private static readonly Color k_DayFallbackSunColor = new Color(1f, 0.96f, 0.88f);
        private const float k_DaySunVolumetricMultiplier = 1f;

        /// <summary>
        /// Moonlight, in lux — a stylised bright moon (a real full moon is ~0.3 lux). At fixed EV 5 this keeps
        /// unlit ground about two stops under mid-grey: visible, clearly night; the 8 lux first pass read black.
        /// </summary>
        private const float k_NightSunLux = 25f;

        private static readonly Color k_NightSunColor = new Color(0.62f, 0.72f, 1f);

        /// <summary>HDRP light Volumetrics Multiplier at night: dimmed so the brighter moon does not turn the
        /// fog into a uniform grey wash that would swallow the torch beam.</summary>
        private const float k_NightSunVolumetricMultiplier = 0.4f;

        // ---- scene object values -------------------------------------------------------------------------

        /// <summary>Above the opening's local volumes (priorities 10–13) so night wins over every segment.</summary>
        private const float k_VolumePriority = 20f;

        /// <summary>Seconds of cross-fade between two phases; only written when the component is created.</summary>
        private const float k_BlendSeconds = 2f;

        [MenuItem("RootsDance/Environment/Build Time Of Day")]
        public static void BuildKeepingProfile()
        {
            Build(overwriteTuned: false);
        }

        [MenuItem("RootsDance/Environment/Rebuild Time Of Day Profile (overwrite)")]
        public static void BuildOverwritingProfile()
        {
            if (!EditorUtility.DisplayDialog("Rebuild Time Of Day Profile",
                "This resets NightProfile and both time-of-day presets to their seed values, discarding hand "
                    + "tuning. Continue?",
                "Overwrite", "Cancel"))
            {
                return;
            }

            Build(overwriteTuned: true);
        }

        /// <summary>
        /// Batch entry point:
        /// <c>-executeMethod RootsDance.Editor.Environment.TimeOfDayBuilder.BuildFromCommandLine</c>.
        /// Throws so the Editor exits with code 1 when anything fails.
        /// </summary>
        public static void BuildFromCommandLine()
        {
            if (!Build(overwriteTuned: false))
            {
                throw new System.InvalidOperationException($"{k_LogPrefix}: build failed — see the log above.");
            }
        }

        /// <summary>
        /// Batch equivalent of the overwrite menu entry (no dialog):
        /// <c>-executeMethod RootsDance.Editor.Environment.TimeOfDayBuilder.RebuildFromCommandLine</c>.
        /// Resets NightProfile and both presets to the seed values. Throws on failure.
        /// </summary>
        public static void RebuildFromCommandLine()
        {
            if (!Build(overwriteTuned: true))
            {
                throw new System.InvalidOperationException($"{k_LogPrefix}: rebuild failed — see the log above.");
            }
        }

        /// <summary>
        /// One-shot batch install of the whole feature, in dependency order: the bootstrap wiring (channel
        /// asset), this builder, the Player flashlight, and the Dev Play checkpoints set to Night.
        /// <c>-executeMethod RootsDance.Editor.Environment.TimeOfDayBuilder.BuildAllFromCommandLine</c>.
        /// Each step is idempotent; each throws on failure so the Editor exits with code 1.
        /// </summary>
        public static void BuildAllFromCommandLine()
        {
            RootsDance.Editor.Tools.BootstrapSceneBuilder.BuildFromCommandLine();
            BuildFromCommandLine();
            RootsDance.Editor.Tools.PlayerFlashlightInstaller.InstallFromCommandLine();
            RootsDance.Editor.DevPlay.DevCheckpointDefaults.SetAllTimeOfDayToNight();
        }

        /// <summary>
        /// Builds every asset and the scene objects, then saves both. Returns false after logging on failure.
        /// </summary>
        /// <param name="overwriteTuned">True to reset NightProfile and the presets to their seed values.</param>
        /// <returns>True when everything is in place and Main_Environment has been saved.</returns>
        public static bool Build(bool overwriteTuned)
        {
            Scene scene;

            // Opened first because the Day preset seeds itself from whatever the scene's Sun currently is.
            if (!TerrainSceneUtility.TryOpenTargetScene(ScenePaths.k_MainEnvironment, k_LogPrefix, out scene))
            {
                return false;
            }

            EnsureChannel();

            if (EnsureNightProfile(overwriteTuned) == null)
            {
                return false;
            }

            AssetDatabase.SaveAssets();

            // Load the profile back from disk before it is stored in a preset: creating an asset can
            // invalidate the instance the factory handed back, and an invalidated reference serializes as
            // "None" instead of failing.
            VolumeProfile nightProfile = AssetDatabase.LoadAssetAtPath<VolumeProfile>(k_NightProfilePath);

            if (nightProfile == null)
            {
                Debug.LogError($"{k_LogPrefix}: could not load '{k_NightProfilePath}' back after creating it.");
                return false;
            }

            Transform lighting = TerrainSceneUtility.EnsureRoot(scene, k_LightingRootName);
            Light sun = FindSunLight(lighting);
            ApplySunUnit(sun);
            EnsurePresets(sun, nightProfile, overwriteTuned);
            AssetDatabase.SaveAssets();

            // Re-load every asset from its path immediately before wiring. Creating an asset can invalidate
            // the instance CreateAsset handed back (an import in between reloads it), and assigning an
            // invalidated object silently serializes as "None" instead of failing.
            TimeOfDayPresetSO day = AssetDatabase.LoadAssetAtPath<TimeOfDayPresetSO>(k_DayPresetPath);
            TimeOfDayPresetSO night = AssetDatabase.LoadAssetAtPath<TimeOfDayPresetSO>(k_NightPresetPath);
            TimeOfDayEventChannelSO channel =
                AssetDatabase.LoadAssetAtPath<TimeOfDayEventChannelSO>(k_TimeOfDayChangedPath);

            if (day == null || night == null || channel == null)
            {
                Debug.LogError($"{k_LogPrefix}: could not load {k_DayPresetPath}, {k_NightPresetPath} or "
                    + $"{k_TimeOfDayChangedPath}; the controller would be left unwired.");
                return false;
            }

            Transform holder = EnsureChild(lighting, k_TimeOfDayName);
            Volume volume = EnsureVolume(holder);
            WireController(holder, volume, sun, day, night, channel);

            EditorSceneManager.MarkSceneDirty(scene);

            if (!EditorSceneManager.SaveScene(scene))
            {
                Debug.LogError($"{k_LogPrefix}: failed to save '{ScenePaths.k_MainEnvironment}'.");
                return false;
            }

            AssetDatabase.SaveAssets();
            Debug.Log($"{k_LogPrefix}: {k_NightProfilePath}, {k_DayPresetPath}, {k_NightPresetPath} and "
                + $"{k_LightingRootName}/{k_TimeOfDayName} (global Volume, priority {k_VolumePriority}, weight 0) "
                + $"are in place in {ScenePaths.k_MainEnvironment}.");
            return true;
        }

        // ---- assets ---------------------------------------------------------------------------------------

        /// <summary>
        /// Find-or-create the TimeOfDayChanged channel. BootstrapSceneBuilder creates the same asset; both
        /// are "ensure" steps, so whichever runs first wins and the other is a no-op.
        /// </summary>
        private static void EnsureChannel()
        {
            if (AssetDatabase.LoadAssetAtPath<TimeOfDayEventChannelSO>(k_TimeOfDayChangedPath) != null)
            {
                return;
            }

            TerrainSceneUtility.EnsureFolder(k_EventsFolder);
            TimeOfDayEventChannelSO channel = ScriptableObject.CreateInstance<TimeOfDayEventChannelSO>();
            AssetDatabase.CreateAsset(channel, k_TimeOfDayChangedPath);
            AssetDatabase.SaveAssets();
            Debug.Log($"{k_LogPrefix}: created the event channel asset {k_TimeOfDayChangedPath}.");
        }

        private static VolumeProfile EnsureNightProfile(bool overwriteTuned)
        {
            VolumeProfile profile = AssetDatabase.LoadAssetAtPath<VolumeProfile>(k_NightProfilePath);
            bool created = false;

            if (profile == null)
            {
                TerrainSceneUtility.EnsureFolder(k_ProfileFolder);
                profile = VolumeProfileFactory.CreateVolumeProfileAtPath(k_NightProfilePath);
                created = true;
            }

            if (profile == null)
            {
                Debug.LogError($"{k_LogPrefix}: could not create '{k_NightProfilePath}'.");
                return null;
            }

            if (created || overwriteTuned)
            {
                ApplyNightLook(profile);
                EditorUtility.SetDirty(profile);
                Debug.Log($"{k_LogPrefix}: {(created ? "created" : "overwrote")} {k_NightProfilePath}.");
            }

            return profile;
        }

        /// <summary>
        /// Writes the night look. Every parameter touched here becomes an override; everything else keeps
        /// coming from the volumes underneath, which is the whole point — this profile re-colours the opening
        /// atmosphere instead of replacing it.
        /// </summary>
        private static void ApplyNightLook(VolumeProfile profile)
        {
            Exposure exposure = GetOrAdd<Exposure>(profile);
            Set(exposure.mode, ExposureMode.Fixed);
            Set(exposure.fixedExposure, k_NightFixedExposure);

            GradientSky sky = GetOrAdd<GradientSky>(profile);
            Set(sky.top, k_NightSkyTop);
            Set(sky.middle, k_NightSkyMiddle);
            Set(sky.bottom, k_NightSkyBottom);
            Set(sky.exposure, k_NightSkyExposure);
            Set(sky.multiplier, k_NightSkyMultiplier);

            Fog fog = GetOrAdd<Fog>(profile);
            Set(fog.albedo, k_NightFogAlbedo);
            Set(fog.anisotropy, k_NightFogAnisotropy);
            Set(fog.multipleScatteringIntensity, k_NightFogMultipleScattering);
            Set(fog.tint, Color.white);
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

        private static void EnsurePresets(Light sun, VolumeProfile nightProfile, bool overwriteTuned)
        {
            float dayLux = k_DayFallbackSunLux;
            Color dayColor = k_DayFallbackSunColor;

            if (sun != null)
            {
                dayLux = sun.intensity;
                dayColor = sun.color;
            }

            // Day has no profile: the Volume simply fades to weight 0 and the scene-authored look shows.
            EnsurePreset(k_DayPresetPath, TimeOfDay.Day, null, dayLux, dayColor, k_DaySunVolumetricMultiplier,
                overwriteTuned);
            EnsurePreset(k_NightPresetPath, TimeOfDay.Night, nightProfile, k_NightSunLux, k_NightSunColor,
                k_NightSunVolumetricMultiplier, overwriteTuned);
        }

        private static void EnsurePreset(string path, TimeOfDay phase, VolumeProfile profile, float sunIntensityLux,
            Color sunColor, float sunVolumetricMultiplier, bool overwriteTuned)
        {
            TimeOfDayPresetSO preset = AssetDatabase.LoadAssetAtPath<TimeOfDayPresetSO>(path);

            if (preset != null)
            {
                if (!overwriteTuned)
                {
                    return;
                }

                preset.Configure(phase, profile, sunIntensityLux, sunColor, sunVolumetricMultiplier);
                EditorUtility.SetDirty(preset);
                Debug.Log($"{k_LogPrefix}: overwrote {path} ({phase}, {sunIntensityLux} lux).");
                return;
            }

            // Fill the instance before it becomes an asset: CreateAsset serializes what it is handed, and the
            // instance it hands back can be invalidated by the import that follows.
            TerrainSceneUtility.EnsureFolder(k_PresetFolder);
            preset = ScriptableObject.CreateInstance<TimeOfDayPresetSO>();
            preset.Configure(phase, profile, sunIntensityLux, sunColor, sunVolumetricMultiplier);
            AssetDatabase.CreateAsset(preset, path);
            Debug.Log($"{k_LogPrefix}: created {path} ({phase}, {sunIntensityLux} lux).");
        }

        // ---- scene objects --------------------------------------------------------------------------------

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

        private static Light FindSunLight(Transform lighting)
        {
            Transform sunTransform = lighting.Find(k_SunName);

            if (sunTransform == null)
            {
                Debug.LogWarning($"{k_LogPrefix}: no '{k_LightingRootName}/{k_SunName}' in the scene; the "
                    + "controller's Sun stays unwired and the Day preset falls back to its seed values.");
                return null;
            }

            Light light = sunTransform.GetComponent<Light>();

            if (light == null)
            {
                Debug.LogWarning($"{k_LogPrefix}: '{k_SunName}' has no Light component.");
            }

            return light;
        }

        /// <summary>
        /// The controller writes the Sun's brightness straight into <c>Light.intensity</c>, so the unit has to
        /// be Lux for the preset's lux values to mean anything. Directional lights accept Lux only anyway
        /// (guideline 07 §5.1) — this only repairs a light that was authored in another unit.
        /// </summary>
        private static void ApplySunUnit(Light sun)
        {
            if (sun == null || sun.lightUnit == LightUnit.Lux)
            {
                return;
            }

            sun.lightUnit = LightUnit.Lux;
            EditorUtility.SetDirty(sun);
            Debug.Log($"{k_LogPrefix}: switched '{k_SunName}' to Lux.");
        }

        private static Volume EnsureVolume(Transform holder)
        {
            holder.localPosition = Vector3.zero;
            holder.localRotation = Quaternion.identity;
            holder.localScale = Vector3.one;

            Volume volume = holder.GetComponent<Volume>();

            if (volume == null)
            {
                volume = holder.gameObject.AddComponent<Volume>();
            }

            // The authored state is "off": the controller owns weight and profile from Start onwards, so the
            // scene must never ship with a night look baked in at weight 1.
            volume.isGlobal = true;
            volume.priority = k_VolumePriority;
            volume.weight = 0f;
            volume.sharedProfile = null;
            return volume;
        }

        private static void WireController(Transform holder, Volume volume, Light sun, TimeOfDayPresetSO day,
            TimeOfDayPresetSO night, TimeOfDayEventChannelSO channel)
        {
            TimeOfDayController controller = holder.GetComponent<TimeOfDayController>();
            bool created = false;

            if (controller == null)
            {
                controller = holder.gameObject.AddComponent<TimeOfDayController>();
                created = true;
            }

            SerializedObject serialized = new SerializedObject(controller);

            // TimeOfDay is Day = 0, Night = 1, so the enum index and the value are the same number.
            serialized.FindProperty("m_levelDefault").enumValueIndex = (int)TimeOfDay.Night;

            SerializedProperty presets = serialized.FindProperty("m_presets");
            presets.arraySize = 2;
            presets.GetArrayElementAtIndex(0).objectReferenceValue = day;
            presets.GetArrayElementAtIndex(1).objectReferenceValue = night;

            serialized.FindProperty("m_volume").objectReferenceValue = volume;
            serialized.FindProperty("m_timeOfDayChanged").objectReferenceValue = channel;

            if (sun != null)
            {
                serialized.FindProperty("m_sun").objectReferenceValue = sun;
            }

            if (created)
            {
                // Only when the component is new — a hand-tuned blend length survives a re-run.
                serialized.FindProperty("m_blendSeconds").floatValue = k_BlendSeconds;
            }

            serialized.ApplyModifiedProperties();
        }
    }
}
