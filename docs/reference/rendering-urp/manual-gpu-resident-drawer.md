---
title: "Enable the GPU Resident Drawer in URP"
page_title: "Unity - Manual: Enable the GPU Resident Drawer in URP"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/gpu-resident-drawer.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/gpu-resident-drawer.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Enable the GPU Resident Drawer in URP

The GPU Resident Drawer automatically uses the [`BatchRendererGroup`](https://docs.unity3d.com/Manual/batch-renderer-group.html) API to draw GameObjects with GPU instancing, which reduces the number of draw calls and frees CPU processing time. For more information, refer to [How BatchRendererGroup works](https://docs.unity3d.com/Manual/batch-renderer-group-how.html).

The GPU Resident Drawer works only with the following:

-   The [Forward+](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering/forward-rendering-paths.html) rendering path.
-   [Graphics APIs](https://docs.unity3d.com/6000.0/Documentation/Manual/GraphicsAPIs.html) and platforms that support compute shaders, except OpenGL ES.
-   GameObjects that have a [Mesh Renderer component](https://docs.unity3d.com/Manual/class-MeshRenderer.html). Otherwise, Unity falls back to drawing the GameObject without GPU instancing.

If you enable the GPU Resident Drawer, the following applies:

-   Build times are longer because Unity compiles all the `BatchRendererGroup` shader variants into your build. The **Probe Atlas Blending** is used by default when both the [Forward+](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering/forward-rendering-paths.html) rendering path and the GPU Resident Drawer are used.

<span id="enable-the-gpu-resident-drawer"></span>

## Enable the GPU Resident Drawer

Follow these steps:

1.  Go to **Project Settings** > **Graphics**, then in the **Shader Stripping** section set **BatchRendererGroup Variants** to **Keep All**.
2.  Go to the active [URP asset](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/universalrp-asset.html) and check **SRP Batcher** is enabled. If the property isn’t visible in the URP asset, open the **More** (**⋮**) menu and select **Show All Advanced Properties**.
3.  Set **GPU Resident Drawer** to **Instanced Drawing**.
4.  Double-click the renderer in the **Renderer List** to open the Universal Renderer, then set **Rendering Path** to **Forward+**.

If you change or create GameObjects each frame, the GPU Resident Drawer updates with the changes.

To include or exclude GameObjects from the GPU Resident Drawer, refer to [Make a GameObject compatible with the GPU Resident Drawer](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/make-object-compatible-gpu-rendering.html).

## Analyze the GPU Resident Drawer

To analyze the results of the GPU Resident Drawer, you can use the following:

-   [Frame Debugger](https://docs.unity3d.com/Manual/FrameDebugger.html). The GPU Resident Drawer groups GameObjects into draw calls with the name **Hybrid Batch Group**.
-   [Rendering Debugger](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/features/rendering-debugger-reference.html).
-   [Rendering Statistics](https://docs.unity3d.com/Manual/RenderingStatistics.html) to check if the number of frames per second increases, and the CPU processing time and SetPass calls decreases.
-   [Unity Profiler](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/optimize-for-better-performance.html)

## Optimize the GPU Resident Drawer

How much the GPU Resident Drawer speeds up rendering depends on your scene. The GPU Resident Drawer is most effective in the following setups:

-   The scene is large.
-   Multiple GameObjects use the same mesh, so Unity can group them into a single draw call.

Rendering usually speeds up less in the Scene view and the Game view, compared to Play mode or your final built project.

The following might speed up the GPU Resident Drawer:

-   Go to **Project Settings** > **Player**, then in the **Other Settings** section disable **Static Batching**.
-   Go to **Window** > **Rendering** > **Lighting**, then in the **Lightmapping Settings** section enable **Fixed Lightmap Size** and disable **Use Mipmap Limits**.

**Note:** The GPU Resident Drawer uses its own GPU Occlusion culling system, but supports [Dynamic Occlusion](https://docs.unity3d.com/6000.3/Documentation/Manual/occlusion-culling-dynamic-gameobjects.html) as well.

## Additional resources

-   [Reduce rendering work on the CPU](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/reduce-rendering-work-on-cpu.html)
-   [Graphics performance fundamentals](https://docs.unity3d.com/Manual/OptimizingGraphicsPerformance.html)
-   [GPU occlusion culling](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/gpu-culling.html)
