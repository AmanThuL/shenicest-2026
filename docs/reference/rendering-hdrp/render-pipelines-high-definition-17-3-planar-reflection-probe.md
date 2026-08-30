---
title: "Planar Reflection Probe reference"
page_title: "Planar Reflection Probe reference | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Planar-Reflection-Probe.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Planar-Reflection-Probe.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Planar Reflection Probe reference

The Planar Reflection Probe component is one of the types of [Reflection Probe](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Reflection-Probes-Intro.html) that the High Definition Render Pipeline (HDRP) provides to help you create reactive and accurate reflective Materials.

## Properties

Planar Reflection Probes share many properties with the [built-in render pipeline Reflection Probe](https://docs.unity3d.com/Manual/class-ReflectionProbe.html), and the [HDRP cubemap Reflection Probe](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Reflection-Probe.html).

Planar Reflection Probes use the same texture format than the one selected in [HDRP Asset](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html) for Color Buffer Format.

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
<td><strong>Realtime Mode</strong></td>
<td>A Planar Reflection Probe updates in real time. Use this property to tell HDRP how often to update the Probe.<br />
• <strong>Every Frame</strong>: Updates the Probe’s capture data every frame.<br />
• <strong>On Enable</strong>: Updates the Probe’s capture data each time Unity calls the component’s <code>OnEnable()</code> function. This occurs whenever you enable the component in the Inspector or activate the GameObject that the component attaches to.<br />
• <strong>On Demand</strong>: Updates the Probe's capture data when you request it. To do this, access the Probe's <code>HDAdditionalReflectionData</code> and call the <code>RequestRenderNextUpdate()</code> function.</td>
</tr>
</tbody>
</table>

### Projection Settings

The following properties control the projection settings for this Planar Reflection Probe.

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
<td>The <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Reflection-Proxy-Volume.html">Reflection Proxy Volume</a> this Probe uses to correct displacement issues between the Probe’s capture point (<strong>Mirror Position</strong>) and the position of the reflective Material using the RenderTexture this Probe captures. Note: The <strong>Proxy Volume</strong> you assign must be the same <strong>Shape</strong> as the Influence Volume.</td>
</tr>
<tr>
<td><strong>Use Influence Volume As Proxy Volume</strong></td>
<td>Tick this checkbox to use the boundaries of the Influence Volume as the Proxy Volume.<br />
This property only appears when you have not set a Reflection Proxy Volume to the <strong>Proxy Volume</strong> property.</td>
</tr>
</tbody>
</table>

<span id="InfluenceVolume"></span>

### Influence Volume

The Influence Volume defines the area around the Probe in which reflective Materials use the results that the Probe captures to influence the reflective behavior of their surface. The Planar Reflection Probe also uses the bounds of the Influence Volume to calculate **Field Of View** if you don’t provide an override value.

For reflective objects not aligned with the planar probe direction, the reflection will smoothly fade out as the reflected rays leave the reflected camera field of view.

| **Property** | **Description** |
|----|----|
| **Shape** | Defines the shape of the Influence Volume. The possible values are **Box** and **Sphere**. The availability of properties below depends on the selected shape. |
| **Box Size** | Defines the scale of each axis of the box that represents the Influence Volume. Only available with a **Box Shape**. |
| **Radius** | Defines the radius of the sphere that represents the Influence Volume. Only available with a **Sphere Shape**. |
| **Per Axis Control** | Enable the checkbox to control the **Blend Distance** per axis. Only available with a **Box Shape**. |
| **Blend Distance** | The inward distance from the **Box Size** or **Radius** at which this Planar Reflection Probe blends with other Reflection Probes. In **Normal** mode, this property is a single value that modulates the distance at which this Reflection Probe blends with other Reflection Probes in every direction. This mode is available for **Box** or **Sphere** Influence Volumes. For the **Box** shape, when **Per Axis Control** is enabled, this property uses six values, one for each side of the box. Use each of the six input fields to define the blend distance in each direction. For example, **Y** defines the blending distance for the face at the top of the box and **-Y** defines the blending distance for the face on the bottom. This mode is only available for **Box** Influence Volumes.This feature is only available for [deferred](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Forward-And-Deferred-Rendering.html) Reflection Probes. |

### Capture Settings

The following properties control the method that the Planar Reflection Probe uses to capture the directional view of its surroundings.

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
<td><strong>Field Of View Mode</strong></td>
<td>Defines the mode to use when computing the field of view.</td>
</tr>
<tr>
<td><strong>Clear Mode</strong></td>
<td>Defines how to fill empty background areas of the RenderTexture this Probe captures.<br />
• <strong>Sky</strong> uses the sky defined by the current <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html">Volume</a> settings to fill empty background areas.<br />
• <strong>Color</strong> uses the <strong>Background Color</strong> setting to fill empty background areas.<br />
• <strong>None</strong> reuses the previous value for each pixel that doesn’t represent a reflected GameObject, instead of filling in empty areas of the RenderTexture.</td>
</tr>
<tr>
<td><strong>Background Color</strong></td>
<td>The color to fill empty background areas of the RenderTexture if you set the <strong>Clear Mode</strong> to <strong>Background</strong>.</td>
</tr>
<tr>
<td><strong>Clear Depth</strong></td>
<td>Choose whether the Planar Reflection Probe clears the Depth Buffer or not.</td>
</tr>
<tr>
<td><strong>Volume Layer Mask</strong></td>
<td>A LayerMask that defines which Volumes affect this Planar Reflection Probe’s capture.</td>
</tr>
<tr>
<td><strong>Volume Anchor Override</strong></td>
<td>Set the Transform that the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html">Volume</a> system uses to handle the position of this Planar Reflection Probe. For example, if you want this Planar Reflection Probe to match post-processing effects with the view Camera, set this property to the view Camera’s Transform. The Volume system then uses the Camera’s position to process which Volume affects this Planar Reflection Probe.</td>
</tr>
<tr>
<td><strong>Use Occlusion Culling</strong></td>
<td>Enables <a href="https://docs.unity3d.com/Manual/OcclusionCulling.html">Occlusion Culling</a> for this Planar Reflection Probe.</td>
</tr>
<tr>
<td><strong>Culling Mask</strong></td>
<td>A LayerMask that defines which Layers to include in the reflection. GameObjects on the Layers included in this LayerMask appear in the reflection.</td>
</tr>
<tr>
<td><strong>Clipping Planes - Near</strong></td>
<td>The closest point relative to the Planar Reflection Probe that the Probe captures reflections.</td>
</tr>
<tr>
<td><strong>Clipping Planes - Far</strong></td>
<td>The furthest point relative to the Planar Reflection Probe that it captures reflections.</td>
</tr>
<tr>
<td><strong>Probe Layer Mask</strong></td>
<td>Acts as a culling mask for environment lights (light from other Planar Reflection Probes and Reflection Probes). This Planar Reflection Probe ignores all Reflection Probes that are on Layers not included in this Layer mask, so use this property to ignore certain Reflection Probes when rendering this one.</td>
</tr>
<tr>
<td><strong>Custom Frame Settings</strong></td>
<td>Allows you to define custom <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Frame-Settings.html">Frame Settings</a> for this Probe. Disable this property to use the <strong>Default Frame Settings</strong> in your Unity Project’s <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html">HDRP Asset</a>.</td>
</tr>
<tr>
<td><strong>Resolution</strong></td>
<td>Set the resolution of this Planar Reflection Probe. Use the drop-down to select which quality mode to derive the resolution from. If you select Custom, set the resolution, measured in pixels, in the input field. A higher resolution increases the fidelity of planar reflection at the cost of GPU performance and memory usage, so if you experience any performance issues, try using a lower value. The resolution can be set to 0 to prevent the probe from being rendered for certain quality levels.</td>
</tr>
<tr>
<td><strong>Rough Reflections</strong></td>
<td>Disable the checkbox to tell HDRP to use this Planar Reflection Probe as a mirror. If you do this, the receiving surface must be perfectly smooth or the reflection result is not accurate. If you want perfect reflection, disabling this option can be useful because it means HDRP does not need to process rough refraction and thus decreases the resource intensity of the effect.</td>
</tr>
<tr>
<td><strong>Mirror Position</strong></td>
<td>Offsets the position of the mirror from the Transform Position.<br />
This property only appears when you enable <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest?subfolder=/manual/advanced-properties.html">advanced properties</a> for this section.</td>
</tr>
<tr>
<td><strong>Range Compression Factor</strong></td>
<td>The factor which HDRP divides the result of the probe's rendering by. This is useful to deal with very bright or dark objects in the reflections that would otherwise be saturated.<br />
This property only appears when you enable <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest?subfolder=/manual/advanced-properties.html">advanced properties</a> for this section.</td>
</tr>
</tbody>
</table>

### Render Settings

The following properties control extra behavior options for fine-tuning the behavior of your Planar Reflection Probes.

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
<td><strong>Light Layer</strong></td>
<td>A mask that allows you to choose which Light Layers this Reflection Probe affects. This Reflection Probe only affects Mesh Renderers or Terrain with a matching <strong>Rendering Layer Mask</strong>.<br />
Navigate to your Project’s <strong>HDRP Asset &gt; Render Pipeline Supported Features</strong> and enable <strong>Light Layers</strong> to use this property.</td>
</tr>
<tr>
<td><strong>Importance</strong></td>
<td>A value that indicates the relative priority of this Reflection Probe for sorting. Unity renders probes with a higher value on top of those with a lower value. Default value for <strong>Planar Reflection Probes</strong> is 64 so they are displayed on top of <strong>Reflection Probes</strong>.</td>
</tr>
<tr>
<td><strong>Multiplier</strong></td>
<td>A multiplier that HDRP applies to the RenderTexture captured by the Planar Reflection Probe. Higher multiplier values make the queried RenderTexture brighter, and lower multiplier values make the queried RenderTexture darker.</td>
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
| ![Influence Volume boundary gizmo](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/ReflectionProbeGizmo1.png) | **Influence Volume boundary** | Provides Scene view handles that allow you to move the boundaries of the [Influence Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Planar-Reflection-Probe.html#InfluenceVolume), which defines the area this Reflection Probe affects reflective Materials. Edits the **Box Size** or **Radius** value, depending on the **Shape** you select. |
| ![Blend Distance boundary gizmo](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/ReflectionProbeGizmo2.png) | **Blend Distance boundary** | Provides Scene view handles that allows you to alter the inward distance from the **Box Size** or **Radius** at which this Planar Reflection Probe blends with other Reflection Probes. For the **Box** shape, when **Per Axis Control** is enabled, there is a separate handle for each size of the box. |
| ![Blend Normal Distance boundary gizmo](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/ReflectionProbeGizmo3.png) | **Blend Normal Distance boundary** | Provides Scene view handles that allow you to resize the boundary where pixels with a normal pointing away from the **Capture Position** don’t receive any influence from this Probe. |
| ![Mirror Position gizmo](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/ReflectionProbeGizmo4.png) | **Mirror Position** | Changes the behavior of the Move Tool so that it alters the **Mirror** **Position** property, rather than the **Position** of the **Transform**. |
| ![Mirror Rotation gizmo](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/ReflectionProbeGizmo5.png) | **Mirror Rotation** | Changes the behavior of the Rotate Tool so that it alters the **Mirror Rotation** property, rather than the **Rotation** of the **Transform**. |
| ![Chrome gizmo](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/ReflectionProbeGizmo6.png) | **Chrome Gizmo** | Displays a chrome quad to preview the probe's texture in the scene. |

## Best practices

If you use a Planar Reflection Probe as a mirror (i.e its influence volume overlap a GameObject with a Material that has its smoothness and metallic properties set to 1) it is best practice to disable the **Rough Refraction** property to decrease the resource intensity. If a receiving surface isn't a perfect mirror and the **Rough Reflection** option is disabled, the surface still renders smooth, but the result is physically incorrect.
