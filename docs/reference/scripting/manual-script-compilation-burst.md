---
title: "Burst compilation"
page_title: "Unity - Manual: Burst compilation"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/script-compilation-burst.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/script-compilation-burst.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Burst compilation

Burst is a compiler that works on a subset of C# referred to in the Unity context as High-Performance C# (HPC#). Burst uses [LLVM](https://llvm.org/) to translate .NET [Intermediate Language (IL)](https://learn.microsoft.com/en-us/dotnet/standard/managed-code) to code that’s optimized for performance on the target CPU architecture.

Burst was originally designed for use with Unity’s job system. Jobs are structs that implement the [`IJob`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UnityJobs.IJob.html) interface and represent small units of work that can run in parallel to make best use of all available CPU cores. Designing or refactoring your project to split work into Burst-compiled jobs can significantly improve the performance of CPU-bound code. For more information, refer to [Write multithreaded code with the job system](https://docs.unity3d.com/6000.3/Documentation/Manual/job-system.html).

Aside from jobs, Burst can also compile static methods, as long as the code inside them belongs to the supported subset of C#. For more information on what’s included in High-Performance C#, refer to [HPC# overview](https://docs.unity3d.com/Packages/com.unity.burst@latest/index.html?subfolder=/manual/csharp-hpc-overview.html).

Burst is central to Unity’s [Entity Component System (ECS) technologies](https://docs.unity3d.com/Packages/com.unity.entities@latest/index.html?subfolder=/manual/ecs-packages.html), which includes a series of interdependent packages that work together to produce high performance code. However, Burst can be used independently of ECS and can be integrated into any Unity project that uses supported C# features.

For more information on Burst, refer to the [Burst compiler package documentation](https://docs.unity3d.com/Packages/com.unity.burst@latest).

## Burst’s role in the compilation pipeline

Burst is not a complete [scripting back end](https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-backend) because it only supports a subset of C#. It can’t replace [Mono](https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-backends-mono.html) or [IL2CPP](https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-backends-il2cpp.html) in your project but is supplemental to either of them.

When you include the Burst package in your project, the scripting back end compiles the code by default and Burst compiles whichever Burst-compatible parts of it are [marked for Burst compilation](https://docs.unity3d.com/Packages/com.unity.burst@latest/index.html?subfolder=/manual/compilation-burstcompile.html).

Your C# scripts compile to Intermediate Language (IL) as usual. For methods marked for Burst, that IL is further compiled by Burst into native code. Burst compiles just-in-time (JIT) in the Unity Editor’s Play mode but ahead-of-time (AOT) in Player builds.

The subset of C# supported by Burst doesn’t support managed objects. Unity has packages designed to provide Burst-compatible versions of common types and data structures. The [Collections](https://docs.unity3d.com/Packages/com.unity.collections@latest) package offers Burst-compatible collections such as arrays and lists, and [Unity Mathematics](https://docs.unity3d.com/Packages/com.unity.mathematics@latest) offers Burst-compatible mathematics functions.

## Compiling with Burst

Code is Burst compiled if the following conditions are met:

-   The code is [Burst-compatible](https://docs.unity3d.com/Packages/com.unity.burst@latest/index.html?subfolder=/manual/csharp-hpc-overview.html).
-   Burst compilation is enabled, either through [Burst AOT Settings](https://docs.unity3d.com/Packages/com.unity.burst@latest/index.html?subfolder=/manual/building-aot-settings.html) for Player builds or through the [Burst menu](https://docs.unity3d.com/Packages/com.unity.burst@latest/index.html?subfolder=/manual/editor-burst-menu.html) for Unity Editor code.
-   The code is explicitly marked with the [`[BurstCompile]`](https://docs.unity3d.com/Packages/com.unity.burst@latest/index.html?subfolder=/manual/compilation-burstcompile.html) attribute or is referenced from code that is.

You can use the [scripting symbol](https://docs.unity3d.com/6000.3/Documentation/Manual/platform-dependent-compilation.html) `ENABLE_BURST_AOT` to conditionally compile sections of your code only when the Burst AOT compilation setting is enabled.

For more information, refer to [Burst compilation](https://docs.unity3d.com/Packages/com.unity.burst@latest/index.html?subfolder=/manual/compilation.html)

## Additional resources

-   [Burst compiler package documentation](https://docs.unity3d.com/Packages/com.unity.burst@latest)
-   [Job system](https://docs.unity3d.com/6000.3/Documentation/Manual/job-system.html)
