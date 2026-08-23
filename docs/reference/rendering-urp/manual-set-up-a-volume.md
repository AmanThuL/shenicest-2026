---
title: "Set up a volume in URP"
page_title: "Unity - Manual: Set up a volume in URP"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/set-up-a-volume.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/set-up-a-volume.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Set up a volume in URP

To set up a volume in your scene, you can configure the project’s default volume settings, or add a new custom volume. For details, refer to the following sections:

-   [Configure the default volumes](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/set-up-a-volume.html#configure-the-default-volumes)
-   [Add a volume](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/set-up-a-volume.html#add-a-volume).

<span id="configure-the-default-volumes"></span>

## Configure the default volumes

You can configure the default global volumes that all URP scenes use.

<span id="configure-the-default-volume"></span>

### Configure the Default Volume

To configure the Default Volume, go to **Project Settings** \> **Graphics** \> **URP** \> **Default Volume Profile**.

By default, the Default Volume references a Volume Profile called `DefaultVolumeProfile`. `DefaultVolumeProfile` lists all possible Volume Overrides. You can change the properties, but you can’t disable or remove Volume Overrides. Refer to [Volume Overrides](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/VolumeOverrides.html) for more information about changing the properties.

You can assign your own Volume Profile.

If you delete the Volume Profile, URP automatically reassigns `DefaultVolumeProfile`.

<span id="configure-the-global-volume-for-a-quality-level"></span>

### Configure the global volume for a quality level

To configure the global volume for a quality level, follow these steps:

1.  Go to **Project Settings** > **Quality** and select the quality level.
2.  Go to **Rendering** > **Render Pipeline Asset** and open the URP asset.
3.  In the Inspector window for the URP asset, go to **Volumes**.

You can add or remove Volume Overrides and edit their properties. Refer to [Volume Overrides](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/VolumeOverrides.html) for more information about changing the Volume Overrides and properties.

<span id="add-a-volume"></span>

## Add a volume

To add a volume to your scene and edit its Volume Profile, follow these steps:

1.  Go to **GameObject** > **Volume** and select a GameObject.
2.  In the **Scene** or **Hierarchy** view, select the new GameObject to view it in the Inspector.
3.  In the **Volume** component, assign a Volume Profile asset. To create a new Volume Profile, select **New**.

The list of Volume Overrides that the Volume Profile contains appears below the Volume Profile asset. You can add or remove Volume Overrides and edit their properties. Refer to [Volume Overrides](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/VolumeOverrides.html) for more information about changing the Volume Overrides and properties.

### Example: Create a local post-processing effect

The following example shows how to use a local Box Volume to implement a location-based post-processing effect.

1.  In a scene, create a new Box Volume using **GameObject** > **Volume** > **Box Volume**.

2.  Select the Box Volume. In the Inspector, in the **Volume** component, select **New**.

    Unity creates the new Volume Profile.

3.  Select **Add Override**, then select a post-processing effect.

4.  In the **Box Collider** component, adjust the **Size** and **Center** properties so the collider occupies the volume where you want the local post-processing effect to be.

5.  Ensure **Is Trigger** is enabled in the **Box Collider** component.

6.  If you have other Volume components in the scene, change the value of the **Priority** property to ensure that the Volume Overrides from this volume have higher priority than those of other volumes.

Now, when the Camera is within the bounds of the GameObject’s collider, URP uses the Volume Overrides from the **Volume** component.
