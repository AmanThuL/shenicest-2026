---
title: "Unity 6.3 Manual: Unity programming best practices"
page_title: "Unity - Manual: Unity programming best practices"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/programming-best-practices.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/programming-best-practices.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Unity programming best practices

There are some unique features of Unity’s programming environment that require extra consideration when writing code compared to standard C#/.NET projects. The following is a summary of key issues to be aware of when writing code for Unity applications, along with best practices to help you avoid common pitfalls.

## Unity Object lifecycle and references

When writing C# in Unity, be careful when comparing objects for equality with other objects or with null. For types that inherit from [UnityEngine.Object](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Object.html), Unity uses a custom version of the C# [equality and inequality operators](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/operators/equality-operators). This means the null check `myGameObject == null` can evaluate `true` (and conversely `myGameObject != null` can evaluate `false`) even if `myGameObject` technically holds a valid C# object reference. For more information on the specifics of this behavior, refer to [Custom equality operators](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Object.html#custom-equality-comparers).

Unity’s custom equality behavior and object lifecycle have a few implications for your code:

-   In circumstances where you want to be sure of excluding destroyed objects in your check, make sure to use `if (obj == null)` and not `ReferenceEquals` for Unity objects.
-   In circumstances where you want to check for actual C# null references, use `ReferenceEquals` or cast to `System.Object` first.
-   When comparing two Unity objects for equality, be aware that `obj1 == obj2` may return `true` even if both references are different C# objects, if one or both have been destroyed and recreated, for example through [`Undo`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo.html).
-   The custom equality operator is slower than the standard C# one. This is usually not a problem, but be mindful of this at scale and in hot paths.
-   Don’t cache components across scene unloads without guarding because they can be destroyed but remain as C# wrapper objects with no unmanaged counterpart.
-   Don’t hold strong references to large assets in static fields because they persist across scenes and prevent unloading.
-   When destroying objects, [`Object.DestroyImmediate`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.DestroyImmediate.html) is Editor-only so use [`Object.Destroy`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.Destroy.html) at runtime and let Unity schedule destruction.

## Avoid C# finalizers

