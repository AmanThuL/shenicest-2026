---
title: "Exposure volume override reference"
page_title: "Exposure volume override reference | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/reference-override-exposure.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/reference-override-exposure.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Exposure volume override reference

To edit properties in any Volume component override, enable the checkbox to the left of the property. This also tells HDRP to use the property value you specify for the Volume component rather than the default value. If you disable the checkbox, HDRP ignores the property you set and uses the Volume’s default value for that property instead.

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
<td><strong>Mode</strong></td>
<td>Use the drop-down to select the method that HDRP uses to process exposure:<br />
• <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/reference-override-exposure.html#FixedProperties"><strong>Fixed</strong></a>: Allows you to manually sets the Scene exposure.<br />
• <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/reference-override-exposure.html#AutomaticProperties"><strong>Automatic</strong></a>: Automatically sets the exposure depending on what's on screen.<br />
• <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/reference-override-exposure.html#AutomaticHistogram"><strong>Automatic Histogram</strong></a>: Extends Automatic exposure with histogram control.<br />
• <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/reference-override-exposure.html#CurveMappingProperties"><strong>Curve Mapping</strong></a>: Maps the current Scene exposure to a custom curve.<br />
• <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/reference-override-exposure.html#UsePhysicalCameraProperties"><strong>Use Physical Camera</strong></a>: Uses the current physical Camera settings to set the Scene exposure.</td>
</tr>
</tbody>
</table>

<span id="FixedProperties"></span>

### Fixed

This is the simplest, and least flexible, method for calculating exposure but it's useful when you have a Scene with a relatively uniform exposure or when you want to take images of static areas. You can also use local [Volumes](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) to blend between various fixed exposure values in your Scenes.

#### Properties

| **Property** | **Description** |
|----|----|
| **Fixed Exposure** | Set the exposure value for Cameras this Volume affects. |

<span id="AutomaticProperties"></span>

### Automatic

The human eye can function in both dark and bright areas. However, at any single moment, the eye can only sense a contrast ratio of about one millionth of the total range. The eye functions well in multiple light levels by adapting and redefining what's black.

**Automatic Mode** dynamically adjusts the exposure according to the range of brightness levels on the screen. The adjustment takes place gradually, which means that the user can be dazzled by bright outdoor light when they emerge from a dark area. Equally, when moving from a bright area to a dark one, the Camera takes a moment to adjust.

#### Properties

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
<td><strong>Metering Mode</strong></td>
<td>Use the drop-down to select the metering method that HDRP uses to filter the luminance source. For information on the <strong>Metering Mode</strong>s available, see the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/reference-override-exposure.html#UsingAutomatic">Using Automatic section</a>.</td>
</tr>
<tr>
<td><strong>Luminance Source</strong></td>
<td>Use the drop-down to set the luminance source that HDRP uses to calculate the current Scene exposure. HDRP doesn't currently support the <strong>Lighting Buffer</strong> option.</td>
</tr>
<tr>
<td><strong>Compensation</strong></td>
<td>Set the value that the Camera uses to compensate the automatically calculated exposure value. This is useful if you want to over or under expose the Scene.</td>
</tr>
<tr>
<td><strong>Limit Min</strong></td>
<td>Set the minimum value that the Scene exposure can be.</td>
</tr>
<tr>
<td><strong>Limit Max</strong></td>
<td>Set the maximum value that the Scene exposure can be.</td>
</tr>
<tr>
<td><strong>Mode</strong></td>
<td>Use the drop-down to select the method that HDRP uses to change the exposure when the Camera moves from dark to light and vice versa:<br />
• <strong>Progressive</strong>: The exposure changes over the period of time defined by the <strong>Speed Dark to Light</strong> and <strong>Speed Light to Dark</strong> property fields.<br />
• <strong>Fixed</strong>: The exposure changes instantly. Note: The Scene view uses <strong>Fixed</strong>.</td>
</tr>
<tr>
<td><strong>Speed Dark to Light</strong></td>
<td>Set the speed at which the exposure changes when the Camera moves from a dark area to a bright area.<br />
This property only appears when you set the <strong>Mode</strong> to <strong>Progressive</strong>.</td>
</tr>
<tr>
<td><strong>Speed Light to Dark</strong></td>
<td>Set the speed at which the exposure changes when the Camera moves from a bright area to a dark area.<br />
This property only appears when you set the <strong>Mode</strong> to <strong>Progressive</strong>.</td>
</tr>
<tr>
<td><strong>Target Mid Gray</strong></td>
<td>Sets the desired Mid gray level used by the auto exposure (for example, to what grey value the auto exposure system maps the average scene luminance).<br />
Note that the lens model used in HDRP isn't of a perfect lens, so it won't map precisely to the selected value.</td>
</tr>
</tbody>
</table>

<span id="AutomaticHistogram"></span>

### Automatic Histogram

