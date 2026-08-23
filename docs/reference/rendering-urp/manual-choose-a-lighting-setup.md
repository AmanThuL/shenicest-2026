---
title: "Global illumination"
page_title: "Unity - Manual: Global illumination"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/choose-a-lighting-setup.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/choose-a-lighting-setup.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Global illumination

Global illumination is a group of techniques that model both direct and indirect lighting to provide realistic lighting results.

Unity has the following global illumination systems:

-   Baked Global Illumination
-   Enlighten Realtime Global Illumination

With both systems, you need to make sure you set up texture UVs correctly, and control Light Probe placement to avoid increasing baking time.

If you’re experimenting with lighting, you can disable both global illumination systems so lighting updates more quickly. To compensate for the lack of indirect lighting, enable [screen space ambient occlusion (SSAO)](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/post-processing-ssao.html).

For more information about support for global illumination across render pipelines, refer to [render pipeline feature comparison reference](https://docs.unity3d.com/6000.3/Documentation/Manual/render-pipelines-feature-comparison.html).

## Baked Global Illumination

Unity uses a CPU or GPU lightmapper to store lighting data in your build, in Light Probes, Reflection Probes, and textures called lightmaps.

Lighting quality is usually better than Enlighten Realtime Global Illumination.

For more information, refer to [Baking lightmaps before runtime](https://docs.unity3d.com/6000.3/Documentation/Manual/Lightmapping-baking-before-runtime.html).

## Enlighten Realtime Global Illumination

Unity stores some lighting data in your build, but uses the data to create lightmaps at runtime. As a result, you can adjust lights and see the effects on indirect lighting in real-time, in the Editor or at runtime.

Enlighten Realtime Global Illumination doesn’t support global illumination from realtime shadows.

For more information, refer to [Update lightmaps at runtime with Enlighten Realtime Global Illumination](https://docs.unity3d.com/6000.3/Documentation/Manual/realtime-gi-using-enlighten-landing.html).

## Using both systems together

The Unity Editor and Player allow you to use both Enlighten Realtime Global Illumination and baked lighting at the same time.

However, simultaneously enabling these features greatly increases baking time and memory usage at runtime, because they do not use the same data sets. You can expect visual differences between indirect light you have baked and indirect light provided by Enlighten Realtime Global Illumination, regardless of the lightmapper you use for baking. This is because Enlighten Realtime Global Illumination often operates at a significantly different resolution than Unity’s baking backends, and relies on different techniques to simulate indirect lighting.

If you wish to use both Enlighten Realtime Global Illumination and baked lighting at the same time, limit your simultaneous use of both global illumination systems to high-end platforms and/or to projects that have tightly controlled scenes with predictable costs. Only expert users who have a very good understanding of all lighting settings can effectively use this approach. Consequently, picking one of the two global illumination systems is usually a safer strategy for most projects. Using both systems is rarely recommended.

## Additional resources

-   [Choose a render pipeline](https://docs.unity3d.com/6000.3/Documentation/Manual/choose-a-render-pipeline.html)
-   [Choose a Light Mode](https://docs.unity3d.com/6000.3/Documentation/Manual/LightModes-choose.html)
-   [Lighting Mode](https://docs.unity3d.com/6000.3/Documentation/Manual/lighting-mode.html)
-   [Lighting in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/lighting-landing.html)
-   [Lighting in the Built-In Render Pipeline](https://docs.unity3d.com/6000.3/Documentation/Manual/lighting-birp.html)
-   [Manage your templates](https://docs.unity.com/hub/project-create#template-categories.html)
-   [Creating Believable Visuals tutorial (Built-In Render Pipeline)](https://unity3d.com/learn/tutorials/s/creating-believable-visuals)
