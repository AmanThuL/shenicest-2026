---
title: "Lighting configuration workflow"
page_title: "Unity - Manual: Lighting configuration workflow"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/lighting-configuration-workflow.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/lighting-configuration-workflow.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Lighting configuration workflow

To set up lighting in Unity, follow these steps:

1.  [Choose a render pipeline](https://docs.unity3d.com/6000.3/Documentation/Manual/lighting-configuration-workflow.html#choose-a-render-pipeline)
2.  [Configure lighting](https://docs.unity3d.com/6000.3/Documentation/Manual/lighting-configuration-workflow.html#configure-lighting)
3.  [Fine-tune your scene lighting](https://docs.unity3d.com/6000.3/Documentation/Manual/lighting-configuration-workflow.html#fine-tune-your-scene-lighting)

## Choose a render pipeline

Unity provides render pipelines that differ in customization and lighting features:

-   [Built-in Render Pipeline](https://docs.unity3d.com/6000.3/Documentation/Manual/lighting-birp.html) (not scriptable)
-   [Universal Render Pipeline (URP)](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/lighting/lighting-in-urp.html)
-   [High-Definition Render Pipeline (HDRP)](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@latest?subfolder=/manual/Light-Component.html)
-   Custom Scriptable Render Pipeline (SRP)

For more information on render pipeline selection, refer to [choose a render pipeline](https://docs.unity3d.com/6000.3/Documentation/Manual/choose-a-render-pipeline.html).

## Configure lighting

1.  Choose baked GI, realtime GI, mixed baked and realtime GI, or opt for no GI.

    For more information, refer to [Lighting Settings Asset Inspector window reference](https://docs.unity3d.com/6000.3/Documentation/Manual/class-LightingSettings.html#MixedLighting)

2.  Choose one of the following Lighting Modes:

    -   Baked Indirect
    -   Subtractive
    -   Shadowmask
    -   Distance Shadowmask

    For more information, refer to [Lighting Mode](https://docs.unity3d.com/6000.3/Documentation/Manual/lighting-mode.html).

## Fine-tune your scene lighting

To fine-tune your scene lighting, follow these tasks based on project requirements:

1.  Add [baked, realtime, or mixed lights](https://docs.unity3d.com/6000.3/Documentation/Manual/LightModes-introduction.html).

2.  Optionally configure emissive surfaces with [Baked GI or Realtime GI](https://docs.unity3d.com/6000.3/Documentation/Manual/class-LightmapParameters.html).

3.  Add baked, realtime, or custom [Reflection Probes](https://docs.unity3d.com/6000.3/Documentation/Manual/ReflectionProbes.html).

4.  If a GI mode is set, add [Light Probes](https://docs.unity3d.com/6000.3/Documentation/Manual/LightProbes-landing.html). You can also add [Light Probe Proxy Volumes (LPPVs)](https://docs.unity3d.com/6000.3/Documentation/Manual/LightProbeProxyVolume-landing.html).

## Additional resources

-   [Add light emission to a material](https://docs.unity3d.com/6000.3/Documentation/Manual/StandardShaderMaterialParameterEmission.html)
-   [Reflection Probe Inspector window reference](https://docs.unity3d.com/6000.3/Documentation/Manual/class-ReflectionProbe.html)
-   [Light Probes](https://docs.unity3d.com/6000.3/Documentation/Manual/LightProbes.html)
-   [SRP Core](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest)
