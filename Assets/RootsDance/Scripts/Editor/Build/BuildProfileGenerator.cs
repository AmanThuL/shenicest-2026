using System;
using System.IO;
using System.Reflection;
using UnityEditor;
using UnityEditor.Build;
using UnityEditor.Build.Profile;
using UnityEngine;

namespace RootsDance.Editor.Build
{
    /// <summary>
    /// Creates the committed build-profile assets and applies the release player settings.
    /// Run once per machine after a fresh clone, or after changing the settings below.
    /// </summary>
    public static class BuildProfileGenerator
    {
        private const string k_ProfileFolder = "Assets/RootsDance/Settings/BuildProfiles";
        private const string k_MacProfileName = "macOS-Release";
        private const string k_WindowsProfileName = "Windows-Release";

        [MenuItem("RootsDance/Build/Create Default Build Profiles")]
        public static void CreateDefaultBuildProfiles()
        {
            CreateProfile(k_MacProfileName, BuildTarget.StandaloneOSX);
            CreateProfile(k_WindowsProfileName, BuildTarget.StandaloneWindows64);
            ApplyReleasePlayerSettings();

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
            Debug.Log("[BuildProfileGenerator] Profiles and player settings are up to date.");
        }

        private static void CreateProfile(string profileName, BuildTarget buildTarget)
        {
            string assetPath = string.Format("{0}/{1}.asset", k_ProfileFolder, profileName);
            if (!Directory.Exists(k_ProfileFolder))
            {
                throw new InvalidOperationException("Missing folder: " + k_ProfileFolder);
            }

            BuildProfile profile = AssetDatabase.LoadAssetAtPath<BuildProfile>(assetPath);
            if (profile == null)
            {
                InvokeCreateInstance(GetPlatformId(buildTarget), assetPath);
                AssetDatabase.ImportAsset(assetPath);
                profile = AssetDatabase.LoadAssetAtPath<BuildProfile>(assetPath);
            }

            if (profile == null)
            {
                throw new InvalidOperationException("Failed to create build profile at " + assetPath);
            }

            // Inherit the single curated scene list in EditorBuildSettings rather than
            // keeping a second copy per profile that can drift out of sync. Applied on every
            // run — not only on first creation — so a previously-committed, stale asset is
            // repaired rather than left as-is.
            profile.overrideGlobalScenes = false;

            if (buildTarget == BuildTarget.StandaloneOSX)
            {
                if (BuildPipeline.IsBuildTargetSupported(BuildTargetGroup.Standalone, BuildTarget.StandaloneOSX))
                {
                    SetMacProfileArchitectureArm64(profile);
                }
                else
                {
                    Debug.LogWarning(
                        "[BuildProfileGenerator] macOS Build Support is not installed on this " +
                        "machine — skipping ARM64 architecture on " + profileName + ". Install " +
                        "the module and re-run this menu item to finish the macOS profile.");
                }
            }

            EditorUtility.SetDirty(profile);
        }

        private static GUID GetPlatformId(BuildTarget buildTarget)
        {
            Type moduleUtil = Type.GetType(
                "UnityEditor.Build.Profile.BuildProfileModuleUtil, UnityEditor.CoreModule");
            if (moduleUtil == null)
            {
                throw new InvalidOperationException(
                    "BuildProfileModuleUtil not found — the internal build-profile API moved in this Unity version.");
            }

            MethodInfo method = moduleUtil.GetMethod(
                "GetPlatformId",
                BindingFlags.NonPublic | BindingFlags.Public | BindingFlags.Static,
                null,
                new Type[] { typeof(BuildTarget), typeof(StandaloneBuildSubtarget) },
                null);
            if (method == null)
            {
                throw new InvalidOperationException(
                    "BuildProfileModuleUtil.GetPlatformId not found — the internal API moved in this Unity version.");
            }

            object result = InvokeMethod(
                method, null, new object[] { buildTarget, StandaloneBuildSubtarget.Player },
                "BuildProfileModuleUtil.GetPlatformId");
            return (GUID)result;
        }

        private static void InvokeCreateInstance(GUID platformId, string assetPath)
        {
            MethodInfo method = typeof(BuildProfile).GetMethod(
                "CreateInstance",
                BindingFlags.NonPublic | BindingFlags.Public | BindingFlags.Static,
                null,
                new Type[] { typeof(GUID), typeof(string) },
                null);
            if (method == null)
            {
                throw new InvalidOperationException(
                    "BuildProfile.CreateInstance(GUID, string) not found — the internal API " +
                    "moved in this Unity version.");
            }

            InvokeMethod(method, null, new object[] { platformId, assetPath }, "BuildProfile.CreateInstance");
        }

