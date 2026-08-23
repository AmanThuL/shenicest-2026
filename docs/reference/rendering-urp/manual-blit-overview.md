---
title: "Blit in URP"
page_title: "Unity - Manual: Blit in URP"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/customize/blit-overview.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/customize/blit-overview.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Blit in URP

To blit from one texture to another in a custom render pass in the Universal Render Pipeline (URP), use the following:

-   The `AddBlitPass` API in the render graph system. For more information, refer to [Blit using the render graph system](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph-blit.html).
-   The [Blitter API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest?subfolder=/api/UnityEngine.Rendering.Blitter.html) from the Core Scriptable Render Pipeline (SRP).

The shader you use with the `Blitter` API must be a hand-coded shader. [Shader Graph](https://docs.unity3d.com/6000.3/Documentation/Manual/shader-graph.html) shaders aren’t compatible with the `Blitter` API.

**Note:** Don’t use the `CommandBuffer.Blit` or `Graphics.Blit` APIs, or APIs that use them internally such as `RenderingUtils.Blit`. These APIs might break XR rendering, and aren’t compatible with native render passes.

For example in the `Execute` function in a render pass, add the following:

``` lang-cs

```

You can also use the [`AddBlitPass`](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@17.3/api/UnityEngine.Rendering.RenderGraphModule.Util.RenderGraphUtils.html#UnityEngine_Rendering_RenderGraphModule_Util_RenderGraphUtils_AddBlitPass_UnityEngine_Rendering_RenderGraphModule_RenderGraph_UnityEngine_Rendering_RenderGraphModule_TextureHandle_UnityEngine_Rendering_RenderGraphModule_TextureHandle_UnityEngine_Vector2_UnityEngine_Vector2_System_Int32_System_Int32_System_Int32_System_Int32_System_Int32_System_Int32_UnityEngine_Rendering_RenderGraphModule_Util_RenderGraphUtils_BlitFilterMode_System_String_System_Boolean_) or [`AddCopyPass`](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@17.3/api/UnityEngine.Rendering.RenderGraphModule.Util.RenderGraphUtils.html#UnityEngine_Rendering_RenderGraphModule_Util_RenderGraphUtils_AddCopyPass_UnityEngine_Rendering_RenderGraphModule_RenderGraph_UnityEngine_Rendering_RenderGraphModule_TextureHandle_UnityEngine_Rendering_RenderGraphModule_TextureHandle_System_Int32_System_Int32_System_Int32_System_Int32_System_String_) APIs in your `RecordRenderGraph` method to blit or copy textures. For example:

``` lang-cs
using UnityEngine.Rendering.RenderGraphModule.Util;

...

    public override void RecordRenderGraph(RenderGraph renderGraph, ContextContainer frameData) 
```

## Examples

For full examples of using the `Blitter`, `AddBlitPass`, and `AddCopyPass` APIs, follow these steps:

1.  Import the URP render graph samples. For more information, refer to [Importing a package sample in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/package-sample-urp-package-samples.html).
2.  In the **Project** window, go to **Samples** > **Universal Render Pipeline** > **17.3.0** > **URP RenderGraph Samples**.
3.  Open **Blit**, **BlitWithFrameData**, or **BlitWithMaterial**.

## Additional resources

-   [Custom render pass workflow](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/renderer-features/custom-rendering-pass-workflow-in-urp.html)
-   [Textures in the Render Graph system](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/working-with-textures.html)
