---
title: "Lit material"
page_title: "Lit material | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/lit-material.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/lit-material.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Lit material

The Lit Shader and the Lit Master Stack lets you easily create realistic materials in the High Definition Render Pipeline (HDRP). They include options for effects like subsurface scattering, iridescence, vertex or pixel displacement, and decal compatibility. For more information about Materials, Shaders, and Textures, see the [Unity User Manual](https://docs.unity3d.com/Manual/Shaders.html).

![Example of realistic materials created with the Lit Shader and the Lit Master Stack.](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/HDRPFeatures-LitShader.png)

<span id="creating-a-lit-material"></span>

## Creating a Lit Material

To create a new Lit Material, navigate to your Project's Asset window, right-click in the window and select **Create \> Material**. This adds a new Material to your Unity Project’s Asset folder. When you create new Materials in HDRP, they use the Lit Shader by default.

Refer to [Lit Material Inspector reference](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/lit-material-inspector-reference.html) for more information.

## Creating a Lit Shader Graph

To create a Lit material in Shader Graph, use one of the following methods:

- Modify an existing Shader Graph.

  1.  Open the Shader Graph in the Shader Editor.
  2.  In **Graph Settings**, select the **HDRP** Target. If there isn't one, go to **Active Targets,** click the **Plus** button, and select **HDRP**.
  3.  In the **Material** drop-down, select **Lit**.

- Create a new Shader Graph. Go to **Assets** \> **Create** \> **Shader Graph** \> **HDRP** and select **Lit Shader Graph**.

Refer to [Lit Master Stack reference](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/lit-master-stack-reference.html) for more information.
