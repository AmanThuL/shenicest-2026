---
title: "Analyze memory usage with memory profiling tools"
page_title: "Analyze Memory Usage with Memory Profiling Tools"
source_url: "https://unity.com/how-to/analyze-memory-usage-memory-profiling-tools"
final_url: "https://unity.com/how-to/analyze-memory-usage-memory-profiling-tools"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Profile and analyze memory usage with Unity's memory profiling tools

This page provides information on two tools for analyzing memory usage in your application in Unity: The Memory Profiler package and the Memory Profiler module.

<span class="absolute inset-0 flex items-center justify-center"><span class="dark:bg-mango-black/90 flex h-14 w-14 items-center justify-center rounded-full bg-white/90 text-black shadow-md transition-transform group-hover:scale-110 group-focus-visible:scale-110 dark:text-white"></span></span>

## -

By profiling and honing your game’s performance for a broad range of platforms and devices, you can expand your player base and increase your chance for success.

## -

The information here is excerpted from the [*Ultimate guide to profiling Unity games (Unity 6 edition)*](https://unity.com/resources/ultimate-guide-to-profiling-unity-games-unity-6), an e-book created by both external and internal Unity experts in game development, profiling, and optimization.

What is memory profiling?

Understand and define a memory budget

Determine the lowest RAM specification

A few tips for memory profiling

Memory Profiler package

Snapshots component

The Summary tab

Unity Objects tab

Profiling techniques and workflows

Managed allocations as shown in the Memory Profiler module

Timeline view in the CPU Usage Profiler module

Allocation call stacks

The Hierarchy view in the CPU Usage Profiler

Project Auditor

Memory and GC optimizations

## What is memory profiling?

Memory profiling is largely unrelated to runtime performance but is useful for testing against hardware platform memory limitations or if your game is crashing. It can also be relevant if you want to improve CPU/GPU performance by making changes that actually increase memory usage.

There are two ways of analyzing memory usage in your application in Unity:

\- The [Memory Profiler module](https://docs.google.com/document/d/1yQW1N-OLeIIP3FAClREmRw30GA7dCdE3_rDMOYjHRpc/edit#heading=h.kbjt7h158npq): This is a built-in Profiler module that gives you basic information on where your application uses memory in the regular profiler.

\- The [Memory Profiler](https://docs.google.com/document/d/1yQW1N-OLeIIP3FAClREmRw30GA7dCdE3_rDMOYjHRpc/edit#heading=h.qutsgc95uwcu): This is a dedicated tool available as a Unity package that you can add to your project. It adds an additional Memory Profiler window to the Unity Editor, which you can then use to analyze memory usage in your application in even more detail. You can store and compare snapshots to find memory leaks, or see the memory layout to find memory fragmentation issues. We will cover this in further detail later in this guide and keep focus here on the general considerations you need to take into account.

Both these tools enable you to monitor memory usage, locate areas of an application where memory usage is higher than expected, and find and improve memory fragmentation.

The Memory Profiler package is a tool you can use to inspect the memory usage of your Unity application and the Unity Editor

## Understand and define a memory budget

Understanding and budgeting for the memory limitations of your target devices are critical for multiplatform development. When designing scenes and levels, you need to stick to the memory budget that’s set for each target device. By setting limits and guidelines, you can ensure that your application works well within the confines of each platform’s hardware specification.

You can find device memory specifications in [developer documentation](https://docs.microsoft.com/en-us/windows/uwp/xbox-apps/system-resource-allocation).

It can also be useful to set content budgets around mesh and shader complexity, as well as for texture compression. These all play into how much memory is allocated. These budget figures can be referred to during the project’s development cycle.

**Determine physical RAM limits**

As each platform has a memory limit, your application will need a memory budget for each of its target devices. Use the Memory Profiler to look at a captured snapshot of your memory usage. The **Hardware Resources** snapshot (see image below) shows **Physical Random Access Memory** (RAM) and **Video Random Access Memory** (VRAM) sizes. This figure doesn’t account for the fact that not all of that space might be available to use. However, it provides a useful ballpark figure to start working with.

It’s a good idea to cross reference hardware specifications for target platforms, as figures displayed here might not always show the full picture. Developer kit hardware sometimes has more memory, or you may be working with hardware that has a unified memory architecture.

The Hardware Resources snapshot shows the device RAM and VRAM figures the snapshot was captured on.

## Determine the lowest RAM specification

Identify the hardware with the lowest specification of RAM for each platform you support, and use this to guide your memory budget decision. Remember that not all of that physical memory might be available to use. For example, a console could have a hypervisor running to support older games which might use some of the total memory. Think about a percentage (e.g., 80% of total) to use as a team depending on your specific scenario. For mobile platforms, you might also consider splitting into multiple tiers of specifications to support better quality and features for those with higher-end devices.

**Consider per-team budgets for larger teams**

Once you have a memory budget defined, consider setting memory budgets per team. For example, your environment artists get a certain amount of memory to use for each level or scene that is loaded, the audio team gets memory allocation for music and sound effects, and so on. While this may seem rigid, think of it as guidelines to inform the creative decisions being made vs the cost of the resources.

It’s important to be flexible with the budgets as the project progresses. If one team comes in under budget, assign the surplus to another team if it can improve the areas of the game they’re developing.

Once you decide on and set memory budgets for your target platforms, the next step is to use profiling tools to help you monitor and track memory usage in your game, enabling you to make informed decisions and take actions as needed.

## A few tips for memory profiling

To determine at a high-level when memory usage begins to approach platform budgets, use the following “back-of-napkin” calculation:

System Used Memory (or Total Reserved Memory if System Used shows 0) + ballpark buffer of untracked memory / Platform total memory

When this figure starts approaching 100% of your platform’s memory budget, use the [Memory Profiler package](https://docs.unity3d.com/Packages/com.unity.memoryprofiler@latest?utm_source=demand-gen&utm_medium=pdf&utm_campaign=profiling-for-performance&utm_content=the-ultimate-guide-to-profiling-ebook) to figure out why.

In Unity 6, many of the features of the Memory Profiler module are superseded by the Memory Profiler package, but you can still use the module to supplement your memory analysis efforts. For example:

\- To spot GC allocations: Although these show up in the module, they are easier to track down using [Project Auditor](https://github.com/Unity-Technologies/ProjectAuditor) or Deep Profiling.

\- To quickly look at the Used/Reserved size of the heap

\- Shader memory analysis

\- Use the **Detailed** view in the Memory Profiler module to drill down into the highest memory trees to find out what is using the most memory.

Here are some more resources to help you explore additional use cases and features of the Unity Profiler:

\- [Profiler overview in the Unity manual](https://docs.unity3d.com/Manual/Profiler.html?utm_source=demand-gen&utm_medium=pdf&utm_campaign=profiling-for-performance&utm_content=the-ultimate-guide-to-profiling-ebook)

\- [Introduction to profiling in Unity](https://youtu.be/uXRURWwabF4?t=73?utm_source=demand-gen&utm_medium=pdf&utm_campaign=profiling-for-performance&utm_content=the-ultimate-guide-to-profiling-ebook)

\- [How to profile and optimize a game](https://www.youtube.com/watch?v=epTPFamqkZo?utm_source=demand-gen&utm_medium=pdf&utm_campaign=profiling-for-performance&utm_content=the-ultimate-guide-to-profiling-ebook)

You’ll usually want to profile using a powerful developer system with lots of memory available (space for storing large memory snapshots or loading and saving those snapshots quickly is important).

Memory profiling is a different beast compared with CPU and GPU profiling because it can incur additional memory overhead itself. You may need to profile memory on higher-end devices (with more memory), but specifically watch out for the memory budget limit for the lower-end target specification.

Settings such as quality levels, graphics tiers, and AssetBundle variants may have different memory usage on more powerful devices. With that in mind, here are some details to keep in mind to get the most from memory profiling:

\- The quality and graphics settings can affect the size of render textures used for shadow maps.

\- The resolution scaling can affect the size of the screen buffers, render textures, and post-processing effects.

\- Texture settings can affect the size of all textures.

\- The maximum LOD can affect models and more.

If you have AssetBundle variants like an HD (High Definition) and an SD (Standard Definition) version, and you choose which one to use based on the specifications of your target device, you might get different asset sizes based on which device you are profiling on.

\- The screen resolution of your target device will affect the size of render textures used for post-processing effects.

\- The supported graphics API of a device might affect the size of shaders based on which variants of them it supports (or doesn’t support).

\- A tiered system that uses different quality and graphic settings, as well as AssetBundle variants, is a great way to be able to target a wider range of devices.

For example, you can load a HD version of an AssetBundle on a 4GB mobile - device, and a SD version on a 2GB device. However, take the above variations in memory usage in mind and make sure to test both types of devices, as well as devices with different screen resolutions or supported graphics APIs.

**Note**: The Unity Editor will generally always show a larger memory footprint due to additional objects that are loaded from the Editor and Profiler. Additionally, texture memory footprint is higher since they are all forced to have read/write enabled in the Editor.

The Memory Profiler module allows you to easily see how much memory you have allocated to the system.

## The Memory Profiler package

The [Memory Profiler](https://docs.unity3d.com/Packages/com.unity.memoryprofiler@1.1/manual/index.html) package can help you understand and optimize your project's memory usage. It allows you to capture 'snapshots' of your application's memory at specific moments, both within the Unity Editor and in running Player builds on your target device.

The snapshots provide a comprehensive breakdown of how memory is being utilized, showing allocations throughout the engine. This helps you identify sources of excessive or unnecessary memory usage, track down memory leaks, and inspect issues like heap fragmentation.

After installing the Memory Profiler package, open it via **Window \> Analysis \> Memory Profiler**.

The Memory Profiler’s top menu bar allows you to change the player selection target and capture or import snapshots. The Target selection dropdown in the top-left corner allows you to profile memory directly on your target hardware by connecting the Memory Profiler to the remote device. Note that profiling in the Unity Editor will give you inaccurate figures due to overheads added by the Editor and other tooling.

Change player selection and capture or import memory snapshots.

## Snapshots component

On the left side of the Memory Profiler window is the [Snapshots component](https://docs.unity3d.com/Packages/com.unity.memoryprofiler@1.1/manual/snapshots-component.html). Use this to manage and open or close saved memory snapshots. The Snapshot component provides two views, Single Snapshot and Compare Snapshot.

Similar to the Profile Analyzer, the Memory Profiler allows you to load and compare two memory snapshots side by side. Use this comparison to track memory growth over time, analyze usage between scenes, or identify potential memory leaks.

Memory Profiler has a number of tabs in the main window that allow you to dig into memory snapshots, the key ones being **Summary**, **Unity Objects**, and **All of Memory**. Let’s look at each of these options in detail.

You can manage multiple memory snapshots.

## The Summary tab

The [Summary tab](https://docs.unity3d.com/Packages/com.unity.memoryprofiler@1.1/manual/summary-tab.html) gives you a high-level snapshot of your project’s memory usage at the moment a memory capture was taken. It’s perfect for when you want a fast and informative overview without diving into detailed analysis.

This view highlights key metrics and can help you quickly spot potential memory issues or unexpected usage patterns. It’s especially useful when comparing snapshots or debugging memory usage over time. Let’s look at a few of its key sections.

**Tips:** In the right panel (see image below), you’ll find helpful contextual information about your snapshot. These can alert you to possible problems or guide you in interpreting results.

**Memory Usage on Device:** This shows the application footprint in physical memory. It includes all Unity and non-Unity allocations resident in memory at the time of the capture.

**Allocated Memory Distribution:** This view visualizes how allocated memory is distributed across different memory categories.

Note the **Untracked\*** memory bar. It corresponds to the memory that Unity does not track through its memory management system. Such allocations may come from native plugins and drivers. Use the platform-specific profiler to analyze Untracked memory usage for your target device.

**Managed Heap Utilization:** In this view, you’ll get a breakdown of the memory that Unity's scripting VM manages, which includes managed heap memory used for managed objects, empty heap space that might have previously been used by objects or been reserved during the last heap expansion, and memory used by a virtual machine itself.

**Top Unity Object Categories:** This displays which types of Unity objects use the most memory in the snapshot (e.g., Texture2D, mesh, GameObject).

The Summary tab displays an overview of memory at the time the snapshot was captured.

## The Objects tab

The [Unity Objects tab](https://docs.unity3d.com/Packages/com.unity.memoryprofiler@1.1/manual/unity-objects-tab.html) displays any Unity objects that allocated memory, how much native and managed memory the object uses, and the combined total. Use this information to identify areas where you can eliminate duplicate memory entries or to find which objects use the most memory. And via the search bar, you can find the entries in the table which contain the text you enter.

By default, the table lists all relevant objects by Allocated Size in descending order. You can click on a column header name to sort the table by that column or to change whether the column sorts in ascending or descending order.

Use this to your advantage when optimizing memory usage and aiming to pack memory more efficiently for hardware platforms where memory budgets are limited.

The Unity Objects tab allows you to drill down into captured snapshot memory usage with high granularity.

## Memory profiling techniques and workflows

Begin by analyzing a Memory Profiler snapshot to identify high-memory usage areas. Once you capture or load a Memory Profiler snapshot, use the Unity Objects tab to inspect the categories, ordered from largest to smallest in memory footprint size.

Project assets are often the highest consumers of memory. Using [the Table mode](https://docs.unity3d.com/Packages/com.unity.memoryprofiler@1.1/manual/unity-objects-tab.html#table-mode), locate textures, meshes, audio clips, render textures, shader variants, and preallocated buffers. These are often good candidates to start with when optimizing memory usage. The Project Auditor is a great complementary tool here as it can provide some recommendations about how to reduce memory use for assets (making sure the asset is set up properly in the **Import Settings** Inspector is a good starting place).

**Locating memory leaks**

A memory leak is a situation where unused assets, objects, or resources are not properly released from memory. This can lead to progressively increasing memory usage and performance issues or crashes.

A memory leak typically happens when:

\- An object is not released manually from memory through the code.

\- An object unintentionally remains in memory because another object still holds a reference to it.

The Memory Profiler has a **Compare Snapshots** mode which can help [find memory leaks](https://docs.unity3d.com/Packages/com.unity.memoryprofiler@1.1/manual/find-memory-leaks.html) by comparing two snapshots over a specific time frame. This comparison can reveal objects that persist in memory when they should be deallocated.

A frequent scenario for memory leaks in Unity games is after unloading a scene. Objects from the unloaded scene might not be correctly garbage collected if references to them still exist.

**Locating recurring memory allocations over application lifetime**

Through [differential comparison of multiple memory snapshots](https://docs.unity3d.com/Packages/com.unity.memoryprofiler@1.1/manual/find-memory-leaks.html), you can identify the source of continuous memory allocations during application lifetime.

The following sections provide some tips to help identify managed heap allocations in your projects.

Compare two snapshots to see the differences.

## Managed allocations as shown in the Memory Profiler module

The Memory Profiler module in the Unity Profiler represents managed allocations per frame with a red line. This should be 0 most of the time, so any spikes in that line indicate frames you should investigate for managed allocations.

Any spikes seen for GC Allocated In Frame give you pointers to investigate for managed allocations.

## Timeline view in the CPU Usage Profiler module

The Timeline view in the CPU Usage Profiler module shows allocations, including managed ones, in pink, making them easy to hone in on.

Managed allocations appear as pink-colored markers in the Timeline view.

## Allocation call stacks

[Allocation call stacks](https://docs.unity3d.com/Manual/ProfilerCPU.html#call-stacks) provide a quick way to discover managed memory allocations in your code. These will provide the call stack detail you need at less overhead compared to what deep profiling would normally add, and they can be enabled on the fly using the standard Profiler.

Allocation call stacks are disabled by default in the Profiler. To enable them, click the **Call Stacks** button in the main toolbar of the Profiler window. Change the **Details** view to **Related Data**.

**Note**: If you’re using an older version of Unity (prior to allocation call stack support), then [deep profiling](https://docs.google.com/document/d/1yQW1N-OLeIIP3FAClREmRw30GA7dCdE3_rDMOYjHRpc/edit#heading=h.yqm5p7yrbgl0) is a good way to get full call stacks to help find managed allocations.

GC.Alloc samples selected in the Hierarchy or Raw Hierarchy will now contain their call stacks. You can also see the call stacks of GC.Alloc samples in the selection tooltip in Timeline.

Enabling Allocation call stacks in the Profiler will allow you to follow the call stack back to the source for managed allocations.

## The Hierarchy view in the CPU Usage Profiler

The Hierarchy view in the CPU Usage Profiler lets you click on column headers to use them as the sorting criteria. Sorting by GC Alloc is a great way to focus on those.

Using the Hierarchy view in the CPU Usage Profiler module is a great way to filter and focus on managed allocations.

## Project Auditor

[The Project Auditor](https://docs.unity3d.com/Packages/com.unity.project-auditor@latest), introduced as a package in Unity 6.1, is a powerful analysis tool for Unity projects, designed to help developers optimize performance, maintain best practices, and identify potential issues and bottlenecks in their projects.

Project Auditor scans your entire project and provides detailed reports about inefficiencies, such as heavy scripting calls, unused assets, excessive entity counts, etc.

The Project Auditor covers several different areas:

**Performance optimization:** It identifies problems that could impact your project’s runtime performance, such as excessive garbage generation, unnecessary object allocations, or expensive function calls.

**Code and asset review**: It highlights unused assets, inefficient code patterns, or outdated APIs that can be refactored. This helps reduce build size, improve overall project maintainability and optimize memory use.

**Diagnostics and best practices**: It provides recommendations based on Unity best practices and highlights errors or warnings related to your project setup, like missing references, or suboptimal Player or Quality settings.

**Customizable reports**: It organizes the results into categories, making it easy to prioritize optimizations. You can also create custom rules to tailor the analysis to your specific project or needs.

**💡Tips**:

\- Run the Project Auditor at key stages of development (e.g., before milestones, beta releases, final builds). Regular audits help catch performance bottlenecks, unused assets, or outdated code early, preventing problems from growing larger as your project scales.

\- You can automate running Project Auditor as part of your CI or build setup (as shown [here](https://docs.unity3d.com/Packages/com.unity.project-auditor@1.0/manual/run-from-command-line.html) in the manual) and use the reports to make sure no one checks in any assets or code that add new issues (using the API detailed [here](https://docs.unity3d.com/Packages/com.unity.project-auditor@1.0/manual/compare-issues.html)).

\- You can add your own rules if there are particular things you want to make sure you catch in your game; e.g. texture settings, sizes, or more complicated rules. See [this page in the manual](https://docs.unity3d.com/Packages/com.unity.project-auditor@1.0/manual/custom-analyzers.html) for more details about how to do this.

The reports generated by the Project Auditor are categorized by severity (Major, Moderate, and Info). Focus on the most severe issues first, as they often highlight performance-critical problems, such as over-allocation of memory or excessive garbage collection. They’re also likely to be in code paths that are called more frequently, like Update, where any performance problems they bring will be more obvious to players.

The Project Auditor also checks settings like **Player settings** and **Quality settings** and makes recommendations about what you might change. Use this to ensure your build targets, resolution, text compression, or other project settings are optimized for your intended platform.

**Domain Reload**

The Unity Editor allows you to configure settings about entering Play mode; [this page](https://docs.unity3d.com/6000.0/Documentation/Manual/configurable-enter-play-mode.html) has more details about it, but you can often speed up your Editor iteration time by disabling Domain Reload. However, this will no longer reset your scripting state every time you enter Play mode, so you have to do this manually in your code.

The Code area in Project Auditor can analyze the scripts in your project to help you find anywhere that you need to reset your script variables. It's considered best practice to fix all the issues displayed in the Domain Reload view and then to disable domain reload. To populate this view with data, you must enable the Use Roslyn Analyzers setting in the Preferences window. Then you can run through the list of issues, following the [instructions in the manual](https://docs.unity3d.com/Packages/com.unity.project-auditor@1.0/manual/domain-reloading-issues.html) to fix them. Once they’re all addressed you can disable Domain Reload when entering play mode.

The Project Auditor Summary view

## Memory and GC optimizations

Unity uses the [Boehm-Demers-Weiser garbage collector](https://www.hboehm.info/gc/) to automatically clean up memory when it's no longer needed for your application. The GC stops running your program code and only resumes normal execution once its work is complete.

While the automatic management is convenient, unnecessary or frequent allocations can lead to performance hiccups because the garbage collector has to pause your game to clean up unused memory (also known as GC spikes). Here are some common pitfalls to keep in mind:

**Strings:** In C#, strings are reference types, not value types. This means that every new string will be allocated on the managed heap, even if it’s only used temporarily. Reduce unnecessary string creation or manipulation. Avoid parsing string-based data files such as JSON and XML, and store data in ScriptableObjects or formats like MessagePack or Protobuf instead. Use the [StringBuilder](https://msdn.microsoft.com/en-us/library/system.text.stringbuilder) class if you need to build strings at runtime.

**Unity function calls:** Some Unity API functions create heap allocations, particularly ones which return an array of temporary managed objects. Cache references to arrays rather than allocating them in the middle of a loop. Also, take advantage of certain functions that avoid generating garbage. For example, use **GameObject.CompareTag** instead of manually comparing a string with **GameObject.tag** (as returning a new string creates garbage).

You can also use the Project Auditor to list these alternatives; this can help ensure that you’re using the non-allocating versions wherever possible.

**Boxing:** Boxing occurs when a value type (e.g., int, float, struct) is converted to a reference type (e.g., object). Avoid passing a value-typed variable in place of a reference-typed variable. This creates a temporary object, and the potential garbage that comes with it implicitly converts the value type to a type object (e.g., **int i = 123; object o = i**). Instead, try to provide concrete overrides with the value type you want to pass in. Generics can also be used for these overrides.

**Coroutines:** Though yield does not produce garbage, creating a new WaitForSeconds object does. Cache and reuse the WaitForSeconds object rather than creating it in the yield line.

**LINQ and Regular Expressions:** Both of these generate garbage from behind-the-scenes boxing. Avoid LINQ and Regular Expressions if performance is an issue. Write for loops and use lists as an alternative to creating new arrays.

**Generic Collections and other managed types:** Don’t declare and populate a List or collection every frame in Update (for example, a list of enemies within a certain radius of the player). Instead, make the List a member of the MonoBehaviour and initialize it in Start. Simply empty the collection with **Clear** every frame before using it.

**Time garbage collection whenever possible**

If you are certain that a garbage collection freeze won’t affect a specific point in your game, you can trigger garbage collection with [System.GC.Collect](https://docs.microsoft.com/en-us/dotnet/api/system.gc.collect?view=net-5.0). A classic example of this is when the user is in a menu or pauses the game, where it won’t be noticable.

See [Understanding Automatic Memory Management](https://docs.unity3d.com/Manual/UnderstandingAutomaticMemoryManagement.html?utm_source=demand-gen&utm_medium=pdf&utm_campaign=profiling-for-performance&utm_content=the-ultimate-guide-to-profiling-ebook) for examples of how to use this to your advantage.

**Use the Incremental Garbage Collector to split the GC workload**

Rather than creating a single, long interruption during your program’s execution, incremental garbage collection uses multiple, shorter interruptions that distribute the workload over many frames. If garbage collection is causing an irregular frame rate, try this option to see if it reduces the problem of GC spikes. Use the Profile Analyzer to verify its benefit to your application.

Note that using the GC in Incremental mode adds read-write barriers to some C# calls, which comes with some overhead that can add up to \~1 ms per frame of scripting call overhead. For optimal performance, it’s ideal to have no GC Allocs in the main gameplay loops so that you don’t need the Incremental GC for a smooth frame rate and can hide the GC.Collect where a user won’t notice it, for example, when opening the menu or loading a new level. In such optimized scenarios, you can perform full, non-incremental garbage collections (using System.GC.Collect()).

To learn more about the Memory Profiler check out the following resources:

[Memory Profiler Walkthrough and Tutorial](https://www.youtube.com/watch?v=Uuzd39AjFWQ)

[Memory Profiler documentation](https://docs.unity3d.com/Packages/com.unity.memoryprofiler@0.4/manual/index.html)

[Improve memory usage with the Memory Profiler in Unity](https://www.youtube.com/watch?v=I9wB4Cvgz5g?utm_source=demand-gen&utm_medium=pdf&utm_campaign=profiling-for-performance&utm_content=the-ultimate-guide-to-profiling-ebook)

[Memory Profiler: The Tool for Troubleshooting Memory-related Issues](https://www.youtube.com/watch?v=5b79ZIQBXsg?utm_source=demand-gen&utm_medium=pdf&utm_campaign=profiling-for-performance&utm_content=the-ultimate-guide-to-profiling-ebook)

[Working with the Memory Profiler](https://learn.unity.com/tutorial/working-with-the-memory-profiler-2019-3)

## More tips for Unity 6

You can find many more best practices and tips for advanced Unity developers and creators from the Unity best practices hub. Choose from over 30 guides, created by industry experts, and Unity engineers and technical artists, that will help you develop efficiently with Unity’s toolsets and systems.

<a href="https://unity.com/how-to" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[3.125rem] px-[2rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">More best practices<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>
