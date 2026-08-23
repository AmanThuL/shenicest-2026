---
title: "Unity 6.3 Manual: Code and scene reload on entering Play mode"
page_title: "Unity - Manual: Code and scene reload on entering Play mode"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/code-reloading-editor.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/code-reloading-editor.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Code and scene reload on entering Play mode

Authoring your application in Edit mode and then switching to Play mode to preview its runtime behavior is a core feature of iterative development in the Unity Editor. By default the Editor reloads both your code and scene assets as part of the transition from Edit mode to Play mode. It’s important to understand what Unity reloads, why and when it does so, and how you can configure the reloading behavior. This helps you make informed trade-offs between development iteration time and the degree to which Play mode accurately reflects your built application’s performance.

| **Topic**                                                                                                                                      | **Description**                                                                                                                                     |
|:-----------------------------------------------------------------------------------------------------------------------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------|
| [Configuring how Unity enters Play mode](https://docs.unity3d.com/6000.3/Documentation/Manual/configurable-enter-play-mode.html)               | Configure the Unity Editor to enter Play mode more quickly and improve your development iteration times.                                            |
| [Enter Play mode with domain reload disabled](https://docs.unity3d.com/6000.3/Documentation/Manual/domain-reloading.html)                      | Understand how disabling domain reload on enter Play mode affects your application state and how you can compensate for these effects in your code. |
| [Enter Play mode with scene reload disabled](https://docs.unity3d.com/6000.3/Documentation/Manual/scene-reloading.html)                        | Understand how disabling scene reload on enter Play mode affects your application and how you can compensate for these effects in your code.        |
| [Details of disabling domain and scene reload](https://docs.unity3d.com/6000.3/Documentation/Manual/configurable-enter-play-mode-details.html) | Understand the work Unity performs during domain and scene reload and what’s skipped when they’re disabled.                                         |

## Additional resources

-   [Script compilation](https://docs.unity3d.com/6000.3/Documentation/Manual/script-compilation.html)
-   [Scripting back ends](https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-backends.html)
