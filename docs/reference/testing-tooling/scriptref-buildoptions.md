---
title: "Scripting API: BuildOptions"
page_title: "Unity - Scripting API: BuildOptions"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# BuildOptions

enumeration

<span id="scrollToFeedback">Leave feedback</span>

<span class="blue-btn sbtn">Suggest a change</span>

## Success!

Thank you for helping us improve the quality of Unity Documentation. Although we cannot accept all submissions, we do read each suggested change from our users and will make updates where applicable.

<span class="gray-btn sbtn close">Close</span>

## Submission failed

For some reason your suggested change could not be submitted. Please \<a>try again\</a> in a few minutes. And thank you for taking the time to help us improve the quality of Unity Documentation.

<span class="gray-btn sbtn close">Close</span>

Your name Your email Suggestion<span class="r">\*</span>

Submit suggestion

<span class="cancel left lh42 cn">Cancel</span>

<span style="color:red;"> </span>

### Description

Options to configure a build. You can combine multiple build options together.

Additional resources: [BuildPipeline.BuildPlayer](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPipeline.BuildPlayer.html).

``` codeExampleCS
using UnityEditor;
using UnityEngine;

public class EditorExample : MonoBehaviour
{
    [MenuItem("Build/Build scripts")]
    public static void MyBuild()
    {
        BuildPlayerOptions buildPlayerOptions = new BuildPlayerOptions();
        buildPlayerOptions.scenes = new[] { "Assets/scene.unity" };
        buildPlayerOptions.locationPathName = "scriptBuilds";
        buildPlayerOptions.target = BuildTarget.StandaloneOSX;

        // use these options for a development and strict mode build
        buildPlayerOptions.options = BuildOptions.Development | BuildOptions.StrictMode;

        BuildPipeline.BuildPlayer(buildPlayerOptions);
    }
}
```

### Properties

| Property                                                                                                                                                   | Description                                                                                                                                                                                       |
|------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [None](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.None.html)                                                               | Perform the specified build without any special settings or extra tasks.                                                                                                                          |
| [Development](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.Development.html)                                                 | Build a development version of the Player.                                                                                                                                                        |
| [AutoRunPlayer](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.AutoRunPlayer.html)                                             | Run the built Player.                                                                                                                                                                             |
| [ShowBuiltPlayer](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.ShowBuiltPlayer.html)                                         | Show the built Player.                                                                                                                                                                            |
| [BuildAdditionalStreamedScenes](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.BuildAdditionalStreamedScenes.html)             | For internal use                                                                                                                                                                                  |
| [AcceptExternalModificationsToPlayer](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.AcceptExternalModificationsToPlayer.html) | Appends to an existing Xcode (iOS) project during the build process.                                                                                                                              |
| [CleanBuildCache](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.CleanBuildCache.html)                                         | Clear all cached build results, resulting in a full rebuild of all scripts and all player data.                                                                                                   |
| [ConnectWithProfiler](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.ConnectWithProfiler.html)                                 | Start the Player with a connection to the Profiler in the Editor.                                                                                                                                 |
| [AllowDebugging](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.AllowDebugging.html)                                           | Allow script debuggers to attach to the Player remotely. You can debug your scripts only if you use BuildOptions.Development.                                                                     |
| [SymlinkSources](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.SymlinkSources.html)                                           | Symlink sources when generating the project. This is useful if you're changing source files inside the generated project and want to bring the changes back into your Unity project or a package. |
| [UncompressedAssetBundle](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.UncompressedAssetBundle.html)                         | Don't compress the data when creating the asset bundle.                                                                                                                                           |
| [ConnectToHost](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.ConnectToHost.html)                                             | Sets the Player to connect to the Editor.                                                                                                                                                         |
| [CustomConnectionID](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.CustomConnectionID.html)                                   | Determines if the player should be using the custom connection ID.                                                                                                                                |
| [BuildScriptsOnly](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.BuildScriptsOnly.html)                                       | Only build the scripts in a project.                                                                                                                                                              |
| [PatchPackage](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.PatchPackage.html)                                               | Patch a Development app package rather than completely rebuilding it.Supported only on Android platform.                                                                                          |
| [ForceEnableAssertions](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.ForceEnableAssertions.html)                             | Include assertions in the build. By default, the assertions are only included in development builds.                                                                                              |
| [CompressWithLz4](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.CompressWithLz4.html)                                         | Use chunk-based LZ4 compression when building the Player.                                                                                                                                         |
| [CompressWithLz4HC](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.CompressWithLz4HC.html)                                     | Use chunk-based LZ4 high-compression when building the Player.                                                                                                                                    |
| [StrictMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.StrictMode.html)                                                   | Prevent the build from succeeding if any errors are reported during the build process.                                                                                                            |
| [IncludeTestAssemblies](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.IncludeTestAssemblies.html)                             | Build will include Assemblies for testing.                                                                                                                                                        |
| [NoUniqueIdentifier](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.NoUniqueIdentifier.html)                                   | Will force the buildGUID to all zeros.                                                                                                                                                            |
| [WaitForPlayerConnection](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.WaitForPlayerConnection.html)                         | Sets the Player to wait for player connection on player start.                                                                                                                                    |
| [EnableCodeCoverage](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.EnableCodeCoverage.html)                                   | Enables code coverage. You can use this as a complimentary way of enabling code coverage on platforms that do not support command line arguments.                                                 |
| [EnableDeepProfilingSupport](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.EnableDeepProfilingSupport.html)                   | Enables Deep Profiling support in the Player.                                                                                                                                                     |
| [DetailedBuildReport](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.DetailedBuildReport.html)                                 | Generates detailed information in the BuildReport.                                                                                                                                                |
