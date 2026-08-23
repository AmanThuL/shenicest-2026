---
title: "Configure for better performance in URP"
page_title: "Unity - Manual: Configure for better performance in URP"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/configure-for-better-performance.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/configure-for-better-performance.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Configure for better performance in URP

You can disable or change Universal Render Pipeline (URP) settings and features that have a large performance impact. This helps you get better performance for your project, especially on lower-end platforms.

Depending on your project or the platforms you target, one or all of the following might have the biggest effect:

-   Which rendering path you choose
-   How much memory URP uses
-   Processing time on the CPU
-   Processing time on the GPU

You can use the [Unity Profiler](https://docs.unity3d.com/Manual/Profiler.html) or a GPU profiler such as [RenderDoc](https://docs.unity3d.com/Manual/RenderDocIntegration.html) or [Xcode](https://docs.unity3d.com/Manual/XcodeFrameDebuggerIntegration.html) to measure the effect of each setting on the performance of your project.

You might not be able to disable some features if your project needs them.

## Choose a rendering path

Refer to [Universal Renderer](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/urp-universal-renderer.html) for more information about the three rendering paths in URP, and the performance effects and limitations of each one.

## Reduce how much memory URP uses

You can do the following in the [URP asset](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/universalrp-asset.html):

-   Disable **Depth Texture** unless you need it (for example, if you use a shader that samples scene depth), so that URP doesn’t store a depth texture unless it’s needed.
-   Disable **Opaque Texture**, so that URP doesn’t store a snapshot of the opaques in a scene unless it needs to.
-   If you use the Deferred rendering path, disable **Use Rendering Layers** so that URP doesn’t create an extra render target. 
-   Disable **High Dynamic Range (HDR)** if you don’t need it, so that URP doesn’t do HDR calculations. If you need HDR, set **HDR Precision** to **32 Bit**.
-   Reduce **Main Light > Shadow Resolution**, to lower the resolution of the shadow map for the main light.
-   If you use additional lights, reduce **Additional Lights > Shadow Atlas Resolution**, to lower the resolution of the shadow map for additional lights.
-   Disable **Light Cookies** if you don’t need them, or reduce **Cookie Atlas Resolution** and **Cookie Atlas Format**.
-   On lower-end mobile platforms, set **Store Actions** to **Auto** or **Discard**, so that URP doesn’t use memory bandwidth to copy the render targets from each pass into and out of memory.

In the [Universal Renderer asset](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/urp-universal-renderer.html), you can set **Intermediate Texture** to **Auto**, so that Unity only renders using an intermediate texture when necessary. This might also reduce how much GPU memory bandwidth URP uses. Use the [Frame Debugger](https://docs.unity3d.com/Manual/frame-debugger-window.html) to check if URP removes the intermediate texture when you change this setting.

You can also do the following:

-   Minimize the use of the Decal Renderer Feature, because URP creates an additional render pass to render decals. This also reduces processing time on the CPU and GPU. Refer to [Decal Renderer Feature](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/renderer-feature-decal.html) for more information.
-   [Strip shader variants in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/urp/shader-stripping-landing.html) for features you don’t use.

## Reduce processing time on the CPU

You can do the following in the URP asset:

-   Set **Volume Update Mode** to **Via Scripting**, so that URP doesn’t update volumes every frame. You need to update volumes manually using an API such as [UpdateVolumeStack](https://docs.unity3d.com/Packages/com.unity.render-pipelines.universal@latest/index.html?subfolder=/api/UnityEngine.Rendering.Universal.CameraExtensions.html#UnityEngine_Rendering_Universal_CameraExtensions_UpdateVolumeStack_UnityEngine_Camera_).
-   On lower-end mobile platforms, if you use [Reflection Probes](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/lighting/reflection-probes.html), disable **Probe Blending** and **Box Projection**.
-   In the **Shadows** section, reduce **Max Distance** so that URP processes fewer objects in the shadow pass. This also reduces processing time on the GPU.
-   In the **Shadows** section, reduce **Cascade Count** to reduce the number of render passes. This also reduces processing time on the GPU.
-   In the **Additional Lights** section, disable **Cast Shadows**. This also reduces processing time on the GPU and how much memory URP uses.

Each camera in the Scene requires resources for URP culling and rendering. To optimize URP for better performance, minimize the number of cameras you use. This also reduces processing time on the GPU.

## Reduce processing time on the GPU

You can do the following in the URP asset:

-   Reduce or disable **Anti-aliasing (MSAA)**, so that URP doesn’t use memory bandwidth to copy frame buffer attachments into and out of memory. This also reduces how much memory URP uses.
-   Disable **Terrain Holes**.
-   Enable **SRP Batcher**, so that URP reduces the GPU setup between draw calls and makes material data persistent in GPU memory. Check your shaders are compatible with the [SRP Batcher](https://docs.unity3d.com/Manual/SRPBatcher.html) first. This also reduces processing time on the CPU.
-   On lower-end mobile platforms, disable **LOD Cross Fade**, so that URP doesn’t use alpha testing to fade level of detail (LOD) meshes in and out.
-   Set **Additional Lights** to **Disabled**, or **Per Vertex** if you use the Forward rendering path. This reduces the work URP does to calculate lighting. This also reduces processing time on the CPU if you set to **Disabled**.
-   Disable **Soft Shadows**, or enable **Soft Shadows** but reduce **Quality**.

You can do the following in the Universal Renderer asset:

-   Enable **Native RenderPass** if you use Vulkan, Metal or DirectX 12 graphics APIs, so that URP automatically reduces how often it copies render textures into and out of memory. This also reduces how much memory URP uses.
-   If you use the Forward or Forward+ rendering path, set **Depth Priming Mode** to **Auto** or **Forced** for PC and console platforms, or **Disabled** for mobile platforms. On PC and console platforms, this makes URP create and use depth textures to avoid running pixel shaders on obscured pixels.
-   Set **Depth Texture Mode** to **After Transparents**, so that URP avoids switching render targets between the opaque pass and the transparent pass.

You can also do the following:

-   Avoid use of the [Complex Lit shader](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/shader-complex-lit.html), which has complex lighting calculations. If you use the Complex Lit shader, disable **Clear Coat**.
-   On lower-end mobile platforms, use the [Baked Lit shader](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/baked-lit-shader.html) for static objects and the [Simple Lit shader](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/simple-lit-shader.html) for dynamic objects.
-   If you use Screen Space Ambient Occlusion (SSAO), refer to [Ambient Occlusion](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/post-processing-ssao.html) for more information about settings that have a large performance impact.

## Additional resources

-   [Understand performance in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/understand-performance.html)
-   [Optimize for better performance](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/optimize-for-better-performance.html)
-   [Introduction to the Universal Render Pipeline for advanced Unity creators](https://resources.unity.com/games/introduction-universal-render-pipeline-for-advanced-unity-creators)
-   [Performance optimization for high-end graphics on PC and console](https://unity.com/how-to/performance-optimization-high-end-graphics)
-   [Making Alba: How to build a performant open-world game](https://www.youtube.com/watch?v=YOtDVv5-0A4)
-   [Post-processing in URP for mobile devices](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/integration-with-post-processing.html).
-   [Optimizing lighting for a healthy frame rate](https://unity.com/how-to/advanced/optimize-lighting-mobile-games)

Refer to the following for more information on the settings:

-   [Deferred Rendering Path in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering/deferred-rendering-path-landing.html)
-   [Forward rendering paths in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering/forward-rendering-paths.html)
-   [Universal Render Pipeline asset](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/universalrp-asset.html)
-   [Universal Renderer](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/urp-universal-renderer.html)
