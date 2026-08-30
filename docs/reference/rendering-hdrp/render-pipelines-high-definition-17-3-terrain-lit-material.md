---
title: "Terrain Lit material"
page_title: "Terrain Lit material | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/terrain-lit-material.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/terrain-lit-material.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Terrain Lit material

The High Definition Render Pipeline (HDRP) uses the Terrain Lit Shader for Unity Terrain. This Shader is a simpler version of the [Lit Shader](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/lit-material.html). A Terrain can use a Terrain Lit Material with up to eight [Terrain Layers](https://docs.unity3d.com/Manual/class-TerrainLayer.html).

![Sample Terrain Lit Material](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/HDRPFeatures-TerrainShader.png)

## Creating a Terrain Lit Material

To create a new Terrain Lit Shader Material:

1.  Go to your Project window and right-click in the **Assets** folder
2.  Select **Create** \> **Material**. This adds a new Material to your Unity Project’s Asset folder.
3.  Click on the Material to view it in the Inspector.
4.  Click on the **Shader** drop-down and select **HDRP** \> **TerrainLit**.

Refer to [Terrain Lit Material Inspector reference](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/terrain-lit-material-inspector-reference.html) for more information.

## Using a Terrain Lit Material

To use a Terrain Lit Material, you must assign it to a Terrain:

1.  View the Terrain in the Inspector window and select **Terrain Settings**.
2.  Either drag and drop or use the radio button to assign your Terrain Lit Material to the **Material** property.

![Terrain Lit Material Inspector.](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/TerrainLitShader1.png)

## Using the Paint Holes Tool

If you use the **Paint Holes** tool on your terrain, enable the **Terrain Hole** feature in your Project's HDRP Asset. Otherwise, the holes don't appear when you build your application. To do this:

1.  Open your HDRP Asset in the Inspector window.
2.  Go to **Rendering** and enable **Terrain Hole**.
