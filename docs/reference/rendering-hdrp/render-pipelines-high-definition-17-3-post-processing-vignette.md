---
title: "Vignette"
page_title: "Vignette | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Vignette.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Vignette.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Vignette

In Photography, vignetting is the term for the darkening or desaturating towards the edges of an image compared to the center. In real life, thick or stacked filters, secondary lenses, and improper lens hoods are usually the cause of this effect. You can use vignetting to draw focus to the center of an image.

## Using Vignette

**Vignette** uses the [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) framework, so to enable and modify **Vignette** properties, you must add a **Vignette** override to a [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) in your Scene. To add **Vignette** to a Volume:

1.  In the Scene or Hierarchy view, select a GameObject that contains a Volume component to view it in the Inspector.
2.  In the Inspector, go to **Add Override** \> **Post-processing** and select **Vignette**. HDRP now applies **Vignette** to any Camera this Volume affects.

### API

To access and control this override at runtime, use the [Volume scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#changing-volume-profile-properties). Because of how the Volume system works, you edit properties in a different way to standard Unity components. There are also other nuances to be aware of too, such as each property has an [overrideState](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest/index.html?subfolder=/api/UnityEngine.Rendering.VolumeParameter.html%23UnityEngine_Rendering_VolumeParameter_overrideState). This indicates to the Volume system whether to use the property value you set, or use the default value stored in the [Volume Profile](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-volume-profile.html). For information on how to use the API correctly, see [Volume scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#changing-volume-profile-properties).

## Properties

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr>
<th><strong>Property</strong></th>
<th><strong>Description</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>Mode</strong></td>
<td>Use the drop-down to select the vignette display mode.<br />
• <strong>Procedural</strong>: Select this mode to expose properties that control the position, shape, and intensity of the vignette.<br />
•<strong>Masked</strong>: Select this mode to use a texture mask to create a custom vignette effect. Use this mode to achieve irregular vignetting effects.</td>
</tr>
<tr>
<td><strong>Color</strong></td>
<td>Use the color picker to set the color of the vignette.</td>
</tr>
<tr>
<td><strong>Center</strong></td>
<td>Set the vignette center point. For reference, the screen center is [0.5, 0.5].<br />
This property only appears when you select <strong>Procedural</strong> from the <strong>Mode</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Intensity</strong></td>
<td>Use the slider to set the strength of the vignette effect.<br />
This property only appears when you select <strong>Procedural</strong> from the <strong>Mode</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Smoothness</strong></td>
<td>Use the slider to set the smoothness of the vignette borders.<br />
This property only appears when you select <strong>Procedural</strong> from the <strong>Mode</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Roundness</strong></td>
<td>Use the slider to set the roundness of the vignette. Higher values result in a more round vignette.<br />
This property only appears when you select <strong>Procedural</strong> from the <strong>Mode</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Rounded</strong></td>
<td>Enable the checkbox to make the vignette perfectly round. Disable the checkbox to make the vignette match the shape on the current aspect ratio.<br />
This property only appears when you select <strong>Procedural</strong> from the <strong>Mode</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Mask</strong></td>
<td>Assign a Texture to use as the vignette. This should be a black and white mask.<br />
This property only appears when you select <strong>Masked</strong> from the <strong>Mode</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Opacity</strong></td>
<td>Use the slider to set the opacity of the mask vignette.<br />
This property only appears when you select <strong>Masked</strong> from the <strong>Mode</strong> drop-down.</td>
</tr>
</tbody>
</table>
