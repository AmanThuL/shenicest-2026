---
title: "Optimize custom shaders"
page_title: "Unity - Manual: Optimize custom shaders"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/SL-ShaderPerformance.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/SL-ShaderPerformance.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Optimize custom shaders

If your custom shaders take a long time to execute, use a GPU profiling tool to check and improve their performance.

Always profile your application on the target platform, so the results represent the actual performance, not the performance on your development machine. For a list of profiling tools for each platform, refer to [Profiling tools reference](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-profiling-tools.html).

## Check GPU capacity

Check the GPU profiling tool for the following metrics, which can indicate performance issues in custom shaders:

-   High texture bandwidth, which means the GPU is approaching the limit of how many gigabytes of texture data it can read and write per second.
-   High buffer bandwidth, which means the GPU is approaching the limit of how many gigabytes of buffer data it can read and write per second.
-   High arithmetic logic unit (ALU) capacity, which means the math processor is reaching the limit of how many operations it can execute per second.

Depending on the platform, you might not have access to all these performance metrics.

### Reduce texture reads and writes

To reduce the number of texture reads, use the following approaches:

-   Use math instead of sampling textures. For example, calculate a gradient or shape rather than reading a texture.
-   Read a packed texture, which is a single texture where each channel is a different texture. For information about how the Universal Render Pipeline (URP) packs textures, refer to [Assign a channel-packed texture to a URP material](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/shaders-in-universalrp-channel-packed-texture.html).
-   Enable [mipmaps](https://docs.unity3d.com/6000.3/Documentation/Manual/texture-mipmaps-introduction.html).

To reduce the number of texture writes, use the following approaches:

-   Reduce the number of dimensions of the render target the shader writes to.
-   Use a format for the render target that uses fewer bits per pixel. For example, use a 16-bit format such as ARGB16 instead of a 32-bit format such as ARGB32, or use a format with fewer channels. For more information, refer to [GPU texture formats reference](https://docs.unity3d.com/6000.3/Documentation/Manual/texture-formats-reference.html).
-   Disable Multisample Anti-aliasing (MSAA) or reduce the number of samples per pixel. For more information, refer to [Add anti-aliasing](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/anti-aliasing.html).
-   If your shader writes to multiple render targets (MRT), write to a packed texture instead, or avoid writing to all the render targets unless you need to.

### Reduce buffer reads and writes

To reduce the amount the GPU reads from and writes to buffers, use the following approaches:

-   Use a read-only buffer if you can. Use a uniform buffer instead of a structured buffer, for example use [ComputeBufferType.Constant](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ComputeBufferType.Constant.html) for compute buffers, and [GraphicsBuffer.Target.Constant](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GraphicsBuffer.Target.Constant.html) for graphics buffers.
-   Read values from the buffer in order, so the GPU fetches values from its current cache instead of having to read from the buffer again.

### Reduce arithmetic operations

To limit how many operations the ALU executes, use the following approaches:

-   Move calculations from the fragment shader to the vertex shader, so the ALU calculates once per vertex instead of once per fragment. If you need per-fragment values, let the GPU interpolate the per-vertex values.

-   Do a calculation once per frame in a C# script, then pass the value to the shader.

-   Avoid slow operations such as `sqrt`, `log`, and `exp`.

-   Avoid slow trigonometric operations such as `sin` and `cos`. Use `dot` and `cross` instead where you can.

-   Use `half` instead of `float`. For more information, refer to [Use 16-bit precision in shaders](https://docs.unity3d.com/6000.3/Documentation/Manual/SL-Use16BitPrecisionInShaders.html).

    **Note**: `half` can cause rendering artifacts if you use it for world-space positions or other variables that need to be high precision.

-   Use a lookup texture (LUT) instead of complex calculations, for example to calculate post-processing effects such as color grading.

## Discard more fragments early

The GPU uses depth testing to discard hidden fragments before it executes the fragment shader, so it has fewer fragments to draw. This is called early depth testing.

To check if your shader prevents the GPU discarding fragments early, check for the following profiler metrics:

-   A low number of “Pre-Z test fails”.
-   A small difference between rasterized fragments sent to the fragment shader and the number of times the fragment shader executes.

To increase the number of fragments the GPU discards early, use the following approaches:

-   Avoid `discard` and `clip` operations in your fragment shader.
-   If you need `discard` and `clip`, for example because you test the alpha channel for alpha clipping, use a conditional or a material property to disable them for GameObjects that don’t need them.

You can also create a depth prepass that writes the depth of objects before URP’s opaque and transparent passes. For more information, refer to [Write a depth-only pass in a shader](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/writing-shaders-urp-depth-only.html).

## Check branching

You can use dynamic branching if your shaders run on a fast GPU, and don’t have asymmetric code branches where one branch is longer or more complex than the other. The GPU allocates registers based on the most complex branch, even if that branch never executes. The GPU might also execute both branches at once, which means the shorter branch must wait for the longer branch to finish.

For more information, refer to [How Unity compiles branching shaders](https://docs.unity3d.com/6000.3/Documentation/Manual/shader-conditionals-choose-a-type.html) and [Introduction to shader variants](https://docs.unity3d.com/6000.3/Documentation/Manual/shader-variants.html).

## Additional resources

-   [Troubleshooting shaders](https://docs.unity3d.com/6000.3/Documentation/Manual/shader-troubleshooting.html)
-   [Introduction to performance in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/understand-performance.html)
-   [Adjust settings to improve performance in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/optimize-for-better-performance.html)
