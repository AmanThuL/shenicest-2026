---
title: "Awaitable code example reference"
page_title: "Unity - Manual: Awaitable code example reference"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/async-awaitable-examples.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/async-awaitable-examples.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Awaitable code example reference

The examples in this reference demonstrate `Awaitable` solutions to common scenarios encountered when writing asynchronous code.

## Asynchronous tests

Unity’s [Test Framework](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/test-framework-introduction.html) doesn’t recognize `Awaitable` as a valid test return type. However, the following example shows how you can use the `Awaitable` implementation of `IEnumerator` to write async tests:

``` lang-cs
[UnityTest]
public IEnumerator SomeAsyncTest(){
    async Awaitable TestImplementation(){
        // test something with async / await support here
    };
    return TestImplementation();
}
```

## Frame coroutines

You can use the frame-related async methods in the `Awaitable` class to create asynchronous Unity coroutines as an alternative to iterator-based coroutines:

``` lang-cs
async Awaitable SampleSchedulingJobsForNextFrame()

JobHandle ScheduleSomethingWithJobSystem()

```

### Conditional wait

In iterator-based coroutines, [WaitUntil](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/WaitUntil.html) suspends a coroutine execution until a delegate evaluates `true`. You can create equivalent behavior for an `Awaitable`-returning asynchronous method by making it wait until a condition changes using a cancellation token:

``` lang-cs
public static async Awaitable AwaitableUntil(Func<bool> condition, CancellationToken cancellationToken)

}
```

You can then pass in a cancellation token as follows:

``` lang-cs
cancellationTokenSource = new CancellationTokenSource();
currentTask = AwaitableUntil(myCondition, cancellationTokenSource.Token);
```

## Loading resources asynchronously

You can `await` an asynchronous resource loading operation so that it doesn’t block the main thread:

``` lang-cs
public async Awaitable LoadResourcesAsync()

```

## Composition

You can `await` multiple different `await`-compatible types in the same method:

``` lang-cs
public async Awaitable Bar()

```

<span id="awaitable-as-task"></span>

## Wrapping Awaitable in .NET Task

To work around some of the limitations of `Awaitable` you can wrap it in a .NET `Task`. This incurs the cost of an allocation but gives you access to methods such as `WhenAll` and `WhenAny` from the `Task` API. To do this you can write your own custom `AsTask` extension methods as follows:

``` lang-cs
// Implement custom AsTask extension methods to wrap Awaitable in Task
public static class AwaitableExtensions
    
        public static async Task<T> AsTask<T>(this Awaitable<T> a)
        
    }
```

<span id="await-multiple-times"></span>

## Await a result multiple times

A major difference between `Awaitable` and `Task` is that `Awaitable` objects are pooled to reduce allocations. You can’t safely `await` an `Awaitable`-returning method that completes with a result multiple times because once returned the original `Awaitable` object is returned to the pool.

### Unsafe version

The following code is **not safe** and will lead to exceptions and deadlocks:

``` lang-cs
async Awaitable Bar()
```

### Safe version

This is one of the scenarios where you can [wrap Awaitable in a Task](https://docs.unity3d.com/6000.3/Documentation/Manual/async-awaitable-examples.html#awaitable-as-task) at the cost of an allocation. The `Task` can then be safely awaited multiple times:

``` lang-cs
// Implement custom AsTask extension methods to wrap Awaitable in Task
public static class AwaitableExtensions
    
        public static async Task<T> AsTask<T>(this Awaitable<T> a)
        
    }

async Awaitable Bar()
```

## Additional resources

-   [Comparing Unity Awaitable and .NET Task](https://docs.unity3d.com/6000.3/Documentation/Manual/async-awaitable-introduction.html)
-   [Async continuation and completion](https://docs.unity3d.com/6000.3/Documentation/Manual/async-awaitable-continuations.html)
-   [Awaitable API reference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.html)
