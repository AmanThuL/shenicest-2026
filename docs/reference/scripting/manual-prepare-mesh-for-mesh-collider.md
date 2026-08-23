---
title: "Unity 6.3 Manual: Prepare a Mesh for Mesh colliders"
page_title: "Unity - Manual: Prepare a Mesh for Mesh colliders"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/prepare-mesh-for-mesh-collider.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/prepare-mesh-for-mesh-collider.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Prepare a Mesh for Mesh colliders

Mesh colliders require a GameObject’s [Mesh](https://docs.unity3d.com/6000.3/Documentation/Manual/mesh.html) to be properly configured so that collisions are accurate.

<span id="allow-read-write-access"></span>

## Allow read and write access to a Mesh

There are particular configurations and optimizations that require a Mesh to be read/write enabled. For details on what “read/write” means in this context, refer to documentation on the Mesh API property [`Mesh.isReadable`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mesh-isReadable.html).

A Mesh must be read/write enabled if any of the following circumstances are true:

-   The attached Mesh collider’s Transform has negative scaling (for example, (–1, 1, 1)) and the Mesh is convex.
-   The attached Mesh collider’s Transform is skewed or sheared (for example, when a rotated Transform has a scaled parent Transform).
-   The Mesh collider’s **Cooking Options** (see [Configure Mesh cooking](https://docs.unity3d.com/6000.3/Documentation/Manual/prepare-mesh-for-mesh-collider.html#configure-mesh-cooking)) are set to any value other than the default (that is, everything enabled except **None**).

### Make a Mesh read/write enabled

To make a Mesh read/write enabled, the Mesh must have a `Mesh.isReadable` value of `true`. To apply this via the Editor:

1.  In the Project window, select the model file (for example, the FBX file) that contains the Mesh.
2.  In the Inspector, select **Model**.
3.  In the **Meshes** section, enable **Read/Write**.

<span id="configure-mesh-cooking"></span>

## Configure Mesh cooking

To calculate collisions with a Mesh collider, the physics system needs to be able to access the Mesh’s geometry. “Mesh cooking” refers to the process of converting a 3D mesh from its original format (for example, FBX or OBJ) into a format that the physics system can read. The cooking process takes the raw Mesh data and builds spatial search structures so that Unity can respond to physics queries more quickly.

You can trigger Mesh cooking in the Import Settings (**Import Settings** \> **Model** \> **Generate Colliders**) or at run time.

### Optimize Mesh cooking at run time

During the Mesh cooking process, Unity can apply various optimizations to reduce the size and complexity of the Mesh (for example: removing redundant vertices, merging overlapping triangles, or simplifying the geometry to reduce the number of triangles). Unity can then load the optimized mesh more quickly and efficiently, which reduces memory use and improves overall performance.

To control which optimizations run, use the Mesh collider’s **Cooking Options** property (which corresponds to the C# enum [`MeshColliderCookingOptions`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MeshColliderCookingOptions.html)). For an overview of the different cooking options available, see the [Mesh collider component reference](https://docs.unity3d.com/6000.3/Documentation/Manual/class-MeshCollider.html).

The default **Cooking Options** are suitable for any Mesh collider that you cook in the Editor and never re-cook at run time. They are also suitable for most Mesh colliders that you need at run time (particularly large or complicated Meshes that only need to cook once). However, you might need to alter the **Cooking Options** to make collider generation faster if you need to rapidly generate collision geometry at run time (for example, procedural surfaces, or Mesh colliders that deform in response to player behaviour).

To optimize Mesh cooking for Meshes that Unity generates at run time, you can disable the data cleaning steps (**Enable Mesh Cleaning**, and **Weld Co-Located Vertices**). However, if you disable the data cleaning steps, you must have another way to validate your Mesh data, to ensure you aren’t using data that those algorithms would otherwise clean.

-   If **Enable Mesh Cleaning** is disabled, you must ensure that the Mesh has no degenerate triangles (for example, thin triangles where the points are collinear, or triangles with an area close to zero or infinity).
-   If **Weld Colocated Vertices** is disabled, you must ensure that the Mesh has no co-located vertices (that is, multiple vertices existing in the same location).

You can also disable **Cook For Faster Simulation** to save memory usage.

When you change the **Cooking Options**, you need to apply read/write permission to the Mesh. For guidance on how to do this, see [Allow read and write access to a Mesh](https://docs.unity3d.com/6000.3/Documentation/Manual/prepare-mesh-for-mesh-collider.html#allow-read-write-access).

## Optimize non-rendered Meshes

If a Mesh only needs to provide data for physics calculations and not for rendering (for example, for invisible colliders), you don’t need to import the Mesh’s normals. Meshes without normals require less memory and use less disk space.

To disable normals:

1.  In the Project window, select the Mesh.
2.  In the Inspector’s Import settings, select **Model**.
3.  Navigate to the Geometry section and set **Normals** to **None**.
