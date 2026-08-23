---
title: "Inject a render pass with a Scriptable Renderer Feature in URP"
page_title: "Unity - Manual: Inject a render pass with a Scriptable Renderer Feature in URP"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/renderer-features/scriptable-renderer-features/inject-a-pass-using-a-scriptable-renderer-feature.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/renderer-features/scriptable-renderer-features/inject-a-pass-using-a-scriptable-renderer-feature.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Inject a render pass with a Scriptable Renderer Feature in URP

Use the `ScriptableRenderFeature` API to insert a [Scriptable Render Pass](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/renderer-features/intro-to-scriptable-render-passes.html) into the Universal Render Pipeline (URP) frame rendering loop.

Follow these steps:

1.  Create a new C# script.

2.  Replace the code with a class that inherits from the `ScriptableRendererFeature` class.

    ``` lang-cs
    using UnityEngine;
    using UnityEngine.Rendering.Universal;

    public class MyRendererFeature : ScriptableRendererFeature
    
    ```

3.  In the class, override the `Create` method. For example:

    ``` lang-cs
    public override void Create()
    
    ```

    URP calls the `Create` methods on the following events:

    -   When the Scriptable Renderer Feature loads the first time.
    -   When you enable or disable the Scriptable Renderer Feature.
    -   When you change a property in the **Inspector** window of the Renderer Feature.

4.  In the `Create` method, create an instance of your Scriptable Render Pass, and inject it into the renderer.

    For example, if you have a Scriptable Render Pass called `RedTintRenderPass`:

    ``` lang-cs
    // Define an instance of the Scriptable Render Pass
    private RedTintRenderPass redTintRenderPass;

    public override void Create()
    
    ```

    You can also use the `Create` method to initialize any other resources the Scriptable Renderer Feature needs, such as materials.

5.  Override the `AddRenderPasses` method.

    ``` lang-cs
    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
    
    ```

    URP calls the `AddRenderPasses` method every frame, once for each camera. Don’t create or instantiate any resources within this method.

6.  Use the `EnqueuePass` API to inject the Scriptable Render Pass into the frame rendering loop.

    ``` lang-cs
    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
    
    ```

    To add a render pass to a specific camera only, use an `if` statement to check the camera type. For example:

    ``` lang-cs
    if (renderingData.cameraData.cameraType == CameraType.Game)
    
    ```

You can now add the Scriptable Renderer Feature to the active URP asset. Refer to [How to add a Renderer Feature to a Renderer](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/urp-renderer-feature.html) for more information.

To dispose of any resources, override the [`Dispose`](https://docs.unity3d.com/Packages/com.unity.render-pipelines.universal@latest/index.html?subfolder=/api/UnityEngine.Rendering.Universal.ScriptableRendererFeature.html#UnityEngine_Rendering_Universal_ScriptableRendererFeature_Dispose) method.

## Example

For a complete example of a Scriptable Renderer Feature with a custom render pass that uses a material to blit, follow these steps:

1.  Import the URP render graph samples. For more information, refer to [Importing a package sample in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/package-sample-urp-package-samples.html).
2.  In the **Project** window, go to **Samples** > **Universal Render Pipeline** > \<your version> > **URP RenderGraph Samples** > **BlitWithMaterial**.

## Additional resources

-   [`ScriptableRendererFeature`](https://docs.unity3d.com/Packages/com.unity.render-pipelines.universal@latest/index.html?subfolder=/api/UnityEngine.Rendering.Universal.ScriptableRendererFeature.html)
-   [Add a Renderer Feature to a URP Renderer](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/urp-renderer-feature.html)
-   [Restrict a render pass to a scene area](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/customize/restrict-render-pass-scene-area.html)
-   [Create a custom post-processing effect with Volume support in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/post-processing/custom-post-processing-with-volume.html)
-   [Custom render pass workflow in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/renderer-features/custom-rendering-pass-workflow-in-urp.html)
-   [Render graph system](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph.html)
