---
title: "Scripting in Unity for experienced C# & C++ programmers"
page_title: "Scripting in Unity for experienced C# & C++ programmers"
source_url: "https://unity.com/how-to/programming-unity"
final_url: "https://unity.com/how-to/programming-unity"
topic: "csharp-style"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Scripting in Unity for experienced programmers

## For programmers new to Unity

In Unity you can use scripts to develop pretty much every part of a game or other real-time interactive content. Unity supports scripting in C# and there are two main ways to architect your C# scripts in [Unity](https://unity.com/products/core-platform): object-oriented design, which is the traditional and most widely used approach, and data-oriented design, which is now possible in Unity, for specific use cases, via our new high-performance multithreaded [<span style="text-decoration:underline">Data-Oriented Technology Stack (DOTS)</span>](https://unity.com/dots).

Are you coming to Unity from a C++ background?

GameObjects & Components in Unity

Scripting Components in Unity

Benefits of data-oriented design with DOTS

Take full advantage of modern hardware

Debugging in Unity

Scripting backends in Unity

Customize Unity by extending the Editor

## Are you coming to Unity from a C++ background?

Unity supports C#, an industry-standard language with some similarities to Java or C++

In comparison to C++, C# is easier to learn. Additionally, it’s a “managed language”, meaning that it automatically does the memory management for you: allocating-deallocating memory, covering memory leaks, and so on.

Generally, C# is preferable to C++ if you want to make a game first, and then deal with more advanced aspects of programming later.

