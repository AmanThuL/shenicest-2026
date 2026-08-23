---
title: "Introduction to level of detail"
page_title: "Unity - Manual: Introduction to level of detail"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/LevelOfDetail.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/LevelOfDetail.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to level of detail

Level of detail (LOD) is a technique that improves performance by reducing the rendering workload.

Without a LOD solution, Unity renders an object with the same complexity no matter the size of the object on the screen. For example, in one frame, a 3D model of a building might occupy the whole game view. Then a player moves away from the building and it might be only a few pixels high on the screen, but Unity has to render the same mesh.

With a LOD solution, as a GameObject becomes smaller on the screen, Unity can reduce the rendering workload using one or a combination of the following approaches:

-   Reduce the number of polygons to render.

-   Reduce the complexity or the number of materials to render.

-   Reduce the number of **Mesh Renderer** components.

Unity refers to objects representing levels of detail using indices, where a LOD with index 0 (LOD0) represents the most detailed LOD, and LODs with higher indices have progressively lower amounts of detail (LOD1, LOD2, and so on).

![Left: at LOD0, meshes have a large number of small triangles. Right: at LOD1, the meshes have far fewer triangles, which are much larger in size.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/lod/lod-introduction-general.jpg)

## LOD features in Unity

Unity implements two different LOD features:

-   [Mesh LOD](https://docs.unity3d.com/6000.3/Documentation/Manual/lod/mesh-lod-introduction.html)

-   [LOD Group](https://docs.unity3d.com/6000.3/Documentation/Manual/lod/lod-group-landing.html)

Each feature has its advantages and uses a different format for LOD objects. The following table provides a comparison of key characteristics of the features.

<table><thead><tr class="header"><th style="text-align: left;"><strong>Mesh LOD</strong></th><th style="text-align: left;"><strong>LOD Group</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;">The feature focuses on reducing the number of polygons to draw with minimum memory footprint and computational overhead. Does not optimize materials or number of draw calls.</td><td style="text-align: left;">A flexible solution with a larger memory footprint and computational overhead. When authoring LOD objects, you have the following optimization options for each LOD:<ul><li>Create a less detailed mesh.</li><li>Reduce the number of materials or submeshes, which reduces the number of draw calls.</li><li>Optimize settings on materials.</li><li>Optimize <strong>Mesh Renderer</strong> settings.</li></ul></td></tr><tr class="even"><td style="text-align: left;">Provides the option to create LODs automatically on model import.</td><td style="text-align: left;">Requires manual authoring of each LOD mesh in an external tool.</td></tr><tr class="odd"><td style="text-align: left;">Unity stores each LOD in the index buffer of the original mesh.</td><td style="text-align: left;">Each LOD is one or a set of Mesh Renderer components. Users can access and configure each LOD using the Editor interface.</td></tr><tr class="even"><td style="text-align: left;">Provides a smaller memory footprint compared with LOD Group. Has a smaller rendering workload overhead compared to LOD Group because Mesh LOD does not use any extra GameObjects, components, or meshes.</td><td style="text-align: left;">Has a larger memory footprint and computational overhead compared with Mesh LOD.</td></tr><tr class="odd"><td style="text-align: left;">Provides parameters that control LOD transitions implicitly.</td><td style="text-align: left;">Lets users explicitly specify object size on screen at which a LOD transition occurs per LOD index.</td></tr></tbody></table>

## LOD transitions

By default, Unity displays one LOD at a time. When Unity transitions from one LOD to another, the transition is noticeable and abrupt.

To make LOD transitions smooth, enable LOD cross-fading. Unity renders both the current and the next LOD, and blends them together.

![A sphere (LOD 1) blends smoothly into a cube (LOD 2) as the camera zooms out.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/lod/lod-crossfade.gif)

For more information, refer to:

-   [Make LOD transitions smooth in Mesh LOD](https://docs.unity3d.com/6000.3/Documentation/Manual/lod/lod-transitions-mesh-lod.html)
-   [Make LOD transitions smooth in LOD Group](https://docs.unity3d.com/6000.3/Documentation/Manual/lod/lod-transitions-lod-group.html)

**Additional resources**

-   [LOD directive in ShaderLab reference](https://docs.unity3d.com/6000.3/Documentation/Manual/SL-ShaderLOD.html)

-   [Introduction to Mesh LOD](https://docs.unity3d.com/6000.3/Documentation/Manual/lod/mesh-lod-introduction.html)

-   [LOD Group](https://docs.unity3d.com/6000.3/Documentation/Manual/lod/lod-group-landing.html)
