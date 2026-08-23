---
title: "Universal Renderer asset reference for URP"
page_title: "Unity - Manual: Universal Renderer asset reference for URP"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/urp-universal-renderer.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/urp-universal-renderer.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Universal Renderer asset reference for URP

This page describes the URP Universal Renderer settings.

For more information on rendering in URP, also check [Rendering in the Universal Render Pipeline](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering-in-universalrp.html).

## How to find the Universal Renderer asset

To find the Universal Renderer asset that a URP asset is using:

1.  Select a URP asset.

2.  In the Renderer List section, click a renderer item or the vertical ellipsis icon (⋮) next to a renderer.

    ![How to find the Universal Renderer asset](https://docs.unity3d.com/6000.3/Documentation/uploads/urp/urp-assets/find-renderer.png)

## Properties

### Filtering

This section contains properties that define which layers the renderer draws.

| Property                   | Description                                                                          |
|:---------------------------|:-------------------------------------------------------------------------------------|
| **Prepass Layer Mask**     | The layers that GameObjects must be assigned to in order to affect any prepass.      |
| **Opaque Layer Mask**      | The layers that opaque GameObjects must be assigned to in order to be rendered.      |
| **Transparent Layer Mask** | The layers that transparent GameObjects must be assigned to in order to be rendered. |

<span id="rendering"></span>

### Rendering

This section contains properties related to rendering.

<table><thead><tr class="header"><th style="text-align: left;">Property</th><th style="text-align: left;">Description</th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Rendering Path</strong></td><td style="text-align: left;">Select the Rendering Path.<br />
Options:<ul><li><strong>Forward</strong>: The Forward Rendering Path.</li><li><strong>Forward+</strong>: The <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering/forward-rendering-paths.html">Forward+ Rendering Path</a>.</li><li><strong>Deferred</strong>: The <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering/deferred-rendering-path-landing.html">Deferred Rendering Path</a>.</li><li><strong>Deferred+</strong>: The <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering/deferred-rendering-path-landing.html">Deferred+ Rendering Path</a></li></ul></td></tr><tr class="even"><td style="text-align: left;"><strong>Depth Priming Mode</strong></td><td style="text-align: left;">Skips drawing overlapping pixels, to speed up rendering. Unity uses the depth texture to check which pixels overlap. The rendering improvement depends on the number of overlapping pixels and the complexity of the pixel shaders.<br />
<br />
<strong>Note</strong>: If you use custom shaders, Unity renders opaque objects as invisible unless you add passes with <code>DepthOnly</code> and <code>DepthNormals</code> tags. For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/urp/writing-shaders-urp-depth-only.html">Write depth only in a shader</a>.<br />
<br />
The options are:<ul><li><strong>Disabled</strong>: Doesn’t perform depth priming.</li><li><strong>Auto</strong>: Performs depth priming only if a depth prepass already exists in the render pipeline. This setting isn’t supported on Android, iOS and Apple TV platforms.</li><li><strong>Forced</strong>: Adds a depth prepass to the render pipeline if it doesn’t already exist, and performs depth priming. Adding the depth prepass has an impact on memory and performance.</li></ul><strong>Note</strong>: Depth priming isn’t supported if you use a <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering/deferred-rendering-path-landing.html">deferred rendering path</a> or <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/urp/anti-aliasing.html#multisample-anti-aliasing-msaa">Multisample Anti-aliasing</a>, or at runtime on mobile devices that use tile-based deferred rendering (TBDR).</td></tr><tr class="odd"><td style="text-align: left;"><strong>Accurate G-buffer normals</strong></td><td style="text-align: left;">Indicates whether to use a more resource-intensive normal encoding/decoding method to improve visual quality.<br />
<br />
This property is available only if <strong>Rendering Path</strong> is set to <strong>Deferred</strong>.</td></tr><tr class="even"><td style="text-align: left;"><strong>Depth Texture Mode</strong></td><td style="text-align: left;">Specifies the stage in the render pipeline at which to copy the scene depth to a depth texture. The options are:<ul><li><strong>After Opaques</strong>: URP copies the scene depth after the opaques render pass.</li><li><strong>After Transparents</strong>: URP copies the scene depth after the transparents render pass.</li><li><strong>Force Prepass</strong>: URP does a depth prepass to generate the scene depth texture.</li></ul><strong>Note</strong>: On mobile devices, the <strong>After Transparents</strong> option can lead to a significant improvement in memory bandwidth. This is because the Copy Depth pass causes a switch in render target between the Opaque pass and the Transparents pass. When this occurs, Unity stores the contents of the Color Buffer in the main memory, and then loads it again once the Copy Depth pass is complete. The impact increases significantly when MSAA is enabled as Unity must also store and load the MSAA data alongside the Color Buffer.</td></tr></tbody></table>

### Native RenderPass

This section contains properties related to URP’s Native RenderPass API.

<table><thead><tr class="header"><th style="text-align: left;">Property</th><th style="text-align: left;">Description</th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Native RenderPass</strong></td><td style="text-align: left;">Indicates whether to use URP’s Native RenderPass API. When enabled, URP uses this API to structure render passes. As a result, you can use <a href="https://docs.unity3d.com/Manual/SL-PlatformDifferences.html#using-shader-framebuffer-fetch">programmable blending</a> in custom URP shaders. For more information about the RenderPass API, refer to <a href="https://docs.unity3d.com/ScriptReference/Rendering.ScriptableRenderContext.BeginRenderPass.html">ScriptableRenderContext.BeginRenderPass</a>.<br />
<br />
<strong>Note</strong>: Enabling this property has no effect on OpenGL ES.</td></tr></tbody></table>

### Shadows

This section contains properties related to rendering shadows.

| Property                        | Description                                                         |
|:--------------------------------|:--------------------------------------------------------------------|
| **Transparent Receive Shadows** | When this option is on, Unity draws shadows on transparent objects. |

### Post-processing

| **Property** | **Description**                                                                                                                                   |
|:-------------|:--------------------------------------------------------------------------------------------------------------------------------------------------|
| **Enabled**  | Enables post-processing effects in your scene. If disabled, Unity excludes post-processing renderer passes, shaders, and textures from the build. |
| **Data**     | Selects the asset that the renderer uses for post-processing. This property is available only when **Enabled** is enabled.                        |

### Overrides

This section contains Render Pipeline properties that this Renderer overrides.

#### Stencil

With this check box selected, the Renderer processes the Stencil buffer values.

![URP Universal Renderer Stencil override](https://docs.unity3d.com/6000.3/Documentation/uploads/urp/urp-assets/urp-universal-renderer-stencil-on.png)

For more information on how Unity works with the Stencil buffer, refer to [ShaderLab: Stencil](https://docs.unity3d.com/Manual/SL-Stencil.html).

In URP, you can use bits 0 to 3 of the stencil buffer for custom rendering effects. This means you can use stencil indices 0 to 15.

### Compatibility

This section contains settings related to backwards compatibility.

<table><thead><tr class="header"><th style="text-align: left;">Property</th><th style="text-align: left;">Description</th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Intermediate Texture</strong></td><td style="text-align: left;">This property lets you force URP to renders via an intermediate texture.<br />
Options:<ul><li><strong>Auto</strong>: URP uses the information provided by the <code>ScriptableRenderPass.ConfigureInput</code> method to determine automatically whether rendering via an intermediate texture is necessary.</li><li><strong>Always</strong>: forces rendering via an intermediate texture. Use this option only for compatibility with Renderer Features that do not declare their inputs with <code>ScriptableRenderPass.ConfigureInput</code>. Using this option might have a significant performance impact on some platforms.</li></ul></td></tr></tbody></table>

### Renderer Features

This section contains the list of Renderer Features assigned to the selected Renderer.

For information on how to add a Renderer Feature, check [How to add a Renderer Feature to a Renderer](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/urp-renderer-feature.html).

URP contains the pre-built Renderer Feature called [Render Objects](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/renderer-features/renderer-feature-render-objects.html).
