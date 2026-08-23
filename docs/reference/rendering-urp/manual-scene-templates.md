---
title: "Scene templates in URP"
page_title: "Unity - Manual: Scene templates in URP"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/scene-templates.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/scene-templates.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Scene templates in URP

You can use [Scene Templates](https://docs.unity3d.com/Manual/scene-templates.html) to quickly create scenes that include pre-configured URP-specific settings and post-processing effects. For information on how to create a new scene from a Scene Template, refer to [Creating a new scene from the New Scene dialog](https://docs.unity3d.com/Manual/scenes-working-with.html#creating-a-new-scene-from-the-new-scene-dialog).

![The New Scene dialog displaying Scene Templates.](https://docs.unity3d.com/6000.3/Documentation/uploads/urp/scene-templates.png)

The following Scene Templates are available for URP:

-   **Basic (URP)**: A scene that contains a [Camera](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/camera-component-reference.html) and a [Light](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/light-component.html). This is the URP equivalent of Unity’s default scene.
-   **Standard (URP)**: A scene that contains a Camera, a Light, and a global [Volume](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/Volumes.html) with various post-processing effects. **Note**: If you create a scene using the Standard (URP) Scene Template, Unity creates a new [Volume Profile](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/Volume-Profile.html) to store the post-processing effects.
