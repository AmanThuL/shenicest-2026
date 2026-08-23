---
title: "Graphics settings window reference for URP"
page_title: "Unity - Manual: Graphics settings window reference for URP"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/urp-global-settings.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/urp-global-settings.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Graphics settings window reference for URP

If a project has the Universal Render Pipeline (URP) package installed, Unity shows URP-specific graphics settings in **Project Settings** \> **Graphics** \> **Pipeline Specific Settings** \> **URP**.

The section contains the following settings that let you define project-wide settings for URP.

You can also add your own settings. Refer to [Add custom settings](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@17.0/manual/add-custom-graphics-settings) in the Scriptable Render Pipeline (SRP) Core manual for more information.

## Default Volume Profile

Use this section to assign and edit a [Volume Profile](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/Volume-Profile.html) for the default volume that all scenes use. Refer to [Understand Volumes](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/Volumes.html) for more information.

| **Property**       | **Description**                                                                                                                                                                      |
|:-------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Volume Profile** | Set the [Volume Profile](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/Volume-Profile.html) the global default volume uses. You can’t set **Volume Profile** to **None**. |

URP displays all the properties for all the possible [Volume Overrides](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/VolumeOverrides.html). To edit or override the properties, use [the global volume for a quality level](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/set-up-a-volume.html#configure-the-global-volume-for-a-quality-level) or [create a volume](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/set-up-a-volume.html#add-a-volume).

## Adaptive Probe Volumes

| **Property**                              | **Description**                                                                                                                                                                                                                                                                                                                                       |
|:------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Probe Volume Disable Streaming Assets** | When enabled, URP uses [streaming assets](https://docs.unity3d.com/6000.0/Documentation/Manual/StreamingAssets.html) to optimize [Adaptive Probe Volumes](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/probevolumes.html). Disable this setting if you use Asset Bundles and Addressables, which aren’t compatible with streaming assets. |

## Lightmap Sampling Settings

| **Property**                      | **Description**                                                                                                                                                                             |
|:----------------------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Use Bicubic Lightmap Sampling** | Improves the visual fidelity of lightmaps by smoothening sharp or jagged edges, especially at the edges of shadows. Enabling this property might reduce performance on lower-end platforms. |

## Additional Shader Stripping Settings

The check boxes in this section define which shader variants Unity strips when you build the Player.

<table><thead><tr class="header"><th style="text-align: left;"><strong>Property</strong></th><th style="text-align: left;"><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Export Shader Variants</strong></td><td style="text-align: left;">Output two log files with shader compilation information when you build your project. For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/urp/shader-stripping-landing.html">Reducing shader variants in URP</a>.</td></tr><tr class="even"><td style="text-align: left;"><strong>Shader Variant Log Level</strong></td><td style="text-align: left;">Select what information about Shader variants Unity saves in logs when you build your Unity Project.<br />
Options:<br />
• Disabled: Unity doesn’t save any shader variant information.<br />
• Only SRP Shaders: Unity saves only shader variant information for URP shaders.<br />
• All Shaders: Unity saves shader variant information for every shader type.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Strip Debug Variants</strong></td><td style="text-align: left;">When enabled, Unity strips all debug view shader variants when you build the Player. This decreases build time, but prevents the use of Rendering Debugger in Player builds.</td></tr><tr class="even"><td style="text-align: left;"><strong>Strip Unused Post Processing Variants</strong></td><td style="text-align: left;">When enabled, Unity assumes that the Player does not create new <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/urp/Volume-Profile.html">Volume Profiles</a> at runtime. With this assumption, Unity only keeps the shader variants that the existing <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/urp/Volume-Profile.html">Volume Profiles</a> use, and strips all the other variants. Unity keeps shader variants used in Volume Profiles even if the scenes in the project do not use the Profiles.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Strip Unused Variants</strong></td><td style="text-align: left;">When enabled, Unity performs shader stripping in a more efficient way. This option reduces the amount of shader variants in the Player by a factor of 2 if the project uses the following URP features:<ul><li>Rendering Layers</li><li>Native Render Pass</li><li>Reflection Probe Blending</li><li>Reflection Probe Box Projection</li><li>SSAO Renderer Feature</li><li>Decal Renderer Feature</li><li>Certain post-processing effects</li></ul>Disable this option only if you notice issues in the Player.</td></tr><tr class="even"><td style="text-align: left;"><strong>Strip Screen Coord Override Variants</strong></td><td style="text-align: left;">When enabled, Unity strips Screen Coordinates Override shader variants in Player builds.</td></tr></tbody></table>

## Render Graph

Use this section to enable, disable or configure the render graph system. Refer to [Render graph system](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph.html) for more information.

| **Property**                   | **Description**                                                                                                                                                       |
|:-------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Enable Compilation Caching** | When enabled, URP uses the compiled render graph from the previous frame when it can, instead of compiling the render graph again. This speeds up rendering.          |
| **Enable Validity Checks**     | When enabled, URP validates aspects of a render graph in the Editor and in a development build. **Enable Validity Checks** is disabled automatically in final builds. |

## VRS - Runtime Resources

Use this section to configure Variable Rate Shading (VRS).

| **Property**                   | **Description**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|:-------------------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Texture Compute Shader**     | Sets the compute shader that the [`ColorMaskTextureToShadingRateImage`](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@17.4/api/UnityEngine.Rendering.Vrs.html#UnityEngine_Rendering_Vrs_ColorMaskTextureToShadingRateImage_UnityEngine_Rendering_RenderGraphModule_RenderGraph_UnityEngine_Rendering_RTHandle_UnityEngine_Rendering_RTHandle_System_Boolean_) API uses to convert colors to shading rate values during Variable Rate Shading. The default is the built-in `VrsTexture` compute shader.                                                       |
| **Visualization Shader**       | Sets the shader that the [`ShadingRateImageToColorMaskTexture`](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@17.4/api/UnityEngine.Rendering.Vrs.html#UnityEngine_Rendering_Vrs_ShadingRateImageToColorMaskTexture_UnityEngine_Rendering_RenderGraphModule_RenderGraph_UnityEngine_Rendering_RenderGraphModule_TextureHandle__UnityEngine_Rendering_RenderGraphModule_TextureHandle__) API uses to convert shading rate values to colors in visualizations, such as in the Rendering Debugger window. The default is the built-in `VrsVisualization` shader. |
| **Visualization Lookup Table** | Sets the color mapping the **Visualization Shader** uses to convert shading rate values into colors for display.                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| **Conversion Lookup Table**    | Sets the lookup table the **Texture Compute Shader** uses to map input colors to their corresponding shading rate values.                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
