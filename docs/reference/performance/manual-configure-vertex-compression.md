---
title: "Configure vertex compression"
page_title: "Unity - Manual: Configure vertex compression"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/configure-vertex-compression.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/configure-vertex-compression.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Configure vertex compression

To use the Vertex Compression setting, you must first prepare the mesh, then apply compression in the project’s optimization settings.

### Prepare the mesh for vertex compression

The mesh must meet the following requirements to use vertex compression:

-   The mesh must have its **Read/Write Enabled** property disabled. You can change this property in the Model tab of the Model Import Settings window.
-   The mesh must not be a skinned mesh.
-   The target platform must support FP16 values.
-   The model that contains the mesh must have its **Mesh Compression** value set to “Off”.
-   The mesh is not eligible for dynamic batching or dynamic batching is turned off in the player settings.

If a mesh fails to meet any of these requirements, then Unity does not apply vertex compression to that mesh and all data channels on the mesh use FP32 precision numbers.

### Configure Vertex Compression

To change the Vertex Compression settings:

1.  Open the Player settings (menu: **Edit** > **Project Settings** > **Player**).
2.  Open the **Other Settings** submenu and navigate to the **Optimization** heading.
3.  Select the **Vertex Compression** dropdown and select any channel to enable or disable compression for that channel. You can also select **None** to disable compression for all channels, or select **Everything** to enable compression for all channels.

By default, Vertex Compression is set to **Mixed**, which Unity displays when multiple selections are active in the dropdown. By default, Unity uses Vertex Compression for the following channels:

-   Normal
-   Tangent
-   Tex Coord 0
-   Tex Coord 2
-   Tex Coord 3

Unity compresses these channels by default because in most cases this combination of settings provides a good mixture of saved memory without significant changes to how the mesh looks. Unity doesn’t compress the other settings, Position and Tex Coord 1, by default because these are more likely to affect the appearance of the mesh, and do not offer significant reduction in memory use. If you intend to enable Vertex Compression for the Position and Tex Coord 1 channels, you should test the settings to ensure they don’t cause artifacts in your meshes.
