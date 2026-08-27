---
title: "Unlit material"
page_title: "Unlit material | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/unlit-material.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/unlit-material.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Unlit material

The Unlit Shader and the Unlit Shader Graph let you create Materials that are not affected by lighting. They include options for the Surface Type, Emissive Color, and GPU Instancing. For more information about Materials, Shaders and Textures, see the [Unity User Manual](https://docs.unity3d.com/Manual/Shaders.html).

![Two glowing strip lights in a very dark industrial environment.](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/HDRPFeatures-UnlitShader.png)

## Creating an Unlit Material

New Materials in HDRP use the [Lit Shader](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/lit-material.html) by default. To create an Unlit Material, you need to create a new Material then make it use the Unlit Shader. To do this:

1.  In the Unity Editor, navigate to your Project's Asset window.

2.  Right-click the Asset Window and select **Create \> Material**. This adds a new Material to your Unity Project’s Asset folder.

3.  Click the **Shader** drop-down at the top of the Material Inspector, and select **HDRP \> Unlit**.

Refer to [Unlit Material Inspector reference](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/unlit-material-inspector-reference.html) for more information.

## Creating an Unlit Shader Graph

To create an Unlit material in Shader Graph, you can either:

- Modify an existing Shader Graph.

  1.  Open the Shader Graph in the Shader Editor.
  2.  In **Graph Settings**, select the **HDRP** Target. If there isn't one, go to **Active Targets,** click the **Plus** button and select **HDRP**.
  3.  In the **Material** drop-down, select **Unlit**.

- Create a new Shader Graph. Go to **Assets** \> **Create** \> **Shader Graph** \> **HDRP** and select **Unlit Shader Graph**.

Refer to [Unlit Master Stack reference](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/unlit-master-stack-reference.html) for more information.
