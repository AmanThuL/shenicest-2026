---
title: "Terrain Lit Material Inspector reference"
page_title: "Terrain Lit Material Inspector reference | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/terrain-lit-material-inspector-reference.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/terrain-lit-material-inspector-reference.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Terrain Lit Material Inspector reference

You can modify the properties of a Terrain Lit material in the Terrain Lit Material Inspector.

Refer to [Terrain Lit material](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/terrain-lit-material.html) for more information.

## Surface Options

| **Property** | **Description** |
|----|----|
| **Receive Decals** | Enable the checkbox to allow HDRP to draw decals on this Material’s surface. |

## Terrain

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
<td><strong>Enable Height-based Blend</strong></td>
<td>Specifies whether HDRP should only render the Terrain Layer with the greatest height value for a particular pixel. When enabled, HDRP takes the height values from the blue channel of the <strong>Mask Map</strong> Texture. When disabled, HDRP blends the Terrain Layers based on the weights painted in the control map Textures.</td>
</tr>
<tr>
<td><strong>- Height Transition</strong></td>
<td>Controls how much HDRP blends the terrain if multiple Terrain Layers are approximately the same height.</td>
</tr>
<tr>
<td><strong>Enable Per-pixel Normal</strong></td>
<td>Specifies whether HDRP should sample the normal map Texture on a per-pixel level. When enabled, Unity preserves more geometry details for distant terrain parts. Unity generates a geometry normal map at runtime from the heightmap, rather than the Mesh geometry. This means you can have high-resolution Mesh normals, even if your Mesh is low resolution. It only works if you enable <strong>Draw Instanced</strong> on the terrain.</td>
</tr>
<tr>
<td><strong>Specular Occlusion Mode</strong></td>
<td>Sets the mode that HDRP uses to calculate specular occlusion.<br />
• <strong>Off</strong>: Disables specular occlusion.<br />
• <strong>From Ambient Occlusion</strong>: Calculates specular occlusion from the ambient occlusion map and the Camera's view direction.</td>
</tr>
</tbody>
</table>

### Advanced Options

| **Property** | **Description** |
|----|----|
| **Enable GPU Instancing** | Enable the checkbox to tell HDRP to render Meshes with the same geometry and Material in one batch when possible. This makes rendering faster. HDRP cannot render Meshes in one batch if they have different Materials, or if the hardware does not support GPU instancing. For example, you cannot [static-batch](https://docs.unity3d.com/Manual/DrawCallBatching.html) GameObjects that have an animation based on the object pivot, but the GPU can instance them. |
