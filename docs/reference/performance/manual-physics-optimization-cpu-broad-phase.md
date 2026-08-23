---
title: "Select a broad phase pruning algorithm"
page_title: "Unity - Manual: Select a broad phase pruning algorithm"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu-broad-phase.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu-broad-phase.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Select a broad phase pruning algorithm

Select the most efficient broad phase pruning algorithm.

In the Unity Editor, you can select these algorithms for broad phase collision detection:

-   Sweep and Prune (SAP): Projects Axis-Aligned Bounding Boxes (AABBs) onto axes. While generally efficient, SAP can generate false positives in large, flat worlds with many colliders. In these scenarios, it can identify pairs of objects for narrow phase collision checking that aren’t actually close and projections can overlap even if the objects are distant.
-   Multibox Pruning: This algorithm uses a grid, and each grid cell performs sweep-and-prune. This usually helps improve performance if, for example, there are many GameObjects in a flat world.
-   Automatic Box Pruning: Divides the world into a grid and automatically configures the boundaries and cell sizes of the world based on your scene’s content. This can significantly reduce the number of pairs that need narrow phase checks in suitable environments. This algorithm is similar to Multibox Pruning, except that it can also automatically compute the world boundaries and number of subdivisions

SAP is the default broad phase algorithm for 3D physics. If you want to select the Automatic Box Pruning algorithm, there are several associated drawbacks you must consider:

-   Overhead in highly dynamic scenes: If your scene contains many objects that are all constantly and rapidly moving across grid cell boundaries, the overhead of updating their positions within the grid might negate or even outweigh the pruning benefits. In highly dynamic scenarios, the Sweep and Prune broad phase might be more efficient.
-   Automatic grid configuration: The automatically determined grid might not be optimal for every conceivable scene layout. While it aims for a good general-purpose configuration, specific or unusual world structures might not have as high performance benefits.
-   Initial setup and reconfiguration: There’s an initial performance cost to build the grid. If your world’s physical bounds change drastically at runtime, the system might need to reconfigure the grid, potentially causing a temporary performance spike.
-   Memory usage: The grid structure consumes some memory, though typically not a major concern.

Automatic Box Pruning generally performs well in large, open worlds, or scenes with many static or infrequently moving colliders. For smaller, dense scenes or scenes with extreme numbers of rapidly moving objects, **Sweep and Prune** might be a better choice. Always profile your specific scenes using the [**Unity Profiler**](https://docs.unity3d.com/6000.3/Documentation/Manual/Profiler.html), and focus on physics broad phase processing time, to determine which broad phase type yields the best performance for your game.

To change the broad phase type:

1.  Select **Edit > Project Settings** to open the Project Settings window.
2.  Select the **Physics > Settings** tab.
3.  Select the **GameObject** tab.
4.  In **Broad phase Type**, select a broad phase type algorithm.

## Additional resources

-   [Unity Profiler](https://docs.unity3d.com/6000.3/Documentation/Manual/Profiler.html)
-   [Managing time and frame rate](https://docs.unity3d.com/6000.3/Documentation/Manual/managing-time-and-frame-rate.html)
-   [Memory Profiler](https://docs.unity3d.com/Packages/com.unity.memoryprofiler@latest)
-   [Physics Project Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PhysicsManager.html)
-   [Collision detection](https://docs.unity3d.com/6000.3/Documentation/Manual/collision-detection.html)
