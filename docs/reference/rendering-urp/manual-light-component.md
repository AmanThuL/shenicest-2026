---
title: "Light component Inspector window reference for URP"
page_title: "Unity - Manual: Light component Inspector window reference for URP"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/light-component.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/light-component.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Light component Inspector window reference for URP

This page contains information on Light components in the Universal Render Pipeline (URP). For a general introduction to lighting in Unity and examples of common lighting workflows, refer to [Lighting](https://docs.unity3d.com/6000.3/Documentation/Manual/Lighting.html).

When using a preset of a **Light** component, only a subset of properties are supported. Unsupported properties are hidden.

## Properties

The **Light Inspector** window includes the following groups of properties:

-   [General](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/light-component.html#General)
-   [Shape](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/light-component.html#Shape)
-   [Emission](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/light-component.html#Emission)
-   [Rendering](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/light-component.html#Rendering)
-   [Shadows](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/light-component.html#Shadows)

### <span id="General"></span>General

<table><thead><tr class="header"><th style="text-align: left;">Property:</th><th style="text-align: left;">Function:</th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Type</strong></td><td style="text-align: left;">The current type of light. Possible values are <strong>Directional</strong>, <strong>Point</strong>, <strong>Spot</strong> and <strong>Area</strong>.</td></tr><tr class="even"><td style="text-align: left;"><strong>Mode</strong></td><td style="text-align: left;">Specify the <a href="https://docs.unity3d.com/Manual/LightModes.html"><strong>Light Mode</strong></a> used to determine if and how a light is “baked”.<br />
<br />
Options:<ul><li><strong>Realtime</strong></li><li><strong>Mixed</strong></li><li><strong>Baked</strong></li></ul><br />
<strong>Note</strong>: If <strong>Type</strong> is set to <strong>Area</strong>, this property is automatically set to <strong>Baked</strong>.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Rendering Layers</strong></td><td style="text-align: left;">Set which rendering layers the light applies to.<br />
<br />
<strong>Note</strong>: This property is only available if <strong>Mode</strong> is set to <strong>Realtime</strong> or <strong>Mixed</strong>.</td></tr></tbody></table>

### <span id="Shape"></span>Shape

<table><thead><tr class="header"><th style="text-align: left;">Property:</th><th style="text-align: left;">Function:</th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Inner/Outer Spot Angle</strong></td><td style="text-align: left;">The inner and outer angles (in degrees) at the base of a spot light’s cone (spot light only).<br />
Avoid setting the <strong>Outer Spot Angle</strong> property to excessively high values (for example, higher than 160 degrees). Very high outer spot angle values cause Unity to spread the shadow map over a large area, which reduces shadow quality.</td></tr><tr class="even"><td style="text-align: left;"><strong>Shape</strong></td><td style="text-align: left;">The shape of the area light.<br />
<br />
Available options:<ul><li><strong>Rectangle</strong></li><li><strong>Disc</strong></li></ul></td></tr><tr class="odd"><td style="text-align: left;">    <strong>Width</strong></td><td style="text-align: left;">The width of the area light.<br />
<br />
<strong>Note</strong>: This property is only available if <strong>Shape</strong> is set to <strong>Rectangle</strong>.</td></tr><tr class="even"><td style="text-align: left;">    <strong>Height</strong></td><td style="text-align: left;">The height of the area light.<br />
<br />
<strong>Note</strong>: This property is only available if <strong>Shape</strong> is set to <strong>Rectangle</strong>.</td></tr><tr class="odd"><td style="text-align: left;">    <strong>Radius</strong></td><td style="text-align: left;">The radius of the area light<br />
<br />
<strong>Note</strong>: This property is only available if <strong>Shape</strong> is set to <strong>Disc</strong>.</td></tr></tbody></table>

### <span id="Emission"></span>Emission

<table><thead><tr class="header"><th style="text-align: left;">Property:</th><th style="text-align: left;">Function:</th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Light Appearance</strong></td><td style="text-align: left;">Select the method used to create the color of the light.<br />
<br />
Available options:<ul><li><strong>Color</strong></li><li><strong>Filter and Temperature</strong></li></ul></td></tr><tr class="even"><td style="text-align: left;">    <strong>Color</strong></td><td style="text-align: left;">The color of the emitted light. Set this property with the color slider.<br />
<br />
<strong>Note</strong>: This property is only available if <strong>Light Apperance</strong> is set to <strong>Color</strong>.</td></tr><tr class="odd"><td style="text-align: left;">    <strong>Filter</strong></td><td style="text-align: left;">The color of the tint for the light source. Set this property with the color slider.<br />
<br />
<strong>Note</strong>: This property is only available if <strong>Light Apperance</strong> is set to <strong>Filter and Temperature</strong>.</td></tr><tr class="even"><td style="text-align: left;">    <strong>Temperature</strong></td><td style="text-align: left;">The temperature (in Kelvin) of the light. Set this property with the slider or enter a specific value.<br />
<br />
<strong>Note</strong>: This property is only available if <strong>Light Apperance</strong> is set to <strong>Filter and Temperature</strong>.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Intensity</strong></td><td style="text-align: left;">Set the brightness of the light. The default value for a <strong>Directional</strong> light is 0.5. The default value for a <strong>Point</strong>, <strong>Spot</strong> or <strong>Area</strong> light is 1.</td></tr><tr class="even"><td style="text-align: left;"><strong>Indirect Multiplier</strong></td><td style="text-align: left;">Use this value to vary the intensity of indirect light. Indirect light is light that has bounced from one object to another. The <strong>Indirect Multiplier</strong> defines the brightness of bounced light calculated by the global illumination (GI) system. If you set <strong>Indirect Multiplier</strong> to a value lower than <strong>1,</strong> the bounced light becomes dimmer with every bounce. A value higher than <strong>1</strong> makes light brighter with each bounce. This is useful, for example, when a dark surface in shadow (such as the interior of a cave) needs to be brighter in order to make detail visible.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Range</strong></td><td style="text-align: left;">Define how far the light emitted from the center of the object travels (<strong>Point</strong> and <strong>Spot</strong> lights only).</td></tr><tr class="even"><td style="text-align: left;"><strong>Cookie</strong></td><td style="text-align: left;">The RGB texture this Light projects into the scene. Use cookies to create silhouettes or patterned illumination. The texture format to use depends on the type of Light:<br />
• Directional: 2D texture<br />
• Spot: 2D texture<br />
• Point: <a href="https://docs.unity3d.com/Manual/class-Cubemap.html">cubemap texture</a><br />
<br />
<strong>Note</strong>: URP doesn’t support light cookies for Area lights.<br />
<br />
For more information about light cookies, refer to <a href="https://docs.unity3d.com/Manual/Cookies.html">Cookies</a>.</td></tr><tr class="odd"><td style="text-align: left;">  <strong>Cookie Size</strong></td><td style="text-align: left;">The per-axis scale Unity applies to the cookie texture. Use this property to set the size of the cookie.<br />
<br />
<strong>Note</strong>: This property is available only if you set <strong>Type</strong> to <strong>Directional</strong> and assign a texture to <strong>Cookie</strong>.</td></tr><tr class="even"><td style="text-align: left;">  <strong>Cookie Offset</strong></td><td style="text-align: left;">The per-axis offset Unity applies to the cookie texture. Use this property to move the cookie without moving the light itself. You can also animate this property to scroll the cookie.<br />
<br />
<strong>Note</strong>: This property is available only if you set <strong>Type</strong> to <strong>Directional</strong> and assign a texture to <strong>Cookie</strong>.</td></tr></tbody></table>

## <span id="Rendering"></span>Rendering

| Property:        | Function:                                                                                                                                                                 |
|:-----------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Culling Mask** | Use this to selectively exclude groups of objects from being affected by the light. For more information, refer to [Layers](https://docs.unity3d.com/Manual/Layers.html). |

## <span id="Shadows"></span>Shadows

<table><thead><tr class="header"><th style="text-align: left;">Property:</th><th style="text-align: left;">Function:</th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Shadow Type</strong></td><td style="text-align: left;">Determine whether this light casts Hard Shadows, Soft Shadows, or no shadows at all. For information on hard and soft shadows, refer to documentation on <a href="https://docs.unity3d.com/Manual/class-Light.html">lights</a>.</td></tr><tr class="even"><td style="text-align: left;">    <strong>Baked Shadow Angle</strong></td><td style="text-align: left;">If <strong>Type</strong> is set to <strong>Directional</strong> and <strong>Shadow Type</strong> is set to <strong>Soft Shadows</strong>, this property adds some artificial softening to the edges of shadows and gives them a more natural look.<br />
<br />
<strong>Note</strong>: This property is only available if <strong>Mode</strong> is set to <strong>Mixed</strong> or <strong>Baked</strong>.</td></tr><tr class="odd"><td style="text-align: left;">    <strong>Baked Shadow Radius</strong></td><td style="text-align: left;">If <strong>Type</strong> is set to <strong>Point</strong> or <strong>Spot</strong> and <strong>Shadow Type</strong> is set to <strong>Soft Shadows</strong>, this property adds some artificial softening to the edges of shadows and gives them a more natural look.<br />
<br />
<strong>Note</strong>: This property is only available if <strong>Mode</strong> is set to <strong>Mixed</strong> or <strong>Baked</strong>.</td></tr><tr class="even"><td style="text-align: left;">    <strong>Realtime Shadows</strong></td><td style="text-align: left;">These properties are available when <strong>Shadow Type</strong> is set to <strong>Hard Shadows</strong> or <strong>Soft Shadows</strong>. Use these properties to control real-time shadow rendering settings.</td></tr><tr class="odd"><td style="text-align: left;">        <strong>Strength</strong></td><td style="text-align: left;">Use the slider to control how dark the shadows cast by this light are. The range is between 0 and 1. Default value: 1.</td></tr><tr class="even"><td style="text-align: left;">        <strong>Bias</strong></td><td style="text-align: left;">Controls whether to use shadow bias settings from the URP asset, or whether to define custom shadow bias settings for this light. Possible values are <strong>Use Pipeline Settings</strong> or <strong>Custom</strong>.</td></tr><tr class="odd"><td style="text-align: left;">        <strong>Depth</strong></td><td style="text-align: left;">Controls the distance at which the shadows will be pushed away from the light. Useful for avoiding false self-shadowing artifacts. This property is visible only when <strong>Bias</strong> is set to <strong>Custom</strong>.</td></tr><tr class="even"><td style="text-align: left;">        <strong>Normal</strong></td><td style="text-align: left;">Controls the distance at which the shadow casting surfaces will be shrunk along the surface normal. Useful for avoiding false self-shadowing artifacts. This property is visible only when <strong>Bias</strong> is set to <strong>Custom</strong>.</td></tr><tr class="odd"><td style="text-align: left;">        <strong>Near Plane</strong></td><td style="text-align: left;">Use the slider to control the value for the near clip plane when rendering shadows, defined as a value between 0.1 and 10. This value is clamped to 0.1 units or 1% of the light’s <strong>Range</strong> property, whichever is lower. This is set to 0.2 by default.</td></tr><tr class="even"><td style="text-align: left;">        <strong>Soft</strong> <strong>Shadows</strong> <strong>Quality</strong></td><td style="text-align: left;">Select the soft shadows quality. With the <strong>Use Pipeline Settings</strong> option selected Unity uses the value from the URP asset. Options <strong>Low</strong>, <strong>Medium</strong>, and <strong>High</strong> let you specify the soft shadow quality value for this light. For more information on the values, refer to the <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/urp/universalrp-asset.html#soft-shadows">Soft Shadows</a> section.</td></tr><tr class="odd"><td style="text-align: left;">    <strong>Custom Shadow Layers</strong></td><td style="text-align: left;">Enable to specify the layer for shadows from the light separately to the layer for the light itself.<br />
<br />
<strong>Note</strong>: This property is only available if <strong>Mode</strong> is set to <strong>Mixed</strong> or <strong>Baked</strong>, and <strong>Shadow Type</strong> is set to <strong>Hard Shadows</strong> or <strong>Soft Shadows</strong>.</td></tr><tr class="even"><td style="text-align: left;">        <strong>Layer</strong></td><td style="text-align: left;">The layer for shadows from the light.</td></tr></tbody></table>

## Additional resources

-   [Light component Inspector window reference for the Built-In Render Pipeline](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Light.html)
