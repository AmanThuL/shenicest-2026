---
title: "Create a gradient sky"
page_title: "Create a gradient sky | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-gradient-sky.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-gradient-sky.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Create a gradient sky

A gradient sky is a simple representation of the sky, where the High Definition Render Pipeline (HDRP) interpolates between the following three colors:

- **Top**
- **Middle**
- **Bottom**

You can alter these values at runtime.

## Using Gradient Sky

**Gradient Sky** uses the [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) framework, so to enable and modify **Gradient Sky** properties, you must add a **Gradient Sky** override to a [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) in your Scene. To add **Gradient Sky** to a Volume:

1.  In the Scene or Hierarchy view, select a GameObject that contains a Volume component to view it in the Inspector.
2.  In the Inspector, go to **Add Override** \> **Sky** and select on **Gradient Sky**.

After you add a **Gradient Sky** override, you must set the Volume to use **Gradient Sky**. The [Visual Environment](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/visual-environment-volume-override-reference.html) override controls which type of sky the Volume uses. To set the Volume to use **Gradient Sky**:

1.  In the **Visual Environment** override, go to **Sky** \> **Sky Type**
2.  Set **Sky Type** to **Gradient Sky**.

HDRP now renders a **Gradient Sky** for any Camera this Volume affects.

Refer to the [Gradient Sky Volume Override Reference](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/gradient-sky-volume-override-reference.html) for more information.

### API

To access and control this override at runtime, use the [Volume scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#changing-volume-profile-properties). Because of how the Volume system works, you edit properties in a different way to standard Unity components. There are also other nuances to be aware of too, such as each property has an [overrideState](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest/index.html?subfolder=/api/UnityEngine.Rendering.VolumeParameter.html%23UnityEngine_Rendering_VolumeParameter_overrideState). This indicates to the Volume system whether to use the property value you set, or use the default value stored in the [Volume Profile](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-volume-profile.html). For information on how to use the API correctly, see [Volume scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#changing-volume-profile-properties).
