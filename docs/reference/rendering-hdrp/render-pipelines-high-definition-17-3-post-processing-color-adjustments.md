---
title: "Color Adjustments"
page_title: "Color Adjustments | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Color-Adjustments.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Color-Adjustments.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Color Adjustments

Use this effect to tweak the overall tone, brightness, and contrast of the final rendered image.

## Using Color Adjustments

**Color Adjustments** uses the [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) framework, so to enable and modify **Color Adjustments** properties, you must add a **Color Adjustments** override to a [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) in your Scene. To add **Color Adjustments** to a Volume:

1.  In the Scene or Hierarchy view, select a GameObject that contains a Volume component to view it in the Inspector.
2.  In the Inspector, go to **Add Override** \> **Post-processing** and select **Color Adjustments**. HDRP now applies **Color Adjustments** to any Camera this Volume affects.

### API

To access and control this override at runtime, use the [Volume scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#changing-volume-profile-properties). Because of how the Volume system works, you edit properties in a different way to standard Unity components. There are also other nuances to be aware of too, such as each property has an [overrideState](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest/index.html?subfolder=/api/UnityEngine.Rendering.VolumeParameter.html%23UnityEngine_Rendering_VolumeParameter_overrideState). This indicates to the Volume system whether to use the property value you set, or use the default value stored in the [Volume Profile](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-volume-profile.html). For information on how to use the API correctly, see [Volume scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#changing-volume-profile-properties).

## Properties

| **Property** | **Description** |
|----|----|
| **Post Exposure** | Adjusts the overall exposure of the Scene in EV (not EV<sub>100</sub>). HDRP applies this after the HDR effect and before tonemapping, which means that it doesn't affect previous effects in the chain. |
| **Contrast** | Use the slider to expand or shrink the overall range of tonal values. Larger positive values expand the tonal range and lower negative values shrink the tonal range. |
| **Color Filter** | Use the color picker to select which color the Color Adjustment effect should use to multiply the render and tint the result. |
| **Hue Shift** | Use the slider to shift the hue of all colors. |
| **Saturation** | Use the slider to push the intensity of all colors. |
