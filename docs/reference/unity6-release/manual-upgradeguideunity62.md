---
title: "Upgrade to Unity 6.2"
page_title: "Unity - Manual: Upgrade to Unity 6.2"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity62.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity62.html"
topic: "unity6-release"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Upgrade to Unity 6.2

This page lists changes in Unity 6.2 that can affect existing projects when you upgrade them from Unity 6.1 to Unity 6.2.

Review changes for Unity 6.2 in these areas:

-   [Graphics](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity62.html#graphics)
-   [UI Toolkit](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity62.html#ui-toolkit)

## Graphics <span id="graphics"></span>

This section outlines recent updates to Unity’s graphics systems that can affect your upgrade experience.

### Select shader APIs are now deprecated

Unity 6.2 deprecates a set of shader APIs that are superseded by more recent APIs. Refer to the [6.2 release notes](https://unity.com/releases/editor/whats-new/6000.2.0) for the full list of deprecated APIs and the APIs to replace them with. The deprecated APIs will be removed in a future release.

### Change to AfterRendering injection point timing in URP

The `AfterRendering` injection point now always executes after the final blit to the back buffer. In previous Unity versions, `AfterRendering` sometimes executes before the final blit, if, for example, an effect like Fast Approximate Anti-Aliasing (FXAA) or an upscaler requires an additional final post-processing render pass.

To preserve the old behavior and continue rendering into an intermediate texture rather than the back buffer, change the event in your custom render pass from `AfterRendering` to `AfterRenderingPostProcessing`. This avoids further changes such as handling y-flips. The change is backward-compatible, so you can apply it to Unity 6.0 and later to maintain compatibility across all Unity 6 versions.

### SetupRenderPasses is deprecated in URP

The `SetupRenderPasses` API is now deprecated in the Universal Render Pipeline (URP). This API will be removed in a future release.

If your project contains Scriptable Renderer Features that use `SetupRenderPasses`, rewrite them using the render graph system and the `AddRenderPasses` API. For more information, refer to [Render graph system](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph.html).

For compatibility purposes, Unity 6 includes the option to disable the render graph system and use the rendering path from previous URP versions. Unity no longer develops or improves this rendering path. For more information, refer to [Compatibility Mode](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/compatibility-mode).

## UI Toolkit <span id="ui-toolkit"></span>

This section outlines recent updates to Unity’s UI Toolkit that can affect your upgrade experience.

### VisualElement.transform API deprecated

The [VisualElement.transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.VisualElement-transform.html) API has been deprecated.

To set values, use:

-   [VisualElement.style.translate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.IStyle-translate.html)
-   [VisualElement.style.rotate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.IStyle-rotate.html)
-   [VisualElement.style.scale](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.IStyle-scale.html)

To read values, use:

-   [VisualElement.resolvedStyle.translate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.IResolvedStyle-translate.html)
-   [VisualElement.resolvedStyle.rotate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.IResolvedStyle-rotate.html)
-   [VisualElement.resolvedStyle.scale](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.IResolvedStyle-scale.html)
