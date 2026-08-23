---
title: "Optimize raycasts and other physics queries"
page_title: "Unity - Manual: Optimize raycasts and other physics queries"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-raycasts-queries.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-raycasts-queries.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Optimize raycasts and other physics queries

Optimize physics query performance and reduce garbage collection overhead by using efficient query versions and batch processing.

## Use non-allocating query versions

Standard physics queries, such as [`Physics.Raycast`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.Raycast.html), [`Physics.SphereCast`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.SphereCast.html), or [`Physics.OverlapSphere`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.OverlapSphere.html), allocate memory on the heap for their results. This allocation can contribute to garbage collection pauses, especially if they are called frequently.

Instead, use the non-allocating counterparts of these queries that write their results into a pre-allocated array that you provide. Non-allocating counterparts can include:

-   [`Physics.RaycastNonAlloc`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.RayCastNonAlloc.html)
-   [`Physics.SphereCastNonAlloc`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.SphereCastNonAlloc.html)
-   [`Physics.OverlapSphereNonAlloc`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.OverlapSphereNonAlloc.html)

For example:

``` csharp
int hitCount = Physics.RaycastNonAlloc(ray, preAllocatedHitsArray, distance, layerMask);
```

When you use non-allocating queries, you must provide a pre-allocated array. For example, `RaycastHit[] preAllocatedHitsArray = new RaycastHit[10];`.

Size this array appropriately: make it large enough to capture the maximum expected hits in typical scenarios, but not so large as to waste memory. If the number of actual colliders found exceeds the size of your buffer array, only the results up to the array’s capacity are returned, and the rest are ignored.

**Tip:** Choose a buffer size that balances typical needs with memory considerations. Profile your game to understand common hit counts.

## Use batch queries for multiple operations

Running many individual physics queries (for example, many raycasts per frame) can reduce performance because of the overhead of each call. If you need to perform many queries simultaneously, batch them using APIs like [`RaycastCommand`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RaycastCommand.html), [`SpherecastCommand`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SpherecastCommand.html), or [`BoxcastCommand`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BoxcastCommand.html) in conjunction with the [job system](https://docs.unity3d.com/6000.3/Documentation/Manual/job-system.html).

This approach leverages multi-threading to process queries in parallel, significantly improving performance for bulk query operations. This is particularly powerful when you have many independent raycasts (or other queries) that can be processed in parallel.

To use batch queries, follow these steps:

1.  Create and populate a `NativeArray<RaycastCommand>` with the parameters for all your raycasts.
2.  Allocate a `NativeArray<RaycastHit>` to store the results.
3.  Schedule the batch processing using `RaycastCommand.ScheduleBatch`, which returns a `JobHandle`.
4.  You can then perform other work, and later ensure the job is complete using `jobHandle.Complete` before you access the results. For example, ensure the job is complete at the start of the next frame or when needed.

## Additional resources

-   [Unity Profiler](https://docs.unity3d.com/6000.3/Documentation/Manual/Profiler.html)
-   [Managing time and frame rate](https://docs.unity3d.com/6000.3/Documentation/Manual/managing-time-and-frame-rate.html)
-   [Memory Profiler](https://docs.unity3d.com/Packages/com.unity.memoryprofiler@latest)
-   [Physics Project Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PhysicsManager.html)
-   [RaycastCommand](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RaycastCommand.html)
-   [Write multithreaded code with the job system](https://docs.unity3d.com/6000.3/Documentation/Manual/job-system.html)
-   [Collections package](https://docs.unity3d.com/Packages/com.unity.collections@latest?subfolder=/manual/index.html)
