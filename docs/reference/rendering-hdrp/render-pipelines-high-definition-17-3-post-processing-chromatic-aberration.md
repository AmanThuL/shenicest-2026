---
title: "Chromatic Aberration"
page_title: "Chromatic Aberration | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Chromatic-Aberration.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Chromatic-Aberration.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Chromatic Aberration

Chromatic Aberration mimics the effect that a real-world camera produces when its lens fails to join all colors to the same point.

For more information on the Chromatic Aberration effect, see the [Chromatic Aberration](https://docs.unity3d.com/Manual/PostProcessing-ChromaticAberration.html) documentation in the Unity Manual.

## Using Chromatic Aberration

**Chromatic Aberration** uses the [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) framework, so to enable and modify **Chromatic Aberration** properties, you must add a **Chromatic Aberration** override to a [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) in your Scene. To add **Chromatic Aberration** to a Volume:

1.  In the Scene or Hierarchy view, select a GameObject that contains a Volume component to view it in the Inspector.
2.  In the Inspector, go to **Add Override** \> **Post-processing** and select **Chromatic Aberration**. HDRP now applies **Chromatic Aberration** to any Camera this Volume affects.

### API

To access and control this override at runtime, use the [Volume scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#changing-volume-profile-properties). Because of how the Volume system works, you edit properties in a different way to standard Unity components. There are also other nuances to be aware of too, such as each property has an [overrideState](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest/index.html?subfolder=/api/UnityEngine.Rendering.VolumeParameter.html%23UnityEngine_Rendering_VolumeParameter_overrideState). This indicates to the Volume system whether to use the property value you set, or use the default value stored in the [Volume Profile](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-volume-profile.html). For information on how to use the API correctly, see [Volume scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#changing-volume-profile-properties).

## Properties

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr>
<th><strong>Property</strong></th>
<th><strong>Description</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>Spectral Lut</strong></td>
<td>Assign a Texture to use for a custom fringing color. Leave this field empty to use the default Texture.</td>
</tr>
<tr>
<td><strong>Intensity</strong></td>
<td>Use the slider to set the strength of the Chromatic Aberration effect.</td>
</tr>
<tr>
<td><strong>Quality</strong></td>
<td>Specify the quality level HDRP uses for performance relevant parameters:<br />
<br />
• <strong>Custom</strong>: Set your own <strong>Max Samples</strong> value, using the slider below.<br />
<br />
• <strong>Low</strong>: Use the low <strong>Max Samples</strong> value, predefined in your HDRP Asset.<br />
<br />
• <strong>Medium</strong>: Use the medium <strong>Max Samples</strong> value, predefined in your HDRP Asset.<br />
<br />
• <strong>High</strong>: Use the high <strong>Max Samples</strong> value, predefined in your HDRP Asset.</td>
</tr>
<tr>
<td><strong>Max Samples</strong></td>
<td>Use the slider to set the maximum number of samples that HDRP uses to render the Chromatic Aberration effect.</td>
</tr>
</tbody>
</table>

## Details

From 2019.3, HDRP provides lookup Textures that you can use to customize this effect. These lookup Textures are for the **Spectral Lut** property. To add these Textures to your Unity Project, you must use the Package Manager:

1.  Select **Window** \> **Package Management** \> **Package Manager**.
2.  In the **Packages** window, select **High Definition RP**.
3.  In the **High Definition RP** section, go to **Additional Post-processing Data** and select **Import into Project**.
4.  The Textures that are relevant to Chromatic Aberration are in the **Spectral LUTs** folder, so if you only want the lookup Textures for Chromatic Aberration, only import the contents of the **Spectral LUTs** folder.

Care is needed when using the [Bloom](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Bloom.html) effect with Chromatic Abberation. For performance reasons, Chromatic Aberation is computed after the Bloom computation. This results in Bloom overpowering the Chromatic Aberration effect when the Bloom Intensity is set to a very high value. However, in a typical Bloom configuration, the Intensity should never need to be set high enough for this to be an issue.
