---
title: "Film Grain"
page_title: "Film Grain | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Film-Grain.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Film-Grain.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Film Grain

The Film Grain effect simulates the random optical texture of photographic film, usually caused by small particles being present on the physical film.

## Using Film Grain

**Film Grain** uses the [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) framework, so to enable and modify **Film Grain** properties, you must add a **Film Grain** override to a [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) in your Scene. To add **Film Grain** to a Volume:

1.  In the Scene or Hierarchy view, select a GameObject that contains a Volume component to view it in the Inspector.
2.  In the Inspector, go to **Add Override** \> **Post-processing** and select **Film Grain**. HDRP now applies **Film Grain** to any Camera this Volume affects.

### API

To access and control this override at runtime, use the [Volume scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#changing-volume-profile-properties). Because of how the Volume system works, you edit properties in a different way to standard Unity components. There are also other nuances to be aware of too, such as each property has an [overrideState](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest/index.html?subfolder=/api/UnityEngine.Rendering.VolumeParameter.html%23UnityEngine_Rendering_VolumeParameter_overrideState). This indicates to the Volume system whether to use the property value you set, or use the default value stored in the [Volume Profile](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-volume-profile.html). For information on how to use the API correctly, see [Volume scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#changing-volume-profile-properties).

## Properties

| **Property** | **Description** |
|----|----|
| **Type** | Use the drop-down to select the type of grain to use. You can select from a list of presets that HDRP includes, or select **Custom** to provide your own grain Texture. |
| **Texture** | Assign a Texture that this effect uses as a custom grain Texture. This property is only available when **Type** is set to **Custom**. |
| **Intensity** | Use the slider to set the strength of the Film Grain effect. |
| **Response** | Use the slider to set the noisiness response curve. The higher you set this value, the less noise there is in brighter areas. |
