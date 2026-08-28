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
            // keeping a second copy per profile that can drift out of sync.
            profile.overrideGlobalScenes = false;
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

            return (GUID)method.Invoke(
                null, new object[] { buildTarget, StandaloneBuildSubtarget.Player });
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
                    "BuildProfile.CreateInstance(GUID, string) not found — the internal API moved in this Unity version.");
            }

            method.Invoke(null, new object[] { platformId, assetPath });
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

            // Metal only — avoids generating excessive shader variants.
            PlayerSettings.SetUseDefaultGraphicsAPIs(BuildTarget.StandaloneOSX, false);
            PlayerSettings.SetGraphicsAPIs(
                BuildTarget.StandaloneOSX,
                new UnityEngine.Rendering.GraphicsDeviceType[] { UnityEngine.Rendering.GraphicsDeviceType.Metal });

            SetMacArchitectureAppleSilicon();
        }

        private static void SetMacArchitectureAppleSilicon()
        {
            Type userBuildSettings = Type.GetType(
                "UnityEditor.OSXStandalone.UserBuildSettings, UnityEditor.OSXStandalone.Extensions");
            if (userBuildSettings == null)
            {
                Debug.LogWarning(
                    "[BuildProfileGenerator] macOS build support not installed; skipping architecture setting.");
                return;
            }

            PropertyInfo architecture = userBuildSettings.GetProperty(
                "architecture", BindingFlags.Public | BindingFlags.Static);
            if (architecture == null)
            {
                Debug.LogWarning("[BuildProfileGenerator] UserBuildSettings.architecture not found; skipping.");
                return;
            }

            object arm64 = Enum.Parse(architecture.PropertyType, "ARM64");
            architecture.SetValue(null, arm64);
        }
    }
}
