---
title: "Optimizing draw calls in URP"
page_title: "Unity - Manual: Optimizing draw calls in URP"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/reduce-draw-calls-landing-urp.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/reduce-draw-calls-landing-urp.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Optimizing draw calls in URP

Techniques for speeding up rendering by reducing the number of drawing commands the CPU sends to the GPU, in the Universal Render Pipeline (URP).

For more information about techniques for optimizing draw calls, refer to [choose a method for optimizing draw calls](https://docs.unity3d.com/6000.3/Documentation/Manual/optimizing-draw-calls-choose-method.html).

| **Page**                                                                                                           | **Description**                                                                                                                   |
|:-------------------------------------------------------------------------------------------------------------------|:----------------------------------------------------------------------------------------------------------------------------------|
| [Scriptable Render Pipeline Batcher](https://docs.unity3d.com/6000.3/Documentation/Manual/SRPBatcher-landing.html) | Resources for using the Scriptable Render Pipeline (SRP) Batcher to reduce the number of render state changes between draw calls. |
| [GPU Resident Drawer](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/reduce-rendering-work-on-cpu.html)  | Automatically use the `BatchRendererGroup` API to use instancing and reduce the number of draw calls.                             |
| [BatchRendererGroup API](https://docs.unity3d.com/6000.3/Documentation/Manual/batch-renderer-group.html)           | Resources for using the `BatchRendererGroup` API to reduce the number of batches in the SRP Batcher.                              |

## Additional resources

-   [Reduce rendering work on the CPU](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/reduce-rendering-work-on-cpu.html)
-   [Optimize rendering lots of objects](https://docs.unity3d.com/6000.3/Documentation/Manual/reduce-draw-calls-landing.html)
-   [Graphics rendering: Getting the best performance with Unity 6](https://www.youtube.com/watch?v=Oc6T4hh5gaI)
-   [Performance tips and tricks from a Unity consultant](https://www.youtube.com/watch?v=CmD8MVGkDxQ)
