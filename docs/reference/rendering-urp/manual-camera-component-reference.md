---
title: "Camera Inspector window reference for URP"
page_title: "Unity - Manual: Camera Inspector window reference for URP"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/camera-component-reference.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/camera-component-reference.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Camera Inspector window reference for URP

In the Universal Render Pipeline (URP), Unity exposes different properties of the Camera component in the Inspector depending on the camera type. To change the type of the camera, select a [Render Type](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/camera-types-and-render-type.html).

Base cameras expose the following properties:

-   [Projection](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/camera-component-reference.html#Projection)
-   [Physical Camera](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/camera-component-reference.html#PhysicalCamera)
-   [Rendering](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/camera-component-reference.html#Rendering)
-   [Stack](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/camera-component-reference.html#Stack)
-   [Environment](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/camera-component-reference.html#Environment)
-   [Output](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/camera-component-reference.html#Output)

Overlay cameras expose the following properties:

-   [Projection](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/camera-component-reference.html#Projection)
-   [Physical Camera](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/camera-component-reference.html#PhysicalCamera)
-   [Rendering](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/camera-component-reference.html#Rendering)
-   [Environment](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/camera-component-reference.html#Environment)

<span id="Projection"></span>

## Projection

<table><thead><tr class="header"><th style="text-align: left;"><strong>Property</strong></th><th style="text-align: left;"><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Projection</strong></td><td style="text-align: left;">Control how the camera simulates perspective.</td></tr><tr class="even"><td style="text-align: left;">    <strong>Perspective</strong></td><td style="text-align: left;">Render objects with perspective intact.</td></tr><tr class="odd"><td style="text-align: left;">    <strong>Orthographic</strong></td><td style="text-align: left;">Render objects uniformly, with no sense of perspective.</td></tr><tr class="even"><td style="text-align: left;"><strong>Field of View Axis</strong></td><td style="text-align: left;">Set the axis Unity measures the camera’s field of view along.<br />
<br />
Available options:<ul><li><strong>Vertical</strong></li><li><strong>Horizontal</strong></li></ul>This property is only visible when <strong>Projection</strong> is set to <strong>Perspective</strong>.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Field of View</strong></td><td style="text-align: left;">Set the width of the camera’s view angle, measured in degrees along the selected axis.<br />
<br />
This property is only visible when <strong>Projection</strong> is set to <strong>Perspective</strong>.</td></tr><tr class="even"><td style="text-align: left;"><strong>Size</strong></td><td style="text-align: left;">Set the viewport size of the camera.<br />
<br />
This property is only visible when <strong>Projection</strong> is set to <strong>Orthographic</strong>.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Clipping Planes</strong></td><td style="text-align: left;">Set the distances from the camera where rendering starts and stops.</td></tr><tr class="even"><td style="text-align: left;">    <strong>Near</strong></td><td style="text-align: left;">The closest point relative to the camera where drawing occurs.</td></tr><tr class="odd"><td style="text-align: left;">    <strong>Far</strong></td><td style="text-align: left;">The furthest point relative to the camera where drawing occurs.</td></tr><tr class="even"><td style="text-align: left;"><strong>Physical Camera</strong></td><td style="text-align: left;">Displays additional properties for the camera in the Inspector to simulate a physical camera. A physical camera calculates the Field of View with properties simulating real-world camera attributes: <strong>Focal Length</strong>, <strong>Sensor Size</strong>, and <strong>Shift</strong>.<br />
<br />
The <strong>Physical Camera</strong> property is only available when <strong>Projection</strong> is set to <strong>Perspective</strong>.</td></tr></tbody></table>

<span id="PhysicalCamera"></span>

### Physical Camera

The **Physical Camera** property adds additional properties to the camera to simulate a real-world camera. For more information, refer to the [Physical Camera reference](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/cameras/physical-camera-reference.html).

<span id="Rendering"></span>

## Rendering

<table><thead><tr class="header"><th style="text-align: left;"><strong>Property</strong></th><th style="text-align: left;"><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Renderer</strong></td><td style="text-align: left;">Select which renderer this camera uses.</td></tr><tr class="even"><td style="text-align: left;"><strong>Post Processing</strong></td><td style="text-align: left;">Enable post-processing effects.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Anti-Aliasing</strong></td><td style="text-align: left;">Select the method that this camera uses for post-process anti-aliasing. A camera can still use Multisample Anti-aliasing (MSAA), which is a hardware feature, at the same time as post-process anti-aliasing unless you use Temporal Anti-aliasing.<br />
<br />
The following Anti-aliasing options are available:<ul><li><strong>None</strong>: This camera can process MSAA but does not process any post-process anti-aliasing.</li><li><strong>Fast Approximate Anti-aliasing (FXAA)</strong>: Performs a full screen pass which smooths edges on a per-pixel level.</li><li><strong>Subpixel Morphological Anti-aliasing (SMAA)</strong>: Finds edge patterns in the image and blends the pixels on these edges according to those patterns.</li><li><strong>Temporal Anti-aliasing (TAA)</strong>: Uses previous frames accumulated into a color history buffer to smooth edges over the course of multiple frames.</li></ul>For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/urp/anti-aliasing.html">Anti-aliasing in the Universal Render Pipeline</a>.<br />
<br />
This property is only visible when <strong>Render Type</strong> is set to <strong>Base</strong>.</td></tr><tr class="even"><td style="text-align: left;">        <strong>Quality (SMAA)</strong></td><td style="text-align: left;">Select the quality of SMAA. The difference in resource intensity is fairly small between <strong>Low</strong> and <strong>High</strong>.<br />
<br />
Available options:<ul><li><strong>Low</strong></li><li><strong>Medium</strong></li><li><strong>High</strong></li></ul>This property only appears when you select <strong>Subpixel Morphological Anti-aliasing (SMAA)</strong> from the <strong>Anti-aliasing</strong> drop-down.</td></tr><tr class="odd"><td style="text-align: left;">        <strong>Quality (TAA)</strong></td><td style="text-align: left;">Select the quality of TAA.<br />
<br />
Available options:<ul><li><strong>Very Low</strong></li><li><strong>Low</strong></li><li><strong>Medium</strong></li><li><strong>High</strong></li><li><strong>Very High</strong></li></ul>This property only appears when you select <strong>Temporal Anti-aliasing (TAA)</strong> from the <strong>Anti-aliasing</strong> drop-down.</td></tr><tr class="even"><td style="text-align: left;">        <strong>Contrast Adaptive Sharpening</strong></td><td style="text-align: left;">Enable high quality post sharpening to reduce TAA blur.<br />
<br />
This setting is overridden when you enable either <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/urp/universalrp-asset.html#quality">AMD FidelityFX Super Resolution (FSR) or Scalable Temporal Post-Processing (STP)</a> upscaling in the URP asset as they both handle sharpening as part of the upscaling process.<br />
<br />
This property only appears when you select <strong>Temporal Anti-aliasing (TAA)</strong> from the <strong>Anti-aliasing</strong> drop-down.</td></tr><tr class="odd"><td style="text-align: left;">        <strong>Base Blend Factor</strong></td><td style="text-align: left;">Set how much the history buffer blends with the current frame result. Higher values mean more history contribution, which improves the anti-aliasing, but also increases the chance of ghosting.<br />
<br />
This property only appears when you select <strong>Temporal Anti-aliasing (TAA)</strong> from the <strong>Anti-aliasing</strong> drop-down and enable <strong>Advanced Properties</strong> in the Inspector.</td></tr><tr class="even"><td style="text-align: left;">        <strong>Jitter Scale</strong></td><td style="text-align: left;">Set the scale of the jitter applied when TAA is enabled. A lower value reduces visible flickering and jittering, but also reduces the effectiveness of the anti-aliasing.<br />
<br />
This property only appears when you select <strong>Temporal Anti-aliasing (TAA)</strong> from the <strong>Anti-aliasing</strong> drop-down and enable <strong>Advanced Properties</strong> in the Inspector.</td></tr><tr class="odd"><td style="text-align: left;">        <strong>Mip Bias</strong></td><td style="text-align: left;">Set how much texture mipmap selection is biased when rendering.<br />
<br />
A positive bias makes a texture appear more blurry, while a negative bias sharpens the texture. However, a lower value also has a negative impact on performance.<br />
<br />
<strong>Note</strong>: Requires mipmaps in textures.<br />
<br />
This property only appears when you select <strong>Temporal Anti-aliasing (TAA)</strong> from the <strong>Anti-aliasing</strong> drop-down and enable <strong>Advanced Properties</strong> in the Inspector.</td></tr><tr class="even"><td style="text-align: left;">        <strong>Variance Clamp Scale</strong></td><td style="text-align: left;">Set the size of the color volume Unity uses to find nearby pixels when the color history is incorrect or unavailable. The clamp limits how much a pixel’s color can vary from the color of the surrounding pixels.<br />
<br />
Lower values can reduce ghosting, but produce more flickering. Higher values reduce flickering, but are prone to blur and ghosting.<br />
<br />
This property only appears when you select <strong>Temporal Anti-aliasing (TAA)</strong> from the <strong>Anti-aliasing</strong> drop-down and enable <strong>Advanced Properties</strong> in the Inspector.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Stop NaNs</strong></td><td style="text-align: left;">Replaces Not a Number (NaN) values with a black pixel for the camera. This stops certain effects from breaking, but is a resource-intensive process which causes a negative performance impact. Only enable this feature if you experience NaN issues you can’t fix.<br />
<br />
The Stop NaNs pass executes at the start of the post-processing passes. You must enable <strong>Post Processing</strong> for the camera to use <strong>Stop NaNs</strong>.<br />
<br />
Only available when <strong>Render Type</strong> is set to <strong>Base</strong>.</td></tr><tr class="even"><td style="text-align: left;"><strong>Dithering</strong></td><td style="text-align: left;">Enable to apply 8-bit dithering to the final render to help reduce banding on wide gradients and low light areas.<br />
<br />
This property is only visible when <strong>Render Type</strong> is set to <strong>Base</strong>.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Clear Depth</strong></td><td style="text-align: left;">Enable to clear depth from previous camera on rendering.<br />
<br />
This property is only visible when <strong>Render Type</strong> is set to <strong>Overlay</strong>.</td></tr><tr class="even"><td style="text-align: left;"><strong>Render Shadows</strong></td><td style="text-align: left;">Enable shadow rendering.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Priority</strong></td><td style="text-align: left;">A camera with a higher priority is drawn on top of a camera with a lower priority. Priority has a range from –100 to 100.<br />
<br />
This property is only visible when <strong>Render Type</strong> is set to <strong>Base</strong>.</td></tr><tr class="even"><td style="text-align: left;"><strong>Opaque Texture</strong></td><td style="text-align: left;">Control whether the camera creates a CameraOpaqueTexture, which is a copy of the rendered view.<br />
<br />
Available options:<ul><li><strong>Off</strong>: Camera does not create a CameraOpaqueTexture.</li><li><strong>On</strong>: Camera creates a CameraOpaqueTexture.</li><li><strong>Use Pipeline Settings</strong>: The render pipeline asset determines the value of this setting.</li></ul>This property is only visible when <strong>Render Type</strong> is set to <strong>Base</strong>.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Depth Texture</strong></td><td style="text-align: left;">Control whether the camera creates <code>_CameraDepthTexture</code>, which is a copy of the rendered depth values.<br />
<br />
Available options:<ul><li><strong>Off</strong>: Camera does not create a CameraDepthTexture.</li><li><strong>On</strong>: Camera creates a CameraDepthTexture.</li><li><strong>Use Pipeline Settings</strong>: The render pipeline asset determines the value of this setting.</li></ul><strong>Note</strong>: <code>_CameraDepthTexture</code> is set between the <code>AfterRenderingSkybox</code> and <code>BeforeRenderingTransparents</code> events, or at the <code>BeforeRenderingOpaques</code> event if you use a depth prepass. For more information on the order of events in the rendering loop, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/urp/customize/custom-pass-injection-points.html">Injection points</a>.</td></tr><tr class="even"><td style="text-align: left;"><strong>Culling Mask</strong></td><td style="text-align: left;">Select which Layers the camera renders to.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Occlusion Culling</strong></td><td style="text-align: left;">Enable Occlusion Culling.</td></tr></tbody></table>

<span id="Stack"></span>

## Stack

**Note:** This section is only available if **Render Type** is set to **Base**

A camera stack allows to composite results of several cameras together. The camera stack consists of a Base camera and any number of additional Overlay cameras.

You can use the stack property add Overlay cameras to the stack and they will render in the order as defined in the stack. For more information on configuring and using camera stacks, refer to [Set up a camera stack](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/camera-stacking.html).

<span id="Environment"></span>

## Environment

<table><thead><tr class="header"><th style="text-align: left;"><strong>Property</strong></th><th style="text-align: left;"><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Background Type</strong></td><td style="text-align: left;">Control how to initialize the color buffer at the start of this camera’s render loop. For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/urp/cameras-advanced.html#clearing-the-color-and-depth-buffers">the documentation on clearing</a>.<br />
<br />
This property is only visible when <strong>Render Type</strong> is set to <strong>Base</strong>.</td></tr><tr class="even"><td style="text-align: left;">        <strong>Skybox</strong></td><td style="text-align: left;">Initializes the color buffer by clearing to a Skybox. Defaults to a background color if no Skybox is found.</td></tr><tr class="odd"><td style="text-align: left;">        <strong>Solid Color</strong></td><td style="text-align: left;">Initializes the color buffer by clearing to a given color.<br />
If you select this property, Unity shows the following extra property:<br />
<strong>Background</strong>: The camera clears its color buffer to this color before rendering.</td></tr><tr class="even"><td style="text-align: left;">        <strong>Uninitialized</strong></td><td style="text-align: left;">Does not initialize the color buffer. This means that the load action for that specific RenderTarget will be <code>DontCare</code> instead of <code>Load</code> or <code>Clear</code>. <code>DontCare</code> specifies that the previous contents of the RenderTarget don’t need to be preserved.<br />
<br />
Only use this option in order to optimize performance in situations where your camera or Camera Stack will draw to every pixel in the color buffer, otherwise the behaviour of pixels the camera doesn’t draw is undefined.<br />
<br />
<strong>Note</strong>: The results might look different between Editor and Player, as the Editor doesn’t run on Tile-Based Deferred Rendering (TBDR) GPUs (found in mobile devices). If you use this option on TBDR GPUs, it causes uninitialized tile memory and the content is undefined.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Volumes</strong></td><td style="text-align: left;">The settings in this section define how Volumes affect this camera.</td></tr><tr class="even"><td style="text-align: left;">        <strong>Update</strong> <strong>Mode</strong></td><td style="text-align: left;">Select how Unity updates Volumes.<br />
<br />
Available options:<ul><li><strong>Every Frame</strong>: Update Volumes with every frame Unity renders.</li><li><strong>Via Scripting</strong>: Only update volumes when triggered by a script.</li><li><strong>Use Pipeline Settings</strong>: Use the default setting for the Render Pipeline.</li></ul></td></tr><tr class="odd"><td style="text-align: left;">        <strong>Volume</strong> <strong>Mask</strong></td><td style="text-align: left;">Use the drop-down to set the Layer Mask that defines which Volumes affect this camera.</td></tr><tr class="even"><td style="text-align: left;">        <strong>Volume</strong> <strong>Trigger</strong></td><td style="text-align: left;">Assign a Transform that the <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/urp/Volumes.html">Volume</a> system uses to handle the position of this camera. For example, if your application uses a third person view of a character, set this property to the character’s Transform. The camera then uses the post-processing and scene settings for Volumes that the character enters. If you do not assign a Transform, the camera uses its own Transform instead.</td></tr></tbody></table>

<span id="Output"></span>

## Output

This section is only available if you set the **Render Type** to **Base**

**Note:** When a camera’s **Render Type** is set to **Base** and its **Render Target** is set to **Texture**, Unity does not show the following properties in the Inspector for the camera:

-   **Target Display**
-   **HDR rendering**
-   **MSAA**
-   **Allow Dynamic Resolution**

This is because the Render Texture determines these properties. You can change them in the Render Texture Asset.

<table><thead><tr class="header"><th style="text-align: left;"><strong>Property</strong></th><th style="text-align: left;"><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Output Texture</strong></td><td style="text-align: left;">Render this camera’s output to a RenderTexture if this field is assigned, otherwise render to the screen.</td></tr><tr class="even"><td style="text-align: left;"><strong>Target Display</strong></td><td style="text-align: left;">Select which external device to render to.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Target Eye</strong></td><td style="text-align: left;">Select the target eye for this camera.<br />
<br />
Available options:<ul><li><strong>Both</strong>: Allows XR rendering from the selected camera.</li><li><strong>None</strong>: Disables XR rendering for the selected camera.</li></ul></td></tr><tr class="even"><td style="text-align: left;"><strong>Viewport Rect</strong></td><td style="text-align: left;">Four values that indicate where on the screen this camera view is drawn. Measured in Viewport Coordinates (values 0–1).</td></tr><tr class="odd"><td style="text-align: left;">    <strong>X</strong></td><td style="text-align: left;">The beginning horizontal position Unity uses to draw the camera view.</td></tr><tr class="even"><td style="text-align: left;">    <strong>Y</strong></td><td style="text-align: left;">The beginning vertical position Unity uses to draw the camera view.</td></tr><tr class="odd"><td style="text-align: left;">    <strong>W</strong></td><td style="text-align: left;">Width of the camera output on the screen.</td></tr><tr class="even"><td style="text-align: left;">    <strong>H</strong></td><td style="text-align: left;">Height of the camera output on the screen.</td></tr><tr class="odd"><td style="text-align: left;"><strong>HDR Rendering</strong></td><td style="text-align: left;">Enable High Dynamic Range rendering for this camera.</td></tr><tr class="even"><td style="text-align: left;"><strong>MSAA</strong></td><td style="text-align: left;">Enable <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/urp/anti-aliasing.html#msaa">Multisample Anti-aliasing</a> for this camera.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Allow Dynamic Resolution</strong></td><td style="text-align: left;">Enable Dynamic Resolution rendering for this camera.</td></tr></tbody></table>
