---
title: "Understand Volumes"
page_title: "Understand Volumes | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Understand Volumes

The High Definition Render Pipeline (HDRP) uses volumes. Volumes allow you to partition your scene into areas, so you can control lighting and effects depending on the camera position relative to each volume, rather than tuning an entire scene.

You can add a Volume component to any GameObject. A scene can contain multiple GameObjects with Volume components. You can add multiple Volume components to a GameObject.

At runtime, HDRP goes through all the enabled Volume components attached to active GameObjects in the scene, and determines each volume's contribution to the final scene settings. HDRP uses the camera position and the Volume component properties to calculate the contribution. HDRP interpolates values from all volumes with a non-zero contribution to calculate the final property values.

## Global and local volumes

There are two types of volume:

- Global volumes affect the camera everywhere in the scene.
- Local volumes affect the camera only if the camera is near the bounds of the collider on the parent GameObject.

Refer to [Set up a volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/set-up-a-volume.html) for more information.

## Volume Profiles and Volume Overrides

Each Volume component references a Volume Profile, which contains scene properties in one or more Volume Overrides. Each Volume Override controls different settings.

![The default Sky and Fog Volume selected in the Hierarchy window and open in the Inspector window. The volume profile is set to SkyandFogSettingsProfile, and there is a dropdown and properties for each Volume Override.](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/VolumeProfile3.png)

The default **Sky and Fog Volume** GameObject in a new HDRP project. The GameObject has a global volume. The Volume Profile has **Visual Environment**, **Physically Based Sky**, **Fog** and **Exposure** Volume Overrides.

Refer to the following for more information:

- [Create a Volume Profile](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-volume-profile.html)
- [Configure Volume Overrides](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/configure-volume-overrides.html)

<span id="default-volumes"></span>

## Default volumes

All HDRP scenes have two default global volumes:

- The Default Volume for your whole project, which uses the Volume Profile set in Project Settings \> **Graphics** \> **HDRP** \> **Volume** \> **Default Profile**.
- The global volume for the active quality level, which uses the Volume Profile set in the active [HDRP Asset](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html) \> **Volumes** \> **Volume Profile**.

HDRP sets the default volumes to the lowest priority, so any volume you add to a scene overrides them.

Refer to the following for more information:

- [Configure the Default Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/set-up-a-volume.html#configure-the-default-volume)
- [Configure the global volume for a quality level](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/set-up-a-volume.html#configure-the-global-volume-for-a-quality-level)

## Caching for volumes

When you first configure your project, Unity computes the values for [default volumes](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html#default-volumes) once and then caches them for performance and optimization. Caching prevents repeated calculations during gameplay and enables efficient interpolation between settings. This means that changes to these settings in your script will not have any effect. To implement changes that affect your scene despite caching, refer to [Troubleshooting volumes](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/volumes-troubleshooting.html).
