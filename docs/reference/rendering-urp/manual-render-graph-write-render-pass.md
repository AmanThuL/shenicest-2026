---
title: "Write a render pass using the render graph system in URP"
page_title: "Unity - Manual: Write a render pass using the render graph system in URP"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph-write-render-pass.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph-write-render-pass.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Write a render pass using the render graph system in URP

This page describes how to write a render pass using the render graph system.

To illustrate the description, the page uses the example render pass that copies the camera’s active color texture to a destination texture. To simplify the code, this example does not use the destination texture elsewhere in the frame. You can use the frame debugger to inspect its contents.

## Declare a render pass

Declare a render pass as a class that inherits from the [ScriptableRenderPass](https://docs.unity3d.com/Packages/com.unity.render-pipelines.universal@latest/index.html?subfolder=/api/UnityEngine.Rendering.Universal.ScriptableRenderPass.html) class.

## Declare resources that a render pass uses

Inside the render pass, declare a class that contains the resources that the render pass uses.

The resources can be regular C# variables and render graph resource references. The render graph system can access this data structure during the rendering code execution. Ensure that you declare only the variables that the render pass uses. Adding unnecessary variables can reduce performance.

``` lang-cs
class PassData

```

The [RecordRenderGraph](https://docs.unity3d.com/Packages/com.unity.render-pipelines.universal@latest/index.html?subfolder=/api/UnityEngine.Rendering.Universal.RenderObjectsPass.html#UnityEngine_Rendering_Universal_RenderObjectsPass_RecordRenderGraph_) method populates the data and the render graph passes it as a parameter to the rendering function.

## <span id="recordrendergraph"></span>Implement the RecordRenderGraph method

Use the [RecordRenderGraph](https://docs.unity3d.com/Packages/com.unity.render-pipelines.universal@latest/index.html?subfolder=/api/UnityEngine.Rendering.Universal.RenderObjectsPass.html#UnityEngine_Rendering_Universal_RenderObjectsPass_RecordRenderGraph_) method to add and configure one or more render passes in the render graph system.

Unity calls this method during the render graph configuration step and lets you register relevant passes and resources for the render graph execution. Use this method to implement custom rendering.

In the [RecordRenderGraph](https://docs.unity3d.com/Packages/com.unity.render-pipelines.universal@latest/index.html?subfolder=/api/UnityEngine.Rendering.Universal.RenderObjectsPass.html#UnityEngine_Rendering_Universal_RenderObjectsPass_RecordRenderGraph_) method you declare render pass inputs and outputs, but do not add commands to command buffers.

The following section describes the main elements of the [RecordRenderGraph](https://docs.unity3d.com/Packages/com.unity.render-pipelines.universal@latest/index.html?subfolder=/api/UnityEngine.Rendering.Universal.RenderObjectsPass.html#UnityEngine_Rendering_Universal_RenderObjectsPass_RecordRenderGraph_) method and provides an example implementation.

## The render graph builder variable add frame resources

The `builder` variable is an instance of the `IRasterRenderGraphBuilder` interface. This variable is the entry point for configuring the information related to the render pass.

The [UniversalResourceData](https://docs.unity3d.com/Packages/com.unity.render-pipelines.universal@latest/index.html?subfolder=/api/UnityEngine.Rendering.Universal.UniversalResourceData.html) class contains all the texture resources used by URP, including the active color and depth textures of the camera.

The [UniversalCameraData](https://docs.unity3d.com/Packages/com.unity.render-pipelines.universal@latest/index.html?subfolder=/api/UnityEngine.Rendering.Universal.UniversalCameraData.html) class contains the data related to the currently active camera.

For demonstrative purposes, this sample creates a temporary destination texture. The `builder.UseTexture` method declares that this render pass uses the source texture as a read-only input:

``` lang-cs
builder.UseTexture(passData.copySourceTexture);
```

In this example, the `builder.SetRenderAttachment` method declares that this render pass uses the temporary destination texture as its color render target.

## Declare a rendering function that generates the rendering commands for the render pass

Declare a rendering function that generates the rendering commands for the render pass.

``` lang-cs
static void ExecutePass(PassData data, RasterGraphContext context)

```

The `SetRenderFunc` method in the `RecordRenderGraph` method sets the `ExecutePass` method as the rendering function that render graph calls when executing the render pass. Use a static method or a static lambda method.

``` lang-cs
builder.SetRenderFunc(static (PassData data, RasterGraphContext context) => ExecutePass(data, context));
```

The complete example of the [RecordRenderGraph](https://docs.unity3d.com/Packages/com.unity.render-pipelines.universal@latest/index.html?subfolder=/api/UnityEngine.Rendering.Universal.RenderObjectsPass.html#UnityEngine_Rendering_Universal_RenderObjectsPass_RecordRenderGraph_) method:

``` lang-cs
// This method adds and configures one or more render passes in the render graph.
// This process includes declaring their inputs and outputs,
// but does not include adding commands to command buffers.
public override void RecordRenderGraph(RenderGraph renderGraph, ContextContainer frameContext)

}
```

## Inject the scriptable render pass instance into the renderer

To inject the scriptable render pass instance into the renderer, use the `AddRenderPasses` method from a Renderer Feature implementation. URP calls the `AddRenderPasses` method every frame, once for each Camera.

``` lang-cs
public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)

```

## Additional resources

-   [Inject a render pass using a Scriptable Renderer Feature](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/customize/inject-render-pass-via-script.html)
