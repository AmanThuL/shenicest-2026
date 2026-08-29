using System;
using System.Collections.Generic;
using RootsDance.Editor.Rendering;
using RootsDance.Editor.Terrain;
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
    /// Builds the continuous A-E exterior atmosphere. Profiles are seed-once assets: an ordinary rebuild keeps
    /// Inspector tuning, and only the explicitly named overwrite entry reapplies the code defaults. Scene objects
    /// are always reconciled idempotently under _Lighting/Chapter00ExteriorAtmosphere.
    /// </summary>
    public static class Chapter00ZoneAtmosphereBuilder
    {
        private const string k_LogPrefix = "Chapter00ZoneAtmosphereBuilder";
        private const string k_LightingRootName = "_Lighting";
        private const float k_FogScreenResolutionPercentage = 33f;
        private const int k_FogSliceCount = 128;
        private const float k_FogSliceUniformity = 0.5f;

        [MenuItem("RootsDance/Environment/Chapter 00/Preview A-E Zone Atmosphere (keep profiles)")]
        public static void PreviewKeepingProfiles()
        {
            Build(Chapter00ZoneAtmosphereParams.CreateDefault(), overwriteTuned: false, saveScene: false);
        }

        [MenuItem("RootsDance/Environment/Chapter 00/Preview A-E Zone Atmosphere Profiles (overwrite)")]
        public static void PreviewOverwritingProfiles()
        {
            if (!EditorUtility.DisplayDialog("Overwrite Chapter 00 A-E Atmosphere Profiles",
                "This resets all five zone profiles to the code seed values. The scene remains unsaved so the "
                    + "placement can be reviewed before committing it. Continue?",
                "Overwrite", "Cancel"))
            {
                return;
            }

            Build(Chapter00ZoneAtmosphereParams.CreateDefault(), overwriteTuned: true, saveScene: false);
        }

        [MenuItem("RootsDance/Environment/Chapter 00/Build And Save A-E Zone Atmosphere (keep profiles)")]
        public static void BuildAndSaveKeepingProfiles()
        {
            Build(Chapter00ZoneAtmosphereParams.CreateDefault(), overwriteTuned: false, saveScene: true);
        }

        [MenuItem("RootsDance/Environment/Chapter 00/Validate A-E Zone Atmosphere")]
        public static void ValidateFromMenu()
        {
            ValidateInstalledFromCommandLine();
        }

        /// <summary>
        /// Batch content entry. It keeps tuned profiles, reconciles the five scene volumes, and saves the scene:
        /// <c>-executeMethod RootsDance.Editor.Environment.Chapter00ZoneAtmosphereBuilder.BuildFromCommandLine</c>.
        /// </summary>
        public static void BuildFromCommandLine()
        {
            if (!Build(Chapter00ZoneAtmosphereParams.CreateDefault(), overwriteTuned: false, saveScene: true))
            {
                throw new InvalidOperationException($"{k_LogPrefix}: build failed — see the log above.");
            }
        }

        /// <summary>Batch overwrite entry. This is the only non-interactive entry that resets tuned profiles.</summary>
        public static void RebuildFromCommandLine()
        {
            if (!Build(Chapter00ZoneAtmosphereParams.CreateDefault(), overwriteTuned: true, saveScene: true))
            {
                throw new InvalidOperationException($"{k_LogPrefix}: rebuild failed — see the log above.");
            }
        }

        /// <summary>Batch preview entry: builds assets and in-memory scene objects but deliberately does not save.</summary>
        public static void PreviewFromCommandLine()
        {
            if (!Build(Chapter00ZoneAtmosphereParams.CreateDefault(), overwriteTuned: false, saveScene: false))
            {
                throw new InvalidOperationException($"{k_LogPrefix}: preview failed — see the log above.");
            }
        }

        /// <summary>Read-only batch validation entry; throws on a missing or malformed install.</summary>
        public static void ValidateInstalledFromCommandLine()
        {
            Chapter00ZoneAtmosphereParams p = Chapter00ZoneAtmosphereParams.CreateDefault();
            Scene scene;

            if (!Validate(p) || !TerrainSceneUtility.TryOpenTargetScene(p.ScenePath, k_LogPrefix, out scene)
                || !ValidateInstalled(p, scene, logSuccess: true))
            {
                throw new InvalidOperationException($"{k_LogPrefix}: validation failed — see the log above.");
            }
        }

        public static string ProfilePath(Chapter00ZoneAtmosphereParams p, Chapter00ZoneDefinition zone)
        {
            return $"{p.ProfileFolder}/{zone.ProfileName}.asset";
        }

        /// <summary>
        /// Creates/reuses profiles and reconciles scene objects. Asset changes are saved; scene saving is an
        /// explicit caller choice so an artist can preview the placement without silently committing YAML.
        /// </summary>
        public static bool Build(Chapter00ZoneAtmosphereParams p, bool overwriteTuned, bool saveScene)
        {
            if (!Validate(p))
            {
                return false;
            }

            VolumeProfile[] profiles = new VolumeProfile[p.Zones.Length];

            for (int i = 0; i < p.Zones.Length; i++)
            {
                profiles[i] = EnsureProfile(p, p.Zones[i], overwriteTuned);

                if (profiles[i] == null)
                {
                    return false;
                }
            }

            AssetDatabase.SaveAssets();

            // Profile creation can trigger an import that invalidates an earlier in-memory instance. Re-load
            // every asset before assigning it to a scene Volume; otherwise Unity can silently serialize None.
            for (int i = 0; i < p.Zones.Length; i++)
            {
                string path = ProfilePath(p, p.Zones[i]);
                profiles[i] = AssetDatabase.LoadAssetAtPath<VolumeProfile>(path);

                if (profiles[i] == null)
                {
                    Debug.LogError($"{k_LogPrefix}: could not reload '{path}' after saving assets.");
                    return false;
                }
            }

            Scene scene;

            if (!TerrainSceneUtility.TryOpenTargetScene(p.ScenePath, k_LogPrefix, out scene))
            {
                return false;
            }

            Transform lighting = TerrainSceneUtility.EnsureRoot(scene, k_LightingRootName);
            Transform root = EnsureChild(lighting, Chapter00ZoneAtmosphereParams.k_RootName);
            EnsureVolumes(p, profiles, root);
            EditorSceneManager.MarkSceneDirty(scene);

            if (!ValidateInstalled(p, scene, logSuccess: false))
            {
                return false;
            }

            if (saveScene && !EditorSceneManager.SaveScene(scene))
            {
                Debug.LogError($"{k_LogPrefix}: failed to save '{p.ScenePath}'.");
                return false;
            }

            Debug.Log($"{k_LogPrefix}: built {p.Zones.Length} A-E volumes under "
                + $"{k_LightingRootName}/{Chapter00ZoneAtmosphereParams.k_RootName}; scene "
                + (saveScene ? "saved." : "left dirty for review."));
            return true;
        }

        /// <summary>Pure parameter validation used by both the builder and EditMode tests.</summary>
        public static bool Validate(Chapter00ZoneAtmosphereParams p)
        {
            List<string> errors = CollectValidationErrors(p);

            foreach (string error in errors)
            {
                Debug.LogError($"{k_LogPrefix}: {error}");
            }

            return errors.Count == 0;
        }

        public static List<string> CollectValidationErrors(Chapter00ZoneAtmosphereParams p)
        {
            List<string> errors = new List<string>();

            if (p == null || p.Zones == null)
            {
                errors.Add("params or Zones is null.");
                return errors;
            }

            if (p.Zones.Length != 5)
            {
                errors.Add($"expected exactly five zones; found {p.Zones.Length}.");
                return errors;
            }

            float previousMeanFreePath = 0f;
            float previousPriority = float.NegativeInfinity;

            for (int i = 0; i < p.Zones.Length; i++)
            {
                Chapter00ZoneDefinition zone = p.Zones[i];

                if (zone == null)
                {
                    errors.Add($"zone index {i} is null.");
                    continue;
                }

                if ((int)zone.Id != i)
                {
                    errors.Add($"zone index {i} must be {(Chapter00ZoneId)i}; found {zone.Id}.");
                }

                if (string.IsNullOrEmpty(zone.Name) || string.IsNullOrEmpty(zone.ProfileName))
                {
                    errors.Add($"zone {zone.Id} needs a scene name and profile name.");
                }

                if (zone.Look == null || zone.Look.MeanFreePath <= previousMeanFreePath)
                {
                    errors.Add($"zone {zone.Id} mean free path must be positive and strictly increase outward-to-inward.");
                }
                else
                {
                    previousMeanFreePath = zone.Look.MeanFreePath;
                }

                if (zone.BlendDistance < 6f || zone.BlendDistance > 10f)
                {
                    errors.Add($"zone {zone.Id} blend distance {zone.BlendDistance} is outside 6-10 m.");
                }

                if (zone.Priority <= previousPriority)
                {
                    errors.Add($"zone {zone.Id} priority must strictly increase toward E.");
                }
                previousPriority = zone.Priority;

                if (zone.Id == Chapter00ZoneId.A && zone.Shape != Chapter00ZoneVolumeShape.Global)
                {
                    errors.Add("zone A must be the global fallback.");
                }
                else if ((zone.Id == Chapter00ZoneId.B || zone.Id == Chapter00ZoneId.C
                    || zone.Id == Chapter00ZoneId.D)
                    && (zone.Shape != Chapter00ZoneVolumeShape.Sphere || zone.Radius <= 0f))
                {
                    errors.Add($"zone {zone.Id} must be a positive-radius sphere.");
                }
                else if (zone.Id == Chapter00ZoneId.E
                    && (zone.Shape != Chapter00ZoneVolumeShape.Box || zone.BoxSize.x <= 0f
                        || zone.BoxSize.y <= 0f || zone.BoxSize.z <= 0f))
                {
                    errors.Add("zone E must be a positive-size rotated box.");
                }
            }

            return errors;
        }

        private static VolumeProfile EnsureProfile(Chapter00ZoneAtmosphereParams p, Chapter00ZoneDefinition zone,
            bool overwriteTuned)
        {
            string path = ProfilePath(p, zone);
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
                ApplyLook(profile, zone.Look);
                RemoveBaselineOwners(profile);
                EditorUtility.SetDirty(profile);
                Debug.Log($"{k_LogPrefix}: {(created ? "created" : "overwrote")} {path}.");
            }

            return profile;
        }

        private static void ApplyLook(VolumeProfile profile, Chapter00ZoneLook look)
        {
            Fog fog = GetOrAdd<Fog>(profile);
            Set(fog.enabled, true);
            Set(fog.colorMode, FogColorMode.SkyColor);
            Set(fog.tint, look.FogTint);
            Set(fog.maxFogDistance, 5000f);
            Set(fog.meanFreePath, look.MeanFreePath);
            Set(fog.baseHeight, look.BaseHeight);
            Set(fog.maximumHeight, look.MaximumHeight);
            Set(fog.enableVolumetricFog, true);
            Set(fog.albedo, look.FogAlbedo);
            Set(fog.anisotropy, look.Anisotropy);
            Set(fog.globalLightProbeDimmer, look.AmbientDimmer);
            Set(fog.depthExtent, look.VolumetricDistance);
            Set(fog.multipleScatteringIntensity, look.MultipleScattering);
            Set(fog.denoisingMode, FogDenoisingMode.Gaussian);
            ApplyFogQuality(fog);

            ColorAdjustments grading = GetOrAdd<ColorAdjustments>(profile);
            Set(grading.contrast, look.Contrast);
            Set(grading.saturation, look.Saturation);
            Set(grading.colorFilter, look.ColorFilter);
        }

        /// <summary>
        /// Defensive cleanup for an overwrite: these profiles must never become a second exposure, sky,
        /// tonemapping, PSX or stock-grain owner. A normal build preserves the profile wholesale.
        /// </summary>
        private static void RemoveBaselineOwners(VolumeProfile profile)
        {
            RemoveComponent<Exposure>(profile);
            RemoveComponent<VisualEnvironment>(profile);
            RemoveComponent<GradientSky>(profile);
            RemoveComponent<Tonemapping>(profile);
            RemoveComponent<FilmGrain>(profile);

            for (int i = profile.components.Count - 1; i >= 0; i--)
            {
                VolumeComponent component = profile.components[i];

                if (component != null && component.GetType().Name == "PsxPostProcess")
                {
                    profile.components.RemoveAt(i);
                    AssetDatabase.RemoveObjectFromAsset(component);
                    UnityEngine.Object.DestroyImmediate(component, true);
                }
            }
        }

        private static void ApplyFogQuality(Fog fog)
        {
            Set(fog.quality, ScalableSettingLevelParameter.LevelCount);
            fog.fogControlMode = FogControl.Manual;
            Set(fog.screenResolutionPercentage, k_FogScreenResolutionPercentage);
            Set(fog.volumeSliceCount, k_FogSliceCount);
            Set(fog.sliceDistributionUniformity, k_FogSliceUniformity);
        }

        private static T GetOrAdd<T>(VolumeProfile profile) where T : VolumeComponent
        {
            T component;
            return profile.TryGet(out component)
                ? component
                : VolumeProfileFactory.CreateVolumeComponent<T>(profile, overrides: false, saveAsset: false);
        }

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

        private static void Set<T>(VolumeParameter<T> parameter, T value)
        {
            parameter.overrideState = true;
            parameter.value = value;
        }

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

        private static void EnsureVolumes(Chapter00ZoneAtmosphereParams p, VolumeProfile[] profiles,
            Transform root)
        {
            string[] names = new string[p.Zones.Length];

            for (int i = 0; i < p.Zones.Length; i++)
            {
                names[i] = p.Zones[i].Name;
            }

            for (int i = root.childCount - 1; i >= 0; i--)
            {
                Transform child = root.GetChild(i);

                if (Array.IndexOf(names, child.name) < 0)
                {
                    Undo.DestroyObjectImmediate(child.gameObject);
                }
            }

            for (int i = 0; i < p.Zones.Length; i++)
            {
                Chapter00ZoneDefinition zone = p.Zones[i];
                Transform holder = EnsureChild(root, zone.Name);
                Undo.RecordObject(holder, "Configure " + zone.Name);
                holder.position = zone.Center;
                holder.rotation = Quaternion.Euler(0f, zone.YawDegrees, 0f);
                holder.localScale = Vector3.one;

                Volume volume = holder.GetComponent<Volume>();

                if (volume == null)
                {
                    volume = Undo.AddComponent<Volume>(holder.gameObject);
                }

                Undo.RecordObject(volume, "Configure " + zone.Name);
                volume.isGlobal = zone.Shape == Chapter00ZoneVolumeShape.Global;
                volume.priority = zone.Priority;
                volume.blendDistance = zone.Shape == Chapter00ZoneVolumeShape.Global ? 0f : zone.BlendDistance;
                volume.weight = 1f;
                volume.sharedProfile = profiles[i];
                EnsureCollider(holder.gameObject, zone);
            }
        }

        private static void EnsureCollider(GameObject holder, Chapter00ZoneDefinition zone)
        {
            Collider[] colliders = holder.GetComponents<Collider>();

            foreach (Collider collider in colliders)
            {
                bool keep = (zone.Shape == Chapter00ZoneVolumeShape.Sphere && collider is SphereCollider)
                    || (zone.Shape == Chapter00ZoneVolumeShape.Box && collider is BoxCollider);

                if (!keep)
                {
                    Undo.DestroyObjectImmediate(collider);
                }
            }

            if (zone.Shape == Chapter00ZoneVolumeShape.Global)
            {
                return;
            }

            if (zone.Shape == Chapter00ZoneVolumeShape.Sphere)
            {
                SphereCollider sphere = holder.GetComponent<SphereCollider>();

                if (sphere == null)
                {
                    sphere = Undo.AddComponent<SphereCollider>(holder);
                }

                Undo.RecordObject(sphere, "Configure " + zone.Name);
                sphere.isTrigger = true;
                sphere.center = Vector3.zero;
                sphere.radius = zone.Radius;
                return;
            }

            BoxCollider box = holder.GetComponent<BoxCollider>();

            if (box == null)
            {
                box = Undo.AddComponent<BoxCollider>(holder);
            }

            Undo.RecordObject(box, "Configure " + zone.Name);
            box.isTrigger = true;
            box.center = Vector3.zero;
            box.size = zone.BoxSize;
        }

        public static bool ValidateInstalled(Chapter00ZoneAtmosphereParams p, Scene scene, bool logSuccess)
        {
            Transform lighting = TerrainSceneUtility.FindRoot(scene, k_LightingRootName);
            Transform root = lighting == null ? null : lighting.Find(Chapter00ZoneAtmosphereParams.k_RootName);

            if (root == null)
            {
                Debug.LogError($"{k_LogPrefix}: missing {k_LightingRootName}/"
                    + Chapter00ZoneAtmosphereParams.k_RootName + ".");
                return false;
            }

            bool valid = true;

            foreach (Chapter00ZoneDefinition zone in p.Zones)
            {
                Transform holder = root.Find(zone.Name);
                VolumeProfile profile = AssetDatabase.LoadAssetAtPath<VolumeProfile>(ProfilePath(p, zone));

                if (holder == null || holder.GetComponent<Volume>() == null || profile == null)
                {
                    Debug.LogError($"{k_LogPrefix}: zone {zone.Id} object, Volume or profile is missing.");
                    valid = false;
                    continue;
                }

                Volume volume = holder.GetComponent<Volume>();
                bool expectedGlobal = zone.Shape == Chapter00ZoneVolumeShape.Global;

                if (volume.isGlobal != expectedGlobal || volume.sharedProfile != profile)
                {
                    Debug.LogError($"{k_LogPrefix}: zone {zone.Id} has the wrong global flag or profile.");
                    valid = false;
                }

                if (!profile.TryGet(out Fog _) || !profile.TryGet(out ColorAdjustments _)
                    || HasBaselineOwner(profile))
                {
                    Debug.LogError($"{k_LogPrefix}: zone {zone.Id} profile must contain only regional fog/grading, "
                        + "not exposure, sky, tonemapping, PSX or Film Grain.");
                    valid = false;
                }
            }

            if (valid && logSuccess)
            {
                Debug.Log($"{k_LogPrefix}: validation passed for all five A-E volumes and profiles.");
            }

            return valid;
        }

        private static bool HasBaselineOwner(VolumeProfile profile)
        {
            if (profile.TryGet(out Exposure _) || profile.TryGet(out VisualEnvironment _)
                || profile.TryGet(out GradientSky _) || profile.TryGet(out Tonemapping _)
                || profile.TryGet(out FilmGrain _))
            {
                return true;
            }

            foreach (VolumeComponent component in profile.components)
            {
                if (component != null && component.GetType().Name == "PsxPostProcess")
                {
                    return true;
                }
            }

            return false;
        }
    }
}
