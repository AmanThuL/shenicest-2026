---
title: "Profiling and debugging with Unity and native platform tools"
page_title: "Profiling and debugging with Unity and native platform tools"
source_url: "https://unity.com/how-to/profiling-and-debugging-tools"
final_url: "https://unity.com/how-to/profiling-and-debugging-tools"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Tools for profiling and debugging

Smooth performance is essential to creating great gaming experiences that reach a broad range of devices and players. Unity provides a full set of profiling and memory management tools that Unity developers can use alongside the native profiling tools available for their target platforms.

In this article we provide you with an overview of the profiling and debugging tools available with Unity and those available for target platforms.

The information here is excerpted from the e-book, *[Ultimate guide to profiling Unity games (Unity 6 edition)](https://unity.com/resources/ultimate-guide-to-profiling-unity-games-unity-6),* available to download for free. The e-book was created by both external and internal Unity experts in game development, profiling, and optimization.

Use both Unity and native tools for the best results

Unity profiling tools

Native profiling tools

GPU debugging and profiling tools

## Use both Unity and native tools for the best results

Lean, performant code and optimized memory usage lead to a better user experience across low- and high-end devices. This applies for everything, from being able to reach more users on the low-end devices by tackling heat and battery consumption, to your players’ comfort levels, and ultimately, factors that drive higher adoption and retention. It can also be a requirement for passing distribution platform specifications.Profiling is like detective work, unraveling the mysteries of why performance in your application is lagging, or why code is allocating excess memory.

The best gains from profiling are made when you plan early on in your project’s development lifecycle. It’s an ongoing proactive and iterative process. By profiling early and often, rather than just before you are about to ship your game, you and your team can understand and establish a “performance signature” for the project. If performance takes a nosedive, for instance, you’ll be able to easily spot when things go wrong, and quickly remedy the issue.

The most accurate profiling results come from running and profiling builds on target devices, as well as using platform-specific tooling to dig into the hardware characteristics of each targeted platform.

Unity ships with a range of free and powerful profiling tools for analyzing and optimizing your code, both in-Editor and on hardware. There are also several great native profiling tools designed for each target platform, such as those available from the major platform owners. Using a combination of both provides a more holistic view of application performance across all target devices.

The Highlights module in the Profiler makes it easy to understand how your game is performing vs the set target frame time. In this example, a lot of optimization work is needed on both the CPU and GPU to hit the target 60 fps.

## Unity profiling tools

Unity’s [profiling tools](https://docs.unity3d.com/6000.1/Documentation/Manual/performance-profiling-tools.html) are available in the Editor and via the [Package Manager](https://docs.unity3d.com/6000.1/Documentation/Manual/Packages.html). These tools, along with the Unity [Frame Debugger](https://docs.unity3d.com/6000.1/Documentation/Manual/FrameDebugger.html?utm_source=demand-gen&utm_medium=pdf&utm_campaign=profiling-for-performance&utm_content=the-ultimate-guide-to-profiling-ebook), are covered in more detail in the e-book [*Ultimate guide to profiling Unity games (Unity 6 edition)*](https://unity.com/resources/ultimate-guide-to-profiling-unity-games-unity-6).

**-** The [Unity Profiler](https://docs.unity3d.com/6000.1/Documentation/Manual/Profiler.html) measures the performance of the Unity Editor, and your application in Play mode or development mode while connected to a device.

**-** The [Profiling Core package](https://docs.unity3d.com/Packages/com.unity.profiling.core@1.0/manual/index.html) provides APIs that you can use to add contextual information to Unity Profiler captures.

**-** The [Memory Profiler](https://docs.unity3d.com/Packages/com.unity.memoryprofiler@1.1/manual/index.html) provides in-depth analysis of how much memory your game is using and what objects are using it.

**-** The [Profile Analyzer](https://docs.unity3d.com/Packages/com.unity.performance.profile-analyzer@1.2/manual/index.html) enables you to compare two profiling datasets side by side to analyze how your changes affect your application’s performance.

**-** The [Project Auditor](https://docs.unity3d.com/Packages/com.unity.project-auditor@1.0/manual/index.html) reports insights and issues about the scripts, assets, and code in your project, many of which relate to performance.

Unity also offers several debugging tools that complement its suite of profiling tools. The [Rendering Debugger](https://docs.unity3d.com/6000.2/Documentation/Manual/urp/features/rendering-debugger.html)'s Display Stats panel, for example, allows you to see a limited set of performance numbers and markers (CPU + GPU) on development builds without having the Editor connected.

Use the Frame Debugger to analyze how identified overdraw occurs.

## Native profiling tools

**Android / Arm**

**-** [Android Studio](https://developer.android.com/studio/profile):The latest Android Studio includes a new [Android Profiler](https://developer.android.com/studio/profile/android-profiler) that replaces the previous Android Monitor tools. Use it to gather real-time data about hardware resources on Android devices.

**-** [Arm Performance Studio](https://developer.arm.com/Tools%20and%20Software/Arm%20Performance%20Studio): A suite of tools to help you profile and debug your games in great detail, catered for devices running Arm hardware.

**-** [Snapdragon Profiler](https://developer.qualcomm.com/software/snapdragon-profiler): Specifically for Snapdragon chipset devices only. Analyze CPU, GPU, DSP, memory, power, thermal, and network data to help find and fix performance bottlenecks.

**Intel**

**-** [Intel VTune](https://software.intel.com/en-us/intel-vtune-amplifier-xe): Quickly find and fix performance bottlenecks on Intel platforms with this suite of tools. For Intel processors only.

**-** [Intel GPA suite](https://software.intel.com/content/www/us/en/develop/tools/graphics-performance-analyzers.html): A suite of graphics focused tools to help you improve your game’s performance by quickly identifying problem areas.

**Xbox / PC  
-** [PIX](https://devblogs.microsoft.com/pix/introduction/): PIX is a performance tuning and debugging tool for Windows and Xbox game developers using DirectX 12. It includes tools for understanding and analyzing CPU and GPU performance as well as monitoring various real-time performance counters.

**PC / Universal**

**-** [AMD μProf](https://developer.amd.com/amd-uprof/): AMD uProf is a performance analysis tool for understanding and profiling performance for applications running on AMD hardware.

**-** [NVIDIA NSight](https://developer.nvidia.com/tools-overview): Tooling that enables developers to build, debug, profile, and develop class-leading and cutting-edge software using the latest visual computing hardware from NVIDIA.

**-** [Samply](https://github.com/mstange/samply): Samply is an open source command line CPU profiler which uses the Firefox profiler as its UI. It works on macOS, Linux, and Windows.

**-** [Superluminal](https://superluminal.eu/): Superluminal is a high-performance, high-frequency profiler that supports profiling applications on Windows, Xbox One, and PlayStation written in C++, Rust and .NET. It is a paid product, though, and must be licensed to be used. Check out our [discussions article](https://discussions.unity.com/t/unity-profiling-using-superluminal/1614358) for a quick intro on how to get started.

**PlayStation**

**-** CPU profiler tools are available for PlayStation hardware. For more details, you need to be a registered PlayStation® developer, [start here](https://partners.playstation.net/).

**iOS**

**-** [Xcode Instruments and the XCode Frame Debugger](https://developer.apple.com/library/archive/documentation/AnalysisTools/Conceptual/instruments_help-collection/Chapter/Chapter.html): Instruments is a powerful and flexible performance-analysis and testing tool that’s part of the Xcode toolset.

**WebGL**

**-** [Firefox Profiler](https://profiler.firefox.com/): Dig into the call stacks and view flame graphs for Unity WebGL builds (among other things) with the Firefox Profiler. It also features a comparison tool to look at profiling captures side by side.

**-** [Chrome DevTools Performance](https://developer.chrome.com/docs/devtools/evaluate-performance/): Another web browser tool that can be used to profile Unity WebGL builds.

Arm’s Streamline Performance Analyzer includes a wealth of performance counter information that can be captured during live profiling sessions on target Arm hardware. This is great for identifying performance issues such as memory bandwidth saturation that result from overdraw.

## GPU debugging and profiling tools

While the Unity Frame Debug tool captures and illustrates draw calls that are sent from the CPU, the following tools can help show you what the GPU does when it receives those commands.

Some are platform-specific and offer closer platform integration. Take a look at the tools relevant to the platforms of interest:

**-** [Arm Streamline](https://developer.arm.com/Tools%20and%20Software/Streamline%20Performance%20Analyzer): Part of Arm’s Performance Studio software suite, focusing on low-overhead performance measurement of the CPU and GPU.

**-** [Arm Frame Advisor](https://developer.arm.com/Tools%20and%20Software/Frame%20Advisor): Part of Arm’s Performance Studio software suite, focusing on frame-based API profiling.

**-** [RenderDoc](https://docs.unity3d.com/Manual/RenderDocIntegration.html): GPU debugger for desktop and mobile platforms, focusing on frame-based API debugging.

**-** [Intel GPA](https://software.intel.com/content/www/us/en/develop/tools/graphics-performance-analyzers.html): Graphics profiling for Intel-based platforms

**-** [Apple Frame Capture Debugging Tools](https://developer.apple.com/documentation/metal/frame_capture_debugging_tools/): GPU debugging for Apple platforms

**-** [Visual Studio Graphics Diagnostics](https://docs.microsoft.com/en-gb/visualstudio/debugger/graphics/visual-studio-graphics-diagnostics?view=vs-2019&redirectedfrom=MSDN&viewFallbackFrom=vs-2015): Choose this and/or PIX for DirectX-based platforms such as Windows or Xbox

**-** [NVIDIA Nsight Frame Debugger](https://docs.nvidia.com/nsight-graphics/2018.4/content/nsight_graphics/frame_debugging.htm): OpenGL-based frame debugger for NVIDIA GPUs

**-** [AMD Radeon Developer Tool Suite](https://gpuopen.com/tools/): GPU profiler for AMD GPUs

**-** [Xcode frame debugger](https://docs.unity3d.com/6000.1/Documentation/Manual/XcodeFrameDebuggerIntegration.html): For iOS and macOS.

## More tips for Unity 6

You can find many more best practices and tips for advanced Unity developers and creators from the Unity best practices hub. Choose from over 30 guides, created by industry experts, and Unity engineers and technical artists, that will help you develop efficiently with Unity’s toolsets and systems.

<a href="https://unity.com/how-to" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[3.125rem] px-[2rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">More best practices<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>
