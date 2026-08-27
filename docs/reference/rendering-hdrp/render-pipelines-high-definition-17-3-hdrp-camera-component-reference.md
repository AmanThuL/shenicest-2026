---
title: "HDRP Camera component reference"
page_title: "HDRP camera component reference | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/hdrp-camera-component-reference.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/hdrp-camera-component-reference.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# HDRP camera component reference

The High Definition Render Pipeline (HDRP) adds extra properties and methods to Unity's [standard Camera](https://docs.unity3d.com/ScriptReference/Camera.html) to control HDRP features, such as [Frame Settings](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Frame-Settings.html). Although HDRP displays these extra properties in the Camera component Inspector, HDRP stores them in the [HDAdditionalCameraData](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@latest?subfolder=/api/UnityEngine.Rendering.HighDefinition.HDAdditionalCameraData.html) component. This means if you use a script to access properties or methods for the Camera, be aware that they may be inside the HDAdditionalCameraData component. For the full list of properties and methods HDRP stores in the HDAdditionalCameraData component, see the [scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@latest?subfolder=/api/UnityEngine.Rendering.HighDefinition.HDAdditionalCameraData.html).

## Properties

The HDRP Camera shares many properties with Unity's [standard Camera](https://docs.unity3d.com/Manual/class-Camera.html).

The Camera Inspector includes the following groups of properties:

