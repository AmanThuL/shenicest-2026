---
title: "Render pipeline feature comparison"
page_title: "Unity - Manual: Render pipeline feature comparison"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/render-pipelines-feature-comparison.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/render-pipelines-feature-comparison.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Render pipeline feature comparison

This page contains information on feature support in the Built-in Render Pipeline, the Universal Render Pipeline (URP), and the High Definition Render Pipeline (HDRP). It also contains suggested alternatives for certain features.

For ease of reference, features are broken down into the following categories:

-   [Platform Support](https://docs.unity3d.com/6000.3/Documentation/Manual/render-pipelines-feature-comparison.html#platform-support)
-   [Lighting](https://docs.unity3d.com/6000.3/Documentation/Manual/render-pipelines-feature-comparison.html#lighting)
-   [Color](https://docs.unity3d.com/6000.3/Documentation/Manual/render-pipelines-feature-comparison.html#color)
-   [Camera](https://docs.unity3d.com/6000.3/Documentation/Manual/render-pipelines-feature-comparison.html#camera)
-   [Shaders](https://docs.unity3d.com/6000.3/Documentation/Manual/render-pipelines-feature-comparison.html#shaders)
-   [World building](https://docs.unity3d.com/6000.3/Documentation/Manual/render-pipelines-feature-comparison.html#world-building)
-   [Visual effects](https://docs.unity3d.com/6000.3/Documentation/Manual/render-pipelines-feature-comparison.html#visual-effects)
-   [2D and UI](https://docs.unity3d.com/6000.3/Documentation/Manual/render-pipelines-feature-comparison.html#2d-and-ui)
-   [XR](https://docs.unity3d.com/6000.3/Documentation/Manual/render-pipelines-feature-comparison.html#xr)
-   [Scripting](https://docs.unity3d.com/6000.3/Documentation/Manual/render-pipelines-feature-comparison.html#scripting)
-   [Optimizations](https://docs.unity3d.com/6000.3/Documentation/Manual/render-pipelines-feature-comparison.html#optimizations)
-   [Debug](https://docs.unity3d.com/6000.3/Documentation/Manual/render-pipelines-feature-comparison.html#debug)

<span id="platform-support"></span>

## Platform Support

<table><thead><tr class="header"><th style="text-align: left;"><strong>Feature</strong></th><th style="text-align: left;"><strong>Built-in Render Pipeline</strong></th><th style="text-align: left;"><strong>URP</strong></th><th style="text-align: left;"><strong>HDRP</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Windows</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes<br />
<br />
DirectX 11, DirectX 12, Vulkan</td><td style="text-align: left;">Yes<br />
<br />
DirectX 11, DirectX 12, Vulkan</td></tr><tr class="even"><td style="text-align: left;"><strong>MacOS</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Linux</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes<br />
<br />
Vulkan</td></tr><tr class="even"><td style="text-align: left;"><strong>XBox One</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>XBox Series</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>PlayStation 4</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>PlayStation 5</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Nintendo Switch</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">No</td></tr><tr class="odd"><td style="text-align: left;"><strong>iOS</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">No</td></tr><tr class="even"><td style="text-align: left;"><strong>Android</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">No</td></tr><tr class="odd"><td style="text-align: left;"><strong>Desktop VR</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Mobile VR</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">No</td></tr><tr class="odd"><td style="text-align: left;"><strong>Hololens</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">No</td></tr><tr class="even"><td style="text-align: left;"><strong>WebGL</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">No</td></tr><tr class="odd"><td style="text-align: left;"><strong>WebGPU</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Experimental</td><td style="text-align: left;">No</td></tr></tbody></table>

<span id="lighting"></span>

## Lighting

### Lights

<table><thead><tr class="header"><th style="text-align: left;"><strong>Feature</strong></th><th style="text-align: left;"><strong>Built-in Render Pipeline</strong></th><th style="text-align: left;"><strong>URP</strong></th><th style="text-align: left;"><strong>HDRP</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Directional</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Spot</strong></td><td style="text-align: left;">Yes<br />
<br />
Supported shapes: Cone</td><td style="text-align: left;">Yes<br />
<br />
Supported shapes: Cone</td><td style="text-align: left;">Yes<br />
<br />
Supported shapes: Cone, Pyramid, Box</td></tr><tr class="odd"><td style="text-align: left;"><strong>Point</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Area</strong></td><td style="text-align: left;">Yes<br />
<br />
Supported shapes: Rectangle (only with Enlighten Realtime Global Illumination), Disc (baked only)</td><td style="text-align: left;">Yes<br />
<br />
Supported shapes: Rectangle (baked only), Disc (baked only)</td><td style="text-align: left;">Yes<br />
<br />
Supported shapes: Rectangle (real-time and baked), Tube (real-time only), Disc (baked only)</td></tr><tr class="odd"><td style="text-align: left;"><strong>Inner Spot angle</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Shading technique</strong></td><td style="text-align: left;">Yes<br />
<br />
Multiple passes</td><td style="text-align: left;">Yes<br />
<br />
Single pass only</td><td style="text-align: left;">Yes<br />
<br />
Hybrid tile and cluster</td></tr><tr class="odd"><td style="text-align: left;"><strong>Culling Per Object</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">No</td></tr><tr class="even"><td style="text-align: left;"><strong>Culling Per Tile</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Culling Per Layer</strong></td><td style="text-align: left;">Yes<br />
<br />
Based on GameObject layers</td><td style="text-align: left;">Yes<br />
<br />
Based on dedicated Rendering layers (32 layers available)</td><td style="text-align: left;">Yes<br />
<br />
Based on dedicated Rendering layers (only the first 16 are used)</td></tr><tr class="even"><td style="text-align: left;"><strong>Multiple directional lights</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes<br />
<br />
Supports shadowing for one directional light at a time.</td><td style="text-align: left;">Yes<br />
<br />
Supports shadowing for one directional light at a time. To simulate more, use Spot light with a Box shape.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Number of real-time lights per object</strong></td><td style="text-align: left;">Unlimited</td><td style="text-align: left;">Forward: 1 Directional light + up to 8 lights per-object depending on the settings in the render pipeline asset.<br />
Deferred and Deferred+: Unlimited lights for opaque objects. For transparents or objects that shade in forward mode the same limit as above applies.<br />
Forward+: Not Applicable. Forward+ shade lights per-tile, see “Number of real-time lights per Camera” below.<br />
<br />
For more information check: Render Path Comparison</td><td style="text-align: left;">Unlimited (HDRP doesn’t classify lights per object, see bellow the “Number of real-time lights per Camera” section).</td></tr><tr class="even"><td style="text-align: left;"><strong>Number of real-time lights per Camera</strong></td><td style="text-align: left;">Unlimited</td><td style="text-align: left;">On mobile platforms: 32.<br />
On other platforms: 256 (configurable to improve build time and performance adding the package Packages/com.unity.render-pipelines.universal-config, and changing the value of MAX_VISIBLE_LIGHT_COUNT_DESKTOP in Runtime/ShaderConfig.cs.hlsl and<br />
k_MaxVisibleLightCountDesktop in Runtime/ShaderConfig.cs).</td><td style="text-align: left;">In Deferred: 63 per 16x16 pixel tile.<br />
<br />
In Forward: 63 per 32x32 pixel cluster.<br />
<br />
You can disable the cap for the deferred rendering path in Frame Settings &gt; Light Loop Debug &gt; Deferred Tile. This will affect performance.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Light attenuation type</strong></td><td style="text-align: left;">Yes<br />
<br />
Legacy</td><td style="text-align: left;">Yes<br />
<br />
InverseSquared</td><td style="text-align: left;">Yes<br />
<br />
InverseSquared</td></tr><tr class="even"><td style="text-align: left;"><strong>Vertex Lights</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">No</td></tr><tr class="odd"><td style="text-align: left;"><strong>SH Lights</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">No</td><td style="text-align: left;">No</td></tr><tr class="even"><td style="text-align: left;"><strong>Light Cookies</strong></td><td style="text-align: left;">Yes<br />
<br />
Only shape, no color (Alpha channel).</td><td style="text-align: left;">Yes<br />
<br />
Colored cookie (RGB)</td><td style="text-align: left;">Yes<br />
<br />
Colored cookie (RGB)</td></tr><tr class="odd"><td style="text-align: left;"><strong>IES Lights</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Light Distance Fade</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Physical light units</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Light anchor tool</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr></tbody></table>

### Shadows

<table><thead><tr class="header"><th style="text-align: left;"><strong>Feature</strong></th><th style="text-align: left;"><strong>Built-in Render Pipeline</strong></th><th style="text-align: left;"><strong>URP</strong></th><th style="text-align: left;"><strong>HDRP</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Directional Light Shadows</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Multiple Directional Light Shadows</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">No</td><td style="text-align: left;">No</td></tr><tr class="odd"><td style="text-align: left;"><strong>Directional Light Cascade Shadows</strong></td><td style="text-align: left;">Yes<br />
<br />
1, 2, or 4 cascades, control by percentage only.</td><td style="text-align: left;">Yes<br />
<br />
1 to 4 cascades. Control by percentage, or switch to meters.<br />
<br />
Settings are in URP asset.</td><td style="text-align: left;">Yes<br />
<br />
1 to 4 cascades. Control by percentage or distance.<br />
<br />
Settings are in Volumes.</td></tr><tr class="even"><td style="text-align: left;"><strong>Shadow Cascade Blending</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Spot Light Shadows</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Point Light Shadows</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Area Light Shadows</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Only for rectangle shape</td></tr><tr class="even"><td style="text-align: left;"><strong>Stable Fit Shadow Projection</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Close Fit Shadow Projection</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">No</td><td style="text-align: left;">No<br />
<br />
No support for orthographic projection. Use wide field of view to emulate.</td></tr><tr class="even"><td style="text-align: left;"><strong>Shadow Screen Space Pass</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes<br />
<br />
Mostly used for Raytracing.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Shadow bias</strong></td><td style="text-align: left;">Yes<br />
<br />
Supported types: Constant clip space offset. Normal bias</td><td style="text-align: left;">Yes<br />
<br />
Supported types: Offsets shadowmap texels in the light direction, Normal bias</td><td style="text-align: left;">Yes<br />
<br />
Supported types: Slope bias, Normal bias</td></tr><tr class="even"><td style="text-align: left;"><strong>PCF filtering (Percentage Closer Filtering)</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
PCF Tent 5x5</td><td style="text-align: left;">Yes<br />
<br />
For Point and Spot lights in “Low” (PCF 3x3 4 taps) and “Medium” (PCF 5x5 9 taps) quality settings, and for Directional lights in “Low” (PCF 5x5 9 taps) and “Medium” (PCF Tent 5x5 9 taps) quality settings.</td></tr><tr class="odd"><td style="text-align: left;"><strong>PCSS filtering (Percentage Closer Soft Shadows)</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
For Point and Spot lights, Directional lights and Area lights when in “High” quality in the HDRP settings for each kind of light.</td></tr><tr class="even"><td style="text-align: left;"><strong>EVSM filtering (Exponential Variance Shadow Mapping)</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
For area lights only in all quality settings except “High”.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Shadow update modes</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Every frame, On Enable, On Demand. Each cascade can be updated independently using the API (RequestSubShadowMapRendering)</td></tr><tr class="even"><td style="text-align: left;"><strong>Resolution settings</strong></td><td style="text-align: left;">Yes<br />
<br />
Configured in Quality Settings.</td><td style="text-align: left;">Yes<br />
<br />
Configured in URP Lighting Settings.</td><td style="text-align: left;">Yes<br />
<br />
Configure shadowmap resolution or budget per Light, and configure shadow atlas size in HDRP asset.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Dynamic rescale</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Directional light shadow caching</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Punctual and Area lights shadow caching</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Dynamic Shadow Casters</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Static Shadow Casters</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Contact Shadows</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Micro Shadows</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Shadow Cascade Volume Controller</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Shadow Distance Fade</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes<br />
<br />
Configure in Shadows Volume.</td></tr><tr class="even"><td style="text-align: left;"><strong>Shadow Mask</strong></td><td style="text-align: left;">Yes<br />
<br />
Configure per scene.</td><td style="text-align: left;">Yes<br />
<br />
Configure per scene.</td><td style="text-align: left;">Yes<br />
<br />
Configure per Light.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Distance Shadow Mask</strong></td><td style="text-align: left;">Yes<br />
<br />
Configure per scene.</td><td style="text-align: left;">Yes<br />
<br />
Forward Rendering Path only.</td><td style="text-align: left;">Yes<br />
<br />
Configure per Light.</td></tr><tr class="even"><td style="text-align: left;"><strong>Transparent objects casting shadows</strong></td><td style="text-align: left;">Yes<br />
<br />
Use the Transparent Cutout shaders for objects with “gaps” such as fences, vegetation, etc. or custom pixel-lit shaders using the Geometry render queue. Opacity can affect shadow intensity using dithering.</td><td style="text-align: left;">No<br />
<br />
Alpha clipping only.</td><td style="text-align: left;">Yes<br />
<br />
Raytracing only (incl support of colored shadows). For raster, alpha clipping only (use Alpha clipping &gt; Shadow threshold option).</td></tr><tr class="odd"><td style="text-align: left;"><strong>Transparent objects receiving shadows</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Shadow tint</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Shadow tint or penumbra tint options</td></tr><tr class="odd"><td style="text-align: left;"><strong>Shadow matte</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Use Unlit master node and “Enable Shadow Matte”</td></tr><tr class="even"><td style="text-align: left;"><strong>Shadow Layers</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr></tbody></table>

### Global Illumination

<table><thead><tr class="header"><th style="text-align: left;"><strong>Feature</strong></th><th style="text-align: left;"><strong>Built-in Render Pipeline</strong></th><th style="text-align: left;"><strong>URP</strong></th><th style="text-align: left;"><strong>HDRP</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Baked Global Illumination: Progressive CPU Lightmapper</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Baked Global Illumination: Progressive GPU Lightmapper</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Baked Global Illumination: Enlighten Lightmapper</strong></td><td style="text-align: left;">No<br />
<br />
Deprecated</td><td style="text-align: left;">No<br />
<br />
Deprecated</td><td style="text-align: left;">No<br />
<br />
Deprecated</td></tr><tr class="even"><td style="text-align: left;"><strong>Baked Global Illumination: Mixed Lighting modes</strong></td><td style="text-align: left;">Yes<br />
<br />
Subtractive, Baked indirect, Shadow Mask, Distance Shadow mask</td><td style="text-align: left;">Yes<br />
<br />
Subtractive, Baked indirect, Shadow Mask, Distance Shadow mask</td><td style="text-align: left;">Yes<br />
<br />
Baked indirect, Shadow Mask (per light setting), Distance Shadow mask (per light setting)</td></tr><tr class="odd"><td style="text-align: left;"><strong>Baked Global Illumination: Double Sided GI</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Realtime Global Illumination: Pre-computed (Enlighten)</strong></td><td style="text-align: left;">Yes<br />
<br />
Support ends after Unity 6</td><td style="text-align: left;">Yes<br />
<br />
Support ends after Unity 6</td><td style="text-align: left;">Yes<br />
<br />
Support ends after Unity 6</td></tr><tr class="odd"><td style="text-align: left;"><strong>Realtime Global Illumination: Screen space GI</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Screen Space Reflections</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Planar Reflections</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Raytraced Reflections</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Screen Space Refractions</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Non directional lightmap</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Directional lightmap</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr></tbody></table>

### Light Probes

<table><thead><tr class="header"><th style="text-align: left;"><strong>Feature</strong></th><th style="text-align: left;"><strong>Built-in Render Pipeline</strong></th><th style="text-align: left;"><strong>URP</strong></th><th style="text-align: left;"><strong>HDRP</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Light Probes: Blending</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Light Probes: Custom provided</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Light Probes: Occlusion Probes</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Light Probes: Proxy volumes (LPPV)</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">No<br />
<br />
Deprecated</td><td style="text-align: left;">Yes</td></tr></tbody></table>

### Adaptive Probe Volumes

<table><thead><tr class="header"><th style="text-align: left;"><strong>Feature</strong></th><th style="text-align: left;"><strong>Built-in Render Pipeline</strong></th><th style="text-align: left;"><strong>URP</strong></th><th style="text-align: left;"><strong>HDRP</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Probe Volumes: Per pixel lighting</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Probe Volumes: Per vertex lighting</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">No</td></tr><tr class="odd"><td style="text-align: left;"><strong>Probe Volumes: Blending</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Probe Volumes: Touchup volumes</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Probe Volumes: Stream from disk</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Incl. non compute pass for lower end devices.</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Probe Volumes: Sky occlusion</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Probe Volumes: Reflection Probes Normalization</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr></tbody></table>

### Reflection Probes

<table><thead><tr class="header"><th style="text-align: left;"><strong>Feature</strong></th><th style="text-align: left;"><strong>Built-in Render Pipeline</strong></th><th style="text-align: left;"><strong>URP</strong></th><th style="text-align: left;"><strong>HDRP</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Reflection Probes: Baked</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Reflection Probes: Real-time</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Reflection Probes: Real-time time sliced all faces at once</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">No</td></tr><tr class="even"><td style="text-align: left;"><strong>Reflection Probes: Real-time time sliced individual faces</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Reflection Probes: On-demand API</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Reflection Probes: Proxy volumes</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Reflection Probes: Simple sampling</strong></td><td style="text-align: left;">Yes<br />
<br />
Choose per-object how to sample reflection probes.</td><td style="text-align: left;">Yes<br />
<br />
Choose in the URP asset whether URP always performs simple sampling from reflection probes, or if it blends.</td><td style="text-align: left;">No<br />
<br />
See Reflection Hierarchy.</td></tr><tr class="even"><td style="text-align: left;"><strong>Reflection Probes: Blend probes sampling</strong></td><td style="text-align: left;">Yes<br />
<br />
Choose per-object how to sample reflection probes.<br />
<br />
Blend up to 2 reflection probes.</td><td style="text-align: left;">Yes<br />
<br />
Choose in the URP asset whether URP always performs simple sampling from reflection probes, or if it blends.<br />
<br />
If blending is enabled, URP always blends sky + 1 local probe, or 2 probes if there is no sky.</td><td style="text-align: left;">Yes<br />
<br />
No blending limit. All reflections including planar blend between each other.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Reflection Probes: Blend probes and skybox sampling</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes<br />
<br />
See Reflection Hierarchy.</td></tr><tr class="even"><td style="text-align: left;"><strong>Reflection Probes: Distanced based roughness</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Reflection Probes: Box Projection</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Reflection Probes: Oriented Box Projection</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Reflection Probes: Sphere Projection</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Reflection Probes: Per probe resolution</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr></tbody></table>

### Raytracing

<table><thead><tr class="header"><th style="text-align: left;"><strong>Feature</strong></th><th style="text-align: left;"><strong>Built-in Render Pipeline</strong></th><th style="text-align: left;"><strong>URP</strong></th><th style="text-align: left;"><strong>HDRP</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Ray-traced Ambient Occlusion</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Ray-traced Contact Shadows</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Ray-traced Global Illumination</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Ray-traced Reflections</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Incl. decals</td></tr><tr class="odd"><td style="text-align: left;"><strong>Ray-traced Shadows</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Ray-traced Recursive Rendering</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>AxF (automotive material)</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Terrain</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Heightmap only. No support for terrain details and terrain trees. For vegetation on terrain, we recommend using mixed rendering modes for ray traced GI and reflections which allow to support foliage/vegetation &amp; deformation, and for shadows using raster shadows.</td></tr><tr class="odd"><td style="text-align: left;"><strong>VFX Graph particles</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Windows</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Requires DX12, and platforms with hardware supporting RTX.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Linux</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">No</td></tr><tr class="even"><td style="text-align: left;"><strong>PS5</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>XBox Series</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr></tbody></table>

### Pathtracing

<table><thead><tr class="header"><th style="text-align: left;"><strong>Feature</strong></th><th style="text-align: left;"><strong>Built-in Render Pipeline</strong></th><th style="text-align: left;"><strong>URP</strong></th><th style="text-align: left;"><strong>HDRP</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Lit (Pathtracing support)</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Hair (Pathtracing support)</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Eye (Pathtracing support)</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">No</td></tr><tr class="even"><td style="text-align: left;"><strong>Fabric (Pathtracing support)</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>AxF (Pathtracing support)</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Decals (Pathtracing support)</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Except emissive decals.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Punctual lights (point, spot, directional)</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Incl. box spot light</td></tr><tr class="even"><td style="text-align: left;"><strong>Area Lights</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Incl. volumetric fog control</td></tr><tr class="odd"><td style="text-align: left;"><strong>Tube and Disc Lights</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Depth of field (Pathtracing support)</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Exponential Fog (Pathtracing support)</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Anisotropic fog (Pathtracing support)</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Local Volumetric fog (Pathtracing support)</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">No</td></tr><tr class="even"><td style="text-align: left;"><strong>HDRI sampling</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Denoiser</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
NVidia Optix™ AI accelerated denoiser or<br />
Intel® Open Image Denoise.</td></tr><tr class="even"><td style="text-align: left;"><strong>Recorder integration</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>VFX Graph particles</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">No</td></tr></tbody></table>

### Environment lighting

<table><thead><tr class="header"><th style="text-align: left;"><strong>Feature</strong></th><th style="text-align: left;"><strong>Built-in Render Pipeline</strong></th><th style="text-align: left;"><strong>URP</strong></th><th style="text-align: left;"><strong>HDRP</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Skybox</strong></td><td style="text-align: left;">Yes<br />
<br />
Per project. Set in the Lighting window.</td><td style="text-align: left;">Yes<br />
<br />
Per project. Set in the Lighting window.</td><td style="text-align: left;">Yes<br />
<br />
Configure in Visual Environment Volume. Choose from HDRI sky, physical sky or custom sky.</td></tr><tr class="even"><td style="text-align: left;"><strong>Gradient</strong></td><td style="text-align: left;">Yes<br />
<br />
Per project. Set in the Lighting window.</td><td style="text-align: left;">Yes<br />
<br />
Per project. Set in the Lighting window.</td><td style="text-align: left;">Yes<br />
<br />
Configure in Visual Environment Volume.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Color</strong></td><td style="text-align: left;">Yes<br />
<br />
Per project. Set in the Lighting window.</td><td style="text-align: left;">Yes<br />
<br />
Per project. Set in the Lighting window.</td><td style="text-align: left;">No<br />
<br />
Alternative: use Gradient sky.</td></tr><tr class="even"><td style="text-align: left;"><strong>Real-time Ambient Mode</strong></td><td style="text-align: left;">Yes<br />
<br />
By script.</td><td style="text-align: left;">Yes<br />
<br />
By script.</td><td style="text-align: left;">Yes<br />
<br />
Configure in Visual Environment Volume.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Baked Ambient Mode</strong></td><td style="text-align: left;">Yes<br />
<br />
By default</td><td style="text-align: left;">Yes<br />
<br />
By default</td><td style="text-align: left;">Yes<br />
<br />
Configure in Visual Environment Volume.<br />
<br />
Uses the environment stored in Lighting &gt; Environment settings.</td></tr><tr class="even"><td style="text-align: left;"><strong>Indirect Lighting Controller</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr></tbody></table>

<span id="color"></span>

## Color

### HDR

<table><thead><tr class="header"><th style="text-align: left;"><strong>Feature</strong></th><th style="text-align: left;"><strong>Built-in Render Pipeline</strong></th><th style="text-align: left;"><strong>URP</strong></th><th style="text-align: left;"><strong>HDRP</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>HDR rendering</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>HDR output</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Only certain devices are supported, see URP Documentation for more information.</td><td style="text-align: left;">Yes<br />
<br />
Use the HDROutputSettings API to configure HDR output options and HDRP’s tonemapping HDR options.<br />
See HDRP HDR documentation for more information.</td></tr></tbody></table>

### Color space

<table><thead><tr class="header"><th style="text-align: left;"><strong>Feature</strong></th><th style="text-align: left;"><strong>Built-in Render Pipeline</strong></th><th style="text-align: left;"><strong>URP</strong></th><th style="text-align: left;"><strong>HDRP</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Linear</strong></td><td style="text-align: left;">Yes<br />
<br />
Requires OpenGLES3.0</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Gamma</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">No</td></tr></tbody></table>

<span id="camera"></span>

## Camera

<table><thead><tr class="header"><th style="text-align: left;"><strong>Feature</strong></th><th style="text-align: left;"><strong>Built-in Render Pipeline</strong></th><th style="text-align: left;"><strong>URP</strong></th><th style="text-align: left;"><strong>HDRP</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Multi display</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Hardware Dynamic resolution</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes<br />
<br />
Supported on Vulkan, DirectX 12, Metal, and compatible consoles.</td><td style="text-align: left;">Yes<br />
<br />
Supported on Vulkan, DirectX 12, Metal, and compatible consoles.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Software Dynamic resolution</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No<br />
<br />
Except for XR direct-to-eye rendering.</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Nvidia Deep learning super sampling (DLSS)</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>AMD FidelityFX™ Super Resolution 1.0</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>AMD FidelityFX™ Super Resolution 2.0</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Windows platforms only.</td></tr><tr class="odd"><td style="text-align: left;"><strong>TAA upsampler</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Unity Spatial Temporal Post Process (STP)</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Mip bias</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Compositing multiple cameras</strong></td><td style="text-align: left;">Yes<br />
<br />
Use multiple cameras</td><td style="text-align: left;">Yes<br />
<br />
Use Camera stacking</td><td style="text-align: left;">Yes<br />
<br />
Use HDRP Compositor</td></tr><tr class="odd"><td style="text-align: left;"><strong>Physical camera</strong></td><td style="text-align: left;">Yes<br />
<br />
Affects field of view only</td><td style="text-align: left;">Yes<br />
<br />
Affects field of view only</td><td style="text-align: left;">Yes<br />
<br />
Affects field of view, exposure, bloom, and depth of field</td></tr><tr class="even"><td style="text-align: left;"><strong>Multi-sample anti-aliasing (MSAA)</strong></td><td style="text-align: left;">Yes<br />
<br />
Forward rendering path only</td><td style="text-align: left;">Yes<br />
<br />
Forward rendering path only</td><td style="text-align: left;">Yes<br />
<br />
Forward rendering path only</td></tr><tr class="odd"><td style="text-align: left;"><strong>Fast approximate anti-aliasing (FXAA)</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Subpixel morphological anti-aliasing (SMAA)</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Temporal anti-aliasing (TAA)</strong></td><td style="text-align: left;">Yes<br />
<br />
Additional pass to render all object’s motion vectors. No override support for transparents.</td><td style="text-align: left;">Yes<br />
<br />
Additional pass to render all object’s motion vectors. No override support for transparents. No custom motion vectors in ShaderGraph. Not compatible with Dynamic Resolution, MSAA nor Camera Stacking. 16-bits.</td><td style="text-align: left;">Yes<br />
<br />
Uses per-shader motion vectors and the stencil buffer to only render motion vectors where needed. Allows custom motion vectors in shaders, for example using the ShaderGraph or Alembic packages. 32-bits (float).</td></tr><tr class="even"><td style="text-align: left;"><strong>Depth Texture</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Depth + Normal Texture</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Depth + Normal Texture (affected by decals)</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Except if MSAA is enabled.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Color Texture</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Motion Vectors</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Thickness Pass</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Optional</td></tr></tbody></table>

<span id="shaders"></span>

## Shaders

### Authoring workflows

<table><thead><tr class="header"><th style="text-align: left;"><strong>Feature</strong></th><th style="text-align: left;"><strong>Built-in Render Pipeline</strong></th><th style="text-align: left;"><strong>URP</strong></th><th style="text-align: left;"><strong>HDRP</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Material Variants</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Shader Graph</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>ShaderLab</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes<br />
<br />
Hand-coded shaders are supported, but not recommended. Shader Graph is recommended (more easily upgradable).</td><td style="text-align: left;">Yes<br />
<br />
Hand-coded shaders are supported, but not recommended. Shader Graph is recommended (more easily upgradable).</td></tr><tr class="even"><td style="text-align: left;"><strong>ShaderLab Command: UsePass</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>ShaderLab Command: GrabPass</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">No<br />
<br />
Alternative: Scene color node in ShaderGraph / create a Renderer Feature</td><td style="text-align: left;">No<br />
<br />
Alternative: Scene color node in ShaderGraph / create a Custom Pass</td></tr><tr class="even"><td style="text-align: left;"><strong>Surface Shaders</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">No. For more information about alternatives, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/SL-SurfaceShaders.html">Surface shaders</a></td><td style="text-align: left;">No. For more information about alternatives, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/SL-SurfaceShaders.html">Surface shaders</a>.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Diffusion Profiles</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr></tbody></table>

### Prebuilt shaders

<table><thead><tr class="header"><th style="text-align: left;"><strong>Feature</strong></th><th style="text-align: left;"><strong>Built-in Render Pipeline</strong></th><th style="text-align: left;"><strong>URP</strong></th><th style="text-align: left;"><strong>HDRP</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Camera-relative rendering</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Material type: Metallic / Standard</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Material type: Specular</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Surface Type and Blend Mode: Opaque</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Surface Type and Blend Mode: Faded (Alpha Blend)</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes<br />
<br />
Also supports premultiplied alpha.</td></tr><tr class="even"><td style="text-align: left;"><strong>Surface Type and Blend Mode: Transparent</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Surface Type and Blend Mode: Cutout</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Surface Type and Blend Mode: Additive</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Surface Type and Blend Mode: Multiply</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">No<br />
<br />
Not compatible with half res transparent optimization and offscreen UI blending.</td></tr><tr class="even"><td style="text-align: left;"><strong>Surface Type and Blend Mode: Translucence</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Translucent Material Type in the Lit shaders</td></tr><tr class="odd"><td style="text-align: left;"><strong>Surface Inputs: Albedo (Base Map)</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Surface Inputs: Specular</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes<br />
<br />
Base map when using Material Type Specular</td></tr><tr class="odd"><td style="text-align: left;"><strong>Surface Inputs: Metallic</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes<br />
<br />
Stored in the R channel of the Mask Map.</td></tr><tr class="even"><td style="text-align: left;"><strong>Surface Inputs: Ambient Occlusion</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes<br />
<br />
Stored in the G channel of the Mask Map.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Surface Inputs: Smoothness</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes<br />
<br />
Stored in the A channel of the Mask Map.</td></tr><tr class="even"><td style="text-align: left;"><strong>Surface Inputs: Normal Map</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Surface Inputs: Bent Normal Map</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Surface Inputs: Detail Map</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes<br />
<br />
Albedo stored in the R channel of the Detail Map. Smoothness stored in the B channel.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Surface Inputs: Detail Normal Map</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes<br />
<br />
Y axis stored in the G channel of the Detail Map. X axis stored in the A channel.</td></tr><tr class="even"><td style="text-align: left;"><strong>Surface Inputs: Heightmap</strong></td><td style="text-align: left;">Yes<br />
<br />
Pixel displacement only.</td><td style="text-align: left;">Yes<br />
<br />
Pixel displacement only.</td><td style="text-align: left;">Yes<br />
<br />
Pixel or vertex displacement.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Surface Inputs: Detail Mask</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes<br />
<br />
Stored in the B channel of the Mask Map.</td></tr><tr class="even"><td style="text-align: left;"><strong>Surface Inputs: Emissive Map</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Surface Inputs: Transmission Mask</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Also available in Shader Graph.</td></tr><tr class="even"><td style="text-align: left;"><strong>Surface Inputs: Specular Occlusion</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Surface Inputs: Planar &amp; Triplanar mapping</strong></td><td style="text-align: left;">No<br />
<br />
Alternative: Use ShaderGraph Triplanar node</td><td style="text-align: left;">No<br />
<br />
Alternative: Use ShaderGraph Triplanar node</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Included Lighting models: ClearCoat</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Included Lighting models: SubSurface Scattering</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Includes Dual Lobe multipliers and diffuse shading power for skin.</td></tr><tr class="even"><td style="text-align: left;"><strong>Included Lighting models: Colored Translucent</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Included Lighting models: Anisotropy</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Included Lighting models: Irridescence</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Included Lighting models: Fabric</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Included Lighting models: Eye</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Eye caustics available in High quality mode.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Included Lighting models: Hair (Approximate)</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Based on Kajiya Kay parametrization</td></tr><tr class="even"><td style="text-align: left;"><strong>Included Lighting models: Hair (Physical)</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Based on Marshner-Disney parametrization. Cinematic option available to trade performance vs quality.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Add custom Lighting model as a plugin</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Pluggable Master Node (undocumented)</td></tr><tr class="even"><td style="text-align: left;"><strong>Features: Light Cookies</strong></td><td style="text-align: left;">Yes<br />
<br />
Supports grayscale textures</td><td style="text-align: left;">Yes<br />
<br />
Supports RGB textures</td><td style="text-align: left;">Yes<br />
<br />
Supports RGB textures</td></tr><tr class="odd"><td style="text-align: left;"><strong>Features: Parallax Mapping</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Features: Light Distance Fade</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Features: Shadow Distance Fade</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes<br />
<br />
Configure in Shadows Volume.</td></tr><tr class="even"><td style="text-align: left;"><strong>Features: Shadow Cascade Blending</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Features: GPU Instancing</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Features: Double Sided GI</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Features: Two Sided</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Configure with the RenderFace property.</td><td style="text-align: left;">Yes<br />
<br />
Configure with the Double Side toggle.</td></tr><tr class="even"><td style="text-align: left;"><strong>Features: Material sorting priority</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Features: Renderer sorting priority</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No<br />
<br />
Not exposed (use debug mode of the inspector).</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Features: GPU Tesselation</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Use the LitTesselation Shader.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Features: Specular Occlusion</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Use only the ambient occlusion map, or both bent and ambient occlusion maps.</td></tr><tr class="even"><td style="text-align: left;"><strong>Features: Geometric Specular Anti-Aliasing</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Features: Add precomputed velocity</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Requires per vertex velocity information (for example, Alembic, or using ShaderGraph custom velocity option)</td><td style="text-align: left;">Yes<br />
<br />
Requires per vertex velocity information (for example, Alembic, or using ShaderGraph custom velocity option)</td></tr></tbody></table>

### Shader Graph

<table><thead><tr class="header"><th style="text-align: left;"><strong>Feature</strong></th><th style="text-align: left;"><strong>Built-in Render Pipeline</strong></th><th style="text-align: left;"><strong>URP</strong></th><th style="text-align: left;"><strong>HDRP</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>UI</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Full screen master node</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Custom post-processing</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Custom render texture</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Text Mesh Pro</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">No</td></tr><tr class="even"><td style="text-align: left;"><strong>Decals</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Affect opaque objects only.</td><td style="text-align: left;">Yes<br />
<br />
Affect opaque and transparent objects.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Fog Volume</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Terrain</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">No</td></tr><tr class="odd"><td style="text-align: left;"><strong>Physically Based Sky</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr></tbody></table>

<span id="world-building"></span>

## World building

### Environment

<table><thead><tr class="header"><th style="text-align: left;"><strong>Feature</strong></th><th style="text-align: left;"><strong>Built-in Render Pipeline</strong></th><th style="text-align: left;"><strong>URP</strong></th><th style="text-align: left;"><strong>HDRP</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Terrain system: Physically Based Shader</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Terrain system: Simple Lit (Blinn-Phong) Shader</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">No</td><td style="text-align: left;">No</td></tr><tr class="odd"><td style="text-align: left;"><strong>Terrain system: SpeedTree Shader</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Terrain system: Paint Trees</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Terrain system: Vegetation</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Terrain system: Terrain Details</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Terrain system: number of Terrain Layers</strong></td><td style="text-align: left;">Yes<br />
<br />
Unlimited</td><td style="text-align: left;">Yes<br />
<br />
With height-based blending: 4<br />
With alpha blending: unlimited</td><td style="text-align: left;">Yes<br />
<br />
8</td></tr><tr class="even"><td style="text-align: left;"><strong>Terrain system: GPU Instanced Rendering</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Terrain system: Terrain Holes</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Water system: Physically Based Shader</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Water system: Compute based wave simulation</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Water system: CPU wave simulation for gameplay integration</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Simulation on CPU (no latency) or on GPU with GPU readback (low latency but high performance).</td></tr><tr class="odd"><td style="text-align: left;"><strong>Water system: Local currents</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Water system: Local foam</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Water system: Surface deformer</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Water system: Water excluder</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Water system: Support for decals (eg: Foam)</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Water system: Underwater Caustics</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Water system: Under water rendering</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Includes Water line rendering.</td></tr><tr class="even"><td style="text-align: left;"><strong>Water system: Under water volumetrics</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>SpeedTree 8</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes<br />
<br />
Both Shader Graph and ShaderLab shaders available.</td><td style="text-align: left;">Yes<br />
<br />
Shader Graph shader only. Support for subsurface map and motion vectors.</td></tr><tr class="even"><td style="text-align: left;"><strong>SpeedTree 9</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes<br />
<br />
Shader Graph shaders only.</td><td style="text-align: left;">Yes<br />
<br />
Shader Graph shaders only.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Wind Zone</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr></tbody></table>

### Sky

<table><thead><tr class="header"><th style="text-align: left;"><strong>Feature</strong></th><th style="text-align: left;"><strong>Built-in Render Pipeline</strong></th><th style="text-align: left;"><strong>URP</strong></th><th style="text-align: left;"><strong>HDRP</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Procedural Skybox</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">No<br />
<br />
This sky type is deprecated, but you can still use if if you install the Procedural Sky Sample.</td></tr><tr class="even"><td style="text-align: left;"><strong>6 sided Skybox</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes<br />
<br />
HDRI Sky supports cubemaps. Unity can build cubemaps from this type on import.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Cubemap</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes<br />
<br />
HDRI Sky supports cubemaps.</td></tr><tr class="even"><td style="text-align: left;"><strong>Panoramic</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes<br />
<br />
HDRI Sky supports cubemaps. Unity can build cubemaps from this type on import.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Physical Sky</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Gradient Sky</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Sky distortion</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Procedural or Flowmap</td></tr><tr class="even"><td style="text-align: left;"><strong>Cloud layers</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Atmospheric Scattering</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr></tbody></table>

### Volumetrics

<table><thead><tr class="header"><th style="text-align: left;"><strong>Feature</strong></th><th style="text-align: left;"><strong>Built-in Render Pipeline</strong></th><th style="text-align: left;"><strong>URP</strong></th><th style="text-align: left;"><strong>HDRP</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Volumetric Clouds</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Linear Fog</strong></td><td style="text-align: left;">Yes<br />
<br />
Configure in Graphics Settings.</td><td style="text-align: left;">Yes<br />
<br />
Configure in Graphics Settings.</td><td style="text-align: left;">No</td></tr><tr class="odd"><td style="text-align: left;"><strong>Exponential Fog</strong></td><td style="text-align: left;">Yes<br />
<br />
Configure in Graphics Settings.</td><td style="text-align: left;">Yes<br />
<br />
Configure in Graphics Settings.</td><td style="text-align: left;">Yes<br />
<br />
Configure with the Fog Override.</td></tr><tr class="even"><td style="text-align: left;"><strong>Exponential Squared</strong></td><td style="text-align: left;">Yes<br />
<br />
Configure in Graphics Settings.</td><td style="text-align: left;">Yes<br />
<br />
Configure in Graphics Settings.</td><td style="text-align: left;">No</td></tr><tr class="odd"><td style="text-align: left;"><strong>Local Volumetrics</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>3D Render texture for local volumetric fog</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Volumetric Material (use ShaderGraph for local volumetric fog)</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Fog Scattering &amp; Atmospheric scattering</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr></tbody></table>

<span id="visual-effects"></span>

## Visual effects

### Post-processing

<table><thead><tr class="header"><th style="text-align: left;"><strong>Feature</strong></th><th style="text-align: left;"><strong>Built-in Render Pipeline</strong></th><th style="text-align: left;"><strong>URP</strong></th><th style="text-align: left;"><strong>HDRP</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Feature support</strong></td><td style="text-align: left;">Yes<br />
<br />
Uses separate package: Post-Processing V2</td><td style="text-align: left;">Yes<br />
<br />
Uses integrated post-processing solution</td><td style="text-align: left;">Yes<br />
<br />
Uses integrated post-processing solution</td></tr><tr class="even"><td style="text-align: left;"><strong>Per-project default effects</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
A default volume can be applied to the project using HDRP default settings.</td><td style="text-align: left;">Yes<br />
<br />
A default volume can be applied to the project using HDRP default settings.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Ambient Occlusion</strong></td><td style="text-align: left;">Yes<br />
<br />
Supported types: Multi-scale ambient occlusion</td><td style="text-align: left;">Yes<br />
<br />
Supported types: Screen Space Ambient Occlusion (Depth or normal)</td><td style="text-align: left;">Yes<br />
<br />
Supported types: Screen Space Ground Truth Ambient Occlusion (Normal + temporal, tinted multi bounced, specular occlusion), Ray-traced ambient occlusion</td></tr><tr class="even"><td style="text-align: left;"><strong>Exposure</strong></td><td style="text-align: left;">Yes<br />
<br />
Supported types: Fixed, Automatic</td><td style="text-align: left;">Yes<br />
<br />
Supported types: Fixed</td><td style="text-align: left;">Yes<br />
<br />
Supported types: Fixed, Automatic (Eye adaptation), Curve Mapping, Physical Camera settings and Histogram.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Bloom</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Chromatic Aberration</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Tonemapping (Neutral, ACES, Custom)</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>White balance</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Color Channel Mixer</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Color Adjustments</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Color Curves</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Lift, Gamma, Gain</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Shadows, Midtones, Highlights</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Split Toning</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Depth of Field</strong></td><td style="text-align: left;">Yes<br />
<br />
Supported types: Bokeh</td><td style="text-align: left;">Yes<br />
<br />
Supported types: Bokeh and Gaussian</td><td style="text-align: left;">Yes<br />
<br />
Supported types: Bokeh</td></tr><tr class="even"><td style="text-align: left;"><strong>Physical Depth of Field</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Film Grain</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Lens Distortion</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Camera Motion Blur</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Object Motion Blur</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Screen Space Reflections</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Screen Space Refractions</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Vignette</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Panini Projection</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Screen Space Lens Flares</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Custom post-processing</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes<br />
<br />
Available with Full Screen Pass Renderer Feature.</td><td style="text-align: left;">Yes<br />
<br />
Either with script or ShaderGraph.</td></tr></tbody></table>

### CPU Particles (Shuriken)

<table><thead><tr class="header"><th style="text-align: left;"><strong>Feature</strong></th><th style="text-align: left;"><strong>Built-in Render Pipeline</strong></th><th style="text-align: left;"><strong>URP</strong></th><th style="text-align: left;"><strong>HDRP</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Feature support</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes<br />
<br />
GPU instancing is not supported. Distortion and flipbook blending can be done with Shader Graph. No standard particle shader available, but example particles ShaderGraph shaders can be found in the HDRP package samples.</td></tr><tr class="even"><td style="text-align: left;"><strong>Lit Particles</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Simple lit particles</strong></td><td style="text-align: left;">Yes<br />
<br />
Uses Blinn Phong.</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Unlit particles</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Soft Particles</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes<br />
<br />
Available via Shader Graph. Examples available in the particles system shader samples in the HDRP package sample.</td></tr><tr class="even"><td style="text-align: left;"><strong>Distortion</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes<br />
<br />
Available via Shader Graph. Examples available in the particles system shader samples in the HDRP package sample.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Flipbook blending</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes<br />
<br />
Available via Shader Graph. Examples available in the particles system shader samples in the HDRP package sample.</td></tr><tr class="even"><td style="text-align: left;"><strong>Trail</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>GPU Instancing</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">No</td></tr></tbody></table>

### GPU Particles (VFX Graph)

<table><thead><tr class="header"><th style="text-align: left;"><strong>Feature</strong></th><th style="text-align: left;"><strong>Built-in Render Pipeline</strong></th><th style="text-align: left;"><strong>URP</strong></th><th style="text-align: left;"><strong>HDRP</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Feature support</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Compute capable hardware only. OpenGL ES not supported.</td><td style="text-align: left;">Yes<br />
<br />
Compute capable hardware only.</td></tr><tr class="even"><td style="text-align: left;"><strong>Supported Shader graph shaders</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
VFX Shader Graph, Lit, Unlit, 2D Sprite Lit, 2D Custom Lit</td><td style="text-align: left;">Yes<br />
<br />
VFX Shader Graph, Lit, Unlit, Hair, Fabric (no support for tessellation, nor decal)</td></tr><tr class="odd"><td style="text-align: left;"><strong>Renders with 2D</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
3D particles and support for sorting layers and sprites. No support for 2D Physics, 2D sprites emitters, nor 2D Lights</td><td style="text-align: left;">No</td></tr><tr class="even"><td style="text-align: left;"><strong>Lit Particles</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Simple lit particles</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Unlit particles</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Soft Particles</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Distortion</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Flipbook blending</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Linear interpolation or flipbook motion vectors</td><td style="text-align: left;">Yes<br />
<br />
Linear interpolation or flipbook motion vectors</td></tr><tr class="even"><td style="text-align: left;"><strong>Trail</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Experimental</td><td style="text-align: left;">Yes<br />
<br />
Experimental</td></tr><tr class="odd"><td style="text-align: left;"><strong>Half-resolution</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Decals</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Motion Vectors</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Camera Buffer</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Depth collision, Color buffer</td><td style="text-align: left;">Yes<br />
<br />
Depth collision, Color buffer</td></tr><tr class="odd"><td style="text-align: left;"><strong>Instancing</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Skinned Mesh Sampling</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>6-way lighting</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Volumetric Fog Output</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Custom HLSL Blocks</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr></tbody></table>

### Decals

<table><thead><tr class="header"><th style="text-align: left;"><strong>Feature</strong></th><th style="text-align: left;"><strong>Built-in Render Pipeline</strong></th><th style="text-align: left;"><strong>URP</strong></th><th style="text-align: left;"><strong>HDRP</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Decals</strong></td><td style="text-align: left;">No<br />
<br />
Suggested alternative: Projector component.</td><td style="text-align: left;">Yes<br />
<br />
Projector decals (Forward or Forward+, using a Decal buffer) or Screen Space Decals (Deferred or Deferred+), decal layers, no emissive decals</td><td style="text-align: left;">Yes<br />
<br />
Projector decals (Forward or Deferred, using a Decal Buffer) or Mesh decals, support on transparents (Cluster decals), support decal layers, surface gradients, emissive decals</td></tr><tr class="even"><td style="text-align: left;"><strong>Decal layers</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr></tbody></table>

### Other visual effects

<table><thead><tr class="header"><th style="text-align: left;"><strong>Feature</strong></th><th style="text-align: left;"><strong>Built-in Render Pipeline</strong></th><th style="text-align: left;"><strong>URP</strong></th><th style="text-align: left;"><strong>HDRP</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Projector component</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">No<br />
<br />
Use the Decal Renderer Feature instead.</td><td style="text-align: left;">No<br />
<br />
Use the Decal Projector instead.</td></tr><tr class="even"><td style="text-align: left;"><strong>Line Renderer component</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Trail Renderer component</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes<br />
<br />
You can also use VFX Graph to create a custom trail effect.</td><td style="text-align: left;">Yes<br />
<br />
You can also use VFX Graph to create a custom trail effect.</td></tr><tr class="even"><td style="text-align: left;"><strong>Billboard Renderer component</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">No<br />
<br />
Suggested alternative: Use VFX Graph.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Halo component</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">No<br />
<br />
Suggested alternative: Use a Lens Flare (SRP) Data asset and a Lens Flare (SRP) component.</td><td style="text-align: left;">No<br />
<br />
Suggested alternative: Use a Lens Flare (SRP) Data asset and a Lens Flare (SRP) component, or use a celestial body in a directional light.</td></tr><tr class="even"><td style="text-align: left;"><strong>Lens flares</strong></td><td style="text-align: left;">Yes<br />
<br />
Use a Flare asset and either a Light component or a Lens Flare component.</td><td style="text-align: left;">Yes<br />
<br />
Use a Lens Flare (SRP) Data asset and a Lens Flare (SRP) component. Also check Screen Space Lens Flares (Post processing) that offer an alternative or complementary solution for lens flares.</td><td style="text-align: left;">Yes<br />
<br />
Use a Lens Flare (SRP) Data asset and a Lens Flare (SRP) component. Also check Screen Space Lens Flares (Post processing) that offer an alternative or complementary solution for lens flares.</td></tr></tbody></table>

<span id="2d-and-ui"></span>

## 2D and UI

### 2D

<table><thead><tr class="header"><th style="text-align: left;"><strong>Feature</strong></th><th style="text-align: left;"><strong>Built-in Render Pipeline</strong></th><th style="text-align: left;"><strong>URP</strong></th><th style="text-align: left;"><strong>HDRP</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Sprite</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">No</td></tr><tr class="even"><td style="text-align: left;"><strong>Tilemap</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">No</td></tr><tr class="odd"><td style="text-align: left;"><strong>Sprite Shape</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">No</td></tr><tr class="even"><td style="text-align: left;"><strong>Pixel-Perfect</strong></td><td style="text-align: left;">Yes<br />
<br />
Using the “2D Pixel Perfect” package.</td><td style="text-align: left;">Yes<br />
<br />
Using the “2D Pixel Perfect” package.</td><td style="text-align: left;">No</td></tr><tr class="odd"><td style="text-align: left;"><strong>2D Lights</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Available when Using 2D Renderer</td><td style="text-align: left;">No</td></tr><tr class="even"><td style="text-align: left;"><strong>2D Shadows</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Available when Using 2D Renderer</td><td style="text-align: left;">No</td></tr><tr class="odd"><td style="text-align: left;"><strong>VFX Graph</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Supports 3D particles, sorting layers, ShaderGraph Sprite Lit and Custom Lit targets, Alpha Clipping with Shadergraph Sprite Lit, Unlit and Custom Lit targets.<br />
<br />
Does not support 2D Physics, 2D sprites emitters, or 2D Lights.</td><td style="text-align: left;">No</td></tr></tbody></table>

### UI

| **Feature**                | **Built-in Render Pipeline** | **URP** | **HDRP** |
|:---------------------------|:-----------------------------|:--------|:---------|
| **Screen Space - Overlay** | Yes                          | Yes     | Yes      |
| **Screen Space - Camera**  | Yes                          | Yes     | Yes      |
| **World Space**            | Yes                          | Yes     | Yes      |
| **Text Mesh Pro**          | Yes                          | Yes     | Yes      |

<span id="xr"></span>

## XR

<table><thead><tr class="header"><th style="text-align: left;"><strong>Feature</strong></th><th style="text-align: left;"><strong>Built-in Render Pipeline</strong></th><th style="text-align: left;"><strong>URP</strong></th><th style="text-align: left;"><strong>HDRP</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Multipass</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Single Pass (double-wide)</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">No<br />
<br />
Deprecated</td><td style="text-align: left;">No<br />
<br />
Deprecated</td></tr><tr class="odd"><td style="text-align: left;"><strong>Single Pass Instanced</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes<br />
<br />
Windows and PSVR only</td></tr><tr class="even"><td style="text-align: left;"><strong>Multiview</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">No</td></tr><tr class="odd"><td style="text-align: left;"><strong>AR Foundation</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">No</td></tr><tr class="even"><td style="text-align: left;"><strong>Foveated Rendering</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Compatible with Forward on Oculus Quest (Fixed foveated rendering), PSVR2 and VisionPro (eye tracking).</td><td style="text-align: left;">No</td></tr><tr class="odd"><td style="text-align: left;"><strong>HDR</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr></tbody></table>

<span id="scripting"></span>

## Scripting

### Render Pipeline Hooks

<table><thead><tr class="header"><th style="text-align: left;"><strong>Feature</strong></th><th style="text-align: left;"><strong>Built-in Render Pipeline</strong></th><th style="text-align: left;"><strong>URP</strong></th><th style="text-align: left;"><strong>HDRP</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Camera.RenderWithShader</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">No<br />
<br />
Suggested alternative: ScriptableRenderPass</td><td style="text-align: left;">No<br />
<br />
Suggested alternative: CustomPass with material override</td></tr><tr class="even"><td style="text-align: left;"><strong>Camera.AddCommandBuffer (Camera.Remove[All]CommandBuffer)</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">No</td><td style="text-align: left;">No<br />
<br />
Alternative: Custom Passes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Camera.Render</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Light.AddCommandBuffer (LightRemove[All]CommandBuffer)</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">No</td><td style="text-align: left;">No</td></tr><tr class="odd"><td style="text-align: left;"><strong>OnPreCull</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">No<br />
<br />
Suggested alternative: RenderPipelineManager.beginCameraRendering or ScriptableRenderPass</td><td style="text-align: left;">No</td></tr><tr class="even"><td style="text-align: left;"><strong>OnPreRender</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">No<br />
<br />
Suggested alternative: RenderPipelineManager.beginCameraRendering or ScriptableRenderPass</td><td style="text-align: left;">No</td></tr><tr class="odd"><td style="text-align: left;"><strong>OnPostRender</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">No</td><td style="text-align: left;">No</td></tr><tr class="even"><td style="text-align: left;"><strong>OnRenderImage</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">No<br />
<br />
Suggested alternative: ScriptableRenderPass</td><td style="text-align: left;">No<br />
<br />
Suggested alternative: Fullscreen CustomPass</td></tr><tr class="odd"><td style="text-align: left;"><strong>OnRenderObject</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes<br />
<br />
RenderPipelineManager.endCameraRendering or<br />
ScriptableRenderPass API</td><td style="text-align: left;">No<br />
<br />
RenderPipelineManager.endCameraRendering or<br />
Custom Pass</td></tr><tr class="even"><td style="text-align: left;"><strong>OnWillRenderObject</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>OnBecameVisible</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>OnBecameInvisible</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Camera Replacement Material</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No<br />
<br />
Suggested alternative: use Render Feature to replace materials per-Pass.</td><td style="text-align: left;">No<br />
<br />
Suggested alternative: Custom Pass with Shader override</td></tr><tr class="even"><td style="text-align: left;"><strong>RenderPipeline.BeginFrameRendering</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>RenderPipeline.EndFrameRendering</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>RenderPipeline.BeginCameraRendering</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>RenderPIpeline.EndCameraRendering</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>UniversalRenderPipeline.RenderSingleCamera</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">No</td></tr><tr class="odd"><td style="text-align: left;"><strong>ScriptableRenderPass</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
This is similar to the CustomPass feature in HDRP.</td><td style="text-align: left;">No</td></tr><tr class="even"><td style="text-align: left;"><strong>Custom Renderers</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">No</td></tr><tr class="odd"><td style="text-align: left;"><strong>CustomPass</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
This is similar to the ScriptableRenderPass feature in URP.</td></tr><tr class="even"><td style="text-align: left;"><strong>Custom Post Process Pass</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Arbitrary Output Variables (AOV) API</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Recording API</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td></tr></tbody></table>

<span id="optimizations"></span>

## Optimizations

<table><thead><tr class="header"><th style="text-align: left;"><strong>Feature</strong></th><th style="text-align: left;"><strong>Built-in Render Pipeline</strong></th><th style="text-align: left;"><strong>URP</strong></th><th style="text-align: left;"><strong>HDRP</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Batching By Shader</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Batching By Material</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Batching by Material Property Blocks</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes<br />
<br />
Batched separately from the SRP Batcher</td><td style="text-align: left;">Yes<br />
<br />
Batched separately from the SRP Batcher</td></tr><tr class="even"><td style="text-align: left;"><strong>Dynamic batching (without SRP Batcher)</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Real-time batching with SRP Batcher</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Requires OpenGLES 3.1.</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Dynamic Shadows Batching</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">No<br />
<br />
Deprecated.</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>GPU Resident Drawer</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Disabled by default. Supported on Forward+ and Deferred+. Supported on Vulkan, DirectX 11, DirectX 12, Metal, and consoles. Disabled on other platforms.</td><td style="text-align: left;">Yes<br />
<br />
Enabled by default.</td></tr><tr class="even"><td style="text-align: left;"><strong>GPU Occlusion Culling</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Supported on Forward+ and Deferred+. Supported on Vulkan, DirectX 11, DirectX 12, Metal, and consoles. Disabled on other platforms.</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>GPU Instancing</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes<br />
<br />
Disabled by default when SRP Batcher is enabled.</td><td style="text-align: left;">Yes<br />
<br />
Disabled by default when SRP Batcher is enabled.</td></tr><tr class="even"><td style="text-align: left;"><strong>Render Graph</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Optimized for tile-based GPUs with raster pass merging.</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Dynamic Render Pass Culling</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes<br />
<br />
Disabled by default.</td></tr><tr class="even"><td style="text-align: left;"><strong>Variable Rate Shading API</strong></td><td style="text-align: left;">Yes<br />
<br />
API only.</td><td style="text-align: left;">Yes<br />
<br />
API, and integration with custom Scriptable Renderer Features.</td><td style="text-align: left;">Yes<br />
<br />
API, and integration with custom passes.</td></tr></tbody></table>

<span id="debug"></span>

## Debug

<table><thead><tr class="header"><th style="text-align: left;"><strong>Feature</strong></th><th style="text-align: left;"><strong>Built-in Render Pipeline</strong></th><th style="text-align: left;"><strong>URP</strong></th><th style="text-align: left;"><strong>HDRP</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Scene View Modes</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Volume Explorer</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Rendering debugger</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Runtime GPU profiler</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Render Graph viewer</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="even"><td style="text-align: left;"><strong>Probe volume debugger</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>Color Monitors</strong></td><td style="text-align: left;">No<br />
<br />
Use post processing stack v2</td><td style="text-align: left;">No</td><td style="text-align: left;">Yes<br />
<br />
Waveform, Parade, Vectorscope</td></tr><tr class="even"><td style="text-align: left;"><strong>Shader Graph Heatmap</strong></td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr><tr class="odd"><td style="text-align: left;"><strong>VFX Graph profiler</strong></td><td style="text-align: left;">No</td><td style="text-align: left;">Yes</td><td style="text-align: left;">Yes</td></tr></tbody></table>
