---
title: "Lit Tessellation material"
page_title: "Lit Tessellation material | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/lit-tessellation-material.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/lit-tessellation-material.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Lit Tessellation material

The Lit Tessellation Shader allows you to create Materials that use tessellation to provide adaptive vertex density for meshes. This means that you can render more detailed geometry without the need to create a model that contains a lot of vertices. This Shader also includes options for effects like subsurface scattering, iridescence, vertex or pixel displacement, and decal compatibility. For more information about Materials, Shaders, and Textures, see the [Unity User Manual](https://docs.unity3d.com/Manual/Shaders.html).

![Tessellation Mode set to None (off).](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/LitTessellationShader1.png)

**Tessellation Mode** set to **None** (off).

![Tessellation Mode set to Phong (on).](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/LitTessellationShader2.png)

**Tessellation Mode** set to **Phong** (on).

## Creating a Lit Tessellation Material

To create a new Lit Tessellation Material:

1.  Right-click in your Project's Asset window.
2.  Select **Create** \> **Material**. This adds a new Material to your Unity Project’s Asset folder.
3.  Select the Material and, in the Inspector, select the **Shader** drop-down.
4.  Select **HDRP** \> **LitTessellation**.

Refer to [Lit Tessellation Material Inspector reference](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/lit-tessellation-material-inspector-reference.html) for more information.
