---
title: "Optimize physics performance (landing)"
page_title: "Unity - Manual: Optimize physics performance"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Optimize physics performance

Optimize physics system performance in the Unity Editor.

Use the guidance in these pages to optimize the physics system so you can maintain your target frame rate and ensure smooth, responsive gameplay. The instructions in these pages address issues identified by Unity Editor diagnostic tools. Before you apply the optimizations described in the documentation in this section and throughout your development, you must be familiar with these diagnostic tools:

-   [**The Unity Profiler**](https://docs.unity3d.com/6000.3/Documentation/Manual/Profiler.html): The Profiler is the primary tool to measure CPU performance. The Profiler helps identify bottlenecks in your project, particularly in areas such as `Physics.FixedUpdate` and `Physics.Simulate`, and in its detailed breakdowns of physics phases such as broad phase and narrow phase processing. To open the Profiler window, go to **Window > Analysis > Profiler**.
-   [**The Memory Profiler**](https://docs.unity3d.com/Packages/com.unity.memoryprofiler@latest): Use the Memory Profiler to identify and optimize memory allocations caused by physics operations, such as excessive `RaycastHit` arrays or frequent collision data creation. You can use this information to reduce your garbage collection overhead.
-   [**The Physics Debug**](https://docs.unity3d.com/6000.3/Documentation/Manual/PhysicsDebugVisualization.html) window: Use this tool to visually diagnose physics-related performance issues. It displays collision shapes, contacts, broad phase bounding boxes, and Rigidbody component sleep states. This helps you identify areas like overly complex colliders, unnecessary interactions, or objects failing to sleep, all of which contribute to performance bottlenecks. To open the Physics Debug window, select **Window > Analysis > Physics Debug**.

| **Topic**                                                                                                                                 | **Description**                                                                                                                          |
|:------------------------------------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------------------------------------------------------------|
| **[Optimize the physics system for CPU usage](https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu.html)**       | Optimize Unity’s physics system’s CPU usage by adjusting simulation frequency, managing colliders, and configuring Rigidbody components. |
| **[Optimize the physics system for memory usage](https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-memory.html)** | Optimize Unity’s physics system’s memory usage by controlling collision callbacks and optimizing physics queries.                        |
| **[Understand physics performance issues](https://docs.unity3d.com/6000.3/Documentation/Manual/physics-performance-issues.html)**         | Understand performance issues related to physics in your application.                                                                    |

## Additional resources

-   [Unity Profiler](https://docs.unity3d.com/6000.3/Documentation/Manual/Profiler.html)
-   [Built-in 3D Physics](https://docs.unity3d.com/6000.3/Documentation/Manual/PhysicsOverview.html)
-   [Memory Profiler](https://docs.unity3d.com/Packages/com.unity.memoryprofiler@latest)
-   [Physics Project Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PhysicsManager.html)
