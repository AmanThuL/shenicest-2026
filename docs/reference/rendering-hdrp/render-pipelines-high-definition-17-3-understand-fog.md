---
title: "Understand fog"
page_title: "Understand atmospheric scattering | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Understand-Fog.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Understand-Fog.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Understand atmospheric scattering

Atmospheric scattering occurs when particles suspended in the atmosphere diffuse (or scatter) a part of the light passing through them in all directions.

Natural effects that cause atmospheric scattering include fog, clouds, or mist.

The High Definition Render Pipeline (HDRP) simulates a [fog](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/fog.html) effect by overlaying a color onto objects, depending on their distance from the Camera. This is good for simulating fog or mist in outdoor environments. You can use it to hide the clipping of far away GameObjects, which is useful if you reduce a Camera’s far clip plane to enhance performance.

HDRP implements an exponential fog, where density varies exponentially with distance from the Camera. All Material types (Lit or Unlit) react correctly to the fog. HDRP calculates fog density depending on the distance from the Camera, and the world space height.

Instead of using a constant color, fog can use the background sky as a source for color. In this case, HDRP samples the color from different mipmaps of the cubemap generated from the current sky settings. The chosen mip varies linearly between the lowest resolution and the highest resolution mipmaps, depending on the distance from the Camera and the values in the fog component’s **Mip Fog** properties. You can also choose to limit the resolution of the highest mip that HDRP uses. Doing this adds a volumetric effect to the fog and is less resource intensive to use than actual volumetric fog.

Optionally, you can enable volumetric fog for GameObjects close to the camera. It realistically simulates the interaction of lights with fog, which allows for physically plausible rendering of glow and crepuscular rays, which are beams of light that stream through gaps in objects like clouds and trees from a central point.

**Note:** Volumetric fog doesn't support [light rendering layers](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Rendering-Layers).
