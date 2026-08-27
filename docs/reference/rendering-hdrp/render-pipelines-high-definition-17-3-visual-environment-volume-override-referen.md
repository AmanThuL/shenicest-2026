---
title: "Visual Environment volume override reference"
page_title: "Visual Environment volume override reference | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/visual-environment-volume-override-reference.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/visual-environment-volume-override-reference.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Visual Environment volume override reference

The Visual Environment Volume Override lets you change the type of sky the High Definition Render Pipeline (HDRP) uses, and configure the sky and clouds.

Refer to [Sky](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/sky.html) for more information.

## Properties

To edit properties in any Volume component override, enable the checkbox to the left of the property. This also tells HDRP to use the property value you specify for the Volume component rather than the default value. If you disable the checkbox, HDRP ignores the property you set and uses the Volume’s default value for that property instead.

### Sky

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
<td><strong>Sky Type</strong></td>
<td>Use the drop-down to select the type of sky that HDRP renders when this Volume affects a Camera. This list automatically updates when you <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-custom-sky.html">create a custom Sky</a>.<br />
• <strong>None</strong>: HDRP doesn't render a sky for Cameras in this Volume.<br />
• <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-gradient-sky.html">Gradient Sky</a>: Renders the top, middle, and bottom sections of the sky using three separate color zones. HDRP controls the size of these color zones using the Gradient Sky’s <strong>Gradient Diffusion</strong> property.<br />
• <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-an-hdri-sky.html">HDRI Sky</a>: Uses a cubemap texture to represent the entire sky.<br />
• <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-physically-based-sky.html">Physically Based Sky</a>: Simulates the sky of a spherical planet with a two-part atmosphere which has an exponentially decreasing density with respect to its altitude.<br />
• Procedural Sky: Generates a sky based on properties such as, <strong>Sky Tint</strong>, <strong>Ground Color</strong>, and <strong>Sun Size</strong>. HDRP deprecated <strong>Procedural Sky</strong> in 2019.3 and replaced it with <strong>Physically Based Sky</strong>. To use Procedural Sky for HDRP Projects in Unity 2019.3 or later, follow the instructions on the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Upgrading-from-2019.2-to-2019.3.html#ProceduralSky">Upgrading from 2019.2 to 2019.3 guide</a>.<br />
<br />
Note: If you select any option that's not <strong>None</strong>, make sure the respective sky <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/configure-volume-overrides.html">Volume override</a> exists in a Volume in you Scene. For example, if you select <strong>Gradient Sky</strong>, your Scene must contain a Volume with a <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/gradient-sky-volume-override-reference.html">Gradient Sky</a> override.</td>
</tr>
<tr>
<td><strong>Background Clouds</strong></td>
<td>Use the drop-down to select the type of clouds that HDRP renders when this Volume affects a Camera. The options are:<br />
• <strong>None</strong>: Doesn't render any clouds.<br />
• <strong>Cloud Layer</strong>: Renders clouds using the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Override-Cloud-Layer.md">Cloud Layer system</a>.<br />
This list automatically updates when you <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Creating-Custom-Clouds.md">create custom clouds</a>.<br />
For more information, refer to the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Clouds-In-HDRP.md">clouds in HDRP documentation</a>.</td>
</tr>
<tr>
<td><strong>Ambient Mode</strong></td>
<td>Use the drop-down to select the mode this Volume uses to process ambient light.<br />
• <strong>Static</strong>: Ambient light comes from the baked sky assigned to the <strong>Static Lighting Sky</strong> property in the Lighting window. This light affects both real-time and baked global illumination. For information on how to set up environment lighting, see the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Environment-Lighting.html#lighting-environment">Environment Lighting documentation</a>.<br />
• <strong>Dynamic</strong>: Ambient light comes from the sky that you set in the <strong>Sky</strong> &gt; <strong>Type</strong> property of this override. This means that ambient light can change in real time depending on the current Volume affecting the Camera. If you use baked global illumination, changes to the environment lighting only affect GameObjects exclusively lit using Ambient Probes. If you use real-time global illumination, changes to the environment lighting affect both lightmaps and Ambient Probes.</td>
</tr>
</tbody>
</table>

### Planet

The planet settings will impact various environment effects like Volumetric Clouds, Fog and Physically Based Sky.

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
<td><strong>Radius</strong></td>
<td>The radius of the planet in kilometers. The radius is the distance from the center of the planet to the sea level.</td>
</tr>
<tr>
<td><strong>Rendering Space</strong></td>
<td>Indicates the space in which HDRP computes the various environement effects. The options are:<br />
• <strong>Camera</strong>: Use this option when the camera stays on the ground and do not need to go high in the atmosphere. This mode allow the various effects to use faster and more memory efficient variants.<br />
• <strong>World</strong>: Use this option when you need the camera to fly through the volumetric clouds or go outside of the atmosphere.</td>
</tr>
<tr>
<td><strong>- Center</strong></td>
<td>The center is used when defining where the planet's surface is. In automatic mode, the top of the planet is at the world's origin and the center is derived from the planet radius. Only available when <strong>Rendering Space</strong> is set to <strong>World</strong></td>
</tr>
<tr>
<td><strong>- Position</strong></td>
<td>The world-space position of the planet's center in kilometers. Only available when <strong>Center</strong> is set to <strong>Manual</strong>.</td>
</tr>
</tbody>
</table>

### Wind

| **Property** | **Description** |
|----|----|
| **Global Orientation** | Controls the orientation of the wind relative to the world-space direction x-axis. |
| **Global Speed** | Sets the global wind speed in kilometers per hour. |
