---
title: "Excluding hidden objects with occlusion culling"
page_title: "Unity - Manual: Excluding hidden objects with occlusion culling"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/OcclusionCulling-landing.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/OcclusionCulling-landing.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Excluding hidden objects with occlusion culling

Resources about preventing Unity doing rendering calculations for hidden GameObjects.

**Note:** If your project uses the Universal Render Pipeline (URP) or the High Definition Render Pipeline (HDRP), you can instead [Enable GPU occlusion culling in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/gpu-culling.html) or [Enable GPU occlusion culling in HDRP](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.4/manual/gpu-culling.html).

| **Page**                                                                                                                                  | **Description**                                                                                     |
|:------------------------------------------------------------------------------------------------------------------------------------------|:----------------------------------------------------------------------------------------------------|
| [Occlusion culling](https://docs.unity3d.com/6000.3/Documentation/Manual/OcclusionCulling.html)                                           | Understand how occlusion culling checks for hidden objects, and when to use it.                     |
| [Set up a scene for occlusion culling](https://docs.unity3d.com/6000.3/Documentation/Manual/occlusion-culling-getting-started.html)       | Set up a scene for occlusion culling, bake occlusion culling data, and check the results.           |
| [Set up multiple scenes for occlusion culling](https://docs.unity3d.com/6000.3/Documentation/Manual/occlusion-culling-scene-loading.html) | Prepare occlusion culling data differently if you load multiple scenes at a time.                   |
| [Cull moving GameObjects](https://docs.unity3d.com/6000.3/Documentation/Manual/occlusion-culling-dynamic-gameobjects.html)                | Enable or disable Dynamic Occlusion.                                                                |
| [Create high-precision occlusion areas](https://docs.unity3d.com/6000.3/Documentation/Manual/class-OcclusionArea.html)                    | Use the Occlusion Area component to define an area where Unity calculates culling more precisely.   |
| [Control occlusion in areas with Occlusion Portals](https://docs.unity3d.com/6000.3/Documentation/Manual/class-OcclusionPortal.html)      | Turn occlusion on and off through an object, for example a door that opens and closes.              |
| [Occlusion Culling window reference](https://docs.unity3d.com/6000.3/Documentation/Manual/occlusion-culling-window.html)                  | Explore the properties and settings in the Occlusion Culling window to customize how culling works. |
| [Configure culling with the CullingGroup API](https://docs.unity3d.com/6000.3/Documentation/Manual/CullingGroupAPI-landing.html)          | Integrate your own systems into Unity’s culling and level of detail (LOD) pipelines.                |
| [Troubleshooting occlusion culling](https://docs.unity3d.com/6000.3/Documentation/Manual/occlusion-culling-troubleshooting.html)          | Solve common problems when using occlusion culling.                                                 |

## Additional resources

-   [Graphics performance and profiling](https://docs.unity3d.com/6000.3/Documentation/Manual/graphics-performance-profiling.html)
-   [Enable GPU occlusion culling in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/gpu-culling.html)
