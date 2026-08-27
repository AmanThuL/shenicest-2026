---
title: "Custom Pass reference"
page_title: "Custom Pass reference | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/custom-pass-reference.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/custom-pass-reference.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Custom Pass reference

## Custom Pass Volume component properties

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
<td>Mode</td>
<td>Use the drop-down to select the method that Unity uses to determine whether this Custom Pass Volume can affect a Camera:<br />
• <strong>Global</strong>: The Custom Pass Volume has no boundaries, and it can affect every Camera in the scene.<br />
• <strong>Local</strong>: Allows you to specify boundaries for the Custom Pass Volume so that it only affects Cameras inside the boundaries. To set the boundaries, add a <a href="https://docs.unity3d.com/Manual/CollidersOverview.html">Collider</a> to the Custom Pass Volume's GameObject.</td>
</tr>
<tr>
<td>Injection point</td>
<td>Use the drop-down to define when Unity executes this Custom Pass in the HDRP render loop.<br />
<br />
For more information about each injection point, see [<strong>Injection Points</strong>](#Injection Points.md)</td>
</tr>
<tr>
<td>Priority</td>
<td>If you have more than one Custom Pass Volume assigned to the same injection point, use this property to control the order that Unity executes them in.<br />
<br />
Unity executes these Volumes in order of Priority, starting with 0.</td>
</tr>
<tr>
<td>Fade Radius</td>
<td>Defines when Unity starts to fade in the effect of the Custom Pass as you approach the Volume.<br />
A value of 0 means HDRP applies this Volume’s effect immediately at the edge of the Volume. A high value means the effect starts to appear far away from the Volume.<br />
<br />
This property only appears when <strong>Mode</strong> is set to <strong>Local</strong>.</td>
</tr>
<tr>
<td>Custom Passes</td>
<td>Click the Add (<strong>+</strong>) button to create a Custom Pass. The Custom Pass Volume component includes the following types of Custom Passes by default:<br />
<strong>• FullScreen Custom Pass</strong>: Use this to execute an effect that Unity applies to the Camera view or stores in the Custom Pass buffer. For more information, see <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/custom-pass-create-gameobject.html#Full-Screen-Custom-Pass">Full-screen Custom Pass</a>.<br />
<strong>• DrawRenderers Custom Pass</strong>: Use this to apply a Custom Pass to GameObjects that are in the Camera view. For more information, see <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/custom-pass-create-gameobject.html#Draw-Renderers-Custom-Pass">Draw renderers custom pass</a>.<br />
<br />
• <strong>ObjectID Custom Pass</strong>: Use this to apply a unique color controlled by the Object ID to GameObjects in your scene. For more information, see <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/custom-pass-create-gameobject.html#object-id-custom-pass">Object ID Custom Pass</a>.<br />
<br />
If you create your own Custom Pass, it also appears in this drop-down. For more information, see <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Custom-Pass-Scripting.html">Scripting your own Custom Pass in C#</a>.<br />
<br />
If there are one or more Custom Passes in this component, you can click <code>**-**</code> to delete one.</td>
</tr>
</tbody>
</table>

## FullScreenCustomPass properties

Configure a full-screen Custom Pass in the **Custom Passes** panel using the following properties:

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
<td>Name</td>
<td>Use this field to name this Custom Pass. Unity uses this name to refer to this Custom Pass Volume in the <a href="https://docs.unity3d.com/Manual/Profiler.html">Profiler</a>.</td>
</tr>
<tr>
<td>Target Color Buffer</td>
<td>Select the buffer that Unity writes the color data to:<br />
<strong>Camera:</strong> Targets the current camera color buffer that renders the Custom Pass.<br />
<strong>Custom:</strong> Uses the Custom Pass Buffer allocated in the HDRP asset.<br />
<strong>None:</strong> Doesn’t write the data to a buffer.<br />
<br />
You can't write color data to the Camera color buffer if you have <strong>Fetch Color Buffer</strong> enabled.<br />
<br />
When the Target Color Buffer and The Target Buffer are both set to <strong>None</strong> Unity does not execute a Custom Pass because there is no buffer to render to.</td>
</tr>
<tr>
<td>Target Depth Buffer</td>
<td>Select the buffer where Unity writes and tests the depth and stencil data.<br />
This buffer does not contain transparent objects that have <strong>Depth Write</strong> enabled in the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@latest?subfolder=/manual/Lit-Shader.html">shader properties</a>.<br />
<br />
When the Target Color Buffer and The Target Buffer are both set to <strong>None</strong> Unity does not execute a Custom Pass because there is no buffer to render to.</td>
</tr>
<tr>
<td>Clear Flags</td>
<td>A clear flag discards the contents of a buffer before Unity executes this Custom Pass.<br />
This property assigns a clear flag to one of the following buffers:<br />
<strong>None:</strong> Doesn’t clear any buffers in this pass.<br />
<strong>Color:</strong> Clears the depth buffer.<br />
<strong>Depth:</strong> Clears the depth buffer and the stencil buffer.<br />
<strong>All:</strong> Clears the data in the color, depth, and stencil buffers.</td>
</tr>
<tr>
<td>Fetch Color Buffer</td>
<td>Enable this checkbox to allow this Custom Pass to read data from the color buffer.<br />
This applies even when you enable <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@latest?subfolder=/manual/MSAA.html">Multisampling anti-aliasing (MSAA)</a>.<br />
<br />
When you enable<strong>Fetch Color Buffer</strong> and MSAA, it forces the color buffer to resolve, and the Custom Pass uses one of the following injection points:<br />
Before PreRefraction<br />
Before Transparent<br />
After Opaque Depth And Normal<br />
<br />
A Custom Pass can’t read and write to the same render target. This means that you can’t enable <strong>Fetch Color Buffer</strong> and use <strong>Target Color Buffer</strong> at the same time.</td>
</tr>
<tr>
<td>FullScreen Material</td>
<td>The material this Custom Pass renders in your scene. Use the <strong>New</strong> dropdown to create a new material and its associated shader from a template. The options are the following:
<ul>
<li><strong>ShaderGraph</strong>: Creates a new material or material variant from a new shader graph asset based on the <strong>Fullscreen Basic HDRP</strong> shader graph template, which uses the default <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@latest/index.html?subfolder=/manual/fullscreen-master-stack-reference.html"><strong>HDRP Fullscreen</strong> material type</a>.<br />
<strong>Note</strong>: To define if Unity creates a material or a material variant from the shader graph asset, refer to the <strong>Graph Template Workflow</strong> option in the <a href="https://docs.unity3d.com/Packages/com.unity.shadergraph@latest/index.html?subfolder=/manual/Shader-Graph-Preferences.html">Shader Graph Preferences</a>.</li>
<li><strong>Handwritten Shader</strong>: Creates a new handwritten shader using the HDRP fullscreen Custom Pass template.</li>
</ul></td>
</tr>
<tr>
<td>Pass Name</td>
<td>Select the shader <a href="https://docs.unity3d.com/Manual/SL-Pass.html">Pass name</a> that Unity uses to draw the full-screen quad.</td>
</tr>
</tbody>
</table>

## Draw renderers Custom Pass properties

Configure a draw renderers Custom Pass in the **Custom Passes** panel using the following properties:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
</colgroup>
<thead>
<tr>
<th><strong>Property</strong></th>
<th></th>
<th></th>
<th><strong>Description</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td>Name</td>
<td></td>
<td></td>
<td>Assigns a name to this Custom Pass. Unity uses this as the name of the profiling marker for debugging.</td>
</tr>
<tr>
<td>Target Color Buffer</td>
<td></td>
<td></td>
<td>Determines the buffer that Unity writes the color data to:<br />
<br />
•<strong>Camera:</strong> Targets the current camera color buffer that renders the Custom Pass.<br />
•<strong>Custom:</strong> Uses the Custom Pass buffer allocated in the HDRP Asset.<br />
•<strong>None:</strong> Doesn’t write the data to a buffer.</td>
</tr>
<tr>
<td>Target Depth Buffer</td>
<td></td>
<td></td>
<td>The target buffer where Unity writes and tests the depth and stencil data:<br />
<br />
•<strong>Camera:</strong> Targets the current camera depth buffer that renders the Custom Pass.<br />
•<strong>Custom:</strong> Uses the Custom Pass buffer allocated in the HDRP Asset.<br />
•<strong>None:</strong> Doesn’t write the data to a buffer.<br />
<br />
This buffer does not contain transparent objects that have <strong>Depth Write</strong> enabled in the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@10.2/manual/Lit-Shader.html">shader properties</a>.</td>
</tr>
<tr>
<td>Clear Flags</td>
<td></td>
<td></td>
<td>Discards the contents of a buffer before Unity executes this Custom Pass.<br />
Assign a clear flag to one of the following buffers:<br />
<br />
•<strong>None:</strong> Doesn’t clear any buffers in this pass.<br />
•<strong>Color:</strong> Clears the depth buffer.<br />
•<strong>Depth:</strong> Clears the depth buffer and the stencil buffer.<br />
•<strong>All:</strong> Clears the data in the color, depth and stencil buffers.</td>
</tr>
<tr>
<td>Filters</td>
<td></td>
<td></td>
<td>Properties in this section determine the GameObjects that Unity renders in this Custom Pass.</td>
</tr>
<tr>
<td></td>
<td>Queue</td>
<td></td>
<td>Determines the kind of materials that this Custom Pass renders:<br />
•<strong>Opaque No Alpha test</strong>: Opaque GameObjects without alpha test only.<br />
•**Opaque Alpha Test: **Opaque GameObjects with alpha test only.<br />
•<strong>All Opaque</strong>: All opaque GameObjects.<br />
•<strong>After Post Process Opaque</strong>: Opaque GameObjects that use the after post process render pass.<br />
•<strong>Pre Refraction</strong>: Transparent GameObjects that use the pre refraction render pass.<br />
•<strong>Transparent</strong>: Transparent GameObjects that use the default render pass.<br />
•<strong>Low Transparent</strong>: Transparent GameObjects that use the low resolution render pass.<br />
•<strong>All Transparent</strong>: All Transparent GameObjects.<br />
•<strong>All Transparent With Low Res</strong>: Transparent GameObjects that use the Pre-refraction, Default, or Low resolution render pass.<br />
•<strong>After Post Process Transparent</strong>: Transparent GameObjects that use after post process render pass.<br />
•<strong>Overlay</strong>: All GameObjects that use the overlay render pass.<br />
•<strong>All:</strong> All GameObjects.</td>
</tr>
<tr>
<td></td>
<td>Layer Mask</td>
<td></td>
<td>Determines the GameObject layer that this Custom Pass applies to.</td>
</tr>
<tr>
<td>Overrides</td>
<td></td>
<td></td>
<td></td>
</tr>
<tr>
<td></td>
<td>Override Mode</td>
<td></td>
<td>Determines what this Custom Pass volume uses to render GameObjects included in this Custom Pass:<br />
•<strong>Material</strong><br />
•<strong>Shader</strong><br />
•<strong>Pass Name</strong></td>
</tr>
<tr>
<td></td>
<td></td>
<td>Material</td>
<td>Determines the Material that this Custom Pass uses to override the Material and Material properties of every GameObject included in this Custom Pass.<br />
<br />
This property appears when you select the <strong>Material</strong> override mode.<br />
This field accepts an unlit Shader Graph, unlit HDRP Unity shader or lit shader. For a full list of compatible materials, see <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/custom-pass-create-gameobject.html#material-and-injection-point-compatibility">Material and injection point compatibility</a>.<br />
<br />
To create a Unity shader that is compatible with a draw renderers Custom Pass, navigate to <strong>Create &gt; Shader &gt; HDRP &gt; Custom Renderers Pass</strong> .</td>
</tr>
<tr>
<td></td>
<td></td>
<td>Shader</td>
<td>Determines the Shader that this Custom Pass uses to override the Materials of every GameObject included in this Custom Pass.<br />
<br />
This override keeps all the properties of the original Material and renders them with the Shader you assign. You can use this to sample Textures or other values from the Material this Custom Pass overrides.<br />
<br />
This property appears when you select the <strong>Shader</strong> override mode.<br />
<br />
This field accepts an unlit Shader Graph, unlit HDRP Unity shader or lit shader. For a full list of compatible materials, see <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/custom-pass-create-gameobject.html#material-and-injection-point-compatibility">Material and injection point compatibility</a>.<br />
<br />
To create a Unity shader that is compatible with a draw renderers Custom Pass, navigate to <strong>Create &gt; Shader &gt; HDRP &gt; Custom Renderers Pass</strong> .</td>
</tr>
<tr>
<td></td>
<td></td>
<td>Pass Name</td>
<td>Determines the Custom Pass that Unity uses to draw the full-screen quad. You can use this to switch between multiple Custom Pass effects.<br />
This field appears when you assign a material to the <strong>Material</strong> or <strong>Shader</strong> field. The drop-down options for this field change depending on the material or shader you assign.<br />
<br />
</td>
</tr>
<tr>
<td></td>
<td>Override Depth</td>
<td></td>
<td>Enable this checkbox to override the depth render state in the materials of the rendered GameObjects.<br />
<br />
This allows you to replace the default <strong>Depth Test</strong> value, and write the depth using custom values.</td>
</tr>
<tr>
<td></td>
<td></td>
<td>Depth Test</td>
<td>When Unity renders a GameObject, it uses the <strong>Depth Test</strong> value to check if it is behind another object. To do this, Unity tests the z-value (the depth) of a given GameObject’s pixel, and compares it against a value stored in the depth buffer.<br />
By default, <strong>Depth Test</strong> is set to <strong>Less Equal</strong>, allowing the original object to appear in front of the object it is tested against. Use the drop-down to select the comparison method to use for the depth test. Each comparison method changes how the Shader renders:<br />
<br />
•<strong>Disabled</strong>: Do not perform a depth test.<br />
•<strong>Never</strong>: The depth test never passes.<br />
•<strong>Less</strong>: The depth test passes if the pixel's z-value is less than the stored value.<br />
•<strong>Equal</strong>: The depth test passes if the pixel's z-value is equal to the stored value.<br />
•<strong>Less Equa</strong>l: The depth test passes if the pixel's z-value is less than or equal than the Z-buffers value. This renders the tested pixel in front of the other.<br />
•<strong>Greater</strong>: The depth test passes if the pixel's z-value is greater than the stored value.<br />
•<strong>Not Equa</strong>l: The depth test passes if the pixel's z-value is not equal to the stored value.<br />
•<strong>Greater Equa</strong>l: The depth test passes if the pixel's z-value is greater than or equal to the stored value.<br />
•<strong>Always</strong>: The depth test always passes, there is no comparison to the stored value. This setting only appears when you enable <strong>Override Depth</strong>.</td>
</tr>
<tr>
<td></td>
<td></td>
<td>Write Depth</td>
<td>Instructs Unity to write depth values for GameObjects that use this material.<br />
Disable it if you do not want Unity to write depth values for each GameObject.</td>
</tr>
<tr>
<td></td>
<td>Override Stencil</td>
<td></td>
<td>Overrides the stencil operations of the Materials in this Custom Pass. Enable this property to control all stencil fields. For more information, see <a href="https://docs.unity3d.com/Manual/SL-Stencil.html">ShaderLab command: Stencil</a>.</td>
</tr>
<tr>
<td></td>
<td></td>
<td>Reference</td>
<td>Determines the stencil reference value this Custom Pass uses for all stencil operations.</td>
</tr>
<tr>
<td></td>
<td></td>
<td>Read mask</td>
<td>Determines which bits this Custom Pass can read during the stencil test.</td>
</tr>
<tr>
<td></td>
<td></td>
<td>Write mask</td>
<td>Determines which bits this Custom Pass can write to during the stencil test.</td>
</tr>
<tr>
<td></td>
<td></td>
<td>Comparison</td>
<td>Determines the comparison function this Custom Pass uses during the stencil test.</td>
</tr>
<tr>
<td></td>
<td></td>
<td>Pass</td>
<td>Determines the operation this Custom Pass executes if the stencil test succeeds.</td>
</tr>
<tr>
<td></td>
<td></td>
<td>Fail</td>
<td>Determines the operation this Custom Pass executes if the stencil test fails.</td>
</tr>
<tr>
<td></td>
<td></td>
<td>Depth Fail</td>
<td>Determines the operation this Custom Pass executes if the depth test fails. This option has no effect if the depth test is disabled.</td>
</tr>
<tr>
<td></td>
<td>Sorting</td>
<td></td>
<td>Determines how Unity sorts the GameObjects in your scene before it renders them.<br />
<br />
For more information, see <a href="https://docs.unity3d.com/ScriptReference/Rendering.SortingCriteria.html">Sorting criteria</a>.</td>
</tr>
</tbody>
</table>

## Object ID Custom Pass properties

Configure an Object ID Custom Pass in the **Custom Passes** panel using the following properties:

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
<td>Name</td>
<td>Use this field to name this Custom Pass. Unity uses this as the name of the profiling marker for debugging.</td>
</tr>
<tr>
<td>Target Color Buffer</td>
<td>Select the buffer that Unity writes the color data to:<br />
<br />
<strong>Camera:</strong> Targets the current camera color buffer that renders the Custom Pass.<br />
<strong>Custom:</strong> Uses the Custom Pass buffer allocated in the HDRP Asset.<br />
<strong>None:</strong> Doesn’t write the data to a buffer.</td>
</tr>
<tr>
<td>Target Depth Buffer</td>
<td>The target buffer where Unity writes and tests the depth and stencil data:<br />
<br />
•<strong>Camera:</strong> Targets the current camera depth buffer that renders the Custom Pass.<br />
•<strong>Custom:</strong> Uses the Custom Pass buffer allocated in the HDRP Asset.<br />
•<strong>None:</strong> Doesn’t write the data to a buffer.<br />
<br />
This buffer does not contain transparent objects that have <strong>Depth Write</strong> enabled in the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@10.2/manual/Lit-Shader.html">shader properties</a>.</td>
</tr>
<tr>
<td>Clear Flags</td>
<td>A clear flag discards the contents of a buffer before Unity executes this Custom Pass.<br />
This property assigns a clear flag to one of the following buffers:<br />
<br />
•<strong>None:</strong> Doesn’t clear any buffers in this pass.<br />
•<strong>Color:</strong> Clears the depth buffer.<br />
•<strong>Depth:</strong> Clears the depth buffer and the stencil buffer.<br />
•<strong>All:</strong> Clears the data in the color, depth and stencil buffers.</td>
</tr>
<tr>
<td>Filters</td>
<td>This section determines the GameObjects that Unity renders in this Custom Pass.</td>
</tr>
<tr>
<td>Queue</td>
<td>Select the kind of materials that this Custom Pass renders.</td>
</tr>
<tr>
<td>Layer Mask</td>
<td>Select the GameObject layer that this Custom Pass applies to.</td>
</tr>
<tr>
<td>Overrides</td>
<td></td>
</tr>
<tr>
<td>Override Depth</td>
<td>Enable this checkbox to override the depth render state in the materials of the rendered GameObjects.<br />
<br />
This allows you to replace the default <strong>Depth Test</strong> value, and write the depth using custom values.</td>
</tr>
<tr>
<td>Depth Test</td>
<td>When Unity renders an GameObjects, it uses the <strong>Depth Test</strong> value to check if it's behind another object. To do this, Unity tests the z-value (the depth) of a given GameObject’s pixel, and compares it against a value stored in the depth buffer.<br />
By default, HDRP sets <strong>Depth Test</strong> to <strong>Less Equal</strong>, allowing the original object to appear in front of the object it is tested against. Use the drop-down to select the comparison method to use for the depth test. Each comparison method changes how the Shader renders:<br />
<br />
•<strong>Disabled</strong>: Do not perform a depth test.<br />
•<strong>Never</strong>: The depth test never passes.<br />
•<strong>Less</strong>: The depth test passes if the pixel's z-value is less than the stored value.<br />
•<strong>Equal</strong>: The depth test passes if the pixel's z-value is equal to the stored value.<br />
•<strong>Less Equa</strong>l: The depth test passes if the pixel's z-value is less than or equal than the Z-buffers value. This renders the tested pixel in front of the other.<br />
•<strong>Greater</strong>: The depth test passes if the pixel's z-value is greater than the stored value.<br />
•<strong>Not Equa</strong>l: The depth test passes if the pixel's z-value is not equal to the stored value.<br />
•<strong>Greater Equa</strong>l: The depth test passes if the pixel's z-value is greater than or equal to the stored value.<br />
•<strong>Always</strong>: The depth test always passes, there is no comparison to the stored value.This setting only appears when you enable <strong>Override Depth</strong>.</td>
</tr>
<tr>
<td>Write Depth</td>
<td>Enable <strong>Write Depth</strong> to instruct Unity to write depth values for GameObjects that use this material.<br />
Disable it if you do not want Unity to write depth values for each GameObject.</td>
</tr>
<tr>
<td>Sorting</td>
<td>Select the way Unity sorts the GameObjects in your scene before it renders them.<br />
<br />
For more information, see <a href="https://docs.unity3d.com/ScriptReference/Rendering.SortingCriteria.html">Sorting criteria</a>.</td>
</tr>
</tbody>
</table>
