---
title: "Code optimization"
page_title: "Unity - Manual: Code optimization"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-optimization.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-optimization.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Code optimization

Considering performance in all the code you write helps your project scale without bottlenecks. There are several ways you can improve performance, including avoiding bad practices, [profiling](https://docs.unity3d.com/6000.3/Documentation/Manual/Profiler.html) your code, implementing appropriate design patterns, and using techniques like asynchronous programming to split work across multiple threads of execution.

| **Topic**                                                                                                                                       | **Description**                                                                                                                                                                                                                               |
|:------------------------------------------------------------------------------------------------------------------------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Unity programming best practices](https://docs.unity3d.com/6000.3/Documentation/Manual/programming-best-practices.html)                        | Key issues to be aware of when writing code for Unity applications, along with best practices to help you avoid common pitfalls.                                                                                                              |
| [Asynchronous programming](https://docs.unity3d.com/6000.3/Documentation/Manual/async-await-support.html)                                       | Asynchronous programming in Unity with the .NET `async` and `await` keywords and Unity’s own custom `Awaitable` class.                                                                                                                        |
| [Job system](https://docs.unity3d.com/6000.3/Documentation/Manual/job-system.html)                                                              | Use Unity’s own `Job` system to get the most out of multi-core CPUs and parallelize your algorithms.                                                                                                                                          |
| [Optimizing your code for managed memory](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-optimizing-code-managed-memory.html) | Approaches for optimizing your code to work with managed memory.                                                                                                                                                                              |
| [Using unmanaged API for transform operations](https://docs.unity3d.com/6000.3/Documentation/Manual/transformhandle-landing.html)               | Use the [`TransformHandle`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/TransformHandle.html) API as an alternative to the [`Transform`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) API. |

## Additional resources

-   [Optimization in Unity](https://docs.unity3d.com/6000.3/Documentation/Manual/analysis.html)
