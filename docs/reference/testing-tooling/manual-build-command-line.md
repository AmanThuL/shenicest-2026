---
title: "Build a player from the command line"
page_title: "Unity - Manual: Build a player from the command line"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/build-command-line.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/build-command-line.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Build a player from the command line

You can build a Unity Player from the command line without opening the Unity Editor. This is useful for automated builds in continuous integration (CI) systems and build pipelines.

There are several approaches to building a Player from the command line:

| **Build type**                                   | **Command line details**                                                                                                                                                                                                                                                                                                                                                                     |
|:-------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Build with a build target**                    | Use the [`-buildTarget`](https://docs.unity3d.com/6000.3/Documentation/Manual/EditorCommandLineArguments.html#build-arguments) argument to specify the target platform, and the `-build` argument to trigger a Player build.                                                                                                                                                                 |
| **Build with a build profile**                   | Use the [`-activeBuildProfile`](https://docs.unity3d.com/6000.3/Documentation/Manual/EditorCommandLineArguments.html#build-arguments) argument to specify a saved build profile, and the `-build` argument to trigger the build. You need a [build profile asset file](https://docs.unity3d.com/6000.3/Documentation/Manual/create-build-profile.html) in your project to use this approach. |
| **Build with a custom script and build target**  | Use the `-executeMethod` argument to execute a [custom build script](https://docs.unity3d.com/6000.3/Documentation/Manual/build-script-build.html), along with `-buildTarget` to specify the target platform.                                                                                                                                                                                |
| **Build with a custom script and build profile** | Use the `-executeMethod` argument to execute a [custom build script](https://docs.unity3d.com/6000.3/Documentation/Manual/build-script-build.html), along with `-activeBuildProfile` to specify a saved build profile.                                                                                                                                                                       |

If you want to build a Player without a custom build script, use the `-build` argument with either `-buildTarget` or `-activeBuildProfile`. This approach is similar to selecting **Build** in the [Build Profiles window](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles-reference.html).

If you have a [custom build script](https://docs.unity3d.com/6000.3/Documentation/Manual/build-script-build.html), use the `-executeMethod` argument to specify the static method to execute, along with either `-buildTarget` or `-activeBuildProfile`.

## Required arguments

The following arguments are required for command line builds:

-   `-projectPath <pathname>`: Specifies the path to your Unity project.
-   `-quit`: Exits the Unity Editor after execution completes.

## Recommended arguments

The following arguments are optional but recommended for command line builds:

-   `-batchmode`: Runs Unity in batch mode without the graphical user interface.
-   `-logFile <pathname>`: Saves the Editor log to a specific file for easier debugging and monitoring.
-   `-buildTarget` or `-activeBuildProfile`: Ensures that Unity starts with the correct target platform configuration. If you don’t specify this then Unity loads with the last used configuration.

For a complete list of command line arguments, refer to [Unity Editor command line arguments](https://docs.unity3d.com/6000.3/Documentation/Manual/EditorCommandLineArguments.html).

### Target switching limitations in batch mode

**Important**: For reliable command line builds, always specify the build profile or build target directly on the command line when running any custom script that triggers a build. This requirement also means that you can’t build for multiple targets in a single command line invocation. Instead, run the Unity process separately for each target platform.

Some APIs that can change or specify the target platform don’t work as expected in batch mode, because when you change target platform, Unity recompiles and reloads the Editor assemblies. This reload can’t happen while a script is running, so the change doesn’t take effect.

The following APIs don’t work as expected:

-   [`BuildProfile.SetActiveBuildProfile`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.Profile.BuildProfile.SetActiveBuildProfile.html)
-   [`EditorUserBuildSettings.SwitchActiveBuildTargetAsync`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorUserBuildSettings.SwitchActiveBuildTargetAsync.html)
-   [`BuildAssetBundlesParameters.targetPlatform`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildAssetBundlesParameters-targetPlatform.html)
-   [`BuildPlayerOptions.target`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPlayerOptions-target.html)

Additionally, platform-specific [conditional compilation](https://docs.unity3d.com/6000.3/Documentation/Manual/platform-dependent-compilation.html) varies based on the current target. The assemblies that Unity loads can also differ depending on the target platform. These differences can influence the build output and lead to issues that are hard to diagnose.

## Example: Build with a custom script on Windows

The following command executes a custom build script on Windows:

    "C:\Program Files\Unity\Hub\Editor\6000.3.XXf1\Editor\Unity.exe" -executeMethod BuildScripts.BuildWindows64 -buildTarget StandaloneWindows64 -batchmode -quit -projectPath "C:\path\to\Project" -logFile C:\Logs\build.log

## Example: Build with a custom script on macOS

The following command executes a custom build script on macOS:

    /Applications/Unity/Hub/Editor/6000.3.XXf1/Unity.app/Contents/MacOS/Unity -executeMethod BuildScripts.BuildMacOS -buildTarget StandaloneOSX -batchmode -quit -projectPath "/path/to/Project" -logFile ~/Logs/build.log

**Note**: Adjust the Unity Editor path in the examples to match the version of Unity you want to use, or replace the path entirely if your Unity Editor is installed in a different location.

## Additional resources

-   [Unity Editor command line arguments](https://docs.unity3d.com/6000.3/Documentation/Manual/EditorCommandLineArguments.html)
-   [Create a custom build script](https://docs.unity3d.com/6000.3/Documentation/Manual/build-script-build.html)
-   [Build arguments](https://docs.unity3d.com/6000.3/Documentation/Manual/EditorCommandLineArguments.html#build-arguments)
