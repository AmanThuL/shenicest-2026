---
title: "Introduction to runtime performance scaling"
page_title: "Unity - Manual: Introduction to runtime performance scaling"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/runtime-performance-scaling-introduction.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/runtime-performance-scaling-introduction.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to runtime performance scaling

Runtime performance scaling is the process of adjusting an application’s quality settings while it’s running. The goal is to maintain a stable frame rate and manage device resources like power and temperature by dynamically trading visual quality for performance.

## Systems for runtime performance scaling

In Unity, you can control quality settings at runtime with the following tools and APIs:

-   [Dynamic Resolution](https://docs.unity3d.com/6000.3/Documentation/Manual/DynamicResolution-landing.html): Adjusts rendering resolution automatically to maintain a target frame rate in URP and HDRP.
-   [QualitySettings](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/QualitySettings.html) API: Defines and changes between performance tiers with different settings for shadows, textures, and more.
-   [Level of Detail (LOD)](https://docs.unity3d.com/6000.3/Documentation/Manual/LevelOfDetail.html): Modifies the complexity of rendered models by changing the LOD bias, using simpler or more detailed meshes based on performance needs.
-   [Frame Timing Manager](https://docs.unity3d.com/6000.3/Documentation/Manual/frame-timing-manager.html): Provides low-level CPU and GPU timing data, enabling scripts to detect performance bottlenecks and respond as needed.

You can also use the [Adaptive Performance](https://docs.unity3d.com/6000.3/Documentation/Manual/adaptive-performance/adaptive-performance.html) system, which monitors device performance and automatically manages these foundational features and APIs to meet your performance targets. This system is especially useful on mobile devices, where hardware constraints can change rapidly.

## Additional resources

-   [Memory in Unity](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-memory.html)
-   [Unity Profiler](https://docs.unity3d.com/6000.3/Documentation/Manual/Profiler.html)
-   [Profiling tools](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-profiling-tools.html)
-   [Graphics performance and profiling](https://docs.unity3d.com/6000.3/Documentation/Manual/graphics-performance-profiling.html)
