---
title: "Create an HDRI sky"
page_title: "Create an HDRI sky | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-an-hdri-sky.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-an-hdri-sky.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Create an HDRI sky

A High-dynamic-range imaging (HDRI) Sky is a simple sky representation that uses a cubemap texture. You can define how HDRP updates the indirect lighting the sky generates in the Scene. For information on supported cubemap layouts, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-Cubemap-create.html" class="xref">Create a cubemap</a>.

Tip: [Unity HDRI Pack](https://assetstore.unity.com/packages/essentials/beta-projects/unity-hdri-pack-72511) is available on the Unity Asset Store and provides 7 pre-converted HDR Cubemaps ready for use within your Project.

![A stylized car floating on a dirt road in a vast plain.](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/HDRPFeatures-HDRISky.png)

## Using HDRI Sky

**HDRI Sky** uses the [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) framework, so to enable and modify **HDRI Sky** properties, you must add an **HDRI Sky** override to a [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) in your Scene. To add **HDRI Sky** to a Volume:

1.  In the Scene or Hierarchy view, select a GameObject that contains a Volume component to view it in the Inspector.
2.  In the Inspector, go to **Add Override** \> **Sky** and select **HDRI Sky**.

After you add an **HDRI Sky** override, you must set the Volume to use **HDRI Sky**. The [Visual Environment](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/visual-environment-volume-override-reference.html) override controls which type of sky the Volume uses. To set the Volume to use **HDRI Sky**:

1.  In the **Visual Environment** override, go to **Sky** \> **Sky Type**.
2.  Set **Sky Type** to **HDRI Sky**.

HDRP now renders an **HDRI Sky** for any Camera this Volume affects.

Refer to the [HDRI Sky Volume Override Reference](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/hdri-sky-volume-override-reference.html) for more information.

### API

To access and control this override at runtime, use the [Volume scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#changing-volume-profile-properties). Because of how the Volume system works, you edit properties in a different way to standard Unity components. There are also other nuances to be aware of too, such as each property has an [overrideState](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest/index.html?subfolder=/api/UnityEngine.Rendering.VolumeParameter.html%23UnityEngine_Rendering_VolumeParameter_overrideState). This indicates to the Volume system whether to use the property value you set, or use the default value stored in the [Volume Profile](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-volume-profile.html). For information on how to use the API correctly, see [Volume scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#changing-volume-profile-properties).
