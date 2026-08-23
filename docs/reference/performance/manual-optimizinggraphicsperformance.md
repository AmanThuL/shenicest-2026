---
title: "Reduce rendering work on the CPU or GPU"
page_title: "Unity - Manual: Reduce rendering work on the CPU or GPU"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/OptimizingGraphicsPerformance.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/OptimizingGraphicsPerformance.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Reduce rendering work on the CPU or GPU

This page contains some simple guidelines for optimzing rendering performance in your application.

## Before you begin: locate and understand the problem

Before you make any changes, you must profile your application to identify the cause of the problem. If you attempt to solve a performance problem before you understand its cause, you might waste your time or make the problem worse. Additionally, rendering-related performance problems can occur on the CPU or the GPU. Strategies for fixing these problems are quite different, so it’s important to understand where your problem is before taking any action.

The following article on the Unity Learn site is a comprehensive introduction to graphics performance, and contains information on identifying and fixing problems: [Fixing performance problems](https://learn.unity.com/tutorial/fixing-performance-problems-2019-3). If you are not yet familiar with this subject, read the article before following any of the advice on this page.

<span id="CPU-optimization"></span>

## Reducing the CPU cost of rendering

Usually, the greatest contributor to CPU rendering time is the cost of sending rendering commands to the GPU. Rendering commands include draw calls (commands to draw geometry), and commands to change the settings on the GPU before drawing the geometry. If this is the case, consider these options:

-   You can reduce the number of objects that Unity renders.
    -   Consider reducing the overall number of objects in the scene: for example, use a [skybox](https://docs.unity3d.com/6000.3/Documentation/Manual/sky-landing.html) to create the effect of distant geometry.
    -   Perform more rigorous culling, so that Unity draws fewer objects. Consider using [occlusion culling](https://docs.unity3d.com/6000.3/Documentation/Manual/OcclusionCulling.html) to prevent Unity from drawing objects that are hidden behind other objects, reducing the far clip plane of a [Camera](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Camera.html) so that more distant objects fall outside its frustum, or, for a more fine-grained approach, putting objects into [separate layers](https://docs.unity3d.com/6000.3/Documentation/Manual/Layers.html) and setting up per-layer cull distances with [Camera.layerCullDistances](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Camera-layerCullDistances.html).
-   You can reduce the number of times that Unity renders each object.
    -   Use [lightmapping](https://docs.unity3d.com/6000.3/Documentation/Manual/Lightmappers.html) to “bake” (pre-compute) lighting and shadows where appropriate. This increases build time, runtime memory usage and storage space, but can improve runtime performance.
    -   If your application uses Forward rendering, reduce the number of per-pixel real-time lights that affect objects. For more information, see [Forward rendering path](https://docs.unity3d.com/6000.3/Documentation/Manual/RenderTech-ForwardRendering.html).
    -   Real-time shadows can be very resource-intensive, so use them sparingly and efficiently. For more information, see [Shadow troubleshooting: Shadow performance](https://docs.unity3d.com/6000.3/Documentation/Manual/ShadowPerformance.html).
    -   If your application uses Reflection Probes, ensure that you optimize their usage. For more information, see [Reflection Probe performance](https://docs.unity3d.com/6000.3/Documentation/Manual/RefProbePerformance.html)
-   You can reduce the amount of work that Unity must do to prepare and send rendering commands, usually by sending them to the GPU in more efficient “batches”. There are a few different ways to achieve this: for more information, see [Optimizing draw calls](https://docs.unity3d.com/6000.3/Documentation/Manual/optimizing-draw-calls.html).

Many of these approaches will also reduce the work required on the GPU; for example, reducing the overall number of objects that Unity renders in a frame will result in a reduced workload for both the CPU and the GPU.

## Reducing the GPU cost of rendering

There are three main reasons why the GPU might fail to complete its work in time to render a frame.

If an application is limited by fill rate, the GPU is trying to draw more pixels per frame than it can handle. If this is the case, consider these options:

-   Identify and reduce overdraw in your application. The most common contributors to overdraw are overlapping transparent elements, such as UI, particles and sprites. In the Unity Editor, use the [Overdraw Draw mode](https://docs.unity3d.com/6000.3/Documentation/Manual/overlays-reference-draw-modes.html) to identify areas where this is a problem.
-   Reduce the execution cost of fragment shaders. For information about shader performance, see the [Shader Performance](https://docs.unity3d.com/6000.3/Documentation/Manual/SL-ShaderPerformance.html) page.
-   If you’re using Unity’s built-in shaders, pick ones from the **Mobile** or **Unlit** categories. They work on non-mobile platforms as well, but are simplified and approximated versions of the more complex shaders.
-   [Dynamic Resolution](https://docs.unity3d.com/6000.3/Documentation/Manual/DynamicResolution-landing.html) is a Unity feature that allows you to dynamically scale individual render targets.

If an application is limited by memory bandwidth, the GPU is trying to read and write more data to its dedicated memory than it can handle in a frame. This usually means that that there are too many or textures, or that textures are too large. If this is the case, consider these options:

-   Enable [mipmaps](https://docs.unity3d.com/6000.3/Documentation/Manual/class-TextureImporter.html) for textures whose distance from the camera varies at runtime (for example, most textures used in a 3D scene). This increases memory usage and storage space for these textures, but can improve runtime GPU performance.
-   Use suitable [compression formats](https://docs.unity3d.com/6000.3/Documentation/Manual/class-TextureImporter.html) to decrease the size of your textures in memory. This can result in faster load times, a smaller memory footprint, and improved GPU rendering performance. Compressed textures only use a fraction of the memory bandwidth needed for uncompressed textures.

If an appliction is limited by vertex processing, this means that the GPU is trying to process more vertices than it can handle in a frame. If this is the case, consider these options:

-   Reduce the execution cost of vertex shaders. For information about shader performance, see the [Shader Performance](https://docs.unity3d.com/6000.3/Documentation/Manual/SL-ShaderPerformance.html) page.
-   Optimize your geometry: don’t use any more triangles than necessary, and try to keep the number of UV mapping seams and hard edges (doubled-up vertices) as low as possible. For more information, see [Creating models for optimal performance](https://docs.unity3d.com/6000.3/Documentation/Manual/ModelingOptimizedCharacters.html).
-   Use the [Level Of Detail](https://docs.unity3d.com/6000.3/Documentation/Manual/LevelOfDetail.html) system.

## Reducing the frequency of rendering

Sometimes, it might benefit your application to reduce the rendering frame rate. This doesn’t reduce the CPU or GPU cost of rendering a single frame, but it reduces the frequency with which Unity does so without affecting the frequency of other operations (such as script execution).

You can reduce the rendering frame rate for parts of your application, or for the whole application. Reducing the rendering frame rate to prevents unnecessary power usage, prolongs battery life, and prevent device temperature from rising to a point where the CPU frequency may be throttled. This is particularly useful on handheld devices.

If profiling reveals that rendering consumes a significant proportion of the resources for your application, consider which parts of your application might benefit from this. Common use cases include menus or pause screens, turn based games where the game is awaiting input, and applications where the content is mostly static, such as automotive UI.

To prevent input lag, you can temporarily increase the rendering frame rate for the duration of the input so that it still feels responsive.

To adjust the rendering frame rate, use the [OnDemandRendering](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.OnDemandRendering.html) API. The API works particularly well with [Adaptive Performance](https://docs.unity3d.com/6000.3/Documentation/Manual/adaptive-performance/adaptive-performance.html).

*Note:* VR applications don’t support On Demand Rendering. Not rendering every frame causes the visuals to be out of sync with head movement and might increase the risk of motion sickness.

## Additional resources

-   [Reduce rendering work on the GPU or CPU in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/reduce-rendering-work-on-cpu.html)
-   [Optimize for untethered XR devices in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/xr-untethered-device-optimization.html)
-   [Graphics rendering: Getting the best performance with Unity 6](https://www.youtube.com/watch?v=Oc6T4hh5gaI)
-   [Performance tips and tricks from a Unity consultant](https://www.youtube.com/watch?v=CmD8MVGkDxQ)
