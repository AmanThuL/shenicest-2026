---
title: "Multiple cameras in URP"
page_title: "Unity - Manual: Multiple cameras in URP"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/cameras-multiple.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/cameras-multiple.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Multiple cameras in URP

![An example of the effect camera stacking can produce in URP](https://docs.unity3d.com/6000.3/Documentation/uploads/urp/camera-stacking-example.png)

Resources and approaches for using multiple cameras to work with multiple camera outputs and targets in the Universal Render Pipeline (URP).

**Note:** If you use multiple cameras, it might make rendering slower. An active camera runs through the entire rendering loop even if it renders nothing.

| Page                                                                                                                                                                      | Description                                                                                                |
|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------------------------------|
| [Camera stacking](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/cameras/camera-stacking-concepts.html)                                                         | Learn about the fundamental concepts of camera stacking.                                                   |
| [Set up a camera stack](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/camera-stacking.html)                                                                    | Stack cameras to layer the outputs of multiple cameras into a single combined output.                      |
| [Add and remove cameras in a camera stack](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/cameras/add-and-remove-cameras-in-a-stack.html)                       | Add, remove, and reorder cameras within a camera stack.                                                    |
| [Set up split-screen rendering](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering-to-the-same-render-target.html)                                        | Render multiple camera outputs to a single render target to create effects such as split screen rendering. |
| [Apply different post processing effects to separate cameras](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/cameras/apply-different-post-proc-to-cameras.html) | Apply different post-processing setups to individual cameas within a scene.                                |
| [Render a camera’s output to a Render Texture](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering-to-a-render-texture.html)                               | Render to a Render Texture to create effects such as in-game CCTV monitors.                                |
| [Create a render request](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/User-Render-Requests.html)                                                             | Trigger a camera to render to a Render Texture outside of URP rendering loop.                              |

## Additional resources

-   [Multiple cameras](https://docs.unity3d.com/6000.3/Documentation/Manual/MultipleCameras-landing.html)
-   [Camera render types in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/camera-types-and-render-type.html)
-   [Camera render order in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/cameras-advanced.html)