<a href="https://docs.microsoft.com/en-us/previous-versions/visualstudio/visual-studio-2008/yyaad03b(v=vs.90)?redirectedfrom=MSDN" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[2.875rem] px-[1.625rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Learn more<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a><a href="https://docs.unity3d.com/ScriptReference/" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-gray-50 text-mango-black btn-secondary-shadow-default data-[hovered]:bg-mango-gray-100 data-[pressed]:bg-mango-gray-200 data-[pressed]:btn-secondary-shadow-pressed dark:bg-mango-gray-800 dark:text-mango-white dark:btn-secondary-shadow-default-dark dark:data-[hovered]:bg-mango-gray-900 dark:data-[pressed]:bg-mango-gray-950 dark:data-[pressed]:btn-secondary-shadow-pressed-dark h-[2.875rem] px-[1.625rem] mt-3 md:mt-0 md:ml-4"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">See Unity API documentation<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>

## GameObjects & Components in Unity

All gameplay and interactivity developed in Unity is constructed on three fundamental building blocks: GameObjects, Components, and Variables.

Any object in a game is a [GameObject](https://docs.unity3d.com/Manual/GameObjects.html): characters, lights, special effects, props–everything.

**Components**  
GameObjects can’t do anything on their own. To actually become something, you need to give a GameObject properties, which you do by adding Components.

[Components](https://docs.unity3d.com/Manual/Components.html) define and control the behavior of GameObjects they are attached to. A simple example would be the creation of a light, which involves attaching a Light Component to a GameObject (see below). Or, adding a Rigid body Component to an object to make it fall.

Components have any number of [editable properties](https://docs.unity3d.com/Manual/UsingComponents.html), or variables, that can be tweaked via the Inspector window in the [Unity editor](https://docs.unity3d.com/Manual/LearningtheInterface.html) and/or via script. In the above example, some properties of the light are range, color, and intensity.

## Scripting Components in Unity

Unity’s built-in Components are very versatile, but you will soon find you need to go beyond what they can provide to implement your own logic. To do this, you [use scripts](https://docs.unity3d.com/Manual/CreatingAndUsingScripts.html) to implement your own game logic and behaviour and then add those scripts as Components to GameObjects. Each script makes its connection with the internal workings of Unity by implementing a class which derives from the built-in class called MonoBehaviour.

Your script Components will allow you to do many things: trigger game events, check for collisions, apply physics, respond to user input, and much, much more. See the Unity [Scripting API](https://docs.unity3d.com/ScriptReference/index.html) for more information.

## Benefits of data-oriented design with DOTS

The traditional GameObject-Component concept continues to work well because it’s easy to understand for programmers and non-programmers alike, and easy to build intuitive UIs for. You add a Rigidbody Component to a GameObject and it will start falling, or a Light Component to a GameObject and it will emit light. And so on.

However, the Component system was written in an object-oriented framework and it creates challenges for developers when it comes to managing cache and memory in ever-evolving hardware.

Components and GameObjects are “heavy C++” objects. All GameObjects have a name. Their Components are C# wrappers on top of C++ components. This makes them easy to work with, however, it can come at a cost to performance because they potentially end up stored in an unstructured way. That C# object could be anywhere in memory. The C++ object can also be anywhere in memory. Things are not grouped together in contiguous memory. Every time anything is loaded in CPU for processing, everything has to be fetched from multiple locations. It can get slow and inefficient and therefore, require a lot of optimization workarounds.

To address these performance problems, we’re rebuilding the core foundation of Unity with the high-performance, multithreaded Data-Oriented Technology Stack or [DOTS](https://unity.com/dots) (currently in Preview).

DOTS makes it possible for your game to fully utilize the latest multicore processors efficiently. It’s comprised of:

-   The [C# Job System](https://unity.com/dots#c-job-system) for running multithreaded code efficiently.
-   The [Entity Component System](https://unity.com/dots#entity-component-system-ecs) (ECS) for writing high-performance code by default.
-   The [Burst Compiler](https://unity.com/dots#burst-compiler) for producing highly optimized native code.

In DOTS, the ECS is the new Component system; what you do with a GameObject in the traditional object-oriented way, you do with an Entity in this new system. Components are still called just that. The critical difference is in the data layout. You can read more about this in the blog post “[On DOTS: Entity Component System](https://blogs.unity3d.com/2019/03/08/on-dots-entity-component-system/)”.

## Take full advantage of modern hardware

In addition to being a better way of approaching game programming for design reasons, using ECS puts you in an ideal position to leverage Unity's C# Job System and Burst Compiler, letting you take full advantage of today's modern hardware.

DOTS’ multithreaded systems enable you to create games that run on a variety of hardware and build richer game worlds with more elements and more complex simulations. Performant code in turn contributes to optimal thermal control and battery lifetime on players’ mobile devices. By moving from object-oriented to data-oriented design, it can be easier for you to reuse your code and for others to understand and work on it.

As some of the technology of DOTS is in Preview, it is advised that developers use it to solve a specific performance challenge in their projects, as opposed to building entire projects on it. Check out the “More Resources” section at the bottom of this page for links to key DOTS resources.

## Debugging in Unity

Tweaking and debugging is efficient in Unity because all the gameplay variables are shown right as developers play, so things can be altered on the fly, without writing a single line of code. The game can be paused at anytime or you can step-through code one statement at a time.

Here are some great resources to learn more about optimizing in Unity:

[The Profiler](https://docs.unity3d.com/Manual/Profiler.html)

[The Profiler Analyzer](https://blogs.unity3d.com/2019/05/13/introducing-the-profile-analyzer/)

[The Memory Profiler](https://docs.unity3d.com/Manual/ProfilerMemory.html)

[Understanding optimization in Unity](https://docs.unity3d.com/Manual/BestPracticeUnderstandingPerformanceInUnity.html)

[Optimizing graphics performance](https://docs.unity3d.com/Manual/OptimizingGraphicsPerformance.html)

[General best practices](https://unity3d.com/learn/tutorials/topics/best-practices) (including extensive tips on optimizing Unity’s UI system)

## Scripting backends in Unity

.NET: Unity has used an implementation of the standard Mono runtime for scripting that natively supports C#. Unity currently ships with Visual Studio for Mac instead of MonoDevelop-Unity on macOS. On Windows, Unity ships with Visual Studio.

The .NET 4.6 scripting runtime in Unity supports many of the new exciting C# features and debugging available in C# 6.0 and beyond. This also provides a great C# IDE experience to accompany the new C# features.

IL2CPP: This is a Unity-developed scripting backend which you can use as an alternative to Mono when building projects for some platforms. When you choose to build a project using IL2CPP, Unity converts IL code from scripts and assemblies into C++ code, before creating a native binary file (.exe, apk, .xap, for example) for your chosen platform.

Note that IL2CPP is the only scripting backend available when building for iOS and WebGL.

## Customize Unity by extending the Editor

As a programmer you have a great deal of flexibility in Unity because you can [extend the editor](https://docs.unity3d.com/Manual/ExtendingTheEditor.html) with your own custom windows that behave just like the Inspector, Scene or any other built-in windows in the standard editor. Adding your own tools to Unity supports you and your team’s unique workflows and needs, ultimately boosting efficiency.

## More resources

Converting your game to DOTS

<a href="https://www.youtube.com/watch?v=BNMrevfB6Q0&amp;t=2s" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[2.875rem] px-[1.625rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">See the video<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>

DOTS documentation

<a href="https://github.com/Unity-Technologies/EntityComponentSystemSamples/blob/master/ECSSamples/Documentation/index.md" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[2.875rem] px-[1.625rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Learn more<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>

Overview of Unity real-time 3D platform

<a href="https://unity3d.com/unity" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[2.875rem] px-[1.625rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Learn more<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>
