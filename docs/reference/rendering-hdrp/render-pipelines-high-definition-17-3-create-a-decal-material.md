---
title: "Create a decal material"
page_title: "Create a decal material | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-decal-material.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-decal-material.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Create a decal material

## Create a Decal shader material

New Materials in HDRP use the [Lit Shader](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/lit-material.html) by default. To create a Decal Material:

1.  In the Unity Editor, navigate to your Project's Asset window.
2.  Right-click the Asset Window and select **Create \> Material**. This adds a new Material to your Unity Project’s Asset folder.
3.  Click the **Shader** drop-down at the top of the Material Inspector, and select **HDRP \> Decal**.

Refer to [Decal Material Inspector reference](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/decal-material-inspector-reference.html) for more information.

## Create a Decal Shader Graph

To create a Decal material in Shader Graph, use one of the following methods:

- Modify an existing Shader Graph.
  1.  Open the Shader Graph in the Shader Editor.
  2.  In **Graph Settings**, select the **HDRP** Target. If there isn't one, go to **Active Targets,** click the **Plus** button, and select **HDRP**.
  3.  In the **Material** drop-down, select **Decal**.
- Create a new Shader Graph. Go to **Assets** \> **Create** \> **Shader Graph** \> **HDRP** and click **Decal Shader Graph**.

Refer to [Decal Master Stack reference](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/decal-master-stack-reference.html) for more information.
