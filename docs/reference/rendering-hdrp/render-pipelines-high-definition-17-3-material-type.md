---
title: "Material Type reference"
page_title: "Material Type | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Material-Type.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Material-Type.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Material Type

The **Material Type** property allows you to give your Material a type, which allows you to customize it with different settings depending on the **Material Type** you select. Each has a different workflow and so use the **Material Type** that is most suitable for the Material you are creating.

| **Material Type** | **Description** |
|----|----|
| **Subsurface Scattering** | Applies the subsurface scattering workflow to the Material. Subsurface scattering simulates the way light interacts with and penetrates translucent objects, such as skin. When light penetrates the surface of a subsurface scattering Material, it scatters and blurs before exiting the surface at a different point. |
| **Standard** | Applies the basic metallic Shader workflow to the Material. This is the default **Material Type**. |
| **Anisotropy** | Applies the anisotropic workflow to the Material. The highlights of Anisotropic surfaces change in appearance as you view the Material from different angles. Use this **Material Type** to create Materials with anisotropic highlights. For example, brushed metal or velvet. |
| **Iridescence** | Applies the Iridescence workflow to the Material. Iridescent surfaces appear to gradually change color as the angle of view or angle of illumination changes. Use this **Material Type** to create Materials like soap bubbles, iridescent metal, or insect wings. |
| **Specular Color** | Applies the Specular Color workflow to the Material. Use this **Material Type** to create Materials with a coloured specular highlight. For more information, refer to [Metallic and specular workflows](https://docs.unity3d.com/Documentation/Manual/StandardShaderMetallicVsSpecular.html). |
| **Translucent** | Applies the Translucent workflow to the Material. Use this **Material Type**, and a thickness map, to simulate a translucent object, such as a plant leaf. In contrast to **Subsurface Scattering** Materials, **Translucent** Materials do not blur light that transmits through the Material. |

![A detailed dragon statuette, rendered three times. The first dragon is iridescent, the second is a translucent green material, and the third has subsurface scattering.](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/MaterialType1.png)

## Properties

Unity exposes different properties for your Material depending on the **Material Types** you select.

### Surface Options

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
<td><strong>Transmission</strong></td>
<td>Enable the checkbox to make HDRP simulate the translucency of an object using a thickness map. Configure subsurface scattering and transmission settings using a <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/diffusion-profile-reference.html">Diffusion Profile</a>. For more information, see documentation on <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/skin-and-diffusive-surfaces-subsurface-scattering.html">Subsurface Scattering</a>.<br />
This property only appears when you select <strong>Subsurface Scattering</strong> from the <strong>Material Type</strong> drop-down.</td>
</tr>
</tbody>
</table>

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
<td><strong>Metallic</strong></td>
<td>Use the slider to adjust how metal-like the surface of your Material is (between 0 and 1). When a surface is more metallic, it reflects the environment more and its albedo color becomes less visible. At full metallic level, environmental reflections fully drive the surface color. When a surface is less metallic, its albedo color is clearer and any surface reflections are visible on top of the surface color, rather than obscuring it.<br />
This property only appears when you select <strong>Standard</strong>, <strong>Anisotropy</strong>, or <strong>Iridescence</strong> from the <strong>Material Type</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Diffusion Profile</strong></td>
<td>Assign a <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/diffusion-profile-reference.html">Diffusion Profile</a> to drive the behavior of subsurface scattering. To quickly view the currently selected Diffusion Profile’s Inspector, double click the Diffusion Profile Asset in the assign field. If you do not assign a Diffusion Profile, HDRP does not process the subsurface scattering.<br />
This property only appears when you select <strong>Subsurface Scattering</strong> or <strong>Translucent</strong> from the <strong>Material Type</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Subsurface Mask Map</strong></td>
<td>Assign a grayscale Texture, with values from 0 to 1, that controls the strength of the blur effect across the Material. A texel with a value of 1 corresponds to full strength, while those with a value of 0 disables the Subsurface Scattering blur effect.<br />
This property only appears when you select <strong>Subsurface Scattering</strong> from the <strong>Material Type</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Subsurface Mask</strong></td>
<td>Use the slider to set the strength of the screen-space blur effect. If you set a <strong>Subsurface Mask Map</strong>, this acts as a multiplier for that map. If you do not set a Subsurface Mask Map, this increases the entire subsurface scattering effect on this Material.<br />
This property only appears when you select <strong>Subsurface Scattering</strong> from the <strong>Material Type</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Transmission Mask Map</strong></td>
<td>Assign a grayscale Texture, with values from 0 to 1, that controls the strength of transmitted light across the Material. A texel with a value of 1 corresponds to full strength, while those with a value of 0 disables the Transmission effect.<br />
This property only appears when <strong>Material Type</strong> is set to <strong>Translucent</strong> or if it is set to <strong>Subsurface Scattering</strong> and <strong>translucent</strong> option is enabled.</td>
</tr>
<tr>
<td><strong>Transmission Mask</strong></td>
<td>Use the slider to set the strength of the transmission effect. If you set a <strong>Transmission Mask Map</strong>, this acts as a multiplier for that map.<br />
This property only appears when <strong>Material Type</strong> is set to <strong>Translucent</strong> or if it is set to <strong>Subsurface Scattering</strong> and <strong>translucent</strong> option is enabled.</td>
</tr>
<tr>
<td><strong>Thickness Map</strong></td>
<td>Assign a grayscale Texture, with values from 0 to 1, that correspond to the average thickness of the Mesh at the location of the texel. Higher values mean thicker areas, and thicker areas transmit less light.<br />
This property only appears when you select <strong>Subsurface Scattering</strong> or <strong>Translucent</strong> from the <strong>Material Type</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Thickness</strong></td>
<td>Use the slider to set the strength of the transmission effect. Multiplies the Thickness Map.<br />
This property only appears when you select <strong>Subsurface Scattering</strong> or <strong>Translucent</strong> from the <strong>Material Type</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Tangent Map</strong></td>
<td>Assign a Texture that defines the direction of the anisotropy effect of a pixel, in tangent space. This stretches the specular highlights in the given direction.<br />
This property only appears when you select <strong>ObjectSpace</strong> from the <strong>Normal Map Space</strong> drop-down and <strong>Anisotropy</strong> from the <strong>Material Type</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Tangent Map OS</strong></td>
<td>Assign a Texture that defines the direction of the anisotropy effect of a pixel, in object space. This stretches the specular highlights in the given direction.<br />
This property only appears when you select <strong>TangentSpace</strong> from the <strong>Normal Map Space</strong> drop-down and <strong>Anisotropy</strong> from the <strong>Material Type</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Anisotropy</strong></td>
<td>Use the slider to set the direction of the anisotropy effect. Negative values make the effect vertical, and positive values make the effect horizontal. This stretches the specular highlights in the given direction.<br />
This property only appears when you select <strong>Anisotropy</strong> from the <strong>Material Type</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Anisotropy Map</strong></td>
<td>Assign a Texture, with values from 0 to 1, that controls the strength of the anisotropy effect. HDRP only uses the red channel of this Texture to calculate the strength of the effect.<br />
This property only appears when you select <strong>Anisotropy</strong> from the <strong>Material Type</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Iridescence Mask</strong></td>
<td>Assign a Texture, with values from 0 to 1, that controls the strength of the iridescence effect. A texel with a value of 1 corresponds to full strength, while those with a value of 0 disables the iridescence effect.<br />
This property only appears when you select <strong>Iridescence</strong> from the <strong>Material Type</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Iridescence Layer Thickness map</strong></td>
<td>Assign a Texture, with values from 0 to 1, that controls the thickness of the thin iridescence layer over the material. This modifies the color of the effect. Unit is micrometer multiplied by 3. A value of 1 is remapped to 3 micrometers or 3000 nanometers.<br />
This property only appears when you select <strong>Iridescence</strong> from the <strong>Material Type</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Iridescence Layer Thickness remap</strong></td>
<td>Use this min-max slider to remap the thickness values from the <strong>Iridescence Layer Thickness map</strong> to the range you specify. Rather than <a href="https://docs.unity3d.com/ScriptReference/Mathf.Clamp.html">clamping</a> values to the new range, Unity condenses the original range down to the new range uniformly.<br />
This property only appears when you select <strong>Iridescence</strong> from the <strong>Material Type</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Specular Color</strong></td>
<td>Allows you to manually define the specular color. You can assign a Texture to define the specular color on a pixel level and use the color picker to select a global specular color for the Material. If you do both, HDRP multiplies each pixel of the Texture by the color you specify in the color picker.<br />
This property only appears when you select <strong>Specular Color</strong> from the <strong>Material Type</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Energy Conserving Specular Color</strong></td>
<td>Enable the checkbox to make HDRP reduce the diffuse color of the Material if the specular effect is more intense. This makes the lighting of the Material more consistent, which makes the Material look more physically accurate.<br />
This property only appears when you select <strong>Specular Color</strong> from the <strong>Material Type</strong> drop-down.</td>
</tr>
</tbody>
</table>
