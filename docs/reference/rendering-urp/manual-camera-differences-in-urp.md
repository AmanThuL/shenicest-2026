---
title: "Introduction to cameras in URP"
page_title: "Unity - Manual: Introduction to cameras in URP"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/cameras/camera-differences-in-urp.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/cameras/camera-differences-in-urp.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to cameras in URP

URP cameras use the following:

-   The [Universal Additional Camera Data](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/universal-additional-camera-data.html) component, which extends the Camera component’s functionality and allows URP to store additional camera-related data.
-   The [Render Type](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/camera-types-and-render-type.html) setting, which defines the two types of camera in URP: Base and Overlay.
-   The [Camera Stacking](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/camera-stacking.html) system, which allows you to layer the output of multiple Cameras into a single combined output.
-   The [Volume](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/Volumes.html) system, which allows you to apply [post-processing effects](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/integration-with-post-processing.html) to a camera based on the position of a Transform in your scene.
-   The [Camera component](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/camera-component-reference.html), which exposes URP-specific properties in the Inspector.

For a general introduction to how cameras work in Unity, and examples of common Camera workflows, refer to [Cameras](https://docs.unity3d.com/Manual/CamerasOverview.html).

## Additional resources

-   [Cameras in the Built-In Render Pipeline](https://docs.unity3d.com/6000.3/Documentation/Manual/cameras-birp.html)
