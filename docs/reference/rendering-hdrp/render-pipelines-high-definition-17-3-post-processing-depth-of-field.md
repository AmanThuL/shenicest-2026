---
title: "Depth of Field"
page_title: "Depth Of Field | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Depth-of-Field.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Depth-of-Field.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Depth Of Field

The Depth Of Field component applies a depth of field effect, which simulates the focus properties of a camera lens. In real life, a camera can only focus sharply on an object at a specific distance; objects nearer or farther from the camera are out of focus. The blurring gives a visual cue about an object’s distance, and introduces Bokeh, which refers to visual artifacts that appear around bright areas of the image as they fall out of focus.

## Using Depth Of Field

**Depth Of Field** uses the [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) framework, so to enable and modify **Depth Of Field** properties, you must add a **Depth Of Field** override to a [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) in your Scene. To add **Depth Of Field** to a Volume:

1.  In the Scene or Hierarchy view, select a GameObject that contains a Volume component to view it in the Inspector.
2.  In the Inspector, go to **Add Override** \> **Post-processing** and select **Depth Of Field**. HDRP now applies **Depth Of Field** to any Camera this Volume affects.

Depth Of Field includes [advanced properties](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest?subfolder=/manual/advanced-properties.html). that you must manually expose.

### API

To access and control this override at runtime, use the [Volume scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#changing-volume-profile-properties). Because of how the Volume system works, you edit properties in a different way to standard Unity components. There are also other nuances to be aware of too, such as each property has an [overrideState](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest/index.html?subfolder=/api/UnityEngine.Rendering.VolumeParameter.html%23UnityEngine_Rendering_VolumeParameter_overrideState). This indicates to the Volume system whether to use the property value you set, or use the default value stored in the [Volume Profile](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-volume-profile.html). For information on how to use the API correctly, see [Volume scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#changing-volume-profile-properties).

## Properties

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
<td><strong>Focus Mode</strong></td>
<td>Use the drop-down to select the mode that HDRP uses to set the focus for the depth of field effect. The options are:
<ul>
<li><strong>Off</strong>: Select this option to disable depth of field.</li>
<li><strong>Physical Camera</strong>: Select this option to use the physical <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/hdrp-camera-component-reference.html">Camera</a> to set focusing properties for the depth of field effect. For more information about what Camera properties affect depth of field, refer to <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Depth-of-Field.html#PhysicalCameraSettings">Physical Camera settings</a>.</li>
<li><strong>Manual Ranges</strong>: Select this option to use custom values to set the near and far range of the depth of field effect.</li>
</ul></td>
</tr>
<tr>
<td><strong>Focus Distance Mode</strong></td>
<td>Use the drop-down to select where the focus distance is specified. The options are:
<ul>
<li><strong>Volume</strong>: Reads the focus distance from the Volume.</li>
<li><strong>Camera</strong>: Reads the focus distance from the physical camera.</li>
</ul>
This property only appears when you select <strong>Physical Camera</strong> from the <strong>Focus Mode</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Focus Distance</strong></td>
<td>Set the distance to the focus plane from the Camera.<br />
This property only appears when you select <strong>Volume</strong> from the <strong>Distance Mode</strong> drop-down.</td>
</tr>
</tbody>
</table>

### Near Blur

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
<td><strong>Start</strong></td>
<td>Set the distance from the Camera at which the near field blur begins to decrease in intensity.<br />
This property only appears when you select <strong>Manual</strong> from the <strong>Focus Mode</strong> drop-down.</td>
</tr>
<tr>
<td><strong>End</strong></td>
<td>Set the distance from the Camera at which the near field doesn't blur anymore.<br />
This property only appears when you select <strong>Manual</strong> from the <strong>Focus Mode</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Sample Count</strong></td>
<td>Set the number of samples to use for the near field. Lower values result in better performance at the cost of visual accuracy.</td>
</tr>
<tr>
<td><strong>Max Radius</strong></td>
<td>Set the maximum radius the near blur can reach.</td>
</tr>
</tbody>
</table>

### Far Blur

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
<td><strong>Start</strong></td>
<td>Set the distance from the Camera at which the far field starts blurring.<br />
This property only appears when you select <strong>Manual</strong> from the <strong>Focus Mode</strong> drop-down.</td>
</tr>
<tr>
<td><strong>End</strong></td>
<td>Set the distance from the Camera at which the far field blur reaches its maximum blur radius.<br />
This property only appears when you select <strong>Manual</strong> from the <strong>Focus Mode</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Sample Count</strong></td>
<td>Set the number of samples to use for the far field. Lower values result in better performance at the cost of visual accuracy.</td>
</tr>
<tr>
<td><strong>Max Radius</strong></td>
<td>Set the maximum radius the far blur can reach.</td>
</tr>
</tbody>
</table>

<span id="PhysicalCameraSettings"></span>

## Physical Camera settings

Here is a list of the physical [Camera](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/hdrp-camera-component-reference.html) properties that affect the Depth of Field effect when you select **Use Physical Camera** from the **Focus Mode** drop-down.

| **Property** | **Effect** |
|----|----|
| **Aperture** | The larger this value, the larger the [bokeh](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Glossary.html#Bokeh) and overall blur effect. |
| **Blades Count** | This determines the shape of the bokeh. For more information on the effect this property has, see the example below. |
| **Curvature** | Determines how much of the blades are visible. Use this to change the roundness of bokeh in the blur. For more information on the effect this property has, see the example below. |

![This example shows how the Blade Count and Curvature properties affect the shape of the bokeh. On the left side, there's a five blade iris that's slightly open, producing a pentagonal bokeh. On the right side, there's a five blade iris that's wide open, producing a circular bokeh.](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/Post-ProcessingDepthOfField2.png)

This example shows how the **Blade Count** and **Curvature** properties affect the shape of the bokeh:

- On the left side, there is a five blade iris that's slightly open, producing a pentagonal bokeh.
- On the right side, there is a five blade iris that's wide open, producing a circular bokeh.

## Path-traced depth of field

If you enable [path tracing](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Ray-Tracing-Path-Tracing.html) and set **Focus Mode** to **Use Physical Camera**, HDRP computes depth of field directly during path tracing instead of as a post-processing effect.

Path-traced depth of field produces images without any artifacts, apart from noise when using insufficient path-tracing samples. To reduce the noise level, increase the number of samples from the [Path Tracing](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Ray-Tracing-Path-Tracing.html) settings or de-noise the final frame.

HDRP computes path-traced depth of field at full resolution and ignores any quality settings from the Volume.

![Two paint pots with a depth of field effect that makes surfaces increasingly blurry towards and away from the camera.](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/Path-traced-DoF.png)
