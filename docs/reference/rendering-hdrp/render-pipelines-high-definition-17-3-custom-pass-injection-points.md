---
title: "Custom pass injection points"
page_title: "Injection Points | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Custom-Pass-Injection-Points.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Custom-Pass-Injection-Points.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Injection Points

To determine when Unity executes a Custom Pass Volume, select an **Injection Point** in the [Custom Pass Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/custom-pass-reference.html#custom-pass-volume-component-properties) component.

Each injection point affects the way Custom Passes appear in your scene. There are seven injection points in the High Definition Render Pipeline (HDRP). If there are multiple Custom Pass volumes assigned to one Injection Point, HDRP executes them in order of priority. For more information see [Custom Pass Volume workflow](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Custom-Pass-Volume-Workflow.html)

Injection points give a Custom Pass Volume component access to a selection of buffers. Each available buffer has different read or write access at each injection point. Each buffer contains a subset of objects rendered before your pass. HDRP creates a color pyramid and depth pyramid at specific points in the rendering pipeline. For more information, see [Custom Pass buffers and pyramids](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Custom-Pass-buffers-pyramids.html).

In a **DrawRenderers Custom Pass** you can only use certain materials at specific injection points. For a full list of compatible materials, see [Material and injection point compatibility](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/custom-pass-create-gameobject.html#material-and-injection-point-compatibility).

To analyse the actions Unity performs in a render loop and see where Unity executes your Custom Pass, use the [frame debugger](https://docs.unity3d.com/Manual/FrameDebugger.html).

To learn when injection points happen in the render pipeline refer to [Execution order](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/rendering-execution-order.html).

Unity triggers the following injection points in a frame, in order from top to bottom:

<table>
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<thead>
<tr>
<th><strong>Injection point</strong></th>
<th><strong>Available buffers</strong></th>
<th><strong>Description</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td>BeforeRendering</td>
<td>Depth (write)</td>
<td>Unity clears the depth buffer immediately before this injection point.<br />
<br />
In this injection point you can write to the depth buffer so that Unity doesn’t render depth-tested, opaque objects.<br />
<br />
You can also clear the buffer you allocated or the <code>Custom Buffer</code>.<br />
<br />
When you select this Injection point for a <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/custom-pass-create-gameobject.html#full-screen-custom-pass">FullscreenCustom Pass</a>, Unity assigns the camera color buffer as the target by default.</td>
</tr>
<tr>
<td>AfterOpaqueDepthAndNormal</td>
<td>Depth (read, write), Normal and roughness (read, write), Motion vectors (write)</td>
<td>The available buffers for this injection point contain all opaque objects.<br />
<br />
In this injection point you can modify the normal, roughness, depth, and motion vectors buffers. HDRP takes this into account in the lighting and the depth pyramid.<br />
<br />
Normals and roughness are in the same buffer. You can use <code>DecodeFromNormalBuffer</code> and <code>EncodeIntoNormalBuffer</code> methods to read/write normal and roughness data.<br />
<br />
The Motion vectors buffer only includes object motion vector data when you use <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Forward-And-Deferred-Rendering.html">forward rendering</a>. To include object motion vector data in the Motion vectors buffer when using deferred rendering, go to <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Frame-Settings.html">Frame Settings</a> and enable <strong>Depth Prepass within Deferred</strong>.</td>
</tr>
<tr>
<td>AfterOpaqueColor</td>
<td>Color (no pyramid; read, write), Depth (read, write), Normal and roughness (read), Motion vectors (read, write)</td>
<td>The color buffer contains all the opaque objects in your view. HDRP hasn't rendered the sky or fog yet, so if you change the color buffer in this injection point, HDRP applies fog on top of your effect.</td>
</tr>
<tr>
<td>AfterOpaqueAndSky</td>
<td>Color (no pyramid; read, write), Depth (read, write), Normal and roughness (read), Motion vectors (read, write)</td>
<td>The available buffers for this injection point contain all opaque objects and the sky. Note that the Fog is rendered just after this pass, so if you modify the color buffer, fog will be added on top of your effect.</td>
</tr>
<tr>
<td>BeforePreRefraction</td>
<td>Color (no pyramid; read, write), Depth (read, write), Normal and roughness (read), Motion vectors (read, write)</td>
<td>The available buffers for this injection point contain all opaque objects, the camera and object motion vectors, and the sky.<br />
<br />
From this point, the motion vectors buffer is complete.<br />
<br />
In this injection point you can render any transparent objects that require refraction. These objects are then included in the color pyramid that Unity uses for refraction when it renders transparent objects.</td>
</tr>
<tr>
<td>BeforeTransparent</td>
<td>Color (Pyramid | read, write), Depth (read, write), Normal and roughness (read), Motion vectors (read)</td>
<td>The available buffers for this injection point contain:
<ul>
<li>All opaque objects.</li>
<li>Transparent PreRefraction objects.</li>
<li>Transparent objects with depth-prepass and screen space reflections (SSR) enabled.</li>
</ul>
In this Injection Point you can sample the color pyramid that Unity uses for transparent refraction. You can use this to create a blur effect. All objects Unity renders in this injection point will not be in the color pyramid.<br />
<br />
You can also use this injection point to draw some transparent objects that refract the whole scene, like water.</td>
</tr>
<tr>
<td>BeforePostProcess</td>
<td>Color (Pyramid | read, write), Depth (read, write), Normal and roughness (read), Motion vectors (read)</td>
<td>The available buffers for this injection point contain all geometry in the frame that uses High Dynamic Range (HDR).</td>
</tr>
<tr>
<td>AfterPostProcess</td>
<td>Color (read, write), Depth (read)</td>
<td>The available buffers for this injection point contain the final render of the scene, including post-process effects.<br />
<br />
This injection point executes the available buffers after Unity applies any post-processing effects.<br />
<br />
If you select this injection point, objects that use the depth buffer display jittering artifacts.<br />
<br />
When you select this injection point for a <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/custom-pass-create-gameobject.html#full-screen-custom-pass">FullscreenCustom Pass</a>, Unity assigns the camera color buffer as the target by default.<br />
<br />
<strong>Note:</strong> When sampling scene color using HDSceneColor node in a FullScreenShaderGraph at this injection point, consider using a temporary buffer to handle concurrent read/write operations. See <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Custom-Pass-Scene-Color-Read.html">Scene Color Sampling in AfterPostProcess</a> for implementation details.</td>
</tr>
</tbody>
</table>
