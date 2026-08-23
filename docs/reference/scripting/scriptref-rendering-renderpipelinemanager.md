---
title: "RenderPipelineManager"
page_title: "Unity - Scripting API: RenderPipelineManager"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.RenderPipelineManager.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.RenderPipelineManager.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# RenderPipelineManager

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

Static class that manages the currently active Render Pipeline.

The RenderPipelineManager provides access to the currently active [RenderPipeline](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.RenderPipeline.html) instance. It also provides a way to subscribe to various events related to the life cycle of the Render Pipeline.  
  
The following example illustrates how RenderPipelineManager can be used to check if a SRP is currently active.

``` codeExampleCS
using UnityEngine;
using UnityEngine.Rendering;

public class RenderPipelineManagerExample : MonoBehaviour
{
    public void Update()
    {
        if (RenderPipelineManager.currentPipeline != null) {
            Debug.Log("A scriptable render pipeline is active");
        } else 
    }
}
```

Additional resources: [How to get, set, and configure the active render pipeline](https://docs.unity3d.com/6000.3/Documentation/Manual/srp-setting-render-pipeline-asset.html).

### Static Properties

| Property                                                                                                                                              | Description                                          |
|-------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------|
| [currentPipeline](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.RenderPipelineManager-currentPipeline.html)                 | Returns the active RenderPipeline.                   |
| [pipelineSwitchCompleted](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.RenderPipelineManager-pipelineSwitchCompleted.html) | Indicate when Render Pipeline switch is in progress. |

### Events

| Event                                                                                                                                                                   | Description                                                                                                                                                    |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [activeRenderPipelineAssetChanged](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.RenderPipelineManager-activeRenderPipelineAssetChanged.html) | Delegate that you can use to invoke custom code when the current RenderPipelineAsset between frames has changed.                                               |
| [activeRenderPipelineCreated](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.RenderPipelineManager-activeRenderPipelineCreated.html)           | Delegate that you can use to invoke custom code right after RenderPipelineManager.currentPipeline is created.                                                  |
| [activeRenderPipelineDisposed](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.RenderPipelineManager-activeRenderPipelineDisposed.html)         | Delegate that you can use to invoke custom code right before RenderPipelineManager.currentPipeline is disposed.                                                |
| [activeRenderPipelineTypeChanged](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.RenderPipelineManager-activeRenderPipelineTypeChanged.html)   | Delegate that you can use to invoke custom code when Unity changes the active render pipeline, and the new RenderPipeline has a different type to the old one. |
| [beginCameraRendering](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.RenderPipelineManager-beginCameraRendering.html)                         | Delegate that you can use to invoke custom code before Unity renders an individual Camera.                                                                     |
| [beginContextRendering](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.RenderPipelineManager-beginContextRendering.html)                       | Delegate that you can use to invoke custom code at the start of RenderPipeline.Render.                                                                         |
| [beginFrameRendering](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.RenderPipelineManager-beginFrameRendering.html)                           | Delegate that you can use to invoke custom code at the start of RenderPipeline.Render.                                                                         |
| [endCameraRendering](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.RenderPipelineManager-endCameraRendering.html)                             | Delegate that you can use to invoke custom code after Unity renders an individual Camera.                                                                      |
| [endContextRendering](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.RenderPipelineManager-endContextRendering.html)                           | Delegate that you can use to invoke custom code at the end of RenderPipeline.Render.                                                                           |
| [endFrameRendering](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.RenderPipelineManager-endFrameRendering.html)                               | Delegate that you can use to invoke custom code at the end of RenderPipeline.Render.                                                                           |
