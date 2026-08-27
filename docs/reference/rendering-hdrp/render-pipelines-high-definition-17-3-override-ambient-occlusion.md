---
title: "Screen Space Ambient Occlusion (SSAO)"
page_title: "Screen space ambient occlusion (SSAO) | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Override-Ambient-Occlusion.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Override-Ambient-Occlusion.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Screen space ambient occlusion (SSAO)

The Screen Space Ambient Occlusion (SSAO) volume override simulates [ambient occlusion](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/ambient-occlusion-introduction.html) in real-time.

![A single-channel screen space ambient occlusion texture of a gothic corridor. The scene is white with shades of grey representing corners and crevices.](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/RayTracedAmbientOcclusion1.png)\
A single-channel screen space ambient occlusion texture of a gothic corridor. The scene is white with shades of grey representing corners and crevices.

For each frame, SSAO creates a texture containing occluded areas in the camera view, which HDRP uses to reduce indirect lighting in those areas.

SSAO doesn't affect direct lighting, or the indirect light from Reflection Probes.

A screen-space effect only processes what's on-screen, so objects outside the camera view don't occlude objects in the camera view. You can sometimes see this at the edges of the screen. To include off-screen objects for better results, enable [Ray-traced ambient occlusion](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Ray-Traced-Ambient-Occlusion.html) instead.

## Enable screen space ambient occlusion

Follow these steps:

1.  Enable screen space ambient occlusion in your project.

    To use this feature in your Scene, you must first enable it for your project and then enable it for your Cameras. To enable features in your project, you use the [HDRP Asset](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html) and to enable features for your Cameras, you use [Frame Settings](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Frame-Settings.html). You can enable features either for all Cameras, using the Default Frame Settings, or for specific Cameras, by overriding each Camera's individual Frame Settings.

    - To enable SSAO in your HDRP Asset, go to **Lighting** \> **Screen Space Ambient Occlusion**.
    - To enable SSAO in your Frame Settings, go to **Edit** \> **Project Settings** \> **Graphics** \> **Pipeline Specific Settings** \> **HDRP** \> **Frame Settings (Default Values)** \> **Camera** \> **Lighting** \> **Screen Space Ambient Occlusion**.

2.  [Add a volume component](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/set-up-a-volume.html#add-a-volume) to any GameObject in your scene.

3.  Select the GameObject, then in the **Inspector** window select **Add Override** \> **Lighting** \> **Ambient Occlusion**.

    HDRP now applies screen space ambient occlusion to any camera this volume affects.

To access and control the volume override at runtime, refer to [Volume scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#changing-volume-profile-properties).

## Additional resources

- [Assign an ambient occlusion texture](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Ambient-Occlusion.html)
- [Ray-traced ambient occlusion](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Ray-Traced-Ambient-Occlusion.html)
