---
title: "Optimizing your code for managed memory"
page_title: "Unity - Manual: Optimizing your code for managed memory"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/performance-optimizing-code-managed-memory.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/performance-optimizing-code-managed-memory.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Optimizing your code for managed memory

C#’s automatic memory management reduces the risk of memory leaks and other programming errors, in comparison to other programming languages like C++, where you must manually track and free all the memory you allocate.

Automatic memory management allows you to write code quickly and with few errors. However, this convenience might have performance implications. To optimize your code for performance, you must avoid situations where your application triggers the [garbage collector](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-garbage-collector.html) a lot. This section outlines some common issues and workflows that affect when your application triggers the garbage collector.

| **Topic**                                                                                                              | **Description**                                                                                                                                                                                         |
|:-----------------------------------------------------------------------------------------------------------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **[Reference type management](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-reference-types.html)** | Optimize how you use reference types in your code.                                                                                                                                                      |
| **[Pooling and reusing objects](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-reusable-code.html)** | Reduce CPU load and garbage collector overhead by using Unity’s `UnityEngine.Pool` APIs, which allow you to pool and reuse frequently-used objects rather than repeatedly creating and destroying them. |
| **[Optimizing arrays](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-optimizing-arrays.html)**       | Optimize when and how you use arrays in your code.                                                                                                                                                      |

## Additional resources

-   [Managed memory introduction](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-managed-memory-introduction.html)
-   [Garbage collector introduction](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-garbage-collector.html)
