---
title: "Add a Renderer Feature to a URP Renderer"
page_title: "Unity - Manual: Add a Renderer Feature to a URP Renderer"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/urp-renderer-feature.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/urp-renderer-feature.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Add a Renderer Feature to a URP Renderer

URP draws objects in the **DrawOpaqueObjects** and **DrawTransparentObjects** passes. You might need to draw objects at a different point in the frame rendering, or interpret and write rendering data (like depth and stencil) in alternate ways. The Render Objects Renderer Feature lets you do such customizations by letting you draw objects on a certain layer, at a certain time, with specific overrides.

For examples of how to use Renderer Features, refer to the [Renderer Features samples in URP Package Samples](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/package-sample-urp-package-samples.html#renderer-features).

To add a Renderer Feature to a Renderer:

1.  In the **Project** window, select a Renderer.

    ![Select a Renderer.](https://docs.unity3d.com/6000.3/Documentation/uploads/urp/add-renderer-feature/renderer-feature-select-renderer.png)

    The Inspector window shows the Renderer properties.

    ![Inspector window shows the Renderer properties.](https://docs.unity3d.com/6000.3/Documentation/uploads/urp/add-renderer-feature/renderer-feature-inspector-no-rend-features.png)

2.  In the Inspector window, select **Add Renderer Feature**. In the list, select a Renderer Feature.

    ![Select **Add Renderer Feature**, then select a Renderer Feature.](https://docs.unity3d.com/6000.3/Documentation/uploads/urp/add-renderer-feature/renderer-feature-select-renderer-feature.png)

    Unity adds the selected Renderer Feature to the Renderer.

    ![New Renderer Feature added.](https://docs.unity3d.com/6000.3/Documentation/uploads/urp/add-renderer-feature/renderer-feature-created.png)

Unity shows Renderer Features as child items of the Renderer in the Project Window:

![Renderer Feature as child item of the Renderer in the Project Window](https://docs.unity3d.com/6000.3/Documentation/uploads/urp/add-renderer-feature/renderer-feature-project-window.png)

## Additional resources

-   [Drawing objects with a Render Objects Renderer Feature](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/renderer-features/how-to-custom-effect-render-objects.html)
-   [Decal Renderer Feature](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/renderer-feature-decal-landing.html)
-   [Screen Space Ambient Occlusion (SSAO) Renderer Feature](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/post-processing-ssao.html)
-   [Screen Space Shadows Renderer Feature](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/renderer-feature-screen-space-shadows.html)
