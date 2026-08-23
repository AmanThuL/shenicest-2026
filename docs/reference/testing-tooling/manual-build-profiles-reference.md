---
title: "Build Profiles window reference"
page_title: "Unity - Manual: Build Profiles window reference"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles-reference.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles-reference.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Build Profiles window reference

Configure build settings for the target platforms and override specific project settings for a build profile.

**Note**: Access the **Build Profiles** window in the Unity Editor from **File** \> **Build Profiles**.

The following sections describe the settings available in the **Build Profiles** window.

-   [Asset Import Overrides](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles-reference.html#AssetImportOverride)
-   [Platform Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles-reference.html#platform-settings)
-   [Diagnostics](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles-reference.html#diagnostics)
-   [Add Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles-reference.html#add-settings)
-   [Build options](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles-reference.html#build-options)

<span id="AssetImportOverride"></span>

## Asset Import Overrides

To speed up the time it takes to import assets and change platforms, you can locally override all texture import settings. During development, asset overrides can be useful to speed up iteration time by using lower quality assets.

**Note**: To set asset import overrides for initial project imports, use the Editor [command line arguments](https://docs.unity3d.com/6000.3/Documentation/Manual/CommandLineArguments.html) `-overrideMaxTextureSize` and `-overrideTextureCompression`.

<table><colgroup><col style="width: 50%" /><col style="width: 50%" /></colgroup><thead><tr class="header"><th><strong>Property</strong></th><th><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td><strong>Max Texture Size</strong></td><td>Override the maximum imported texture size. Unity imports textures in the lower of two values: this value, or the Max Size value specified in <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-TextureImporter.html">Texture import settings</a>. The time it takes to import a texture is proportional to the number of pixels it contains, so a texture size with a lower maximum can speed up import times. It’s recommended to use this setting only during development as the resulting textures are lower in resolution.</td></tr><tr class="even"><td><strong>Texture Compression</strong></td><td>Override the texture compression options set in <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-TextureImporter.html">Texture import settings</a>.<br />
<br />
<strong>Note</strong>: The following texture compression options only apply to textures referenced in <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/texture-formats-reference.html">GPU texture formats reference</a>.<br />
<br />
<ul><li><strong>Force Fast Compressor</strong>:Use a faster but lower quality texture compression mode for formats that support it (BC7, BC6H, ASTC, ETC, ETC2). Usually this results in more compression artifacts, but for many formats the compression itself is 2 to 20 times faster. This setting also disables <strong>Crunch</strong> texture compression format on any textures that have it. The effect of this setting is the same as if all textures had their <strong>Compressor Quality</strong> set to a low number in the platforms section of their <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-TextureImporter.html">Texture import settings</a>.</li><li><strong>Force Uncompressed</strong>: Use uncompressed formats. This is faster to import (because it skips the texture compression process), but the resulting textures take up more memory and game data size, and can impact rendering performance. The effect of this setting is the same as if all textures had their <strong>Compression</strong> set to <strong>None</strong> in their platforms’ <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-TextureImporter.html">Texture import settings</a>.</li><li><strong>Force No Crunch</strong>: Disable Crunch compression for all textures. Crunch compression can take a long time, so disabling it can speed up the import process significantly. However, the resulting textures take up more disk space. Selecting this option is the same as disabling <strong>Use Crunch Compression</strong> in the <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-TextureImporter.html">Texture import settings</a> for all textures.</li></ul></td></tr></tbody></table>

<span id="platform-settings"></span>

## Platform Settings

Each platform has specific build settings. For more information, refer to the following platform-specific documentation:

| **Platform**                       | **Documentation**                                                                                                                  |
|:-----------------------------------|:-----------------------------------------------------------------------------------------------------------------------------------|
| **Android**                        | [Android build settings reference](https://docs.unity3d.com/6000.3/Documentation/Manual/android-build-settings.html)               |
| **iOS and tvOS**                   | [iOS build settings reference](https://docs.unity3d.com/6000.3/Documentation/Manual/BuildSettingsiOS.html)                         |
| **Embedded Linux**                 | [Embedded Linux build settings reference](https://docs.unity3d.com/6000.3/Documentation/Manual/embedded-linux-build-settings.html) |
| **Linux**                          | [Linux build settings reference](https://docs.unity3d.com/6000.3/Documentation/Manual/Buildsettings-linux.html)                    |
| **macOS**                          | [macOS build settings reference](https://docs.unity3d.com/6000.3/Documentation/Manual/macosbuildsettings.html)                     |
| **QNX**                            | [QNX build settings reference](https://docs.unity3d.com/6000.3/Documentation/Manual/qnx-build-settings.html)                       |
| **Universal Windows Platform**     | [UWP build settings reference](https://docs.unity3d.com/6000.3/Documentation/Manual/windowsstore-buildsettings.html)               |
| **Web and Facebook Instant Games** | [Web build settings](https://docs.unity3d.com/6000.3/Documentation/Manual/web-build-settings.html)                                 |
| **Windows**                        | [Windows build settings reference](https://docs.unity3d.com/6000.3/Documentation/Manual/WindowsStandaloneBinaries.html)            |

**Note**: For information on build settings for closed platforms, refer to the included documentation in the Unity installer of each closed platform.

<span id="shared-build-settings"></span>

### Shared build settings

The following build settings are available for all profile types. The values of these settings are shared across platform profiles but not across build profiles.

**Note**: Updating shared settings of an active platform profile using [`EditorUserBuildSettings`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorUserBuildSettings.html) applies changes across all platform profiles. However, updating shared settings of an active build profile with [`EditorUserBuildSettings`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorUserBuildSettings.html) only updates that specific build profile.

<table><colgroup><col style="width: 50%" /><col style="width: 50%" /></colgroup><thead><tr class="header"><th><strong>Property</strong></th><th><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td><strong>Development Build</strong></td><td>Include scripting debug symbols and the <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/Profiler.html">Profiler</a> in your build. Use this setting when you want to test your application. When you select this option, Unity sets the <code>DEVELOPMENT_BUILD</code> scripting define symbol. Your build then includes preprocessor directives that set <code>DEVELOPMENT_BUILD</code> as a condition.<br />
<br />
For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/platform-dependent-compilation.html">Platform dependent compilation</a>.</td></tr><tr class="even"><td><strong>Autoconnect Profiler</strong></td><td>Automatically connect the Unity Profiler to your build. For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/Profiler.html">Profiler</a>.<br />
<br />
<strong>Note</strong>: This option is available only if you select <strong>Development Build</strong>.</td></tr><tr class="odd"><td><strong>Deep Profiling</strong></td><td>Allow the Profiler to process all your script code and record every function call, returning detailed profiling data. For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/ProfilerWindow.html#deep-profiling">Deep Profiling</a>.<br />
<br />
This property is available only if you enable <strong>Development Build</strong>.<br />
<br />
<strong>Note</strong>: Enabling <strong>Deep Profiling</strong> might slow down script execution.</td></tr><tr class="even"><td><strong>Script Debugging</strong></td><td>Attach script debuggers to the Player remotely.<br />
<br />
This property is available only if you enable <strong>Development Build</strong>.</td></tr><tr class="odd"><td><strong>Wait for Managed Debugger</strong></td><td>Make the Player wait for a debugger to be attached before it executes any script code.<br />
<br />
This property is visible only if you enable <strong>Script Debugging</strong>.</td></tr><tr class="even"><td><strong>Compression Method</strong></td><td>Specifies the method Unity uses to compress the data in your Project when it builds the Player. This includes <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/assets-supported-types.html">Assets</a>, <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/CreatingScenes.html">Scenes</a>, <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-PlayerSettings.html">Player settings</a>, and <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/GICache.html">GI data</a>.<ul><li><strong>Default</strong>: On Windows, Mac, Linux Standalone, and iOS, there’s no default compression. On Android, the default compression is ZIP, which gives slightly better compression results than LZ4HC. However, ZIP data is slower to decompress.</li><li><strong>LZ4</strong>: A fast compression format that is useful for development builds. For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.CompressWithLz4.html">BuildOptions.CompressWithLz4</a>.</li><li><strong>LZ4HC</strong>: A high compression variant of LZ4 that is slower to build but produces better results for release builds. For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.CompressWithLz4HC.html">BuildOptions.CompressWithLz4HC</a>.</li></ul></td></tr></tbody></table>

<span id="diagnostics"></span>

## Diagnostics

**Note**: The **Diagnostics** section is visible only when using a build profile on Android, iOS, macOS, and Windows platforms. This section is visible by default on these platforms and isn’t added through [Add Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles-reference.html#add-settings).

<table><thead><tr class="header"><th style="text-align: left;"><strong>Property</strong></th><th style="text-align: left;"><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Diagnostic Data</strong></td><td style="text-align: left;">Configure settings to collect diagnostic data for each build profile in your project. Use these settings to override the default setting specified in <strong>Project Settings</strong> &gt; <strong>Services</strong> &gt; <strong>Diagnostics</strong> &gt; <strong>Diagnostic Data</strong> per build profile. For more information on diagnostic data, refer to <a href="https://docs.unity.com/en-us/cloud/developer-data/">Developer Data framework</a>.<br />
<br />
The following options are available:<ul><li><strong>Disabled</strong>: Disables collection of diagnostic data for the build.<br />
<strong>Note</strong>: <strong>Diagnostic Data</strong> is set to <strong>Disabled</strong> if your project isn’t connected to <a href="https://docs.unity.com/en-us/cloud">Unity Cloud</a>. To collect diagnostic data, you must link your project to Unity Cloud via <strong>Project Settings</strong>. For more information, refer to <a href="https://docs.unity.com/cloud/en-us/projects/configure-project-for-unity-cloud">Configure a project for Unity Cloud</a>.</li><li><strong>Use Project Settings &gt; Diagnostics</strong>: Uses the value specified in <strong>Project Settings</strong> &gt; <strong>Services</strong> &gt; <strong>Diagnostics</strong> &gt; <strong>Diagnostic Data</strong>. All builds for your project use the value in this setting by default.</li><li><strong>Enabled</strong>: Enables collection of diagnostic data for the build.</li></ul><strong>Note</strong>: Disabling Diagnostic Data collection can impact the performance and behavior of services that rely on Developer Data.</td></tr></tbody></table>

<span id="add-settings"></span>

## Add Settings

Use the **Add Settings** button to add optional settings to a build profile. You should only add the settings you want to customize. The settings you add appear in a section with a foldout, where you can customize them for the build profile.

**Note**: The **Add Settings** button is available only for build profiles and not for platform profiles. This button is disabled when you add all available settings to the build profile.

The following settings are available for customization through **Add Settings**. Additional settings might be available based on the packages installed in your project.

<table><thead><tr class="header"><th style="text-align: left;"><strong>Setting</strong></th><th style="text-align: left;"><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Scene List</strong></td><td style="text-align: left;">Create a custom scene list for your build profile. When you add <strong>Scene List</strong>, scenes are automatically inherited from the global scene list. For more information on managing scenes, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/build-profile-scene-list.html">Manage scenes in a build</a>.<br />
<br />
<strong>Note</strong>: For platform profiles, <strong>Scene List</strong> is visible by default.</td></tr><tr class="even"><td style="text-align: left;"><strong>Scripting Defines</strong></td><td style="text-align: left;">Add custom scripting defines for your build profile. These custom scripting defines are additive and don’t override other scripting defines in your project. For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/custom-scripting-symbols.html">Custom scripting symbols</a>.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Player Settings</strong></td><td style="text-align: left;">Create custom <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-PlayerSettings.html">Player</a> settings for your build profile. The Player settings inherit their initial values from the global Player settings for the build profile’s target platform. To access the global Player settings, use the link in the <strong>Build Profiles</strong> toolbar or navigate to <strong>Edit</strong> &gt; <strong>Project Settings</strong> &gt; <strong>Player</strong>.<br />
<br />
<strong>Note</strong>: For an active build profile, the Player Settings overrides are linked to the <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayerSettings.html">Player settings APIs</a>. If you use the Player Settings APIs to modify a Player setting for an active build profile, the change will update the corresponding override value.</td></tr><tr class="even"><td style="text-align: left;"><strong>Graphics Settings</strong></td><td style="text-align: left;">Create custom <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-GraphicsSettings.html">Graphics</a> settings for your build profile. The Graphics settings inherit their initial values from the global settings in <strong>Edit</strong> &gt; <strong>Project Settings</strong> &gt; <strong>Graphics</strong>.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Quality Settings</strong></td><td style="text-align: left;">Create custom <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-QualitySettings.html">Quality</a> levels for your build profile. The Quality settings inherit their initial values from the global settings in <strong>Edit</strong> &gt; <strong>Project Settings</strong> &gt; <strong>Quality</strong>. For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles-override-settings.html#override-quality">Customize settings with build profiles</a>.</td></tr><tr class="even"><td style="text-align: left;"><strong>Adaptive Performance Settings</strong></td><td style="text-align: left;">Create custom <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/adaptive-performance/provider-settings-reference.html">Adaptive Performance</a> settings for your build profile. These settings inherit their initial values from the global settings in <strong>Edit</strong> &gt; <strong>Project Settings</strong> &gt; <strong>Adaptive Performance</strong>.</td></tr></tbody></table>

<span id="build-options"></span>

## Build options

To build your application, select one of the following options:

<table><thead><tr class="header"><th style="text-align: left;"><strong>Property</strong></th><th style="text-align: left;"><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Cloud Build</strong></td><td style="text-align: left;">Use <strong>Unity Build Automation</strong> to build your project in the cloud. When selecting <strong>Cloud Build</strong> for the first time, a dialog appears prompting you to install the Build Automation package. Connect your Unity project to your Unity Build Automation project using <strong>Edit</strong> &gt; <strong>Project Settings</strong> &gt; <strong>Services</strong>. Once connected, use the <strong>Build Automation Settings</strong> section in your build profile to configure your cloud build. For more information, refer to <a href="https://docs.unity.com/ugs/en-us/manual/devops/manual/build-automation/overview">Build Automation Overview</a>.<br />
<br />
<strong>Note</strong>: <strong>Cloud Build</strong> is visible only when using a build profile.</td></tr><tr class="even"><td style="text-align: left;"><strong>Build</strong></td><td style="text-align: left;">Build the Player without launching it. The default build is incremental, except for the first build, which is always a full non-incremental clean build. This option runs a build without the <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.StrictMode.html">StrictMode</a> option enabled.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Clean build</strong></td><td style="text-align: left;">Create a clean, <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/build-clean-build.html">non-incremental</a> build.</td></tr><tr class="even"><td style="text-align: left;"><strong>Force skip data build</strong></td><td style="text-align: left;">Skip the content step of the build process. This requires that you have already performed a successful build and that it is compatible with the current scripts in your project. For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/build-scripts-only.html">Create a scripts-only build</a>.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Build and Run</strong></td><td style="text-align: left;">Build the Player and open it on your target platform. This option runs a build with the <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.StrictMode.html">StrictMode</a> option enabled. Unity will do an incremental build when possible, otherwise it will perform a clean build.</td></tr></tbody></table>

**Note**: The **Build** and **Build and Run** settings are visible only for the active profile.

## Additional resources

-   [Create a build profile](https://docs.unity3d.com/6000.3/Documentation/Manual/create-build-profile.html)
-   [Build Profiles scripting API reference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.Profile.BuildProfile.html)
