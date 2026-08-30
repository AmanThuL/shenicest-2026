---
title: "Light component reference (HDRP)"
page_title: "Light component reference | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/reference-light-component.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/reference-light-component.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

## Light component reference

The properties available for Lights are in separate sections. Each section contains some properties that all Lights share, and also properties that customize the behavior of the specific type of Light. These sections also contain [advanced properties](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest?subfolder=/manual/advanced-properties.html) that you can expose if you want to fine-tune your light's behavior. The sections are:

- [General](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/reference-light-component.html#General)
- [Shape](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/reference-light-component.html#Shape)
- [Celestial Body](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/reference-light-component.html#CelestialBody)
- [Emission](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/reference-light-component.html#Emission)
- [Volumetrics](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/reference-light-component.html#Volumetric)
- [Shadows](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/reference-light-component.html#Shadow)

## Animation

To make the Light work with the **Animation window**, when you click on the **Add Property** button, you need to use the properties inside the **HD Additional Light Data** component and not inside the Light component itself. If you do edit the properties inside the Light component, this modifies the built-in light values, which HDRP doesn't support. Alternatively, you can use the record button and modify the values directly inside the Inspector.

<span id="General"></span>

## General

**General** properties control the type of Light, how HDRP processes this Light, and whether this Light affects everything in the Scene or just GameObjects on a specific Rendering Layer.

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
<td>Defines the Light’s type. Lights of different Types behave differently, so when you change the <strong>Type</strong>, the properties change in the Inspector. For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/Lighting.html" class="xref">Types of Light component</a>. Possible types are:<br />
• Directional<br />
• Point<br />
• Spot<br />
• Area</td>
</tr>
<tr>
<td><strong>Mode</strong></td>
<td>Specify the <a href="https://docs.unity3d.com/Manual/LightModes.html">Light Mode</a> that HDRP uses to determine how to bake a Light, if at all. Possible modes are:<br />
• <a href="https://docs.unity3d.com/Manual/LightMode-Realtime.html">Realtime</a>: Unity performs the lighting calculations for Realtime Lights at runtime, once per frame.<br />
• <a href="https://docs.unity3d.com/Manual/LightMode-Mixed.html">Mixed</a>: Mixed Lights combine elements of both realtime and baked lighting.<br />
• <a href="https://docs.unity3d.com/Manual/LightMode-Baked.html">Baked</a>: Unity performs lighting calculations for Baked Lights in the Unity Editor, and saves the results to disk as lighting data. Note that soft falloff/range attenuation isn't supported for Baked Area Lights.</td>
</tr>
<tr>
<td><strong>Rendering Layer Mask</strong></td>
<td>Defines which Rendering Layers this Light affects. The affected Light only lights up Mesh Renderers or Terrain with a matching <strong>Rendering Layer Mask</strong>. To use this property:<br />
• Set up <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Rendering-Layers.html">light layers</a> in your project.<br />
• Enable <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest?subfolder=/manual/advanced-properties.html">advanced properties</a> for this section.</td>
</tr>
</tbody>
</table>

<span id="Shape"></span>

## Shape

These settings define the area this Light affects. Each Light **Type** has its own unique **Shape** properties.

#### Spot Light

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
<td>HDRP Spot Lights can use three shapes.<br />
• <strong>Cone</strong> : Projects light from a single point at the GameObject’s position, out to a circular base, like a cone. Alter the radius of the circular base by changing the <strong>Outer Angle</strong> and the <strong>Range</strong>.<br />
• <strong>Pyramid</strong> : Projects light from a single point at the GameObject’s position onto a base that's a square with its side length equal to the diameter of the <strong>Cone</strong>.<br />
• <strong>Box</strong> : Projects light evenly across a rectangular area defined by a horizontal and vertical size. This light has no attenuation unless <strong>Range Attenuation</strong> is checked.</td>
</tr>
<tr>
<td><strong>Inner / Outer Spot Angle</strong></td>
<td>Determines both the outer angle in degrees at the base of a Spot Light’s cone and where the attenuation between the inner cone and the outer cone starts. Lower inner angle values cause the light at the edges of the Spot Light to fade out. Higher values stop the light from fading at the edges. This property is only for Lights with a <strong>Cone Shape</strong>.</td>
</tr>
<tr>
<td><strong>Spot Angle</strong></td>
<td>The angle in degrees used to determine the size of a Spot Light using a <strong>Pyramid</strong> shape.</td>
</tr>
<tr>
<td><strong>Aspect Ratio</strong></td>
<td>Adjusts the shape of a Pyramid Spot Light to create rectangular Spot Lights. Set this to 1 for a square projection. Values lower than 1 make the Light wider, from the point of origin. Values higher than 1 make the Light longer. This property is only for Lights with a <strong>Pyramid Shape</strong>.</td>
</tr>
<tr>
<td><strong>Radius</strong></td>
<td>The radius of the light source. This has an impact on the size of specular highlights, diffuse lighting falloff, and the softness of baked, ray-traced, and PCSS shadows. This will not have an impact on the angle attenuation of the cone.</td>
</tr>
<tr>
<td><strong>Size X</strong></td>
<td>For <strong>Box</strong>. Adjusts the horizontal size of the Box Light. No light shines outside of the dimensions you set.</td>
</tr>
<tr>
<td><strong>Size Y</strong></td>
<td>For <strong>Box</strong>. Adjusts the vertical size of the Box Light. No light shines outside of the dimensions you set.</td>
</tr>
</tbody>
</table>

<span id="DirectionalLight"></span>

### Directional Light

| **Property** | **Description** |
|----|----|
| **Angular Diameter** | Allows you to set the area of a distant light source through an angle in degrees. This has an impact on the size of specular highlights, and the softness of baked, ray-traced, and PCSS shadows. |

<span id="PointLight"></span>

### Point Light

| **Property** | **Description** |
|----|----|
| **Radius** | Defines the radius of the light source. This has an impact on the size of specular highlights, diffuse lighting falloff and the smoothness of baked shadows and ray-traced shadows. |

### Area Light

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
<td>HDRP Area Lights can use three shapes.<br />
• <strong>Rectangle</strong> : Projects light from a rectangle shape at the GameObject’s position and orientation, perpendicularly, out to a certain <strong>Range</strong>.<br />
• <strong>Tube</strong> : Projects light from a single line at the GameObject’s position in every direction, out to a certain <strong>Range</strong>. This shape is only for <strong>Realtime Mode</strong> at the moment.<br />
• <strong>Disc</strong> : Projects light from a disc shape at the GameObject’s position and orientation, perpendicularly, out to a certain <strong>Range</strong>. This shape is only for <strong>Baked Mode</strong> at the moment.</td>
</tr>
<tr>
<td><strong>Size X</strong></td>
<td>For <strong>Rectangle</strong>. Defines the horizontal size of the Rectangle Light.</td>
</tr>
<tr>
<td><strong>Size Y</strong></td>
<td>For <strong>Rectangle</strong>. Defines the vertical size of the Rectangle Light.</td>
</tr>
<tr>
<td><strong>Barn Door Angle</strong></td>
<td>For <strong>Rectangle</strong>. Defines the angle of the barn door effect. The barn door shader option needs to be enabled in the render pipeline config package for this property to affect the light. You can install the config package by following the instructions in the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/configure-a-project-using-the-hdrp-config-package.html">config package documentation</a>.</td>
</tr>
<tr>
<td><strong>Barn Door Length</strong></td>
<td>For <strong>Rectangle</strong>. Defines the length of the barn door sides. The barn door shader option needs to be enabled in the render pipeline config package for this property to affect the light. You can install the config package by following the instructions in the [config package documentation](configure-a-project-using-the-hdrp-config-package.</td>
</tr>
<tr>
<td><strong>Length</strong></td>
<td>For <strong>Tube</strong>. Defines the length of the Tube Light. The center of the Light is the Transform Position and the Light itself extends out from the center symmetrically. The <strong>Length</strong> is the distance from one end of the tube to the other.</td>
</tr>
<tr>
<td><strong>Radius</strong></td>
<td>For <strong>Disc</strong>. Define the radius of the Disc Light.</td>
</tr>
</tbody>
</table>

<span id="CelestialBody"></span>

## Celestial Body (Directional only)

These settings define the behavior of the light when you use it as a celestial body with the [Physically Based Sky](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-physically-based-sky.html).

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
<td><strong>Affect Physically Based Sky</strong></td>
<td>When using a <strong>Physically Based Sky</strong>, this displays a sun disc in the sky in this Light's direction. The diameter, color, and intensity of the sun disc match the properties of this Directional Light.<br />
This property only appears when you enable <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/More-Options.md">additional properties</a> for this section.</td>
</tr>
<tr>
<td><strong>Angular Diameter</strong></td>
<td>Controls the size of the sun disk by multiplying or overriding the value of the angular diameter. A higher angular diameter artificially increases the size of the celestial body on screen without impacting the specular highlights or softness of shadows. If the sun is only a few pixels large and very bright, you can also increase the angular diameter to avoid flickering when using bloom.</td>
</tr>
<tr>
<td><strong>Distance</strong></td>
<td>Controls the distance of the sun disc. This is useful if you have multiple sun discs in the sky and want to change their sort order. HDRP draws sun discs with smaller <strong>Distance</strong> values on top of those with larger <strong>Distance</strong> values.</td>
</tr>
<tr>
<td><strong>Surface Color</strong></td>
<td>Sets a 2D (disk) Texture and color multiplier for the surface of the celestial body. Rotate the light component on the Z axis to rotate this texture.</td>
</tr>
<tr>
<td><strong>Shading</strong></td>
<td>Specify the light source used for the shading of the Celestial Body.<br />
• <strong>Emission</strong> : Simulates a Sun. The celestial body emits light based on the intensity parameter set in the Emission section.<br />
• <strong>Reflect Sun Light</strong> : Simulates moons or planets. The celestial body is illuminated by a directional light.<br />
• <strong>Manual</strong> : Simulates moons or planets with complete control over the phase angle and rotation, as well as the reflected light intensity.</td>
</tr>
<tr>
<td><strong>Flare Size</strong></td>
<td>Controls the size of the flare around the celestial body (in degrees). This is not a physically realist behavior but can be used to simulate sun flare when not using bloom or aerosol anisotropy of the PBR Sky.</td>
</tr>
<tr>
<td><strong>Flare Falloff</strong></td>
<td>Controls the falloff rate of flare intensity as the angle from the light increases.</td>
</tr>
<tr>
<td><strong>Flare Tint</strong></td>
<td>Controls the tint of the flare of the celestial body.</td>
</tr>
<tr>
<td><strong>Flare Multiplier</strong></td>
<td>Multiplies the flare intensity.</td>
</tr>
</tbody>
</table>

### Shading settings

The following settings appear depending on the value of the **Shading** property.

| **Property** | **Description** |
|----|----|
| **Sun Light Override** | Specify the Directional Light that should illuminate this Celestial Body. If not specified, HDRP uses the directional light in the scene with the highest intensity. |
| **Earthshine** | Controls the intensity of the light reflected from the planet onto the Celestial Body. |
| **Sun Color** | Sets the color of the artificial light source in **Manual** mode. |
| **Sun Intensity** | Sets the intensity of the artificial light source in **Manual** mode. |
| **Phase** | Controls the area of the surface illuminated by the Sun in **Manual** mode. A phase value of 0.5 means the surface is fully illuminated. |
| **Phase Rotation** | Rotates the light source relatively to the celestial body in **Manual** mode. |

<span id="Emission"></span>

## Emission

These settings define the emissive behavior of your Light. You can set the Light’s color, strength, and maximum range. If you don't see these properties in the Light Inspector, make sure you enable [advanced properties](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest?subfolder=/manual/advanced-properties.html). Most Lights share **Emission** properties. Below are the list of properties that more than one Light **Type** share, followed by unique properties only available for a single Light **Type**.

### Shared Properties

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
<td><strong>Light Appearance</strong></td>
<td>Selects how to set the color of the Light. The options are:
<ul>
<li><strong>Color</strong>: Displays the <strong>Color</strong> property so you can set the color of the Light.</li>
<li><strong>Filter and Temperature</strong> : Displays the <strong>Filter</strong> and <strong>Temperature</strong> properties. Set the color of the Light based on a red-to-blue kelvin temperature scale.</li>
</ul></td>
</tr>
<tr>
<td><strong>Color</strong></td>
<td>Allows you to select the color of the Light using the color picker.</td>
</tr>
<tr>
<td><strong>Filter</strong></td>
<td>Allows you to select the color of the Light’s filter using the color picker. HDRP uses this and the <strong>Temperature</strong> property to calculate the final color of the Light.</td>
</tr>
<tr>
<td><strong>Temperature</strong></td>
<td>Select a temperature on a red-to-blue kelvin scale that HDRP uses to calculate a color. Move the slider along the scale, or specify an exact temperature value in the field below the scale.<br />
The icon to the right of the slider represents the light source that best matches the current value set. Click the icon to access a list of preset values that match real-world light sources.</td>
</tr>
<tr>
<td><strong>Intensity</strong></td>
<td>The strength of the Light. Intensity is expressed in the following units:<br />
• A Spot Light can use <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Physical-Light-Units.html#Lumen">Lumen</a>, <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Physical-Light-Units.html#Candela">Candela</a>, <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Physical-Light-Units.html#Lux">Lux</a>, and <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Physical-Light-Units.html#EV">EV<sub>100</sub></a>.<br />
• A Directional Light can only use <strong>Lux</strong>.<br />
• A Point Light can use <strong>Lumen</strong>, <strong>Candela</strong>, <strong>Lux</strong>, and <strong>EV<sub>100</sub></strong>.<br />
• A Area Light can use <strong>Lumen</strong>, <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Physical-Light-Units.html#Nits">Nits</a>, and <strong>EV<sub>100</sub></strong>.<br />
<br />
Generally, the further the light travels from its source, the weaker it gets. The only exception to this is the <strong>Directional Light</strong> which has the same intensity regardless of distance. For the rest of the Light types, lower values cause light to diminish closer to the source. Higher values cause light to diminish further away from the source.<br />
<br />
This property includes an icon to the right of the slider which represents the light source that best matches the current value set. The icon is also a button which you can click to access a list of preset values that match real world light sources.</td>
</tr>
<tr>
<td><strong>Range</strong></td>
<td>The range of influence for this Light. Defines how far the emitted light reaches. This property is available for all <strong>Light Types</strong> except <strong>Directional</strong>.</td>
</tr>
<tr>
<td><strong>Indirect Multiplier</strong></td>
<td>The intensity of <a href="https://docs.unity3d.com/Manual/LightModes-TechnicalInformation.html">indirect</a> light in your Scene. A value of 1 mimics realistic light behavior. A value of 0 disables indirect lighting for this Light. If both <strong>Realtime</strong> and <strong>Baked</strong> Global Illumination are disabled in Lighting Settings (menu: <strong>Window &gt; Rendering &gt; Lighting Settings</strong>), the Indirect Multiplier has no effect.</td>
</tr>
<tr>
<td><strong>Cookie</strong></td>
<td>An RGB Texture that the Light projects. For example, to create silhouettes or patterned illumination for the Light. Texture shapes should be 2D for Spot and Directional Lights and Cube for Point Lights. Always import <strong>Cookie</strong> textures as the default texture type. This property is available for <strong>Spot</strong>, <strong>Area</strong> (Rectangular only), <strong>Directional</strong>, and <strong>Point</strong> Lights.<br />
Pyramid and Box lights will use an implicit 4x4 white cookie if none is specified.</td>
</tr>
<tr>
<td><strong>IES Profile</strong></td>
<td>An IES File that describes the light profile. HDRP uses a linear average of a cookie and an IES profile in your scene. If you use an IES profile and a cookie at the same time during light baking, the Light in your scene only uses the cookie. You can't assign an IES file with code. Instead, use the <strong>Cookie</strong> property with the Textures that IES generates.</td>
</tr>
<tr>
<td><strong>IES cutoff angle (%)</strong></td>
<td>Cut off of the IES Profile, as a percentage of the Outer angle. During a baking of a lightmap this parameter isn't used.</td>
</tr>
<tr>
<td><strong>Affect Diffuse</strong></td>
<td>Enable the checkbox to apply <a href="https://docs.unity3d.com/Manual/shader-NormalDiffuse.html">diffuse</a> lighting to this Light.<br />
This property only appears when you enable <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest?subfolder=/manual/advanced-properties.html">advanced properties</a> for this section. It's only available in Realtime or Mixed light <strong>Mode</strong>.</td>
</tr>
<tr>
<td><strong>Affect Specular</strong></td>
<td>Enable the checkbox to apply <a href="https://docs.unity3d.com/Manual/shader-NormalSpecular.html">specular</a> lighting to this Light.<br />
This property only appears when you enable <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest?subfolder=/manual/advanced-properties.html">advanced properties</a>for this section. It's only available in Realtime or Mixed light <strong>Mode</strong>.</td>
</tr>
<tr>
<td><strong>Range Attenuation</strong></td>
<td>Enable the checkbox to make this Light shine uniformly across its range. This stops light from fading around the edges. This setting is useful when the range limit isn't visible on screen, and you don't want the edges of your light to fade out. This property is available for all <strong>Light Types</strong> except <strong>Directional</strong>.<br />
This property only appears when you enable <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest?subfolder=/manual/advanced-properties.html">advanced properties</a> for this section. It's only available in Realtime or Mixed light <strong>Mode</strong> for <strong>Type</strong> Area.</td>
</tr>
<tr>
<td><strong>Fade Distance</strong></td>
<td>The distance between the Light source and the Camera at which the Light begins to fade out. Measured in meters. This property is available for all <strong>Light Types</strong> except <strong>Directional</strong>.<br />
This property only appears when you enable <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@17.2/manual/advanced-properties.html">additional properties</a> for this section. It's only available in Realtime or Mixed light <strong>Mode</strong>.</td>
</tr>
<tr>
<td><strong>Intensity Multiplier</strong></td>
<td>A multiplier that gets applied to the intensity of the Light. Doesn't affect the intensity value, but only gets applied during the evaluation of the lighting. You can also modify this property via <a href="https://docs.unity3d.com/Manual/TimelineSection.html">Timeline</a>, Scripting or <a href="https://docs.unity3d.com/Manual/animeditor-AnimatingAGameObject.html">animation</a>. The parameter lets you fade the Light in and out without having to store its original intensity.<br />
This property does not affect the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/physically-based-sky-volume-override-reference.html">Physically Based Sky</a> rendering for the main directionnal light.<br />
This property only appears when you enable <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest?subfolder=/manual/advanced-properties.html">advanced properties</a> for this section. It's only available in Realtime or Mixed light <strong>Mode</strong>.</td>
</tr>
<tr>
<td><strong>Display Emissive Mesh</strong></td>
<td>Enable the checkbox to make Unity automatically generate a Mesh with an emissive Material using the size, color, and intensity of this Light. Unity automatically adds the Mesh and Material to the GameObject the Light component is attached to. This property is available for <strong>Rectangle</strong> and <strong>Tube</strong> Lights.<br />
This property only appears when you enable <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest?subfolder=/manual/advanced-properties.html">advanced properties</a> for this section. (In case of an IES profile and a cookie used at the same time, only the cookie will be displayed).</td>
</tr>
<tr>
<td><strong>Include For Ray Tracing</strong></td>
<td>Enable the checkbox to make this Light active when you enable the <strong>Ray Tracing</strong> <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Frame-Settings.html">Frame Setting</a> on the Camera. This applies to rasterization and <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Ray-Tracing-Getting-Started.html">ray tracing</a> passes.<br />
This property only appears when you enable <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest?subfolder=/manual/advanced-properties.html">advanced properties</a> for this section. It's only available in Realtime or Mixed light <strong>Mode</strong>.</td>
</tr>
<tr>
<td><strong>Include For Path Tracing</strong></td>
<td>Enable the checkbox to make this Light active when <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Ray-Tracing-Path-Tracing.html">Path Tracing</a> is enabled.</td>
</tr>
</tbody>
</table>

### Spot Light

| **Property** | **Description** |
|----|----|
| **Reflector** | Enable the checkbox to simulate a reflective surface behind the Spot Light. Spot Lights are Point Lights that are partly occluded at the back by a reflective surface. Simulating this reflective surface increases the intensity of the Spot Light because the reflective surface reflects light originally directed backwards to focus the intensity in the Spot Light’s direction. |

### Directional Light

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
<td><strong>Size X</strong></td>
<td>The horizontal size of the projected cookie texture in pixels.<br />
This property only appears when you set a <strong>Cookie</strong> in the Light Inspector.</td>
</tr>
<tr>
<td><strong>Size Y</strong></td>
<td>The vertical size of the projected cookie texture in pixels.<br />
This property only appears when you set a <strong>Cookie</strong> in the Light Inspector.</td>
</tr>
</tbody>
</table>

<span id="Volumetric"></span>

## Volumetrics

These settings define the volumetric behavior of this Light. Alter these settings to change how this Light behaves with [Atmospheric Scattering](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Atmospheric-Scattering.html). All Light **Types** share the same **Volumetric** properties, except **Area** Light. It's only available in Realtime or Mixed light **Mode**.

| **Property** | **Description** |
|----|----|
| **Enable** | Enable the checkbox to simulate light scattering through volumetric fog. Enabling this property allows you to edit the **Multiplier** and **Shadow Dimmer** properties. |
| **Multiplier** | Sets the intensity of the volumetric lighting effect of this Light. |
| **Shadow Dimmer** | Dims the volumetric shadows the light casts. If you set this property to zero, Unity no longer samples the shadow map to create volumetric shadows, which might reduce the performance impact. |

<span id="Shadow"></span>

## **Shadows**

Use this section to adjust the Shadows cast by this Light.

Unity exposes extra properties in this section depending on the **Mode** you set in the [General](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/reference-light-component.html#general) section. Unity also exposes extra properties depending on the **Filtering Quality** set in your Unity Project’s [HDRP Asset](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html).

For more information on shadow filtering in HDRP, refer to [Shadow Filtering](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Shadows-in-HDRP.html##ShadowFiltering). For a list of the available filter quality presets in HDRP, refer to the [Filtering Qualities table](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html#filtering-quality).

### Shadow Map

This section is only available in Realtime or Mixed light **Mode**.

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
<td><strong>Enable</strong></td>
<td>Enable the checkbox to let this Light cast shadows.</td>
</tr>
<tr>
<td><strong>Update Mode</strong></td>
<td>Determines how often HDRP updates the shadow map for the Light. The options are:
<ul>
<li><strong>Every Frame</strong>: Updates the shadow maps for the Light every frame. This is the default value.</li>
<li><strong>On Enable</strong>: Updates the shadow maps for the Light only when you enable the GameObject.</li>
<li><strong>On Demand</strong>: Updates the shadow maps for the Light only when you call the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/api/UnityEngine.Rendering.HighDefinition.HDAdditionalLightData.html#UnityEngine_Rendering_HighDefinition_HDAdditionalLightData_RequestShadowMapRendering" class="xref"><code>HDAdditionalLightData.RequestShadowMapRendering</code></a> API to update them.</li>
</ul>
For more information, refer to <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/shadow-update-mode.html">Update shadows less frequently</a>.</td>
</tr>
<tr>
<td><strong>Resolution</strong></td>
<td>Set the resolution of this Light’s shadow maps. Use the drop-down to select which quality mode to derive the resolution from. If you don't enable <strong>Use Quality Settings</strong>, or you select <strong>Custom</strong>, set the resolution, measured in pixels, in the input field.<br />
A higher resolution increases the fidelity of shadows at the cost of GPU performance and memory usage, so if you experience any performance issues, try using a lower value. Shadows can be turned off by setting the resolution to 0.</td>
</tr>
<tr>
<td><strong>Near Plane</strong></td>
<td>The distance, in meters, from the Light that GameObjects begin to cast shadows.</td>
</tr>
<tr>
<td><strong>Shadowmask Mode</strong></td>
<td>Defines how the shadowmask behaves for this Light. For detailed information on each <strong>Shadowmask Mode</strong>, see the documentation on <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Lighting-Mode-Shadowmask.html">Shadowmasks</a>. This property is only visible if you tet the <strong>Mode</strong>, under <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/reference-light-component.html#general">General</a>, to <strong>Mixed</strong>.</td>
</tr>
<tr>
<td><strong>Slope-Scale Depth Bias</strong></td>
<td>Use the slider to set the bias that HDRP adds to the distance in this Light's shadow map to avoid self intersection. This bias is proportional to the slope of the polygons represented in the shadow map.<br />
This property only appears when you enable <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest?subfolder=/manual/advanced-properties.html">advanced properties</a> for this section.</td>
</tr>
<tr>
<td><strong>Normal Bias</strong></td>
<td>Controls the amount of normal <a href="https://docs.unity3d.com/Manual/ShadowOverview.html#LightBias">bias</a> this Light applies along the <a href="https://docs.unity3d.com/Manual/AnatomyofaMesh.html">normal</a> of the illuminated surface.<br />
This property only appears when you enable <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest?subfolder=/manual/advanced-properties.html">advanced properties</a> for this section.</td>
</tr>
<tr>
<td><strong>Custom Spot Angle</strong></td>
<td>Enable the checkbox to use a custom angle to render shadow maps with.<br />
This property only appears if you select <strong>Spot</strong> from the <strong>Type</strong> drop-down and enable <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest?subfolder=/manual/advanced-properties.html">advanced properties</a> for this section.</td>
</tr>
<tr>
<td><strong>Shadow Angle</strong></td>
<td>Use the slider to set a custom angle to use for shadow map rendering.<br />
This property only appears if you enable <strong>Custom Spot Angle</strong> and enable <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest?subfolder=/manual/advanced-properties.html">advanced properties</a> for this section.</td>
</tr>
<tr>
<td><strong>Shadow Cone</strong></td>
<td>Use the slider to set the aperture of the shadow cone this area Light uses for shadowing. This property only appears if you select <strong>Rectangle</strong> from the <strong>Type</strong> drop-down.</td>
</tr>
<tr>
<td><strong>EVSM Exponent</strong></td>
<td>Use the slider to set the exponent this area Light uses for depth warping. <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Glossary.html#ExponentialVarianceShadowMap">EVSM</a> modifies its shadow distribution representation by this exponent. Increase this value to reduce light leaking and change the appearance of the shadow. This property only appears if you select <strong>Rectangle</strong> from the <strong>Type</strong> drop-down and enable <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest?subfolder=/manual/advanced-properties.html">advanced properties</a> for this section.</td>
</tr>
<tr>
<td><strong>Light Leak Bias</strong></td>
<td>Use this slider to set the bias that HDRP uses to prevent light leaking through Scene geometry. Increasing this value prevents light leaks, but removes some of the shadow softness. This property only appears if you select <strong>Rectangle</strong> from the <strong>Type</strong> drop-down and enable <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@17.2/manual/advanced-properties.html">additional properties</a> for this section.</td>
</tr>
<tr>
<td><strong>Variance Bias</strong></td>
<td>Use the slider to fix numerical accuracy issues in the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Glossary.html#ExponentialVarianceShadowMap">EVSM</a>. This property only appears if you select <strong>Rectangle</strong> from the <strong>Type</strong> drop-down and enable <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest?subfolder=/manual/advanced-properties.html">advanced properties</a> for this section.</td>
</tr>
<tr>
<td><strong>Blur Passes</strong></td>
<td>Use the slider to set the number of blur passes HDRP performs on this shadow map. Increasing this value softens shadows, but impacts performance. This property only appears if you select <strong>Rectangle</strong> from the <strong>Type</strong> drop-down and enable <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest?subfolder=/manual/advanced-properties.html">advanced properties</a> for this section.</td>
</tr>
<tr>
<td><strong>Dimmer</strong></td>
<td>Dims the shadows this Light casts so they become more faded and transparent.<br />
This property only appears when you enable <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest?subfolder=/manual/advanced-properties.html">advanced properties</a> for this section.</td>
</tr>
<tr>
<td><strong>Tint</strong></td>
<td>Specifies whether HDRP should tint the shadows this Light casts. This option affects dynamic shadows, <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Override-Contact-Shadows.html">Contact Shadows</a>, and <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Lighting-Mode-Shadowmask.html">ShadowMask</a>. It doesn't affect baked shadows. You can use this behavior to change the color and transparency of shadows.<br />
This property only appears when you enable <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest?subfolder=/manual/advanced-properties.html">advanced properties</a> for this section.</td>
</tr>
<tr>
<td><strong>Penumbra Tint</strong></td>
<td>Specifies whether the tint should only affect the shadow's penumbra. If you enable this property, HDRP only applies the color tint to the shadow's penumbra. If you disable this property, HDRP applies the color tint to the entire shadow including the penumbra. To change the color HDRP tints the shadow to, see the above <strong>Tint</strong> property.<br />
This property only appears when you enable <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest?subfolder=/manual/advanced-properties.html">advanced properties</a>for this section.</td>
</tr>
<tr>
<td><strong>Fade Distance</strong></td>
<td>The distance, in meters, between the Camera and the Light at which shadows fade out. This property is available for <strong>Spot</strong> and <strong>Point</strong> Lights.<br />
This property only appears when you enable <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@17.2/manual/advanced-properties.html">additional properties</a> for this section.</td>
</tr>
<tr>
<td><strong>Custom Shadow Layers</strong></td>
<td>Enable the checkbox to use a different <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Rendering-Layers.html">Rendering Layer Mask</a> for shadows than the one used for lighting. If you enable this feature, then HDRP uses the <strong>Shadow Layers</strong> drop-down in this section for shadowing. If you disable it, then HDRP uses the <strong>Rendering Layer Mask</strong> drop-down in the <strong>General</strong> section for shadowing.<br />
This property only appears when you enable <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest?subfolder=/manual/advanced-properties.html">advanced properties</a> for this section. To access this property, enable <strong>Light Layers</strong> in your <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html">HDRP Asset</a>.</td>
</tr>
<tr>
<td><strong>Shadow Layers</strong></td>
<td>Use the drop-down to set the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Rendering-Layers.html">Rendering Layer Mask</a> HDRP uses for shadowing. This Light therefore only casts shadows for GameObjects that use a matching Rendering Layer. For more information about using Rendering Layers for shadowing, see <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Rendering-Layers.html#ShadowLightLayers">Shadow Light Layers</a>.<br />
This property only appears when you enable <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest?subfolder=/manual/advanced-properties.html">advanced properties</a> for this section. To access this property, enable the <strong>Custom Shadow Layers</strong> checkbox.</td>
</tr>
</tbody>
</table>

### Contact Shadows

This section is only available in Realtime or Mixed light **Mode**.

| **Property** | **Description** |
|----|----|
| **Enable** | Add [Contact Shadows](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Override-Contact-Shadows.html) to this Light. Use the drop-down to select a quality mode for the Contact Shadows. Select **Custom** to expose a checkbox that allows you to enable or disable Contact Shadows at will. |

### Baked Shadows

This section is only available in Baked light **Mode**.

| **Property** | **Description** |
|----|----|
| **Enable** | Enable the checkbox to let this Light cast shadows. |
| **Near Plane** | The distance, in meters, from the Light that GameObjects begin to cast shadows. |

### High Quality Settings

In your [HDRP Asset](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html), select **High** from the **Filtering Quality** drop-down to expose the following properties.

| **Property** | **Description** |
|----|----|
| **Max Penumbra Size** | Sets the maximum blurriness of the edge of shadows that HDRP calculates as percentage-closer soft shadows (PCSS). If you increase this value, you might need to increase **Blocker Sample Count** and **Filter Sample Count** to maintain shadow quality. |
| **Max Sampling Distance** | Sets the distance from the shadow receiver where the edge of shadows reaches the **Max Penumbra Size**. Lower values reduce light bleeding, but might increase self-shadowing. |
| **Min Filter** | The minimum size of the whole shadow’s blur effect, no matter the distance between the pixel and the shadow caster. Higher values give blurrier results. |
| **Min Filter Max Angular Diameter** | Specifies how small shadows can get before HDRP uses the **Min Filter** size. Lower values help reduce self-shadowing. Higher values might increase light bleeding. |
| **Blocker Search Angular Diameter** | Specifies how much of the shadow map HDRP searches to find shadow casters, also known as blockers. Increasing this value might detect hidden or close shadow casters, but might also increase self-shadowing. |
| **Blocker Sampling Clump Exponent** | Adjusts the distribution of samples when HDRP searches for shadow casters in the shadow map. Higher values concentrate samples closer to the center, affecting the accuracy and blurriness of the shadow edge. |
| **Blocker Sample Count** | Sets the number of samples HDRP uses to calculate the distance between the pixel receiving the shadow and the shadow caster. Higher values give better accuracy. |
| **Filter Sample Count** | Sets the number of samples HDRP uses to blur shadows. Higher values give smoother results. |
| **Radius Scale for Softness** | Scales the radius that HDRP uses to calculate blurriness from the light source. Higher values give larger, blurrier results. |
