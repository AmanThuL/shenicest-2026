---
title: "ShaderLab Pass tags in URP reference"
page_title: "Unity - Manual: ShaderLab Pass tags in URP reference"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/urp-shaders/urp-shaderlab-pass-tags.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/urp-shaders/urp-shaderlab-pass-tags.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# ShaderLab Pass tags in URP reference

This section contains descriptions of URP-specific ShaderLab Pass tags.

> **Note**: URP does not support the following LightMode tags: `Always`, `ForwardAdd`, `PrepassBase`, `PrepassFinal`, `Vertex`, `VertexLMRGBM`, `VertexLM`.

## <span id="lightmode"></span>LightMode

The value of this tag lets the pipeline determine which Pass to use when executing different parts of the Render Pipeline.

If you do not set the `LightMode` tag in a Pass, URP uses the `SRPDefaultUnlit` tag value for that Pass.

The `LightMode` tag can have the following values.

<table><thead><tr class="header"><th style="text-align: left;"><strong>Property</strong></th><th style="text-align: left;"><strong>Description</strong></th><th style="text-align: left;"><a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.PassType.html"><strong>PassType</strong></a></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>UniversalForward</strong></td><td style="text-align: left;">The Pass renders object geometry and evaluates all light contributions. URP uses this tag value in the Forward Rendering Path.</td><td style="text-align: left;"><code>ScriptableRenderPipeline</code></td></tr><tr class="even"><td style="text-align: left;"><strong>UniversalGBuffer</strong></td><td style="text-align: left;">The Pass renders object geometry without evaluating any light contribution. Use this tag value in Passes that Unity must execute in the Deferred Rendering Path.</td><td style="text-align: left;"><code>ScriptableRenderPipeline</code></td></tr><tr class="odd"><td style="text-align: left;"><strong>UniversalForwardOnly</strong></td><td style="text-align: left;">The Pass renders object geometry and evaluates all light contributions, similarly to when <strong>LightMode</strong> has the <strong>UniversalForward</strong> value. The difference from <strong>UniversalForward</strong> is that URP can use the Pass for both the Forward and the Deferred Rendering Paths.<br />
Use this value if a certain Pass must render objects with the Forward Rendering Path when URP is using the Deferred Rendering Path. For example, use this tag if URP renders a scene using the Deferred Rendering Path and the scene contains objects with shader data that does not fit the GBuffer, such as Clear Coat normals.<br />
If a shader must render in both the Forward and the Deferred Rendering Paths, declare two Passes with the <code>UniversalForward</code> and <code>UniversalGBuffer</code> tag values.<br />
If a shader must render using the Forward Rendering Path regardless of the Rendering Path that the URP Renderer uses, declare only a Pass with the <code>LightMode</code> tag set to <code>UniversalForwardOnly</code>.<br />
If you use the SSAO Renderer Feature, add a Pass with the <code>LightMode</code> tag set to <code>DepthNormalsOnly</code>. For more information, check the <code>DepthNormalsOnly</code> value.</td><td style="text-align: left;"><code>ScriptableRenderPipeline</code></td></tr><tr class="even"><td style="text-align: left;"><strong>DepthNormalsOnly</strong></td><td style="text-align: left;">Use this value in combination with <code>UniversalForwardOnly</code> in the Deferred Rendering Path. This value lets Unity render the shader in the Depth and normal prepass. In the Deferred Rendering Path, if the Pass with the <code>DepthNormalsOnly</code> tag value is missing, Unity does not generate the ambient occlusion around the Mesh.</td><td style="text-align: left;"><code>ScriptableRenderPipeline</code></td></tr><tr class="odd"><td style="text-align: left;"><strong>Universal2D</strong></td><td style="text-align: left;">The Pass renders objects and evaluates 2D light contributions. URP uses this tag value in the 2D Renderer.</td><td style="text-align: left;"><code>ScriptableRenderPipeline</code></td></tr><tr class="even"><td style="text-align: left;"><strong>ShadowCaster</strong></td><td style="text-align: left;">The Pass renders object depth from the perspective of lights into the Shadow map or a depth texture.</td><td style="text-align: left;"><code>ShadowCaster</code></td></tr><tr class="odd"><td style="text-align: left;"><strong>DepthOnly</strong></td><td style="text-align: left;">The Pass renders only depth information from the perspective of a Camera into a depth texture.</td><td style="text-align: left;"><code>ScriptableRenderPipeline</code></td></tr><tr class="even"><td style="text-align: left;"><strong>Meta</strong></td><td style="text-align: left;">Unity executes this Pass only when baking lightmaps in the Unity Editor. Unity strips this Pass from shaders when building a Player.</td><td style="text-align: left;"><code>Meta</code></td></tr><tr class="odd"><td style="text-align: left;"><strong>SRPDefaultUnlit</strong></td><td style="text-align: left;">Use this <code>LightMode</code> tag value to draw an extra Pass when rendering objects. Application example: draw an object outline. This tag value is valid for both the Forward and the Deferred Rendering Paths.<br />
URP uses this tag value as the default value when a Pass does not have a <code>LightMode</code> tag.</td><td style="text-align: left;"><code>ScriptableRenderPipelineDefaultUnlit</code></td></tr><tr class="even"><td style="text-align: left;"><strong>MotionVectors</strong></td><td style="text-align: left;">Use this tag to add motion vector support to your shader. For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/urp/features/motion-vectors-custom-shader.html">Motion vector pass for ShaderLab</a>.</td><td style="text-align: left;"><code>MotionVectors</code></td></tr></tbody></table>

## <span id="universalmaterialtype"></span>UniversalMaterialType

Unity uses this tag in the Deferred Rendering Path.

The `UniversalMaterialType` tag can have the following values.

If this tag is not set in a Pass, Unity uses the `Lit` value.

<table><thead><tr class="header"><th style="text-align: left;"><strong>Property</strong></th><th style="text-align: left;"><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Lit</strong></td><td style="text-align: left;">This value indicates that the shader type is Lit. During the G-buffer Pass, Unity uses stencil to mark the pixels that use the Lit shader type (specular model is PBR).<br />
Unity uses this value by default, if the tag is not set in a Pass.</td></tr><tr class="even"><td style="text-align: left;"><strong>SimpleLit</strong></td><td style="text-align: left;">This value indicates that the shader type is SimpleLit. During the G-buffer Pass, Unity uses stencil to mark the pixels that use the SimpleLit shader type (specular model is Blinn-Phong).</td></tr></tbody></table>
