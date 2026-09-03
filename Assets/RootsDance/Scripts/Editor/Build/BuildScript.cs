using System;
using System.Collections.Generic;
using System.IO;
using UnityEditor;
using UnityEditor.Build;
using UnityEditor.Build.Profile;
using UnityEditor.Build.Reporting;
using UnityEngine;

namespace RootsDance.Editor.Build
{
    /// <summary>
    /// Command-line build entry point. Invoked by Tools/build/build.py with
    /// -executeMethod RootsDance.Editor.Build.BuildScript.BuildFromCommandLine.
    /// Carries the Release/Dev difference, which the profile assets cannot hold
    /// because per-profile settings are internal in Unity 6.3.
    /// </summary>
    public static class BuildScript
    {
        private const string k_ProfileFolder = "Assets/RootsDance/Settings/BuildProfiles";

        public const string k_BuildReportFile = "build-report.json";

        /// <summary>True while BuildFromCommandLine runs; build callbacks use it to stay quiet otherwise.</summary>
        public static bool IsCommandLineBuild { get; private set; }

        public static void BuildFromCommandLine()
        {
            Dictionary<string, string> args = ParseArgs(System.Environment.GetCommandLineArgs());

            string profileName;
            if (!args.TryGetValue("-rdProfile", out profileName) || string.IsNullOrEmpty(profileName))
            {
                throw new BuildFailedException("Missing -rdProfile <name>.");
            }

            string outputPath;
            if (!args.TryGetValue("-rdOutput", out outputPath) || string.IsNullOrEmpty(outputPath))
            {
                throw new BuildFailedException("Missing -rdOutput <path>.");
            }

            bool development = args.ContainsKey("-rdDev");
            bool strict = args.ContainsKey("-rdStrict");
            bool skipAudit = args.ContainsKey("-rdSkipAudit");

            string assetPath = string.Format("{0}/{1}.asset", k_ProfileFolder, profileName);
            BuildProfile profile = AssetDatabase.LoadAssetAtPath<BuildProfile>(assetPath);
            if (profile == null)
            {
                throw new BuildFailedException(
                    "No build profile at " + assetPath +
                    ". Run RootsDance > Build > Create Default Build Profiles first.");
            }

            ValidateBuildProfile(profile, profileName);
            Debug.Log(string.Format("[BuildScript] build start profile={0} dev={1}", profileName, development));

            if (!skipAudit)
            {
                AuditResult audit = AssetSizeAudit.Run(false, true);
                if (strict)
                {
                    // Only fixable violations gate the build: report-only rules (an
                    // Uncompressed project texture, a pipeline-owned model) have no action
                    // --fix could take, so failing on them would leave --strict unusable.
                    int fixable = 0;
                    foreach (AssetViolation violation in audit.Violations)
                    {
                        if (violation.fixable)
                        {
                            fixable++;
                        }
                    }

                    if (fixable > 0)
                    {
                        throw new BuildFailedException(string.Format(
                            "Asset size audit found {0} fixable violation(s); run build.py --audit --fix "
                            + "or drop --strict.", fixable));
                    }
                }
            }

            BuildOptions options = BuildOptions.StrictMode | BuildOptions.DetailedBuildReport;
            if (development)
            {
                options |= BuildOptions.Development | BuildOptions.AllowDebugging | BuildOptions.CompressWithLz4;
            }
            else
            {
                options |= BuildOptions.CompressWithLz4HC;
            }

            var buildOptions = new BuildPlayerWithProfileOptions
            {
                buildProfile = profile,
                locationPathName = outputPath,
                options = options,
            };

            BuildReport report;
            StackTraceLogType logTraces = Application.GetStackTraceLogType(LogType.Log);
            StackTraceLogType warningTraces = Application.GetStackTraceLogType(LogType.Warning);
            IsCommandLineBuild = true;
            BuildProgressLogger.Reset();
            try
            {
                // 322k duplicate-LODGroup warnings with stack traces made the last log 614 MB.
                Application.SetStackTraceLogType(LogType.Log, StackTraceLogType.None);
                Application.SetStackTraceLogType(LogType.Warning, StackTraceLogType.None);
                report = BuildPipeline.BuildPlayer(buildOptions);
            }
            finally
            {
                Application.SetStackTraceLogType(LogType.Log, logTraces);
                Application.SetStackTraceLogType(LogType.Warning, warningTraces);
                IsCommandLineBuild = false;
            }

            if (report == null)
            {
                throw new BuildFailedException("Unity returned no build report. Check the preceding build errors.");
            }

            BuildSummary summary = report.summary;
            string reportPath = Path.Combine(Path.GetDirectoryName(outputPath), k_BuildReportFile);
            try
            {
                BuildReportWriter.Write(report, reportPath);
            }
            catch (Exception error)
            {
                Debug.LogWarning("[BuildScript] could not write " + reportPath + ": " + error.Message);
            }

            Debug.Log(string.Format(
                "[BuildScript] {0}: result={1} size={2} bytes errors={3} time={4}",
                profileName, summary.result, summary.totalSize, summary.totalErrors, summary.totalTime));

            if (summary.result != BuildResult.Succeeded)
            {
                throw new BuildFailedException(string.Format(
                    "Build {0} with {1} error(s).", summary.result, summary.totalErrors));
            }

            if (Application.isBatchMode)
            {
                // Do not wait for -quit: the Editor otherwise idles up to -quitTimeout seconds
                // (5 minutes by default) on IL2CPP's analytics launch. build.py trusts the marker.
                EditorApplication.Exit(0);
            }
        }

