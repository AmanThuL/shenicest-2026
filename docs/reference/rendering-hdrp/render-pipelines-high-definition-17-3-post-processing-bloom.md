---
title: "Bloom"
page_title: "Bloom | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Bloom.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Bloom.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Bloom

The Bloom effect creates fringes of light extending from the borders of bright areas in an image. This creates the illusion of an extremely bright light overwhelming the Camera.

Bloom in the High Definition Render Pipeline (HDRP) is energy-conserving. This means that you must use correct physical values for lighting and Materials for it to work correctly. For information on the light units that HDRP uses, see the [Physical Light Units documentation](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Physical-Light-Units.html).

The Bloom effect also has a **Lens Dirt** feature, which you can use to apply a full-screen layer of smudges or dust to diffract the Bloom effect.

## Using Bloom

**Bloom** uses the [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) framework, so to enable and modify **Bloom** properties, you must add a **Bloom** override to a [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) in your Scene. To add **Bloom** to a Volume:

1.  In the Scene or Hierarchy view, select a GameObject that contains a Volume component to view it in the Inspector.
2.  In the Inspector, go to **Add Override** \> **Post-processing** and select **Bloom**. HDRP now applies **Bloom** to any Camera this Volume affects.

Bloom includes [advanced properties](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest?subfolder=/manual/advanced-properties.html) that you must manually expose.

### API

To access and control this override at runtime, use the [Volume scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#changing-volume-profile-properties). Because of how the Volume system works, you edit properties in a different way to standard Unity components. There are also other nuances to be aware of too, such as each property has an [overrideState](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest/index.html?subfolder=/api/UnityEngine.Rendering.VolumeParameter.html%23UnityEngine_Rendering_VolumeParameter_overrideState). This indicates to the Volume system whether to use the property value you set, or use the default value stored in the [Volume Profile](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-volume-profile.html). For information on how to use the API correctly, see [Volume scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#changing-volume-profile-properties).

## Properties

### Bloom

| **Property** | **Description** |
|----|----|
| **Threshold** | Use the slider to set the level of brightness to filter out pixels under this level. This value is expressed in gamma-space. A value higher than 0 will break the energy conservation rule. |
| **Intensity** | Use the slider to set the strength of the Bloom filter. |
| **Scatter** | Use the slider to change the extent of the veiling effect. |
| **Tint** | Use the color picker to select a color for the Bloom effect to tint to. |

### Lens Dirt

| **Property** | **Description** |
|----|----|
| **Texture** | Assign a Texture to apply dirtiness (for example, smudges or dust) to the lens. |
| **Intensity** | Set the strength of the Lens Dirt effect. |

### Advanced Tweaks

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
<td><strong>Resolution</strong></td>
<td>Use the drop-down to set the resolution at which HDRP processes the Bloom effect. If you target consoles that use a very high resolution (for example, 4k), select <strong>Quarter,</strong> because it's less resource-intensive.<br />
• <strong>Quarter</strong>: Uses quarter the screen resolution.<br />
• <strong>Half</strong>: Uses half the screen resolution.<br />
This property only appears when you enable <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest?subfolder=/manual/advanced-properties.html">advanced properties</a>.</td>
</tr>
<tr>
<td><strong>High Quality Prefiltering</strong></td>
<td>Enable the checkbox to make HDRP use 13 samples instead of 4 during the prefiltering pass. This increases the resource intensity of the Bloom effect, but results in less flickering by small and bright objects like the sun.<br />
This property only appears when you enable <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@17.2/manual/advanced-properties.html">additional properties</a>.</td>
</tr>
<tr>
<td><strong>High Quality Filtering</strong></td>
<td>Enable the checkbox to make HDRP use bicubic filtering instead of bilinear filtering. This increases the resource intensity of the Bloom effect, but results in smoother visuals.<br />
This property only appears when you enable <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest?subfolder=/manual/advanced-properties.html">advanced properties</a>.</td>
</tr>
<tr>
<td><strong>Anamorphic</strong></td>
<td>Enable the checkbox to make the bloom effect take the <strong>Anamorphism</strong> property of the Camera into account. This stretches the bloom horizontally or vertically like it would on anamorphic sensors.<br />
This property only appears when you enable <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest?subfolder=/manual/advanced-properties.html">advanced properties</a>.</td>
</tr>
</tbody>
</table>

## Details

From 2019.3, HDRP provides [lookup textures](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Authoring-LUTs.html) that you can use to customize this effect. These lookup textures are for the **Texture** property in the **Lens Dirt** section. To add these Textures to your Unity Project, you must use the Package Manager:

1.  Go to **Window** \> **Package Management** \> **Package Manager**.
2.  In the **Packages** window, select **High Definition RP**.
3.  In the **High Definition RP** section, go to **Additional Post-processing Data** and select **Import into Project**.
4.  The Textures that are relevant to Bloom are in the **Lens Dirt** folder, so if you only want the lookup Textures for Bloom, only import the contents of the **Lens Dirt** folder.

Care is needed when using the Bloom effect with [Chromatic Abberation](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Chromatic-Aberration.html). For performance reasons, Chromatic Aberation is computed after the Bloom computation. This results in Bloom overpowering the Chromatic Aberration effect when the Bloom Intensity is set to a very high value. However, in a typical Bloom configuration, the Intensity should never need to be set high enough for this to be an issue.
