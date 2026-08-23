---
title: "Choose a render pipeline"
page_title: "Unity - Manual: Choose a render pipeline"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/choose-a-render-pipeline.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/choose-a-render-pipeline.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Choose a render pipeline

It’s important to choose the right [Unity render pipeline](https://docs.unity3d.com/6000.3/Documentation/Manual/render-pipelines-overview.html) for your project when you’re early in development.

Different render pipelines have different capabilities and perform differently, so they work best for different games, applications, and platforms.

It can be very time-consuming to switch a project from one render pipeline to another, especially if the project is far along in development. Different render pipelines use different shaders and might not have the same features.

The table shows some high-level differences between the pipelines to help you choose the right pipeline for your project at the start.

**Note:** You can’t use the Universal Render Pipeline and the High Definition Render Pipeline (HDRP) at the same time. They’re both built with the Scriptable Render Pipeline (SRP), but their render paths and light models are different.

**Feature**

**Universal Render Pipeline (URP)**

**High Definition Render Pipeline (HDRP)**

**Built-In Render Pipeline**

Target uses

Projects that need rendering scalability across all platforms, especially tile-based deferred rendering (TBDR) platforms, and untethered VR platforms.  
  
Projects that need to extend and customize the rendering pipeline.  
  
2D and 3D projects.

Projects that need photorealism and high-fidelity rendering on high-end platforms  
  
3D projects

Projects that need rendering scalability across all platforms.  
  
2D and 3D projects.

Platform support

Supports all Unity-supported platforms  
  
Focuses on efficiency on tile-based deferred rendering (TBDR) platforms, and untethered VR platforms

Supports desktop, Xbox and PlayStation platforms  
  
Focuses on efficiently using advanced GPU hardware capabilities such as async compute shaders, and ray tracing if the hardware supports it.

Supports all Unity-supported platforms

Source code access

Mostly C#  
  
Public access to [the URP source code on GitHub](https://github.com/Unity-Technologies/Graphics/tree/master/Packages/com.unity.render-pipelines.universal). You can also create a custom pipeline using URP as a base  
  
Easier to read, change, and extend the source code than the Built-In Render Pipeline

Mostly C#  
  
Public access to [the HDRP source code on GitHub](https://github.com/Unity-Technologies/Graphics/tree/master/Packages/com.unity.render-pipelines.high-definition). You can also create a custom pipeline using HDRP as a base  
  
Easier to read, change, and extend the source code than the Built-In Render Pipeline

Mostly C++  
  
Private access by [purchasing source code access](https://unity.com/products/source-code)

Pipeline extension

The API and injection points the pipeline provides, or you can modify the publicly available source code  
  
Easier to extend than the Built-In Render Pipeline

The API and injection points the pipeline provides, or you can modify the publicly available source code  
  
Easier to extend than the Built-In Render Pipeline, but more difficult than URP because HDRP is complex and has advanced features

The API and injection points the pipeline provides

Customization through artist tooling

[Shader Graph](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.0/manual/index.html), which you can use to customize shading, materials, and screen space effects  
  
[Built-in Particle System](https://docs.unity3d.com/6000.3/Documentation/Manual/PartSysUsage.html), which you can use to customize visual effects.Limited customization  
  
[VFX Graph](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.0/manual/index.html), which you can use to design visual effects, from simple common particle behaviors to complex simulations running on the GPU.

[Shader Graph](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.0/manual/index.html), which you can use to customize shading, materials, and screen space effects  
  
[Built-in Particle System](https://docs.unity3d.com/6000.3/Documentation/Manual/PartSysUsage.html), which you can use to customize visual effects. Limited customization  
  
[VFX Graph](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.0/manual/index.html), which you can use to design visual effects, from simple common particle behaviors to complex simulations running on the GPU.

[Shader Graph](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.0/manual/index.html), which you can use to customize shading, materials, and screen space effects  
  
Shader Graph doesn’t receive updates for Built-In Render Pipeline support, aside from bug fixes for existing features  
  
[Built-in Particle System](https://docs.unity3d.com/6000.3/Documentation/Manual/PartSysUsage.html), which you can use to customize visual effects. Limited customization

Customization through hand-coded shaders

HLSL shaders, and URP shaders in the source code that you can customize

HLSL shaders, and HDRP shaders in the source code that you can customize  
  
Hand-coded shaders are recommended for advanced users only, because HDRP shaders are complex and have advanced features

HLSL shaders and [surface shaders](https://docs.unity3d.com/6000.3/Documentation/Manual/SL-SurfaceShaders.html)

Lighting

Designed for both realistic and stylized lighting  
  
Basic PBR, and some advanced PBR such as clear coat  
  
Easier to customize for custom lighting models such as cel shading

Focuses on photorealism and physically accurate lighting with built-in support for physical light units  
  
Basic and advanced PBR. For example clear coat, skin, hair, eyes, subsurface scattering and water  
  
Advanced screen space and volumetric effects  
  
Harder to customize for custom lighting models such as cel shading

Designed for both realistic and stylized lighting  
  
Basic physically-based rendering (PBR)  
  
Easier to customize for custom lighting models such as cel shading

Performance

Supports [static batching](https://docs.unity3d.com/6000.3/Documentation/Manual/static-batching.html) and [dynamic batching](https://docs.unity3d.com/6000.3/Documentation/Manual/dynamic-batching.html)  
  
Advanced draw call batching with the [Scriptable Render Pipeline (SRP) Batcher](https://docs.unity3d.com/6000.3/Documentation/Manual/SRPBatcher.html)  
  
Compatible with the [BatchRenderer Group](https://docs.unity3d.com/6000.3/Documentation/Manual/batch-renderer-group.html) API, and [Entities](https://docs.unity3d.com/Packages/com.unity.entities@1.0/manual/index.html)

Supports [static batching](https://docs.unity3d.com/6000.3/Documentation/Manual/static-batching.html)  
  
Advanced draw call batching with the [Scriptable Render Pipeline (SRP) Batcher](https://docs.unity3d.com/6000.3/Documentation/Manual/SRPBatcher.html)  
  
Compatible with the [BatchRenderer Group](https://docs.unity3d.com/6000.3/Documentation/Manual/batch-renderer-group.html) API, and [Entities](https://docs.unity3d.com/Packages/com.unity.entities@1.0/manual/index.html)

Supports [static batching](https://docs.unity3d.com/6000.3/Documentation/Manual/static-batching.html) and [dynamic batching](https://docs.unity3d.com/6000.3/Documentation/Manual/dynamic-batching.html)

Refer to [Render pipeline feature comparison](https://docs.unity3d.com/6000.3/Documentation/Manual/render-pipelines-feature-comparison.html) for detailed information about which pipeline is compatible with which features, to help you choose the right pipeline for your project.

## Additional resources

-   [Universal Render Pipeline](https://docs.unity3d.com/6000.3/Documentation/Manual/universal-render-pipeline.html)
-   [High Definition Render Pipeline](https://docs.unity3d.com/6000.3/Documentation/Manual/high-definition-render-pipeline.html)
-   [Creating Believable Visuals tutorial](https://unity3d.com/learn/tutorials/s/creating-believable-visuals) for the Built-In Render Pipeline
-   [Creating a custom render pipeline](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@17.0/manual/srp-custom.html)
