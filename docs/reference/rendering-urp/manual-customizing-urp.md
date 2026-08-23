---
title: "Custom rendering and post-processing in URP"
page_title: "Unity - Manual: Custom rendering and post-processing in URP"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/customizing-urp.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/customizing-urp.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Custom rendering and post-processing in URP

Customize and extend the rendering process in the Universal Render Pipeline (URP). Create a custom render pass in a C# script and inject it into the URP frame rendering loop.

| Page                                                                                                                                                          | Description                                                                                                                        |
|:--------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------------------------------------------------------|
| [Introduction to Scriptable Render Passes](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/renderer-features/intro-to-scriptable-render-passes.html) | Learn about using Scriptable Render Passes to alter how Unity renders a scene or the objects within a scene.                       |
| [Adding pre-built effects with Renderer Features in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/urp-renderer-feature-landing.html)          | Resources for adding pre-built render passes to URP, and configuring their behaviour.                                              |
| [Custom render pass workflow in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/renderer-features/custom-rendering-pass-workflow-in-urp.html)   | Add and inject a custom render pass.                                                                                               |
| [Blit](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/customize/blit-overview.html)                                                                 | Understand the different ways to perform a blit operation in URP and best practices to follow when writing custom render passes.   |
| [Render graph system](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph.html)                                                             | Resources and approaches for using the `RenderGraph` APIs to create a Scriptable Render Pass.                                      |
| [Adding a Scriptable Render Pass to the frame rendering loop](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/inject-a-render-pass.html)             | Resources and techniques for injecting a custom render pass via a Scriptable Renderer Feature, or the `RenderPipelineManager` API. |
| [Modify URP source code](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/customize/modify-urp-source-code.html)                                      | Modify URP source code to implement advanced customizations.                                                                       |

## Additional resources

-   [Rendering](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering-in-universalrp.html)
-   [Render pipeline concepts](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/urp-concepts.html)
-   [Pre-built effects (Renderer Features)](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/urp-renderer-feature.html)
-   [How to create a custom post-processing effect](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/post-processing/post-processing-custom-effect-low-code.html)
-   [Execute rendering commands in a custom render pipeline](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@17.0/manual/srp-using-scriptable-render-context.html)
-   [Universal Render Pipeline scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.universal@17.2/api/index.html)
