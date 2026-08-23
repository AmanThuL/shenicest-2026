---
title: "OnDemandRendering (Script Reference)"
page_title: "Unity - Scripting API: OnDemandRendering"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.OnDemandRendering.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.OnDemandRendering.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# OnDemandRendering

class in UnityEngine.Rendering

/

Implemented in:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UnityEngine.CoreModule.html" class="cl">UnityEngine.CoreModule</a>

<span id="scrollToFeedback">Leave feedback</span>

<span class="blue-btn sbtn">Suggest a change</span>

## Success!

Thank you for helping us improve the quality of Unity Documentation. Although we cannot accept all submissions, we do read each suggested change from our users and will make updates where applicable.

<span class="gray-btn sbtn close">Close</span>

## Submission failed

For some reason your suggested change could not be submitted. Please \<a>try again\</a> in a few minutes. And thank you for taking the time to help us improve the quality of Unity Documentation.

<span class="gray-btn sbtn close">Close</span>

Your name Your email Suggestion<span class="r">\*</span>

Submit suggestion

<span class="cancel left lh42 cn">Cancel</span>

<span style="color:red;"> </span>

### Description

Use the OnDemandRendering class to control and query information about your application's rendering speed independent from all other subsystems (such as physics, input, or animation).

If you use this with Optimized Frame Pacing on Android, and if you're also using OpenGL ES, Optimized Frame Pacing is most effective when the frame rate is either 20, 30, or 60 frames per second. To make sure that you render at one of these frame rates, use OnDemandRendering.effectiveRenderframerate.  
  
Vulkan is less strict and allows a greater number of valid frame rates.  
  
If you request an incompatible frame rate, the application renders at the highest frame rate possible. However, if the renderFrameInterval is too high, the application might become unresponsive because the time between rendered frames also becomes too high.  
  
Note about event execution:  
The diagram on the Manual page [Order of execution for event functions](https://docs.unity3d.com/6000.3/Documentation/Manual/execution-order.html) describes the execution order for events in each frame. However, render-specific events, including those for Scene rendering, Gizmo rendering, GUI rendering, and End of frame sections, don't occur during frames that Unity doesn't render (when [OnDemandRendering.willCurrentFrameRender](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.OnDemandRendering-willCurrentFrameRender.html) is false).

### Static Properties

| Property                                                                                                                                            | Description                                                                                                                                                         |
|-----------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [effectiveRenderFrameRate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.OnDemandRendering-effectiveRenderFrameRate.html) | The current estimated rate of rendering in frames per second rounded to the nearest integer.                                                                        |
| [renderFrameInterval](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.OnDemandRendering-renderFrameInterval.html)           | Get or set the current frame rate interval. To restore rendering back to the value of Application.targetFrameRate or QualitySettings.vSyncCount set this to 0 or 1. |
| [willCurrentFrameRender](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.OnDemandRendering-willCurrentFrameRender.html)     | True if the current frame will be rendered.                                                                                                                         |