The automatic histogram is an extension of the [**Automatic**](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/reference-override-exposure.html#AutomaticProperties) mode. In order to achieve a more stable exposure result, this mode calculates a histogram of the image which makes it possible exclude parts of the image from the exposure calculation. This is useful to discard very bright or very dark areas of the screen.

To control this process, in addition to the properties for **Automatic** mode, this mode includes the following properties:

#### Properties

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
<td><strong>Histogram Percentages</strong></td>
<td>Use this field to select the range of the histogram to consider for auto exposure calculations. The values for this field are percentiles. This means that, for example, if you set the low percentile to <em>X</em>, if a pixel has a lower intensity than (100-<em>X</em>)% of all the pixels on screen, HDRP discards it from the exposure calculation. Similarly, if you set the higher percentile to <em>Y</em>, it means that if a pixel has a higher intensity than <em>Y</em>%, HDRP discards it from the exposure calculation.<br />
This allows the exposure calculation to discard unwanted outlying values in the shadows and highlight regions.</td>
</tr>
<tr>
<td><strong>Use Curve Remapping</strong></td>
<td>Specifies whether to apply curve mapping on top of this exposure mode or not. For information on curve mapping properties, see the [Curve Mapping section](#Curve Mapping).</td>
</tr>
</tbody>
</table>

<span id="UsingAutomatic"></span>

#### Using Automatic

To configure **Automatic Mode**:

1.  Set the **Metering Mode**. This tells the Camera how to measure the current Scene exposure. You can set the **Metering Mode** to:

- **Average**: The Camera uses the entire luminance buffer to measure exposure.
- **Spot**: The Camera only uses the center of the buffer to measure exposure. This is useful if you want to only expose light against what's in the center of your screen.

![A small white circle against a black background, representing the area the camera uses when Metering Mode is set to Spot.](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/Override-Exposure2.png)

- **Center Weighted**: The Camera applies a weight to every pixel in the buffer and then uses them to measure the exposure. Pixels in the center have the maximum weight, pixels at the screen borders have the minimum weight, and pixels between have a progressively lower weight the closer they're to the screen borders.

![A large white oval with diffuse edges, representing the area the camera uses when Metering Mode is set to Center Weighted. The oval almost fills the black background.](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/Override-Exposure3.png)

- **Mask Weighted**: The Camera applies a weight to every pixel in the buffer then uses the weights to measure the exposure. To specify the weighting, this technique uses the Texture set in the **Weight Texture Mask** field. Note that, if you don't provide a Texture, this metering mode is equivalent to **Average**.
- **Procedural Mask**: The Camera applies a weight to every pixel in the buffer then uses the weights to measure the exposure. The weights are generated using a mask that's procedurally generated with the following parameters:

| **Property** | **Description** |
|----|----|
| **Center Around Exposure target** | Whether the procedural mask is centered around the GameObject set as Exposure Target in the [Camera](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/hdrp-camera-component-reference.html). |
| **Center** | Sets the center of the procedural metering mask (\[0,0\] being bottom left of the screen and \[1,1\] top right of the screen). Available only when **Center Around Exposure target** is disabled. |
| **Offset** | Sets an offset to where mask is centered . Available only when you enable **Center Around Exposure target**. |
| **Radius** | Sets the radiuses (horizontal and vertical) of the procedural mask, in terms of fraction of half the screen (for example, 0.5 means a mask that stretch half of the screen in both directions). |
| **Softness** | Sets the softness of the mask, the higher the value the less influence is given to pixels at the edge of the mask. |
| **Mask Min Intensity** | All pixels below this threshold (in EV100 units) are assigned a weight of 0 in the metering mask. |
| **Mask Max Intensity** | All pixels above this threshold (in EV100 units) are assigned a weight of 0 in the metering mask. |

2.  Set the **Limit Min** and **Limit Max** to define the minimum and maximum exposure values respectively. Move between light and dark areas of your Scene and alter each property until you find the perfect values for your Scene.
3.  Use the **Compensation** property to over or under-expose the Scene. This works in a similar way to how exposure compensation works on most cameras.
4.  Tweak the adaptation speed. This controls how fast the exposure adapts to exposure changes. The human eye adapts slower to darkness than to lightness, so use a lower value for **Speed Light to Dark** than for **Speed Dark to Light**.

<span id="CurveMappingProperties"></span>

### Curve Mapping

The **Curve Mapping Mode** is a variant of [**Automatic**](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/reference-override-exposure.html#AutomaticProperties) **Mode**. Instead of setting limits, you manipulate a curve, where the x-axis represents the current Scene exposure and the y-axis represents the exposure you want. This lets you set the exposure in a more precise and controlled way for all lighting conditions at once.

#### Properties

| **Property** | **Description** |
|----|----|
| **Curve Map** | Use the curve to remap the Scene exposure (x-axis) to the exposure you want (y-axis). |

<span id="UsePhysicalCameraProperties"></span>

### Use Physical Camera

This mode mainly relies on the [Camera’s](https://docs.unity3d.com/Manual/class-Camera.html) **Physical Settings**. The only property this **Mode** exposes allows you to over or under expose the Scene.

#### Properties

| **Property** | **Description** |
|----|----|
| **Compensation** | Set the value that the Camera uses to compensate the automatically computed exposure value. This is useful if you want to over or under expose the Scene. This works similarly to how exposure compensation works on most cameras. |
