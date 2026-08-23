---
title: "Memory Management in Unity (Unity Learn)"
page_title: "Memory Management in Unity"
source_url: "https://learn.unity.com/tutorial/memory-management-in-unity"
final_url: "https://learn.unity.com/tutorial/memory-management-in-unity"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Memory Management in Unity

![](https://learn.unity.com/_next/static/media/tutorial-coverImage-bg.8fcd34a7.jpeg)

# Memory Management in Unity

Tutorial

advanced

+10XP

1h

174

\(55\)

Unity Technologies

![Memory Management in Unity](https://connect-mediagw.unity.com/h1/20190130/9dc3f46a-8502-4786-aeb1-5a2266d0bcae_memory_management_in_unity_0.png)

Summary

Proper memory management in Unity can be challenging. The goal of this guide is to fit you with the necessary knowledge to profile and optimize memory consumption on any publicly available platform.

Languages available:

EnglishEnglish

<span id="react-aria-«R1ahmpmH7»">English</span><span class="pl-2"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 1. Overview

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Proper memory management in Unity can be challenging. You need to consider the nuances of automatic memory management, understand the difference between native and managed memory, and how memory behaves on different platforms. The goal of this guide is to fit you with the necessary knowledge to profile and optimize memory consumption on any publicly available platform.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 2. Important documentation

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Understanding the managed heap is essential for memory management in Unity. For more information on profiling managed memory and how to optimize memory, see the <a href="https://docs.unity3d.com/Manual/BestPracticeUnderstandingPerformanceInUnity4-1.html" class="link-primary text-inherit">Managed memory section</a> under <a href="https://docs.unity3d.com/Manual/BestPracticeUnderstandingPerformanceInUnity.html" class="link-primary text-inherit"><strong><span style="text-decoration:underline">Understanding Optimization</span></strong></a> in the Unity Manual.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 3. Assets

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Assets cause native memory and managed memory implications during runtime. The Unity runtime engine doesn't return managed memory to the operating system for reuse until the user terminates the application. The managed heap grows if it becomes too fragmented, and then runs out of available memory. Due to this unpredictable behavior, it is critical to know how assets occupy managed memory:

-   Use **Destroy(myObject)** to destroy an <a href="https://docs.unity3d.com/ScriptReference/Object.Destroy.html" class="link-primary text-inherit">Object</a> and release its memory. Setting a reference to an Object to null does **not** destroy it.
-   Set persistent (long-term) objects as classes and ephemeral (short-term) objects as structs. Structs are not allocated on the heap and thus not garbage-collected.
-   Reuse temporary work buffers to keep temporary garbage low, instead of allocating frequently.
-   Remember that an Enumerator does not clean up its memory until it exits.

Avoid <a href="https://docs.unity3d.com/Manual/BestPracticeUnderstandingPerformanceInUnity3.html" class="link-primary text-inherit">never-ending coroutines</a>, especially when allocating large amounts of managed memory, because coroutines hold onto stack allocations on the heap until they end.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 4. Scripting backends

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

On iOS and Android**,** choose between the **Mono** or **IL2CPP** scripting backends in Player Settings. To change the Scripting Backend, go to the **Player Settings** window (**Edit** \> **Project Settings** \> **Player**), scroll down to the **Other Settings** section, and select either **Mono** or **IL2CPP** from the **Scripting Backend** dropdown menu.

**Note**: As of 2017.3, choose either the <a href="https://docs.unity3d.com/Manual/IL2CPP.html" class="link-primary text-inherit"><strong>IL2CPP</strong></a> Scripting Backend or the **Mono** scripting backend. However, both WebGL and UWP only support IL2CPP. iOS still supports the Mono Scripting Backend for fast iteration, but you cannot submit Mono (32-bit) applications to Apple anymore.

### Benefits and drawbacks of different scripting backends

Each scripting backend has benefits and drawbacks that should influence your decision on which is the right choice for your situation:

IL2CPP

-   Code generation is heavily improved compared to Mono.
-   Debugging script code in C++ from top to bottom is possible.
-   You can enable <a href="https://unity3d.com/learn/tutorials/topics/best-practices/il2cpp-mono#Code%20stripping%20in%20Unity" class="link-primary text-inherit">Engine code stripping</a> to reduce code size.
-   Build times are longer than with Mono.
-   IL2CPP only supports <a href="https://docs.unity3d.com/Manual/ScriptingRestrictions.html" class="link-primary text-inherit"><strong>Ahead of Time</strong> (AOT)</a> compilation.

Mono

-   Faster build times than IL2CPP.
-   Supports more managed libraries due to **Just In Time compilation** (JIT).
-   Supports runtime code execution.
-   Must ship managed assemblies (.dll files that mono or .net produces).

**Tip:** Use IL2CPP to both develop and ship your project. If iteration times end up being too slow using IL2CPP, switch temporarily to the Mono scripting backend during development to improve iteration speed.

**Note**: The default target architectures in the Player Settings are optimized for **release builds**. Using this default during development increases your build time because Unity builds the binary for each target architecture selected, as follows:

-   The default **Target Architecture** in the Android Player Settings are armv7 **and** x86 with the IL2CPP **and** Mono scripting backends.

The default **Architecture** in the iOS Player Settings are armv7 **and** arm64 with the IL2CPP scripting backend.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 5. Code stripping in Unity

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Code size has a direct influence on disk space and runtime memory. It’s important to note that Unity removes any code paths you aren’t using from the code base. Unity strips code automatically during a build, working on two different levels:

-   Managed code stripping
-   Native code stripping

### Managed code stripping

Unity strips managed code at the <a href="https://docs.unity3d.com/ScriptReference/StrippingLevel.StripAssemblies.html" class="link-primary text-inherit">method level</a>. To change the stripping level, go to the **Player Settings** window, scroll down to the **Other Settings** section, locate the **Managed Stripping Level** dropdown menu and select **Strip Assemblies** .

The UnityLinker removes unused types (classes, structs, etc.) from the <a href="https://en.wikipedia.org/wiki/Common_Intermediate_Language" class="link-primary text-inherit">Intermediate Language</a> (IL). Even if you use a type, the UnityLinker removes the type’s unused methods.

**Note**: Although this functionality is optional on builds using the Mono Scripting Backend, it is always enabled on builds using the IL2CPP Scripting Backend.

### Native code stripping

Unity enables **Strip Engine Code** by default in the **Player Settings** and enables native code stripping. Enable **Strip Engine Code** to remove unused modules and classes in the native Unity engine code. Disable **Strip Engine Code** to preserve all of the modules and classes in the native Unity engine code.

**Note:** For publically available platforms, native code stripping is only supported on iOS, WebGL, and Android.

Unity 2017.3 onwards supports native code stripping on Android; in prior versions, the Unity Android runtime shipped as a pre-linked *.*so library, which Unity could not strip. The Android runtime shipped in 2017.3 is a static engine code library, allowing for native code stripping. The final link happens during the build, which is ultimately what accounts for the slightly longer build times.

### Unity Module Stripping

**Note**: WebGL is currently the only platform which supports stripping unused Unity modules.

Unity makes the best attempt to eliminate all unused Unity modules. This means if any scene or script references a component from a Unity module that you include in the build, Unity doesn't strip the module. Unity doesn’t strip core modules, such as Camera, AssetBundle, Halo, etc.

#### **Stripping modules from an empty project on WebGL**

Removing modules saves a substantial amount of memory. For example, one of the largest modules in Unity is the Physics module, which accounts for about 5MB of gzipped ASM.js code. If you remove the Physics module from an empty project it reduces the build size from 17MB to 12MB.

### C# Code Stripping

The UnityLinker works on a basic mark and sweep principle, similar to a garbage collector. The UnityLinker builds a map of each type and method included in each assembly from a build. The UnityLinker marks a number of types and methods as *"*roots" and the UnityLinker then walks the graph of dependencies between types and methods.

If, for example, one type’s method calls a method on another type, then the UnityLinker marks the called type and method as in-use. Once the UnityLinker marks all the roots’ dependencies, the system reweaves the assemblies, omitting methods or entire types that are not marked as used.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 6. Roots

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

The UnityLinker marks its internal classes as roots if they’ve been used in a scene or from content in Resources. Similarly, the UnityLinker marks all types and methods in the user assemblies as roots.

If you use types and methods from other assemblies directly in a scene or in an asset you include in Resources, Unity marks these as roots.

Use the <a href="https://docs.unity3d.com/Manual/IL2CPP-BytecodeStripping.html" class="link-primary text-inherit">link.xml</a> file to mark additional types and methods as roots. If your project uses AssetBundles, use the <a href="https://docs.unity3d.com/ScriptReference/BuildPlayerOptions-assetBundleManifestPath.html" class="link-primary text-inherit">BuildPlayerOption.assetBundleManifestPath</a> to mark additional types and methods as roots.

#### User Assemblies

User Assemblies are the assemblies Unity generates from loose code within the Assets folder. Unity places most of the C# code in **Assembly-CSharp.dll**; whereas Unity places code in **/Assets/Standard Assets/** or **/Assets/Plugins/** in **Assembly-CSharp-firstpass.dll**, which is also considered a user assembly.

If a significant proportion of a codebase’s types or methods are unused, you could save some binary size and build time by migrating stable code into pre-built assemblies and allowing the UnityLinker to strip them. Use <a href="https://unity3d.com/learn/tutorials/topics/best-practices/il2cpp-mono#Assembly%20Definition%20Files" class="link-primary text-inherit">Assembly Definition Files</a> to migrate stable code into pre-built assemblies.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 7. Generic Sharing

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

For reference types, IL2CPP generates the implementation (C++ code) which can be shared between Generics using reference types. However, IL2CPP doesn't share value types because IL2CPP needs to generate the code for each of the types separately. This results in your code size increasing.

In general, there should not be any noticeable performance difference, but it depends on the specific situation and what it should be optimized for. Classes are usually on the heap while structs are on the stack (with some exceptions, such as in the case of coroutines). For memory performance and usage, this matters. Using non-reference types leads to other problems. You must copy function parameters using value types to influence performance. For additional information see this <a href="https://blogs.unity3d.com/2015/06/16/il2cpp-internals-generic-sharing-implementation/" class="link-primary text-inherit"></a> blog post: <a href="https://blog.unity.com/engine-platform/il2cpp-full-generic-sharing-in-unity-2022-1-beta" class="link-primary text-inherit"><strong><span style="text-decoration:underline">Feature preview: IL2CPP Full Generic Sharing in Unity 2022.1 beta</span></strong></a>.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 8. Assembly Definition Files

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

<a href="https://blogs.unity3d.com/2017/11/22/unity-2017-3b-feature-preview-assembly-definition-files-and-transform-tool/" class="link-primary text-inherit">Assembly Definition Files</a> allow you to define custom managed assemblies and assign user scripts to them on a per-folder basis. In turn, this results in faster iteration times, because Unity will only build those assemblies actually affected by script changes.

**Note**: While multiple assemblies do grant modularity, they also increase the application’s binary size and runtime memory. Tests show that the executable can grow by up to 4kB per assembly.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 9. Build Report

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

<a href="https://docs.unity3d.com/ScriptReference/Build.Reporting.BuildReport.html" class="link-primary text-inherit"><span style="text-decoration:underline">Build Report</span></a> is an API which is included in Unity but has no UI. Building a project generates a **buildreport** file that shows you what is stripped and why it was stripped from the final executable.

To preview the stripping information:

-   Build your project.
-   Leave the Editor open.
-   Connect to <http://files.unity3d.com/build-report/>.

**Note:** You may need to<a href="https://docs.unity3d.com/Manual/class-PackageManager.html" class="link-primary text-inherit"><span style="text-decoration:underline"> enable preview packages</span></a> to find this tool in the Package Manager.

The Build Report tool connects to your running Unity Editor, downloads and presents the breakdown of the build report.

It’s possible to use the **binary2text** tool on the generated file in **Library/LatestBuild.buildreport** to view data from the report. <a href="https://support.unity3d.com/hc/en-us/articles/217123266-How-do-I-determine-what-is-in-my-Scene-bundle-" class="link-primary text-inherit">Binary2text</a> is shipped with Unity under **Unity.app/Contents/Tools/** on Mac or **Unity/Editor/Data/Tools/** on Windows.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 10. Native memory

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Native memory is a key component when optimizing applications, because most of the engine code is in resident memory. When you integrate code in native plugins you can control it directly, but it isn't always possible to control and optimize the native memory consumption from Unity internal systems. Internal systems use different buffers and resources, and it may not always be apparent how that influences memory consumption. This step details Unity internal systems and explains memory data you often see in a native profiler.

Unity uses many different native allocators and buffers. Some are persistent, such as the constant buffer, while others are dynamic, such as the back buffer. The following subsections describe buffers and their behavior.

### Scratchpad

Unity stores constants in a 4MB buffer pool and cycles through the pool between frames. The pool is bound to the GPU for the duration of its lifetime and shows up in frame capture tools such as XCode or Snapdragon.

![](https://connect-mediagw.unity.com/h1/20230703/learn/images/3a91d76d-4279-4db6-8de9-257ee45fc3bf_image.png)

### Block allocator

Unity uses block allocators in some internal systems. There is memory and CPU overhead anytime Unity needs to allocate a new page block of memory. Usually, the block size of the page is large enough that the allocation only appears the first time Unity uses a system. After the first allocation, the page block is reused. There are small differences in how internal systems use the block allocator.

### AssetBundles

The first time you load an AssetBundle, additional CPU and memory overhead is required as the block allocators spin up, allowing the Asset Bundle system to allocate the first page block of memory.

Unity reuses the pages that the AssetBundle system allocates, but if you want to load many AssetBundles at once, you may have to allocate a second or third block. All of these stay allocated until the application terminates.

### Resources

Resources use a block allocator shared with other systems, so there is no CPU or memory overhead when loading an asset from Resources for the first time (since it already happened earlier during startup).

### Ring buffer

Unity uses a ring buffer to push textures to the GPU. You can adjust this async texture buffer via <a href="https://docs.unity3d.com/ScriptReference/QualitySettings-asyncUploadBufferSize.html" class="link-primary text-inherit">QualitySettings.asyncUploadBufferSize</a>.

**Note**: You cannot return ring buffer memory to the system after Unity allocates it.

### Assets

Assets cause native and managed memory implications during runtime. Beyond managed memory, Unity returns native memory to the operating system when it's no longer needed. Since every byte counts — especially on mobile devices — you can try the following to reduce native runtime memory:

-   Remove unused channels from meshes.
-   Remove redundant keyframes from animations.
-   Use <a href="https://docs.unity3d.com/Manual/class-QualitySettings.html" class="link-primary text-inherit">maxLOD</a> in the **Quality Settings** to remove higher detail meshes in <a href="https://docs.unity3d.com/Manual/LevelOfDetail.html" class="link-primary text-inherit">LODGroups</a> from the build.
-   Check the <a href="https://docs.unity3d.com/Manual/LogFiles.html" class="link-primary text-inherit"><strong>Editor.log</strong></a> after a build to ensure that the size of each Asset on disk is proportional to its runtime memory use.
-   Reduce memory uploaded to GPU memory by using the **Texture Quality** setting in the **Rendering** section of the **Quality Settings** to force lower texture resolutions via mipmaps.
-   Normal maps need not be the same size as diffuse maps (1:1), so you can use a smaller resolution for normal maps while still achieving high visual fidelity and saving memory and disk space.

Be aware that managed memory implications can often surpass native memory problems, due to heavy fragmentation of the managed heap.

### Cloned Materials

Beware of cloned materials, because accessing the material property of any renderer causes the material to be cloned even if nothing is assigned. This cloned material will not be garbage collected and will only be cleared up when you change scenes or call <a href="https://docs.unity3d.com/ScriptReference/Resources.UnloadUnusedAssets.html" class="link-primary text-inherit"><strong>Resources.UnloadUnusedAssets()</strong></a>. You can use **customRenderer.sharedMaterial** if you want to access a read-only material.

### Unloading Scenes

Call <a href="https://docs.unity3d.com/ScriptReference/SceneManagement.SceneManager.UnloadSceneAsync.html" class="link-primary text-inherit"><strong>UnloadScene()</strong></a> to destroy and unload the GameObjects associated with a Scene.

**Note**: This does not unload the associated assets. In order to unload the Assets and free both managed and native memory, call <a href="https://docs.unity3d.com/ScriptReference/Resources.UnloadUnusedAssets.html" class="link-primary text-inherit">Resources.UnloadUnusedAssets()</a> after the scene has been unloaded.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 11. Audio

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

### Virtual Voices

Unity dynamically sets voices as either virtual or real, depending on the <a href="https://www.fmod.com/docs/api/content/generated/overview/virtualvoices.html" class="link-primary text-inherit">real time audibility</a> of the platform. For example, Unity sets sounds that are playing far off or with a low volume as virtual, but will change these sounds to a real voice if they come closer or become louder. The default values in the <a href="https://docs.unity3d.com/Manual/class-AudioManager.html" class="link-primary text-inherit">Audio Settings</a> are great values for mobile devices.

### DSP Buffer Size

Unity uses the DSP buffer sizes to control the <a href="https://www.fmod.com/docs/api/content/generated/FMOD_System_SetDSPBufferSize.html" class="link-primary text-inherit">mixer latency</a>. The underlying Audio System <a href="https://www.fmod.com/" class="link-primary text-inherit">FMOD</a> defines the platform dependent DSP buffer sizes. The buffer size influences the latency and should be treated carefully. Latency equals the samples multiplied by the number of buffers. The number of buffers <a href="https://www.fmod.com/docs/api/content/generated/FMOD_System_SetDSPBufferSize.html" class="link-primary text-inherit">defaults</a> to 4. The audio system in Unity uses the following sample counts for the Audio Settings in Unity:

-   Default:
    -   iOS and Desktop: 1024
    -   Android: 512
-   Best latency: 256
-   Good latency: 512
-   Best performance: 1024

### Audio Import Settings

Using the correct settings can save runtime memory and CPU performance.

-   Enable **Force to mono** option on audio files if they do not require stereo sound. Doing so will reduce runtime memory and disk space. This is mostly used on mobile platforms with a mono speaker.
-   Larger AudioClips should be set to **Streaming**. Streaming in Unity 5.0 and later has a <a href="https://docs.unity3d.com/Manual/class-AudioClip.html" class="link-primary text-inherit">200KB overhead</a> so you should set audio files smaller than 200KB to **Compressed into Memory** instead.
-   For longer clips, import AudioClips as **Compressed into Memory** to save runtime memory (if the clips are not set to Streaming).
-   Use **Decompress On Load** only if you have plenty of memory but are constrained by CPU performance, as this option requires <a href="https://docs.unity3d.com/Manual/class-AudioClip.html" class="link-primary text-inherit">a significant amount of memory</a>.

Various platforms also have preferred **Compression Format** settings to save runtime memory and disk space. To adjust these settings, follow these instructions:

**1**. Set **Compression Format** to **ADPCM** for very short clips such as sound effects which are played often. ADPCM offers a fixed 3.5:1 compression ratio and is inexpensive to decompress.

**2**. Use **Vorbis** on **Android** for longer clips. Unity does not use hardware accelerated decoding.

**3**. Use **MP3** or Vorbis on **iOS** for longer clips. Unity does not use hardware accelerated decoding.

**4**. MP3 or Vorbis need more resources for decompression but offer significantly smaller file size. High-quality MP3s require fewer resources for decompression, while middle- and low-quality files of either format require almost the same CPU time for decompression.

**Tip**: Use **Vorbis** for longer looping sounds since it handles looping better. MP3 contains data blocks of predetermined sizes, so if the loop is not an exact multiple of the block size then the MP3 encoding will add silence while Vorbis does not.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 12. Android Memory Management

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Memory on Android is shared across multiple processes. How much memory a process uses is not clear at first glance. Android memory management is complex. To learn more, refer to this talk on <a href="https://www.youtube.com/watch?v=w7K0jio8afM" class="link-primary text-inherit">Understanding Android memory usage from Google I/O</a> before reading on.

### Paging on Android

<a href="https://en.wikipedia.org/wiki/Paging" class="link-primary text-inherit">Paging</a> is a method of moving memory from main memory to secondary memory or vice versa.

Android pages out to disk but does not use swap space for paging the memory. This makes it even more difficult to see the total memory, especially as every application in Android runs in a different process which runs its own instance of a Dalvik VM.

#### **Paging vs. swap space**

Android uses paging but does not utilize swap space. Paging relies heavily on the ability to memory map (**mmap()**) files and store the kernel page in data as needed. Although this doesn’t happen often, paging needs to drop kernel pages when memory is low and the system drops cache page files. Android does not swap spaces for paging out dirty pages, as doing so on mobile devices both lowers battery life and causes excess wear-and-tear on memory.

#### **Onboard flash**

Android devices frequently come with very little onboard flash and limited space to store data. Onboard flash is mainly used to store apps but could actually store a swap file. Onboard flash is slow and has generally worse access rates than those of hard disks or flash drives.

Onboard flash's size is not enough to enable swapping spaces effectively. A basic rule of thumb for swap file size is about 512MB per 1-2GB RAM. You can always enable swap support by modifying the kernel .config file (CONFIG_SWAP) and compiling the kernel yourself, but doing so falls outside the scope of this guide.

### Memory Consumption Limitations

Just how much memory can your app use before the <a href="https://developer.android.com/guide/components/activities/process-lifecycle" class="link-primary text-inherit">Android system</a> activates and starts shutting down processes? Unfortunately, there is no simple answer, and figuring it out involves a lot of profiling with tools such as dumpsys, procrank, and Android Studio.

Many different factors can influence your ability to measure memory consumption on Android, such as the following:

-   Different platform configuration for low-, mid-, and high-end devices
-   Different OS versions on the test device(s)
-   Different points in your application when you measure memory
-   Overall device memory pressure

It is important to always measure your memory at the same location in your code with the same platform configuration, OS version, and device memory pressure.

#### **Low and high memory pressure**

A good way to profile memory is to ensure that the device has plenty of free memory available (low memory pressure) while you profile the memory consumption of your application. If the device has no free memory available (high memory pressure) it can be difficult to get stable results. It’s important to keep in mind that although you use profiling to try to find the source of high memory pressure, there are still hard physical limitations. If the system is already thrashing memory caches, it will produce unstable results during memory profiling your app.

### Dumpsys

If you were to sum up all physical RAM mapped to each process, then add up all of the processes, the resulting figure would be greater than the actual total RAM. With **dumpsys***,* you can get clearer information about each Java process. The stats dumpsys provides contain a variety of information related to the apps’ memory. **dumpsys** is an Android tool that runs on the device and dumps information about the status of system services and applications. dumpsys enables you to easily access system information.

-   Get system information in a simple string representation.
-   Use dumped CPU, RAM, battery, and storage to check how an application affects the overall device.

The following command lists all services offered by dumpsys:

*\~$ adb shell dumpsys \| grep "dumpsys services"*

You can use **dumpsys meminfo** to dump system memory on Android.

#### dumpsys meminfo

adb provides a host of tools to gain information about the memory of a running application on Android. The most common and quickest way to get an overview is the **adb shell dumpsys meminfo** command. It reports detailed information about the memory usage of each Java process, native heap, binary data as well as a variety of process and system information. The following command will provide a quick overview of system memory:

*\~$ adb shell dumpsys meminfo*

It’s possible to track a single process via **name**, **bundle ID** or **pid** to determine the details of the Unity **androidtest** app as the following command shows. The androidtest app is an empty Unity Project with only one main Scene, no Skybox, and no content, to get a baseline for memory measurements.

*\~$ adb shell dumpsys meminfo com.unity.amemorytest*

This prints the following information in the command line using a Nexus 6P (2560 by 1440 px - Android 8.1.0 and Unity 2018.1).

```
* Applications Memory Usage (in Kilobytes):  
* Uptime: 6815563691 Realtime: 10882940478  
*   
* ** MEMINFO in pid 20676 [com.unity.androidtest] **  
*                    Pss  Private  Private  SwapPss     Heap     Heap     Heap  
*                  Total    Dirty    Clean    Dirty     Size    Alloc     Free  
*                 ------   ------   ------   ------   ------   ------   ------  
*   Native Heap    31467    31448        0        0    51072    47261     3810  
*   Dalvik Heap     1872     1760        0        0    12168     7301     4867  
*  Dalvik Other      470      460        0        0                             
*         Stack      492      492        0        2                             
*        Ashmem        8        0        0        0                             
*       Gfx dev     3846     2036        0        0                             
*     Other dev        4        0        4        0                             
*      .so mmap    17760      516    15908      161                             
*     .jar mmap        4        0        4        0                             
*     .apk mmap      243        0        0        0                             
*     .dex mmap      116        4      112        0                             
*     .oat mmap     6206        0     3244        0                             
*     .art mmap     2571      716      232       22                             
*    Other mmap       49        4        0        2                             
*    EGL mtrack    99840    99840        0        0                             
*     GL mtrack    64480    64480        0        0                             
*       Unknown     1270     1264        0       14                             
*         TOTAL   230899   203020    19504      201    63240    54562     8677  
*    
*  App Summary  
*                        Pss(KB)  
*                         ------  
*            Java Heap:     2708  
*          Native Heap:    31448  
*                 Code:    19788  
*                Stack:      492  
*             Graphics:   166356  
*        Private Other:     1732  
*               System:     8375  
*    
*                TOTAL:   230899       TOTAL SWAP PSS:      201  
*    
*  Objects  
*                Views:        7         ViewRootImpl:        1  
*          AppContexts:        2           Activities:        1  
*               Assets:        2        AssetManagers:        2  
*        Local Binders:       16        Proxy Binders:       21  
*        Parcel memory:        5         Parcel count:       23  
*     Death Recipients:        1      OpenSSL Sockets:        2  
*             WebViews:        0  
*    
*  SQL  
*          MEMORY_USED:        0  
*   PAGECACHE_OVERFLOW:        0          MALLOC_SIZE:        0  
*
```

In contrast, executing the same command using an application featuring a full 3D Scene and a significantly higher amount of content prints the following information:

```
* Applications Memory Usage (in Kilobytes):  
* Uptime: 6823482422 Realtime: 10890859209  
*   
* ** MEMINFO in pid 22903 [com.unity3d.androidtest] **  
*                    Pss  Private  Private  SwapPss     Heap     Heap     Heap  
*                  Total    Dirty    Clean    Dirty     Size    Alloc     Free  
*                 ------   ------   ------   ------   ------   ------   ------  
*   Native Heap   304918   304900        0        0   327552   315885    11666  
*   Dalvik Heap     1240     1096        0        0    11858     7127     4731  
*  Dalvik Other      424      412        0        0                             
*         Stack      528      528        0        1                             
*        Ashmem        6        0        0        0                             
*       Gfx dev   196934   132128        0        0                             
*     Other dev        4        0        4        0                             
*      .so mmap    23976      668    21920      199                             
*     .apk mmap      368        0        0        0                             
*     .dex mmap      116        4      112        0                             
*     .oat mmap     6060        0     3768        0                             
*     .art mmap     2774      604      332       25                             
*    Other mmap       44        4        0        2                             
*    EGL mtrack    21600    21600        0        0                             
*     GL mtrack   384184   384184        0        0                             
*       Unknown     6577     6568        0       17                             
*         TOTAL   949997   852696    26136      244   339410   323012    16397  
*    
*  App Summary  
*                        Pss(KB)  
*                         ------  
*            Java Heap:     2032  
*          Native Heap:   304900  
*                 Code:    26472  
*                Stack:      528  
*             Graphics:   537912  
*        Private Other:     6988  
*               System:    71165  
*    
*                TOTAL:   949997       TOTAL SWAP PSS:      244  
*    
*  Objects  
*                Views:        7         ViewRootImpl:        1  
*          AppContexts:        3           Activities:        1  
*               Assets:        2        AssetManagers:        2  
*        Local Binders:       15        Proxy Binders:       20  
*        Parcel memory:        3         Parcel count:       14  
*     Death Recipients:        0      OpenSSL Sockets:        0  
*             WebViews:        0  
*    
*  SQL  
*          MEMORY_USED:        0  
*   PAGECACHE_OVERFLOW:        0          MALLOC_SIZE:        0  
*
```

The following table compares the results and describes the detailed stats:

#### **procrank**

One alternative to dumpsys is **procrank***,* another useful tool that you can use to view memory usage across all processes. It lists the memory usage of processes in order from highest to lowest usage. The sizes reported per process are Vss, Rss, Pss, and Uss.

*\~$ adb shell procrank*

```
* PID      Vss      Rss      Pss      Uss  cmdline 
*  890   84456K   48668K   25850K   21284K  system_server 
* 1231   50748K   39088K   17587K   13792K  com.android.launcher2 
*  947   34488K   28528K   10834K    9308K  com.android.wallpaper 
*  987   26964K   26956K    8751K    7308K  com.google.process.gapps 
*  954   24300K   24296K    6249K    4824K  com.unity.androidmemory 
*  888   25728K   25724K    5774K    3668K  zygote 
*  977   24100K   24096K    5667K    4340K  android.process.acore
```

-   Vss - Virtual set size is the total accessible address space of a process. It shows how much virtual memory is associated with a process.
-   Rss - Resident Set Size is how many physical pages are allocated to the process. Pages shared between processes are counted multiple times.
-   Pss - Proportional Set Size takes the Rss number but evenly distributes shared pages among the sharing processes. For example, if three processes are sharing 9MB, each process gets 3MB in Pss.
-   Uss - Unique Set Size is also known as Private Dirty, which is basically the amount of RAM inside the process that cannot be paged to disk as it is not backed by the same data on disk, and is not shared with any other processes.

**Note:** Pss and Uss are different than reports of *meminfo*. Procrank uses a different kernel mechanism to collect its data than meminfo which can give different results.

#### meminfo

The meminfo command gives a summary of the overall memory usage of the system:

*\~$ adb shell cat /proc/meminfo*

The first couple of numbers are worth discussing.

```
* MemTotal:        2866492 kB  
* MemFree:          244944 kB  
* Buffers:           36616 kB  
* Cached:           937700 kB  
* SwapCached:        13744 kB
```

-   MemTotal is the total amount of memory available to the kernel and userspace which is usually less than actual physical RAM as the handset requires memory for GSM, buffers, etc. as well.
-   MemFree is the amount of RAM that is not being used at all. On Android the number would typically be very small as the system tries to always use all available memory to keep processes running.
-   Cached is the RAM being used for filesystem caches etc.

For additional information please also read the <a href="https://developer.android.com/studio/profile/investigate-ram.html" class="link-primary text-inherit">RAM investigation page</a> and <a href="https://developer.android.com/topic/performance/memory.html" class="link-primary text-inherit">Android performance guides</a>.

### Android Studio

Android Studio offers a memory profiler in addition to the command line tools available in the Android SDK. Similar to the command line tools reporting there is a split between managed and native memory.

![](https://connect-mediagw.unity.com/h1/20190130/9e72006d-5dc8-4e04-9c56-1a56141fcaf9_memory_management_in_unity_1.png)

In this case, the table compares the empty Project from the <a href="https://unity3d.com/learn/tutorials/topics/best-practices/android-memory-management#dumpsys%20meminfo" class="link-primary text-inherit">dumpsys meminfo</a> section with the data from Android Studio. It basically covers the App Summary displayed from dumpsys meminfo with some additions.

### Plugins

Usually, most of the memory goes into the Native Heap section. The Dalvik Heap is small compared to the Native Heap section. In case it grows, you should investigate the Android plugins you use in your application. The Native Heap makes it difficult to know where memory comes from and there is no great way to see Native Plugin allocations in the profiler. A possible solution to gain a greater insight is to isolate and measure the plugins used for 3rd party integrations and compare them with the memory baseline of an empty Project.

### Application Size

One way you can save disk space and runtime memory is to reduce the size of your .apk on Android or .ipa on iOS. Resources and code are directly proportional to runtime memory and if you can reduce them, you can save runtime memory. Please read <a href="https://unity3d.com/learn/tutorials/topics/best-practices/il2cpp-mono#Code%20stripping%20in%20Unity" class="link-primary text-inherit">Code stripping in Unity</a> to learn more about reducing code size and read <a href="https://support.unity3d.com/hc/en-us/articles/208412186-IL2CPP-build-size-optimizations" class="link-primary text-inherit"></a> the knowledge base article <a href="https://support.unity.com/hc/en-us/articles/208412186-IL2CPP-build-size-optimizations" class="link-primary text-inherit"><strong><span style="text-decoration:underline">IL2CPP build size optimizations</span></strong></a> if you want to understand the details of IL2CPP optimization on iOS.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

## Complete this Tutorial

Mark all steps complete
