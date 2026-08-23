---
title: "Performance consideration for runtime UI (UI Toolkit)"
page_title: "Unity - Manual: Performance consideration for runtime UI"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-performance-consideration-runtime.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-performance-consideration-runtime.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Performance consideration for runtime UI

This section describes how you can improve the performance for runtime UI.

| **Topic**                                                                                                                                                                                      | **Description**                                                                                                              |
|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------------------------------------------------|
| [Use usage hints to reduce draw calls and geometry regeneration](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-use-usage-hints-to-reduce-draw-calls-and-geometry-regeneration.html) | Use usage hints to set how an element is used at runtime. Usage hints can reduce draw calls and avoid geometry regeneration. |
| [Control textures of the dynamic atlas](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-control-textures-of-the-dynamic-atlas.html)                                                   | Use an atlas to reduce the number of batches broken by texture changes and achieve good performance.                         |
| [Platform and mesh consideration](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-platform-and-mesh.html)                                                                             | Consider device capabilities and avoid mesh tessellation.                                                                    |

## Additional resources

-   [Panel Settings asset](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Runtime-Panel-Settings.html)
-   [`usageHints`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.VisualElement-usageHints.html)
