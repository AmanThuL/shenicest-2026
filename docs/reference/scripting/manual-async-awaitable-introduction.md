---
title: "Introduction to asynchronous programming with Awaitable"
page_title: "Unity - Manual: Introduction to asynchronous programming with Awaitable"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/async-awaitable-introduction.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/async-awaitable-introduction.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to asynchronous programming with Awaitable

The [`Awaitable`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.html) class is a custom Unity type that can be awaited and used as an async return type in the C# asynchronous programming model. Most of Unity’s asynchronous APIs support the `async` and `await` pattern, including:

-   Unity coroutines: [`NextFrameAsync`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.NextFrameAsync.html), [`WaitForSecondsAsync`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.WaitForSecondsAsync.html), [`EndOfFrameAsync`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.EndOfFrameAsync.html), [`FixedUpdateAsync`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.FixedUpdateAsync.html)
-   Switching to [Background Thread](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.BackgroundThreadAsync.html) or [Main Thread](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.MainThreadAsync.html)
-   All types inheriting from [`AsyncOperation`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AsyncOperation.html)
-   [Unity Events](https://docs.unity3d.com/6000.3/Documentation/Manual/unity-events.html)
-   [Async GPU Readback](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.AsyncGPUReadback.html)

You can use the `Awaitable` class with both the `await` operator and as an `async` return type in your own code, as follows:

``` lang-cs
async Awaitable<List<Achievement>> GetAchievementsAsync()

async Awaitable ShowAchievementsView()

```

## Awaitable compared to .NET Task

`Awaitable` is designed to offer a more efficient alternative to .NET [`Task`](https://learn.microsoft.com/en-us/dotnet/api/system.threading.tasks.task?view=net-8.0) for asynchronous code in Unity projects. The efficiency of `Awaitable` comes with some important limitations compared to `Task`.

The most significant limitation is that `Awaitable` instances are pooled to limit allocations. Consider the following example:

``` lang-cs
class SomeMonoBehaviorWithAwaitable : MonoBehavior

    }
}
```

Without pooling, each instance of the [`MonoBehavior`](https://docs.unity3d.com/6000.3/Documentation/Manual/class-monobehaviour.html) in this example would allocate an `Awaitable` object each frame, increasing [garbage collector workload](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-garbage-collector.html) and degrading performance. To mitigate this, Unity returns the `Awaitable` object to the internal `Awaitable` pool once it’s been awaited.

**Important:** The pooling of `Awaitable` instances means it’s never safe to `await` more than once on an `Awaitable` instance. Doing so can result in undefined behavior such as an exception or a deadlock.

## Awaitable compared to .NET ValueTask

The .NET [`ValueTask<TResult>`](https://learn.microsoft.com/en-us/dotnet/api/system.threading.tasks.valuetask-1?view=net-8.0) offers some of the same key benefits and limitations of `Awaitable`. The typical recommended use for `ValueTask` is for asynchronous workloads that are expected to complete synchronously most of the time. For more information, refer to [Understanding the Whys, Whats, and Whens of ValueTask](https://devblogs.microsoft.com/dotnet/understanding-the-whys-whats-and-whens-of-valuetask/).

## Awaitable, Task, and ValueTask summary

The following table summarizes the feature comparison between Unity’s `Awaitable` class and .NET `Task` and `ValueTask`:

<table><thead><tr class="header"><th style="text-align: left;"><strong>Feature</strong></th><th style="text-align: left;"><code>Task</code></th><th style="text-align: left;"><code>ValueTask</code></th><th style="text-align: left;"><code>UnityEngine.Awaitable</code></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Required allocations</strong></td><td style="text-align: left;"><strong>Many</strong>.<br />
Allocates on every call to a <code>Task</code>-returning method, increasing memory use and garbage collector workload.</td><td style="text-align: left;"><strong>As-needed</strong>.<br />
Can be optimized with pooling.</td><td style="text-align: left;"><strong>Minimal as-needed</strong>.<br />
Calling an <code>Awaitable</code>-returning method usually doesn’t allocate memory, since <code>Awaitable</code> instances are pooled by default.</td></tr><tr class="even"><td style="text-align: left;"><strong>Safe to await multiple times</strong></td><td style="text-align: left;"><strong>Yes</strong>.</td><td style="text-align: left;"><strong>No</strong>.<br />
Must convert to a <code>Task</code> with <code>ValueTask.AsTask</code>.</td><td style="text-align: left;"><strong>No</strong>.<br />
Must convert to a <code>Task</code> with custom <code>AsTask</code> extension methods, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/async-awaitable-examples.html#await-multiple-times">Awaiting multiple times in the same method</a> in the code examples reference.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Continuations run asynchronously</strong></td><td style="text-align: left;"><strong>Yes</strong>.<br />
Using the synchronization context by default, otherwise using the <code>ThreadPool</code>. This increases latency when completing on the main thread in Unity because code must wait until the next frame <code>Update</code> to resume.</td><td style="text-align: left;"><strong>Yes</strong>.<br />
Optimized for the case where awaited tasks complete synchronously. If they complete asynchronously, the continuation behavior is equivalent to <code>Task</code>.</td><td style="text-align: left;"><strong>No</strong>.<br />
Continuation runs synchronously when completion is triggered, meaning code resumes immediately in the same frame in which completion is triggered. Refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/async-awaitable-continuations.html">Awaitable completion and continuation</a> for more information.</td></tr><tr class="even"><td style="text-align: left;"><strong>Completion can be triggered by code</strong></td><td style="text-align: left;"><strong>Yes</strong>.<br />
Using <a href="https://learn.microsoft.com/en-us/dotnet/api/system.threading.tasks.taskcompletionsource?view=net-8.0"><code>TaskCompletionSource</code></a>.</td><td style="text-align: left;">Not applicable in the typical use case, which is for tasks that mostly complete synchronously.</td><td style="text-align: left;"><strong>Yes</strong>.<br />
Using <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AwaitableCompletionSource.html"><code>AwaitableCompletionSource</code></a>.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Can return a value</strong></td><td style="text-align: left;"><strong>Yes</strong>.<br />
Using <a href="https://learn.microsoft.com/en-us/dotnet/api/system.threading.tasks.task-1?view=net-8.0"><code>Task&lt;TResult&gt;</code></a>.</td><td style="text-align: left;"><strong>Yes</strong>.<br />
Using <a href="https://learn.microsoft.com/en-us/dotnet/api/system.threading.tasks.valuetask-1?view=net-8.0"><code>ValueTask&lt;TResult&gt;</code></a>.</td><td style="text-align: left;"><strong>Yes</strong>.<br />
Using <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable_1.html"><code>UnityEngine.Awaitable&lt;T&gt;</code></a>.</td></tr><tr class="even"><td style="text-align: left;"><strong>Built-in support for <code>WaitAll</code> and <code>WaitAny</code></strong></td><td style="text-align: left;"><strong>Yes</strong>.</td><td style="text-align: left;"><strong>No</strong>.<br />
Must convert to <code>Task</code> with <code>ValueTask.AsTask</code>.</td><td style="text-align: left;"><strong>No</strong>.<br />
Must convert to a <code>Task</code> with custom <code>AsTask</code> extension methods, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/async-awaitable-examples.html#awaitable-as-task">Wrapping Awaitable in .NET Task</a> in the code examples reference.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Unity thread and update loop-aware execution scheduling</strong></td><td style="text-align: left;"><strong>No</strong>.</td><td style="text-align: left;"><strong>No</strong>.</td><td style="text-align: left;"><strong>Yes</strong>.<br />
You can specify which thread an <code>Awaitable</code> resumes on with <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.BackgroundThreadAsync.html"><code>Awaitable.BackgroundThreadAsync</code></a> and <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.MainThreadAsync.html"><code>Awaitable.MainThreadAsync</code></a>. You can also schedule work relative to the <code>Update</code> or <code>FixedUpdate</code> loops with <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.NextFrameAsync.html"><code>Awaitable.NextFrameAsync</code></a> and <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.FixedUpdateAsync.html"><code>Awaitable.FixedUpdateAsync</code></a>. For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/async-awaitable-continuations.html">Awaitable completion and continuation</a>.</td></tr></tbody></table>

## When to use Awaitable over Task or ValueTask

The choice of API depends on the performance profile of your asynchronous code, but in general:

-   `Task` is the only choice when you need to await multiple times or from several consumers concurrently.
-   `ValueTask` is a good choice if you have high-throughput asynchronous code that completes synchronously most of the time.
-   `Awaitable` is a good choice when:
    -   You don’t need to await your methods multiple times and expect them to mostly complete asynchronously.
    -   You want your asynchronous tasks to have built-in support for Unity-specific concepts like the main thread and the [Update](https://docs.unity3d.com/6000.3/Documentation/Manual/time-per-frame-updates.html) and [FixedUpdate](https://docs.unity3d.com/6000.3/Documentation/Manual/fixed-updates.html) loops.

## Awaitable compared to iterator-based coroutines

`Awaitable` coroutines are usually more efficient than iterator-based coroutines, especially for cases where the iterator returns non-null values, such as [`WaitForFixedUpdate`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/WaitForFixedUpdate.html).

However, the performance advantage of `Awaitable` coroutines reduces when you run many of them concurrently. For example, a MonoBehaviour such as the one in the previous code example, which awaits [`Awaitable.NextFrameAsync`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.NextFrameAsync.html) in a `while` loop, is likely to cause performance problems if attached to every GameObject in a large project.

**Note**: You can safely `yield return` an [`Awaitable`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.html) from a traditional iterator-based coroutine, but you can’t `yield return` an [`Awaitable<T0>`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable_1.html).

## Additional resources

-   [Awaitable completion and continuation](https://docs.unity3d.com/6000.3/Documentation/Manual/async-awaitable-continuations.html)
-   [Awaitable code example reference](https://docs.unity3d.com/6000.3/Documentation/Manual/async-awaitable-examples.html)
