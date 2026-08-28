---
title: "Panini Projection"
page_title: "Panini Projection | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Panini-Projection.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Panini-Projection.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Panini Projection

This effect helps you to render perspective views in Scenes with a large field of view. Panini projection is a cylindrical projection, which means that it keeps vertical straight lines straight and vertical. Unlike other cylindrical projections, panini projection keeps radial lines through the center of the image straight too.

For more information about panini projection, see PanoTools’ wiki documentation on [General Panini Projection](https://wiki.panotools.org/The_General_Panini_Projection).

## Using Panini Projection

**Panini Projection** uses the [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) framework, so to enable and modify **Panini Projection** properties, you must add a **Panini Projection** override to a [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) in your Scene. To add **Panini Projection** to a Volume:

1.  In the Scene or Hierarchy view, select a GameObject that contains a Volume component to view it in the Inspector.
2.  In the Inspector, go to **Add Override** \> **Post-processing** and select **Panini Projection**. HDRP now applies **Panini Projection** to any Camera this Volume affects.

### API

To access and control this override at runtime, use the [Volume scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#changing-volume-profile-properties). Because of how the Volume system works, you edit properties in a different way to standard Unity components. There are also other nuances to be aware of too, such as each property has an [overrideState](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest/index.html?subfolder=/api/UnityEngine.Rendering.VolumeParameter.html%23UnityEngine_Rendering_VolumeParameter_overrideState). This indicates to the Volume system whether to use the property value you set, or use the default value stored in the [Volume Profile](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-volume-profile.html). For information on how to use the API correctly, see [Volume scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#changing-volume-profile-properties).

## Properties

| **Property** | **Description** |
|----|----|
| **Distance** | Use the slider to set the strength of the distortion. |
| **Crop to Fit** | Use the slider to crop the distortion to fit the screen. A value of 1 crops the distortion to the edge of the screen, but results in a loss of precision in the center if you set **Distance** to a high value. |
