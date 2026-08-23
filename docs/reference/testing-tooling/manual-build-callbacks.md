---
title: "Use build callbacks"
page_title: "Unity - Manual: Use build callbacks"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/build-callbacks.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/build-callbacks.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Use build callbacks

You can implement build callbacks to insert custom behavior into the Player build process. Unity invokes these callbacks whether you trigger the Player build from the [Build Profiles](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles.html) window, from a custom menu, or from a [command line build](https://docs.unity3d.com/6000.3/Documentation/Manual/build-command-line.html). Build callbacks are useful when adding custom build behavior for a package used across different Unity projects.

## Supported callbacks

The following table lists the build callbacks that Unity supports:

| **Callback**                                                                                                                            | **Method**                      | **Description**                                                   |
|:----------------------------------------------------------------------------------------------------------------------------------------|:--------------------------------|:------------------------------------------------------------------|
| [`BuildPlayerProcessor`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.BuildPlayerProcessor.html)                 | `PrepareForBuild`               | Add files and perform custom setup before the build starts.       |
| [`IPreprocessBuildWithContext`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.IPreprocessBuildWithContext.html)   | `OnPreprocessBuild`             | Called at the start of a build.                                   |
| [`IPostprocessBuildWithContext`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.IPostprocessBuildWithContext.html) | `OnPostprocessBuild`            | Called at the end of the build.                                   |
| [`IFilterBuildAssemblies`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.IFilterBuildAssemblies.html)             | `OnFilterAssemblies`            | Remove assemblies from the build.                                 |
| [`IPostBuildPlayerScriptDLLs`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.IPostBuildPlayerScriptDLLs.html)     | `OnPostBuildPlayerScriptDLLs`   | Read or patch managed assemblies after compilation.               |
| [`IProcessSceneWithReport`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.IProcessSceneWithReport.html)           | `OnProcessScene`                | Called while Unity processes each scene for the build.            |
| [`IPreprocessShaders`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.IPreprocessShaders.html)                     | `OnProcessShader`               | Filter the list of shader variants to reduce shader build times.  |
| [`IPreprocessComputeShaders`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.IPreprocessComputeShaders.html)       | `OnProcessComputeShader`        | Similar to `IPreprocessShaders` but intended for compute shaders. |
| [`IUnityLinkerProcessor`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.IUnityLinkerProcessor.html)               | `GenerateAdditionalLinkXmlFile` | Configure the managed code stripping stage of a Player build.     |
| [`IPostprocessLaunch`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.IPostprocessLaunch.html)                     | `OnPostprocessLaunch`           | Called if the Player is launched as a final step of the build.    |

Player builds support all these callbacks. Content-only builds, which don’t include managed assemblies, only invoke a subset: `IPreprocessBuildWithContext`, `IPostprocessBuildWithContext`, `IProcessSceneWithReport`, and `IPreprocessComputeShaders`.

## Callback ordering

You can use [`IOrderedCallback.callbackOrder`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.IOrderedCallback.callbackOrder.html) to control the execution order of a build callback relative to other implementations of the same callback interface. Unity sorts the callbacks from lowest to highest order value, and you can assign any negative or positive integer value. For example, if your implementation of `IPreprocessBuildWithContext` has an order value of 2, it runs after another `IPreprocessBuildWithContext` callback that has an order value of 1.

## Build callbacks during incremental builds

The following build callbacks happen during the content step of a Player build:

-   **Scene callbacks**: [`IProcessSceneWithReport.OnProcessScene`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.IProcessSceneWithReport.OnProcessScene.html)
-   **Shader callbacks**: [`IPreprocessShaders.OnProcessShader`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.IPreprocessShaders.OnProcessShader.html), [`IPreprocessComputeShaders.OnProcessComputeShader`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.IPreprocessComputeShaders.OnProcessComputeShader.html)

When Unity reuses content from a previous build, it doesn’t trigger these callbacks again because they already ran during the previous build. Unity caches any content change caused by the callback in the output from the previous build.

To ensure that Unity runs a modified callback implementation, perform a [clean build](https://docs.unity3d.com/6000.3/Documentation/Manual/build-clean-build.html), or modify the content of one of the scenes or assets in the build.

Other build callbacks that run before or after the content stage might trigger again during incremental builds. These callbacks must handle running multiple times on the same build output. For example, if a callback adds entries to an [Android app manifest](https://docs.unity3d.com/6000.3/Documentation/Manual/android-manifest.html), it must check if those entries already exist to avoid creating an invalid manifest file.

## Additional resources

-   [Customize the build pipeline](https://docs.unity3d.com/6000.3/Documentation/Manual/BuildPlayerPipeline.html)
-   [Create a custom build script](https://docs.unity3d.com/6000.3/Documentation/Manual/build-script-build.html)
-   [Create a clean build](https://docs.unity3d.com/6000.3/Documentation/Manual/build-clean-build.html)
