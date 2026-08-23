---
title: "Unity 6.3 Manual: Reducing the file size of a build"
page_title: "Unity - Manual: Reducing the file size of a build"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/ReducingFilesize.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/ReducingFilesize.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Reducing the file size of a build

Keeping the file size of your built application to a minimum is important to ensure that it doesn’t take up too much space on the end device, or to meet size requirements when submitting your application to online stores.

## Suggestions for reducing build size

The following settings and features impact the size of a build:

| **Feature**                | **Resolution**                                                                                                                                                                                                         |
|:---------------------------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Compressed texture formats | Refer to [Choose a GPU texture format by platform](https://docs.unity3d.com/6000.3/Documentation/Manual/texture-choose-format-by-platform.html).                                                                       |
| Compressed meshes          | Refer to [Configure mesh compression](https://docs.unity3d.com/6000.3/Documentation/Manual/configure-mesh-compression.html).                                                                                           |
| Compressed animation clips | Refer to [Animation properties](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AnimationClip.html#AssetProperties).                                                                                        |
| Strip unreferenced code    | Refer to [Configure managed code stripping](https://docs.unity3d.com/6000.3/Documentation/Manual/managed-code-stripping-configure.html).                                                                               |
| .NET library size          | Using .NET Standard as the [API Compatibility Level](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PlayerSettings.html) restricts you to a smaller subset of the .NET API, which can help keep size down. |

## Tools to analyze build size

Unity has the following tools for analyzing the size of a build.

### Build Report Inspector

Use the [Build Report Inspector package](https://docs.unity3d.com/Packages/com.unity.build-report-inspector@latest) to add an Inspector to the BuildReport file that Unity generates when it creates a build. The build report file is located at `Library/LastBuild.buildreport`. The package uses the [`BuildReport`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.Reporting.BuildReport.html) API to create the Inspector window. It displays information such as the build steps, and assets in the build.

### Editor logs

You can inspect the Editor log after you perform a build to determine which assets were the largest in the build. To open the log:

1.  Open the [**Console** window](https://docs.unity3d.com/6000.3/Documentation/Manual/Console.html) (**Window** > **General** > **Console**).
2.  Select the More menu (⋮) and select **Open Editor Log**.

![The Editor log just after a build](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/FileSizeOptimization.png)

The Editor log provides a summary of assets broken down by type, and then lists all the individual assets in order of size contribution. Typically, assets like textures, sounds, and animations take up the most storage. Scripts, scenes, and shaders usually have the smallest impact. The **File headers** in the list are extra data added to asset files to store references and settings. The headers normally make very little difference to asset size, but the value might be large if you have many large assets in the [Resources folder](https://docs.unity3d.com/6000.3/Documentation/Manual/LoadingResourcesatRuntime.html).

The Editor Log helps you to identify assets that you might want to remove or optimize, but consider the following before you start:

-   Unity re-codes imported assets into its own internal formats, so the choice of source asset type isn’t relevant. For example, if you have a multi-layer texture `.psd` file in the project, Unity flattens and compresses it before building. Exporting the texture as a `.png` file doesn’t make any difference to build size.
-   Unity [includes assets that are referenced](https://docs.unity3d.com/6000.3/Documentation/Manual/assets-direct-reference.html) in your project and strips any unused assets during the build process, so you don’t need to manually remove assets from the project. The only assets that aren’t removed are assets in the [`Resources` folder](https://docs.unity3d.com/6000.3/Documentation/Manual/LoadingResourcesatRuntime.html). Unity includes all assets in the `Resources` folder in a build, so it’s important to ensure that all assets in the `Resources` folder are ones used in your application.

## Additional resources

-   [Include additional files in a build](https://docs.unity3d.com/6000.3/Documentation/Manual/StreamingAssets.html)
-   [Customizing the Player](https://docs.unity3d.com/6000.3/Documentation/Manual/BuildPlayerPipeline.html)
-   [Build Report Inspector package](https://docs.unity3d.com/Packages/com.unity.build-report-inspector@latest)
