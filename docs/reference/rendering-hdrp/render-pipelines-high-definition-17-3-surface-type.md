---
title: "Surface Type reference"
page_title: "Surface Type | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Surface-Type.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Surface-Type.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Surface Type

The **Surface Type** option controls whether your Material supports transparency or not. Each **Surface Type** has a different workflow and so use the **Surface Type** that is most suitable for the Material you are creating.

| **Surface Type** | **Description** |
|----|----|
| **Opaque** | Simulates a solid Material with no light penetration. |
| **Transparent** | Simulates a transparent Material that light can penetrate, such as clear plastic or glass. Select **Transparent** to expose more properties in the **Surface Options** section and the [Transparency Inputs](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Surface-Type.html#TransparencyInputs) section. |

Materials with **Transparent Surface Types** are more resource intensive to render than Materials with an **Opaque Surface Type**.

## Properties

If you set the **Surface Type** to **Transparent**, HDRP exposes options to set the **Blending Mode** and other properties relating to transparency.

### Surface Options

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
<td><strong>Rendering Pass</strong></td>
<td>Use the drop-down to set the rendering pass that HDRP processes this Material in.<br />
• <strong>Before Refraction</strong>: Draws the GameObject before the refraction pass. This means that HDRP includes this Material when it processes refraction. To expose this option, select <strong>Transparent</strong> from the <strong>Surface Type</strong> drop-down.<br />
• <strong>Default</strong>: Draws the GameObject in the default opaque or transparent rendering pass pass, depending on the <strong>Surface Type</strong>.<br />
• <strong>Low Resolution</strong>: Draws the GameObject in half resolution after the <strong>Default</strong> pass.<br />
• <strong>After post-process</strong>: For <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/unlit-material.html">Unlit Materials</a> only. Draws the GameObject after all post-processing effects.</td>
</tr>
<tr>
<td><strong>Blending Mode</strong></td>
<td>Use the drop-down to determine how HDRP calculates the color of each pixel of the transparent Material by blending the Material with the background pixels.<br />
• <strong>Alpha</strong>: Uses the Material’s alpha value to change how transparent an object is. 0 is fully transparent. 1 appears fully opaque, but the Material is still rendered during the Transparent render pass.<br />
• <strong>Additive</strong>: Adds the Material’s RGB values to the background color. The alpha channel of the Material modulates the intensity. A value of 0 adds nothing and a value of 1 adds 100% of the Material color to the background color.<br />
• <strong>Premultiply</strong>: Assumes that you have already multiplied the RGB values of the Material by the alpha channel. This gives better results than <strong>Alpha</strong> blending when filtering images or composing different layers.</td>
</tr>
<tr>
<td><strong>Preserve specular lighting</strong></td>
<td>Enable the checkbox to make alpha blending not reduce the intensity of specular highlights. This preserves the specular elements on the transparent surface, such as sunbeams shining off glass or water.</td>
</tr>
<tr>
<td><strong>Sorting Priority</strong></td>
<td>Allows you to change the rendering order of overlaid transparent surfaces. For more information and an example of usage, see the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Renderer-And-Material-Priority.html#SortingByMaterial">Material sorting documentation</a>.</td>
</tr>
<tr>
<td><strong>Receive fog</strong></td>
<td>Enable the checkbox to allow fog to affect the transparent surface. When disabled, HDRP does not take this Material into account when it calculates the fog in the Scene.</td>
</tr>
<tr>
<td><strong>Back Then Front Rendering</strong></td>
<td>Enable the checkbox to make HDRP render this Material in two separate draw calls. HDRP renders the back face in the first draw call and the front face in the second.</td>
</tr>
<tr>
<td><strong>Transparent depth prepass</strong></td>
<td>Enable the checkbox to add polygons from the transparent surface to the depth buffer to improve their sorting. HDRP performs this operation before the transparent lighting pass. Not supported when rendering pass is Low Resolution.</td>
</tr>
<tr>
<td><strong>Transparent depth postpass</strong></td>
<td>Enable the checkbox to add polygons from the transparent surface to the depth buffer so they affect post-processing. HDRP performs this operation after the lighting pass. Enabling this feature is useful when using post-processing effects that use depth information, like <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Motion-Blur.html">motion blur</a> or <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Depth-of-Field.html">depth of field</a>. Not supported when rendering pass is Low Resolution.</td>
</tr>
<tr>
<td><strong>Transparent Writes Motion Vectors</strong></td>
<td>Enable the checkbox to make HDRP write motion vectors for transparent GameObjects that use this Material. This allows HDRP to process effects like motion blur for transparent objects. For more information on motion vectors, see the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Motion-Vectors.html">motion vectors documentation</a>. Not supported when rendering pass is Low Resolution.</td>
</tr>
<tr>
<td><strong>Depth Write</strong></td>
<td>Enable the checkbox to make HDRP write depth values for transparent GameObjects that use this Material. Not supported when rendering pass is Low Resolution.</td>
</tr>
<tr>
<td><strong>Depth Test</strong></td>
<td>Use the drop-down to select the comparison function to use for the depth test.</td>
</tr>
<tr>
<td><strong>Cull Mode</strong></td>
<td>Use the drop-down to select the face to cull for transparent GameObjects that use this Material.<br />
• <strong>Front</strong>: Culls the front face of the GameObject's Mesh.<br />
• <strong>Back</strong>: Culls the back face of the GameObject's Mesh.</td>
</tr>
</tbody>
</table>

<span id="TransparencyInputs"></span>

### Transparency Inputs

To expose this section in the Material Inspector, set the **Surface Type** to **Transparent**.

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
<td><strong>Refraction Model</strong></td>
<td>Select the model that HDRP uses to process refraction. See <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-refractive-material.html#set-shape">Set the approximate shape of a refractive object</a> .<br />
• <strong>None</strong>: Disable refraction.<br />
• <strong>Planar</strong>: Calculate refraction by approximating the interior of the object as the area between two parallel planes. Select this option for objects where the entry and exit surfaces are parallel, for example hollow objects. See <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/refraction-models.html#sphere-refraction-model">planar refraction model</a> .<br />
• <strong>Sphere</strong>: Calculate refraction by approximating the interior of the object as a sphere. Select this option for organic, solid, convex objects. See <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/refraction-models.html#planar-refraction-model">sphere refraction model</a>.<br />
• <strong>Thin</strong>: This is the same as <strong>Planar</strong>, but HDRP sets <strong>Refraction Thickness</strong> at 5mm. Use the thin refraction model with thin objects if you use the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Ray-Tracing-Path-Tracing.html">Path Tracing Volume Override</a>. See <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/refraction-models.html#thin-refraction-model">thin refraction model</a>.</td>
</tr>
<tr>
<td><strong>Index of Refraction</strong></td>
<td>Set the index of refraction for this Material. Different real-world materials have different indices of refraction. For example, water has an index of refraction of 1.33. See <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-refractive-material.html#set-ior">Set the index of refraction</a>.<br />
This property appears only if you select <strong>Planar</strong>, <strong>Sphere</strong> or <strong>Thin</strong> as the <strong>Refraction Model</strong>.</td>
</tr>
<tr>
<td><strong>Refraction Thickness</strong></td>
<td>Set the thickness of the refractive object in meters. The higher the value, the more visible the effect is. See <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-refractive-material.html#set-shape">Set the approximate shape of a refractive object</a> .<br />
This property appears only if you select <strong>Planar</strong> or <strong>Sphere</strong> as the <strong>Refraction Model</strong>. If you select <strong>Thin</strong> as the <strong>Refraction Model</strong>, HDRP sets <strong>Refraction Thickness</strong> as 5mm.</td>
</tr>
<tr>
<td><strong>Refraction Thickness Map</strong></td>
<td>Assign a texture that controls the thickness of the object for each pixel. See <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-refractive-material.html#set-shape">Set the approximate shape of a refractive object</a> .<br />
This property appears only if you select <strong>Planar</strong> or <strong>Sphere</strong> as the <strong>Refraction Model</strong>.</td>
</tr>
<tr>
<td><strong>Thickness Remapping</strong></td>
<td>Remap and adjust the minimum and maximum <strong>Thickness Map</strong> values, in meters.<br />
This property only appears if you provide a <strong>Thickness Map</strong>.</td>
</tr>
<tr>
<td><strong>Transmittance Color</strong></td>
<td>Refractive Materials can colorize light that passes through them. Assign a Texture to handle this colorization on a per pixel basis, or use the color picker to set a global color. If you assign a Texture and set a color, the final color of the Material is a combination of the Texture you assign and the color you select. See <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-refractive-material.html#set-absorption">Set color tint and light absorption</a><br />
This property appears only if you select <strong>Planar</strong>, <strong>Sphere</strong> or <strong>Thin</strong> as the <strong>Refraction Model</strong>.</td>
</tr>
<tr>
<td><strong>Transmittance Absorption Distance</strong></td>
<td>Set the distance of the object at which the <strong>Transmittance Color</strong> affects light passing through this Material at full strength. See <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-refractive-material.html#set-absorption">Set color tint and light absorption</a>.<br />
This property appears only if you select <strong>Planar</strong> or <strong>Sphere</strong> the <strong>Refraction Model</strong>. If you select <strong>Thin</strong> as the <strong>Refraction Model</strong>, HDRP sets <strong>Transmittance Absorption Distance</strong> as 5mm.</td>
</tr>
</tbody>
</table>
