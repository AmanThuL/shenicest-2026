---
title: "Diffusion Profile reference"
page_title: "Diffusion Profile reference | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/diffusion-profile-reference.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/diffusion-profile-reference.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Diffusion Profile reference

The High Definition Render Pipeline (HDRP) stores most [Subsurface Scattering](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/skin-and-diffusive-surfaces-subsurface-scattering.html) settings in a **Diffusion Profile** Asset. You can assign a **Diffusion Profile** Asset directly to Materials that use Subsurface Scattering.

To create a Diffusion Profile, navigate to **Assets \> Create \> Rendering \> HDRP Diffusion Profile**. For HDRP to detect it, you must add it to the **Diffusion Profile List** of the [Diffusion Profile List Component](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Override-Diffusion-Profile.html) in an active [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/volume-component.html).

## Properties

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr>
<th style="text-align: left;">Property</th>
<th style="text-align: left;">Description</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align: left;"><strong>Name</strong></td>
<td style="text-align: left;">The name of the Diffusion Profile.</td>
</tr>
<tr>
<td style="text-align: left;"><strong>Scattering Color</strong></td>
<td style="text-align: left;">Use the color picker to define the shape of the Diffusion Profile. It should be similar to the diffuse color of the material.<br />
This affects the Transmission color.</td>
</tr>
<tr>
<td style="text-align: left;"><strong>Multiplier</strong></td>
<td style="text-align: left;">Acts as a multiplier on the scattering color to control how far light travels below the surface. Controls the effective radius of the filter.<br />
This affects the Transmission color.</td>
</tr>
<tr>
<td style="text-align: left;"><strong>Max Radius</strong></td>
<td style="text-align: left;">The maximum radius of the effect you define in <strong>Scattering Color</strong> and <strong>Multiplier</strong>. The size of this value depends on the world scale. For example, when the world scale is 1, this value is in millimeters. When the world scale is 0.001, this value is in meters.<br />
<br />
When the size of this radius is smaller than a pixel on the screen, HDRP doesn't apply Subsurface Scattering.</td>
</tr>
<tr>
<td style="text-align: left;"><strong>Index of Refraction</strong></td>
<td style="text-align: left;">This value is controlled by the highest of the <strong>Scattering Distance</strong> RGB values. Use the slider to set the refractive behavior of the Material. Larger values increase the intensity of specular reflection. For example, the index of refraction of skin is about 1.4. For more example values for the index of refraction of different materials, see Pixel and Poly’s <a href="https://pixelandpoly.com/ior.html">list of indexes of refraction values</a>.</td>
</tr>
<tr>
<td style="text-align: left;"><strong>World Scale</strong></td>
<td style="text-align: left;">Controls the scale of Unity’s world units for this Diffusion Profile. By default, HDRP assumes that 1 Unity unit is 1 meter. This property only affects the subsurface scattering pass.</td>
</tr>
</tbody>
</table>

### Subsurface Scattering only

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr>
<th style="text-align: left;">Property</th>
<th style="text-align: left;">Description</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align: left;"><strong>Texturing Mode</strong></td>
<td style="text-align: left;">Use the drop-down to select when HDRP applies the albedo of the Material.<br />
• <strong>Post-Scatter</strong>: HDRP applies the albedo to the Material after the subsurface scattering pass. This means that the contents of the albedo texture aren't blurred. Use this mode for scanned data and photographs that already contain some blur due to subsurface scattering.<br />
• <strong>Pre- and Post-Scatter</strong>: Albedo is partially applied twice, before and after the subsurface scattering pass. Effectively, this blurs the albedo, resulting in a softer, more natural look.</td>
</tr>
<tr>
<td style="text-align: left;"><strong>Dual Lobe Multipliers</strong></td>
<td style="text-align: left;">Sets how much to multiply the material's base smoothness by, to calculate the smoothness of the primary and secondary specular lobes.</td>
</tr>
<tr>
<td style="text-align: left;"><strong>Lobe Mix</strong></td>
<td style="text-align: left;">Controls how HDRP mixes the primary and secondary specular lobes. The default is 0.5, which means HDRP mixes the specular lobes equally. A value of 0 means HDRP only uses the primary specular lobe. A value of 1 means HDRP only uses the secondary specular lobe.</td>
</tr>
<tr>
<td style="text-align: left;"><strong>Diffuse Shading Power</strong></td>
<td style="text-align: left;">Controls the exponent on the cosine component of the diffuse lobe. Use this to better simulate diffuse lighting on surfaces with strong subsurface scattering.</td>
</tr>
</tbody>
</table>

The following image displays the effect of each Texturing Mode option on a human face model:

