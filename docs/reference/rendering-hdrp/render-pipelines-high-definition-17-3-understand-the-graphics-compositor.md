---
title: "Understand the Graphics Compositor"
page_title: "Understand the Graphics Compositor | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-the-graphics-compositor.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-the-graphics-compositor.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Understand the Graphics Compositor

The Graphics Compositor allows for real-time compositing operations between Unity's High Definition Render Pipeline (HDRP) and external media sources, such as videos or images. Depending on the requirements for your application, the Graphics Compositor provides multiple composition techniques. You can use each technique independently or use more than one at the same time to create a combination of different types of composition operations. The techniques that the Graphics Compositor includes are:

- **Camera Stacking:** Allows you to render multiple [HDRP Cameras](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/hdrp-camera-component-reference.html) to the same render target.
- **Graph-Based Composition:** Allows you to use arbitrary mathematical operations to combine multiple Composition Layers to generate the final frame.
- **3D Composition:** Allows you to use Composition Layers as 3D surfaces in a Unity Scene. This means that, for example, Unity can calculate reflections and refractions between different Composition Layers and GameObjects.

The following table provides a high level overview of the advantages and disadvantages of each compositing technique:

| **Technique** | **Performance** | **Memory Overhead** | **Flexibility** | **Feature Coverage \[\*\]** |
|----|----|----|----|----|
| **Camera Stacking** | High | Low | Low | High |
| **Graph-Based Composition** | Low | High | High | Low |
| **3D Composition** | Low | High | Low | High |

\[\*\] Feature Coverage indicates whether features such as [screen-space reflections](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Override-Screen-Space-Reflection.html), transparencies or refractions can work between layers.

The Graphics Compositor also includes functionality such as localized post-processing, where a Post-Processing Volume only affects certain GameObjects in the Scene.

For an overview of the Graphics Compositor's functionality, refer to [Use the Graphics Compositor](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/use-the-graphics-compositor.html). For a description on specific options in the user interface, refer to [Graphics Compositor window reference](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/graphics-compositor-window-reference.html).

Limitation: The Graphics Compositor is not compatible with Virtual Reality.
