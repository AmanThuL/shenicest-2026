---
title: "Blit using the render graph system in URP"
page_title: "Unity - Manual: Blit using the render graph system in URP"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph-blit.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph-blit.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Blit using the render graph system in URP

To blit from one texture to another in the render graph system in the Universal Render Pipeline (URP), use the [`AddBlitPass`](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@17.3/api/UnityEngine.Rendering.RenderGraphModule.Util.RenderGraphUtils.html#UnityEngine_Rendering_RenderGraphModule_Util_RenderGraphUtils_AddBlitPass_UnityEngine_Rendering_RenderGraphModule_RenderGraph_UnityEngine_Rendering_RenderGraphModule_Util_RenderGraphUtils_BlitMaterialParameters_System_String_System_Boolean_) API. The API generates a render pass automatically, so you don’t need to use a method like `AddRasterRenderPass`.

Follow these steps:

1.  To create a shader and material that works with a blit render pass, from the main menu select **Assets** > **Create** > **Shader** > **SRP Blit Shader**, then create a material from it.

    To use shader graph instead, refer to [Create a low-code custom post-processing effect](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/post-processing/post-processing-custom-effect-low-code.html).

    For more information about writing shaders in URP, refer to [Writing custom shaders in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/writing-custom-shaders-urp.html).

2.  Add `using UnityEngine.Rendering.RenderGraphModule.Util` to your render pass script.

3.  In your render pass, create a field for the blit material. For example:

    ``` lang-cs
    public class MyBlitPass : ScriptableRenderPass
    
    ```

4.  Set up the texture to blit from and blit to. For example:

    ``` lang-cs
    TextureHandle sourceTexture = renderGraph.CreateTexture(sourceTextureProperties);
    TextureHandle destinationTexture = renderGraph.CreateTexture(destinationTextureProperties);
    ```

    For more information, refer to [Get data from the current frame in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/accessing-frame-data.html) and [Create a temporary texture for a single render pass](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph-create-a-texture.html).

5.  To set up the material, textures, and shader pass for the blit operation, create a [`RenderGraphUtils.BlitMaterialParameters`](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@17.3/api/UnityEngine.Rendering.RenderGraphModule.Util.RenderGraphUtils.BlitMaterialParameters.html) object. For example:

    ``` lang-cs
    // Create a BlitMaterialParameters object with the blit material, source texture, destination texture, and shader pass to use.
    var blitParams = new RenderGraphUtils.BlitMaterialParameters(sourceTexture, destinationTexture, blitMaterial, 0);
    ```

6.  To add a blit pass, call the [`AddBlitPass`](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@17.3/api/UnityEngine.Rendering.RenderGraphModule.Util.RenderGraphUtils.html#UnityEngine_Rendering_RenderGraphModule_Util_RenderGraphUtils_AddBlitPass_UnityEngine_Rendering_RenderGraphModule_RenderGraph_UnityEngine_Rendering_RenderGraphModule_Util_RenderGraphUtils_BlitMaterialParameters_System_String_System_Boolean_) method with the blit parameters in your render pass’s `RecordRenderGraph` method. For example:

    ``` lang-cs
    renderGraph.AddBlitPass(blitParams, "Pass created with AddBlitPass");
    ```

For a complete example, refer to the example called **BlitWithMaterial** in the render graph examples of the [Universal Render Pipeline (URP) package samples](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/package-sample-urp-package-samples.html#rendergraph-samples).

If you use `AddBlitPass` with a default material, Unity might use the `AddCopyPass` API instead, to optimize the render pass so it accesses the framebuffer from the on-chip memory of the GPU instead of video memory. This process is sometimes called framebuffer fetch. For more information, refer to [`AddCopyPass`](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@17.3/api/UnityEngine.Rendering.RenderGraphModule.Util.RenderGraphUtils.html#UnityEngine_Rendering_RenderGraphModule_Util_RenderGraphUtils_AddCopyPass_UnityEngine_Rendering_RenderGraphModule_RenderGraph_UnityEngine_Rendering_RenderGraphModule_TextureHandle_UnityEngine_Rendering_RenderGraphModule_TextureHandle_System_String_System_Boolean_) API.

## Avoid blitting back

After a blit, you usually blit the destination texture back to the active color texture. However in the render graph system, you can update the frame data to point to the destination texture instead, so you only blit once. For example:

``` lang-cs
// Set the camera color as the destination texture you blitted to.
frameData.cameraColor = destinationTexture;
```

For more information, refer to [Avoid blitting to and from the color buffer](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph-optimize.html#avoid-blitting-to-and-from-the-color-buffer).

## Customize the render pass

To customize the render pass that the methods generate, for example to change settings or add more resources, call the APIs with the `returnBuilder` parameter set to `true`. The APIs then return the `IBaseRenderGraphBuilder` object that you usually receive as `var builder` from a method like `AddRasterRenderPass`.

For example:

``` lang-cs
using (var builder = renderGraph.AddBlitPass(blitParams, "Pass created with AddBlitPass", returnBuilder: true))

```

## Additional resources

-   [Get the current framebuffer from GPU memory](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph-framebuffer-fetch.html)
-   [Render graph system](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph.html)
-   [Universal Render Pipeline (URP) package samples](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/package-sample-urp-package-samples.html#rendergraph-samples): refer to the **Blit** example which uses **AddCopyPass**.
