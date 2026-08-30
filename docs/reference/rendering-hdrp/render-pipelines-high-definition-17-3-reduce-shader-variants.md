---
title: "Reduce shader variants (HDRP)"
page_title: "Reduce shader variants | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/reduce-shader-variants.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/reduce-shader-variants.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Reduce shader variants

The standard shaders in the High Definition Render Pipeline (HDRP) support a lot of different features, which can mean Unity compiles a lot of shader variants. To avoid your build growing too big, HDRP automatically excludes ('strips') shader variants for features you don't use in your build.

You can change settings to make Unity strip more variants. This speeds up builds, and reduces memory usage and file sizes.

If you want to examine the code that strips shaders in HDRP, see the following files:

- `Editor/Material/Lit/LitShaderPreprocessor.cs`
- `Editor/Material/BaseShaderPreprocessor.cs`
- `Editor/BuildProcessors/HDRPPreprocessShaders.cs`

The files use the [IPreprocessShaders](https://docs.unity3d.com/ScriptReference/Build.IPreprocessShaders.html) API.

## Check how many shader variants your build has

To log how many variants Unity compiles and strips in total, follow these steps:

1.  Open the [Graphics settings window](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Default-Settings-Window.html).
2.  In the **Additional Shader Stripping Settings** section, select a logging level other than **Disabled**.
3.  Build your project.
4.  To see the logged information, open the `Editor.log` log file and search for `ShaderStrippingReport`. For the location of `Editor.log`, refer to <a href="https://docs.unity3d.com/6000.0/Documentation/Manual/LogFiles.html" class="xref">log files</a>.

To log more detailed shader variant information, follow these steps:

1.  Open the [Graphics settings window](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Default-Settings-Window.html).
2.  In the **Additional Shader Stripping Settings** section, select **Export Shader Variants**.
3.  Build your project.
4.  In the folder with your project files, open `Temp/graphics-settings-stripping.json` and `Temp/shader-stripping.json`.

For more information, refer to the following in the Unity User Manual:

- <a href="https://docs.unity3d.com/6000.0/Documentation/Manual/shader-how-many-variants.html" class="xref">Check how many shader variants you have</a>
- <a href="https://docs.unity3d.com/6000.0/Documentation/Manual/shader-variant-stripping.html" class="xref">Shader variant stripping</a>

## Strip feature shader variants

If you disable a feature, HDRP strips any shader variants where the feature is enabled.

You must disable the feature in all the HDRP assets in your build. Unity includes in your build any HDRP asset you set as a **Render Pipeline Asset** in a [Quality Settings level](https://docs.unity3d.com/Manual/class-QualitySettings.html).

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr>
<th style="text-align: left;"><strong>Feature</strong></th>
<th style="text-align: left;"><strong>How to disable the feature</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align: left;">Built-in fog</td>
<td style="text-align: left;">In the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Default-Settings-Window.html">Graphics settings window</a>, in the <strong>Shader Stripping</strong> section, set <strong>Fog Modes</strong> to <strong>Custom</strong>, then disable <strong>Linear</strong>, <strong>Exponential</strong>, <strong>Exponential Squared</strong>. This strips built-in fog shaders that HDRP doesn't use.</td>
</tr>
<tr>
<td style="text-align: left;">Cameras generate additional <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/AOVs.html">Arbitrary Output Variables (AOV)</a> images</td>
<td style="text-align: left;">In the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html">HDRP asset</a>, in the <strong>Rendering</strong> section, disable <strong>Runtime AOV API</strong>.</td>
</tr>
<tr>
<td style="text-align: left;">Cameras use both Deferred and Forward rendering</td>
<td style="text-align: left;">In the HDRP asset, in the <strong>Rendering</strong> section, set <strong>Lit Shader Mode</strong> to <strong>Deferred</strong>. This creates fewer variants than <strong>Forward</strong> or <strong>Both</strong>.</td>
</tr>
<tr>
<td style="text-align: left;">Decals</td>
<td style="text-align: left;">In the HDRP asset, disable <strong>Decals</strong>.</td>
</tr>
<tr>
<td style="text-align: left;">Distortion</td>
<td style="text-align: left;">In the HDRP asset, in the <strong>Material</strong> section, disable <strong>Distortion</strong>.</td>
</tr>
<tr>
<td style="text-align: left;">GPU instancing variants you don't use</td>
<td style="text-align: left;">In the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Default-Settings-Window.html">Graphics settings window</a>, in the <strong>Shader Stripping</strong> section, set <strong>Instancing Variants</strong> to <strong>Strip Unused</strong>.</td>
</tr>
<tr>
<td style="text-align: left;">Holes in Terrain</td>
<td style="text-align: left;">In the HDRP asset, in the <strong>Rendering</strong> section, disable <strong>Terrain Holes</strong>.</td>
</tr>
<tr>
<td style="text-align: left;">Lightmaps HDRP doesn't use</td>
<td style="text-align: left;">In the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Default-Settings-Window.html">Graphics settings window</a>, in the <strong>Shader Stripping</strong> section, set <strong>Lightmap Modes</strong> to <strong>Custom</strong>, and enable only the <strong>Baked Directional</strong> mode. This strips lightmap shader variants that HDRP doesn't use.</td>
</tr>
<tr>
<td style="text-align: left;">Material Quality in Shader Graph shaders</td>
<td style="text-align: left;">In the HDRP asset, in the <strong>Material</strong> section, disable any <strong>Available Material Quality</strong> levels you don't need. This only has an effect if you use the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@15.0/manual/Scalability-Manual.html">Material Quality Node</a> in Shader Graph.</td>
</tr>
<tr>
<td style="text-align: left;">Motion vectors</td>
<td style="text-align: left;">In the HDRP asset, in the <strong>Rendering</strong> section, disable <strong>Motion Vectors</strong>. You shouldn't disable this unless your Scenes are fully static with no deformation.</td>
</tr>
<tr>
<td style="text-align: left;">Realtime raytracing</td>
<td style="text-align: left;">You can do one of the following in the HDRP asset, in the <strong>Rendering</strong> section:
<ul>
<li>Disable <strong>Realtime Raytracing</strong>.</li>
<li>Enable <strong>Realtime Raytracing</strong>, but set <strong>Supported Ray Tracing Mode</strong> to <strong>Performance</strong>.</li>
</ul>
Performance mode doesn't support path tracing.</td>
</tr>
<tr>
<td style="text-align: left;">Rendering Layers</td>
<td style="text-align: left;">In the HDRP asset, in the <strong>Lighting</strong> section, disable <strong>Light Layers</strong>. This only has an effect if you also set <strong>Lit Shader Mode</strong> to <strong>Deferred</strong>.</td>
</tr>
<tr>
<td style="text-align: left;">Subsurface scattering</td>
<td style="text-align: left;">In the HDRP asset, in the <strong>Material</strong> section, disable <strong>Subsurface Scattering</strong>. This only removes a small number of variants, so you should only disable this if you need to.</td>
</tr>
<tr>
<td style="text-align: left;">Transitions between GameObject level of detail (LOD) levels</td>
<td style="text-align: left;">In the HDRP asset, in the <strong>Rendering</strong> section, disable <strong>Dithering Cross-fade</strong>.</td>
</tr>
<tr>
<td style="text-align: left;">Transparent back-face render passes</td>
<td style="text-align: left;">In the HDRP asset, in the <strong>Rendering</strong> section, disable <strong>Transparent Backface</strong>. Unity might incorrectly render transparent objects.</td>
</tr>
<tr>
<td style="text-align: left;">Transparent depth render postpasses</td>
<td style="text-align: left;">In the HDRP asset, in the <strong>Rendering</strong> section, disable <strong>Transparent Depth Postpass</strong>. Unity might incorrectly render transparent objects.</td>
</tr>
<tr>
<td style="text-align: left;">Transparent depth render prepasses</td>
<td style="text-align: left;">In the HDRP asset, in the <strong>Rendering</strong> section, disable <strong>Transparent Depth Prepass</strong>. Unity might incorrectly render transparent objects and screen space reflections.</td>
</tr>
</tbody>
</table>

## Strip XR and VR shader variants

If you don't use XR or VR, you can [disable the XR and VR modules](https://docs.unity3d.com/Documentation/Manual/upm-ui.html). This allows HDRP to strip XR and VR related shader variants from its standard shaders.

## Strip debug shader variants

If you don't need to use the [Rendering Debugger](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/use-the-rendering-debugger.html) in a development build, you can disable **Runtime Debug Shaders** under **Miscellaneous** in the [Graphics settings window](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Default-Settings-Window.html). This strips any debug shader variants that the Rendering Debugger uses.

You don't need to do this if you disable **Development Build** in your [Build Settings](https://docs.unity3d.com/Manual/BuildSettings.html).

## Features that affect build time but not variants

If you disable the following features, Unity doesn't reduce the number of variants but your build time will be faster.

| **Feature** | **How to disable the feature** |
|:---|:---|
| Decal layers | In the HDRP asset, in the **Decals** section, disable **Layers**. |
| High-quality area shadows | In the HDRP asset, in the **Lighting** section, set **Area Shadow Filtering Quality** to **Low**. |
| High-quality shadows | In the HDRP asset, in the **Lighting** section, set **Shadow Filtering Quality** to **Low**. |
| Light Probe system | In the HDRP asset, in the **Lighting** section, set **Light Probe System** to **Light Probe Groups (Legacy)**. |
| Shadowmasks | In the HDRP asset, in the **Lighting** section, disable **Shadowmask**. |
