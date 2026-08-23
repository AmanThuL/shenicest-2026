---
title: "Enable GPU occlusion culling in URP"
page_title: "Unity - Manual: Enable GPU occlusion culling in URP"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/gpu-culling.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/gpu-culling.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Enable GPU occlusion culling in URP

GPU occlusion culling means Unity uses the GPU instead of the CPU to exclude objects from camera rendering when they’re occluded behind other objects. To speed up GPU rendering in scenes with many occluded objects, Unity uses depth information.

GPU occlusion culling works with [GPU Resident Drawer](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/gpu-resident-drawer.html), and restrictions apply similarly.

## How GPU occlusion culling works

Unity generates depth textures from the perspective of cameras in the scene.

The GPU then uses the depth textures from the current and previous frames to cull objects. Unity renders only objects that are tested as unoccluded in either frame.

GPU occlusion culling uses a conservative approach to determine whether objects are visible in a given frame. The system works as follows:

-   **Bounding sphere approximation**: Each potentially occluded object is represented by a bounding sphere. As such, thin or elongated objects have a much coarser spherical representation than their actual mesh, and Unity is less likely to detect that they are occluded.
-   **Downsampled depth buffer**: Unity uses multiple levels of a downsampled depth buffer to test occlusion. The level selected depends on the projected screen size of the bounding sphere, ensuring that the pixel size at that level is larger than the projected sphere. Unity tests larger bounding spheres against more coarsely approximated levels of the depth buffer.

Whether GPU occlusion culling speeds up rendering depends on your scene. GPU occlusion culling is most effective in the following setups:

-   Multiple objects use the same mesh, so Unity can group them into a single draw call.
-   The scene has a lot of occlusion, especially if the occluded objects have a high number of vertices.
-   Occluded objects have a small screen space bounding radius.

If occlusion culling doesn’t have a big effect on your scene, rendering time might increase because of the extra work the GPU does to set up GPU occlusion culling.

## Enable GPU occlusion culling

1.  [Enable the GPU Resident Drawer](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/gpu-resident-drawer.html#enable-the-gpu-resident-drawer).
2.  In the active [Universal Renderer](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/urp-universal-renderer.html), enable **GPU Occlusion**.

## Analyze GPU occlusion culling

You can use the following to analyze GPU occlusion culling:

-   [Rendering Statistics](https://docs.unity3d.com/Manual/RenderingStatistics.html) overlay to check rendering speed increases.
-   [Rendering Debugger](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/features/rendering-debugger-reference.html) to troubleshoot issues.

## Additional resources

-   [Reduce rendering work on the CPU](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/reduce-rendering-work-on-cpu.html)
-   [Occlusion culling](https://docs.unity3d.com/Manual/OcclusionCulling.html)
-   [Choose a method for optimizing draw calls](https://docs.unity3d.com/6000.3/Documentation/Manual/optimizing-draw-calls-choose-method.html)
