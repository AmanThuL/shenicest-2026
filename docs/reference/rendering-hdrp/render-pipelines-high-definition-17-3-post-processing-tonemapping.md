---
title: "Tonemapping"
page_title: "Tonemapping | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Tonemapping.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Tonemapping.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Tonemapping

Tonemapping is the process of remapping HDR values of an image in a range suitable to display on screen.

To use Tonemapping, refer to [High Dynamic Range (HDR) and tonemapping](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDR-Output.html).

## Use Tonemapping

**Tonemapping** uses the [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) framework, so to enable and modify **Tonemapping** properties, you must add a **Tonemapping** override to a [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) in your Scene. To add **Tonemapping** to a Volume:

1.  In the Scene or Hierarchy view, select a GameObject that contains a Volume component to view it in the Inspector.
2.  In the Inspector, go to **Add Override** \> **Post-processing** and select **Tonemapping**. HDRP now applies **Tonemapping** to any Camera this Volume affects.

### API

To access and control this override at runtime, use the [Volume scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#changing-volume-profile-properties). Because of how the Volume system works, you edit properties in a different way to standard Unity components. There are also other nuances to be aware of too, such as each property has an [overrideState](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest/index.html?subfolder=/api/UnityEngine.Rendering.VolumeParameter.html%23UnityEngine_Rendering_VolumeParameter_overrideState). This indicates to the Volume system whether to use the property value you set, or use the default value stored in the [Volume Profile](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-volume-profile.html). For information on how to use the API correctly, see [Volume scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#changing-volume-profile-properties).

## Properties

![The tonemapping component properties.](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/Post-processingTonemapping1.png)

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
<td>Use the drop-down to select a tonemapping algorithm to use for color grading. The options are:<br />
• <strong>None</strong>: Use this option if you don't want to apply tonemapping.<br />
• <strong>Neutral</strong>: Use this option if you only want range-remapping with minimal impact on color hue &amp; saturation. It's a good starting point for extensive color grading.<br />
• <strong>ACES</strong>: Use this option to apply a close approximation of the reference ACES tonemapper for a more filmic look. It's more contrasted than Neutral and has an effect on actual color hue &amp; saturation. Note that if you use this tonemapper all the grading operations will be done in the ACES color spaces for optimal precision and results.<br />
• <strong>Custom</strong>: Use this option if you want to specify the tonemapping settings yourself. Selecting this mode exposes properties that allow you to customize the tonemapping curve.<br />
• <strong>External</strong>: Use this option if you want to specify your own lookup table.</td>
</tr>
<tr>
<td><strong>Toe Strength</strong></td>
<td>Use the slider to set the strength of the transition between the curve's toe and the curve's mid-section. A value of 0 results in no transition and a value of 1 results in a hard transition.<br />
This property only appears when you select <strong>Custom</strong> from the <strong>Mode</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Toe Length</strong></td>
<td>Use the slider to set the length of the curve's toe. Higher values result in longer toes and so contain more of the dynamic range.<br />
This property only appears when you select <strong>Custom</strong> from the <strong>Mode</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Shoulder Strength</strong></td>
<td>Use the slider to set the strength of the transition between the curve's midsection and the curve's shoulder. A value of 0 results in no transition and a value of 1 results in a hard transition.<br />
This property only appears when you select <strong>Custom</strong> from the <strong>Mode</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Shoulder Length</strong></td>
<td>Set the amount of f-stops to add to the dynamic range of the curve. This is how much of the highlights that the curve takes into account.<br />
This property only appears when you select <strong>Custom</strong> from the <strong>Mode</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Shoulder Angle</strong></td>
<td>Use the slider to set how much overshoot to add to the curve's shoulder.<br />
This property only appears when you select <strong>Custom</strong> from the <strong>Mode</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Gamma</strong></td>
<td>Set a gamma correction to the entire curve.<br />
This property only appears when you select <strong>Custom</strong> from the <strong>Mode</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Lookup Texture</strong></td>
<td>Assign a log-encoded Texture that this effect applies as a custom lookup table.<br />
This property only appears when you select <strong>External</strong> from the <strong>Mode</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Contribution</strong></td>
<td>Use the slider to set the overall contribution that the lookup <strong>Texture</strong> has to the color grading effect.<br />
This property only appears when you select <strong>External</strong> from the <strong>Mode</strong> drop-down.</td>
</tr>
</tbody>
</table>
