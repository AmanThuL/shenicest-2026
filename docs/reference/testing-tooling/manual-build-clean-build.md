---
title: "Create a clean build"
page_title: "Unity - Manual: Create a clean build"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/build-clean-build.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/build-clean-build.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Create a clean build

By default, Unity creates builds incrementally, however the incremental pipeline can cause caching issues, or incomplete builds. For example, Unity [serializes](https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization.html) scenes and assets for the target platform during the build process, and either reuses all content from the previous build, or rebuilds everything. However, this detection might fail when global settings affect build output. You can create a clean build to resolve this issue.

When Unity creates a clean build, it discards some cached build data but reuses previously imported assets and cached shaders to rebuild all content and code. Use a clean build when preparing release builds or troubleshooting issues caused by corrupted or outdated build caches.

To create a clean build:

1.  Open the **Build Profiles** window (**File** > **Build Profiles**).
2.  Next to the **Build** button, select the drop-down.
3.  Select **Clean Build**.

You can also create a clean build from a [build script](https://docs.unity3d.com/6000.3/Documentation/Manual/build-script-build.html) by passing [`BuildOptions.CleanBuildCache`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.CleanBuildCache.html) in the call to [`BuildPipeline.BuildPlayer`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPipeline.BuildPlayer.html).

If you don’t want Unity to reuse imported assets and cached shaders, you can delete the `Library` folder to force Unity to repeat all imports and shader compilation. This approach increases build time but helps avoid issues that might occur at earlier stages of the build process.

To create a clean build without using cached shaders and assets:

1.  Close the Editor.
2.  Delete the `Library` folder
3.  Use the previous instructions to create a clean build.

## Additional resources

-   [Create a build from the Editor](https://docs.unity3d.com/6000.3/Documentation/Manual/BuildSettings.html)
-   [Content output of a build](https://docs.unity3d.com/6000.3/Documentation/Manual/build-content-output.html)
