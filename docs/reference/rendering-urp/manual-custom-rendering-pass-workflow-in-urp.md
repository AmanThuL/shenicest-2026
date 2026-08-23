---
title: "Custom render pass workflow in URP"
page_title: "Unity - Manual: Custom render pass workflow in URP"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/renderer-features/custom-rendering-pass-workflow-in-urp.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/renderer-features/custom-rendering-pass-workflow-in-urp.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Custom render pass workflow in URP

A custom render pass is a way to change how the Universal Render Pipeline (URP) renders a scene or the objects within a scene. A custom render pass contains your own rendering code, which you insert into the rendering pipeline at an injection point.

To add a custom render pass, complete the following tasks:

-   [Create the code](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/renderer-features/custom-rendering-pass-workflow-in-urp.html#create-code) for a custom render pass using the Scriptable Render Pass API.
-   Add the custom render pass to URP’s frame rendering loop by [creating a Scriptable Renderer Feature](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/renderer-features/custom-rendering-pass-workflow-in-urp.html#create-srf), or [using the `RenderPipelineManager` API](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/renderer-features/custom-rendering-pass-workflow-in-urp.html#inject-pass).

## <span id="create-code"></span>Create the code for a custom render pass

To create the code for a custom render pass, write a class that inherits `ScriptableRenderPass`. In the class, use the [render graph API](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph-introduction.html) to tell Unity what textures and render targets to use, and what operations to do on them.

Refer to [Scriptable Render Passes](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/renderer-features/intro-to-scriptable-render-passes.html) for more information.

## <span id="create-srf"></span>Create a Scriptable Renderer Feature

To add your custom render pass to URP’s frame rendering loop, write a class that inherits `ScriptableRendererFeature`.

The Scriptable Renderer Feature does the following:

1.  Creates an instance of the custom render pass you created.
2.  Inserts the custom render pass into the rendering pipeline.

Refer to [Inject a pass using a Scriptable Renderer Feature](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/renderer-features/scriptable-renderer-features/inject-a-pass-using-a-scriptable-renderer-feature.html) for more information.

## <span id="inject-pass"></span>Use the RenderPipelineManager API

To add your custom render pass to URP’s frame rendering loop, you can also subscribe a method to one of the events in the [RenderPipelineManager](https://docs.unity3d.com/ScriptReference/Rendering.RenderPipelineManager.html) class.

Refer to [Inject a render pass via scripting](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/customize/inject-render-pass-via-script.html) for more information.

## Additional resources

-   [Render graph system](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph-introduction.html)
