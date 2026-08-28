---
title: "Fog volume override reference"
page_title: "Fog Volume Override reference | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/fog-volume-override-reference.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/fog-volume-override-reference.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Fog Volume Override reference

The Fog Volume Override lets you customize a global fog effect.

Refer to [Create a global fog effect](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-global-fog-effect.html) for more information.

## Properties

### API

To access and control this override at runtime, use the [Volume scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#changing-volume-profile-properties). Because of how the Volume system works, you edit properties in a different way to standard Unity components. There are also other nuances to be aware of too, such as each property has an [overrideState](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest/index.html?subfolder=/api/UnityEngine.Rendering.VolumeParameter.html%23UnityEngine_Rendering_VolumeParameter_overrideState). This indicates to the Volume system whether to use the property value you set, or use the default value stored in the [Volume Profile](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-volume-profile.html). For information on how to use the API correctly, see [Volume scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#changing-volume-profile-properties).

To edit properties in any Volume component override, enable the checkbox to the left of the property. This also tells HDRP to use the property value you specify for the Volume component rather than the default value. If you disable the checkbox, HDRP ignores the property you set and uses the Volume’s default value for that property instead.

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr>
<th style="text-align: left;">Property</th>
<th style="text-align: left;">Function</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align: left;"><strong>State</strong></td>
<td style="text-align: left;">Controls whether the fog is enabled.</td>
</tr>
<tr>
<td style="text-align: left;"><strong>Fog Attenuation Distance</strong></td>
<td style="text-align: left;">Controls the density at the base of the fog and determines how far you can see through the fog in meters. At this distance, the fog has absorbed and out-scattered 63% of background light.</td>
</tr>
<tr>
<td style="text-align: left;"><strong>Base Height</strong></td>
<td style="text-align: left;">The height of the boundary between the constant (homogeneous) fog and the exponential fog.</td>
</tr>
<tr>
<td style="text-align: left;"><strong>Maximum Height</strong></td>
<td style="text-align: left;">Controls the rate of falloff for the height fog in meters. Higher values stretch the fog vertically. At this height , the falloff reduces the initial base density by 63%.</td>
</tr>
<tr>
<td style="text-align: left;"><strong>Max Fog Distance</strong></td>
<td style="text-align: left;">Controls the distance (in meters) when applying fog to the skybox or background. Also determines the range of the Distant Fog. For optimal results, set this to be larger than the Camera’s Far value for its Clipping Plane. Otherwise, a discrepancy occurs between the fog on the Scene’s GameObjects and on the skybox. Note that the Camera’s Far Clipping Plane is flat whereas HDRP applies fog within a sphere surrounding the Camera.</td>
</tr>
<tr>
<td style="text-align: left;"><strong>Color Mode</strong></td>
<td style="text-align: left;">Use the drop-down to select the mode HDRP uses to calculate the color of the fog.<br />
• <strong>Sky Color</strong>: HDRP shades the fog with a color it samples from the sky cubemap and its mipmaps.<br />
• <strong>Constant Color</strong>: HDRP shades the fog with the color you set manually in the <strong>Constant Color</strong> field that appears when you select this option.</td>
</tr>
<tr>
<td style="text-align: left;"><strong>- Tint</strong></td>
<td style="text-align: left;">HDR color multiplied with the sky color.<br />
This property only appears when you select <strong>Sky Color</strong> from the <strong>Color Mode</strong> drop-down.</td>
</tr>
<tr>
<td style="text-align: left;"><strong>- Mip Fog Near</strong></td>
<td style="text-align: left;">The distance (in meters) from the Camera that HDRP stops sampling the lowest resolution mipmap for the fog color.<br />
This property only appears when you select <strong>Sky Color</strong> from the <strong>Color Mode</strong> drop-down.</td>
</tr>
<tr>
<td style="text-align: left;"><strong>- Mip Fog Far</strong></td>
<td style="text-align: left;">The distance (in meters) from the Camera that HDRP starts sampling the highest resolution mipmap for the fog color.<br />
This property only appears when you select <strong>Sky Color</strong> from the <strong>Color Mode</strong> drop-down.</td>
</tr>
<tr>
<td style="text-align: left;"><strong>- Mip Fog Max Mip</strong></td>
<td style="text-align: left;">Use the slider to set the maximum mipmap that HDRP uses for the mip fog. This defines the mipmap that HDRP samples for distances greater than <strong>Mip Fog Far</strong>.<br />
This property only appears when you select <strong>Sky Color</strong> from the <strong>Color Mode</strong> drop-down.</td>
</tr>
<tr>
<td style="text-align: left;"><strong>- Constant Color</strong></td>
<td style="text-align: left;">Use the color picker to select the color of the fog.<br />
This property only appears when you select <strong>Constant Color</strong> from the <strong>Color Mode</strong> drop-down.</td>
</tr>
<tr>
<td style="text-align: left;"><strong>Volumetric Fog</strong></td>
<td style="text-align: left;">Indicates whether HDRP should calculate volumetric fog or not.</td>
</tr>
<tr>
<td style="text-align: left;">- <strong>Albedo</strong></td>
<td style="text-align: left;">The color of the volumetric fog to. Volumetric fog tints lighting, so the fog scatters light to this color. It only tints lighting emitted by Lights behind or within the fog. This means that it doesn't tint lighting that reflects off GameObjects behind or within the fog - reflected lighting only gets dimmer (fades to black) as fog density increases. For example, if you shine a Light at a white wall through fog with a red <strong>Albedo</strong>, the fog looks red. If you shine a Light at a white wall and view it from the other side of the fog, the fog darkens the light but doesn’t tint it red.</td>
</tr>
<tr>
<td style="text-align: left;">- <strong>Ambient Light Probe Dimmer</strong></td>
<td style="text-align: left;">The amount to dim the intensity of the global ambient light probe that the sky generates. A value of 0 doesn't dim the light probe and a value of 1 fully dims the light probe.</td>
</tr>
<tr>
<td style="text-align: left;">- <strong>Volumetric Fog Distance</strong></td>
<td style="text-align: left;">The distance (in meters) from the Camera at which the volumetric fog section of the frustum ends.</td>
</tr>
<tr>
<td style="text-align: left;">- <strong>Denoising Mode</strong></td>
<td style="text-align: left;">The denoising technique to use for the volumetric fog. The options are:<br />
• <strong>None</strong>: Applies no denoising.<br />
• <strong>Reprojection</strong>: A denoising technique that's effective for static lighting, but can lead to severe ghosting for highly dynamic lighting.<br />
• <strong>Gaussian</strong>: A denoising technique that's better than <strong>Reprojection</strong> for dynamic lighting.<br />
• <strong>Both</strong>: Applies both <strong>Reprojection</strong> and <strong>Gaussian</strong> techniques. Using both techniques can produce high quality results but significantly increases the resource intensity of the effect.</td>
</tr>
<tr>
<td style="text-align: left;">- <strong>Slice Distribution Uniformity</strong></td>
<td style="text-align: left;">The uniformity of the distribution of slices along the Camera's forward axis. HDRP samples volumetric fog at multiple distances from the Camera. Each of these sample areas is called a slice. A value of 0 makes the distribution of slices exponential (the spacing between the slices increases with the distance from the Camera) which gives greater precision near to the Camera, and lower precision further away. A value of 1 results in a uniform distribution which gives the same level of precision regardless of the distance to the Camera.</td>
</tr>
<tr>
<td style="text-align: left;">- <strong>Quality</strong></td>
<td style="text-align: left;">Specifies the preset HDRP uses to populate the values of the following nested properties. The options are:<br />
• <strong>Low</strong>: A preset that emphasizes performance over quality.<br />
• <strong>Medium</strong>: A preset that balances performance and quality.<br />
• <strong>High</strong>: A preset that emphasizes quality over performance.<br />
• <strong>Custom</strong>: Allows you to override each property individually.<br />
If you select any value other than <strong>Custom</strong>, <strong>Fog Control Mode</strong> switches to <strong>Balance</strong>.</td>
</tr>
<tr>
<td style="text-align: left;">- - <strong>Fog Control Mode</strong></td>
<td style="text-align: left;">Specifies the method to use to control the performance and quality of the volumetric fog. The options are:<br />
• <strong>Balance</strong>: Uses a performance-oriented approach to define the quality of the volumetric fog.<br />
• <strong>Manual</strong>: Gives you access to the internal set of properties which directly control the effect.</td>
</tr>
<tr>
<td style="text-align: left;">- - - <strong>Volumetric Fog Budget</strong></td>
<td style="text-align: left;">The performance to quality ratio of the volumetric fog. A value of 0 being the least resource-intensive and a value of 1 being the highest quality.<br />
This property only appears if you set <strong>Fog Control Mode</strong> to <strong>Balance</strong>.</td>
</tr>
<tr>
<td style="text-align: left;">- - - <strong>Resolution Depth Ratio</strong></td>
<td style="text-align: left;">The ratio HDRP uses to share resources between the screen (x-axis and y-axis) and the depth (z-axis) resolutions.<br />
This property only appears if you set <strong>Fog Control Mode</strong> to <strong>Balance</strong>.</td>
</tr>
<tr>
<td style="text-align: left;">- - - <strong>Screen Resolution Percentage</strong></td>
<td style="text-align: left;">The resolution of the volumetric buffer (3D texture) along the x-axis and y-axis relative to the resolution of the screen.<br />
This property only appears if you set <strong>Fog Control Mode</strong> to <strong>Manual</strong>.</td>
</tr>
<tr>
<td style="text-align: left;">- - - <strong>Volume Slice Count</strong></td>
<td style="text-align: left;">The number of slices to use for the volumetric buffer (3D texture) along the camera's focal axis.<br />
This property only appears if you set <strong>Fog Control Mode</strong> to <strong>Manual</strong>.</td>
</tr>
<tr>
<td style="text-align: left;">- <strong>Directional Lights Only</strong></td>
<td style="text-align: left;">Indicates whether HDRP only process volumetric fog for directional <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Light-Component.html">Lights</a> or for all Lights. Including non-directional Lights increases the resource intensity of the effect.</td>
</tr>
<tr>
<td style="text-align: left;">- <strong>Anisotropy</strong></td>
<td style="text-align: left;">Controls the angular distribution of scattered light. 0 is isotropic, 1 is forward scattering, and -1 is backward scattering. Note that non-zero values have a moderate performance impact. High values may have compatibility issues with the <strong>Enable Reprojection for Volumetrics</strong> Frame Setting. This is an experimental property that HDRP applies to both global and local fog.</td>
</tr>
<tr>
<td style="text-align: left;">- <strong>Multiple Scattering Intensity</strong></td>
<td style="text-align: left;">Specifies how much light is scattered the further away from the camera.</td>
</tr>
</tbody>
</table>

## Light-specific Properties

The [Light component](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Light-Component.html) has several properties that are useful for volumetric lighting:

- **Emission Radius** is useful to simulate fill lighting. It acts by virtually "pushing" the light away from the Scene. As a result, it softens the core of [punctual lights](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Glossary.html#PunctualLight). Always use a non-zero value to reduce ghosting artifacts resulting from reprojection.
- **Volumetric Multiplier** only affects the fog and replaces the Light Multiplier that HDRP uses for surfaces.
- **Shadow Dimmer** only affects the fog and replaces the Shadow Dimmer that HDRP uses for surfaces.
