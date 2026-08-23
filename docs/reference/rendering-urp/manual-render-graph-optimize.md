---
title: "Optimize a render graph"
page_title: "Unity - Manual: Optimize a render graph"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph-optimize.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph-optimize.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Optimize a render graph

To optimize a render graph, merge or reduce the number of render passes. The more render passes you have, the more data the CPU and GPU need to store and retrieve from memory. This slows down rendering, especially on devices that use tile-based deferred randering (TBDR).

## Use existing copies of the color or depth buffers

If you need a copy of the color or depth buffers, avoid copying them yourself if you can. Use the copies URP creates by default instead, to avoid creating unnecessary render passes.

Use the [ConfigureInput](https://docs.unity3d.com/Packages/com.unity.render-pipelines.universal@latest/index.html?subfolder=/api/UnityEngine.Rendering.Universal.ScriptableRenderPass.html#UnityEngine_Rendering_Universal_ScriptableRenderPass_ConfigureInput_UnityEngine_Rendering_Universal_ScriptableRenderPassInput_) API to make sure URP generates the texture you need in the frame data.

To check if URP creates copies during the frame that you can use, check for the following passes in the [Render Graph Viewer](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph-view.html):

-   **Copy Color** - copies color from `_CameraTargetAttachment` to `cameraOpaqueTexture` in the [frame data](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph-frame-data-reference.html).
-   **Copy Depth** - copies depth from `_CameraDepthAttachment` to `cameraDepthTexture` in the [frame data](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph-frame-data-reference.html).

## Merge render passes

Use the [Render Graph Viewer](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph-view.html) to check the reason why URP can’t merge render passes, and fix the issue if you can. On devices that use tile-based deferred randering (TBDR), merging passes helps the device use less energy and run for longer.

You can do the following to make sure URP merges render passes:

-   Use `AddRasterRenderPass` instead of other types of render pass as much as possible.
-   If a render pass needs only to read the current pixel from the framebuffer instead of neighboring pixels, use the `SetInputAttachment` API and the `LOAD_FRAMEBUFFER_X_INPUT` macro. For more information, refer to [Get the current framebuffer from GPU memory](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph-framebuffer-fetch.html).

## Reduce the number of render passes

Don’t create unnecessary render passes to organize your code into smaller, more manageable chunks. Each render pass you create requires more processing time on the CPU.

To write combined render passes, you can use the `AddUnsafePass` API, but rendering might be slower because URP can’t optimize the render pass. For more information, refer to [Use the CommandBuffer interface in a render graph](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph-unsafe-pass.html).

<span id="avoid-blitting-to-and-from-the-color-buffer"></span>

## Avoid blitting to and from the color buffer

To avoid creating two render passes that blit from and to the camera color texture, use the `ContextContainer` object to read and write to the color buffer directly.

For example:

``` lang-cs
public override void RecordRenderGraph(RenderGraph renderGraph, ContextContainer frameData)

```

## Additional resources

-   [Analyze a render graph](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph-view.html)
