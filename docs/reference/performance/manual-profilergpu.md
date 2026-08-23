---
title: "GPU Usage Profiler module"
page_title: "Unity - Manual: GPU Usage Profiler module"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/ProfilerGPU.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/ProfilerGPU.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# GPU Usage Profiler module

The GPU Usage Profiler module displays where your application spends time in the GPU. You can only use the GPU Profiler in [Play mode](https://docs.unity3d.com/6000.3/Documentation/Manual/profiling-play-mode.html), or for builds of your application. You can’t use it to profile the Unity Editor.

By default, the GPU Usage Profiler module isn’t enabled. To enable it, refer to [Activating Profiler modules](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-modules-activate.html).

**Note:** If you have **Graphics Jobs** enabled in the **Player Settings**, GPU profiling isn’t supported. For more information, refer to the documentation on [Player Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PlayerSettings.html).

## GPU profiling support

The following table lists the platforms that the GPU Usage Profiler module supports:

<table><thead><tr class="header"><th style="text-align: left;"><strong>Platform</strong></th><th style="text-align: left;"><strong>Graphics API</strong></th><th style="text-align: left;"><strong>Status</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Android</strong></td><td style="text-align: left;">OpenGL</td><td style="text-align: left;">Supported on devices running NVIDIA or Intel GPUs.</td></tr><tr class="even"><td style="text-align: left;"><strong>Android</strong></td><td style="text-align: left;">Vulkan</td><td style="text-align: left;">Not supported</td></tr><tr class="odd"><td style="text-align: left;"><strong>iOS, tvOS</strong></td><td style="text-align: left;">Metal</td><td style="text-align: left;">Not supported. Use XCode’s GPU Frame Debugger UI instead.</td></tr><tr class="even"><td style="text-align: left;"><strong>Linux</strong></td><td style="text-align: left;">OpenGL core</td><td style="text-align: left;">Supported</td></tr><tr class="odd"><td style="text-align: left;"><strong>Linux</strong></td><td style="text-align: left;">Vulkan</td><td style="text-align: left;">Not supported</td></tr><tr class="even"><td style="text-align: left;"><strong>macOS</strong></td><td style="text-align: left;">OpenGL</td><td style="text-align: left;">Supported.<br />
<strong>Note:</strong> Apple has deprecated support of OpenGL.</td></tr><tr class="odd"><td style="text-align: left;"><strong>macOS</strong></td><td style="text-align: left;">Metal</td><td style="text-align: left;">Not supported. Use XCode’s GPU Frame Debugger UI instead.</td></tr><tr class="even"><td style="text-align: left;"><strong>Tizen</strong></td><td style="text-align: left;">OpenGL</td><td style="text-align: left;">Not supported.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Web</strong></td><td style="text-align: left;">All WebGL</td><td style="text-align: left;">Not supported</td></tr><tr class="even"><td style="text-align: left;"><strong>Windows</strong></td><td style="text-align: left;">DirectX 11, DirectX 12, OpenGL</td><td style="text-align: left;">Supported</td></tr><tr class="odd"><td style="text-align: left;"><strong>Windows</strong></td><td style="text-align: left;">Vulkan</td><td style="text-align: left;">Not supported</td></tr></tbody></table>

On Windows, Unity supports Play mode profiling in the Editor with Direct3D 11 and Direct3D 12 APIs only. This is convenient for quick profiling, because it means you don’t need to build the Player. However, the overhead of running the Unity Editor affects the Profiler, which might make the profiling results less accurate.

## Chart categories

The GPU Usage Profiler module’s chart has several different categories that you can use to investigate GPU timings:

| **Chart**             | **Description**                                                               |
|:----------------------|:------------------------------------------------------------------------------|
| **Opaque**            | Built-in rendering pipeline’s time to render opaque objects.                  |
| **Transparent**       | Built-in rendering pipeline’s time to render transparent objects.             |
| **Shadows/Depth**     | Built-in rendering pipeline’s time to render shadow maps.                     |
| **Deferred Geometry** | Built-in deferred rendering pipeline’s time to render geometry.               |
| **Deferred Lighting** | Built-in deferred rendering pipeline’s time to render lighting.               |
| **PostProcess**       | Built-in rendering pipeline’s time to process post processing effects.        |
| **Other**             | Rendering time to process other things such as Scriptable Rendering Pipelines |

## Module details pane

When you select the GPU Usage module, the details pane displays a breakdown of where the application spent time in the selected frame.

### Views dropdown

You can display the timing data as a hierarchical table. To change the table views, use the top-left dropdown in the details pane (set to Hierarchy by default). The views available are:

| **Value**         | **Description**                                                                                                                                                                                                                                                                                                                                                           |
|:------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Hierarchy**     | Groups the timing data by its internal hierarchical structure. This option displays the elements that your application called in a descending list format, ordered by the time spent by default. You can also order the information by the total amount of GPU time, or the number of calls. To change the column that orders the table, click the table column’s header. |
| **Raw Hierarchy** | Displays the timing data in a hierarchical structure that is similar to the call stacks where the timing occurred. Unity lists each call stack separately in this mode instead of merging them, as it does in Hierarchy view.                                                                                                                                             |

### Table statistics

The table views have the following columns:

| **Value**     | **Description**                                                                 |
|:--------------|:--------------------------------------------------------------------------------|
| **Total**     | The total amount of time Unity spent on a particular function, as a percentage. |
| **DrawCalls** | The number of calls made to this function in this frame.                        |
| **GPU ms**    | The total amount of time Unity spent on a particular function, in milliseconds. |

## Additional resources

-   [Activating Profiler modules](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-modules-activate.html)
-   [Connecting the Profiler to a data source](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-profiling-applications.html)
-   [Profiler window reference](https://docs.unity3d.com/6000.3/Documentation/Manual/ProfilerWindow.html)
