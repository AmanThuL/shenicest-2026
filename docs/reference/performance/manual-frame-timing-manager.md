---
title: "Frame timing manager introduction"
page_title: "Unity - Manual: Frame timing manager introduction"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/frame-timing-manager.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/frame-timing-manager.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Frame timing manager introduction

You can use the [`FrameTimingManager` class](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/FrameTimingManager.html) to capture high level timing data about individual frame performance in an application. You can then use this data to assess whether your application meets performance targets.

You can use the `FrameTimingManager` class in the following situations:

-   You need to monitor performance at a frame-by-frame level.
-   Your application uses the [Dynamic Resolution](https://docs.unity3d.com/6000.3/Documentation/Manual/DynamicResolution-landing.html) feature.
-   Your application uses [Adaptive Performance](https://docs.unity3d.com/6000.3/Documentation/Manual/adaptive-performance/adaptive-performance.html).

Frame timings don’t replace data from the [Profiler](https://docs.unity3d.com/6000.3/Documentation/Manual/Profiler.html). After you record high level metrics of your application with `FrameTimingManager`, you can use the Profiler to then investigate specific details.

**Note:** `FrameTimingManager` might decrease GPU performance when it records data on OpenGL ES, so it can’t produce an accurate measurement of how your application performs.

To use the data you collect from `FrameTimingManager` refer to [Get frame timing data](https://docs.unity3d.com/6000.3/Documentation/Manual/frame-timing-manager-get-timing-data.html).

## FrameTimingManager data availability

`FrameTimingManager` provides results with a set delay of four frames. This is for the following reasons:

-   CPU timing results aren’t immediately available at the end of each frame.
-   Unity reads GPU timing results with three frames delay.

**Note:** The four frame delay doesn’t guarantee accurate timing results, because the GPU might not have any available resources to return the results, or might fail to return them correctly.

For a detailed description of available timings, refer to [Get frame timing data](https://docs.unity3d.com/6000.3/Documentation/Manual/frame-timing-manager-get-timing-data.html).

`FrameTimingManger` changes how it produces a `FrameTimeComplete` timestamp under the following circumstances:

-   If the GPU supports GPU timestamps, the GPU provides a `FrameTimeComplete` timestamp.
-   If the GPU doesn’t support GPU timestamps but returns a [GPU time](https://docs.unity3d.com/6000.3/Documentation/Manual/ProfilerHighlights.html#gpu-time), `FrameTimingManager` calculates a value for `gpuFrameTime`. The value is the sum of the reported GPU time and the `FirstSubmitTimestamp` values.
-   If the GPU doesn’t support GPU timestamps and doesn’t return GPU time, `FrameTimingManager` sets the value of `PresentTimestamp` as the value of `FrameTimeComplete`.

## Player pause behavior

`FrameTimingManager` automatically excludes the amount of time that `Application.Pause` pauses the applcation from CPU timing measurements. When the application resumes, the `cpuFrameTime` value for the first resumed frame reflects the actual frame work after resuming, not the time the application spent paused.

## Platform support

`FrameTimingManager` is supported on the following platforms and graphics APIs:

| **Platform** | **Graphics** | **Supported**                                                                                                                                                                           |
|:-------------|:-------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Android**  | OpenGL ES    | Yes                                                                                                                                                                                     |
| **Android**  | Vulkan       | Yes                                                                                                                                                                                     |
| **iOS**      | Metal        | Yes                                                                                                                                                                                     |
| **Linux**    | OpenGL       | Partial: [GPU Frame Time](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-counters-reference.html#rendering) measurement is unsupported.                                  |
| **Linux**    | Vulkan       | Yes                                                                                                                                                                                     |
| **macOS**    | Metal        | Yes                                                                                                                                                                                     |
| **tvOS**     | Metal        | Yes                                                                                                                                                                                     |
| **WebGL**    | WebGL        | Partial: [GPU Frame Time](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-counters-reference.html#rendering) measurement is unsupported.                                  |
| **Windows**  | DirectX 11   | Yes                                                                                                                                                                                     |
| **Windows**  | DirectX 12   | Yes                                                                                                                                                                                     |
| **Windows**  | OpenGL       | Yes                                                                                                                                                                                     |
| **Windows**  | Vulkan       | Yes                                                                                                                                                                                     |
| **XR**       | OpenGL ES    | Partial: [CPU Render Thread Frame Time and GPU Frame Time](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-counters-reference.html#rendering) measurement is unsupported. |
| **XR**       | Vulkan       | Partial: [CPU Render Thread Frame Time and GPU Frame Time](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-counters-reference.html#rendering) measurement is unsupported. |

### Compatibility with tile-based deferred rendering GPUs

For GPUs that use tile-based deferred rendering architecture, such as Metal GPUs in Apple devices, the reported GPU time might be larger than the reported frame time.

This can happen when the GPU is under heavy load, or when the GPU pipeline is full. In these cases, the GPU might defer execution of some rendering phases. Because `FrameTimingManager` measures the time between the beginning and end of the frame rendering, any gaps between phases increase the reported GPU time.

In the following example, no GPU resources are available, because the GPU passes a job from the vertex queue to the fragment queue. The GPU’s graphics API therefore defers the execution of the next phase. When this happens, the GPU time measurement includes phase work time and any gap in between. The result is that `FrameTimingManager` reports a higher GPU time measurement than expected.

![Diagram showing how the discrepancy in reported GPU time can happen in the Metal API](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/frame-timing-manager-deferred-rendering-diagram.png)

## Additional resources

-   [`FrameTimingManager` API](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/FrameTimingManager.html)
-   [Profiler overview](https://docs.unity3d.com/6000.3/Documentation/Manual/Profiler.html)
-   [Dynamic resolution](https://docs.unity3d.com/6000.3/Documentation/Manual/DynamicResolution-landing.html)
-   [`FrameTiming` API](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/FrameTiming.html)
