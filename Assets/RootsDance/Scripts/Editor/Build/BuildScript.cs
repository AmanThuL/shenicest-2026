using System;
using System.Collections.Generic;
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

            string assetPath = string.Format("{0}/{1}.asset", k_ProfileFolder, profileName);
            BuildProfile profile = AssetDatabase.LoadAssetAtPath<BuildProfile>(assetPath);
            if (profile == null)
            {
                throw new BuildFailedException(
                    "No build profile at " + assetPath +
                    ". Run RootsDance > Build > Create Default Build Profiles first.");
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

            BuildReport report = BuildPipeline.BuildPlayer(buildOptions);
            BuildSummary summary = report.summary;

            Debug.Log(string.Format(
                "[BuildScript] {0}: result={1} size={2} bytes errors={3} time={4}",
                profileName, summary.result, summary.totalSize, summary.totalErrors, summary.totalTime));

            if (summary.result != BuildResult.Succeeded)
            {
                throw new BuildFailedException(string.Format(
                    "Build {0} with {1} error(s).", summary.result, summary.totalErrors));
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
