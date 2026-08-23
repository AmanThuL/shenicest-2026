---
title: "Create a custom build script"
page_title: "Unity - Manual: Create a custom build script"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/build-script-build.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/build-script-build.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Create a custom build script

To customize how Unity makes a build, use [`BuildPipeline`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPipeline.html) to perform a build, along with any pre-build and post-build steps that you need for your project.

Launching a Player build from the [Build Profiles window](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles-reference.html) doesn’t trigger custom build scripts. You need to provide a way to invoke your script. The most common way to invoke a build script is from the [command line](https://docs.unity3d.com/6000.3/Documentation/Manual/build-command-line.html), but you can also expose your script as a menu item or invoke it from a custom Unity Editor window.

The following examples use the [`BuildPipeline.BuildPlayer`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPipeline.BuildPlayer.html) API to perform a Player build. To use the scripts, place them in the [`Editor` folder](https://docs.unity3d.com/6000.3/Documentation/Manual/SpecialFolders.html) of your project, or create an [Editor assembly asset](https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definitions-creating.html).

## Create a basic build script with menu item

This example demonstrates a simple custom build script that builds a Windows player, copies a `README` file to the build folder, and automatically launches the built Player.

It uses the [`MenuItem`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MenuItem.html) attribute to add a **Build \> Build Windows Player With Readme** menu item to the Unity Editor, which allows you to start the build from the Editor.

``` lang-cs
using System.IO;
using UnityEditor.Build.Reporting;
using UnityEditor;
using UnityEngine;

public class CustomBuild
{
    [MenuItem("Build/Build Windows Player With Readme")]
    public static void BuildWindowsPlayer()
    {
        // Define build options
        string path = EditorUtility.SaveFolderPanel("Choose Location of Built Game", "", "");

        var buildOptions = new BuildPlayerOptions()
        {
            // Adjust scene list based on your project
            scenes = new string[] { "Assets/Scenes/Scene1.unity", "Assets/Scenes/Scene2.unity" },
            locationPathName = path + "/MyGame.exe",
            target = BuildTarget.StandaloneWindows64,
            options = BuildOptions.AutoRunPlayer
        };

        // Build the Player
        var buildReport = BuildPipeline.BuildPlayer(buildOptions);

        if (buildReport.summary.result != BuildResult.Succeeded)
        
        // Post-process: Copy README file to the build folder
        File.Copy("Assets/Documentation/README.txt", path + "/README.txt", true);
    }
}
```

This example has the following limitations:

-   It only works for one platform.
-   The list of scenes is hard coded directly in the script.
-   It bypasses many of the build settings configured in the [Build Profiles window](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles-reference.html).
-   You can’t use it in an automated build pipeline, because it requires user input to select the output folder each time it runs.

## Create a build script for multiple platforms

This example demonstrates a custom build script that supports building for multiple platforms: Windows, macOS, and Android. You can run these builds by selecting the platform from the **Build** menu in the Unity Editor, or by invoking the script from the command line.

``` lang-cs
using UnityEditor;
using UnityEditor.Build.Reporting;

public static class BuildScripts

        return enabledScenes.ToArray();
    }

    // General build method
    static void BuildForTarget(BuildTarget target, string outputPath)
    
        // Build player options
        BuildPlayerOptions options = new BuildPlayerOptions
        {
            scenes = scenes,
            locationPathName = outputPath,
            target = target,
            options = BuildOptions.None
        };

        // Execute the build
        BuildReport report = BuildPipeline.BuildPlayer(options);
        CheckBuildResult(report, outputPath);
    }

    [MenuItem("Build/Windows")]
    public static void BuildWindows()
    
    [MenuItem("Build/macOS")]
    public static void BuildMacOS()
    
    [MenuItem("Build/Android (AAB)")]
    public static void BuildAndroidAAB()
    
    // Helper to validate and log the build result
    static void CheckBuildResult(BuildReport report, string outputPath)
    
        else
        
    }
}
```

You can invoke this script from the [command line](https://docs.unity3d.com/6000.3/Documentation/Manual/build-command-line.html) using one of the following commands:

| **Platform** | **Command**                                                                                  |
|:-------------|:---------------------------------------------------------------------------------------------|
| **Windows**  | `-executeMethod BuildScripts.BuildWindows -buildTarget StandaloneWindows64 -quit -batchmode` |
| **macOS**    | `-executeMethod BuildScripts.BuildMacOS -buildTarget StandaloneOSX -quit -batchmode`         |
| **Android**  | `-executeMethod BuildScripts.BuildAndroidAAB -buildTarget Android -quit -batchmode`          |

This example is an improvement on the previous example in the following ways:

-   It retrieves a list of enabled scenes from [`EditorBuildSettings`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorBuildSettings.html).
-   It configures global settings that influence the behavior of the Player build. In this case, it sets Android options on the [`PlayerSettings`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayerSettings.html) and [`EditorUserBuildSettings`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorUserBuildSettings.html) objects.
-   It supports multiple platforms through a single shared `BuildForTarget` method.

However, it has limitations because it only supports three platforms, and the output paths are hard coded.

## Create an advanced build script with build profiles and AssetBundles

This example demonstrates a custom build script that introduces several advanced concepts:

-   **Using the active build profile**: This script automatically sets the scene list, flags, and settings based on the [active build profile](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profile-scene-list.html). Before using this script, you configure the builds by creating and saving [build profiles](https://docs.unity3d.com/6000.3/Documentation/Manual/create-build-profile.html) in the Build Profiles window.
-   **Dynamic output paths**: The script uses a naming convention for the output path based on the profile name and timestamp, similar to what a basic build server might do.
-   **AssetBundle builds**: The script performs an [AssetBundle](https://docs.unity3d.com/6000.3/Documentation/Manual/AssetBundlesIntro.html) build followed by a Player build.
-   **Type preservation**: The script provides type information from the AssetBundle build as an input to the Player build, so that [managed code stripping](https://docs.unity3d.com/6000.3/Documentation/Manual/managed-code-stripping-content.html) doesn’t remove types used in the AssetBundles.
-   **Build callbacks**: The script uses a [`BuildPlayerProcessor`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPlayerProcessor.html) [build callback](https://docs.unity3d.com/6000.3/Documentation/Manual/build-callbacks.html) to inject the AssetBundle build into the [`StreamingAssets` folder](https://docs.unity3d.com/6000.3/Documentation/Manual/StreamingAssets.html) of the Player build.

``` lang-cs
using UnityEngine;
using System.IO;
using UnityEditor;
using UnityEditor.Build;
using UnityEditor.Build.Reporting;
using UnityEditor.Build.Profile;

// Example BuildScript that supports building the current build profile.
//
//
// It builds AssetBundles and includes them in the player build.
// Each time it runs it builds into a new directory derived from the
// current build profile and timestamp.
public class BuildScript
{
    public const string kBuildRootPath = "Build"; // All builds are inside this top level project folder
    public const string kAssetBundleDirectory = "AssetBundles";
    public const string kPlayerDirectory = "Player";
    public const string kAppName = "MyGame";
    public const string kTextureSourceDirectory = "Assets/Textures";
    public const string kTextureSearchPattern = "*.png";

    // Global variable so that RegisterContentForPlayer can find the correct AssetBundles to include in the player build
    public static string gCurrentBuildRootPath = null;

    [MenuItem("Build/Build Active Profile")]
    public static void BuildPlayerAndBundles()
    {
        var profile = BuildProfile.GetActiveBuildProfile();
        if (profile == null)
            throw new BuildFailedException("No active build profile is set." +
                "Use the Build Profiles window or the `-activeBuildProfile` cli argument");

        // Use a timestamp so that each build goes to a unique output folder
        var timeStamp = System.DateTime.Now.ToString("yyyy-MM-dd_HH-mm-ss");
        gCurrentBuildRootPath = $"{kBuildRootPath}/{profile.name}/{timeStamp}";

        // Build AssetBundles so that they can be shipped inside the player
        var assetBundleBuildPath = BuildAssetBundles(gCurrentBuildRootPath);

        // To preserve types used by the AssetBundles
        var assetBundleManifestPath = assetBundleBuildPath + "/AssetBundles.manifest";

        // Build the player
        var playerBuildOptions = new BuildPlayerWithProfileOptions()
        {
            buildProfile = profile,
            locationPathName = CreatePlayerOutputPath(gCurrentBuildRootPath),
            assetBundleManifestPath = assetBundleManifestPath,

            // These options can be adjusted as needed.
            // Note: the development and compression flags come from the build profile
            options = BuildOptions.CleanBuildCache | BuildOptions.StrictMode
        };

        // Convenient for manual testing
        if (!Application.isBatchMode)
            playerBuildOptions.options |= BuildOptions.AutoRunPlayer;

        var report = BuildPipeline.BuildPlayer(playerBuildOptions);

        gCurrentBuildRootPath = null;

        if (report.summary.result != BuildResult.Succeeded)
            throw new BuildFailedException("Player build failed, see Editor log for details");

        Debug.Log($"Completed build to {playerBuildOptions.locationPathName}");
    }

    private static string BuildAssetBundles(string buildRootDirectory)
    {
        var assetBundlePath = buildRootDirectory + "/" + kAssetBundleDirectory;

        if (!Directory.Exists(assetBundlePath))
            Directory.CreateDirectory(assetBundlePath);

        // For simplicity in this example, define a single AssetBundle,
        // containing all the textures found inside a hard-coded directory in the project
        string[] texturePaths = Directory.GetFiles(kTextureSourceDirectory, kTextureSearchPattern, SearchOption.AllDirectories);

        var assetBundleContents = new AssetBundleBuild()
        {
            assetBundleName = "textures.bundle",
            assetNames = texturePaths
        };

        // The target platform will be automatically set based on the active build profile
        var assetBundleBuildOptions = new BuildAssetBundlesParameters()
        
        };

        AssetBundleManifest manifest = BuildPipeline.BuildAssetBundles(assetBundleBuildOptions);

        if (manifest == null)
            throw new BuildFailedException("AssetBundle build failed, see Editor log for details");

        return assetBundlePath;
    }

    private static string CreatePlayerOutputPath(string buildRootDirectory)
    {
        var playerOutputFolder = $"{buildRootDirectory}/{kPlayerDirectory}";

        if (!Directory.Exists(playerOutputFolder))
            Directory.CreateDirectory(playerOutputFolder);

        var playerPath = $"{playerOutputFolder}/{kAppName}";

        // This property will match the target in the active build profile
        var target = EditorUserBuildSettings.activeBuildTarget;

        // See "Build path requirements for target platforms" in the Unity Manual
        if ((target == BuildTarget.StandaloneWindows64) ||
            (target == BuildTarget.StandaloneWindows))
            playerPath += ".exe";
        else if (target == BuildTarget.StandaloneOSX)
            playerPath += ".app";
        else if (target == BuildTarget.StandaloneLinux64)
            playerPath += ".x86_64";
        else if (target == BuildTarget.Android)
            playerPath += ".aab";

        return playerPath;
    }
}

// Put the AssetBundle build directory into the StreamingAssets folder of the player output.
// This approach keeps built content separate from the source project, avoiding clutter in "Assets/StreamingAssets".
public class RegisterContentForPlayer : BuildPlayerProcessor

    public override int callbackOrder => 1;
}
```

### Using the script in the Editor

To use this script in the Unity Editor:

1.  Select the desired build profile in the Build Profiles window.
2.  Select **Build > Build Active Profile** from the menu.

### Using the script from the command line

You can also invoke this script from the command line. On Windows, the command is as follows:

    .\Unity.exe -batchmode -projectPath "C:\UnityProjects\CLIBuildExample" -activeBuildProfile "Assets\Settings\Build Profiles\MyWindowsProfile.asset" -executeMethod BuildScript.BuildPlayerAndBundles -logFile C:\logs\buildlog.txt -quit

An equivalent command on macOS is as follows:

    Unity -batchmode -projectPath "~/UnityProjects/CLIBuildExample" -activeBuildProfile "Assets/Settings/Build Profiles/MyWeb - Desktop - Development.asset" -executeMethod BuildScript.BuildPlayerAndBundles -logFile "~/logs/buildlog.txt" -quit

**Note**: Adjust the paths in the command lines in the previous examples to match the configuration of your device and path to your Unity project. For more information about command line arguments, refer to [Build a player from the command line](https://docs.unity3d.com/6000.3/Documentation/Manual/build-command-line.html).

## Additional resources

-   [`BuildPipeline.BuildPlayer` API reference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPipeline.BuildPlayer.html)
-   [`BuildPlayerOptions` API reference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPlayerOptions.html)
-   [`BuildReport` API reference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.Reporting.BuildReport.html)
-   [Build a player from the command line](https://docs.unity3d.com/6000.3/Documentation/Manual/build-command-line.html)
-   [Build callbacks](https://docs.unity3d.com/6000.3/Documentation/Manual/build-callbacks.html)
-   [Build path requirements for target platforms](https://docs.unity3d.com/6000.3/Documentation/Manual/build-path-requirements.html)
