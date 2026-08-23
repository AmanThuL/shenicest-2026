---
title: "Camera stacking in URP"
page_title: "Unity - Manual: Camera stacking in URP"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/cameras/camera-stacking-concepts.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/cameras/camera-stacking-concepts.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Camera stacking in URP

In the Universal Render Pipeline (URP), you use camera stacking to layer the output of multiple Cameras and create a single combined output. Camera stacking allows you to create effects such as a 3D model in a 2D UI, or the cockpit of a vehicle.

A camera stack consists of a [Base Camera](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/camera-types-and-render-type-introduction.html#base-camera) and one or more [Overlay Cameras](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/camera-types-and-render-type-introduction.html#overlay-camera). A camera stack overrides the output of the Base Camera with the combined output of all the cameras in the camera stack. As a result, anything you can do with the output of a Base Camera, you can do with the output of a camera stack. For example, you can render a camera stack to a render target, or apply post-processing effects.

Refer to [Set up a camera stack](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/camera-stacking.html) for more information. To download examples of camera stacking in URP, install the [Camera Stacking samples](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/package-sample-urp-package-samples.html#camera-stacking).

## Camera stacking and rendering order

URP performs several optimizations within a camera, including rendering order optimizations to reduce overdraw. However, when you use a camera stack, you define the order in which URP renders the cameras. You must be careful not to order the cameras in a way that causes excessive overdraw. For more information on overdraw in URP, refer to [Rendering order optimizations](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/cameras-advanced.html#rendering-order-optimizations).

## Camera stacking and post-processing

You should only apply post-processing to the last camera in the stack, so the following applies:

-   URP renders the post-processing effects only once, not repeatedly for each camera.
-   The visual effects are consistent, because all the cameras in the stack receive the same post-processing.

## Limitations

You cannot use a mix of different types of renderers (2D and 3D) for cameras in a camera stack.

## Additional resources

-   [Set up a camera stack](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/camera-stacking.html)
-   [Camera component reference](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/camera-component-reference.html)
