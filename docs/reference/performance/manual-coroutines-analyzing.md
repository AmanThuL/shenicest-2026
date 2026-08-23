---
title: "Analyzing coroutines"
page_title: "Unity - Manual: Analyzing coroutines"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/coroutines-analyzing.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/coroutines-analyzing.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Analyzing coroutines

Coroutines execute differently from other script code. Most script code in Unity appears within a performance trace in a single location, beneath a specific callback invocation. However, the CPU code of coroutines always appears in two places in a trace:

-   All the initial code in a coroutine, from the start of the coroutine method until the first `yield` statement, appears in the trace whenever Unity starts a coroutine. The initial code most often appears whenever the [`StartCoroutine`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.StartCoroutine.html) method is called. Coroutines that Unity callbacks generate (such as `Start` callbacks that return an `IEnumerator`) first appear within their respective Unity callback.

-   The rest of a coroutine’s code (from the first time it resumes until it finishes executing) appears within the `DelayedCallManager` line inside Unity’s main loop. This is because of the way that Unity executes coroutines. The [C# compiler](https://docs.unity3d.com/6000.3/Documentation/Manual/overview-of-dot-net-in-unity.html) auto-generates an instance of a class that backs coroutines. Unity then uses this object to track the state of the coroutine across multiple invocations of a single method. Because local-scope variables within the coroutine must persist across `yield` calls, Unity elevates the scope of local variables into the generated class, which remain allocated on the heap during the coroutine. This object also tracks the internal state of the coroutine: it remembers at which point in the code the coroutine must resume after yielding.

For these reasons, the memory allocated when a coroutine starts is equal to a fixed overhead allocation plus the size of its local-scope variables.

The code that starts a coroutine constructs and invokes an object, and then Unity’s `DelayedCallManager` invokes it again whenever the coroutine’s `yield` condition is satisfied. Because coroutines usually start outside of other coroutines, this splits their execution overhead between the `yield` call and `DelayedCallManager`.

## Monitor and improve coroutine performance

You can use the Unity Profiler to inspect and understand where Unity executes coroutines in your application. To do this, profile your application with [Deep Profiling](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-deep-profiling.html) enabled, which profiles every part of your script code and records all function calls. You can then use the [CPU Usage Profiler module](https://docs.unity3d.com/6000.3/Documentation/Manual/ProfilerCPU.html) to investigate the coroutines in your application.

![Profiler session with a coroutine in a DelayedCall](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/coroutines-cpu-profiler.png)

It’s best practice to condense a series of operations down to the fewest number of individual coroutines possible. Nested coroutines are useful for code clarity and maintenance, but they impose a higher memory overhead because the coroutine tracks objects.

If a coroutine runs every frame and doesn’t `yield` on long-running operations, it’s more performant to replace it with an `Update` or `LateUpdate` callback. This is useful if you have long-running or infinitely looping coroutines.

## Additional resources

-   [Coroutine API reference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Coroutine.html)
-   [Unity Profiler](https://docs.unity3d.com/6000.3/Documentation/Manual/Profiler.html)