- [Projection](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/hdrp-camera-component-reference.html#Projection)
  - [Physical Camera](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/hdrp-camera-component-reference.html#PhysicalCamera)
- [Rendering](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/hdrp-camera-component-reference.html#Rendering)
- [Environment](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/hdrp-camera-component-reference.html#Environment)
- [Output](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/hdrp-camera-component-reference.html#Output)

<span id="Projection"></span>

### Projection

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
<td><strong>Projection</strong></td>
<td>Use the drop-down to select the projection mode for the Camera.<br />
• <strong>Perspective</strong>: The Camera simulates perspective when it renders GameObjects. This means that GameObjects further from the Camera appear smaller than GameObjects that are closer.<br />
• <strong>Orthographic</strong>: The Camera renders GameObjects uniformly with no perspective. This means that GameObjects further from the Camera appear to be the same size as GameObjects that are closer. Currently, HDRP doesn't support this projection mode. If you select this projection mode, any HDRP feature that requires lighting doesn't work consistently. This also applies in the Scene view when the Scene view Camera uses orthographic (isometric) projection mode. However, this projection mode does work consistently with <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/unlit-material.html">Unlit</a> Materials.</td>
</tr>
<tr>
<td><strong>Size</strong></td>
<td>Set the size of the orthographic Camera.<br />
This property only appears when you select <strong>Orthographic</strong> from the <strong>Projection</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Field of View Axis</strong></td>
<td>Use the drop-down to select the axis that you want the field of view to relate to.<br />
• <strong>Vertical</strong>: Allows you to set the <strong>Field of View</strong> using the vertical axis.<br />
• <strong>Horizontal</strong>: Allows you to set the <strong>Field of View</strong> using the horizontal axis. This property only appears when you select <strong>Perspective</strong> from the <strong>Projection</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Field of View</strong></td>
<td>Use the slider to set the viewing angle for the Camera, in degrees.<br />
This property only appears when you select <strong>Perspective</strong> from the <strong>Projection</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Physical Camera</strong></td>
<td>Enable the checkbox to make the Camera use its <strong>Physical Settings</strong> to calculate its viewing angle. This property only appears when you select <strong>Perspective</strong> from the <strong>Projection</strong> drop-down.</td>
</tr>
<tr>
<td><strong>Clipping Planes</strong></td>
<td>Set the distances from the Camera at which Unity uses it to start and stop rendering GameObjects.<br />
• <strong>Near</strong>: The distance from the Camera at which Unity begins to use it to draw GameObjects. The Camera doesn't render anything that's closer to it than this distance.<br />
• <strong>Far</strong>: The distance from the Camera at which Unity ceases to use it to draw GameObjects. The Camera doesn't render anything that's further away from it than this distance.</td>
</tr>
</tbody>
</table>

<span id="PhysicalCamera"></span>

### Physical Camera

<table>
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<thead>
<tr>
<th><strong>Property</strong></th>
<th></th>
<th style="text-align: left;"><strong>Description</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>Camera Body</strong></td>
<td></td>
<td style="text-align: left;"></td>
</tr>
<tr>
<td></td>
<td><strong>Sensor Type</strong></td>
<td style="text-align: left;">Use the drop-down to select the real-world camera format that you want the Camera to simulate. When you select a Camera <strong>Sensor Type</strong>, Unity automatically sets the <strong>Sensor Size</strong> to the correct values for that format. If you change the <strong>Sensor Size</strong> values manually, Unity automatically sets this property to <strong>Custom</strong>.</td>
</tr>
<tr>
<td></td>
<td><strong>Sensor Size</strong></td>
<td style="text-align: left;">Set the size, in millimeters, of the real-world camera sensor. Unity sets the <strong>X</strong> and <strong>Y</strong> values automatically when you select the <strong>Sensor Type</strong>. You can enter custom values to fine-tune your sensor.</td>
</tr>
<tr>
<td></td>
<td><strong>ISO</strong></td>
<td style="text-align: left;">Set the sensibility of the real-world camera sensor. Higher values increase the Camera's sensitivity to light and result in faster exposure times. This property affects <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Override-Exposure.html">Exposure</a> if you set its <strong>Mode</strong> to <strong>Use Physical Camera</strong>.</td>
</tr>
<tr>
<td></td>
<td><strong>Shutter Speed</strong></td>
<td style="text-align: left;">Set the exposure time for the camera. Lower values result in less exposed pictures. Use the drop-down to select the units for the exposure time. You can use <strong>Seconds</strong> or <strong>1/Seconds</strong>. This property affects <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Override-Exposure.html">Exposure</a> if you set its <strong>Mode</strong> to <strong>Use Physical Camera</strong>.</td>
</tr>
<tr>
<td></td>
<td><strong>Gate Fit</strong></td>
<td style="text-align: left;">Use the drop-down to select the method that Unity uses to set the size of the resolution gate (aspect ratio of the device you run the application on) relative to the film gate (aspect ratio of the Physical Camera sensor). <strong>Vertical</strong>: Fits the resolution gate to the height of the film gate. If the sensor aspect ratio is larger than the device aspect ratio, Unity crops the rendered image at the sides. If the sensor aspect ratio is smaller than the device aspect ratio, Unity overscans the rendered image at the sides. If you select this method, changing the sensor width (<strong>Sensor Size</strong> &gt; <strong>X</strong> property) has no effect on the rendered image.<br />
• <strong>Horizontal</strong>: Fits the resolution gate to the width of the film gate. If the sensor aspect ratio is larger than the device aspect ratio, Unity overscans the rendered image on the top and bottom. If the sensor aspect ratio is smaller than the device aspect ratio, Unity crops the rendered image on the top and bottom. If you select this method, changing the sensor height (<strong>Sensor Size</strong> &gt; <strong>Y</strong> property) has no effect on the rendered image.<br />
• <strong>Fill</strong>: Fits the resolution gate to either the width or height of the film gate, whichever is smaller. This crops the rendered image.<br />
• <strong>Overscan</strong>: Fits the resolution gate to either the width or height of the film gate, whichever is larger. This overscans the rendered image.<br />
• <strong>None</strong>: Ignores the resolution gate and uses the film gate only. This stretches the rendered image to fit the device aspect ratio.</td>
</tr>
<tr>
<td><strong>Lens</strong></td>
<td></td>
<td style="text-align: left;"></td>
</tr>
<tr>
<td></td>
<td><strong>Focal Length</strong></td>
<td style="text-align: left;">Set the distance, in millimeters, between the Camera sensor and the Camera lens. Lower values result in a wider <strong>Field of View</strong>, and vice versa. This property affects <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Depth-of-Field.html">Depth of Field</a> if you set its <strong>Focus Mode</strong> to <strong>Use Physical Camera</strong>.</td>
</tr>
<tr>
<td></td>
<td><strong>Shift</strong></td>
<td style="text-align: left;">Set the horizontal and vertical shift from the center. Values are multiples of the sensor size; for example, a shift of 0.5 along the <strong>X</strong> axis offsets the sensor by half its horizontal size. You can use lens shifts to correct distortion that occurs when the Camera is at an angle to the subject (for example, converging parallel lines). Shift the lens along either axis to make the Camera frustum <a href="https://docs.unity3d.com/Manual/ObliqueFrustum.html">oblique</a>.</td>
</tr>
<tr>
<td></td>
<td><strong>Aperture</strong></td>
<td style="text-align: left;">Use the slider to set the ratio of the f-stop or <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Glossary.html#f-number">f-number</a> aperture. The smaller the value is, the shallower the depth of field is and more light reaches the sensor. This property affects <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Depth-of-Field.html">Depth of Field</a> if you set its <strong>Focus Mode</strong> to <strong>Use Physical Camera</strong>. This property also affects <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Override-Exposure.html">Exposure</a> if you set its <strong>Mode</strong> to <strong>Use Physical Camera</strong>.</td>
</tr>
<tr>
<td></td>
<td><strong>Focus Distance</strong></td>
<td style="text-align: left;">Sets the distance of the focus plane from the Camera. This property is only used in DoF computations if the <strong>Focus Distance Mode</strong> in the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Depth-of-Field.html">Depth of Field</a> volume component is set to <strong>Camera</strong>.</td>
</tr>
<tr>
<td></td>
<td><strong>Blade Count</strong></td>
<td style="text-align: left;">Use the slider to set the number of diaphragm blades the Camera uses to form the aperture. This property affects the look of the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Depth-of-Field.html">Depth of Field</a> <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Glossary.html#Bokeh">bokeh</a>.</td>
</tr>
<tr>
<td></td>
<td><strong>Curvature</strong></td>
<td style="text-align: left;">Use the remapper to map an aperture range to blade curvature. Aperture blades become more visible on bokeh at higher aperture values. Tweak this range to define how the bokeh looks at a given aperture. The minimum value results in fully-curved, perfectly-circular bokeh, and the maximum value results in fully-shaped bokeh with visible aperture blades. This property affects the look of the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Depth-of-Field.html">Depth of Field</a> bokeh.</td>
</tr>
<tr>
<td></td>
<td><strong>Barrel Clipping</strong></td>
<td style="text-align: left;">Use the slider to set the strength of the “cat eye” effect. You can see this effect on bokeh as a result of lens shadowing (distortion along the edges of the frame). This property affects the look of the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Depth-of-Field.html">Depth of Field</a> bokeh.</td>
</tr>
<tr>
<td></td>
<td><strong>Anamorphism</strong></td>
<td style="text-align: left;">Use the slider to stretch the sensor to simulate an anamorphic look. Positive values distort the Camera vertically, negative values distort the Camera horizontally. This property affects the look of the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Depth-of-Field.html">Depth of Field</a> bokeh and the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Bloom.html">Bloom</a> effect if you enable its <em>Anamorphic</em> property.</td>
</tr>
</tbody>
</table>

<span id="Rendering"></span>

## Rendering

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
<td><strong>HDRP Dynamic Resolution</strong></td>
<td>Enable the checkbox to make this Camera support dynamic resolution for buffers linked to it.</td>
</tr>
<tr>
<td><strong>Allow DLSS</strong></td>
<td>Enables NVIDIA Deep Learning Super Sampling (DLSS). This property has an effect only if you add DLSS to your <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html">HDRP Asset</a>. For more information, refer to <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/hdrp-camera-component-reference.html#dlss-settings">DLSS settings</a>.</td>
</tr>
<tr>
<td><strong>Allow FSR2</strong></td>
<td>Enables AMD FidelityFX Super Resolution 2.0 (FSR2). This property has an effect only if you add FSR2 to your <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html">HDRP Asset</a>. For more information, refer to <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/hdrp-camera-component-reference.html#fsr2-settings">FSR2 settings</a>.</td>
</tr>
<tr>
<td><strong>Override FSR Sharpness</strong></td>
<td>Enables an <strong>FSR Sharpness</strong> slider that lets you set the sharpness of the FidelityFX Super Resolution 1.0 (FSR1) upscale filter. A value of 1.0 means maximum sharpness. A value of 0 means no sharpening. This property has an effect only if you set <strong>Default Upscale Filter</strong> to <strong>FSR1</strong> in your <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html">HDRP Asset</a>.</td>
</tr>
<tr>
<td><strong>Post Anti-aliasing</strong></td>
<td>This Camera can use <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Anti-Aliasing.html#MSAA">multisample anti-aliasing (MSAA)</a>, at the same time as post-process anti-aliasing. This is because MSAA is a hardware feature. To control post-process anti-aliasing, use the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Frame-Settings.html">Frame Settings</a>.<br />
• <strong>No Anti-aliasing</strong>: This Camera processes MSAA but doesn't perform any post-process anti-aliasing.<br />
• <strong>Fast Approximate Anti-aliasing (FXAA)</strong>: Smooths edges on a per-pixel level. This is the most efficient anti-aliasing technique in HDRP.<br />
• <strong>Temporal Anti-aliasing (TAA)</strong>: Uses frames from a history buffer to smooth edges more effectively than fast approximate anti-aliasing.<br />
• <strong>Subpixel Morphological Anti-aliasing (SMAA)</strong>: Finds patterns in borders of the image and blends the pixels on these borders according to the pattern.</td>
</tr>
<tr>
<td><strong>Dithering</strong></td>
<td>Enable the checkbox to apply 8-bit dithering to the final render. This can help reduce banding on wide gradients and low light areas.</td>
</tr>
<tr>
<td><strong>Stop NaNs</strong></td>
<td>Enable the checkbox to make this Camera replace values that aren't a number (NaN) with a black pixel. This stops certain effects from breaking, but is a resource-intensive process. Only enable this feature if you experience NaN issues that you can't fix.</td>
</tr>
<tr>
<td><strong>Culling Mask</strong></td>
<td>Use the drop-down to set the Layer Mask that the Camera uses to exclude GameObjects from the rendering process. The Camera only renders Layers that you include in the Layer Mask.</td>
</tr>
<tr>
<td><strong>Occlusion Culling</strong></td>
<td>Enable the checkbox to make this Camera not render GameObjects that aren't currently visible. For more information, refer to the <a href="https://docs.unity3d.com/Manual/OcclusionCulling.html">Occlusion Culling documentation</a>.</td>
</tr>
<tr>
<td><strong>Exposure Target</strong></td>
<td>The GameObject to center the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Override-Exposure.html">Auto Exposure</a> procedural mask around.</td>
</tr>
</tbody>
</table>

<span id="dlss-settings"></span>

### DLSS settings

The following properties are available only if you enable **Allow DLSS**.

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
<td><strong>Use DLSS Custom Quality</strong></td>
<td>Indicates whether this Camera overrides the DLSS quality mode specified in the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html">HDRP Asset</a>.</td>
</tr>
<tr>
<td><strong>DLSS Mode</strong></td>
<td>Sets whether DLSS prioritizes quality or performance. The options are:
<ul>
<li><strong>Maximum Quality</strong></li>
<li><strong>Balanced</strong></li>
<li><strong>Maximum Performance</strong></li>
<li><strong>Ultra Performance</strong></li>
<li><strong>DLAA</strong></li>
</ul>
This property is available only if you enable <strong>Use DLSS Custom Quality</strong>.</td>
</tr>
<tr>
<td><strong>Use DLSS Custom Attributes</strong></td>
<td>Overrides the DLSS properties specified in the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html">HDRP Asset</a>, on this camera.</td>
</tr>
<tr>
<td><strong>DLSS Use Optimal Settings</strong></td>
<td>Enables DLSS to automatically control screen percentage. This property is available only if you enable <strong>Use DLSS Custom Attributes</strong>.</td>
</tr>
</tbody>
</table>

<span id="fsr2-settings"></span>

### FSR2 settings

The following properties are available only if you enable **Allow FSR2**.

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
<td><strong>Use FSR2 Custom Quality</strong></td>
<td>Indicates whether this camera overrides the FSR2 quality mode specified in the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html">HDRP Asset</a>.</td>
</tr>
<tr>
<td><strong>FSR2 Use Optimal Settings</strong></td>
<td>Enables the <strong>FSR2 Mode</strong> property. This property is available only if you enable <strong>Use FSR2 Custom Quality</strong>.</td>
</tr>
<tr>
<td><strong>FSR2 Mode</strong></td>
<td>Sets whether FSR2 prioritizes quality or performance. The options are:
<ul>
<li><strong>Quality</strong></li>
<li><strong>Balanced</strong></li>
<li><strong>Performance</strong></li>
<li><strong>Ultra Performance</strong></li>
</ul>
This property is available only if you enable <strong>FSR2 Use Optimal Settings</strong>.</td>
</tr>
<tr>
<td><strong>Use FSR2 Custom Attributes</strong></td>
<td>Overrides the FSR2 properties specified in the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html">HDRP Asset</a>, on this camera.</td>
</tr>
<tr>
<td><strong>FSR2 Enable Sharpness</strong></td>
<td>Enables an <strong>FSR2 Sharpness</strong> slider that lets you set the sharpness of the FSR2 upscale filter. A value of 1.0 means maximum sharpness. A value of 0 means no sharpening. You can also set the sharpness in your <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html">HDRP Asset</a>. This property is available only if you enable <strong>Use FSR2 Custom Attributes</strong>.</td>
</tr>
</tbody>
</table>

<span id="taa-settings"></span>

### TAA settings

The following properties are available only if you set **Post Anti-aliasing** to **Temporal Anti-aliasing (TAA)**.

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
<td><strong>Quality Preset</strong></td>
<td>The quality level of TAA. The default settings for higher presets aren't guaranteed to produce better results than lower presets. The result depends on the content in your scene. However, the high quality presets give you more options that you can use to adapt the anti-aliasing to your content.</td>
</tr>
<tr>
<td><strong>Sharpening Mode</strong></td>
<td>Specifies the sharpening method to use.<br />
• <strong>Low quality</strong>: Provides fast sharpening, but might produce lower quality results or artifacts compared to the other sharpening methods.<br />
• <strong>Post Sharpen</strong>: Provides higher-quality sharpening than <strong>Low Quality</strong>, but is more resource-intensive.<br />
• <strong>Contrast Adaptive Sharpening</strong>: AMD's FidelityFX Contrast Adaptive Sharpening. Provides higher-quality sharpening than <strong>Low Quality</strong>, but gives you less control.</td>
</tr>
<tr>
<td><strong>Sharpen Strength</strong></td>
<td>The intensity of the sharpening filter that Unity applies to the result of TAA. This reduces the soft look that TAA can produce. High values can cause ringing issues (dark lines along the edges of geometry)</td>
</tr>
<tr>
<td><strong>Ringing Reduction</strong></td>
<td>Controls how much of the sharpening result HDRP takes from the result without ringing. Reduces unnatural dark outlines, but might also decrease sharpening. Values above 0.0 lead to a small extra cost. This property appears only when you set <strong>TAA Sharpening Mode</strong> to <strong>Post Sharpen</strong></td>
</tr>
<tr>
<td><strong>History Sharpening</strong></td>
<td>Sets the strength of the history sharpening effect. When this value is above 0, Unity samples the history buffer with a bicubic filter that sharpens the result of TAA. You can use this to produce a sharper image during motion. A high value can cause ringing issues (dark lines along the edges of geometry). If you set this value to 0, it increases the performance of TAA because Unity simplifies the history buffer sampling</td>
</tr>
<tr>
<td><strong>Anti-flickering</strong></td>
<td>Sets the strength of TAA's anti-flickering effect. Use this to reduce some cases of flickering. Increasing this value might lead to more <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Glossary.html#Ghosting">ghosting</a> or <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Glossary.html#Disocclusion">disocclusion</a> artifacts.<br />
This property is only visible when <strong>TAA Quality Preset</strong> is set to a value above <strong>Low</strong>.</td>
</tr>
<tr>
<td><strong>Speed rejection</strong></td>
<td>Controls the threshold at which Unity rejects history buffer contribution for TAA. You can increase this value to remove ghosting artifacts. This works because Unity rejects history buffer contribution when a GameObject's current speed and reprojected speed history are very different. When you increase this value, it might also reintroduce some aliasing for fast-moving GameObjects. Setting this value to 0 increases the performance of TAA because Unity doesn't process speed rejection.</td>
</tr>
<tr>
<td><strong>Anti-ringing</strong></td>
<td>Enable this property to reduce the ringing artifacts caused by high history sharpening values. When you enable this property, it reduces the effect of the history sharpening. This property is only visible when TAA Quality Preset is set to <strong>High</strong>.</td>
</tr>
<tr>
<td><strong>Base blend factor</strong></td>
<td>Determines how much the history buffer is blended together with the current frame result. Higher values mean more history contribution, which leads to better anti-aliasing, but is also more prone to ghosting.<br />
This property is only visible when Advanced properties are displayed for the camera.</td>
</tr>
<tr>
<td><strong>Jitter Scale</strong></td>
<td>Controls the scale of jitter, which is the random offset HDRP applies to the camera position at each frame. Use a low value to reduce flickering and jittering at the cost of more aliasing.</td>
</tr>
</tbody>
</table>

<span id="smaa-settings"></span>

### SMAA settings

The following properties are available only if you set **Post Anti-aliasing** to **Subpixel Morphological Anti-aliasing (SMAA)**.

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
<td><strong>SMAA Quality Preset</strong></td>
<td>Use the drop-down to select the quality of SMAA. The difference in resource intensity is small between <strong>Low</strong> and <strong>High</strong>.<br />
• <strong>Low</strong>: The lowest SMAA quality. This is the least resource-intensive option.<br />
• <strong>Medium</strong>: A good balance between SMAA quality and resource intensity.<br />
• <strong>High</strong>: The highest SMAA quality. This is the most resource-intensive option. This property only appears when you select <strong>Subpixel Morphological Anti-aliasing (SMAA)</strong> from the <strong>Anti-aliasing</strong> drop-down.</td>
</tr>
</tbody>
</table>

<span id="Environment"></span>

## Environment

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
<td><strong>Background Type</strong></td>
<td>Use the drop-down to select the type of background that the Camera fills the screen with before it renders a frame.<br />
• <strong>Sky</strong>: The Camera fills the screen with the sky defined in the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/visual-environment-volume-override-reference.html">Visual Environment</a> of the current <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html">Volume</a> settings.<br />
• <strong>Color</strong>: The Camera fills the screen with the color set in <strong>Background Color</strong>.<br />
• <strong>None</strong>: The Camera doesn't clear the screen and the color buffer is left uninitialized. In this case, there are no guarantees on what the contents of the buffer are when you start drawing. It could be content from the previous frame or content from another camera. Because of this, use this option with caution.</td>
</tr>
<tr>
<td><strong>Background Color</strong></td>
<td>Use the HDR color picker to select the color that the Camera uses to clear the screen before it renders a frame. The Camera uses this color if:You select <strong>Color</strong> from the <strong>Background Type</strong> drop-down. You select <strong>Sky</strong> from the <strong>Background Type</strong> drop-down and there is no valid sky for the Camera to use.</td>
</tr>
<tr>
<td><strong>Volume Layer Mask</strong></td>
<td>Use the drop-down to set the Layer Mask that defines which Volumes affect this Camera.</td>
</tr>
<tr>
<td><strong>Volume Anchor Override</strong></td>
<td>Assign a Transform that the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html">Volume</a> system uses to handle the position of this Camera. For example, if your application uses a third person view of a character, set this property to the character's Transform. The Camera then uses the post-processing and Scene settings for Volumes that the character enters. If you don't assign a Transform, the Camera uses its own Transform instead.</td>
</tr>
<tr>
<td><strong>Probe Layer Mask</strong></td>
<td>Use the drop-down to set the Layer Mask that the Camera uses to exclude environment lights (light from Planar Reflection Probes and Reflection Probes). The Camera only uses Reflection Probes on Layers that you include in this Layer Mask.</td>
</tr>
<tr>
<td><strong>Fullscreen Passthrough</strong></td>
<td>Enable the checkbox to make this Camera skip rendering settings and directly render in full screen. This is useful for video.</td>
</tr>
<tr>
<td><strong>Custom Frame Settings</strong></td>
<td>Enable the checkbox to override the default <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Frame-Settings.html">Frame Settings</a> for this Camera. This exposes a new set of Frame Settings that you can use to change how this Camera renders the Scene.</td>
</tr>
</tbody>
</table>

<span id="Output"></span>

## Output

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
<td><strong>Target Display</strong></td>
<td>Use the drop-down to select which device this Camera renders to.</td>
</tr>
<tr>
<td><strong>Target Texture</strong></td>
<td>Assign a RenderTexture that this Camera renders to. If you assign this property, the Camera no longer renders to the screen.</td>
</tr>
<tr>
<td><strong>Depth</strong></td>
<td>Set the Camera's position in the draw order. Unity processes Cameras with a smaller <strong>Depth</strong> first, then processes Cameras with a larger <strong>Depth</strong> on top.</td>
</tr>
<tr>
<td><strong>ViewPort Rect</strong></td>
<td>Set the position and size of this Camera's output on the screen.<br />
• <strong>X</strong>: The beginning horizontal position of the output.<br />
• <strong>Y</strong>: The beginning vertical position of the output.<br />
• <strong>W</strong>: The width of the output.<br />
• <strong>H</strong>: The height of the output.</td>
</tr>
</tbody>
</table>

## Preset

When using Preset of a HD Camera, only a subset of properties are supported. Unsupported properties are hidden.
