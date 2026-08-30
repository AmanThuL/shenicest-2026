---
title: "Unlit Master Stack reference"
page_title: "Unlit Master Stack reference | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/unlit-master-stack-reference.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/unlit-master-stack-reference.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Unlit Master Stack reference

You can modify the properties of an Unlit Shader Graph in the Unlit Master Stack.

Refer to [Unlit material](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/unlit-material.html) for more information.

## Contexts

This Master Stack material type has its own set of Graph Settings. Because of the relationship between settings and Blocks, this has consequences on which Blocks are relevant to the Graph. This section contains information on the Blocks this Master Stack material type adds by default, and which Blocks set properties for this Master Stack material type's Graph Settings.

For more information about the relationship between Graph Settings and Blocks, see [Contexts and Blocks](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-shader-graph-in-hdrp.html).

### Vertex Context

#### Default

When you create a new Unlit Master Stack, the Vertex Context contains the following Blocks by default:

| Property | Description | Setting Dependency | Default Value |
|----|----|----|----|
| **Position** | The object space vertex position per vertex. | None | CoordinateSpace.Object |
| **Normal** | The object space vertex normal per vertex. | None | CoordinateSpace.Object |
| **Tangent** | The object space vertex tangent per vertex. | None | CoordinateSpace.Object |

#### Relevant

