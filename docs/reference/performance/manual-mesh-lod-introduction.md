---
title: "Introduction to Mesh LOD"
page_title: "Unity - Manual: Introduction to Mesh LOD"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/lod/mesh-lod-introduction.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/lod/mesh-lod-introduction.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to Mesh LOD

Mesh LOD reduces the number of polygons Unity has to draw and provides automatic LOD creation.

Mesh LOD creates LODs automatically on model import and stores each LOD in the index buffer of the original mesh. For more information about LOD generation, refer to the following pages:

-   [Generate LODs on import](https://docs.unity3d.com/6000.3/Documentation/Manual/lod/mesh-lod-generate-lods.html)

-   [How the Mesh LOD generator works](https://docs.unity3d.com/6000.3/Documentation/Manual/lod/mesh-lod-generator.html)

At runtime, the Mesh LOD feature selects the appropriate LOD automatically depending on the size of the mesh on the screen, project-wide and per-object Mesh LOD settings. For more information, refer to [Mesh LOD runtime quality](https://docs.unity3d.com/6000.3/Documentation/Manual/lod/mesh-lod-quality.html).

When generating LODs automatically, Unity does not create new GameObjects or components. This means that the Mesh LOD feature only optimizes the workload for rendering geometry, and does not provide options for configuring material or Mesh Renderer settings for less detailed LODs. Being focused on geometry optimization, the feature provides a [smaller memory footprint](https://docs.unity3d.com/6000.3/Documentation/Manual/lod/mesh-lod-generator.html#mesh-lod-memory-footprint) compared with the LOD Group feature.

## Limitations of the Mesh LOD feature

The Mesh LOD feature has the following limitations:

-   The following systems do not support Mesh LOD selection. These systems always select LOD0 with the Mesh LOD feature.

    -   Entities Graphics

    -   Particle System

    -   Visual Effect Graph

    -   [Static batching](https://docs.unity3d.com/6000.3/Documentation/Manual/DrawCallBatching-Enable.html)

    -   [GPU instancing](https://docs.unity3d.com/6000.3/Documentation/Manual/GPUInstancing.html)

-   Mesh LOD supports the [LOD cross-fade](https://docs.unity3d.com/6000.3/Documentation/Manual/lod/lod-transitions-mesh-lod.html) feature with the following limitations:

    -   [GPU Resident Drawer](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/gpu-resident-drawer.html) must be enabled in a project.

    -   Mesh LOD does not support [custom transition zones](https://docs.unity3d.com/6000.3/Documentation/Manual/lod/lod-transitions-lod-group.html#width).

-   When Mesh LOD generates LODs for models with a Skinned Mesh Renderer component, the generator does not take skin weights or blend shape deformations into account during the mesh simplification process. As a consequence, the LOD generator may remove indices that refer to vertices that are important for the intended mesh deformation. For more information, refer to [Skinned Mesh Renderer deformation artifacts](https://docs.unity3d.com/6000.3/Documentation/Manual/lod/mesh-lod-troubleshooting.html#skinned-mesh-renderer-deformation-artifacts).

-   Using Mesh LODs with Skinned Mesh Renderers does not reduce the workload related to calculating mesh deformations. When performing deformations, a Skinned Mesh Renderer deforms LOD0 regardless of which LOD index Unity is currently using for rendering a mesh.

-   Mesh LOD only supports meshes with triangle topology.

-   Unity doesn’t provide functionality to visualize which Mesh LOD index is being rendered.

-   Using Mesh LOD in combination with LOD Group might lead to unexpected outcomes and is not recommended.

-   The following APIs do not support automatic Mesh LOD selection and require explicitly specifying which LOD to draw. To specify an LOD in these methods, use the `forceMeshLod` property in the [RenderParams](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RenderParams.html) struct.

    -   [Graphics.RenderMeshInstanced](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Graphics.RenderMeshInstanced.html)

    -   [Graphics.RenderMeshIndirect](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Graphics.RenderMeshIndirect.html)

    -   [Graphics.RenderMeshPrimitives](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Graphics.RenderMeshPrimitives.html)

## Additional resources

-   [Troubleshooting Mesh LOD visual artifacts](https://docs.unity3d.com/6000.3/Documentation/Manual/lod/mesh-lod-troubleshooting.html)

-   [Introduction to level of detail](https://docs.unity3d.com/6000.3/Documentation/Manual/LevelOfDetail.html)

-   [LOD Group](https://docs.unity3d.com/6000.3/Documentation/Manual/lod/lod-group-landing.html)
