---
title: "Set up GameObjects for batching"
page_title: "Unity - Manual: Set up GameObjects for batching"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/DrawCallBatching-SetUp.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/DrawCallBatching-SetUp.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Set up GameObjects for batching

For more information about batching, refer to [Introduction to batching meshes](https://docs.unity3d.com/6000.3/Documentation/Manual/DrawCallBatching.html).

## Get the best results from batching

To get the best results from batching, do the following:

-   Share materials among as many GameObjects as possible.
-   If you have two material assets that are identical apart from their textures, combine the textures into a single, larger texture.
-   [Profile](https://docs.unity3d.com/6000.3/Documentation/Manual/profile-rendering.html) the performance of your application with batching turned on and off.

## Check whether Unity batches GameObjects

To check whether Unity batches GameObjects, open the [Frame Debugger](https://docs.unity3d.com/6000.3/Documentation/Manual/FrameDebugger.html) and check for either of the following:

-   Render passes called **Draw Static** or **Draw Dynamic**.
-   **Combined Mesh** in the event details of the **Meshes section**.

If Unity isn’t batching GameObjects, check the following for each GameObject:

-   The GameObject is active.
-   The GameObject has an enabled [Mesh Renderer](https://docs.unity3d.com/6000.3/Documentation/Manual/class-MeshRenderer.html) component.
-   None of the materials in the Mesh Renderer component use shaders that have `DisableBatching` set to `true`.
-   The GameObject has an enabled [Mesh Filter](https://docs.unity3d.com/6000.3/Documentation/Manual/class-MeshFilter.html) component with a [Mesh](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Mesh.html).
-   The mesh has a vertex count greater than 0, and hasn’t already been combined with another mesh.
-   The meshes use the same vertex attribute layout. For example, Unity can’t batch a mesh that uses UVs with one that doesn’t.

If you use static batching, check the following:

-   The GameObject uses the same mesh, shader variant, texture samplers, lightmap, and layer as other meshes you want to batch.
-   The mesh is not very small.
-   The mesh doesn’t use LOD fading.

## Additional resources

-   [Reduce rendering work on the GPU or CPU](https://docs.unity3d.com/6000.3/Documentation/Manual/OptimizingGraphicsPerformance.html).
