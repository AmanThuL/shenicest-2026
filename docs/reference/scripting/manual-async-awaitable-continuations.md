---
title: "Awaitable completion and continuation"
page_title: "Unity - Manual: Awaitable completion and continuation"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/async-awaitable-continuations.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/async-awaitable-continuations.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Awaitable completion and continuation

The `await` operator suspends execution of the enclosing async method, which allows the calling thread to perform other work while waiting. When the awaited `Task` or `Awaitable` completes, the asynchronous code needs to resume and continue its execution from the point it was suspended. How asynchronous code resumes can have important effects on the function and performance of your application.

## .NET Task continuations

Information about the state code was in when it began awaiting is referred to as the synchronization context. The .NET platform provides the [`SynchronizationContext`](https://learn.microsoft.com/en-us/dotnet/api/system.threading.synchronizationcontext?view=net-8.0) class for capturing this type of information. `Task` continuations run in the synchronization context from which the asynchronous method was called, or through the [thread pool](https://learn.microsoft.com/en-us/dotnet/api/system.threading.threadpool?view=net-8.0) if no synchronization context was set.

Most Unity APIs aren’t thread-safe and can only be called from the main thread. For this reason, Unity overwrites the default [`SynchronizationContext`](https://docs.microsoft.com/en-us/archive/msdn-magazine/2011/february/msdn-magazine-parallel-computing-it-s-all-about-the-synchronizationcontext) with a custom [`UnitySynchronizationContext`](https://github.com/Unity-Technologies/UnityCsReference/blob/master/Runtime/Export/Scripting/UnitySynchronizationContext.cs) to ensure all .NET `Task` continuations in both Edit mode and Play mode run on the main thread by default. If you call a `Task`-returning method from the Unity main thread, the continuation is posted to the `UnitySynchronizationContext` and runs on the next frame `Update` tick on the main thread. If you call it from a background thread, it completes on a thread pool thread.

Capturing a synchronization context increases the performance overhead of your application and waiting for the next frame Update to resume on the main thread introduces latency at scale. You can avoid both these issues by using `Awaitable` instead.

## Awaitable continuations

Unless documented otherwise, all `Awaitable` instances returned by Unity APIs, as well as any user defined `async Awaitable` returning methods, have the following continuation scheduling behaviour:

-   If the method is called from the main thread, it resumes on the main thread.
-   Otherwise it resumes on a .NET `ThreadPool` thread.

The notable exceptions to that are:

-   `Awaitable.MainThreadAsync`: continuation happens on the main thread.
-   `Awaitable.BackgroundThreadAsync`: continuation happens on a background thread.

The effect of `Awaitable.MainThreadAsync` and `Awaitable.BackgroundThreadAsync` are local to the current method only, for example:

``` lang-cs
private async Awaitable<float> DoHeavyComputationInBackgroundAsync()

public async Awaitable Start()

```

**Note:** Unity doesn’t automatically stop code running in the background when you exit Play mode. To cancel a background operation on exiting Play mode, use [`Application.exitCancellationToken`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-exitCancellationToken.html).

## Thread switching and performance

It’s most efficient to call `await Awaitable.MainThreadAsync()` from the main thread and `await Awaitable.BackgroundThreadAsync()` from a background thread because in each case the code resumes immediately on completion. If you switch back to the main thread from a background thread with `MainThreadAsync`, your code can’t resume until the next [frame update](https://docs.unity3d.com/6000.3/Documentation/Manual/time-per-frame-updates.html) on the main thread.

If you call a `Task`-returning API from the main thread and it doesn’t complete synchronously, you’ll need to wait at least for the next `Update` tick (33ms at 30fps) for the continuation to run. If network latency is a concern, it’s recommended to do this off the main thread and use custom logic to synchronize between the main thread and networking tasks.

In development builds, Unity displays the following error message if you try to use Unity APIs in multithreaded code:

    UnityException: Internal_CreateGameObject can only be called from the main thread.

    Constructors and field initializers will be executed from the loading thread when loading a scene.

    Don't use this function in the constructor or field initializers, instead move initialization code to the Awake or Start function.

**Important**: For performance reasons, Unity doesn’t check for multithreaded behavior in [non-development builds](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles-reference.html) and doesn’t display this error in live builds. While Unity doesn’t prevent execution of multithreaded code in these contexts, crashes and other unpredictable errors are likely if you do use multiple threads. Instead of using your own multithreading, it’s safer to use Unity’s [job system](https://docs.unity3d.com/6000.3/Documentation/Manual/job-system.html). The job system uses multiple threads safely to execute jobs in parallel and achieve the performance benefits of multithreading. For more information, refer to [Job system overview](https://docs.unity3d.com/6000.3/Documentation/Manual/job-system-overview.html).

### Awaitable compared to the job system

Unity’s `Awaitable` class is better suited to the following scenarios than the job system:

-   Simplifying code when dealing with inherently asynchronous operations, such as manipulating files or performing web requests, in a non-blocking way.
-   Offloading long-running tasks (>1 frame) to a background thread.
-   Modernizing iterator-based coroutines.
-   Awaiting multiple kinds of asynchronous operations (frame events, Unity events, third party asynchronous APIs, I/O).

However, it’s not recommended for shorter-lived operations such as parallelizing computationally-intensive algorithms. To get the most of multi-core CPUs and parallelize your algorithms, use the [job system](https://docs.unity3d.com/6000.3/Documentation/Manual/job-system.html) instead.

## Triggering completion from code

[`AwaitableCompletionSource`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AwaitableCompletionSource.html) and [`AwaitableCompletionSource<T>`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AwaitableCompletionSource_1.html) allow creation of `Awaitable` instances where completion is raised from user code. For example, this can be used to implement user prompts without having to implement a state machine to wait for the user interaction to finish:

``` lang-cs
public class UserNamePrompt : MonoBehaviour 

    }

    public Awaitable<string> WaitForUsernameAsync() => _completionSource.Awaitable;
}

...

public class HighScoreRanks : MonoBehaviour 

}
```

## Additional resources

-   [Awaitable code example reference](https://docs.unity3d.com/6000.3/Documentation/Manual/async-awaitable-examples.html)
