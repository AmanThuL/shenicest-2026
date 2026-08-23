---
title: "Garbage collector overview"
page_title: "Unity - Manual: Garbage collector overview"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/performance-garbage-collector.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/performance-garbage-collector.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Garbage collector overview

Unity uses a [garbage collector](https://docs.microsoft.com/en-us/dotnet/standard/garbage-collection/fundamentals) to reclaim memory from objects that your application and Unity are no longer using. When a script tries to make an allocation on the managed heap but there isn’t enough free heap memory to accommodate the allocation, Unity runs the garbage collector.

When the garbage collector runs, it examines all objects in [the managed heap](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-managed-memory-introduction.html), and marks for deletion any objects that your application no longer references. Unity then deletes the unreferenced objects, which frees up memory. Ideally the freed memory can then accommodate the new allocation, and if it can’t, the heap grows and Unity allocates additional memory blocks for it.

## When the garbage collector reallocates memory

The garbage collector handles subsequent requests in the same way until there’s no free area large enough to allocate the required block size. In this situation, it’s unlikely that all allocated memory is still in use. Unity’s scripting backends can only access a reference item on the heap as long as there are still reference variables that can locate it.

To determine which heap blocks are no longer in use, the garbage collector searches through all active reference variables and marks the blocks of memory that they refer to as live. At the end of the search, the garbage collector considers any space between the live blocks empty and marks them for use for subsequent allocations. The process of locating and freeing up unused memory is called **garbage collection** (GC).

**Note:** The garbage collector works differently on the Web platform. For more information, refer to [Memory in web garbage collection considerations](https://docs.unity3d.com/6000.3/Documentation/Manual/webgl-memory.html#garbagecollection).

## Temporary allocations

It’s common for an application to allocate temporary data to the [managed heap](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-managed-memory-introduction.html) in each frame but temporary allocations can affect the performance of the application.

For example, if a program allocates 1 KB of temporary memory each frame, and it runs at 60 frames per second, then it must allocate 60 KB of temporary memory per second. Over the course of a minute, this adds up to 3.6 MB of memory available to the garbage collector.

Invoking the garbage collector once per second has a negative effect on performance. If it has to clean up 3.6 MB spread across thousands of individual allocations, that might result in significant garbage collection times.

Loading operations have an impact on performance. If your application generates a lot of temporary objects during a heavy asset-loading operation, and Unity references those objects until the operation completes, then the garbage collector can’t release those temporary objects. This means that the managed heap needs to expand, even though Unity releases a lot of the objects that it contains a short time later.

To avoid managed heap expansion, reduce the amount of frequent managed heap allocations as possible: ideally to 0 bytes per frame, or as close to zero as you can get. For information on how to optimize for managed heap allocations, refer to [Optimizing your code for managed memory](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-optimizing-code-managed-memory.html).

## Additional resources

-   [Garbage collection modes](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-incremental-garbage-collection.html)
-   [Configuring garbage collection](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-disabling-garbage-collection.html)
-   [Optimizing your code for managed memory](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-optimizing-code-managed-memory.html)
