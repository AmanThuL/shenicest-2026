---
title: "Reflection Probe reference (HDRP)"
page_title: "Reflection probe reference | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Reflection-Probe.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Reflection-Probe.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Reflection probe reference

The Reflection Probe component is one of the types of [Reflection Probes](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Reflection-Probes-Intro.html) that the High Definition Render Pipeline (HDRP) provides to help you create reactive and accurate reflective Materials.

## Properties

The HDRP Reflection Probe uses the [built-in render pipeline Reflection Probe](https://docs.unity3d.com/Manual/class-ReflectionProbe.html) as a base, and thus shares many properties with the built-in version. HDRP Reflection Probes also share many properties with the [HDRP Planar Reflection Probe](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Planar-Reflection-Probe.html).

### General Properties

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
<td><strong>Type</strong></td>
<td>Use the drop-down to select the mode this Reflection Probe uses to capture a view of the Scene. Reflective Materials query this capture to process reflections for their surface.<br />
• <strong>Realtime</strong>: Makes the Reflection Probe capture a view of the Scene in real time. Use the <strong>Realtime Mode</strong> property to set the time period.<br />
• <strong>Custom</strong>: Allows you to assign a cubemap Texture to act as the Reflection Probe's captured view of the Scene. Use the <strong>Texture</strong> property to assign the cubemap.<br />
• <strong>Baked</strong>: Makes the Reflection Probe use a static cubemap Texture at runtime. You must bake this Texture before you build your Unity Project. In this mode, the Reflection Probe does not capture GameObjects have their Reflection Probe Static flag disabled.</td>
</tr>
<tr>
<td><strong>Realtime Mode</strong></td>
<td>Use the drop-down to select how often the Reflection Probe should capture a view of the Scene.<br />
• <strong>Every Frame</strong>: Updates the Probe’s capture data every frame.<br />
• <strong>On Enable</strong>: Updates the Probe’s capture data each time Unity calls the component’s <code>OnEnable()</code> function. This occurs whenever you enable the component in the Inspector or activate the GameObject that the component attaches to.<br />
• <strong>On Demand</strong>: Updates the Probe's capture data when you request it. To do this, access the Probe's <code>HDAdditionalReflectionData</code> and call the <code>RequestRenderNextUpdate()</code> function.<br />
This property only appears when you select <strong>Realtime</strong> from the <strong>Type</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Time Slicing</strong></td>
<td>Enable the checkbox to distribute realtime updates over 7 frames (one for each cubemap face then one to process the result) instead of fully updating in a single frame.<br />
This property only appears when you select <strong>Realtime</strong> from the <strong>Type</strong> drop-down, and only for Reflection Probes (not Planar Reflection Probes).</td>
</tr>
<tr>
<td><strong>Texture</strong></td>
<td>Assign a Texture for the Reflection Probe to use as its captured view of the Scene.<br />
This property only appears when you select <strong>Custom</strong> from the <strong>Type</strong> drop-down.</td>
</tr>
</tbody>
</table>

### Projection Settings

The following properties control the projection settings for this Reflection Probe.

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
<td><strong>Proxy Volume</strong></td>
<td>The <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Reflection-Proxy-Volume.html">Reflection Proxy Volume</a> this Probe uses to correct displacement issues between the Probe’s capture point (<strong>Mirror Position</strong>) and the position of the reflective Material using the Texture this Probe captures. Note: The <strong>Proxy Volume</strong> you assign must be the same <strong>Shape</strong> as the Influence Volume.</td>
</tr>
<tr>
<td><strong>Use Influence Volume As Proxy Volume</strong></td>
<td>Enable the checkbox to use the boundaries of the Influence Volume as the Proxy Volume.<br />
This property only appears when you have not set a Reflection Proxy Volume to the <strong>Proxy Volume</strong> property.</td>
</tr>
<tr>
<td><strong>Distance Based Roughness</strong></td>
<td>Enable the checkbox to used the assigned Proxy Volume to calculate distance based roughness for reflections. This produces more physically-accurate results if the Proxy Volume closely matches the environment. This option should be disable if the Proxy Volume don't matches the environment.</td>
</tr>
</tbody>
</table>

<span id="InfluenceVolume"></span>

### Influence Volume

The Influence Volume defines the area around the Probe in which reflective Materials use the results that the Probe captures to influence the reflective behavior of their surface. The Probe also uses the bounds of the Influence Volume to calculate **Field Of View** if you don’t provide an override value.

<span id="Workflows"></span>

There are two workflows you can use to edit your Reflection Probe’s Influence Volume: **Normal** mode and **Advanced** mode. The two buttons in the top right of the **Influence Volume** section allow you to select which mode to use.

- **Normal** mode allows you to set a single value for the **Blend Distance**. You can use **Normal** mode with **Box** and **Sphere** Influence Volumes.
- **Advanced** mode exposes the **Face Fade** property. It also allows you to set **Face Fade**, **Blend Distance**, and **Blend Normal Distance**, on a per axis, per direction basis for an Influence Volume with a **Box Shape**.

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
<td><strong>Shape</strong></td>
<td>Defines the shape of the Influence Volume. The possible values are <strong>Box</strong> and <strong>Sphere</strong>. Selecting <strong>Sphere</strong> disables <strong>Advanced</strong> mode because you can only use <strong>Advanced</strong> mode for <strong>Box</strong> Influence Volumes.</td>
</tr>
<tr>
<td><strong>Box Size</strong></td>
<td>Defines the scale of each axis of the box that represents the Influence Volume. Only available with a <strong>Box Shape</strong>.</td>
</tr>
<tr>
<td><strong>Radius</strong></td>
<td>Defines the radius of the sphere that represents the Influence Volume. Only available with a <strong>Sphere Shape</strong>.</td>
</tr>
<tr>
<td><strong>Blend Distance</strong></td>
<td>The inward distance from the <strong>Box Size</strong> or <strong>Radius</strong> at which this Reflection Probe blends with other Reflection Probes. In <strong>Normal</strong> mode, this property is a single value that modulates the distance at which this Reflection Probe blends with other Reflection Probes in every direction. This mode is available for <strong>Box</strong> or <strong>Sphere</strong> Influence Volumes.In <strong>Advanced</strong> mode, this property uses six values, one for each side of the box. Use each of the six input fields to define the blend distance in each direction. For example, <strong>Y</strong> defines the blending distance for the face at the top of the box and <strong>-Y</strong> defines the blending distance for the face on the bottom. This mode is only available for <strong>Box</strong> Influence Volumes. This feature is only available for <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Forward-And-Deferred-Rendering.html">deferred</a> Reflection Probes.</td>
</tr>
<tr>
<td><strong>Blend Normal Distance</strong></td>
<td>The area around the Reflection Probe where normals pointing away from the capture position don’t receive any influence from this probe.<br />
1. A pixel on a reflective surface outside of the <strong>Blend Normal Influence</strong> volume receives a blended influence from this Probe.<br />
2. The pixel receives no influence from this Probe if it has a normal pointing away from the <strong>Capture Position</strong>. This is useful when you have a building with a Probe inside that has an Influence Volume larger than the building itself. Setting the <strong>Blend Normal Distance</strong> to be less than the buildings size means that the Probe does not affect the outside facing walls of the building.<br />
This property is only available for deferred Reflection Probes.</td>
</tr>
<tr>
<td><strong>Face Fade</strong></td>
<td>Defines a fade value for each direction on each axis of an Influence Volume with a <strong>Box Shape</strong>. Reflection Probes fade out the Reflection Probe’s effect on reflective Materials based on these values. Only available in <strong>Advanced</strong> mode.</td>
</tr>
</tbody>
</table>

### Capture Settings

The following properties control the method that the Reflection Probe uses to capture its surroundings..

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
<td><strong>Capture Position</strong></td>
<td>The position, relative to the Transform Position, from which the Reflection Probe captures its surroundings.</td>
</tr>
<tr>
<td><strong>Clear Mode</strong></td>
<td>Defines how to fill empty background areas of the RenderTexture this Probe captures.<br />
• <strong>Sky</strong> uses the sky defined by the current <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html">Volume</a> settings to fill empty background areas.<br />
• <strong>Background</strong> uses the <strong>Background Color</strong> property to fill empty background areas.<br />
• <strong>None</strong> reuses the previous value for each pixel that doesn’t represent a reflected GameObject, instead of filling in empty areas of the RenderTexture.</td>
</tr>
<tr>
<td><strong>Background Color</strong></td>
<td>The color to fill empty background areas of the RenderTexture if you set the <strong>Clear Mode</strong> to <strong>Background</strong>.</td>
</tr>
<tr>
<td><strong>Clear Depth</strong></td>
<td>Choose whether the Reflection Probe clears the Depth Buffer or not.</td>
</tr>
<tr>
<td><strong>Volume Layer Mask</strong></td>
<td>A LayerMask that defines which Volumes affect this Reflection Probe’s capture.</td>
</tr>
<tr>
<td><strong>Volume Anchor Override</strong></td>
<td>Set the Transform that the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html">Volume</a> system uses to handle the position of this Reflection Probe. For example, if you want this Reflection Probe to match post-processing effects with the view Camera, set this property to the view Camera’s Transform. The Volume system then uses the Camera’s position to process which Volume affects this Reflection Probe.</td>
</tr>
<tr>
<td><strong>Use Occlusion Culling</strong></td>
<td>Enables <a href="https://docs.unity3d.com/Manual/OcclusionCulling.html">Occlusion Culling</a> for this Reflection Probe.</td>
</tr>
<tr>
<td><strong>Culling Mask</strong></td>
<td>A LayerMask that defines which Layers to include in the reflection. GameObjects on the Layers included in this LayerMask appear in the reflection.</td>
</tr>
<tr>
<td><strong>Clip Planes - Near</strong></td>
<td>The closest point relative to the Reflection Probe that the Probe captures reflections.</td>
</tr>
<tr>
<td><strong>Clip Planes - Far</strong></td>
<td>The furthest point relative to the Reflection Probe that it captures reflections.</td>
</tr>
<tr>
<td><strong>Probe Layer Mask</strong></td>
<td>Acts as a culling mask for environment lights (light from Planar Reflection Probes and Reflection Probes). This Reflection Probe ignores all Reflection Probes that are on Layers not included in this Layer mask, so use this property to ignore certain Reflection Probes when rendering this one.</td>
</tr>
<tr>
<td><strong>Custom Frame Settings</strong></td>
<td>Allows you to define custom <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Frame-Settings.html">Frame Settings</a> for this Probe. Disable this property to use the <strong>Default Frame Settings</strong> in your Unity Project’s <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html">HDRP Asset</a>.</td>
</tr>
<tr>
<td><strong>Resolution</strong></td>
<td>Select a quality mode to determine the resolution of this Reflection Probe. If you select Custom, you must specify a resolution in the dropdown menu. Higher resolutions increase the fidelity of cube reflections but can reduce GPU performance and increase memory consumption. The resolution can be set to 0 to prevent the probe from being rendered for certain quality levels.</td>
</tr>
<tr>
<td><strong>Range Compression Factor</strong></td>
<td>The factor which HDRP divides the result of the probe's rendering by. This is useful to deal with very bright or dark objects in the reflections that would otherwise be saturated.<br />
This property only appears when you enable <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest?subfolder=/manual/advanced-properties.html">advanced properties</a> for this section.</td>
</tr>
</tbody>
</table>

### Render Settings

The following properties control extra behavior options for fine-tuning the behavior of your Reflection Probes.

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
<td><strong>Rendering Layer Mask</strong></td>
<td>A mask that allows you to choose which Rendering Layers this Reflection Probe affects. This Reflection Probe only affects Mesh Renderers or Terrain with a matching <strong>Rendering Layer Mask</strong>.<br />
Navigate to your Project’s <strong>HDRP Asset &gt; Render Pipeline Supported Features</strong> and enable <strong>Light Layers</strong> to use this property.</td>
</tr>
<tr>
<td><strong>Importance</strong></td>
<td>A value that indicates the relative priority of this Reflection Probe for sorting. Unity renders probes with a higher value on top of those with a lower value.</td>
</tr>
<tr>
<td><strong>Multiplier</strong></td>
<td>A multiplier for the RenderTexture the Reflection Probe captures. The Reflection Probe applies this multiplier when Reflective Materials query the RenderTexture.</td>
</tr>
<tr>
<td><strong>Weight</strong></td>
<td>The overall weight of this Reflection Probe’s contribution to the reflective effect of Materials. When Reflection Probe’s blend together, the weight of each Probe determines their contribution to a reflective Material in the blend area.</td>
</tr>
<tr>
<td><strong>Fade Distance</strong></td>
<td>The distance, in meters, from the camera at which reflections begin to smoothly fade out before they disappear completely.</td>
</tr>
</tbody>
</table>

## Gizmos

You can use Scene view gizmos to visually customize specific properties.

| **Gizmo** | **Property** | **Description** |
|----|----|----|
| ![Influence Volume boundary](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/ReflectionProbeGizmo1.png) | **Influence Volume boundary** | Provides Scene view handles that allow you to resize the boundaries of the [Influence Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Reflection-Probe.html#InfluenceVolume), which defines the area this Reflection Probe affects reflective Materials. Edits the **Box Size** or **Radius** value, depending on the **Shape** you select. |
| ![Blend Distance boundary](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/ReflectionProbeGizmo2.png) | **Blend Distance boundary** | Provides Scene view handles that allows you to alter the inward distance from the **Box Size** or **Radius** at which this Reflection Probe blends with other Reflection Probes. Its behavior depends on the [workflow mode](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Reflection-Probe.html#Workflows) you are using. It scales all sides equally in **Normal** mode, scales just the side with the handle you control in **Advanced** mode. |
| ![Blend Normal Distance boundary](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/ReflectionProbeGizmo3.png) | **Blend Normal Distance boundary** | Provides Scene view handles that allow you to resize the boundary where pixels with a normal pointing away from the **Capture Position** don’t receive any influence from this Probe. |
| ![Capture Position](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/ReflectionProbeGizmo4.png) | **Capture Position** | Changes the behavior of the Move Tool so that it alters the **Capture Position** property, rather than the **Position** of the **Transform**. |
