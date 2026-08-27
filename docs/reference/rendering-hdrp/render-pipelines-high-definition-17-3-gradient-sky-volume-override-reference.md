---
title: "Gradient Sky volume override reference"
page_title: "Gradient Sky Volume Override reference | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/gradient-sky-volume-override-reference.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/gradient-sky-volume-override-reference.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Gradient Sky Volume Override reference

The Gradient Sky Volume Override component exposes options that you can use to define how the High Definition Render Pipeline (HDRP) updates the indirect lighting the sky generates in the Scene.

To edit properties in any Volume component override, enable the checkbox to the left of the property. This also tells HDRP to use the property value you specify for the Volume component rather than the default value. If you disable the checkbox, HDRP ignores the property you set and uses the Volume’s default value for that property instead.

Refer to [Create a gradient sky](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-gradient-sky.html) for more information.

<table>
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<thead>
<tr>
<th><strong>Property</strong></th>
<th><strong>Sub-property</strong></th>
<th><strong>Description</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>Top</strong></td>
<td>N/A</td>
<td>Use the color picker to select the color of the upper hemisphere of the sky.</td>
</tr>
<tr>
<td><strong>Middle</strong></td>
<td>N/A</td>
<td>Use the color picker to select the color of the horizon.</td>
</tr>
<tr>
<td><strong>Bottom</strong></td>
<td>N/A</td>
<td>Use the color picker to select the color of the lower hemisphere of the sky. This is below the horizon.</td>
</tr>
<tr>
<td><strong>Gradient Diffusion</strong></td>
<td>N/A</td>
<td>Set the size of the Middle property in the Skybox. Higher values make the gradient thinner, shrinking the size of the Middle section. Low values make the gradient thicker, increasing the size of the Middle section.</td>
</tr>
<tr>
<td><strong>Intensity Mode</strong></td>
<td>N/A</td>
<td>Use the drop-down to select the method that HDRP uses to calculate the sky intensity.
<ul>
<li><strong>Exposure:</strong> HDRP calculates intensity from an exposure value in EV100.</li>
<li><strong>Multiplier:</strong> HDRP calculates intensity from a flat multiplier.</li>
</ul></td>
</tr>
<tr>
<td><strong>Intensity Mode</strong></td>
<td><strong>Exposure</strong></td>
<td>Set the amount of light per unit area that HDRP applies to the HDRI Sky cubemap. This property only appears when you select Exposure from the Intensity Mode drop-down.</td>
</tr>
<tr>
<td><strong>Intensity Mode</strong></td>
<td><strong>Multiplier</strong></td>
<td>Set the multiplier for HDRP to apply to the Scene as environmental light. HDRP multiplies the environment light in your Scene by this value. This property only appears when you select Multiplier from the Intensity Mode drop-down.</td>
</tr>
<tr>
<td><strong>Update Mode</strong></td>
<td>N/A</td>
<td>Use the drop-down to set the rate at which HDRP updates the sky environment (using Ambient and Reflection Probes).
<ul>
<li><strong>On Changed:</strong> HDRP updates the sky environment when one of the sky properties changes.</li>
<li><strong>On Demand:</strong> HDRP waits until you manually call for a sky environment update from a script.</li>
<li><strong>Realtime:</strong> HDRP updates the sky environment at regular intervals defined by the Update Period.</li>
</ul></td>
</tr>
</tbody>
</table>
