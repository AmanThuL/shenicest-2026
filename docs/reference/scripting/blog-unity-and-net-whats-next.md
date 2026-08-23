---
title: "Unity and .NET, what's next?"
page_title: "Unity and .NET, what’s next?"
source_url: "https://unity.com/blog/engine-platform/unity-and-net-whats-next"
final_url: "https://unity.com/blog/engine-platform/unity-and-net-whats-next"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Unity and .NET, what’s next?

<a href="https://unity.com/blog" class="text-xxs mt-8 flex items-center font-bold uppercase hover:underline"><span class="ml-1">Unity Blog</span></a>

# Unity and .NET, what’s next?

<span class="text-gray-900 dark:text-gray-100 pb-1 loco-caption-lg-semibold">ALEXANDRE MUTEL / UNITY TECHNOLOGIES</span><span class="text-gray-700 dark:text-gray-300 tracking-normal loco-text-body-xs-semibold">Contributor</span>

<span class="mr-2">May 18, 2022</span><span class="mr-2">\|</span><span class="mr-2">15 Min</span>

Programming and DevOps

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

We’ve recently started a multiyear initiative to help you write more performant code faster and deliver long-term stability and compatibility. Read on to find out what we’re doing to update the foundational tech stack behind your scripts.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

The [.NET ecosystem](https://dotnet.microsoft.com/en-us/learn/dotnet/what-is-dotnet) is dynamically evolving in a number of beneficial ways, and we want to bring those improvements to you as soon as we can. Our internal .NET Tech Group works on continuous improvement of our .NET integration, including newer C# features and [.NET Standard 2.1](https://unity.com/releases/2021-lts/programming#updated-c-8-and-net-support). But we’ve recently kicked things into a higher gear to improve your developer experience across the board, based on your feedback.

This blog post introduces the issues we’re working on. We’ve also discussed this topic at the Unity Dev Summit at GDC 2022. You can watch the full session [here](https://youtu.be/3SBP2Gpm97k).

This content is hosted by a third party provider that does not allow video views without acceptance of Targeting Cookies. Please set your cookie preferences for Targeting Cookies to yes if you wish to view videos from these providers.

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Cookie settings</span>

The evolution of .NET and Unity

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

The story starts 17 years ago, when our CTO started leveraging the Mono .NET runtime with C#. Unity favored C# due to its simplicity, combined with a JIT (just-in-time) compiler that translates your C# into relatively efficient native code. The remaining and much larger parts of the Unity engine have been developed using C++ in order to provide well-balanced and controlled performance.

For many years, Unity had been running with a specific fork of the Mono .NET runtime and C# language (2.0). During that time, we’ve added support for additional platforms. We’ve also developed our own compiler and runtime, IL2CPP, to enable you to target iOS and some console platforms.

In the meantime, the overall Microsoft .NET ecosystem has evolved, with new licensing and support for non-Windows platforms. This evolution has allowed us to upgrade the [Unity .NET Mono Runtime](https://docs.unity3d.com/Manual/overview-of-dot-net-in-unity.html) in 2018 and embrace more modern C# language versions (7.0+). The same year, we also released the first version of the Burst compiler, pioneering fast native code generated for a subset of the C# language. This breakthrough allowed Unity to envision a world where we could extend the usage of C# in the other critical segments of the engine without having to develop these parts in C++, leading to the development of the [DOTS runtime](https://forum.unity.com/threads/dots-development-status-and-next-milestones-march-2022.1253355/).

Unity 2020 LTS and [Unity 2021 LTS](https://unity.com/releases/2021-lts/programming) brought newer C# language versions and new .NET APIs. In parallel, we have seen tremendous performance improvements be delivered in the .NET ecosystem, as well as a more friendly development environment with the introduction of SDK style csproj and the flourishing NuGet ecosystem.

What we need to do

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

As a result of this long evolution, the Unity platform includes a very large C++ codebase that interacts directly with .NET objects using specific assumptions inherited from the Mono .NET Runtime. These are no longer valid or efficient for the .NET (Core) Runtime.

Furthermore, there’s a complicated custom compilation pipeline bound to the Unity Editor that doesn't rely on MSBuild and thus cannot easily benefit from all standard features.

We’ve also been talking to many of you over the past few years, both in interviews and on the [Unity forum](https://forum.unity.com/forums/scripting.12/), to see what we could improve to better enable your success. What we’ve heard is that you want to use the latest C# language, the .NET runtime technology, and third-party C# code from NuGet. When it comes to using the Unity platform, you told us you wanted to get the maximum out of the target hardware with high-quality C# testing, debugging and profiling tools, and good integration between standard .NET API and the Unity API. As a C# Unity programmer, you want Unity tools that seamlessly work with the rest of your toolbox and enable rapid iteration so that you can achieve best-in-class runtime performance.

Getting there is going to take us several years. We’ll keep you in the loop with frequent blog and forum updates on the technical challenges that we encounter along the way.

How we’re going to do it

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Our first step on this initiative was to huddle with all the internal people passionate about C# and .NET in Unity to form a C#/.NET Tech Group to drive this effort.

We want to build on top of the .NET ecosystem instead of developing custom solutions. To enable you to take advantage of the performance and productivity improvements that come with the latest .NET SDK/Runtime and MSBuild, we want to migrate from the Mono .NET Runtime to CoreCLR, the modern .NET (Core) Runtime.

This initiative is also bringing you innovation beyond the existing .NET universe, with the goals of delivering faster .NET iteration cycles on your C# scripts. We’ll be working on converging the JIT and AOT (ahead-of-time) solutions – IL2CPP and Burst – to offer the best balance between compile time efficiency and CodeGen quality.

Externally, we’re working with partners in the industry like Microsoft and JetBrains to ensure that Unity creators are using the latest .NET technology. We’re also ramping up our participation in open-source communities. We’re going to break down this endeavor into several steps. Let’s see what’s coming next.

What we’re working on in 2022

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

This year, the teams are planning to work on the following tracks.

C# development workflow

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

**Iteration time** remains our [top priority](https://forum.unity.com/threads/improving-iteration-time-on-c-script-changes.1184446/) since we know that you want to get more out of your time. Here are a few examples of what we’re doing to improve this.

-   As part of the compilation pipeline, we’re improving the time spent by the IL Post Processing which is responsible to modify the compiled .NET assemblies after your C# has been compiled. We are now using a persistent process to run the IL Post Processing after the compilation phase, and this can shave off a few hundred milliseconds.
-   With the Burst compiler being used more frequently, we’re improving the granularity of detecting code changes with a transitive hashing algorithm. This lets us identify which Burstable code we need to compile more quickly. We’re working on moving the Burst compiler out of process so that it can compile your code faster thanks to running in a separate .NET 6.0 executable.
-   We’re also making improvements to the domain reload by improving the reflection data built behind the scene whenever the [TypeCache](https://docs.unity3d.com/ScriptReference/TypeCache.html) is used.
-   We’re going to add tests and validation to better track iteration time regression for packages and Project templates.

For the **migration to MSBuild**, the first step is to decouple our compilation pipeline from the Unity Editor and move it to a separate process. This is a complicated operation because there are years of legacy code with thousands of lines of C++ and C# code that we need to untangle in order to achieve this – while also staying backward compatible. You won’t see changes from your point of view, but it’s going to pave our path to MSBuild and simplify maintenance.

We’re also going to **improve the C# IDE debugging experience with Burst** by introducing a mode that will automatically switch the debugger to managed debugging when a breakpoint is set on a codepath running with Burst. This means you won’t have to manually remove the \[BurstCompile\] attribute on codepath being debugged.

Modernizing the .NET runtime

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

The work involved in the **migration to .NET CoreCLR runtime** has already started, and it’s a very challenging journey. In order for us to successfully deliver this migration, we’d like to tackle the problem gradually and make sure that we can release pieces in a way that maintains stability of existing Unity projects.

So, we’re planning to deliver this migration in multiple phases:

-   First, we’ll provide **support of .NET CoreCLR for standalone players on desktop** platforms. You’ll be able to select this runtime in your player settings alongside the existing Mono and IL2CPP backend. This first phase should help us to migrate the core part of the Unity Engine (which is much smaller than the Editor part), and will hopefully solve a good chunk of the technical challenges involved for this migration. You will still access the .NET runtime through the .NET Standard 2.1 API, and we aim to release this new runtime during 2023.
-   Secondly, we’ll be **porting the Unity Editor to .NET CoreCLR** and removing support for the .NET Mono runtime at the same time. This second phase will challenge how we are going to reload your scripts in the Editor without using AppDomains and complete the switch to .NET CoreCLR. It will also involve upgrading IL2CPP to support the base class libraries from the dotnet/runtime repository. You will finally have access to the full .NET 7.x or 8.0 API. We hope to release this new Editor during 2024.

Modernizing the Unity runtime

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

[.NET Standard 2.1](https://devblogs.microsoft.com/dotnet/announcing-net-standard-2-1/) support in [Unity 2021 LTS](https://unity.com/releases/2021-lts/programming) enables us to start modernizing the Unity runtime in a number of ways. We are currently working on two improvements.

**Improving the async/await programming model**. Async/await is a fundamental programming approach to writing gameplay code that must wait for an asynchronous operation to complete without blocking the engine mainloop.

In 2011, before async/await was mainstream in .NET, Unity introduced asynchronous operations with iterator-based [coroutines](https://docs.unity3d.com/Manual/Coroutines.html), but this approach is incompatible with async/await and can be less efficient. In the meantime, .NET Standard 2.1 has been improving the support of async/await in C# and .NET with the introduction of a more efficient handling of async/await operations via [ValueTask](https://devblogs.microsoft.com/dotnet/understanding-the-whys-whats-and-whens-of-valuetask/), and by allowing your own task-like system via AsyncMethodBuilder.

We can now leverage these improvements, so we’re working on enabling the usage of async/await with existing asynchronous operations in Unity (such as waiting for the next frame or waiting for a UnityWebRequest completion). As a first step, we’re improving the support for canceling pending asynchronous tasks when a MonoBehavior is being destroyed or when exiting Play mode by using [cancellation tokens](https://docs.microsoft.com/en-us/dotnet/standard/threading/cancellation-in-managed-threads). We have also been working closely with our biggest community contributors, such as the author of [UniTask](https://github.com/Cysharp/UniTask), to ensure that they will be able to leverage these new functionalities.

**Reducing memory allocations and copies by leveraging Span\<T>.** Because Unity is a C++ engine with a C# Scripting layer, there’s a lot of data being exchanged between the two. This can be inefficient since it often requires either copying data back and forth or allocating new managed objects.

[Span\<T>](https://docs.microsoft.com/en-us/archive/msdn-magazine/2018/january/csharp-all-about-span-exploring-a-new-net-mainstay) was [introduced in C# 7.2](https://docs.microsoft.com/en-us/events/connect-2017/t125) to improve such scenarios and is available by default in .NET Standard 2.1. In recent years, you might have heard or read about many significant performance improvements made to the .NET Runtime thanks to Span\<T> (see improvements details in [.NET Core 2.1](https://devblogs.microsoft.com/dotnet/performance-improvements-in-net-core-2-1/), [.NET Core 3.0](https://devblogs.microsoft.com/dotnet/performance-improvements-in-net-core-3-0/#span-and-friends), [.NET 6](https://devblogs.microsoft.com/dotnet/performance-improvements-in-net-5/), [.NET 6](https://devblogs.microsoft.com/dotnet/performance-improvements-in-net-6/#arrays-strings-spans)). We want to leverage its usage in Unity since this will help to reduce allocations and, consequently, Garbage Collection pauses while improving the overall performance of many APIs.

Join us on this journey

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

We hope that you’re all as excited as we are about these changes and features.

Let us know what you think about our plans on the [forum](https://forum.unity.com/forums/experimental-scripting-previews.107/). We’re also going to be regularly updating the [engineering section](https://unity.com/roadmap/unity-platform/engineering) of the [Unity Platform Roadmap](https://unity.com/roadmap/unity-platform/), and you can share your feature requests and prioritization suggestions with us there.

***Editor's note:** This article was last updated in February 2023.*
