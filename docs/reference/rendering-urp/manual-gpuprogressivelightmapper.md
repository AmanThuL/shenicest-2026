---
title: "Optimize baking"
page_title: "Unity - Manual: Optimize baking"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/GPUProgressiveLightmapper.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/GPUProgressiveLightmapper.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Optimize baking

In most configurations, the Progressive GPU Lightmapper performs much faster than the Progressive CPU Lightmapper. The performance depends on the selected [Baking Profile](https://docs.unity3d.com/Manual/lighting-window.html).

However, the specifications of the GPU you use to bake and the amount of VRAM dedicated to that GPU both influence your experience of the lightmapper’s performance.

Other applications competing for GPU resources also have an impact on baking performance. Depending on your hardware vendor, reductions in the amount of VRAM available to Unity can slow down the bake process or cause it to fail.

In order to achieve results of the same quality as the Progressive CPU Lightmapper, the Progressive GPU Lightmapper needs up to four times more indirect light samples. The Progressive CPU Lightmapper uses an approach called branched path tracing, which launches more light rays at each bounce. The branched path tracing approach is not suitable for GPUs.

Unity provides a spreadsheet to help you determine how much memory the Progressive GPU Lightmapper needs to bake your scene. For more information see the [Progressive GPU Lightmapper Memory Spreadsheet](https://docs.unity3d.com/6000.3/Documentation/uploads/Examples/GPULightmapperMemoryTool.zip) .

## Preventing baking speed slowdowns caused by lightmapper tiling

The Progressive GPU Lightmapper includes a feature called lightmapper tiling. Lightmapper tiling prevents the Progressive GPU Lightmapper from using all available GPU memory. Instead, Unity allocates some temporary memory on the CPU, then bakes your lighting in tiles that are sized to match the amount of GPU memory available. Unity configures the tiling based on the selected **Baking Profile**. The Progressive CPU Lightmapper does not include a tiling feature.

When the tiling feature is active, and when the lightmap atlas resolution is 512px or bigger, the baking process is likely to be slower than baking the same scene without tiling.

## Platform-specific limitations

On macOS it is more difficult to determine how much memory is available. As a result, fallback to CPU is more likely on this platform and it is a best practice to follow instructions for optimizing your bake speed.

## How to optimize your bake speed

There are several ways you can reduce bake times and avoid situations where bakes exceed the VRAM available to the GPU designated for baking.

-   Close other GPU-accelerated applications. GPU-accelerated 2D image editing and 3D modelling software uses VRAM. Turn off accelerated graphics functionality or quit these applications.

-   Use Light Probes for smaller GameObjects. GameObjects such as debris or small props use up space in lightmaps but might not contribute significantly to the look of a scene. To optimize bake speed, [disable **Contribute Global Illumination** for these GameObjects’ Mesh Renderers](https://docs.unity3d.com/Manual/class-MeshRenderer.html#Lighting) and light them with [Light Probes](https://docs.unity3d.com/Manual/LightProbes.html) instead.

-   Designate separate GPUs for rendering and baking. If your computer has more than one GPU, you can designate one for rendering and one for baking. See Configure GPU selection below.

-   Use a lower number of **Anti-aliasing samples**. The default value for this setting in the [Lightmap Parameters Asset](https://docs.unity3d.com/Manual/class-LightmapParameters.html) is 8. When you increase it, Unity uses more VRAM. When you are using a lightmap size of 4096 or above, this can quickly exceed the memory of many consumer GPUs.

-   Use fewer samples (Direct Samples, Indirect Samples, Environment Samples) and use the **Denoiser** to clean up the remaining noise in the lightmap.

-   Reduce your lightmap resolution.

## Configure GPU selection <span id="configgpu"></span>

If you have at least two GPUs, you can specify one GPU for rendering the Scene and another for baking lighting. This might be desirable in cases where there is insufficient VRAM available for the default GPU to both render your scene and bake it using the Progressive GPU Lightmapper.

To change which GPU Unity uses for baking:

1.  Open the [Lighting window](https://docs.unity3d.com/Manual/lighting-window.html) (menu: **Window** > **Rendering** > **Lighting**).
2.  Select **Generate Lighting** to precompute the lighting data.
3.  Use **GPU Baking Device** to select a GPU.
