---
title: "Enable and configure volumetric lights"
page_title: "Enable and configure volumetric lights | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumetric-Lighting.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumetric-Lighting.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Enable and configure volumetric lights

The High Definition Render Pipeline (HDRP) includes a volumetric lighting system that renders Volumetric Fog. HDRP also implements a unified lighting system, which means that all Scene components (for example, [Lights](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Light-Component.html), and opaque and transparent GameObjects) interact with the fog to make it volumetric.

## Enable volumetric lighting

To enable and customize Volumetric Lighting in an [HDRP Asset](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html):

1.  Select an HDRP Asset in your Unity Project and view it in the Inspector.
2.  In the **Lighting** section, enable **Volumetrics**.
3.  Go to **Edit** \> **Project Settings** \> **Graphics** \> **Pipeline Specific Settings** \> **HDRP** \> **Frame Settings (Default Values)** \> **Lighting**.
4.  Enable **Fog** and **Volumetrics**.

### Control volumetric lighting quality

To increase the resolution of the volumetrics, in the **Lighting** section of the Inspector, enable **High Quality**. Volumetric lighting is a resource intensive effect and this option can increase the resource intensity by up to eight times.

If you want to enable reprojection support, go to **Edit** \> **Project Settings** \> **Graphics** \> **Pipeline Specific Settings** \> **HDRP** \> **Frame Settings (Default Values)** \> **Lighting** and enable **Reprojection**. Reprojection improves the lighting quality in the Scene by taking previous frames into account when calculating the lighting for the current frame. This option isn't compatible with dynamic lights, so you might encounter ghosting artifacts behind moving Lights. Using high values for **Anisotropy** in the [Fog](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/fog-volume-override-reference.html) Volume override might cause flickering Shadows.

**Note**: Volumetric fog doesn't work for Cameras that use oblique projection matrices. If you want a Camera to render volumetric fog, don't assign an off-axis projection to it.