Don’t use [C# finalizers](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/finalizers) in runtime code, for the following reasons:

-   They run on separate finalizer threads and Unity APIs usually require the main thread.
-   They run non-determinisitically, leading to unpredictable behavior.
-   They might not run at all, unless the application garbage collects and waits.
-   Exceptions thrown from finalizers can cause an application halt unless specially handled.
-   By their very existence they increase garbage collector overhead.

## Garbage collector overhead and allocations

One of the most important performance risks to be mindful of in Unity applications is runtime code that allocates memory and increases garbage collector overhead, especially in hot paths.

To avoid this, apply the following coding practices:

-   Avoid per-frame allocations by [caching and reusing lists](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-reusable-code.html) and using non-allocating versions of methods where available. This includes caching [`WaitForSeconds`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/WaitForSeconds.html) and other [yield instructions](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/YieldInstruction.html) when using [coroutines](https://docs.unity3d.com/6000.3/Documentation/Manual/coroutines.html).
-   Where possible, use non-allocating versions of methods, and perform expensive operations like [`GameObject.GetComponent`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.GetComponent.html) in [`Awake`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Awake.html) and cache references to returned objects, rather than calling repeatedly from [`Update`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Update.html).
-   Avoid use of [LINQ](https://learn.microsoft.com/en-us/dotnet/csharp/linq/) in runtime code, and especially in the context of the per-frame `Update` or `FixedUpdate` and other hot paths. Methods from the `System.Linq` namespace can create unnecessary allocations and involve boxing and closures.
-   Avoid [repeated string operations](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-reference-types.html) like concatenation.
-   Identify and avoid instances of reflection. For more information, refer to [Avoid C# reflection overhead](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-gc-avoid-reflection.html).

For more detailed guidance and examples of these issues, refer to [Optimizing your code for managed memory](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-optimizing-code-managed-memory.html).

For information on tracking and reducing garbage collector overhead, refer to [Managed memory](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-managed-memory.html).

## MonoBehaviour Update loop optimization

The traditional pattern for many Unity projects involves using MonoBehaviour script components to regularly update the game state through built-in callbacks such as [`MonoBehaviour.Update`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Update.html), [`MonoBehaviour.FixedUpdate`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.FixedUpdate.html), and [`MonoBehaviour.LateUpdate`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.LateUpdate.html) that typically run many times per second.

This is a simple model that can still work well when used appropriately, but it has some key performance risks that commonly catch inexperienced developers out:

-   The default implementation of Unity’s per-frame or other regular event functions can scale poorly. Each of these `Update` functions incurs a small overhead from Unity’s internal management and interaction with the native layer. When you have many such MonoBehaviour scripts, the cumulative overhead can have significant performance impact.
-   The fact that built-in updates run very often makes them a hot code path and magnifies the effect of any inefficient, memory-intensive operations you place in them. A common bad pattern from inexperienced users is to have many MonoBehaviour scripts with `Update` functions that run unnecessarily most of the time, or that are unnecessarily memory-intensive when they do run.

To mitigate these risks, consider the following options:

-   Consider converting your project to a data-oriented architecture using Unity’s [Entity Component System (ECS)](https://docs.unity3d.com/Packages/com.unity.entities@latest) for better scalability with many entities.
-   If you use a MonoBehaviour-based architecture:
    -   To ensure you’re minimizing managed memory impact in your hot paths, refer to [Optimizing your code for managed memory](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-optimizing-code-managed-memory.html).
    -   Minimize the number of active `Update` functions by using a centralized update manager or customizing the Player loop. For more information, refer to [Using a custom update manager](https://docs.unity3d.com/6000.3/Documentation/Manual/events-per-frame-optimization.html) and [Customizing the Player loop](https://docs.unity3d.com/6000.3/Documentation/Manual/player-loop-customizing.html).
    -   Bear in mind that even in a MonoBehaviour-based project, you can often use specific features of Unity’s data-oriented systems. You can use [Jobs](https://docs.unity3d.com/6000.3/Documentation/Manual/job-system.html), [Burst-compile](https://docs.unity3d.com/6000.3/Documentation/Manual/script-compilation-burst.html) sections of your code, use more efficient data structures like [`NativeArray`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Collections.NativeArray_1.html) in performance-critical sections of your code, and choose unmanaged alternatives to managed APIs such as [those for transform operations](https://docs.unity3d.com/6000.3/Documentation/Manual/transformhandle-landing.html).

## Thread safety

While Unity has multithreaded capabilities, the core runtime is single-threaded and most APIs in the `UnityEngine` and `UnityEditor` namespaces can only be called from the main thread. Don’t reference GameObjects, Transforms, Components, or asset APIs from background threads. Never `await` with a `Task.Result` or `Task.Wait` on the main thread as this leads to deadlocks.

When dealing with inherently asynchronous and long-running operations, Unity provides the [`Awaitable`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.html) class as a Unity-specific alternative to .NET `Task`. `Awaitable` uses object pooling to reduce allocations and is aware of Unity-specific concepts like `Update` and `FixedUpdate`, which allows you to `await` tasks and schedule them to resume at specific points in the Player loop. For more information refer to [Asynchronous programming with the Awaitable class](https://docs.unity3d.com/6000.3/Documentation/Manual/async-await-support.html).

For shorter-lived but more computationally-intensive parallelized work, Unity provides the [job system](https://docs.unity3d.com/6000.3/Documentation/Manual/job-system.html), which can be [Burst compiled](https://docs.unity3d.com/6000.3/Documentation/Manual/script-compilation-burst.html). For more information, refer to [Write multithreaded code with the job system](https://docs.unity3d.com/6000.3/Documentation/Manual/job-system.html).

## Compilation considerations

For optimal performance it’s important to think not just about how you write code but how it’s compiled. Compiling code naively rather than actively defining which contexts certain source files or regions of your code are relevant for imposes the following costs:

-   Increased build size if unnecessary code is included.
-   Time spent compiling and recompiling to apply changes. This can especially affect your iteration time in the Editor.
-   Potential runtime errors if inappropriate code is included for a given platform or context.

Unity provides several mechanisms to help you control which parts of your code are compiled for different platforms and contexts:

-   You can use Assembly Definitions to group source files into assemblies that can be compiled separately. This allows you to isolate Editor-only code from runtime code, and platform-specific code from cross-platform code. For more information, refer to [Organizing scripts into assemblies](https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definition-files.html).
-   You can use `#if` directives with [scripting symbols](https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-symbol-reference.html) to exclude specific regions of code from compilation based on the target platform or context. For example, guard Editor-only code behind `#if UNITY_EDITOR` directives to exclude it from runtime builds. For more information on the various methods Unity offers for conditionally including or excluding code, refer to [Conditional compilation](https://docs.unity3d.com/6000.3/Documentation/Manual/platform-dependent-compilation.html).
-   A key Unity-specific concept is [domain reload](https://docs.unity3d.com/6000.3/Documentation/Manual/configurable-enter-play-mode.html) in the Editor on entering and exiting Play mode or recompiling scripts. Domain reloads are time consuming and can affect iteration times when writing and testing in the Editor. You can disable domain reloads on entering Play mode to improve iteration times, but you must then reset static state manually. For more information, refer to [Code and scene reload on entering Play mode](https://docs.unity3d.com/6000.3/Documentation/Manual/code-reloading-editor.html).

## Unity’s analysis tools

Unity provides a variety of tools to help you identify bottlenecks and write more performant code. The [Project Auditor](https://docs.unity3d.com/6000.3/Documentation/Manual/project-auditor/project-auditor) tool can analyze your project code to identify common performance issues and suggest fixes. The [Profiler](https://docs.unity3d.com/6000.3/Documentation/Manual/Profiler.html) can help you identify runtime performance bottlenecks in your code by providing detailed information about CPU and GPU usage, memory allocation, and more. You can also create [Roslyn analyzers](https://learn.microsoft.com/en-us/visualstudio/code-quality/roslyn-analyzers-overview?view=visualstudio) to enforce coding standards and identify performance issues specific to your project.

For more information on creating custom Roslyn analyzers and source generators, refer to [Roslyn analyzers and source generators](https://docs.unity3d.com/6000.3/Documentation/Manual/roslyn-analyzers.html).

For more information on Unity’s suite of analysis tools, refer to [Optimization](https://docs.unity3d.com/6000.3/Documentation/Manual/analysis.html).

## Additional resources

-   [Memory in Unity](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-memory.html)
-   [Optimizing your code for managed memory](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-optimizing-code-managed-memory.html)
-   [Debugging and diagnostics](https://docs.unity3d.com/6000.3/Documentation/Manual/debugging-and-diagnostics.html)