        private static void ValidateBuildProfile(BuildProfile profile, string profileName)
        {
            BuildTarget expectedTarget;
            if (profileName.StartsWith("Windows-", StringComparison.Ordinal))
            {
                expectedTarget = BuildTarget.StandaloneWindows64;
            }
            else if (profileName.StartsWith("macOS-", StringComparison.Ordinal))
            {
                expectedTarget = BuildTarget.StandaloneOSX;
            }
            else
            {
                throw new BuildFailedException("Unsupported profile name: " + profileName);
            }

            if (!BuildPipeline.IsBuildTargetSupported(BuildTargetGroup.Standalone, expectedTarget))
            {
                throw new BuildFailedException(
                    "Build support for " + expectedTarget + " is unavailable. Install the matching " +
                    "IL2CPP build support module for this Unity Editor, then restart the Editor.");
            }

            // Unity 6.3 exposes these profile fields only internally. Read through SerializedObject;
            // never repair or save project assets as a side effect of a command-line build.
            using (var serializedProfile = new SerializedObject(profile))
            {
                SerializedProperty target = serializedProfile.FindProperty("m_BuildTarget");
                SerializedProperty subtarget = serializedProfile.FindProperty("m_Subtarget");
                SerializedProperty platform = serializedProfile.FindProperty("m_PlatformBuildProfile");
                if (target == null || subtarget == null || platform == null)
                {
                    throw new BuildFailedException(
                        "Build profile serialization changed. This build script requires Unity 6000.3.22f1.");
                }

                if (target.intValue != (int)expectedTarget
                    || subtarget.intValue != (int)StandaloneBuildSubtarget.Player)
                {
                    throw new BuildFailedException(
                        profileName + " must target " + expectedTarget + " with subtarget Player. " +
                        "Correct the profile in File > Build Profiles before building.");
                }

                // BuildProfile.OnEnable initializes a previously null platform profile when its
                // module is available, including the Windows profile first authored on macOS.
                if (platform.managedReferenceValue == null)
                {
                    throw new BuildFailedException(
                        profileName + " has no platform settings. Install its build support module, restart " +
                        "Unity, and run RootsDance > Build > Create Default Build Profiles.");
                }
            }

            if (EditorUserBuildSettings.activeBuildTarget != expectedTarget)
            {
                throw new BuildFailedException(
                    "The Editor compiled scripts for " + EditorUserBuildSettings.activeBuildTarget + ". " +
                    "Restart the batch build with -buildTarget " + expectedTarget + " before -executeMethod.");
            }

            ValidateInheritedPlayerSettings(profile);
            BuildProfile activeProfile = BuildProfile.GetActiveBuildProfile();
            if (activeProfile != null && activeProfile != profile)
            {
                // PlayerSettings getters can otherwise read a different active profile's override
                // before BuildPipeline activates the requested profile.
                ValidateInheritedPlayerSettings(activeProfile);
            }

            if (PlayerSettings.GetScriptingBackend(NamedBuildTarget.Standalone) != ScriptingImplementation.IL2CPP)
            {
                throw new BuildFailedException(
                    "Standalone Scripting Backend must be IL2CPP; refusing to silently build Mono. " +
                    "Run RootsDance > Build > Create Default Build Profiles, then retry.");
            }
        }

        private static void ValidateInheritedPlayerSettings(BuildProfile profile)
        {
            using (var serializedProfile = new SerializedObject(profile))
            {
                SerializedProperty settings = serializedProfile.FindProperty("m_PlayerSettingsYaml.m_Settings");
                if (settings == null || settings.arraySize != 0)
                {
                    throw new BuildFailedException(
                        "Profile " + profile.name + " must inherit global Player Settings for this build script. " +
                        "Remove its Player Settings override in File > Build Profiles before building.");
                }
            }
        }

        private static Dictionary<string, string> ParseArgs(string[] argv)
        {
            var parsed = new Dictionary<string, string>();
            for (int i = 0; i < argv.Length; i++)
            {
                if (!argv[i].StartsWith("-rd", StringComparison.Ordinal))
                {
                    continue;
                }

                bool hasValue = i + 1 < argv.Length && !argv[i + 1].StartsWith("-", StringComparison.Ordinal);
                parsed[argv[i]] = hasValue ? argv[i + 1] : string.Empty;
            }

            return parsed;
        }
    }
}
