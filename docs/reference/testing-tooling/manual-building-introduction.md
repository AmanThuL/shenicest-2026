---
title: "Unity 6.3 Manual: Introduction to building"
page_title: "Unity - Manual: Introduction to building"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/building-introduction.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/building-introduction.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to building

When you create a build of your application, you create a Player. A Player is the platform-specific runtime application that Unity builds from your project. This is also known as a **project build**, which is the workflow of building a project from the Unity Editor into an application that runs on a target platform.

Building a Player for a target platform requires the platform-specific build support module for the target platform. You can add build support for a target platform when you [install Unity](https://docs.unity3d.com/6000.3/Documentation/Manual/GettingStartedInstallingUnity.html), or add it when you [create a Build Profile](https://docs.unity3d.com/6000.3/Documentation/Manual/create-build-profile.html).

Unity uses the scenes you define in the [Build Profiles](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles.html) window or the [`BuildPipeline`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPipeline.html) API to create a build of a Player. For more information, refer to [Manage scenes in a build](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profile-scene-list.html).

## Build modes

Unity has different build modes, as follows:

-   **Release** build: Includes only what’s necessary to run the application. This is the default build type.
-   **Development** build: Includes scripting debug symbols and the [Profiler](https://docs.unity3d.com/6000.3/Documentation/Manual/Profiler.html). You can enable development builds in the [Build Profiles](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles.html) window, which allows you to set further options such as [deep profiling support](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-deep-profiling.html) and script debugging. You can also use the [`BuildOptions.Development`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.Development.html) property to set a development build.

Both build modes provide options to build different variations of the Player application for different hardware architectures and [scripting backends](https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-backends.html). You can customize these variations through the [build settings](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles-reference.html), [Player settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PlayerSettings.html), or [command-line flags](https://docs.unity3d.com/6000.3/Documentation/Manual/EditorCommandLineArguments.html).

<span id="incremental-build-pipeline"></span>

## Incremental build pipeline

Unity uses an incremental build pipeline that only rebuilds the parts of your application that have changed since the last build, which helps speed up development iteration time. This build process includes build steps such as content building, code compilation, data compression, and signing.

By default, Unity uses the incremental build pipeline for both [development and release builds](https://docs.unity3d.com/6000.3/Documentation/Manual/building-introduction.html). You can use the options in the **Build Profiles** window, or use the `BuildOptions.CleanBuildCache` API to create a non-incremental build, also known as a clean build. For more information, refer to [Creating clean builds](https://docs.unity3d.com/6000.3/Documentation/Manual/build-clean-build.html).

**Note:** [AssetBundles](https://docs.unity3d.com/6000.3/Documentation/Manual/AssetBundlesIntro.html) don’t use the incremental build pipeline and have separate mechanisms for caching and reusing the results from previous builds. For more information, refer to [Build assets into an AssetBundle](https://docs.unity3d.com/6000.3/Documentation/Manual/AssetBundles-Building.html).

## Additional resources

-   [Build Profiles](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles.html)
-   [Create a Build Profile](https://docs.unity3d.com/6000.3/Documentation/Manual/create-build-profile.html)
-   [Build Profiles window reference](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles-reference.html)
-   [Player settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PlayerSettings.html)
-   [Create a clean build](https://docs.unity3d.com/6000.3/Documentation/Manual/build-clean-build.html)
