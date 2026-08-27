---
title: "Rendering Debugger window reference (HDRP)"
page_title: "Rendering Debugger window reference | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/rendering-debugger-window-reference.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/rendering-debugger-window-reference.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Rendering Debugger window reference

The Rendering Debugger separates debug items into the following sections:

- [Decals](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/rendering-debugger-window-reference.html#DecalsPanel)
- [Display Stats](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/rendering-debugger-window-reference.html#StatsPanel)
- [Material](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/rendering-debugger-window-reference.html#MaterialPanel)
- [Lighting](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/rendering-debugger-window-reference.html#LightingPanel)
- [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/rendering-debugger-window-reference.html#VolumePanel)
- [Rendering](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/rendering-debugger-window-reference.html#RenderingPanel)
- [Probe Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/rendering-debugger-window-reference.html#ProbeVolume)
- [Camera](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/rendering-debugger-window-reference.html#CameraPanel)
- [Virtual Texturing](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/rendering-debugger-window-reference.html#VirtualTexturingPanel)
- [GPU Resident Drawer](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/rendering-debugger-window-reference.html#GPUResidentDrawer)

Refer to [Use the Rendering debugger](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/use-the-rendering-debugger.html) for more information.

<span id="DecalsPanel"></span>

## Decals panel

The **Decals** panel has tools that you can use to debug [decals](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/decal-material-inspector-reference.html) affecting transparent objects in your project.

| **Property** | **Description** |
|----|----|
| **Display Atlas** | Enable the checkbox to display the decal atlas for a Camera in the top left of that Camera's view. |
| **Mip Level** | Use the slider to select the mip level for the decal atlas. The higher the mip level, the blurrier the decal atlas. |

<span id="StatsPanel"></span>

## Display Stats panel

The **display stats** panel is only visible in play mode. You can use it to debug performance issues in your project.

Use the [runtime shortcuts](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/use-the-rendering-debugger.html#how-to-access-the-rendering-debugger) to open the Display stats window in the scene view at runtime.

<span id="frame-stats"></span>

### Frame Stats

The Frame Stats section displays the average, minimum, and maximum value of each property. HDRP calculates each Frame Stat value over the 30 most recent frames.

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
<td><strong>Frame Rate</strong></td>
<td>The frame rate (in frames per second) for the current camera view.</td>
</tr>
<tr>
<td><strong>Frame Time</strong></td>
<td>The total frame time for the current camera view.</td>
</tr>
<tr>
<td><strong>CPU Main Thread Frame</strong></td>
<td>The total time (in milliseconds) between the start of the frame and the time when the Main Thread finished the job.</td>
</tr>
<tr>
<td><strong>CPU Render Thread Frame</strong></td>
<td>The time (in milliseconds) between the start of the work on the Render Thread and the time Unity waits to render the present frame (<a href="https://docs.unity3d.com/2022.1/Documentation/Manual/profiler-markers.html">Gfx.PresentFrame</a>).</td>
</tr>
<tr>
<td><strong>CPU Present Wait</strong></td>
<td>The time (in milliseconds) that the CPU spent waiting for Unity to render the present frame (<a href="https://docs.unity3d.com/2022.1/Documentation/Manual/profiler-markers.html">Gfx.PresentFrame</a>) during the last frame.</td>
</tr>
<tr>
<td><strong>GPU Frame</strong></td>
<td>The amount of time (in milliseconds) the GPU takes to render a given frame.</td>
</tr>
<tr>
<td><strong>RT Mode</strong></td>
<td>When you <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Ray-Tracing-Getting-Started.html">enable ray tracing</a>, this property shows the ray tracing quality mode that HDRP uses during rendering. HDRP updates this value once every frame based on the previous frame.</td>
</tr>
<tr>
<td><strong>Count Rays</strong></td>
<td>Count the number of traced rays for each effect (in MRays / frame). This property only appears when you enable ray tracing.
<ul>
<li><strong>Ambient Occlusion:</strong> The number of rays that HDRP traced for <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Ambient-Occlusion.html">Ambient Occlusion (AO)</a> computations when you enable realtime ambient occlusion (RT AO).</li>
<li><strong>Shadows Directional:</strong> The number of rays that HDRP traced for <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Light-Component.html">directional lights</a> when you enable ray-traced shadows.</li>
<li><strong>Shadows Area:</strong> The number of rays that HDRP traced towards area lights when you enable <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Ray-Traced-Shadows.html">ray-traced shadows</a>.</li>
<li><strong>Shadows Point/Spot:</strong> The number of rays that HDRP traced towards point and spot lights when you enable ray-traced shadows.</li>
<li><strong>Reflection Forward:</strong> The number of rays that HDRP traced for reflection computations that use <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Forward-And-Deferred-Rendering.html">forward shading</a>.</li>
<li><strong>Reflection Deferred:</strong> The number of rays that HDRP traced for reflection computations that use <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Forward-And-Deferred-Rendering.html">deferred shading</a>.</li>
<li><strong>Diffuse GI Forward:</strong> The number of rays that HDRP traced for diffuse <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Ray-Traced-Global-Illumination.html">Global Illumination (GI)</a> computations that use forward shading.</li>
<li><strong>Diffuse GI Deferred:</strong> The number of rays that HDRP traced for diffuse Global Illumination (GI) computations that use deferred shading.</li>
<li><strong>Recursive:</strong> The number of rays that HDRP traced for diffuse Global Illumination (GI) computations when you enable recursive ray tracing.</li>
<li><strong>Total:</strong> The total number of rays that HDRP traced.</li>
</ul></td>
</tr>
<tr>
<td><strong>Debug XR Layout</strong></td>
<td>Display debug information for XR passes. This mode is only available in editor and development builds.</td>
</tr>
</tbody>
</table>

<span id="bottlenecks"></span>

### Bottlenecks

A bottleneck is a condition that occurs when one process performs significantly slower than other components, and other components depend on it.

The **Bottlenecks** section describes the distribution of the last 60 frames across the CPU and GPU. You can only see the Bottleneck information when you build your player on a device.

**Note**: Vsync limits the **Frame Rate** based on the refresh rate of your device’s screen. This means when you enable Vsync, the **Present Limited** category is 100% in most cases. To turn Vsync off, go to **Edit** \> **Project settings** \> **Quality** \> **Current Active Quality Level** and set the **Vsync Count** set to **Don't Sync**.

#### Bottleneck categories

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr>
<th><strong>Category</strong></th>
<th><strong>Description</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>CPU</strong></td>
<td>The percentage of the last 60 frames in which the CPU limited the frame time.</td>
</tr>
<tr>
<td><strong>GPU</strong></td>
<td>The percentage of the last 60 frames in which the GPU limited the frame time.</td>
</tr>
<tr>
<td><strong>Present limited</strong></td>
<td>The percentage of the last 60 frames in which the frame time was limited by the following presentation constraints:
<ul>
<li><strong>Vertical Sync (Vsync):</strong> Vsync synchronizes rendering to the refresh rate of your display.</li>
<li><strong><a href="https://docs.unity3d.com/ScriptReference/Application-targetFrameRate.html">Target framerate</a>:</strong> A function that you can use to manually limit the frame rate of an application. If a frame is ready before the time you specify in targetFrameRate, Unity waits before presenting the frame.</li>
</ul></td>
</tr>
<tr>
<td><strong>Balanced</strong></td>
<td>This percentage of the last 60 frames in which the frame time was not limited by any of the above categories. A frame that is 100% balanced indicates the processing time for both CPU and GPU is approximately equal.</td>
</tr>
</tbody>
</table>

#### Bottleneck example

If Vsync limited 20 of the 60 most recent frames, the Bottleneck section might appear as follows:

- **CPU** 0.0%: This indicates that HDRP did not render any of the last 60 frames on the CPU.
- **GPU** 66.6%: This indicates that the GPU limited 66.6% of the 60 most recent frames rendered by HDRP.
- **Present Limited** 33.3%: This indicates that presentation constraints (Vsync or the [target framerate](https://docs.unity3d.com/ScriptReference/Application-targetFrameRate.html)) limited 33.3% of the last 60 frames.
- **Balanced** 0.0%: This indicates that in the last 60 frames, there were 0 frames where the CPU processing time and GPU processing time were the same.

In this example, the bottleneck is the GPU.

<span id="detailed-stats"></span>

### Detailed Stats

The Detailed Stats section displays the amount of time in milliseconds that each rendering step takes on the CPU and GPU. HDRP updates these values once every frame based on the previous frame.

| **Property** | **Description** |
|----|----|
| Update every second with average | Calculate average values over one second and update every second. |
| Hide empty scopes | Hide profiling scopes that use 0.00ms of processing time on the CPU and GPU. |
| Count Rays | Count the number of traced rays for each effect (in MRays / frame). This mode only appears when you enable ray tracing. |
| Debug XR Layout | Enable to display debug information for [XR](https://docs.unity3d.com/Manual/XR.html) passes. This mode only appears in the editor and development builds. |

<span id="MaterialPanel"></span>

## Material panel

The **Material** panel has tools that you can use to visualize different Material properties.

<table>
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<thead>
<tr>
<th><strong>Property</strong></th>
<th><strong>Sub-property</strong></th>
<th><strong>Description</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>Common Material Property</strong></td>
<td>N/A</td>
<td>Use the drop-down to select a Material property to visualize on every GameObject on screen. All HDRP Materials share the properties available.</td>
</tr>
<tr>
<td><strong>Material</strong></td>
<td>N/A</td>
<td>Use the drop-down to select a Material property to visualize on every GameObject on screen using a specific Shader. The properties available depend on the HDRP Material type you select in the drop-down.</td>
</tr>
<tr>
<td><strong>Rendering Layer Mask</strong></td>
<td>N/A</td>
<td>These parameters only appear when you set the Material Debug Option to Rendering Layers.</td>
</tr>
<tr>
<td><strong>Rendering Layer Mask</strong></td>
<td><strong>Filter Light Layers by Light</strong></td>
<td>Enable the checkbox to visualize GameObjects that the selected light affects.</td>
</tr>
<tr>
<td><strong>Rendering Layer Mask</strong></td>
<td><strong>Use Light's Shadow Layer Mask</strong></td>
<td>Enable the checkbox to visualize GameObjects that cast shadows for the selected light.</td>
</tr>
<tr>
<td><strong>Rendering Layer Mask</strong></td>
<td><strong>Filter Layers</strong></td>
<td>Use the drop-down to filter layers that you want to display. GameObjects that have a matching layer appear in a specific color. Use <strong>Layers Color</strong> to define this color.</td>
</tr>
<tr>
<td><strong>Rendering Layer Mask</strong></td>
<td><strong>Layers Color</strong></td>
<td>Use the color pickers to select the display color of each rendering layer.</td>
</tr>
<tr>
<td><strong>Engine</strong></td>
<td>N/A</td>
<td>Use the drop-down to select a Material property to visualize on every GameObject on a screen that uses a specific Shader. The properties available are the same as Material but are in the form that the lighting engine uses them (for example, Smoothness is Perceptual Roughness).</td>
</tr>
<tr>
<td><strong>Attributes</strong></td>
<td>N/A</td>
<td>Use the drop-down to select a 3D GameObject attribute, like Texture Coordinates or Vertex Color, to visualize on screen.</td>
</tr>
<tr>
<td><strong>Properties</strong></td>
<td>N/A</td>
<td>Use the drop-down to select a property that the debugger uses to highlight GameObjects on screen. The debugger highlights GameObjects that use a Material with the property that you select.</td>
</tr>
<tr>
<td><strong>GBuffer</strong></td>
<td>N/A</td>
<td>Use the drop-down to select a property to visualize from the GBuffer for deferred Materials.</td>
</tr>
<tr>
<td><strong>Material Validator</strong></td>
<td>N/A</td>
<td>Use the drop-down to select properties to display validation colors for:
<ul>
<li><strong>Diffuse Color:</strong> Select this option to check if the diffuse colors in your Scene adhere to an acceptable PBR range. If the Material color is out of this range, the debugger displays it in the Too High Color color if it's above the range, or in the Too Low Color if it's below the range.</li>
<li><strong>Metal or SpecularColor:</strong> Select this option to check if a pixel contains a metallic or specular color that adheres to an acceptable PBR range. If it doesn't, the debugger highlights it in the Not A Pure Metal Color. For information about the acceptable PBR ranges in Unity, see the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Material-Charts.md">Material Charts</a> documentation.</li>
</ul></td>
</tr>
<tr>
<td><strong>Material Validator</strong></td>
<td><strong>Too High Color</strong></td>
<td>Use the color picker to select the color that the debugger displays when a Material's diffuse color is above the acceptable PBR range.</td>
</tr>
<tr>
<td><strong>Material Validator</strong></td>
<td><strong>Too Low Color</strong></td>
<td>Use the color picker to select the color that the debugger displays when a Material's diffuse color is below the acceptable PBR range.
<ul>
<li>This property only appears when you select <strong>Diffuse Color</strong> or <strong>Metal or SpecularColor</strong> from the Material Validator drop-down.</li>
</ul></td>
</tr>
<tr>
<td><strong>Material Validator</strong></td>
<td><strong>Not A Pure Metal Color</strong></td>
<td>Use the color picker to select the color that the debugger displays if a pixel defined as metallic has a non-zero albedo value. The debugger only highlights these pixels if you enable the True Metals checkbox.
<ul>
<li>This property only appears when you select <strong>Diffuse Color</strong> or <strong>Metal or SpecularColor</strong> from the Material Validator drop-down.</li>
</ul></td>
</tr>
<tr>
<td><strong>Material Validator</strong></td>
<td><strong>Pure Metals</strong></td>
<td>Enable the checkbox to make the debugger highlight any pixels which Unity defines as metallic, but which have a non-zero albedo value. The debugger uses the Not A Pure Metal Color to highlight these pixels.
<ul>
<li>This property only appears when you select <strong>Diffuse Color</strong> or <strong>Metal or SpecularColor</strong> from the Material Validator drop-down.</li>
</ul></td>
</tr>
<tr>
<td><strong>Override Global Material Texture Mip Bias</strong></td>
<td>N/A</td>
<td>Enable the checkbox to override the mipmap level bias of texture samplers in material shaders. Use the Debug Global Material Texture Mip Bias Value to control the mipmap level bias override.
<ul>
<li>When using this feature, be aware of the following:
<ul>
<li>It only affects gbuffer, forward opaque, transparency, and decal passes.</li>
<li>It doesn't affect virtual texturing sampling.</li>
<li>It doesn't affect custom passes.</li>
</ul></li>
</ul></td>
</tr>
<tr>
<td><strong>Debug Global Material Texture Mip Bias Value</strong></td>
<td>N/A</td>
<td>Use the slider to control the amount of mip bias of texture samplers in material shaders.</td>
</tr>
</tbody>
</table>

If the geometry or the shading normal is denormalized, the view renders the target pixel red.

<span id="LightingPanel"></span>

## Lighting panel

The **Lighting** panel has tools that you can use to visualize various components of the lighting system in your Scene, like, shadowing and direct/indirect lighting.

<table>
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<thead>
<tr>
<th><strong>Shadow Debug Option</strong></th>
<th><strong>Sub-option</strong></th>
<th><strong>Description</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>Debug Mode</strong></td>
<td>N/A</td>
<td>Use the drop-down to select which shadow debug information to overlay on the screen:
<ul>
<li><strong>None:</strong> Select this mode to remove the shadow debug information from the screen.</li>
<li><strong>VisualizePunctualLightAtlas:</strong> Select this mode to overlay the shadow atlas for Punctual Lights in your Scene.</li>
<li><strong>VisualizeDirectionalLightAtlas:</strong> Select this mode to overlay the shadow atlas for Directional Lights in your Scene.</li>
<li><strong>VisualizeAreaLightAtlas:</strong> Select this mode to overlay the shadow atlas for Area Lights in your Scene.</li>
<li><strong>VisualizeShadowMap:</strong> Select this mode to overlay a single shadow map for a Light in your Scene.</li>
<li><strong>SingleShadow:</strong> Select this mode to replace the Scene's lighting with a single Light. To select which Light to isolate, see <em>Use Selection</em> or <em>Shadow Map Index</em>.</li>
</ul></td>
</tr>
<tr>
<td><strong>Debug Mode</strong></td>
<td><strong>Use Selection</strong></td>
<td>Enable the checkbox to display the shadow map for the Light you select in the Scene.
<ul>
<li>This property only appears when you select <strong>VisualizeShadowMap</strong> or <strong>SingleShadow</strong> from the Shadow Debug Mode drop-down.</li>
</ul></td>
</tr>
<tr>
<td><strong>Debug Mode</strong></td>
<td><strong>Shadow Map Index</strong></td>
<td>Use the slider to select the index of the shadow map to view. To use this property correctly, you must have at least one Light in your Scene that uses shadow maps.</td>
</tr>
<tr>
<td><strong>Global Scale Factor</strong></td>
<td>N/A</td>
<td>Use the slider to set the global scale that HDRP applies to the shadow rendering resolution.</td>
</tr>
<tr>
<td><strong>Clear Shadow Atlas</strong></td>
<td>N/A</td>
<td>Enable the checkbox to clear the shadow atlas every frame.</td>
</tr>
<tr>
<td><strong>Range Minimum Value</strong></td>
<td>N/A</td>
<td>Set the minimum shadow value to display in the various shadow debug overlays.</td>
</tr>
<tr>
<td><strong>Range Maximum Value</strong></td>
<td>N/A</td>
<td>Set the maximum shadow value to display in the various shadow debug overlays.</td>
</tr>
<tr>
<td><strong>Log Cached Shadow Atlas Status</strong></td>
<td>N/A</td>
<td>Set the maximum shadow value to display in the various shadow debug overlays.</td>
</tr>
</tbody>
</table>

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr>
<th><strong>Lighting Debug Option</strong></th>
<th><strong>Description</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>Show Lights By Type</strong></td>
<td>Allows the user to enable or disable lights in the scene based on their type.
<ul>
<li><strong>Directional Lights:</strong> Enable the checkbox to see Directional Lights in your Scene. Disable this checkbox to remove Directional Lights from your Scene's lighting.</li>
<li><strong>Punctual Lights:</strong> Enable the checkbox to see Punctual Lights in your Scene. Disable this checkbox to remove Punctual Lights from your Scene's lighting.</li>
<li><strong>Area Lights:</strong> Enable the checkbox to see Area Lights in your Scene. Disable this checkbox to remove Area Lights from your Scene's lighting.</li>
<li><strong>Reflection Probes:</strong> Enable the checkbox to see Reflection Probes in your Scene. Disable this checkbox to remove Reflection Probes from your Scene's lighting.</li>
</ul></td>
</tr>
<tr>
<td><strong>Exposure</strong></td>
<td>Allows you to select an Exposure debug mode to use.
<ul>
<li><strong>Debug Mode:</strong> Use the drop-down to select a debug mode. See Exposure documentation for more information.</li>
<li><strong>Show Tonemap Curve:</strong> Enable the checkbox to overlay the tonemap curve to the histogram debug view. This property only appears when you select <strong>HistogramView</strong> from Debug Mode.</li>
<li><strong>Center Around Exposure:</strong> Enable the checkbox to center the histogram around the current exposure value. This property only appears when you select <strong>HistogramView</strong> from Debug Mode.</li>
<li><strong>Display RGB Histogram:</strong> Enable the checkbox to display the Final Image Histogram as an RGB histogram instead of just luminance. This property only appears when you select <strong>FinalImageHistogramView</strong> from Debug Mode.</li>
<li><strong>Display Mask Only:</strong> Enable the checkbox to display only the metering mask in the picture-in-picture. When disabled, the mask displays after weighting the scene color instead. This property only appears when you select <strong>MeteringWeighted</strong> from Debug Mode.</li>
<li><strong>Debug Exposure Compensation:</strong> Set an additional exposure compensation for debug purposes.</li>
</ul></td>
</tr>
<tr>
<td><strong>Debug Mode</strong></td>
<td>Use the drop-down to select a lighting mode to debug. For example, you can visualize diffuse lighting, specular lighting, direct diffuse lighting, direct specular lighting, indirect diffuse lighting, indirect specular lighting, emissive lighting and Directional Light shadow cascades.</td>
</tr>
<tr>
<td><strong>Hierarchy Debug Mode</strong></td>
<td>Use the drop-down to select a light type to display the direct lighting for or a Reflection Probe type to display the indirect lighting for.</td>
</tr>
</tbody>
</table>

| **Material Overrides** | **Suboption** | **Description** |
|----|----|----|
| **Override Smoothness** | N/A | Enable the checkbox to override the smoothness for the entire Scene. |
| **Override Smoothness** | **Smoothness** | Use the slider to set the smoothness override value that HDRP uses for the entire Scene. |
| **Override Albedo** | N/A | Enable the checkbox to override the albedo for the entire Scene. |
| **Override Albedo** | **Albedo** | Use the color picker to set the albedo color that HDRP uses for the entire Scene. |
| **Override Normal** | N/A | Enable the checkbox to override the normals for the entire Scene with object normals for lighting debug. |
| **Override Specular Color** | N/A | Enable the checkbox to override the specular color for the entire Scene. |
| **Override Specular Color** | **Specular Color** | Use the color picker to set the specular color that HDRP uses for the entire Scene. |
| **Override Ambient Occlusion** | N/A | Enable the checkbox to override the ambient occlusion for the entire Scene. |
| **Override Ambient Occlusion** | **Ambient Occlusion** | Use the slider to set the Ambient Occlusion override value that HDRP uses for the entire Scene. |
| **Override Emissive Color** | N/A | Enable the checkbox to override the emissive color for the entire Scene. |
| **Override Emissive Color** | **Emissive Color** | Use the color picker to set the emissive color that HDRP uses for the entire Scene. |

<table>
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<thead>
<tr>
<th><strong>Property</strong></th>
<th><strong>Sub-propery</strong></th>
<th><strong>Description</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>Fullscreen Debug Mode</strong></td>
<td>N/A</td>
<td>Use the drop-down to select a fullscreen lighting effect to debug. For example, you can visualize Contact Shadows, the depth pyramid, and indirect diffuse lighting. You can also use some of those Lighting Fullscreen Debug Modes to debug Ray-Traced effects.</td>
</tr>
<tr>
<td><strong>Tile/Cluster Debug</strong></td>
<td>N/A</td>
<td>Use the drop-down to select an internal HDRP lighting structure to visualize on screen.
<ul>
<li><strong>None:</strong> Select this option to disable this debug feature.</li>
<li><strong>Tile:</strong> Select this option to display an overlay of each lighting tile, and the number of lights in them.</li>
<li><strong>Cluster:</strong> Select this option to display an overlay of each lighting cluster that intersects opaque geometry, and the number of lights in them.</li>
<li><strong>Material Feature Variants:</strong> Select this option to display the index of the lighting Shader variant that HDRP uses for a tile. You can find variant descriptions in the lit.hlsl file.</li>
</ul></td>
</tr>
<tr>
<td><strong>Tile/Cluster Debug</strong></td>
<td><strong>Tile/Cluster Debug By Category</strong></td>
<td>Use the drop-down to select the Light type that you want to display the Tile/Cluster debug information for. The options include Light Types, Decals, and Local Volumetric Fog. This property only appears when you select Tile or Cluster from the Tile/Cluster Debug drop-down.</td>
</tr>
<tr>
<td><strong>Tile/Cluster Debug</strong></td>
<td><strong>Cluster Debug Mode</strong></td>
<td>Use the drop-down to select the visualization mode for the cluster. The options are:
<ul>
<li><strong>Visualize Opaque:</strong> Displays cluster information on opaque geometry.</li>
<li><strong>Visualize Slice:</strong> Displays cluster information at a set distance from the camera.</li>
<li>This property only appears when you select <strong>Cluster</strong> from the Tile/Cluster Debug drop-down.</li>
</ul></td>
</tr>
<tr>
<td><strong>Tile/Cluster Debug</strong></td>
<td><strong>Cluster Distance</strong></td>
<td>Use this slider to set the distance from the camera at which to display the cluster slice. This property only appears when you select VisualizeSlice from the Cluster Debug Mode drop-down.</td>
</tr>
<tr>
<td><strong>Display Sky Reflection</strong></td>
<td>N/A</td>
<td>Enable the checkbox to display an overlay of the cube map that the current sky generates and HDRP uses for lighting.</td>
</tr>
<tr>
<td><strong>Display Sky Reflection</strong></td>
<td><strong>Sky Reflection Mipmap</strong></td>
<td>Use the slider to set the mipmap level of the sky reflection cubemap. Use this to view the sky reflection cubemap's different mipmap levels.
<ul>
<li>This property only appears when you enable the <strong>Display Sky Reflection</strong> checkbox.</li>
</ul></td>
</tr>
<tr>
<td><strong>Display Light Volumes</strong></td>
<td>N/A</td>
<td>Enable the checkbox to display an overlay of all light bounding volumes.</td>
</tr>
<tr>
<td><strong>Display Light Volumes</strong></td>
<td><strong>Light Volume Debug Type</strong></td>
<td>Use the drop-down to select the method HDRP uses to display the light volumes.
<ul>
<li><strong>Gradient:</strong> Select this option to display the light volumes as a gradient.</li>
<li><strong>ColorAndedge:</strong> Select this option to display the light volumes as a plain color (a different color for each Light Type) with a red border for readability.</li>
<li>This property only appears when you enable the <strong>Display Light Volumes</strong> checkbox.</li>
</ul></td>
</tr>
<tr>
<td><strong>Display Light Volumes</strong></td>
<td><strong>Max Debug Light Count</strong></td>
<td>Use the slider to rescale the gradient. Lower this value to make the screen turn red faster. Use this property to change the maximum acceptable number of lights for your application and still see areas in red. This property only appears when you set the Display Light Volumes mode to Gradient.</td>
</tr>
<tr>
<td><strong>Display Cookie Atlas</strong></td>
<td>N/A</td>
<td>Enable the checkbox to display an overlay of the cookie atlas.</td>
</tr>
<tr>
<td><strong>Display Cookie Atlas</strong></td>
<td><strong>Mip Level</strong></td>
<td>Use the slider to set the mipmap level of the cookie atlas. This property only appears when you enable the Display Cookie Atlas checkbox.</td>
</tr>
<tr>
<td><strong>Display Cookie Atlas</strong></td>
<td><strong>Clear Cookie Atlas</strong></td>
<td>Enable the checkbox to clear the cookie atlas at each frame. This property only appears when you enable the Display Cookie Atlas checkbox.</td>
</tr>
<tr>
<td><strong>Display Planar Reflection Atlas</strong></td>
<td>N/A</td>
<td>Enable the checkbox to display an overlay of the planar reflection atlas.</td>
</tr>
<tr>
<td><strong>Display Planar Reflection Atlas</strong></td>
<td><strong>Mip Level</strong></td>
<td>Use the slider to set the mipmap level of the planar reflection atlas. This property only appears when you enable the Display Planar Reflection Atlas checkbox.</td>
</tr>
<tr>
<td><strong>Display Planar Reflection Atlas</strong></td>
<td><strong>Clear Planar Atlas</strong></td>
<td>Enable the checkbox to clear the planar reflection atlas at each frame. This property only appears when you enable the Display Planar Reflection Atlas checkbox.</td>
</tr>
<tr>
<td><strong>Debug Overlay Screen Ratio</strong></td>
<td>N/A</td>
<td>Set the size of the debug overlay textures with a ratio of the screen size. The default value is 0.33 which is 33% of the screen size.</td>
</tr>
</tbody>
</table>

<span id="VolumePanel"></span>

## Volume panel

The **Volume** panel has tools that you can use to visualize the Volume Components affecting a camera.

| **Property** | **Description** |
|----|----|
| **Component** | Use the drop-down to select which volume component to visualize. |
| **Camera** | Use the drop-down to select which camera to use as volume anchor. |
| **Parameter** | List of parameters for the selected component. |
| **Interpolated Value** | Current value affecting the choosen camera for each parameter. |
| **Other columns** | Each one of the remaining columns display the parameter values of a volume affecting the selected **Camera**. They're sorted from left to right by decreasing influence. |

<span id="ProbeVolume"></span>

## Probe Volume panel

These settings make it possible for you to visualize [Adaptive Probe Volumes](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/probevolumes.html) in your Scene, and configure the visualization.

### Subdivision Visualization

| **Property** | **Sub-property** | **Description** |
|----|----|----|
| **Display Cells** | N/A | Display cells. Refer to [Understanding Adaptive Probe Volumes](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/probevolumes-concept.html) for more information. |
| **Display Bricks** | N/A | Display bricks. Refer to [Understanding Adaptive Probe Volumes](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/probevolumes-concept.html) for more information. |
| **Live Subdivision Preview** | N/A | Enable a preview of Adaptive Probe Volume data in the scene without baking. This might make the Editor slower. This setting appears only if you select **Display Cells** or **Display Bricks**. |
| **Live Subdivision Preview** | **Cell Updates Per Frame** | Set the number of cells, bricks, and probe positions to update per frame. Higher values might make the Editor slower. The default value is 4. This property appears only if you enable **Live Subdivision Preview**. |
| **Live Subdivision Preview** | **Update Frequency** | Set how frequently Unity updates cell, bricks, and probe positions, in seconds. The default value is 1. This property appears only if you enable **Live Subdivision Preview**. |
| **Debug Draw Distance** | N/A | Set how far from the scene camera Unity draws debug visuals for cells and bricks, in meters. The default value is 500. |

### Probe Visualization

<table>
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<thead>
<tr>
<th><strong>Property</strong></th>
<th><strong>Sub-property</strong></th>
<th><strong>Description</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>Display Probes</strong></td>
<td>N/A</td>
<td>Display probes.</td>
</tr>
<tr>
<td><strong>Display Probes</strong></td>
<td><strong>Probe Shading Mode</strong></td>
<td>Set what the Rendering Debugger displays. The options are:
<ul>
<li><strong>SH</strong>: Display the <a href="https://docs.unity3d.com/Manual/LightProbes-TechnicalInformation.html">spherical harmonics (SH) lighting data</a> for the final color calculation. The number of bands depends on the <strong>SH Bands</strong> setting in the active <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html">HDRP Asset</a>.</li>
<li><strong>SHL0</strong>: Display the spherical harmonics (SH) lighting data with only the first band.</li>
<li><strong>SHL0L1</strong>: Display the spherical Harmonics (SH) lighting data with the first two bands.</li>
<li><strong>Validity</strong>: Display whether probes are valid, based on the number of backfaces the probe samples. Refer to <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/probevolumes-fixissues.html">Fix issues with Adaptive Probe Volumes</a> for more information about probe validity.</li>
<li><strong>Probe Validity Over Dilation Threshold</strong>: Display red if a probe samples too many backfaces, based on the <strong>Validity Threshold</strong> set in the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/probevolumes-lighting-panel-reference.html">Adaptive Probe Volumes panel</a>. This means the probe can't be baked or sampled.</li>
<li><strong>Invalidated By Adjustment Volumes</strong>: Display probes that a <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/probevolumes-adjustment-volume-component-reference.html">Probe Adjustment Volume component</a> has made invalid.</li>
<li><strong>Size</strong>: Display a different color for each size of <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/probevolumes-concept.html">brick</a>.</li>
<li><strong>Sky Occlusion SH</strong>: If you enable <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/probevolumes-skyocclusion.html">sky occlusion</a>, this setting displays the amount of indirect light the probe receives from the sky that bounced off static GameObjects. The value is a scalar, so it displays as a shade of gray.</li>
<li><strong>Sky Direction</strong>: Display a green circle that represents the direction from the probe to the sky. This setting displays a red circle if Unity can't calculate the direction, or <strong>Sky Direction</strong> in the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/probevolumes-lighting-panel-reference">Adaptive Probe Volumes panel</a> is disabled.</li>
<li><strong>Probe Occlusion</strong>: Displays whether probes are affected by lights that have their <a href="https://docs.unity3d.com/Manual/LightModes-choose">Light Mode</a> set to <strong>Mixed</strong>, if you set <a href="https://docs.unity3d.com/Manual/lighting-mode">Lighting Mode</a> to Shadowmask. Each probe displays up to four overlapping lights.</li>
</ul></td>
</tr>
<tr>
<td><strong>Display Probes</strong></td>
<td><strong>Debug Size</strong></td>
<td>Set the size of the displayed probes. The default is 0.3.</td>
</tr>
<tr>
<td><strong>Display Probes</strong></td>
<td><strong>Exposure Compensation</strong></td>
<td>Set the brightness of the displayed probes. Decrease the value to increase brightness. The default is 0. This property appears only if you set <strong>Probe Shading Mode</strong> to <strong>SH</strong>, <strong>SHL0</strong>, or <strong>SHL0L1</strong>.</td>
</tr>
<tr>
<td><strong>Display Probes</strong></td>
<td><strong>Max Subdivisions Displayed</strong></td>
<td>Set the lowest probe density to display. For example, set this to 0 to display only the highest probe density.</td>
</tr>
<tr>
<td><strong>Display Probes</strong></td>
<td><strong>Min Subdivisions Displayed</strong></td>
<td>Set the highest probe density to display.</td>
</tr>
<tr>
<td><strong>Debug Probe Sampling</strong></td>
<td>N/A</td>
<td>Display how probes are sampled for a pixel. In the Scene view, in the <strong>Adaptive Probe Volumes</strong> overlay, select <strong>Select Pixel</strong> to change the pixel.</td>
</tr>
<tr>
<td><strong>Debug Probe Sampling</strong></td>
<td><strong>Debug Size</strong></td>
<td>Set the size of the <strong>Debug Probe Sampling</strong> display.</td>
</tr>
<tr>
<td><strong>Debug Probe Sampling</strong></td>
<td><strong>Debug With Sampling Noise</strong></td>
<td>Enable sampling noise for this debug view. Enabling this gives more accurate information, but makes the information more difficult to read.</td>
</tr>
<tr>
<td><strong>Virtual Offset Debug</strong></td>
<td>N/A</td>
<td>Display the offsets Unity applies to Light Probe capture positions.</td>
</tr>
<tr>
<td><strong>Virtual Offset Debug</strong></td>
<td><strong>Debug Size</strong></td>
<td>Set the size of the arrows that represent Virtual Offset values.</td>
</tr>
<tr>
<td><strong>Debug Draw Distance</strong></td>
<td>N/A</td>
<td>Set how far from the scene camera Unity draws debug visuals for cells and bricks, in meters. The default is 200.</td>
</tr>
<tr>
<td><strong>Auto Display Probes</strong></td>
<td>N/A</td>
<td>Display probes in the Scene view, if you select a volume with a Probe Adjustment Volume component in the Hierarchy window.</td>
</tr>
<tr>
<td><strong>Isolate Affected</strong></td>
<td>N/A</td>
<td>Display only probes affected by a volume with a Probe Adjustment Volume component, if you select the volume in the Hierarchy window.</td>
</tr>
</tbody>
</table>

### Streaming

Use the following properties to control how HDRP streams Adaptive Probe Volumes. Refer to [Streaming Adaptive Probe Volumes](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/probevolumes-streaming.html) for more information.

| **Property** | **Description** |
|----|----|
| **Freeze Streaming** | Stop Unity from streaming probe data. |
| **Display Streaming Score** | If you enable **Display Cells**, this setting darkens cells that have a lower priority for streaming. Cells closer to the camera usually have the highest priority. |
| **Maximum cell streaming** | Stream as many cells as possible every frame. |
| **Display Index Fragmentation** | Open an overlay that displays how fragmented the streaming memory is. A green square is an area of used memory. The more spaces between the green squares, the more fragmented the memory. |
| **Index Fragmentation Rate** | Displays the amount of fragmentation as a numerical value, where 0 is no fragmentation. |
| **Verbose Log** | Log information about streaming. |

### Scenario Blending

Use the following properties to control how HDRP blends Lighting Scenarios. Refer to [Bake different lighting setups with Lighting Scenarios](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/probevolumes-bakedifferentlightingsetups.html) for more information.

| **Property** | **Description** |
|----|----|
| **Number of Cells Blended Per Frame** | Determines the maximum number of cells Unity blends per frame. The default is 10,000. |
| **Turnover Rate** | Set the blending priority of cells close to the camera. The range is 0 to 1, where 0 sets the cells close to the camera with high priority, and 1 sets all cells with equal priority. Increase **Turnover Rate** to avoid cells close to the camera blending too frequently. |
| **Scenario To Blend With** | Select a Lighting Scenario to blend with the active Lighting Scenario. |
| **Scenario Blending Factor** | Set how far to blend from the active Lighting Scenario to the **Scenario To Blend With**. The range is 0 to 1, where 0 is fully the active Lighting Scenario, and 1 is fully the **Scenario To Blend With**. |

<span id="RenderingPanel"></span>

## Rendering panel

The **Rendering** panel has tools that you can use to visualize various HDRP rendering features.

### Fullscreen Debug Mode

Use the drop-down to select a rendering mode to display as an overlay on the screen.

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
<td><strong>Motion Vectors</strong></td>
<td>Select this option to display motion vectors. Note that object motion vectors aren't visible in the Scene view.</td>
</tr>
<tr>
<td><strong>World Space Position</strong></td>
<td>Select this option to display world space positions.</td>
</tr>
<tr>
<td><strong>NaN Tracker</strong></td>
<td>Select this option to display an overlay that highlights <a href="https://en.wikipedia.org/wiki/NaN">NaN</a> values.</td>
</tr>
<tr>
<td><strong>ColorLog</strong></td>
<td>Select this option to display how the raw, log-encoded buffer looks before color grading takes place.</td>
</tr>
<tr>
<td><strong>DepthOfFieldCoc</strong></td>
<td>Select this option to display the circle of confusion for the depth of field effect. The circle of confusion displays how much the depth of field effect blurs a given pixel/area.</td>
</tr>
<tr>
<td><strong>Quad Overdraw</strong></td>
<td>Select this option to display an overlay that highlights gpu quads running multiple fragment shaders. This is mainly caused by small or thin triangles. Use LODs to reduce the amount of overdraw when objects are far away. (This mode is currently not supported on Metal and PS4).</td>
</tr>
<tr>
<td><strong>Vertex Density</strong></td>
<td>Select this option to display an overlay that highlights pixels running multiple vertex shaders. A vertex can be run multiple times when part of different triangles. This helps finding models that need LODs. (This mode is currently not supported on Metal).</td>
</tr>
<tr>
<td><strong>TransparencyOverdraw</strong></td>
<td>Select this option to view the number of transparent pixels that draw over one another. This represents the amount of on-screen overlapping of transparent pixel. This is useful to see the amount of pixel overdraw for transparent GameObjects from different points of view in the Scene. This debug option displays each pixel as a heat map going from black (which represents no transparent pixels) through blue to red (at which there are <strong>Max Pixel Cost</strong> number of transparent pixels).</td>
</tr>
<tr>
<td><strong>RequestedVirtualTextureTiles</strong></td>
<td>Select this option to display what texture tile each pixel uses. Pixels that this debug view renders with the same color request the same texture tile to be streamed into video memory by the streaming virtual texturing system. This debug view is useful to see which areas of the screen use textures that the virtual texturing system steams into video memory. It can help to identify issues with the virtual texture streaming system.</td>
</tr>
<tr>
<td><strong>LensFlareScreenSpace</strong></td>
<td>Display the lens flares that the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/shared/lens-flare/Override-Screen-Space-Lens-Flare.html">Screen Space Lens Flare</a> override generates.</td>
</tr>
<tr>
<td><strong>Compute Thickness</strong></td>
<td>Select this option to display thickness for each layer selected in the current HDRP Asset and configure the following properties:
<ul>
<li><strong>Layer Mask:</strong> Set the layer number to visualize in the debug view.</li>
<li><strong>Show Overlap Count:</strong> Highlight the triangles that intersect for each pixel.</li>
<li><strong>Thickness Scale:</strong> Set the range (in meters) of the Compute Thickness debug view. When you enable <strong>Show Overlap Count</strong>, this setting affects the Overlap Count debug view.</li>
<li>For more information on how to debug compute thickness, refer to <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Compute-Thickness.html">Sample and use material thickness</a>.</li>
</ul></td>
</tr>
<tr>
<td><strong>Max Pixel Cost</strong></td>
<td>The scale of the transparency overdraw heat map. For example, a value of 10 displays a red pixel if 10 transparent pixels overlap. Any number of overdraw above this value also displays as red. This property only appears if you set <strong>Fullscreen Debug Mode</strong> to <strong>TransparencyOverdraw</strong>.</td>
</tr>
<tr>
<td><strong>High Quality Lines</strong></td>
<td>Select this option to view underlying data used by tile-based software rasterizer for the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Override-High-Quality-Lines.html">High Quality Line Rendering</a> feature.
<ul>
<li><strong>Segments per Tile</strong> displays a heatmap representing the number of segments in each tile.</li>
<li><strong>Tile Processor UV</strong> displays the uv coordinate for each tile.</li>
<li><strong>Cluster Depth</strong> displays segments based on their depth in the cluster structure that's used for transparent sorting.</li>
</ul></td>
</tr>
</tbody>
</table>

### Mipmap Streaming

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
<td><strong>Disable Mip Caching</strong></td>
<td>If you enable <strong>Disable Mip Caching</strong>, Unity doesn't cache mipmap levels in GPU memory, and constantly discards mipmap levels from GPU memory when they're no longer needed. This means the mipmap streaming debug views more accurately display which mipmap levels Unity uses at the current time. Enabling this setting increases the amount of data Unity transfers from disk to the CPU and the GPU.</td>
</tr>
<tr>
<td><strong>Debug View</strong></td>
<td>Set a mipmap streaming debug view. Options:
<ul>
<li><strong>None</strong>: Display the normal view.</li>
<li><strong>Mip Streaming Performance</strong>: Use color to indicate which textures use mipmap streaming, and whether mipmap streaming limits the number of mipmap levels Unity loads.</li>
<li><strong>Mip Streaming Status</strong>: Use color on materials to indicate whether their textures use mipmap streaming. Diagonal stripes mean some of the textures use a <a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Texture2D-requestedMipmapLevel.html"><code>requestedMipmapLevel</code></a> that overrides mipmap streaming. Yellow means Unity can't stream the texture, or the texture is assigned to terrain.</li>
<li><strong>Mip Streaming Activity</strong>: Use color to indicate whether Unity recently streamed the textures.</li>
<li><strong>Mip Streaming Priority</strong>: Use color to indicate the streaming priority of the textures. Set streaming priority for a texture in the <a href="https://docs.unity3d.com/6000.0/Documentation/Manual/class-TextureImporter.html"><strong>Texture Import Settings</strong> window</a>.</li>
<li><strong>Mip Count</strong>: Display the number of mipmap levels Unity loads for the textures.</li>
<li><strong>Mip Ratio</strong>: Use color to indicate the pixel density of the highest-resolution mipmap levels Unity uploads for the textures.</li>
</ul></td>
</tr>
<tr>
<td><strong>Debug Opacity</strong></td>
<td>Set the opacity of the <strong>Debug View</strong> you select. 0 means not visible and 1 means fully visible. This property is visible only if <strong>Debug View</strong> is not set to <strong>None</strong>.</td>
</tr>
<tr>
<td><strong>Combined Per Material</strong></td>
<td>Set the <strong>Debug View</strong> to display debug information of all the textures on a material, not individual texture slots. This property is only visible if <strong>Debug View</strong> is set to <strong>Mip Streaming Status</strong> or <strong>Mip Streaming Activity</strong>.</td>
</tr>
<tr>
<td><strong>Material Texture Slot</strong></td>
<td>Set which texture Unity uses from each material to display debug information. For example, set <strong>Material Texture Slot</strong> to <strong>Slot 3</strong> to display debug information for the fourth texture. If a material has fewer textures than the <strong>Material Texture Slot</strong> value, Unity uses no texture. This property is visible only if <strong>Combined Per Material</strong> is disabled, and <strong>Debug View</strong> is not set to <strong>None</strong>.</td>
</tr>
<tr>
<td><strong>Display Status Codes</strong></td>
<td>Display more detailed statuses for textures that display as <strong>Not streaming</strong> or <strong>Warning</strong> in the <strong>Mip Streaming Status</strong> debug view. This property is visible only if <strong>Debug View</strong> is set to <strong>Mip Streaming Status</strong>.</td>
</tr>
<tr>
<td><strong>Activity Timespan</strong></td>
<td>Set how long a texture displays as <strong>Just streamed</strong>, in seconds. This property is visible only if <strong>Debug View</strong> is set to <strong>Mip Streaming Activity</strong>.</td>
</tr>
<tr>
<td><strong>Terrain Texture</strong></td>
<td>Set which terrain texture Unity displays. You can select either <strong>Control</strong> for the control texture, or one of the diffuse textures. This property is visible only if <strong>Debug View</strong> is not set to <strong>None</strong>.</td>
</tr>
</tbody>
</table>

### Color Picker

The **Color Picker** works with whichever debug mode HDRP displays at the time. This means that you can see the values of various components of the rendering like Albedo or Diffuse Lighting. By default, this displays the value of the main High Dynamic Range (HDR) color buffer.

| **Property** | **Description** |
|----|----|
| **Debug Mode** | Use the drop-down to select the format of the color picker display. |
| **Font Color** | Use the color picker to select a color for the font that the Color Picker uses for its display. |

### False Color Mode and Freeze Camera For Culling

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
<td><strong>False Color Mode</strong></td>
<td>Enable the checkbox to define intensity ranges that the debugger uses to display a color temperature gradient for the current frame. The color temperature gradient goes from blue, to green, to yellow, to red.
<ul>
<li><strong>Range Threshold 0:</strong> Set the first split for the intensity range. This property only appears when you enable the <strong>False Color Mode</strong> checkbox.</li>
<li><strong>Range Threshold 1:</strong> Set the second split for the intensity range. This property only appears when you enable the <strong>False Color Mode</strong> checkbox.</li>
<li><strong>Range Threshold 2:</strong> Set the third split for the intensity range. This property only appears when you enable the <strong>False Color Mode</strong> checkbox.</li>
<li><strong>Range Threshold 3:</strong> Set the final split for the intensity range. This property only appears when you enable the <strong>False Color Mode</strong> checkbox.</li>
</ul></td>
</tr>
<tr>
<td><strong>MSAA Samples</strong></td>
<td>Use the drop-down to select the number of samples the debugger uses for MSAA.</td>
</tr>
<tr>
<td><strong>Freeze Camera for Culling</strong></td>
<td>Use the drop-down to select a Camera to freeze to check its culling. To check if the Camera's culling works correctly, freeze the Camera and move occluders around it.</td>
</tr>
</tbody>
</table>

### Color Monitors

The **Color monitors** are a set of industry-standard monitors to help artists control the overall look and exposure of a scene.

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
<td><strong>Waveform</strong></td>
<td>Displays the full range of luma (brightness) information in the Camera’s output. The horizontal axis of the graph corresponds to the render (from left to right) and the vertical axis indicates the brightness value.</td>
</tr>
<tr>
<td><strong>Exposure</strong></td>
<td>Determines the exposure multiplier HDRP applies to the waveform values. This property only appears when you enable the <strong>Waveform</strong> checkbox.</td>
</tr>
<tr>
<td><strong>Parade mode</strong></td>
<td>Splits the image into red, green and blue separately. You can use this to visualise the RGB balance of the Camera's image. This helps you to see large offsets in one particular channel, or to determine if GameObjects are true black or true white. A true black, white, or grey GameObject has equal values across all channels. This property only appears when you enable the <strong>Waveform</strong> checkbox.</td>
</tr>
<tr>
<td><strong>Vectorscope</strong></td>
<td>The Vectorscope monitor measures the overall range of hue and saturation within the Camera’s image in real-time. To display the data, it uses a scatter graph relative to the center of the Vectorscope. The Vectorscope measures hue values between yellow, red, magenta, blue, cyan and green. The center of the Vectorscope represents absolute zero saturation and the edges represent the highest level of saturation. To determine the hues in your scene and their saturation, look at the distribution of the Vectorscope’s scatter graph.<br />
To identify whether there is a color imbalance in the image, look at how close the middle of the Vectorscope graph is to the absolute center. If the Vectorscope graph is off-center, this indicates that there is a color cast (tint) in the image.</td>
</tr>
<tr>
<td><strong>Exposure</strong></td>
<td>Determines the exposure multiplier HDRP applies to the vectorscope values. This property only appears when you enable the <strong>Vectorscope</strong> checkbox.</td>
</tr>
<tr>
<td><strong>Size</strong></td>
<td>The size ratio of the color monitors.</td>
</tr>
</tbody>
</table>

<span id="render-graph"></span>

### Render Graph

| **Property** | **Description** |
|----|----|
| **Clear Render Targets At Creation** | Clears render textures the first time the render graph system uses them. |
| **Clear Render Targets When Freed** | Clears render textures when they're no longer used by render graph. |
| **Disable Pass Culling** | Disables HDRP culling render passes that have no impact on the final render. |
| **Disable Pass Merging** | Disables HDRP merging render passes. |
| **Immediate Mode** | Enables the render graph system evaluating passes immediately after it creates them. |
| **Enable Logging** | Enables logging to the **Console** window. |
| **Log Frame Information** | Logs how HDRP uses the resources during the frame, in the **Console** window. |
| **Log Resources** | Logs the resources HDRP uses during the frame, in the **Console** window. |

The **NVIDIA device debug view** is a panel that displays a list of the current feature states of NVIDIA Deep Learning Super Sampling (DLSS). Each row represents an active screen in which DLSS is running.

| **Information** | **Description** |
|----|----|
| **NVUnityPlugin Version** | Displays the current internal version id of the NVIDIA Unity Plugin that interacts with DLSS. |
| **NGX API Version** | Displays the actual version which DLSS operates on. |
| **Device Status** | Displays the current status of the NVIDIA driver. If an internal error occurred when initializing the driver, Unity displays the error here. |
| **DLSS Supported** | Displays **True** if your project supports DLSS at runtime. Otherwise, displays **False**. |
| **DLSS Slot ID** | Displays an internal ID for the particular DLSS view being displayed. |
| **Status** | Displays whether the view is **valid** or **invalid**. A view is invalid if there is an internal error, or if the Scriptable Render Pipeline passes incorrect parameters. |
| **Input resolution** | Displays the current input resolution. Unity calculates this from the screen percentage specified for dynamic resolution scaling. |
| **Output resolution** | Displays the target resolution for this particular DLSS view. |
| **Quality** | Displays the quality selected for this particular DLSS view. |
| **Render Preset** | Displays the render preset selected for the currently active quality mode for this particular DLSS view. |

The **History Buffers view** lets you display various render pipeline full screen buffers that persist across multiple frames.

| **Property** | **Description** |
|----|----|
| **Buffer** | Choose the history buffer to visualize as a full screen output. |
| **Frame Index** | Choose what frame version of the history buffer to visualize. Certain buffers only have a limited number of versions. |
| **Apply Exposure** | Enable exposure correction of the buffer. It is only available for certain history buffers. |

<span id="CameraPanel"></span>

## Camera panels

In the **Rendering Debugger**, each active Camera in the Scene has its own debug window. Use the Camera's debug window to temporarily change that Camera's [Frame Settings](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Frame-Settings.html) without altering the Camera data in the Scene. The Camera window helps you to understand why a specific feature doesn't work correctly. You can access all the information that HDRP uses the render the Camera you select.

**Note**: The Camera debug window is only available for Cameras, not Reflection Probes.

The following columns are available for each Frame Setting:

| **Column** | **Description** |
|----|----|
| **Debug** | Displays Frame Setting values you can modify for the selected Camera. You can use these to temporarily alter the Camera’s Frame Settings for debugging purposes. You can't enable Frame Setting features that your HDRP Asset doesn't support. |
| **Sanitized** | Displays the Frame Setting values that the selected Camera uses after Unity checks to see if your HDRP Asset supports them. |
| **Overridden** | Displays the Frame Setting values that the selected Camera overrides. If you don't check the **Custom Frame Settings** checkbox, check it and don't override any settings, this column is identical to the **Default** column. |
| **Default** | Displays the default Frame Setting values in your current [HDRP Asset](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html). |

Unity processes **Sanitized**, **Overridden**, and **Default** in a specific order:

1.  It checks the **Default** Frame Settings
2.  It checks the selected Camera’s **Overridden** Frame Settings.
3.  It checks whether the HDRP Asset supports the selected Camera’s Frame Settings
4.  It displays that result in the **Sanitized** column.

### Interpreting the Camera window

![In this screenshot of the Camera window, Ray Tracing is enabled in the Camera's Frame Settings but disabled in the HDRP Asset, while Decals is enabled by default but disabled in the Camera's Custom Frame Settings.](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/RenderPipelineDebug2.png)

- In the image above, **Ray Tracing** is disabled at the **Sanitized** step, but enabled at the **Default** and **Overridden** steps. This means that, although **Ray Tracing** is enabled in the Frame Settings this Camera uses, it's not enabled in the HDRP Asset’s **Render Pipeline Supported Features**.
- Also in the image above, **Decals** is disabled at the **Overridden** step, but enabled at the **Default** step. This means that **Decals** is enabled in the default Camera Frame Settings but disabled for that specific Camera’s **Custom Frame Settings**.

<span id="VirtualTexturingPanel"></span>

## Virtual Texturing panel

You can use the **Virtual Texturing** panel to visualize [Streaming Virtual Texturing](https://docs.unity3d.com/Manual/svt-streaming-virtual-texturing.html).

| **Property** | **Description** |
|----|----|
| **Debug disable Feedback Streaming** | Deactivate Streaming Virtual Texturing to quickly assess its cost in performance and memory at runtime. |
| **Textures with Preloaded Mips** | Display the total number of virtual textures Unity has loaded into the scene. Unity tries to preload the least detailed mipmap level (least being 128x128) into GPU memory. This number increases every time a material is loaded. |

<span id="GPUResidentDrawer"></span>

## GPU Resident Drawer

The properties in this section let you visualize settings that [reduce rendering work on the CPU](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/reduce-rendering-work-on-cpu.html).

### Occlusion Culling

| **Property** | **Sub-property** | **Description** |
|----|----|----|
| **Occlusion Test Overlay** | N/A | Display a heatmap of culled instances. The heatmap displays blue if there are few culled instances, through to red if there are many culled instances. If you enable this setting, culling might be slower. |
| **Occlusion Test Overlay Count Visible** | N/A | Display a heatmap of instances that Unity doesn't cull. The heatmap displays blue if there are many culled instances, through to red if there are few culled instances. This setting only has an effect if you enable **Occlusion Test Overlay**. |
| **Override Occlusion Test To Always Pass** | N/A | Set occluded objects as unoccluded. This setting affects both the Rendering Debugger and the scene. |
| **Occluder Context Stats** | N/A | Display the [**Occlusion Context Stats**](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/rendering-debugger-window-reference.html#occlusion-context-stats) section. |
| **Occluder Debug View** | N/A | Display an overlay with the occlusion textures and mipmaps Unity generates. |
| **Occluder Debug View** | **Occluder Debug View Index** | Set the occlusion texture to display. |
| **Occluder Debug View** | **Occluder Debug View Range Min** | Set the brightness of the minimum depth value. Increase this value to brighten objects that are far away from the view. |
| **Occluder Debug View** | **Occluder Debug View Range Max** | Set the brightness of the maximum depth value. Decrease this value to darken objects that are close to the view. |

![The Rendering Debugger with Occlusion Test Overlay enabled. The red areas are where Unity culls many objects. The blue area is where Unity culls few objects.](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/renderingdebugger-gpuculling-heatmap.jpg)

The Rendering Debugger with **Occlusion Test Overlay** enabled. The red areas are where Unity culls many objects. The blue area is where Unity culls few objects.

![The Rendering Debugger with Occluder Debug View enabled. The overlay displays each mipmap level of the occlusion texture.](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/renderingdebugger-gpuculling-overlay.jpg)

The Rendering Debugger with **Occluder Debug View** enabled. The overlay displays each mipmap level of the occlusion texture.

### Occlusion Context Stats

The **Occlusion Context Stats** section lists the occlusion textures Unity generates.

| **Property** | **Description** |
|----|----|
| **Active Occlusion Contexts** | The number of occlusion textures. |
| **View Instance ID** | The instance ID of the camera Unity renders the view from, to create the occlusion texture. |
| **Subview Count** | The number of subviews. The value might be 2 or more if you use XR. |
| **Size Per Subview** | The size of the subview texture in bytes. |

### GPU Resident Drawer Settings

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
</colgroup>
<thead>
<tr>
<th><strong>Section</strong></th>
<th><strong>Property</strong></th>
<th><strong>Sub-property</strong></th>
<th><strong>Description</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>Display Culling Stats</strong></td>
<td>N/A</td>
<td>N/A</td>
<td>Display information about the cameras Unity uses to create occlusion textures.</td>
</tr>
<tr>
<td><strong>Instance Culler Stats</strong></td>
<td>N/A</td>
<td>N/A</td>
<td></td>
</tr>
<tr>
<td><strong>Instance Culler Stats</strong></td>
<td><strong>View Count</strong></td>
<td>N/A</td>
<td>The number of views Unity uses for GPU culling. Unity uses one view per shadow cascade or shadow map. For example, Unity uses three views for a Directional Light that generates three shadow cascades.</td>
</tr>
<tr>
<td><strong>Instance Culler Stats</strong></td>
<td><strong>Per View Stats</strong></td>
<td>N/A</td>
<td></td>
</tr>
<tr>
<td><strong>Instance Culler Stats</strong></td>
<td>N/A</td>
<td><strong>View Type</strong></td>
<td>The object or shadow split Unity renders the view from.</td>
</tr>
<tr>
<td><strong>Instance Culler Stats</strong></td>
<td>N/A</td>
<td><strong>View Instance ID</strong></td>
<td>The instance ID of the camera or light Unity renders the view from.</td>
</tr>
<tr>
<td><strong>Instance Culler Stats</strong></td>
<td>N/A</td>
<td><strong>Split Index</strong></td>
<td>The shadow split index value. This value is 0 if the object doesn't have shadow splits.</td>
</tr>
<tr>
<td><strong>Instance Culler Stats</strong></td>
<td>N/A</td>
<td><strong>Visible Instances</strong></td>
<td>How many objects are visible in this split.</td>
</tr>
<tr>
<td><strong>Instance Culler Stats</strong></td>
<td>N/A</td>
<td><strong>Draw Commands</strong></td>
<td>How many draw commands Unity uses for this split.</td>
</tr>
<tr>
<td><strong>Occlusion Culling Events</strong></td>
<td>N/A</td>
<td>N/A</td>
<td></td>
</tr>
<tr>
<td><strong>Occlusion Culling Events</strong></td>
<td><strong>View Instance ID</strong></td>
<td>N/A</td>
<td>The instance ID of the camera Unity renders the view from.</td>
</tr>
<tr>
<td><strong>Occlusion Culling Events</strong></td>
<td><strong>Event type</strong></td>
<td>N/A</td>
<td>The type of render pass.
<ul>
<li><strong>OccluderUpdate</strong>
The GPU samples the depth buffer and creates a new occlusion texture and its mipmap.</li>
<li><strong>OcclusionTest</strong>
The GPU tests all the instances against the occlusion texture.</li>
</ul></td>
</tr>
<tr>
<td><strong>Occlusion Culling Events</strong></td>
<td><strong>Occluder Version</strong></td>
<td>N/A</td>
<td>How many times Unity updates the occlusion texture in this frame.</td>
</tr>
<tr>
<td><strong>Occlusion Culling Events</strong></td>
<td><strong>Subview Mask</strong></td>
<td>N/A</td>
<td>A bitmask that represents which subviews are affected in this frame.</td>
</tr>
<tr>
<td><strong>Occlusion Culling Events</strong></td>
<td><strong>Occlusion Test</strong></td>
<td>N/A</td>
<td>Which test the GPU runs against the occlusion texture.
<ul>
<li><strong>TestNone</strong>
Unity found no occluders, so all instances are visible.</li>
<li><strong>TestAll</strong>: Unity tests all instances against the occlusion texture.</li>
<li><strong>TestCulled</strong>: Unity tests only instances that the previous <strong>TestAll</strong> test culled.</li>
</ul></td>
</tr>
<tr>
<td><strong>Occlusion Culling Events</strong></td>
<td><strong>Visible Instances</strong></td>
<td>N/A</td>
<td>The number of visible instances after occlusion culling.</td>
</tr>
<tr>
<td><strong>Occlusion Culling Events</strong></td>
<td><strong>Culled Instances</strong></td>
<td>N/A</td>
<td>The number of culled instances after occlusion culling.</td>
</tr>
</tbody>
</table>
