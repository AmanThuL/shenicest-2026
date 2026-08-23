---
title: "Import or create LOD levels for a LOD Group"
page_title: "Unity - Manual: Import or create LOD levels for a LOD Group"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/lod-group-configure.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/lod-group-configure.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Import or create LOD levels for a LOD Group

To import or create LOD levels for a LOD Group component in a GameObject, use one of the following methods:

-   Add a LOD Group component, then manually add a renderer to each LOD level.
-   Import a model with LOD levels you created in an external 3D modeling application. Unity adds a LOD Group component to the GameObject and configures it automatically.

## Import LOD levels

Follow these steps:

1.  In your external 3D application, follow the application’s process to create as many LOD meshes as you need.

2.  Add the suffix `_LODX` to the name of each mesh, where `X` represents the LOD index. For example, use `ExampleMeshName_LOD0` for the most detailed LOD.

    The LOD Group component accepts a maximum of eight LOD levels. Unity uses LOD 0 closest to the camera, so it should be the most detailed LOD level.

3.  Export your model as a .fbx file.

4.  Import the .fbx file into Unity.

Unity automatically creates a [LOD Group component](https://docs.unity3d.com/6000.3/Documentation/Manual/class-LODGroup.html) with the appropriate settings.

## Manually add a LOD Group component and LOD levels

To manually add a LOD Group component and LOD levels to a GameObject, follow these steps:

1.  In the **Hierarchy** window, create an empty GameObject.
2.  Add child GameObjects for the LOD levels you want, each containing the Renderer components for that LOD level.
3.  Select the empty GameObject, then in the **Inspector** window select **Add Component**, then **Rendering** > **LOD Group**.
4.  In the **LOD Group** component, select a LOD level box to open the LOD level settings.
5.  In the **Renderers** panel, select the **Add** (**+**) button, then select the Renderer picker (**⊙**) or drag and drop to add the child GameObject that contains the Renderers for this LOD level.
6.  Repeat steps 4 and 5 for each LOD level.

To add or delete a LOD levels, right-click on the LOD level boxes.

## Configure project-wide LOD settings

To configure LOD settings for all the LOD Groups in your project, use the following settings in the [Quality settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-QualitySettings.html) window:

-   **Maximum LOD Level**: Exclude meshes above a specified LOD level from your build.
-   **LOD Bias**: Determine whether to favor higher or lower LOD levels at threshold distances.

## Additional resources

-   [LOD Group component reference](https://docs.unity3d.com/6000.3/Documentation/Manual/class-LODGroup.html)
-   [Make LOD transitions smooth in LOD Group](https://docs.unity3d.com/6000.3/Documentation/Manual/lod/lod-transitions-lod-group.html)
-   [Importing models](https://docs.unity3d.com/Manual/ImportingModelFiles.html).
-   [Creating LODs in Maya](https://learn.unity.com/tutorial/creating-lods-in-maya-for-unity)