![Three versions of a close-up view of a pair of lips. Subsurface Scattering (Disabled): the textured lines on the lips and the shadows are clear. Subsurface Scattering (Post-Scatter): the lines and shadows are blurrier. Subsurface Scattering (Pre and Post-Scatter): the lines and shadows are even blurrier.](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/profile_texturing_mode.png)

To simulate the thin oily layer on the skin of lips, HDRP uses two specular lobes (dual lobes). A specular lobe is the shape of light reflecting off the surface, based on the smoothness of the surface.

For performance reasons, if light from a Reflection Probe, Planar Reflection Probe or Screen Space Reflection reflects off a Lit material, HDRP evaluates only a single lobe that has the base smoothness of the material.

If you use the StackLit shader, set the **Dual Specular Lobe Parametrization** to **From Diffusion Profile** in the [StackLit Master Stack](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/stacklit-master-stack-reference.html) so you can control the specular lobes using the settings in the Diffusion Profile. Otherwise you control the smoothness using the settings in the shader graph.

The following image shows the effect of dual lobes on a human face model, with **Lobe Mix** set to 0.5.

![Four versions of a close-up view of a nose and mouth. The first lobe has a smoothess of 0.8, and little specular light. The second lobe has a smoothness of 1.2, and a greater amount of specular light on the nose and lips. The Lobe Mix of 0.5 has a look that's between the two. The final image is the full color result.](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/profile_dual_lobe.png)

The following image shows the effect of increasing **Diffuse Shading Power** on a human face model.

![](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/profile_diffuse_power.jpg) ![](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/profile_diffuse_power-2.jpg)

\
Drag the slider to compare the images.

### Transmission only

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr>
<th style="text-align: left;">Property</th>
<th style="text-align: left;">Description</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align: left;"><strong>Transmission Mode</strong></td>
<td style="text-align: left;">Use the drop-down to determine how HDRP calculates light transmission:<br />
• <strong>Thick Object</strong>: Select this mode for geometrically thick objects. This mode uses shadow maps. Shadow maps of directional lights aren't precise enough to use to estimate thickness. Directional lights instead use the <strong>Transmission Multiplier</strong> setting from the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/reference-shadows-volume-override.html">Shadows volume component</a> to scale transmission.<br />
• <strong>Thin Object</strong>: Select this mode for thin, double-sided geometry.</td>
</tr>
<tr>
<td style="text-align: left;"><strong>Transmission Tint</strong></td>
<td style="text-align: left;">Specifies the tint of the translucent lighting (that's transmitted through objects). The color of transmitted light depends on the <strong>Scattering Color</strong>.</td>
</tr>
<tr>
<td style="text-align: left;"><strong>Min-Max Thickness (mm)</strong></td>
<td style="text-align: left;">Sets the range of thickness values (in millimeters) corresponding to the [0, 1] range of texel values stored in the Thickness Map. This range corresponds to the minimum and maximum values of the Thickness Remap (mm) slider below.</td>
</tr>
<tr>
<td style="text-align: left;"><strong>Thickness Remap (mm)</strong></td>
<td style="text-align: left;">Sets the range of thickness values (in millimeters) corresponding to the [0, 1] range of texel values stored in the Thickness Map. This range is displayed by the Min-Max Thickness (mm) fields above.</td>
</tr>
</tbody>
</table>

The image below displays a human ear model without transmission (left) and with a configured **Thickness Remap** value (right):

![Two images of an ear in very bright light. Light is visible through he ear on the right.](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/transmission_thick.png)

### Profile Previews

| Property | Description |
|:---|:---|
| **Profile Preview** | Displays the fraction of lights scattered from the source located in the center. The distance to the boundary of the image corresponds to the Max Radius. |
| **Transmission Preview** | Displays the fraction of light passing through the GameObject depending on the values from the Thickness Remap (mm). |

## Working with different Transmission Modes

The main difference between the two **Transmission Modes** is how they use shadows. If you disable shadows on your Light, both **Transmission Modes** give the same results, and derive their appearance from the **Thickness Map** and the **Diffusion Profile**. The results change if you enable shadows. The **Thin Object** mode (that only evaluates shadowing once, at the front face) is likely to cause self-shadowing issues (for thick objects) that can cause the object to appear completely black. The **Thick Object** mode derives the thickness from the shadow map, taking the largest value between the baked thickness and the shadow thickness, and uses this to evaluate the light transmittance.

Because you can't control the distances HDRP derives from the shadow map, the best way to approach **Thick Object** is to enable shadows, then adjust the **Scattering Distance** until the overall transmission intensity is in the desired range, and then use the **Thickness Map** to mask any shadow mapping artifacts.
