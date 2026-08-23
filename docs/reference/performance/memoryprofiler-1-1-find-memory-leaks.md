---
title: "Find memory leaks"
page_title: "Find memory leaks | Memory Profiler | 1.1.11"
source_url: "https://docs.unity3d.com/Packages/com.unity.memoryprofiler@1.1/manual/find-memory-leaks.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.memoryprofiler@1.1/manual/find-memory-leaks.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Find memory leaks

Memory leaks cause your application to perform worse over time and might lead to a crash.

Memory leaks typically happen for one of the following reasons:

-   Missing code to release objects from memory.
-   Unintentional references keeping objects in memory.

To identify memory leaks, capture and compare multiple snapshots. Refer to [Compare two snapshots](https://docs.unity3d.com/Packages/com.unity.memoryprofiler@1.1/manual/snapshots-comparison.html) for more information.

## Detect memory leaks after scene unload

Leaks often result from user-allocated objects or resources not released after a scene unload.

To identify this type of leak perform the following steps:

1.  Open **Window** > **Analysis** > **Memory Profiler**.
2.  Use the [Attach to Player](https://docs.unity3d.com/Packages/com.unity.memoryprofiler@1.1/manual/memory-profiler-window-reference.html#memory-profiler-toolbar) dropdown to set the source as a running Player.
3.  Load an empty <a href="https://docs.unity3d.com/Manual/CreatingScenes.html" class="xref">scene</a> and [create a snapshot](https://docs.unity3d.com/Packages/com.unity.memoryprofiler@1.1/manual/snapshot-capture.html) of it.
4.  Load the test scene, play partway through, then unload it or change to an empty scene. To fully unload assets, call <a href="https://docs.unity3d.com/ScriptReference/Resources.UnloadUnusedAssets.html" class="xref"><code>Resources.UnloadUnusedAssets</code></a> or load two new scenes consecutively.
5.  Take another snapshot and optionally close the Player.
6.  [Compare snapshots](https://docs.unity3d.com/Packages/com.unity.memoryprofiler@1.1/manual/snapshots-comparison.html) and use any of the [Memory Profiler tabs](https://docs.unity3d.com/Packages/com.unity.memoryprofiler@1.1/manual/memory-profiler-window-reference.html) to inspect the snapshots.

Increased memory usage in the second snapshot might indicate a memory leak.

## Additional resources

-   [Compare two snapshots](https://docs.unity3d.com/Packages/com.unity.memoryprofiler@1.1/manual/snapshots-comparison.html)
-   [Memory Profiler window reference](https://docs.unity3d.com/Packages/com.unity.memoryprofiler@1.1/manual/memory-profiler-window-reference.html)
-   [Analyzing Unity object memory leaks](https://docs.unity3d.com/Packages/com.unity.memoryprofiler@1.1/manual/managed-shell-objects.html)
