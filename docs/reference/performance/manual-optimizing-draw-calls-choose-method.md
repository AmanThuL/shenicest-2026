---
title: "Choose a method for optimizing draw calls"
page_title: "Unity - Manual: Choose a method for optimizing draw calls"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/optimizing-draw-calls-choose-method.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/optimizing-draw-calls-choose-method.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Choose a method for optimizing draw calls

Use draw call optimization if the CPU sends too many draw calls to the GPU, which is also known as being CPU-bound. For more information about draw calls, refer to [Introduction to optimizing draw calls](https://docs.unity3d.com/6000.3/Documentation/Manual/optimizing-draw-calls.html).

## Check the number of draw calls

To check if your scene sends too many draw calls, do any of the following:

-   Open the [Rendering Statistics window](https://docs.unity3d.com/6000.3/Documentation/Manual/RenderingStatistics.html) and check the **SetPass calls** value.
-   Open the [Profiler](https://docs.unity3d.com/6000.3/Documentation/Manual/Profiler.html) and select the **Rendering** section to display the number of draw calls.
-   Check the number of draw calls in the [Frame Debugger](https://docs.unity3d.com/6000.3/Documentation/Manual/FrameDebugger-landing.html).

## Choose optimization methods

The supported and recommended methods for optimizing draw calls depend on whether you use the Universal Render Pipeline (URP), the High Definition Render Pipeline (HDRP), or the Built-In Render Pipeline (BIRP).

| **Feature**                                                                                                          | **Type**                     | **Multithreaded**                                                                                                                                                               | **Recommendation in URP**                                                                                                         | **Recommendation in HDRP**                                                                                                                                        | **Recommendation in the Built-In Render Pipeline**                                                                                                                          |
|:---------------------------------------------------------------------------------------------------------------------|:-----------------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:----------------------------------------------------------------------------------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Scriptable Render Pipeline (SRP) Batcher**                                                                         | Reduces render state updates | DX12, Vulkan, and compatible console APIs only, if you enable [Graphics Jobs](https://docs.unity3d.com/6000.3/Documentation/Manual/vulkanapi-graphics-jobs-configuration.html). | Enable. Refer to [SRP Batcher in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/SRPBatcher.html).                      | Enable. Refer to [SRP Batcher in HDRP](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/SRPBatcher-landing.html)          | Not supported                                                                                                                                                               |
| **GPU Resident Drawer**                                                                                              | Uses GPU hardware instancing | Yes                                                                                                                                                                             | Enable. Refer to [GPU Resident Drawer in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/gpu-resident-drawer.html). | Enable. Refer to [GPU Resident Drawer in HDRP](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/gpu-resident-drawer.html) | Not supported                                                                                                                                                               |
| [**`BatchRendererGroup` (BRG) API**](https://docs.unity3d.com/6000.3/Documentation/Manual/batch-renderer-group.html) | Uses GPU hardware instancing | Yes                                                                                                                                                                             | Use the GPU Resident Drawer instead, except for advanced use cases.                                                               | Use the GPU Resident Drawer instead, except for advanced use cases.                                                                                               | Not supported                                                                                                                                                               |
| **GPU Instancing checkbox in materials**                                                                             | GPU hardware instancing      | No                                                                                                                                                                              | Disable, to avoid extra shader variants.                                                                                          | Disable, to avoid extra shader variants.                                                                                                                          | Enable if you have many instances or lights. Refer to [GPU Instancing](https://docs.unity3d.com/6000.3/Documentation/Manual/GPUInstancing-landing.html).                    |
| **Batching**                                                                                                         | Combines meshes              | No                                                                                                                                                                              | Disable. Static batching isn’t compatible with the BRG API or GPU Resident Drawer.                                                | Disable. Static batching isn’t compatible with the BRG API or GPU Resident Drawer.                                                                                | Enable static batching. Dynamic batching is no longer recommended. Refer to [Batching](https://docs.unity3d.com/6000.3/Documentation/Manual/DrawCallBatching-landing.html). |

If you have many instances or lights, you can also use [optimize mesh rendering using level of detail (LOD)](https://docs.unity3d.com/6000.3/Documentation/Manual/lod-landing.html).

To get the best results from any draw call optimization method, do the following:

-   Use the same materials for different GameObjects as much as possible.
-   If you want to render the same mesh with different properties, for example different colors, use [Material Variants](https://docs.unity3d.com/6000.3/Documentation/Manual/materialvariant-landingpage.html) instead of multiple materials.
-   Avoid using the `MaterialPropertyBlock` API in URP and HDRP.

## Use multiple optimization methods

You can use multiple draw call optimization methods in the same scene, but each GameObject uses only some methods depending on its mesh and shader.

If you enable all the features in the table, Unity does the following:

-   Static meshes: combines the meshes with static batching.
-   Dynamic meshes with a compatible shader: uses the SRP Batcher with the GPU Resident Drawer or the BRG API.
-   Remaining meshes with a compatible shader: uses GPU Instancing.
-   Remaining meshes: uses dynamic batching.

## Additional resources

-   [Shader variants](https://docs.unity3d.com/6000.3/Documentation/Manual/shader-variants.html)
-   [Fantasy Kingdom in Unity 6](https://unity.com/demos/fantasy-kingdom), which uses the GPU Resident Drawer.
-   [SRP Batcher: Speed up your rendering](https://unity.com/blog/engine-platform/srp-batcher-speed-up-your-rendering)
-   [BatchRendererGroup sample: Achieve high frame rate even on budget devices](https://unity.com/blog/engine-platform/batchrenderergroup-sample-high-frame-rate-on-budget-devices)
-   [Megacity Metro](https://unity.com/demos/megacity-competitive-action-sample), which uses the BatchRendererGroup API to render a large number of objects.
