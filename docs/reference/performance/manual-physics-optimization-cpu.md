---
title: "Optimize the physics system for CPU usage"
page_title: "Unity - Manual: Optimize the physics system for CPU usage"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Optimize the physics system for CPU usage

You can optimize how the Unity physics system uses CPU resources in several ways. For example, you can adjust simulation frequency, carefully manage collider types, configure Rigidbody component behaviors, and more. Effective CPU optimization helps ensure your game maintains a high frame rate and responsive physics interactions.

Use the guidance in these pages to maintain your target frame rate and ensure smooth, responsive gameplay. The instructions in these pages address issues identified by Unity Editor diagnostic tools. Before you apply these optimizations described in the documentation in this section and throughout your development, you must be familiar with these diagnostic tools:

-   [**The Unity Profiler**](https://docs.unity3d.com/6000.3/Documentation/Manual/Profiler.html)
-   [**The Memory Profiler**](https://docs.unity3d.com/Packages/com.unity.memoryprofiler@latest)
-   [**The Physics Debug window**](https://docs.unity3d.com/6000.3/Documentation/Manual/PhysicsDebugVisualization.html)

| **Topic**                                                                                                                                                                         | **Description**                                                                                                      |
|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------|
| **[Set fixed timestep to optimize physics simulation frequency](https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu-frequency.html)**                   | Configure the fixed time step and manage potential performance spirals to control physics update frequency.          |
| **[Manually set physics simulation](https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu-manual-simulation.html)**                                       | Control over when physics calculations occur to align them with game performance.                                    |
| **[Optimize physics for query-only or non-simulating games](https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu-query-only.html)**                      | Prevent the default physics update loop from running to reduce unnecessary performance overhead.                     |
| **[Optimize transform value syncing](https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu-transform-sync.html)**                                         | Optimize the synchronization of Transform values with the physics system to improve performance and query accuracy.  |
| **[Move static colliders](https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu-static-colliders.html)**                                                  | Understand best practices for moving static colliders and when to use Kinematic **Rigidbody** components instead.    |
| **[Use the layer collision matrix to reduce overlaps](https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu-collision-layers.html)**                      | Reduce collision calculation overhead by configuring interaction rules between GameObjects with collision layers.    |
| **[Select a broad phase pruning algorithm](https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu-broad-phase.html)**                                      | Optimize physics performance in large scenes by selecting the most efficient broad phase pruning algorithm.          |
| **[Collider types and performance](https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu-collider-types.html)**                                           | Select the most efficient collider types for different GameObjects.                                                  |
| **[Configure Mesh Collider component cooking options for optimization](https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu-mesh-cooking-options.html)** | Optimize physics calculations by configuring cooking options for **Mesh Collider** components                        |
| **[Use Rigidbody sleeping to improve physics performance](https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu-rigidbody-sleeping.html)**                | Reduce CPU load and improve physics performance by enabling **Rigidbody** sleeping for stationary objects.           |
| **[Adjust Rigidbody component solver iterations](https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu-rigidbody-solver.html)**                           | Adjust solver iteration counts for a **Rigidbody** component to improve simulation accuracy.                         |
| **[Optimize Rigidbody component collision detection modes](https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu-rigidbody-collision-modes.html)**        | Balance collision accuracy and CPU performance by choosing appropriate detection modes for **Rigidbody** components. |

## Additional resources

-   [Unity Profiler](https://docs.unity3d.com/6000.3/Documentation/Manual/Profiler.html)
-   [Built-in 3D Physics](https://docs.unity3d.com/6000.3/Documentation/Manual/PhysicsOverview.html)
-   [Memory Profiler](https://docs.unity3d.com/Packages/com.unity.memoryprofiler@latest)
-   [Physics Project Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PhysicsManager.html)
