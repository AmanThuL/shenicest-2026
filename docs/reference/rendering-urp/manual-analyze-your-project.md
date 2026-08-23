---
title: "Analyze your project in URP"
page_title: "Unity - Manual: Analyze your project in URP"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/analyze-your-project.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/analyze-your-project.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Analyze your project in URP

You can use the [Unity Profiler](https://docs.unity3d.com/Manual/Profiler.html) to get data on the performance of your project in areas such as the CPU and memory.

## Profiler markers

The following table lists markers that appear in the Unity Profiler for a URP frame and have a significant effect on performance.

The table doesn’t include a marker if it’s deep in the Profiler hierarchy, or the label already describes what URP does.

<table><thead><tr class="header"><th style="text-align: left;"><strong>Marker</strong></th><th style="text-align: left;"><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Inl_UniversalRenderPipeline. RenderSingleCameraInternal</strong></td><td style="text-align: left;">URP builds a list of rendering commands in the <a href="https://docs.unity3d.com/ScriptReference/Rendering.ScriptableRenderContext.html"><code>ScriptableRenderContext</code></a>, for a single camera. URP only records rendering commands in this marker, but doesn’t yet execute them. The marker includes the camera name, for example <strong>Main Camera</strong>.<br />
This marker has the following sub-markers:<ul><li><strong>Inl_ScriptableRenderer.Setup</strong>: URP prepares for rendering, for example preparing render textures for the camera and shadow maps.</li><li><strong>CullScriptable</strong>: URP generates a list of GameObjects and lights to render, and culls (excludes) any that are outside the camera’s view. The time this takes depends on the number of GameObjects and lights in your scene.</li></ul></td></tr><tr class="even"><td style="text-align: left;"><strong>Inl_ScriptableRenderContext.Submit</strong></td><td style="text-align: left;">URP submits the list of commands in the <code>ScriptableRenderContext</code> to the graphics API. This marker might appear more than once if URP submits commands more than once per frame, or you call <a href="https://docs.unity3d.com/ScriptReference/Rendering.ScriptableRenderContext.Submit.html"><code>ScriptableRenderContext.Submit</code></a> in your own code.<br />
This marker has the following sub-markers:<ul><li><strong>MainLightShadow</strong>: URP renders a <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/shadow-mapping.html">shadow map</a> for the main Directional Light.</li><li><strong>AdditionalLightsShadow</strong>: URP renders shadow maps for other lights.</li><li><strong>UberPostProcess</strong>: URP renders <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/urp/EffectList.html">post-processing effects</a> you enable. This marker contains separate markers for some post-processing effects.</li><li><strong>RenderLoop.DrawSRPBatcher</strong>: URP uses the <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/SRPBatcher.html">Scriptable Render Pipeline Batcher</a> to render one or more batches of objects.</li></ul></td></tr><tr class="odd"><td style="text-align: left;"><strong>CopyColor</strong></td><td style="text-align: left;">URP copies the color buffer from one render texture to another. You can disable <strong>Opaque Texture</strong> in the <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/urp/universalrp-asset.html">URP asset</a>, so that URP only copies the color buffer if it needs to.</td></tr><tr class="even"><td style="text-align: left;"><strong>CopyDepth</strong></td><td style="text-align: left;">URP copies the depth buffer from one render texture to another. You can disable <strong>Depth Texture</strong> in the <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/urp/universalrp-asset.html">URP asset</a> unless you need the depth texture (for example, if you use a shader that uses scene depth).</td></tr><tr class="odd"><td style="text-align: left;"><strong>FinalBlit</strong></td><td style="text-align: left;">URP copies a render texture to the current camera render target.</td></tr></tbody></table>

## Use a GPU profiler to analyze your project

You can use a platform GPU profiler such as [Xcode](https://docs.unity3d.com/Manual/XcodeFrameDebuggerIntegration.html) to get data on the performance of the GPU during rendering. You can also use a profiler such as [RenderDoc](https://docs.unity3d.com/Manual/RenderDocIntegration.html), but it might provide less accurate performance data.

Data from a GPU profiler includes URP markers for rendering events, such as different render passes.

## Use other tools to analyze your project

You can also use the following tools to analyze the performance of your project:

-   [Scene view View Options](https://docs.unity3d.com/Manual/ViewModes.html)
-   [Rendering Debugger](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/features/rendering-debugger.html)
-   [Frame Debugger](https://docs.unity3d.com/Manual/frame-debugger-window.html)
-   [Graphics performance and profiling reference](https://docs.unity3d.com/6000.3/Documentation/Manual/profiling-landing.html)
