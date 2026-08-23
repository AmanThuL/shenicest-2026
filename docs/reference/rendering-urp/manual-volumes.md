---
title: "Understand volumes in URP"
page_title: "Unity - Manual: Understand volumes in URP"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/Volumes.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/Volumes.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Understand volumes in URP

The Universal Render Pipeline (URP) uses volumes for [post-processing](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/add-post-processing.html) effects. Volumes can override or extend scene properties depending on the camera position relative to each volume.

You can create the following dedicated volume GameObjects:

-   Global Volume
-   Box Volume
-   Sphere Volume
-   Convex Mesh Volume

You can also add a Volume component to any GameObject. A scene can contain multiple GameObjects with Volume components. You can add multiple Volume components to a GameObject.

At runtime, URP goes through all the enabled Volume components attached to active GameObjects in the scene, and determines each volume’s contribution to the final scene settings. URP uses the camera position and the Volume component properties to calculate the contribution. URP interpolates values from all volumes with a non-zero contribution to calculate the final property values.

## Global and local volumes

There are two types of volume:

-   Global volumes affect the camera everywhere in the scene.
-   Local volumes affect the camera only if the camera is near the bounds of the collider on the parent GameObject.

Refer to [Set up a volume](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/set-up-a-volume.html) for more information.

## Volume Profiles and Volume Overrides

Each Volume component references a Volume Profile, which contains scene properties in one or more Volume Overrides. Each Volume Override controls different settings.

![Vignette post-processing effect in the URP Template SampleScene](https://docs.unity3d.com/6000.3/Documentation/uploads/urp/post-proc/post-proc-as-volume-override.png) A GameObject with a global volume. The Volume Profile has **Vignette** and **Tonemapping** Volume Overrides.

Refer to the following for more information:

-   [Create a Volume Profile](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/Volume-Profile.html)
-   [Configure Volume Overrides](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/VolumeOverrides.html)

<span id="default-volumes"></span>

## Default volumes

All URP scenes have two default global volumes:

-   The Default Volume for your whole project, which uses the Volume Profile set in **Project Settings** > **Graphics** > **URP** > **Default Volume Profile**.
-   The global volume for the active quality level, which uses the Volume Profile set in the active [URP asset](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/universalrp-asset.html) > **Volumes** > **Volume Profile**.

URP evaluates the default volumes only when you first load a scene or when you change the [quality level](https://docs.unity3d.com/Manual/class-QualitySettings.html), instead of every frame. If you use only the default volumes in a scene, URP has less work to do at runtime.

URP sets the default volumes to the lowest priority, so any volume you add to a scene overrides them.

Refer to the following for more information:

-   [Configure the Default Volume](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/set-up-a-volume.html#configure-the-default-volume)
-   [Configure the global volume for a quality level](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/set-up-a-volume.html#configure-the-global-volume-for-a-quality-level)

## Caching for volumes

When you first configure your project, Unity computes the values for [default volumes](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/Volumes.html#default-volumes) once and then caches them for performance and optimization. Caching prevents repeated calculations during gameplay and enables efficient interpolation between settings. This means that changes to these settings in your script will not have any effect. To implement changes that affect your scene despite caching, refer to [Troubleshooting volumes](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/volumes-troubleshooting.html).
