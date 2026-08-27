---
title: "Shadows volume override reference"
page_title: "Shadows volume override reference | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/reference-shadows-volume-override.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/reference-shadows-volume-override.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Shadows volume override reference

## Properties

To edit properties in any Volume component override, enable the checkbox to the left of the property. This also tells HDRP to use the property value you specify for the Volume component rather than the default value. If you disable the checkbox, HDRP ignores the property you set and uses the Volume’s default value for that property instead.

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
<td><strong>Working Unit</strong></td>
<td>Use the drop-down to select the unit that you want to use to define the cascade splits.<br />
• <strong>Metric</strong>: Defines cascade splits and borders in meters.<br />
• <strong>Percent</strong>: Defines cascade splits and borders as a percentage of <strong>Max Distance</strong>.</td>
</tr>
<tr>
<td><strong>Max Distance</strong></td>
<td>Set the maximum distance (in meters) at which HDRP renders shadows. HDRP uses this for punctual Lights and as the last boundary for the final cascade.</td>
</tr>
<tr>
<td><strong>Transmission Multiplier</strong></td>
<td>Sets the multiplier that HDRP applies to light transmitted by Directional Lights on thick objects.</td>
</tr>
<tr>
<td><strong>Cascade Count</strong></td>
<td>Use the slider to set the number of cascades to use for Directional Lights that can cast shadows. Cascades work as levels of detail (LOD) for shadows. Each cascade has its own shadow map, and the cascade area gets progressively larger as they get further from the Camera. HDRP spreads the same resolution shadow map over each cascade area, so cascades closer to the Camera have higher quality shadows than those further from the Camera.</td>
</tr>
<tr>
<td><strong>Split 1</strong></td>
<td>Set the distance of the split between the first and second cascades. The <strong>Working Unit</strong> defines the unit this property uses.</td>
</tr>
<tr>
<td><strong>Split 2</strong></td>
<td>Set the distance of the split between the second and third cascades. The <strong>Working Unit</strong> defines the unit this property uses.</td>
</tr>
<tr>
<td><strong>Split 3</strong></td>
<td>Set the distance of the split between the third and final cascades. The <strong>Working Unit</strong> defines the unit this property uses.</td>
</tr>
<tr>
<td><strong>Border 1</strong></td>
<td>Set the size of the border between the first and second cascade split. HDRP fades the shadow cascades between these two sections over this border. The <strong>Working Unit</strong> defines the unit this property uses.</td>
</tr>
<tr>
<td><strong>Border 2</strong></td>
<td>Set the size of the border between the second and third cascade split. HDRP fades the shadow cascades between these two sections over this border. The <strong>Working Unit</strong> defines the unit this property uses.</td>
</tr>
<tr>
<td><strong>Border 3</strong></td>
<td>Set the size of the border between the third and final cascade split. HDRP fades the shadow cascades between these two sections over this border. The <strong>Working Unit</strong> defines the unit this property uses.</td>
</tr>
<tr>
<td><strong>Border 4</strong></td>
<td>Set the size of the border at the end of the last cascade split. HDRP fades the final shadow cascade out over this distance. The <strong>Working Unit</strong> defines the unit this property uses.</td>
</tr>
</tbody>
</table>
