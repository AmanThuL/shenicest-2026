---
title: "Optimize transform value syncing"
page_title: "Unity - Manual: Optimize transform value syncing"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu-transform-sync.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu-transform-sync.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Optimize transform value syncing

Optimize the synchronization of Transform values with the physics system to improve performance and query accuracy.

By default, Unity defers physics transform syncing. If you change a **Transform** value and then immediately query the physics world, the physics system might not become aware of the change unless it’s explicitly communicated. You can control this behavior by enabling or disabling **Auto Sync Transforms**.

The recommended best practice is to disable **Auto Sync Transforms**, which is disabled by default. If you modify a Rigidbody or a Collider component’s transform values directly and then immediately need to perform a physics query that depends on that object’s new position in the same frame, manually call [`Physics.SyncTransforms`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.SyncTransforms.html) before the query. This ensures the physics world is up-to-date with the transform values changes for accurate query results. **Note**: `Physics.SyncTransforms` is crucial for accurate queries when **Auto Sync Transforms** is disabled, especially if `Physics.simulationMode` is set to `Script`, and you’re querying as detailed in [Optimizing physics for query-only or non-simulating games](https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu-query-only.html).

To enable or disable **Auto Sync Transforms** in the Editor:

1.  Select **Edit > Project Settings** to open the Project Settings window.
2.  Select the **Physics > Settings** tab.
3.  Select the **GameObject** tab.
4.  Enable or disable **Auto Sync Transforms**. By default, **Auto Sync Transforms** is not enabled. If you enable it, you add implicit synchronization points before every physics query, which can negatively affect performance.

To enable or disable **Auto Sync Transforms** in script, set [`Physics.autoSyncTransforms`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics-autoSyncTransforms.html) to `true` or `false`. Setting `Physics.autoSyncTransforms = true;` has the same effect as enabling **Auto Sync Transforms** in the Project Settings.

## Additional resources

-   [Unity Profiler](https://docs.unity3d.com/6000.3/Documentation/Manual/Profiler.html)
-   [Managing time and frame rate](https://docs.unity3d.com/6000.3/Documentation/Manual/managing-time-and-frame-rate.html)
-   [Memory Profiler](https://docs.unity3d.com/Packages/com.unity.memoryprofiler@latest)
-   [Physics Project Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PhysicsManager.html)
-   [Optimize physics for query-only or non-simulating games](https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu-query-only.html)
