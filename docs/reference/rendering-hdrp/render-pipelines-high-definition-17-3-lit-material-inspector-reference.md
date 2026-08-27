---
title: "Lit Material Inspector reference"
page_title: "Lit Material Inspector Reference | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/lit-material-inspector-reference.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/lit-material-inspector-reference.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Lit Material Inspector Reference

You can modify the properties of a Lit material in the Lit Material Inspector.

Refer to [Lit material](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/lit-material.html) for more information.

## Properties

### Surface Options

**Surface Options** control the overall look of your Material's surface and how Unity renders the Material on screen.

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
<td>N/A</td>
<td>Preserve Specular Lighting</td>
<td>Indicates whether to make alpha blending not reduce the intensity of specular highlights. This preserves the specular elements on the transparent surface, such as sunbeams shining off glass or water.<br />
This property only appears if you set Surface Type to Transparent.</td>
</tr>
<tr>
<td>Surface Type</td>
<td>Sorting Priority</td>
<td>N/A</td>
<td>Allows you to change the rendering order of overlaid transparent surfaces. For more information and an example of usage, see the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@latest/index.html?subfolder=/manual/Renderer-And-Material-Priority.html#SortingByMaterial">Material sorting documentation</a>.<br />
This property only appears if you set Surface Type to Transparent.</td>
</tr>
<tr>
<td>Surface Type</td>
<td>Receive Fog</td>
<td>N/A</td>
<td>Indicates whether fog affects the transparent surface. When disabled, HDRP doesn't take this material into account when it calculates the fog in the Scene.</td>
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
<td>Depth Write</td>
<td>N/A</td>
<td>Indicates whether HDRP writes depth values for GameObjects that use this material.</td>
</tr>
<tr>
<td>Surface Type</td>
<td>Depth Test</td>
<td>N/A</td>
<td>Specifies the comparison function HDRP uses for the depth test.</td>
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
<td><strong>Alpha Clipping</strong></td>
<td>N/A</td>
<td>N/A</td>
<td>Indicates whether this material acts like a <a href="https://docs.unity3d.com/Manual/StandardShaderMaterialParameterRenderingMode.html">Cutout Shader</a>.<br />
For more information about the feature and for the list of properties this feature exposes, see the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Alpha-Clipping.html">Alpha Clipping documentation</a>.</td>
</tr>
<tr>
<td>- <strong>Threshold</strong></td>
<td>N/A</td>
<td>N/A</td>
<td><p>The alpha value limit HDRP uses to determine whether to render each pixel. If the alpha value of the pixel is equal to or higher than the limit then HDRP renders the pixel. If the value is lower than the limit then HDRP does not render the pixel. The default value is 0.5.</p></td>
</tr>
<tr>
<td>- <strong>Use Shadow Threshold</strong></td>
<td>N/A</td>
<td>N/A</td>
<td><p>Indicates whether HDRP uses another threshold value for alpha clipping shadows.<br />
This property only appears if you enable <strong>Alpha Clipping</strong>.</p></td>
</tr>
<tr>
<td>- - <strong>Shadow Threshold</strong></td>
<td>N/A</td>
<td>N/A</td>
<td><p>The alpha value limit that HDRP uses to determine whether it should render shadows for a pixel.<br />
This property only appears if you enable <strong>Use Shadow Threshold</strong>.</p></td>
</tr>
<tr>
<td>- <strong>Alpha to Mask</strong></td>
<td>N/A</td>
<td>N/A</td>
<td><p>Indicates whether to turn on alpha-to-coverage. If your Project uses MSAA, alpha-to-coverage modifies the multi-sample coverage mask proportionally to the pixel shader result alpha value. This is typically used for anti-aliasing vegetation and other alpha-tested shaders.<br />
This property only appears if you enable <strong>Alpha Clipping</strong>.</p></td>
</tr>
<tr>
<td>- <strong>Prepass Threshold</strong></td>
<td>N/A</td>
<td>N/A</td>
<td><p>The alpha value limit HDRP uses for the transparent depth prepass. This works in the same way as the main <strong>Threshold</strong> property described above.<br />
This property only appears when you enable the <strong>Transparent Depth Prepass</strong> checkbox.</p></td>
</tr>
<tr>
<td>- <strong>Postpass Threshold</strong></td>
<td>N/A</td>
<td>N/A</td>
<td><p>The alpha value limit HDRP uses for the transparent depth postpass. This works in the same way as the main <strong>Threshold</strong> property described above.<br />
This property only appears when you enable the <strong>Transparent Depth Postpass</strong> checkbox.</p></td>
</tr>
<tr>
<td>Double-Sided GI</td>
<td>N/A</td>
<td>N/A</td>
<td>Determines how HDRP handles a material with regards to Double Sided GI. When selecting Auto, Double-Sided GI is enabled if the material is Double-Sided; otherwise selecting On or Off respectively enables or disables double sided GI regardless of the material's Double-Sided option. When enabled, the lightmapper accounts for both sides of the geometry when calculating Global Illumination. Backfaces aren't rendered or added to lightmaps, but get treated as valid when seen from other objects. When using the Progressive Lightmapper backfaces bounce light using the same emission and albedo as frontfaces. (Currently this setting is only available when baking with the Progressive Lightmapper backend.).</td>
</tr>
<tr>
<td>Double-Sided GI</td>
<td>Normal Mode</td>
<td>N/A</td>
<td>Specifies the mode HDRP uses to calculate the normals for back facing geometry.<br />
• Flip: The normal of the back face is 180° of the front facing normal. This also applies to the Material which means that it looks the same on both sides of the geometry.<br />
• Mirror: The normal of the back face mirrors the front facing normal. This also applies to the Material which means that it inverts on the back face. This is useful when you want to keep the same shapes on both sides of the geometry, for example, for leaves.<br />
• None: The normal of the back face is the same as the front face.<br />
This property only appears if you enable Double-Sided.</td>
</tr>
<tr>
<td><strong>Double Sided</strong></td>
<td>N/A</td>
<td>N/A</td>
<td>Indicates whether HDRP renders both faces of the polygons in your geometry. For more information about the feature and for the list of properties this feature exposes, see the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Double-Sided.html">Double-Sided documentation</a>.</td>
</tr>
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
<td><strong>Transmission</strong></td>
<td>N/A</td>
<td>N/A</td>
<td><p>Indicates whether HDRP simulates the translucency of the material using a thickness map. Configure subsurface scattering and transmission settings using a <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/diffusion-profile-reference.html">Diffusion Profile</a>. For more information, see documentation on <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/skin-and-diffusive-surfaces-subsurface-scattering.html">Subsurface Scattering</a>.<br />
This property only appears when you select <strong>Subsurface Scattering</strong> from the <strong>Material Type</strong> drop-down. To disable transmission in specific regions of the Material, use the <strong>Transmission Mask</strong>.</p></td>
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
<td>- <strong>Screen Space Variance</strong></td>
<td>N/A</td>
<td>N/A</td>
<td>The strength of the geometric specular anti-aliasing effect between 0 and 1. Higher values produce a blurrier result with less aliasing.<br />
This property only appears if you enable <strong>Geometric Specular AA</strong>.</td>
</tr>
<tr>
<td>- <strong>Threshold</strong></td>
<td>N/A</td>
<td>N/A</td>
<td>The maximum value for the offset that HDRP subtracts from the smoothness value to reduce artifacts.<br />
This property only appears if you enable <strong>Geometric Specular AA</strong>.</td>
</tr>
<tr>
<td><strong>Displacement Mode</strong></td>
<td>N/A</td>
<td>N/A</td>
<td>Specifies the method HDRP uses to alter the height of the Material’s surface. The options are:<br />
• <strong>None</strong>: Applies no displacement to the material.<br />
• <strong>Vertex displacement</strong>: Displaces the mesh's vertices according to the <strong>Height Map</strong>.<br />
• <strong>Pixel displacement</strong>: Displaces the pixels on the mesh surface according to the <strong>Height Map</strong>.<br />
For more information about the feature and for the list of properties each <strong>Displacement Mode</strong> exposes, see the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Displacement-Mode.html">Displacement Mode documentation</a>.</td>
</tr>
<tr>
<td>- <strong>Lock With Object Scale</strong></td>
<td>N/A</td>
<td>N/A</td>
<td>Indicates whether to alter the height of the displacement using the <strong>Scale</strong> of the <strong>Transform</strong>. This allows you to preserve the ratio between the amplitude of the displacement and the <strong>Scale</strong> of the <strong>Transform</strong>.<br />
This property only appears if you set <strong>Displacement Mode</strong> to <strong>Vertex Displacement</strong> or <strong>Pixel Displacement</strong>.</td>
</tr>
<tr>
<td>- <strong>Lock With Height Map Tiling Rate</strong></td>
<td>N/A</td>
<td>N/A</td>
<td>Indicates whether to alter the amplitude of the displacement using the tiling of the <strong>Height Map</strong>. This allows you to preserve the ratio between the amplitude of the displacement and the scale of the <strong>Height Map</strong> Texture.<br />
This property only appears if you set <strong>Displacement Mode</strong> to <strong>Vertex Displacement</strong> or <strong>Pixel Displacement</strong>.</td>
</tr>
<tr>
<td>- <strong>Minimum Steps</strong></td>
<td>N/A</td>
<td>N/A</td>
<td>The minimum number of Texture samples which Unity performs to process pixel displacement.<br />
This property only appears if you set <strong>Displacement Mode</strong> to <strong>Pixel Displacement</strong>.</td>
</tr>
<tr>
<td>- <strong>Maximum Steps</strong></td>
<td>N/A</td>
<td>N/A</td>
<td>The maximum number of Texture samples which Unity performs to process pixel displacement.<br />
This property only appears if you set <strong>Displacement Mode</strong> to <strong>Pixel Displacement</strong>.</td>
</tr>
<tr>
<td>- <strong>Fading Mip Level Start</strong></td>
<td>N/A</td>
<td>N/A</td>
<td>The mip level at which the pixel displacement effect begins to fade out.<br />
This property only appears if you set <strong>Displacement Mode</strong> to <strong>Pixel Displacement</strong>.</td>
</tr>
<tr>
<td>- <strong>Primitive Length</strong></td>
<td>N/A</td>
<td>N/A</td>
<td>The length of the mesh (in meters) on which Unity applies the displacement mapping.<br />
This property only appears if you set <strong>Displacement Mode</strong> to <strong>Pixel Displacement</strong>.</td>
</tr>
<tr>
<td>- <strong>Primitive Width</strong></td>
<td>N/A</td>
<td>N/A</td>
<td>The width of the mesh (in meters) on which Unity applies the displacement mapping.<br />
This property only appears if you set <strong>Displacement Mode</strong> to <strong>Pixel Displacement</strong>.</td>
</tr>
<tr>
<td>- <strong>Depth Offset</strong></td>
<td>N/A</td>
<td>N/A</td>
<td>Indicates whether HDRP modifies the depth buffer according to the displacement. This allows effects that use the depth buffer (<a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Override-Contact-Shadows.html">Contact Shadows</a> for example) to capture pixel displacement details.<br />
This property only appears if you set <strong>Displacement Mode</strong> to <strong>Pixel Displacement</strong>.</td>
</tr>
</tbody>
</table>

### Vertex Animation

| **Property** | **Description** |
|----|----|
| **Motion Vectors For Vertex Animation** | Enable the checkbox to make HDRP write motion vectors for GameObjects that use vertex animation. This removes the ghosting that vertex animation can cause. |

<span id="surface-inputs"></span>

### Surface Inputs

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
<td><strong>Base Map</strong></td>
<td>Assign a Texture that controls both the color and opacity of your Material. To assign a Texture to this field, click the radio button and select your Texture in the Select Texture window. Use the color picker to select the color of the Material. If you do not assign a Texture, this is the absolute color of the Material. If you do assign a Texture, the final color of the Material is a combination of the Texture you assign and the color you select. The alpha value of the color controls the transparency level for the Material if you select <strong>Transparent</strong> from the <strong>Surface Type</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Metallic</strong></td>
<td>Use this slider to adjust how "metal-like" the surface of your Material is (between 0 and 1). When a surface is more metallic, it reflects the environment more and its albedo color becomes less visible. At full metallic level, the surface color is entirely driven by reflections from the environment. When a surface is less metallic, its albedo color is clearer and any surface reflections are visible on top of the surface color, rather than obscuring it.<br />
This property only appears when you unassign the Texture in the <strong>Mask Map</strong>.</td>
</tr>
<tr>
<td><strong>Smoothness</strong></td>
<td>Use the slider to adjust the smoothness of your Material. Every light ray that hits a smooth surface bounces off at predictable and consistent angles. For a perfectly smooth surface that reflects light like a mirror, set this to a value of 1. Less smooth surfaces reflect light over a wider range of angles (because the light hits the bumps in the microsurface), so the reflections have less detail and spread across the surface in a more diffused pattern.<br />
This property only appears when you unassign the Texture in the <strong>Mask Map</strong>.</td>
</tr>
<tr>
<td><strong>Alpha Remapping</strong></td>
<td>Use this min-max slider to remap the alpha values from the <strong>Base Map</strong> to the range you specify. Rather than <a href="https://docs.unity3d.com/ScriptReference/Mathf.Clamp.html">clamping</a> values to the new range, Unity condenses the original range down to the new range uniformly.<br />
This property only appears when you assign a <strong>Base Map</strong>.</td>
</tr>
<tr>
<td><strong>Metallic Remapping</strong></td>
<td>Use this min-max slider to remap the metallic values from the <strong>Mask Map</strong> to the range you specify. Rather than <a href="https://docs.unity3d.com/ScriptReference/Mathf.Clamp.html">clamping</a> values to the new range, Unity condenses the original range down to the new range uniformly.<br />
This property only appears when you assign a <strong>Mask Map</strong>.</td>
</tr>
<tr>
<td><strong>Smoothness Remapping</strong></td>
<td>Use this min-max slider to remap the smoothness values from the <strong>Mask Map</strong> to the range you specify. Rather than <a href="https://docs.unity3d.com/ScriptReference/Mathf.Clamp.html">clamping</a> values to the new range, Unity condenses the original range down to the new range uniformly.<br />
This property only appears when you assign a <strong>Mask Map</strong>.</td>
</tr>
<tr>
<td><strong>Ambient Occlusion Remapping</strong></td>
<td>Use this min-max slider to remap the ambient occlusion values from the <strong>Mask Map</strong> to the range you specify. Rather than <a href="https://docs.unity3d.com/ScriptReference/Mathf.Clamp.html">clamping</a> values to the new range, Unity condenses the original range down to the new range uniformly.<br />
This property only appears when you assign a <strong>Mask Map</strong>.</td>
</tr>
<tr>
<td><strong>Mask Map</strong></td>
<td>Assign a <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Glossary.html#ChannelPacking">channel-packed Texture</a> with the following Material maps in its RGBA channels.<br />
• <strong>Red</strong>: Stores the metallic map.<br />
• <strong>Green</strong>: Stores the ambient occlusion map.<br />
• <strong>Blue</strong>: Stores the detail mask map.<br />
• <strong>Alpha</strong>: Stores the smoothness map.<br />
For more information on channel-packed Textures and the mask map, see <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Mask-Map-and-Detail-Map.html#MaskMap">mask map</a>.</td>
</tr>
<tr>
<td><strong>Normal Map Space</strong></td>
<td>Use this drop-down to select the type of Normal Map space that this Material uses.<br />
• <strong>TangentSpace</strong>: Defines the normal map in <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Glossary.html#TangentSpaceNormalMap">tangent space</a>. use this to tile a Texture on a Mesh. The normal map Texture must be BC7, BC5, or DXT5nm format.<br />
• <strong>ObjectSpace</strong>: Defines the normal maps in <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Glossary.html#ObjectSpaceNormalMap">object space</a>. Use this for planar-mapping GameObjects like the terrain. The normal map must be an RGB Texture .</td>
</tr>
<tr>
<td><strong>Normal Map</strong></td>
<td>Assign a Texture that defines the normal map for this Material in tangent space. Use the slider to modulate the normal intensity between 0 and 8.<br />
This property only appears when you select <strong>TangentSpace</strong> from the <strong>Normal Map Space</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Normal Map OS</strong></td>
<td>Assign a Texture that defines the object space normal map for this Material. Use the handle to modulate the normal intensity between 0 and 8.<br />
This property only appears when you select <strong>ObjectSpace</strong> from the <strong>Normal Map Space</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Bent Normal Map</strong></td>
<td>Assign a Texture that defines the bent normal map for this Material in tangent space. HDRP uses bent normal maps to simulate more accurate ambient occlusion. Note: Bent normal maps only work with diffuse lighting.<br />
This property only appears when you select <strong>TangentSpace</strong> from the <strong>Normal Map Space</strong> drop-down..</td>
</tr>
<tr>
<td><strong>Bent Normal Map OS</strong></td>
<td>Assign a Texture that defines the bent normal map for this Material in object space. HDRP uses bent normal maps to simulate more accurate ambient occlusion. Note: Bent normal maps only work with diffuse lighting.<br />
This property only appears when you select <strong>ObjectSpace</strong> from the <strong>Normal Map Space</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Coat Mask</strong></td>
<td>Assign a Texture that defines the coat mask for this Material. HDRP uses this mask to simulate a clear coat effect on the Material to mimic Materials like car paint or plastics. The Coat Mask value is 0 by default, but you can use the handle to modulate the clear Coat Mask effect using a value between 0 and 1.</td>
</tr>
<tr>
<td><strong>Base UV Mapping</strong></td>
<td>Use the drop-down to select the type of UV mapping that HDRP uses to map Textures to this Material’s surface.<br />
• Unity manages four UV channels for a vertex: <strong>UV0</strong>, <strong>UV1</strong>, <strong>UV2</strong>, and <strong>UV3</strong>.<br />
• <strong>Planar:</strong> A planar projection from top to bottom.<br />
• <strong>Triplanar</strong>: A planar projection in three directions:<br />
X-axis: Left to right<br />
Y-axis: Top to bottom<br />
Z-axis: Front to back<br />
<br />
Unity blends these three projections together to produce the final result.</td>
</tr>
<tr>
<td><strong>Tiling</strong></td>
<td>Set an <strong>X</strong> and <strong>Y</strong> UV tile rate for all of the Textures in the <strong>Surface Inputs</strong> section. HDRP uses the <strong>X</strong> and <strong>Y</strong> values to tile these Textures across the Material’s surface, in object space.</td>
</tr>
<tr>
<td><strong>Offset</strong></td>
<td>Set an <strong>X</strong> and <strong>Y</strong> UV offset for all of the Textures in the <strong>Surface Inputs</strong> section. HDRP uses the <strong>X</strong> and <strong>Y</strong> values to offset these Textures across the Material’s surface, in object.</td>
</tr>
</tbody>
</table>

### Detail Inputs

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
<td><strong>Detail Map</strong></td>
<td>Specifies a <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Glossary.html#channel-packing">channel-packed Texture</a> that HDRP uses to add micro details into the Material. The Detail Map uses the following channel settings:<br />
• <strong>Red</strong>: Stores the grey scale as albedo.<br />
• <strong>Green</strong>: Stores the green channel of the detail normal map.<br />
• <strong>Blue</strong>: Stores the detail smoothness.<br />
• <strong>Alpha</strong>: Stores the red channel of the detail normal map.<br />
For more information on channel-packed Textures and the detail map, see <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Mask-Map-and-Detail-Map.html#detail-map">detail map</a>.</td>
</tr>
<tr>
<td><strong>Detail UV Mapping</strong></td>
<td>Specifies the type of UV map to use for the <strong>Detail Map</strong>. If the Material’s <strong>Base UV mapping</strong> property is set to <strong>Planar</strong> or <strong>Triplanar</strong>, the <strong>Detail UV Mapping</strong> is also set to <strong>Planar</strong> or <strong>Triplanar</strong>.<br />
The <strong>Detail Map</strong> Texture modifies the appearance of the Material so, by default, HDRP applies the <strong>Tiling</strong> and <strong>Offset</strong> of the <strong>Base UV Map</strong> to the <strong>Detail Map</strong> to synchronize the <strong>Detail Map</strong> and the rest of the Material Textures. HDRP then applies the <strong>Detail Map</strong> <strong>Tiling</strong> and <strong>Offset</strong> properties on top of the <strong>Base Map Tiling</strong> and <strong>Offset</strong>. For example, on a plane, if the <strong>Tiling</strong> for <strong>Base UV Mapping</strong> is 2, and this value is also 2, then the <strong>Detail Map</strong> Texture tiles by 4 on the plane.<br />
This workflow allows you to change the <strong>Tiling</strong> of the Texture on the Material, without having to set the <strong>Tiling</strong> of the <strong>Detail UV</strong> too.<br />
To separate the <strong>Detail UV Map</strong> from the <strong>Base UV Map</strong> to set it independently, disable the <strong>Lock to Base Tiling/Offset</strong> checkbox.</td>
</tr>
<tr>
<td><strong>- Lock to Base Tiling/Offset</strong></td>
<td>Indicates whether the <strong>Base UV Map</strong>’s <strong>Tiling</strong> and <strong>Offset</strong> properties affect the <strong>Detail Map</strong>. When enabled, HDRP multiplies these properties by the <strong>Detail UV Map</strong>’s <strong>Tiling</strong> and <strong>Offset</strong> properties respectively. To separate the <strong>Detail UV Map</strong> from the <strong>Base UV Map</strong> to set it independently, disable this checkbox.</td>
</tr>
<tr>
<td><strong>Tiling</strong></td>
<td>The per-axis tile rate for the <strong>Detail Map</strong> UV. HDRP uses the <strong>X</strong> and <strong>Y</strong> values to tile the Texture assigned to the <strong>Detail Map</strong> across the Material’s surface, in object space.</td>
</tr>
<tr>
<td><strong>Offset</strong></td>
<td>The per-axis offset for the <strong>Detail Map</strong> UV. HDRP uses the <strong>X</strong> and <strong>Y</strong> values to offset the Texture assigned to the <strong>Detail Map</strong> across the Material’s surface, in object space.</td>
</tr>
<tr>
<td><strong>Detail Albedo Scale</strong></td>
<td>Modules the albedo of the detail map (red channel) between 0 and 2. This is an overlay effect. The default value is 1 and applies no scale.</td>
</tr>
<tr>
<td><strong>Detail Normal Scale</strong></td>
<td>Modulates the intensity of the detail normal map (green and alpha channel), between 0 and 2. The default value is 1 and applies no scale.</td>
</tr>
<tr>
<td><strong>Detail Smoothness Scale</strong></td>
<td>Modulate the intensity of the detail smoothness map (blue channel) between 0 and 2. This is an overlay effect. The default value is 1 and applies no scale.</td>
</tr>
</tbody>
</table>

### Transparency Inputs

Unity exposes this section if you select **Transparent** from the **Surface Type** drop-down. For information on the properties in this section, see the [Surface Type documentation](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Surface-Type.html#TransparencyInputs).

Be aware that when you enable **Refraction**, make sure to set **Blend Mode** to **Alpha**, otherwise the effect does not work as expected. If you enable **Refraction** and use a **Blend Mode** other than **Alpha**, a warning displays in the material Inspector.

Also, be aware that HDRP does not support **Refraction** in the **Pre-Refraction** render pass. If you enable **Refraction** and use the **Pre-Refraction** render pass, a warning displays in the material and Shader Graph Inspector.

<span id="EmissionInputs"></span>

### Emission inputs

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
<td><strong>Use Emission Intensity</strong></td>
<td>Enable the checkbox to use a separate LDR color and intensity value to set the emission color for this Material. Disable this checkbox to only use an HDR color to handle the color and emission color intensity. When enabled, this exposes the <strong>Emission Intensity</strong> property.</td>
</tr>
<tr>
<td><strong>Emission Map</strong></td>
<td>Assign a Texture that this Material uses for emission. You can also use the color picker to select a color that HDRP multiplies by the Texture. If you do not set an emission texture then HDRP only uses the HDR color to calculate the final emissive color of the Material. You can set the intensity of the HDR color within the HDR color picker.</td>
</tr>
<tr>
<td><strong>Emission UV Mapping</strong></td>
<td>Use the drop-down to select the type of UV mapping that HDRP uses for the <strong>Emission Map</strong>.<br />
• Unity manages four UV channels for a vertex: <strong>UV0</strong>, <strong>UV1</strong>, <strong>UV2</strong>, and <strong>UV3</strong>.<br />
• <strong>Planar:</strong> A planar projection from top to bottom.<br />
• <strong>Triplanar</strong>: A planar projection in three directions:<br />
X-axis: Left to right<br />
Y-axis: Top to bottom<br />
Z-axis: Front to back<br />
<br />
Unity blends these three projections together to produce the final result.<br />
• <strong>Same as Base</strong>: Unity will use the <strong>Base UV Mapping</strong> selected in the <strong>Surface Inputs</strong>. If the Surface has <strong>Pixel displacement</strong> enabled, this option will apply displacement on the emissive map too.</td>
</tr>
<tr>
<td><strong>- Tiling</strong></td>
<td>Set an <strong>X</strong> and <strong>Y</strong> tile rate for the <strong>Emission Map</strong> UV. HDRP uses the <strong>X</strong> and <strong>Y</strong> values to tile the Texture assigned to the <strong>Emission Map</strong> across the Material’s surface, in object space.</td>
</tr>
<tr>
<td><strong>- Offset</strong></td>
<td>Set an <strong>X</strong> and <strong>Y</strong> offset for the <strong>Emission Map</strong> UV. HDRP uses the <strong>X</strong> and <strong>Y</strong> values to offset the Texture assigned to the <strong>Emission Map</strong> across the Material’s surface, in object space.</td>
</tr>
<tr>
<td><strong>Emission Intensity</strong></td>
<td>Set the overall strength of the emission effect for this Material.<br />
Use the drop-down to select one of the following <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Physical-Light-Units.html">physical light units</a> to use for intensity:<br />
• <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Physical-Light-Units.html#Nits">Nits</a><br />
• <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Physical-Light-Units.html#EV">EV<sub>100</sub></a></td>
</tr>
<tr>
<td><strong>Exposure Weight</strong></td>
<td>Use the slider to set how much effect the exposure has on the emission power. For example, if you create a neon tube, you would want to apply the emissive glow effect at every exposure.</td>
</tr>
<tr>
<td><strong>Emission Multiply with Base</strong></td>
<td>Enable the checkbox to make HDRP use the base color of the Material when it calculates the final color of the emission. When enabled, HDRP multiplies the emission color by the base color to calculate the final emission color.</td>
</tr>
<tr>
<td><strong>Emission</strong></td>
<td>Toggles whether emission affects global illumination.</td>
</tr>
<tr>
<td><strong>- Global Illumination</strong></td>
<td>The mode HDRP uses to determine how color emission interacts with global illumination.<br />
• <strong>Realtime</strong>: Select this option to make emission affect the result of real-time global illumination.<br />
• <strong>Baked</strong>: Select this option to make emission only affect global illumination during the baking process.<br />
• <strong>None</strong>: Select this option to make emission not affect global illumination.</td>
</tr>
</tbody>
</table>

### Advanced options

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
<td><strong>Enable GPU Instancing</strong></td>
<td>Enable the checkbox to tell HDRP to render Meshes with the same geometry and Material in one batch when possible. This makes rendering faster. HDRP cannot render Meshes in one batch if they have different Materials, or if the hardware does not support GPU instancing. For example, you cannot <a href="https://docs.unity3d.com/Manual/DrawCallBatching.html">static-batch</a> GameObjects that have an animation based on the object pivot, but the GPU can instance them.</td>
</tr>
<tr>
<td><strong>Specular Occlusion Mode</strong></td>
<td>The mode that HDRP uses to calculate specular occlusion. The options are:<br />
• <strong>Off</strong>: Disables specular occlusion.<br />
• <strong>From AO</strong>: Calculates specular occlusion from the ambient occlusion map and the Camera's view vector.<br />
• <strong>From AO and Bent Normal</strong>: Calculates specular occlusion from the ambient occlusion map, the bent normal map, and the Camera's view vector. If no bent normal is provided, the normal is used instead.<br />
• <strong>Custom</strong>: Allows you to specify your own specular occlusion values.</td>
</tr>
<tr>
<td><strong>Add Precomputed Velocity</strong></td>
<td><p>Indicates whether to use precomputed velocity information stored in an Alembic file.</p></td>
</tr>
</tbody>
</table>