Depending on the [Graph Settings](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/unlit-master-stack-reference.html#graph-settings) you use, Shader Graph can add the following Blocks to the Vertex Context:

| Property | Description | Setting Dependency | Default Value |
|----|----|----|----|
| **Tessellation Factor** | The number of subdivisions that a triangle can have. If you want more subdivisions, set this to a higher value. More subdivisions increase the strength of the tessellation effect and further smooths the geometry. Note that higher values also increase the resource intensity of the tessellation effect. To maintain good performance on the Xbox One or PlayStation 4, do not use values greater than 15. This is because these platforms cannot consistently handle this many subdivisions. A value of 1.0 mean no tessellation. | **Tessellation** enabled | 1 |
| **Tessellation Displacement** | The world space displacement to apply to the world position of mesh vertices after the tessellation process. It is recommended to displace along the world space normal with a displacement map, the displacement map must be sample with a Sample Texture 2D LOD, regular Sample Texture 2D isn't supported. | **Tessellation** enabled | CoordinateSpace.World |

### Fragment Context

#### Default

When you create a new Unlit Master Stack, the Fragment Context contains the following Blocks by default:

| Property | Description | Setting Dependency | Default Value |
|----|----|----|----|
| **Base Color** | The base color of the material. | None | Color.grey |
| **Emission** | The color of light to emit from this material's surface. Emissive materials appear as a source of light in your scene. | None | Color.black |
| **Alpha** | The Material's alpha value. This determines how transparent the material is. The expected range is 0 - 1. | None | 1.0 |

#### Relevant

Depending on the [Graph Settings](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/unlit-master-stack-reference.html#graph-settings) you use, Shader Graph can add the following Blocks to the Fragment Context:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
</colgroup>
<thead>
<tr>
<th>Property</th>
<th>Description</th>
<th>Setting Dependency</th>
<th>Default Value</th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>Alpha Clip Threshold</strong></td>
<td>The alpha value limit that HDRP uses to determine whether to render each pixel. If the alpha value of the pixel is equal to or higher than the limit, HDRP renders the pixel. If the value is lower than the limit, HDRP does not render the pixel. The default value is 0.5.</td>
<td><strong>Alpha Clipping</strong> enabled</td>
<td>0.5</td>
</tr>
<tr>
<td><strong>Alpha Clip Threshold Depth Postpass</strong></td>
<td>The alpha value limit that HDRP uses for the transparent depth postpass. If the alpha value of the pixel is equal to or higher than this limit, HDRP renders the pixel. If the value is lower than the limit, HDRP does not render the pixel. The default value is 0.5.</td>
<td>• <strong>Alpha Clipping</strong> enabled<br />
• <strong>Transparent Depth Postpass</strong> enabled</td>
<td>0.5</td>
</tr>
<tr>
<td><strong>Alpha Clip Threshold Depth Prepass</strong></td>
<td>The alpha value limit that HDRP uses for the transparent depth prepass. If the alpha value of the pixel is equal to or higher than this limit, HDRP renders the pixel. If the value is lower than the limit, HDRP does not render the pixel. The default value is 0.5.</td>
<td>• <strong>Alpha Clipping</strong> enabled<br />
• <strong>Transparent Depth Prepass</strong> enabled</td>
<td>0.5</td>
</tr>
<tr>
<td><strong>Alpha Clip Threshold Shadow</strong></td>
<td>The alpha value limit that HDRP uses to determine whether it should render shadows for a pixel. If the alpha value of the pixel is equal to or higher than this limit, HDRP renders the pixel. If the value is lower than the limit, HDRP does not render the pixel. The default value is 0.5.</td>
<td><strong>Use Shadow Threshold</strong> enabled</td>
<td>0.5</td>
</tr>
<tr>
<td><strong>Depth Offset</strong></td>
<td>The value that the Shader uses to increase the depth of the fragment by. This Block requires you to input the result of the <a href="https://docs.unity3d.com/Packages/com.unity.shadergraph@latest?subfolder=/manual/Parallax-Occlusion-Mapping-Node.html">Parallax Occlusion Mapping</a> Node to produce a realistic result.</td>
<td><strong>Depth Offset</strong> enabled</td>
<td>0.0</td>
</tr>
<tr>
<td><strong>Distortion</strong></td>
<td>The screen space, per-direction amount that HDRP distorts light that passes through the material. For example, if you set this to (1, 0), the output is offset by 1 pixel to the right.</td>
<td>• <strong>Distortion</strong> enabled</td>
<td>Vector2(0, 0)</td>
</tr>
<tr>
<td><strong>Distortion Blur</strong></td>
<td>The blur intensity of the distortion effect.</td>
<td>• <strong>Distortion</strong> enabled</td>
<td>0.0</td>
</tr>
<tr>
<td><strong>Shadow Tint</strong></td>
<td>The shadow color and opacity.</td>
<td>• <strong>Material</strong> set to <strong>Unlit</strong><br />
• <strong>Shadow Matte</strong> enabled</td>
<td>Color.black</td>
</tr>
</tbody>
</table>

## Graph Settings

### Surface Options

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
</colgroup>
<thead>
<tr>
<th>Property</th>
<th>Option</th>
<th>Sub-option</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Surface Type</td>
<td>N/A</td>
<td>N/A</td>
<td>Specifies whether the material supports transparency or not. Materials with a Transparent Surface Type are more resource intensive to render than Materials with an Opaque Surface Type. Depending on the option you select, HDRP exposes more properties. The options are:<br />
• Opaque:<br />
• Transparent: Simulates a translucent Material that light can penetrate, such as clear plastic or glass.<br />
For more information about the feature and for the list of properties each Surface Type exposes, see the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@latest/index.html?subfolder=/manual/Surface-Type.html">Surface Type documentation</a>.</td>
</tr>
<tr>
<td>Surface Type</td>
<td>Rendering Pass</td>
<td>N/A</td>
<td>Specifies the rendering pass that HDRP processes this material in.<br />
• Before Refraction: Draws the GameObject before the refraction pass. This means that HDRP includes this Material when it processes refraction. To expose this option, select Transparent from the Surface Type drop-down.<br />
• Default: Draws the GameObject in the default opaque or transparent rendering pass pass, depending on the Surface Type.<br />
• Low Resolution: Draws the GameObject in half resolution after the Default pass.<br />
• After post-process: For <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@latest/index.html?subfolder=/manual/Unlit-Shader.html">Unlit Materials</a> only. Draws the GameObject after all post-processing effects.</td>
</tr>
<tr>
<td>Surface Type</td>
<td>Blending Mode</td>
<td>N/A</td>
<td>Specifies the method HDRP uses to blend the color of each pixel of the material with the background pixels. The options are:<br />
• Alpha: Uses the Material’s alpha value to change how transparent an object is. 0 is fully transparent. 1 appears fully opaque, but the Material is still rendered during the Transparent render pass. This is useful for visuals that you want to be fully visible but to also fade over time, like clouds.<br />
• Additive: Adds the Material’s RGB values to the background color. The alpha channel of the Material modulates the intensity. A value of 0 adds nothing and a value of 1 adds 100% of the Material color to the background color.<br />
• Premultiply: Assumes that you have already multiplied the RGB values of the Material by the alpha channel. This gives better results than Alpha blending when filtering images or composing different layers.<br />
This property only appears if you set Surface Type to Transparent.</td>
</tr>
<tr>
<td>Surface Type</td>
<td>Receive Fog</td>
<td>N/A</td>
<td>Indicates whether fog affects the transparent surface. When disabled, HDRP doesn't take this material into account when it calculates the fog in the Scene.</td>
</tr>
<tr>
<td>Surface Type</td>
<td>Depth Test</td>
<td>N/A</td>
<td>Specifies the comparison function HDRP uses for the depth test.</td>
</tr>
<tr>
<td>Surface Type</td>
<td>Depth Write</td>
<td>N/A</td>
<td>Indicates whether HDRP writes depth values for GameObjects that use this material.</td>
</tr>
<tr>
<td>Surface Type</td>
<td>Cull Mode</td>
<td>N/A</td>
<td>Specifies the face to cull for GameObjects that use this material. The options are:<br />
• Front: Culls the front face of the mesh.<br />
• Back: Culls the back face of the mesh.<br />
This property only appears if you disable Double Sided.</td>
</tr>
<tr>
<td>Surface Type</td>
<td>Sorting Priority</td>
<td>N/A</td>
<td>Allows you to change the rendering order of overlaid transparent surfaces. For more information and an example of usage, see the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@latest/index.html?subfolder=/manual/Renderer-And-Material-Priority.html#SortingByMaterial">Material sorting documentation</a>.<br />
This property only appears if you set Surface Type to Transparent.</td>
</tr>
<tr>
<td>- <strong>Back Then Front Rendering</strong></td>
<td>N/A</td>
<td>N/A</td>
<td><p>Indicates whether HDRP renders this material in two separate draw calls. HDRP renders the back face in the first draw call and the front face in the second.<br />
This property only appears if you set <strong>Surface Type</strong> to <strong>Transparent</strong>.</p></td>
</tr>
<tr>
<td>Surface Type</td>
<td>Transparent Depth Prepass</td>
<td>N/A</td>
<td>Indicates whether HDRP adds polygons from the transparent surface to the depth buffer to improve their sorting. HDRP performs this operation before the lighting pass and this process improves GPU performance.</td>
</tr>
<tr>
<td>- <strong>Transparent Depth Postpass</strong></td>
<td>N/A</td>
<td>N/A</td>
<td><p>Indicates whether HDRP adds polygons to the depth buffer that post-processing uses. HDRP performs this operation before the lighting pass. Enabling this feature is useful if you want to use post-processing effects that use depth information, like <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Motion-Blur.html">motion blur</a> or <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Depth-of-Field.html">depth of field</a>.</p></td>
</tr>
<tr>
<td>Surface Type</td>
<td>Transparent Writes Motion Vectors</td>
<td>N/A</td>
<td>Indicates whether HDRP writes motion vectors for transparent GameObjects that use this Material. This allows HDRP to process effects like motion blur for transparent objects. For more information on motion vectors, see the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@latest/index.html?subfolder=/manual/Motion-Vectors.html">motion vectors documentation</a>.<br />
This property only appears if you set Surface Type to Transparent.</td>
</tr>
<tr>
<td><strong>Alpha Clipping</strong></td>
<td>N/A</td>
<td>N/A</td>
<td>Indicates whether this material acts like a <a href="https://docs.unity3d.com/Manual/StandardShaderMaterialParameterRenderingMode.html">Cutout Shader</a>.<br />
For more information about the feature and for the list of properties this feature exposes, see the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Alpha-Clipping.html">Alpha Clipping documentation</a>.</td>
</tr>
<tr>
<td>- <strong>Use Shadow Threshold</strong></td>
<td>N/A</td>
<td>N/A</td>
<td><p>Indicates whether HDRP uses another threshold value for alpha clipping shadows.<br />
This property only appears if you enable <strong>Alpha Clipping</strong>.</p></td>
</tr>
<tr>
<td>- <strong>Alpha to Mask</strong></td>
<td>N/A</td>
<td>N/A</td>
<td><p>Indicates whether to turn on alpha-to-coverage. If your Project uses MSAA, alpha-to-coverage modifies the multi-sample coverage mask proportionally to the pixel shader result alpha value. This is typically used for anti-aliasing vegetation and other alpha-tested shaders.<br />
This property only appears if you enable <strong>Alpha Clipping</strong>.</p></td>
</tr>
<tr>
<td>- <strong>Exclude from Temporal Upscaling and Anti Aliasing</strong></td>
<td>N/A</td>
<td>N/A</td>
<td><p>Indicates whether the render pipeline excludes this surface from any temporal upscalers (TU) and temporal anti-aliasing (AA). This is useful when the surface looks blurry when TAA or any Temporal Upscaler is enabled and especially useful for animated textures (such as video player in a surface). This setting only works for Transparent surfaces due to the fact that there are no more stencil bits open.</p></td>
</tr>
<tr>
<td>Double-Sided GI</td>
<td>N/A</td>
<td>N/A</td>
<td>Determines how HDRP handles a material with regards to Double Sided GI. When selecting Auto, Double-Sided GI is enabled if the material is Double-Sided; otherwise selecting On or Off respectively enables or disables double sided GI regardless of the material's Double-Sided option. When enabled, the lightmapper accounts for both sides of the geometry when calculating Global Illumination. Backfaces aren't rendered or added to lightmaps, but get treated as valid when seen from other objects. When using the Progressive Lightmapper backfaces bounce light using the same emission and albedo as frontfaces. (Currently this setting is only available when baking with the Progressive Lightmapper backend.).</td>
</tr>
<tr>
<td><strong>Depth Offset</strong></td>
<td>N/A</td>
<td>N/A</td>
<td>Indicates whether HDRP modifies the depth buffer according to the displacement. This allows effects that use the depth buffer (<a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Override-Contact-Shadows.html">Contact Shadows</a> for example) to capture pixel displacement details.</td>
</tr>
<tr>
<td>- <strong>Conservative</strong></td>
<td>N/A</td>
<td>N/A</td>
<td>Indicates whether HDRP only applies positive depth offsets in order to take advantage of the early depth test mechanic.</td>
</tr>
<tr>
<td><strong>Add Custom Velocity</strong></td>
<td>N/A</td>
<td>N/A</td>
<td>Indicates whether HDRP changes the motion vector according to the provided velocity. HDRP adds the provided velocity (the difference between the current frame position and the last frame position in Object space) to the motion vector calculation. This provides correct motion vector calculations for any procedural geometry that HDRP calculates outside of Shader Graph. The motion vector still takes into account other deformations (for example, skinning or vertex animation).</td>
</tr>
<tr>
<td><strong>Tessellation</strong></td>
<td>N/A</td>
<td>N/A</td>
<td>Tessellation Shaders subdivide the Mesh and add vertices according to the Material’s tessellation options, see the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Tessellation.html">Tessellation documentation</a>.</td>
</tr>
<tr>
<td><strong>Shadow Matte</strong></td>
<td>N/A</td>
<td>N/A</td>
<td>Indicates whether the shader receives shadows. Shadow matte only supports shadow maps. It doesn't support screen-space shadows, <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Ray-Traced-Shadows.html">ray-traced Shadows</a>, or <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Override-Contact-Shadows.html">contact shadows</a>.<br />
Enable **Shadow Matte** if you add a custom Node that samples shadow maps, otherwise shadows might not render correctly.</td>
</tr>
</tbody>
</table>

### Distortion

This set of settings only appears if you set **Surface Type** to **Transparent**.

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
<td><strong>Distortion</strong></td>
<td>Indicates whether to distort light that passes through this transparent Material.</td>
</tr>
<tr>
<td><strong>Distortion Blend Mode</strong></td>
<td>Specifies the mode that HDRP uses to blend overlaid distortion surfaces. The options are:<br />
• <strong>Add</strong>: Adds the output distortion value with the current distortion value in the pixel. This is the default mode.<br />
• <strong>Multiply</strong>: Multiplies the output distortion value with the current distortion value in the pixel.<br />
• <strong>Replace</strong>: Replaces the current distortion value in the pixel with the output distortion value.<br />
This setting only appears if you enable <strong>Distortion</strong>.</td>
</tr>
<tr>
<td><strong>Distortion Depth Test</strong></td>
<td>Indicates whether GameObjects that are closer to the Camera hide the distortion effect. Disable this setting to make the distortion effect appear on top of the rendering.<br />
This setting only appears if you enable <strong>Distortion</strong>.</td>
</tr>
<tr>
<td><strong>Distortion Only</strong></td>
<td>Indicates whether to disable the rendering of the GameObject and only render the distortion pass for it. This is useful if you want to distort something without changing its color (for example, hot air distortion).</td>
</tr>
</tbody>
</table>

### Advanced Options

| Property | Description |
|----|----|
| **Support Lod Crossfade** | Indicates whether HDRP processes dithering when a mesh moves moves from one LOD level to another. |
| **Add Precomputed Velocity** | Indicates whether to use precomputed velocity information stored in an Alembic file. |

### Other top level settings

| Property | Description |
|----|----|
| **Support VFX Graph** | Indicates whether this Shader Graph supports the Visual Effect Graph. If you enable this property, output contexts can use this Shader Graph to render particles. The internal setup that Shader Graph does to support visual effects happens when Unity imports the Shader Graph. This means that if you enable this property, but don't use the Shader Graph in a visual effect, there is no impact on performance. It only affects the Shader Graph import time. |
| **Support High Quality Line Rendering** | Indicates whether this Shader Graph supports the [High Quality Line Rendering](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Override-High-Quality-Lines.html) feature. Enabling this property will only have an effect on renderers with line topology. |
