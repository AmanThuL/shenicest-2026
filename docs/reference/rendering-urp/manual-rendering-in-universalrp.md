---
title: "Rendering in the Universal Render Pipeline"
page_title: "Unity - Manual: Rendering in the Universal Render Pipeline"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering-in-universalrp.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering-in-universalrp.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Rendering in the Universal Render Pipeline

The Universal Render Pipeline (URP) renders scenes using the following components:

-   URP Renderer. URP contains the following Renderers:
    -   [Universal Renderer](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/urp-universal-renderer.html).
    -   [2D Renderer](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/Setup).
-   [Shading models](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/shading-model.html) for shaders shipped with URP
-   Camera
-   [URP asset](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/universalrp-asset.html)

The following illustration shows the frame rendering loop of the URP Universal Renderer.

![URP Universal Renderer, Forward Rendering Path](https://docs.unity3d.com/6000.3/Documentation/uploads/urp/Graphics/Rendering_Flowchart.png)

When the [render pipeline is active in Graphics Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/InstallURPIntoAProject.html), Unity uses URP to render all Cameras in your Project, including game and Scene view cameras, Reflection Probes, and the preview windows in your Inspectors.

The URP renderer executes a Camera loop for each Camera, which performs the following steps:

1.  Culls rendered objects in your scene
2.  Builds data for the renderer
3.  Executes a renderer that outputs an image to the framebuffer.

<span id="camera-loop"></span>

## Camera loop

The Camera loop performs the following steps:

| Step                         | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
|:-----------------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Setup Culling Parameters** | Configures parameters that determine how the culling system culls Lights and shadows. You can override this part of the render pipeline with a custom renderer.                                                                                                                                                                                                                                                                                                |
| **Culling**                  | Uses the culling parameters from the previous step to compute a list of visible renderers, shadow casters, and Lights that are visible to the Camera. Culling parameters and Camera [layer distances](https://docs.unity3d.com/ScriptReference/Camera-layerCullDistances.html) affect culling and rendering performance.                                                                                                                                       |
| **Build Rendering Data**     | Catches information based on the culling output, quality settings from the [URP asset](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/universalrp-asset.html), [Camera](https://docs.unity3d.com/6000.3/Documentation/Manual/Cameras.html), and the current running platform to build the `RenderingData`. The rendering data tells the renderer the amount of rendering work and quality required for the Camera and the currently chosen platform. |
| **Setup Renderer**           | Builds a list of render passes, and queues them for execution according to the rendering data. You can override this part of the render pipeline with a custom renderer.                                                                                                                                                                                                                                                                                       |
| **Execute Renderer**         | Executes each render pass in the queue. The renderer outputs the Camera image to the framebuffer.                                                                                                                                                                                                                                                                                                                                                              |
