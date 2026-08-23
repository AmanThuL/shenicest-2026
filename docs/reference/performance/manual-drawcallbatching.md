---
title: "Introduction to batching meshes"
page_title: "Unity - Manual: Introduction to batching meshes"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/DrawCallBatching.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/DrawCallBatching.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to batching meshes

Batching is a [draw call optimization](https://docs.unity3d.com/6000.3/Documentation/Manual/optimizing-draw-calls.html) method that combines meshes that use the same material, so that Unity can render them using fewer updates to the render state. Batching can improve performance, memory efficiency, and reduce CPU overhead, leading to a smoother frame rate and better player experience.

Batching has the following limitations:

-   Batching supports only [Mesh Renderers](https://docs.unity3d.com/6000.3/Documentation/Manual/class-MeshRenderer.html). Batching doesn’t support Skinned Mesh Renderers.
-   Batching of transparent GameObjects might be limited because Unity sorts all meshes back-to-front before batching.
-   Unity can’t use dynamic batching to batch GameObjects that use negative scale in their [Transform](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Transform.html) components with GameObjects that use positive scale.

You can also [manually combine meshes](https://docs.unity3d.com/6000.3/Documentation/Manual/combining-meshes.html), but as a result you can’t cull meshes individually.

## Batch static GameObjects

Static batching combines multiple static meshes into one vertex buffer and one index buffer, using coordinates in world space. Each buffer can contain up to 64,000 vertices, but Unity can create multiple batches.

You can use static batching in two ways:

-   [At build time](https://docs.unity3d.com/6000.3/Documentation/Manual/DrawCallBatching-Enable.html)
-   [At runtime](https://docs.unity3d.com/6000.3/Documentation/Manual/static-batching-enable.html)

## Batch moving GameObjects

**Warning:** For most uses, dynamic batching is no longer recommended, because the CPU overhead might be greater than the overhead of a draw call. For more information, refer to [Choose a draw call optimization method](https://docs.unity3d.com/6000.3/Documentation/Manual/optimizing-draw-calls-choose-method.html).

Dynamic batching is recommended only on lower-end devices. It does the following at runtime:

-   Transforms mesh vertices into world space on the CPU rather than on the GPU, and groups them together into one draw call.
-   For geometry generated at runtime, such as particles, lines, and trails, Unity batches all the meshes into a single vertex buffer, then submits one draw call for each mesh. This is similar to static batching.

Unity also batches meshes when it renders shadows, if the material values the shadow pass uses are the same. For example, if you have multiple crates with the same material but different textures, Unity can still batch the shadows.

Dynamic batching has the following limitations:

-   Not supported in the High Definition Render Pipeline (HDRP).
-   Meshes must not exceed 900 vertex attributes or 300 vertices. As a result, if you use more vertex attributes, fewer meshes can be batched.
-   If GameObjects uses lighting from lightmap textures, they must all use the same lightmap texture and UVs.
-   Supports only the first render pass in a multi-pass shader. As a result, Unity can’t batch draw calls for additional per-pixel lights in Unity shaders.

For more information, refer to [Batch meshes at runtime](https://docs.unity3d.com/6000.3/Documentation/Manual/static-batching-enable.html).

## Additional resources

-   [Choose a draw call optimization method](https://docs.unity3d.com/6000.3/Documentation/Manual/choose-draw-call-optimization-method)
