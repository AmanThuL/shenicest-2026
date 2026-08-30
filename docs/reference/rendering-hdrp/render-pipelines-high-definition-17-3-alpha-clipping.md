---
title: "Alpha Clipping reference"
page_title: "Alpha Clipping | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Alpha-Clipping.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Alpha-Clipping.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Alpha Clipping

The **Alpha Clipping** option controls whether your Material acts as a [Cutout Shader](https://docs.unity3d.com/Manual/StandardShaderMaterialParameterRenderingMode.html) or not.

Enable **Alpha Clipping** to create a transparent effect with hard edges between the opaque and transparent areas. HDRP achieves this effect by not rendering pixels with alpha values below the value you specify in the **Threshold** field. For example, a **Threshold** of 0.1 means that HDRP doesn't render alpha values below 0.1.

When using MSAA, the new edges of the object caused by the cutout are not be taken into account for antialiasing. In this case HDRP will automatically enable Alpha To Coverage on the shader to benefit from MSAA.

If you enable this feature, HDRP exposes the following properties for you to use to customize the Alpha Clipping effect:

| Property | Description |
|----|----|
| **Threshold** | Set the alpha value limit that HDRP uses to determine whether it should render each pixel. If the alpha value of the pixel is equal to or higher than the limit then HDRP renders the pixel. If the value is lower than the limit then HDRP does not render the pixel. The default value is 0.5. |
| **Use Shadow Threshold** | Enable the checkbox to set another threshold value for alpha clipping shadows. |
| **- Shadow Threshold** | Set the alpha value limit that HDRP uses to determine whether it should render shadows for a pixel. |

If you set your [Surface Type](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Surface-Type.html) to **Transparent**, HDRP exposes the **Transparent Depth Prepass** and **Transparent Depth Postpass** properties. HDRP allows you to set individual thresholds for these two passes.

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr>
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>Prepass Threshold</strong></td>
<td>Use the slider to set the alpha value limit that HDRP uses for the Transparent depth prepass. This works in the same way as the main <strong>Threshold</strong> property described above.<br />
This property only appears when you enable the <strong>Transparent Depth Prepass</strong> checkbox.</td>
</tr>
<tr>
<td><strong>Postpass Threshold</strong></td>
<td>Use the slider to set the alpha value limit that HDRP uses for the transparent depth postpass. This works in the same way as the main <strong>Threshold</strong> property described above.<br />
This property only appears when you enable the <strong>Transparent Depth Postpass</strong> checkbox.</td>
</tr>
</tbody>
</table>
