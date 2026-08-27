---
title: "Screen space global illumination (SSGI)"
page_title: "Use Screen Space Global Illumination | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Override-Screen-Space-GI.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Override-Screen-Space-GI.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Use Screen Space Global Illumination

The **Screen Space Global Illumination** (SSGI) override is a High Definition Render Pipeline (HDRP) feature that uses the depth and color buffer of the screen to calculate diffuse light bounces.

HDRP implements [ray-traced global illumination](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Ray-Traced-Global-Illumination.html) (RTGI) on top of this override. This means that the properties visible in the Inspector change depending on whether you enable ray tracing.

SSGI and RTGI replace all [lightmap](https://docs.unity3d.com/Manual/Lightmapping.html) and [Light Probe](https://docs.unity3d.com/Manual/LightProbes.html) data. If you enable this override on a Volume that affects the Camera, Light Probes and the ambient probe stop contributing to lighting for GameObjects.

![A sample scene rendered with SSGI.](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/HDRPFeatures-SSGI.png)

## Enable Screen Space Global Illumination

To use this feature in your Scene, you must first enable it for your project and then enable it for your Cameras. To enable features in your project, you use the [HDRP Asset](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html) and to enable features for your Cameras, you use [Frame Settings](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Frame-Settings.html). You can enable features either for all Cameras, using the Default Frame Settings, or for specific Cameras, by overriding each Camera's individual Frame Settings.

To enable SSGI:

1.  Open your HDRP Asset in the Inspector.
2.  Go to **Lighting** and enable **Screen Space Global Illumination**.
3.  Go to **Edit** \> **Project Settings** \> **Graphics** \> **Pipeline Specific Settings** \> **HDRP** \> **Frame Settings (Default Values)** \> **Lighting** and enable **Screen Space Global Illumination**.

## Use Screen Space Global Illumination

HDRP uses the [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) framework to calculate SSGI, so to enable and modify SSGI properties, you must add a **Screen Space Global Illumination** override to a [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) in your Scene. To add **Screen Space Global Illumination** to a Volume:

1.  In the Scene or Hierarchy view, select a GameObject that contains a Volume component to view it in the Inspector.
2.  In the Inspector, go to **Add Override** \> **Lighting** and select **Screen Space Global Illumination**. HDRP now calculates SSGI for any Camera this Volume affects.

### API

To access and control this override at runtime, use the [Volume scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#changing-volume-profile-properties). Because of how the Volume system works, you edit properties in a different way to standard Unity components. There are also other nuances to be aware of too, such as each property has an [overrideState](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest/index.html?subfolder=/api/UnityEngine.Rendering.VolumeParameter.html%23UnityEngine_Rendering_VolumeParameter_overrideState). This indicates to the Volume system whether to use the property value you set, or use the default value stored in the [Volume Profile](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-volume-profile.html). For information on how to use the API correctly, see [Volume scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#changing-volume-profile-properties).

## Tracing modes

The properties visible in the Inspector change depending on the option you select from the **Tracing** drop-down:

- To use a screen-space, ray-marched solution, select **Ray Marching** and see [Screen-space](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Override-Screen-Space-GI.html#screen-space) for the list of properties.
- To use ray tracing, select **Ray Tracing** and see [Ray-traced](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Override-Screen-Space-GI.html#ray-traced) for the list of properties.
- To use a combination of ray tracing and ray marching, select **Mixed** and see [Ray-traced](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Override-Screen-Space-GI.html#ray-traced) for the list of properties. For more information about mixed tracing mode, see [mixed tracing](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Override-Screen-Space-GI.html#mixed-tracing)

### Mixed tracing

This option uses ray marching to intersect on-screen geometry and uses ray tracing to intersect off-screen geometry. This enables HDRP to include on-screen opaque particles, vertex animations, and decals when it processes the effect. This option only works in [Performance mode](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Ray-Tracing-Getting-Started.html#ray-tracing-mode) and with Lit Shader Mode setup to Deferred.

In Mixed tracing mode, HDRP processes screen-space ray marching in the GBuffer. This means that it can only use GameObjects rendered using the [deferred](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Forward-And-Deferred-Rendering.html) rendering path. For example, HDRP renders transparent GameObjects in the forward rendering path which means they don't appear in the GBuffer or in effects that use mixed tracing.

In Mixed tracing mode, HDRP still uses ray tracing for any geometry inside the ray tracing acceleration structure, regardless of whether vertex animation or decals modify the geometry's surface. This means if HDRP fails to intersect the on-screen deformed geometry, it intersects the original mesh inside in the ray tracing acceleration structure. This may cause visual discrepancies between what you see and what you expect. For example, the following Scene contains a cliff that uses mesh deformation.

![Example scene contains a cliff mesh that uses mesh deformation.](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/mixed-tracing-mixed.png)

In this Scene, Mixed mode can include reflections for the opaque leaf particles, the white decal, and GameObjects that aren't visible in the cliff face's non-deformed geometry.

![Reflections in the water show elements that are not visible on the cliff surface.](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/mixed-tracing-ray-traced.png)

Reflection rays intersect with the original, non-deformed cliff face geometry. This means the rays can still be affected by the bush behind the rock. To view the Scene from the perspective of the ray tracing mode, refer to the following image.

![The scene rendered using ray tracing. The reflections match the cliff surface.](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/mixed-tracing-ray-traced-no-deform.png)

This image shows the elements of the Scene that ray tracing takes into account. The non-deformed cliff face geometry reveals the bushes behind the rocks.

### Tracing Modes Limitation

#### Ray Marching

- Transparent Emissive Material are only taken into account when you set Rendering Pass to **Before Refraction**.

#### Ray Tracing

- Transparent Emissive Material aren't taken into account.
- No [decals](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/snippets/decals.md) are supported including Emissive Decals.

#### Mixed Tracing

- The Mixed tracing mode is only useful if you set the Lit shader mode to **Deferred** and have the same limitation than Ray Tracing mode.

## Properties

To learn about SSGI properties, refer to [Screen Space Global Illumination (SSGI) reference](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/reference-screen-space-global-illumination.html).

### Limitations

- SSGI is not compatible with [Reflection Probes](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Reflection-Probe.html).
- When you set [Lit Shader mode](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Forward-And-Deferred-Rendering.html) to **Deferred** the Ambient Occlusion from Lit Shader will combine with Screen Space Ambient Occlusion and apply to the indirect lighting result where there is no Emissive contribution. This is similar behavior to rendering with Lit Shader mode set to **Forward**. If the Material has an emissive contribution then Ambient Occlusion is set to one.
