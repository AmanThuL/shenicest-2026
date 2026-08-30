---
title: "Lit Master Stack reference"
page_title: "Lit Master Stack reference | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/lit-master-stack-reference.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/lit-master-stack-reference.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Lit Master Stack reference

You can modify the properties of a Lit Shader Graph in the Lit Master Stack.

Refer to [Lit material](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/lit-material.html) for more information.

## Contexts

This Master Stack material type has its own set of Graph Settings. Because of the relationship between settings and Blocks, this has consequences on which Blocks are relevant to the Graph. This section contains information on the Blocks this Master Stack material type adds by default, and which Blocks set properties for this Master Stack material type's Graph Settings.

For more information about the relationship between Graph Settings and Blocks, see [Contexts and Blocks](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-shader-graph-in-hdrp.html).

### Vertex Context

#### Default

When you create a new Lit Master Stack, the Vertex Context contains the following Blocks by default:

| Property | Description | Setting Dependency | Default Value |
|----|----|----|----|
| **Position** | The object space vertex position per vertex. | None | CoordinateSpace.Object |
| **Normal** | The object space vertex normal per vertex. | None | CoordinateSpace.Object |
| **Tangent** | The object space vertex tangent per vertex. | None | CoordinateSpace.Object |

#### Relevant

Depending on the [Graph Settings](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/lit-master-stack-reference.html#graph-settings) you use, Shader Graph can add the following Blocks to the Vertex Context:

| Property | Description | Setting Dependency | Default Value |
|----|----|----|----|
| **Tessellation Factor** | The number of subdivisions that a triangle can have. If you want more subdivisions, set this to a higher value. More subdivisions increase the strength of the tessellation effect and further smooths the geometry. Note that higher values also increase the resource intensity of the tessellation effect. To maintain good performance on the Xbox One or PlayStation 4, do not use values greater than 15. This is because these platforms cannot consistently handle this many subdivisions. A value of 1.0 mean no tessellation. | **Tessellation** enabled | 1 |
| **Tessellation Displacement** | The world space displacement to apply to the world position of mesh vertices after the tessellation process. It is recommended to displace along the world space normal with a displacement map, the displacement map must be sample with a Sample Texture 2D LOD, regular Sample Texture 2D isn't supported. | **Tessellation** enabled | CoordinateSpace.World |

### Fragment Context

#### Default

When you create a new Lit Master Stack, the Fragment Context contains the following Blocks by default:

| Property | Description | Setting Dependency | Default Value |
|----|----|----|----|
| **Base Color** | The base color of the material. | None | Color.grey |
| **Normal Tangent Space** | The normal, in tangent space, for the material. | **Fragment Normal Space** set to **Tangent** | CoordinateSpace.Tangent |
| **Bent Normal** | The bent normal of the fragment. HDRP uses bent normal maps to simulate more accurate ambient occlusion. Bent normals only work with diffuse lighting. | **Material** set to **Eye**, **Fabric**, **Hair**, **Lit**, or **StackLit** | CoordinateSpace.Tangent |
| **Metallic** | The material's metallic value. This defines how "metal-like" the surface of your Material is (between 0 and 1). When a surface is more metallic, it reflects the environment more and its albedo color becomes less visible. At full metallic level, the surface color is entirely driven by reflections from the environment. When a surface is less metallic, its albedo color is clearer and any surface reflections are visible on top of the surface color, rather than obscuring it. | None | 0.0 |
| **Emission** | The color of light to emit from this material's surface. Emissive materials appear as a source of light in your scene. | None | Color.black |
| **Smoothness** | The material's smoothness. Every light ray that hits a smooth surface bounces off at predictable and consistent angles. For a perfectly smooth surface that reflects light like a mirror, set this to a value of 1. Less smooth surfaces reflect light over a wider range of angles (because the light hits the bumps in the microsurface), so the reflections have less detail and spread across the surface in a more diffused pattern. | None | 0.5 |
| **Ambient Occlusion** | The material's ambient occlusion. This approximates occlusion for a fragment on a GameObject’s surface that has been cast by details present in the Material but not the mesh geometry. A value of 0 means the fragment is completely occluded and appears black. A value of 1 means the fragment is not occluded at all, and the ambient color does not change. | None | 1.0 |
| **Alpha** | The Material's alpha value. This determines how transparent the material is. The expected range is 0 - 1. | None | 1.0 |

#### Relevant

Depending on the [Graph Settings](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/lit-master-stack-reference.html#graph-settings) you use, Shader Graph can add the following Blocks to the Fragment Context:

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
<td><strong>Anisotropy</strong></td>
<td>The direction of the anisotropy effect. Negative values make the effect vertical, and positive values make the effect horizontal.</td>
<td>• <strong>Anisotropy</strong> enabled</td>
<td>0.0</td>
</tr>
<tr>
<td><strong>Baked Back GI</strong></td>
<td>The global illumination (GI) value to apply to the back <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Glossary.html#face">face</a> of the Mesh only. This replaces the built-in diffuse GI solution.<br />
This port only appears when you enable the <strong>Override Baked GI</strong> setting.</td>
<td><strong>Override Baked GI</strong> enabled</td>
<td>0.0</td>
</tr>
<tr>
<td><strong>Baked GI</strong></td>
<td>The global illumination (GI) value to apply to the front <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Glossary.html#face">face</a> of the Mesh only. This replaces the built-in diffuse GI solution.</td>
<td>• <strong>Override Baked GI</strong> enabled</td>
<td>0.0</td>
</tr>
<tr>
<td><strong>Coat Mask</strong></td>
<td>The mask that simulates a clear coat effect on the Material to mimic materials like car paint or plastics.</td>
<td>• <strong>Material</strong> set to <strong>StackLit</strong><br />
• <strong>Coat</strong> enabled</td>
<td>0.0</td>
</tr>
<tr>
<td><strong>Depth Offset</strong></td>
<td>The value that the Shader uses to increase the depth of the fragment by. This Block requires you to input the result of the <a href="https://docs.unity3d.com/Packages/com.unity.shadergraph@latest?subfolder=/manual/Parallax-Occlusion-Mapping-Node.html">Parallax Occlusion Mapping</a> Node to produce a realistic result.</td>
<td><strong>Depth Offset</strong> enabled</td>
<td>0.0</td>
</tr>
<tr>
<td><strong>Diffusion Profile</strong></td>
<td>The <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/diffusion-profile-reference.html">Diffusion Profile</a> to use for subsurface scattering and transmission.</td>
<td>• <strong>Material Type</strong> set to <strong>Subsurface Scattering</strong> or <strong>Translucent</strong></td>
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
<td><strong>Iridescence Mask</strong></td>
<td>The strength of the iridescence effect.</td>
<td>• <strong>Material Type</strong> set to <strong>StackLit</strong><br />
• <strong>Iridescence</strong> enabled.</td>
<td>0.0</td>
</tr>
<tr>
<td><strong>Iridescence Thickness</strong></td>
<td>The thickness of the iridescence. This changes the gradient of color that the iridescence effect produces. Unit is micrometer multiplied by 3. A value of 1 is remapped to 3 micrometers or 3000 nanometers.</td>
<td>• <strong>Material Type</strong> set to <strong>StackLit</strong><br />
• <strong>Iridescence</strong> enabled.</td>
<td>0.0</td>
</tr>
<tr>
<td><strong>Normal Object Space</strong></td>
<td>The normal, in object space, for the material.</td>
<td><strong>Fragment Normal Space</strong> set to <strong>Object</strong></td>
<td>CoordinateSpace.Object</td>
</tr>
<tr>
<td><strong>Normal World Space</strong></td>
<td>The normal, in world space, for the material.</td>
<td><strong>Fragment Normal Space</strong> set to <strong>World</strong></td>
<td>CoordinateSpace.World</td>
</tr>
<tr>
<td><strong>Refraction Index</strong></td>
<td>The ratio between the speed of light in a vacuum and the speed of light in the medium of the material. Higher values produce more intense refraction.</td>
<td>• <strong>Refraction Model</strong> not set to <strong>None</strong></td>
<td>0.0</td>
</tr>
<tr>
<td><strong>Refraction Color</strong></td>
<td>The color that this refractive material tints light which passes through it.</td>
<td>• <strong>Refraction Model</strong> not set to <strong>None</strong></td>
<td>0.0</td>
</tr>
<tr>
<td><strong>Refraction Distance</strong></td>
<td>The thickness of the object at which the <strong>Refraction Color</strong> affects incident light at full strength.</td>
<td>• <strong>Refraction Model</strong> not set to <strong>None</strong></td>
<td>0.0</td>
</tr>
<tr>
<td><strong>Specular AA Screen Space Variance</strong></td>
<td>The strength of the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Geometric-Specular-Anti-Aliasing.html">geometric specular anti-aliasing</a> effect between 0 and 1. Higher values produce a blurrier result with less aliasing.</td>
<td><strong>Specular AA</strong> enabled</td>
<td>0.0</td>
</tr>
<tr>
<td><strong>Specular AA Threshold</strong></td>
<td>The maximum value that HDRP subtracts from the smoothness value to reduce artifacts.</td>
<td><strong>Specular AA</strong> enabled</td>
<td>0.0</td>
</tr>
<tr>
<td><strong>Specular Color</strong></td>
<td>The material's specular color value. This defines the brightness and tint colour of specular highlights.<br />
If the Material uses Subsurface Scattering or Transmission, this is only available if <strong>Use IOR from Diffusion Profile</strong> is unchecked.</td>
<td>None</td>
<td>Color.grey</td>
</tr>
<tr>
<td><strong>Specular Occlusion</strong></td>
<td>A multiplier for the intensity of specular global illumination.</td>
<td><strong>Specular Occlusion Mode</strong> set to <strong>Custom</strong></td>
<td>1.0</td>
</tr>
<tr>
<td><strong>Subsurface Mask</strong></td>
<td>The strength of the screen-space blur effect across the Material.</td>
<td><strong>Material</strong> set to <strong>Lit</strong><br />
• <strong>Material Type</strong> set to <strong>Subsurface Scattering</strong>.</td>
<td>1.0</td>
</tr>
<tr>
<td><strong>Transmission Mask</strong></td>
<td>The strength of transmitted light across the Material.</td>
<td>• <strong>Material</strong> set to <strong>Lit</strong><br />
• <strong>Material Type</strong> set to <strong>Subsurface Scattering</strong> and <strong>Transmission</strong> enabled.<br />
Or<br />
• <strong>Material Type</strong> set to <strong>Translucent</strong></td>
<td>1.0</td>
</tr>
<tr>
<td><strong>Tangent Object Space</strong></td>
<td>The direction of anisotropy in object space. This stretches the specular highlights in the given direction.</td>
<td>• <strong>Material</strong> set to <strong>Lit</strong><br />
• <strong>Material Type</strong> set to <strong>Anisotropy</strong><br />
• <strong>Fragment Normal Space</strong> set to <strong>Object</strong><br />
Or<br />
• <strong>Material</strong> set to <strong>StackLit</strong><br />
• <strong>Fragment Normal Space</strong> set to <strong>Object</strong><br />
Or<br />
• <strong>Material</strong> set to Fabric and <strong>Material Type</strong> set to <strong>Silk</strong><br />
• <strong>Fragment Normal Space</strong> set to <strong>Object</strong></td>
<td>CoordinateSpace.Object</td>
</tr>
<tr>
<td><strong>Tangent Tangent Space</strong></td>
<td>The direction of anisotropy in tangent space. This stretches the specular highlights in the given direction.</td>
<td>• <strong>Material</strong> set to <strong>Lit</strong><br />
• <strong>Material Type</strong> set to <strong>Anisotropy</strong><br />
• <strong>Fragment Normal Space</strong> set to <strong>Tangent</strong><br />
Or<br />
• <strong>Material</strong> set to <strong>StackLit</strong><br />
• <strong>Fragment Normal Space</strong> set to <strong>Tangent</strong><br />
Or<br />
• <strong>Material</strong> set to Fabric and <strong>Material Type</strong> set to <strong>Silk</strong><br />
• <strong>Fragment Normal Space</strong> set to <strong>Tangent</strong></td>
<td>CoordinateSpace.Tangent</td>
</tr>
<tr>
<td><strong>Tangent World Space</strong></td>
<td>The direction of anisotropy in world space. This stretches the specular highlights in the given direction.</td>
<td>• <strong>Material</strong> set to <strong>Lit</strong><br />
• <strong>Material Type</strong> set to <strong>Anisotropy</strong><br />
• <strong>Fragment Normal Space</strong> set to <strong>World</strong><br />
Or<br />
• <strong>Material</strong> set to <strong>StackLit</strong><br />
• <strong>Fragment Normal Space</strong> set to <strong>World</strong><br />
Or<br />
• <strong>Material</strong> set to Fabric and <strong>Material Type</strong> set to <strong>Silk</strong><br />
• <strong>Fragment Normal Space</strong> set to <strong>World</strong></td>
<td>CoordinateSpace.World</td>
</tr>
<tr>
<td><strong>Thickness</strong></td>
<td>The thickness of the surface that HDRP uses to evaluate transmission.</td>
<td>• <strong>Material Type</strong> set to <strong>Subsurface Scattering</strong> and <strong>Transmission</strong> enabled.<br />
Or<br />
• <strong>Material Type</strong> set to <strong>Transluscent</strong>.<br />
Or<br />
• <strong>Refraction Model</strong> not set to <strong>None</strong></td>
<td>1.0</td>
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
<td><strong>Material Type</strong></td>
<td>N/A</td>
<td>N/A</td>
<td>Specifies a type for the material. This allows you to customize the material with different settings depending on the type you select. The options are:<br />
• <strong>Subsurface Scattering</strong>: Applies the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/skin-and-diffusive-surfaces-subsurface-scattering.html">subsurface scattering</a> workflow to the material. Subsurface scattering simulates the way light interacts with and penetrates translucent objects, such as skin or plant leaves. When light penetrates the surface of a subsurface scattering material, it scatters and blurs before exiting the surface at a different point.<br />
• <strong>Standard</strong>: Applies the basic metallic Shader workflow to the material. This is the default <strong>Material Type</strong>.<br />
• <strong>Anisotropy</strong>: Applies the anisotropic workflow to the material. The highlights of Anisotropic surfaces change in appearance as you view the material from different angles. Use this <strong>Material Type</strong> to create materials with anisotropic highlights. For example, brushed metal or velvet.<br />
• <strong>Iridescence</strong>: Applies the Iridescence workflow to the material. Iridescent surfaces appear to gradually change color as the angle of view or angle of illumination changes. Use this <strong>Material Type</strong> to create materials like soap bubbles, iridescent metal, or insect wings.<br />
• <strong>Specular Color</strong>: Applies the Specular Color workflow to the material. Use this <strong>Material Type</strong> to create Materials with a coloured specular highlight. For more information, refer to <a href="https://docs.unity3d.com/Documentation/Manual/StandardShaderMetallicVsSpecular.html">Metallic and specular workflows</a>.<br />
• <strong>Translucent</strong>: Applies the Translucent workflow to the material. Use this <strong>Material Type</strong>, and a thickness map, to simulate a translucent material. In contrast to <strong>Subsurface Scattering</strong> materials, <strong>Translucent</strong> materials do not blur light that transmits through the material.<br />
For more information about the feature and for the list of properties each <strong>Material Type</strong> exposes, see the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Material-Type.html">Material Type documentation</a>.</td>
</tr>
<tr>
<td><strong>Recursive Rendering</strong></td>
<td>N/A</td>
<td>N/A</td>
<td>Indicates whether to include this material in the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Ray-Tracing-Recursive-Rendering.html">recursive rendering pipeline</a>. When enabled, if your project supports <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Ray-Tracing-Getting-Started.html">ray tracing</a> and a <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Ray-Tracing-Recursive-Rendering.html">Recursive Rendering</a> Volume Profile override is active, HDRP uses ray tracing to render this material.</td>
</tr>
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
<td>Surface Type</td>
<td>N/A</td>
<td>Preserve Specular Lighting</td>
<td>Indicates whether to make alpha blending not reduce the intensity of specular highlights. This preserves the specular elements on the transparent surface, such as sunbeams shining off glass or water.<br />
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
<td><strong>Double Sided Mode</strong></td>
<td>N/A</td>
<td>N/A</td>
<td>Specifies how HDRP renders the faces of polygons in the mesh geometry. The options are:<br />
• Disabled: Only renders one face of the polygons.<br />
• Enabled: Renders both faces of the polygons. In this mode, the normal of the back face is the same as the front face.<br />
• Flipped Normals: Renders both faces of the polygons. In this mode, the normal of the back face is 180° of the front-facing normal. This also applies to the material, which means that it looks the same on both sides of the geometry.<br />
• Mirrored Normals: Renders both faces of the polygons. In this mode, the normal of the back face mirrors the front-facing normal. This also applies to the material, which means that it inverts on the back face. This is useful when you want to keep the same shape on both sides of the geometry, for example, for leaves.<br />
<br />
For more information about this feature, see <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Double-Sided.html">Double-sided</a>.</td>
</tr>
<tr>
<td><strong>Fragment Normal Space</strong></td>
<td>N/A</td>
<td>N/A</td>
<td>Specifies the normal map space that this Material uses.<br />
• TangentSpace: Defines the normals in <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Glossary.html#TangentSpaceNormalMap">tangent space</a>. Use this to tile a Texture on a Mesh.<br />
• ObjectSpace: Defines the normals in <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Glossary.html#ObjectSpaceNormalMap">object space</a>. Use this for planar-mapping GameObjects like the terrain.<br />
• WorldSpace: Defines the normal maps in world space.</td>
</tr>
<tr>
<td>Receive Decals</td>
<td>N/A</td>
<td>N/A</td>
<td>Indicates whether HDRP can draw decals on this material’s surface.</td>
</tr>
<tr>
<td>Receive SSR</td>
<td>N/A</td>
<td>N/A</td>
<td>Indicates whether HDRP includes this material when it processes the screen space reflection pass.<br />
This property only appears if you set Surface Type to Opaque.</td>
</tr>
<tr>
<td>Receive SSR Transparent</td>
<td>N/A</td>
<td>N/A</td>
<td>Indicates whether HDRP includes this material when it processes the screen space reflection pass.<br />
This property only appears if you set Surface Type to Transparent.</td>
</tr>
<tr>
<td><strong>Geometric Specular AA</strong></td>
<td>N/A</td>
<td>N/A</td>
<td>Indicates whether HDRP performs geometric anti-aliasing on this material. This modifies the smoothness values on the surfaces of curved geometry to remove specular artifacts.<br />
For more information about the feature and for the list of properties this feature exposes, see the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Geometric-Specular-Anti-Aliasing.html">Geometric Specular Anti-aliasing documentation</a>.</td>
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
<td><strong>Clear Coat</strong></td>
<td>N/A</td>
<td>N/A</td>
<td>Indicates whether HDRP simulates a clear coat effect on the Material to mimic Materials like car paint or plastics.</td>
</tr>
<tr>
<td><strong>Transmission</strong></td>
<td>N/A</td>
<td>N/A</td>
<td><p>Indicates whether HDRP simulates the translucency of the material using a thickness map. Configure subsurface scattering and transmission settings using a <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/diffusion-profile-reference.html">Diffusion Profile</a>. For more information, see documentation on <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/skin-and-diffusive-surfaces-subsurface-scattering.html">Subsurface Scattering</a>.<br />
This property only appears when you select <strong>Subsurface Scattering</strong> from the <strong>Material Type</strong> drop-down. To disable transmission in specific regions of the Material, use the <strong>Transmission Mask</strong>.</p></td>
</tr>
<tr>
<td><strong>Refraction Model</strong></td>
<td>N/A</td>
<td>N/A</td>
<td><p>Specifies the model HDRP uses to process refraction. The options are:<br />
• <strong>None</strong>: No refraction occurs. Select this option to disable refraction.<br />
• <strong>Box</strong>: A box-shaped model where incident light enters through a flat surface and leaves through a flat surface. Select this option for hollow surfaces.<br />
• <strong>Sphere</strong>: A sphere-shaped model that produces a magnifying glass-like effect to refraction. Select this option for solid surfaces.<br />
• <strong>Thin</strong>: A thin box surface type, equivalent to Box with a fixed thickness of 5cm. Select this for thin window-like surfaces.</p></td>
</tr>
<tr>
<td><strong>Energy Conserving Specular Color</strong></td>
<td>N/A</td>
<td>N/A</td>
<td>Indicates whether HDRP reduces the diffuse color of the Material if the specular effect is more intense. This makes the lighting of the Material more consistent and makes it look more physically-accurate.<br />
This property only appears when you set Material Type to Specular Color.</td>
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
</tbody>
</table>

### Advanced Options

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
<td><strong>Specular Occlusion Mode</strong></td>
<td>The mode that HDRP uses to calculate specular occlusion. The options are:<br />
• <strong>Off</strong>: Disables specular occlusion.<br />
• <strong>From AO</strong>: Calculates specular occlusion from the ambient occlusion map and the Camera's view vector.<br />
• <strong>From AO and Bent Normal</strong>: Calculates specular occlusion from the ambient occlusion map, the bent normal map, and the Camera's view vector. If no bent normal is provided, the normal is used instead.<br />
• <strong>Custom</strong>: Allows you to specify your own specular occlusion values.</td>
</tr>
<tr>
<td><strong>Override Baked GI</strong></td>
<td>Indicates whether this Material ignores global illumination (GI) in the Scene and instead uses custom GI values. Enable this setting to add two baked GI Blocks to the Fragment Context that control GI for the Material. Disable this setting to make the Material use the Scene's GI.</td>
</tr>
<tr>
<td><strong>Support Lod Crossfade</strong></td>
<td>Indicates whether HDRP processes dithering when a mesh moves moves from one LOD level to another.</td>
</tr>
<tr>
<td><strong>Add Precomputed Velocity</strong></td>
<td><p>Indicates whether to use precomputed velocity information stored in an Alembic file.</p></td>
</tr>
</tbody>
</table>

### Other top level settings

| Property | Description |
|----|----|
| **Support VFX Graph** | Indicates whether this Shader Graph supports the Visual Effect Graph. If you enable this property, output contexts can use this Shader Graph to render particles. The internal setup that Shader Graph does to support visual effects happens when Unity imports the Shader Graph. This means that if you enable this property, but don't use the Shader Graph in a visual effect, there is no impact on performance. It only affects the Shader Graph import time. |
| **Support High Quality Line Rendering** | Indicates whether this Shader Graph supports the [High Quality Line Rendering](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Override-High-Quality-Lines.html) feature. Enabling this property will only have an effect on renderers with line topology. |