        /// <summary>
        /// Sets the macOS-only build architecture on the profile's own platform settings
        /// object, not the deprecated, machine-local UserBuildSettings.architecture global —
        /// BuildScript builds via BuildPlayerWithProfileOptions.buildProfile, so only the
        /// value baked into the profile asset actually governs the build.
        /// </summary>
        private static void SetMacProfileArchitectureArm64(BuildProfile profile)
        {
            PropertyInfo platformProperty = typeof(BuildProfile).GetProperty(
                "platformBuildProfile", BindingFlags.NonPublic | BindingFlags.Public | BindingFlags.Instance);
            if (platformProperty == null)
            {
                throw new InvalidOperationException(
                    "BuildProfile.platformBuildProfile not found — the internal API moved in this Unity version.");
            }

            object platformProfile = InvokeGetter(platformProperty, profile, "BuildProfile.platformBuildProfile");
            if (platformProfile == null)
            {
                throw new InvalidOperationException(
                    "BuildProfile.platformBuildProfile returned null for " + profile.name);
            }

            PropertyInfo architectureProperty = platformProfile.GetType().GetProperty(
                "architecture", BindingFlags.NonPublic | BindingFlags.Public | BindingFlags.Instance);
            if (architectureProperty == null)
            {
                throw new InvalidOperationException(
                    "OSXStandaloneBuildProfile.architecture not found — the internal API " +
                    "moved in this Unity version.");
            }

            object arm64 = Enum.Parse(architectureProperty.PropertyType, "ARM64");
            InvokeSetter(architectureProperty, platformProfile, arm64, "OSXStandaloneBuildProfile.architecture");
        }

        /// <summary>
        /// Release settings, applied globally because per-profile Player Settings overrides
        /// are internal-only in 6.3. Rationale and sources: the build-and-packaging doc.
        /// </summary>
        private static void ApplyReleasePlayerSettings()
        {
            NamedBuildTarget standalone = NamedBuildTarget.Standalone;

            PlayerSettings.SetScriptingBackend(standalone, ScriptingImplementation.IL2CPP);
            PlayerSettings.SetIl2CppCodeGeneration(standalone, Il2CppCodeGeneration.OptimizeSpeed);
            PlayerSettings.SetIl2CppCompilerConfiguration(standalone, Il2CppCompilerConfiguration.Release);

            // Minimal is the IL2CPP default and the least likely to strip reflection-driven
            // code (Odin, the Input System). Never use Low: it is marked for deprecation.
            PlayerSettings.SetManagedStrippingLevel(standalone, ManagedStrippingLevel.Minimal);

            // Strips vertex streams no material reads (guideline 05 §7.2). Meshes are 71 % of the build.
            PlayerSettings.stripUnusedMeshComponents = true;

            // Metal only — avoids generating excessive shader variants.
            PlayerSettings.SetUseDefaultGraphicsAPIs(BuildTarget.StandaloneOSX, false);
            PlayerSettings.SetGraphicsAPIs(
                BuildTarget.StandaloneOSX,
                new UnityEngine.Rendering.GraphicsDeviceType[] { UnityEngine.Rendering.GraphicsDeviceType.Metal });
        }

        /// <summary>
        /// Unwraps a reflection TargetInvocationException so callers see the real failure
        /// (with context) instead of a bare wrapper exception.
        /// </summary>
        private static object InvokeMethod(MethodInfo method, object target, object[] parameters, string context)
        {
            try
            {
                return method.Invoke(target, parameters);
            }
            catch (TargetInvocationException exception)
            {
                Exception inner = exception.InnerException != null ? exception.InnerException : exception;
                throw new InvalidOperationException(context + " threw: " + inner.Message, inner);
            }
        }

        private static object InvokeGetter(PropertyInfo property, object target, string context)
        {
            try
            {
                return property.GetValue(target);
            }
            catch (TargetInvocationException exception)
            {
                Exception inner = exception.InnerException != null ? exception.InnerException : exception;
                throw new InvalidOperationException(context + " getter threw: " + inner.Message, inner);
            }
        }

        private static void InvokeSetter(PropertyInfo property, object target, object value, string context)
        {
            try
            {
                property.SetValue(target, value);
            }
            catch (TargetInvocationException exception)
            {
                Exception inner = exception.InnerException != null ? exception.InnerException : exception;
                throw new InvalidOperationException(context + " setter threw: " + inner.Message, inner);
            }
        }
    }
}
