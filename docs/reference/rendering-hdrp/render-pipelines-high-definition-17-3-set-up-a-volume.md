---
title: "Set up a Volume"
page_title: "Set up a Volume | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/set-up-a-volume.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/set-up-a-volume.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Set up a Volume

To set up a volume in your scene, you can configure the project's default volume settings, or add a new custom volume. For details, refer to the following sections:

- [Configure the default volumes](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/set-up-a-volume.html#configure-the-default-volumes)
- [Add a volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/set-up-a-volume.html#add-a-volume).

## Configure the default volumes<span id="configure-the-default-volumes"></span>

You can configure the default global volumes that all HDRP scenes use.

### Configure the Default Volume<span id="configure-the-default-volume"></span>

To configure the Default Volume, go to **Project Settings** \> **Graphics** \> **HDRP** \> **Default Volume Profile**.

By default, the Default Volume references a Volume Profile called `DefaultSettingsVolumeProfile`. `DefaultSettingsVolumeProfile` lists all possible Volume Overrides. You can change the properties, but you can't disable or remove Volume Overrides. Refer to [Volume Overrides](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/configure-volume-overrides.html) for more information about changing the properties.

You can assign your own Volume Profile.

If you delete the Volume Profile, HDRP automatically reassigns `DefaultSettingsVolumeProfile`.

### Configure the global volume for a quality level<span id="configure-the-global-volume-for-a-quality-level"></span>

To configure the global volume for a quality level, follow these steps:

1.  Go to **Project Settings** \> **Quality** and select the quality level.
2.  Go to **Rendering** \> **Render Pipeline Asset** and open the HDRP Asset.
3.  In the Volume component, assign a Volume Profile asset. To create a new Volume Profile, select **New**.

The list of Volume Overrides that the Volume Profile contains appears below the Volume Profile asset. You can add or remove Volume Overrides and edit their properties. Refer to [Volume Overrides](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/configure-volume-overrides.html) for more information about changing the Volume Overrides and properties.

## Add a volume<span id="add-a-volume"></span>

To add a volume to your scene and edit its Volume Profile, follow these steps:

1.  Go to **GameObject** \> **Volume** and select a GameObject.
2.  In the **Scene** or **Hierarchy** view, select the new GameObject to view it in the Inspector.
3.  In the **Volume** component, assign a Volume Profile asset. To create a new Volume Profile, select **New**.

The list of Volume Overrides that the Volume Profile contains appears below the Volume Profile asset. You can add or remove Volume Overrides and edit their properties. Refer to [Volume Overrides](https://docs.unity3d.com/Manual/urp/VolumeOverrides.html) for more information about changing the Volume Overrides and properties.

### Example: Create a local post-processing effect<span id="example-create-a-local-post-processing-effect"></span>

The following example shows how to use a local Box Volume to implement a location-based post-processing effect.

1.  In a scene, create a new Box Volume using **GameObject** \> **Volume** \> **Box Volume**.

2.  Select the Box Volume. In the Inspector, in the **Volume** component, select **New**.\
    Unity creates the new Volume Profile.

3.  Select **Add Override**, then select a post-processing effect.

4.  In the **Box Collider** component, adjust the **Size** and **Center** properties so the collider occupies the volume where you want the local post-processing effect to be.

5.  Ensure **Is Trigger** is enabled in the **Box Collider** component.

6.  If you have other Volume components in the scene, change the value of the **Priority** property to ensure that the Volume Overrides from this volume have higher priority than those of other volumes.

Now, when the Camera is within the bounds of the GameObject's collider, HDRP uses the Volume Overrides from the **Volume** component.
