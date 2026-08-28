---
title: "Configure environment lighting"
page_title: "Configure environment lighting | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/ambient-lighting-configure.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/ambient-lighting-configure.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Configure environment lighting

Control how your scene receives light from the environment.

## Make scene elements use the ambient light probe

If you have lightmap textures or Light Probes in your scene, HDRP doesn't use the ambient light probe by default.

To set objects and fog to use the ambient light probe, follow these steps:

1.  Select a GameObject, then in the **Mesh Renderer** component disable the GameObject from receiving light from global illumination.
2.  In the **Fog** volume override, in the **Volumetric Fog** section, set **GI Dimmer** to 0.

<span id="DecoupleVisualEnvironment"></span>

## Decouple lighting from the sky

To decouple lighting from the sky, use a lighting override mask. For example, you can do the following:

- Render a dark sky, but calculate brighter lighting on GameObjects so they display clearly.
- Use a directional light for a moving sun, but a sky background that excludes the sun to avoid double lighting.

First, create a volume with the sky you want to use for lighting:

1.  Create a new sky and fog global volume. From the main menu, select **GameObject** \> **Volume** \> **Sky and Fog Global Volume**.
2.  Select the volume, then use the **Visual Environment** volume override to set the type of sky you want HDRP to use for lighting.
3.  At the top of the **Inspector** window, open the **Layers** dropdown and set the volume to a different layer.

You can now set HDRP to use the layer for lighting, without affecting the sky background:

1.  From the main menu, select **Edit** \> **Project Settings**.
2.  Go to **Quality** \> **HDRP**.
3.  In the **Lighting** \> **Sky** section, set **Lighting Override Mask** to the layer.

## Additional resources

- [Environment lighting](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Environment-Lighting.html)
- [Ambient light](https://docs.unity3d.com/Manual/lighting-ambient-light.html)
