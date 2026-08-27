---
title: "Convert materials and shaders to HDRP"
page_title: "Convert materials and shaders | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/convert-from-built-in-convert-materials-and-shaders.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/convert-from-built-in-convert-materials-and-shaders.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Convert materials and shaders

To upgrade the Materials in your Scene to HDRP-compatible Materials:

1.  Go to **Edit** \> **Rendering** \> **Materials**

2.  Choose one of the following options:

    - **Convert All Built-in Materials to HDRP**: Converts every compatible Material in your Project to an HDRP Material.
    - **Convert Selected Built-in Materials to HDRP**: Converts every compatible Material currently selected in the Project window to an HDRP Material.
    - **Convert Scene Terrains to HDRP Terrains**: Replaces the built-in default standard terrain Material in every [Terrain](https://docs.unity3d.com/Manual/script-Terrain.html) in the scene with HDRP default Terrain Material.

## Limitations

The automatic upgrade options described above can't upgrade all Materials to HDRP correctly:

- You can't automatically upgrade custom Materials or Shaders to HDRP. You must [convert custom Materials and Shaders manually](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/convert-from-built-in-convert-materials-and-shaders.html#ManualConversion).

- HDRP can only convert materials from the **Assets** folder of your project. HDRP uses the <a href="https://docs.unity3d.com/6000.0/Documentation/Manual/shader-error.html" class="xref">error shader</a> for GameObjects that use the default read-only material from the Built-In Render Pipeline, for example <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/PrimitiveObjects.html" class="xref">primitives</a>.

- Height mapped Materials might look incorrect. This is because HDRP supports more height map displacement techniques and decompression options than the Built-in Render Pipeline. To upgrade a Material that uses a heightmap, modify the Material's **Amplitude** and **Base** properties until the result more closely matches the Built-in Render Pipeline version.

- You can't upgrade particle shaders. HDRP doesn't support particle shaders, but it does provide Shader Graphs that are compatible with the [Built-in Particle System](https://docs.unity3d.com/Manual/Built-inParticleSystem.html). These Shader Graphs work in a similar way to the built-in particle shaders. To use these Shader Graphs, import the **Particle System Shader Samples** sample:

  1.  Open the Package Manager window (menu: **Window** \> **Package Management** \> **Package Manager**).
  2.  Find and click the **High Definition RP** entry.
  3.  In the package information for **High Definition RP**, go to the **Samples** section and click the **Import into Project** button next to **Particle System Shader Samples**.

<span id="ManualConversion"></span>

## Converting Materials manually

HDRP uses multiple processes to automatically convert Built-in Standard and Unlit Materials to HDRP Lit and Unlit Materials respectively. These processes use an overlay function to blend the color channels together, similar to the process you would use in image editing software like Adobe Photoshop.

To help you convert custom Materials manually, this section describes the maps that the converter creates from the Built-in Materials.

### Mask maps

The Built-in Shader to HDRP Shader conversion process combines the different Material maps of the Built-in Standard Shader into the separate RGBA channels of the mask map in the HDRP [Lit Material](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/lit-material.html). For information on which color channel each map goes in, see [mask map](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Mask-Map-and-Detail-Map.html#MaskMap).

### Detail maps

The Built-in Shader to HDRP Shader conversion process combines the different detail maps of the Built-in Standard Shader into the separate RGBA channels of the detail map in the HDRP [Lit Material](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/lit-material.html). It also adds a smoothness detail too. For information on which color channel each map goes in, see [detail map](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Mask-Map-and-Detail-Map.html#DetailMap).
