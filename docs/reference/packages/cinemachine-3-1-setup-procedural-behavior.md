---
title: "Add procedural behavior to a Cinemachine Camera"
page_title: "Add procedural behavior to a Cinemachine Camera | Cinemachine | 3.1.7"
source_url: "https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/setup-procedural-behavior.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/setup-procedural-behavior.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Add procedural behavior to a Cinemachine Camera

Set up a Cinemachine Camera with [procedural behaviors](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/concept-procedural-motion.html):

-   Add behaviors to control the camera position and rotation,
-   Specify a GameObject to track for automatic follow and aim,
-   Add default noise to simulate real-world physical camera shaking, and
-   See how to an Extension to get advanced camera behaviors.

##### Note

This task requires some preparation:

-   You must have created at least one [passive Cinemachine Camera](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/setup-cinemachine-environment.html), and
-   Your Scene must already include a GameObject you can target to follow it with the Cinemachine Camera.

## Add Position Control and Rotation Control behaviors

1.  In the Hierarchy, select the Cinemachine Camera GameObject.

2.  In the Inspector, in the **Cinemachine Camera** component, set the **Position Control** property to **Follow**.

    Unity adds a [Cinemachine Follow](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/CinemachineFollow.html) component to the GameObject.

3.  Still in the **Cinemachine Camera** component, set the **Rotation Control** property to **Rotation Composer**.

    Unity adds a [Cinemachine Rotation Composer](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/CinemachineRotationComposer.html) component to the GameObject.

##### Note

You get the same result when you [create a Follow Camera](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/setup-follow-camera.html) directly from the Editor's menu: **GameObject** \> **Cinemachine** \> **Targeted Cameras** \> **Follow Camera**. The goal here is to show how to add behavior to an existing Cinemachine Camera.

See the [Cinemachine Camera component reference](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/CinemachineCamera.html) to get the list of available Position Control and Rotation Control behaviors and access their detailed descriptions.

##### Warning

A Cinemachine Camera GameObject can only have one Position Control behavior and one Rotation Control behavior selected at a time. If you edit the properties of a behavior component and then select another behavior from the Cinemachine Camera component, your edits are lost.

## Specify a GameObject to track

The behaviors selected in the previous step require a tracking target. To meet this requirement:

1.  In the Inspector, in the **Cinemachine Camera** component, set the **Tracking Target** property to specify the GameObject to track.

2.  Move the targeted GameObject in the Scene to test the Cinemachine Camera behaviors.

    The Cinemachine Camera automatically positions the Cinemachine Camera relative to this GameObject at all times according to the Follow behavior, and rotates the camera to look at the GameObject according to the Rotation Composer behavior.

## Add noise for camera shaking

To optionally add noise to simulate real-world physical camera shaking:

1.  In the Inspector, in the **Cinemachine Camera** component, set the **Noise** property to **Basic Multi Channel Perlin**.

    Unity adds a [Cinemachine Basic Multi Channel Perlin](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/CinemachineBasicMultiChannelPerlin.html) component to the GameObject.

2.  In the Cinemachine Basic Multi Channel Perlin component, click on the configuration button at the right of **Noise Profile**.

3.  Under **Presets**, select an existing [Noise Settings asset](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/CinemachineNoiseProfiles.html).

4.  Enter Play mode to see the effect of the selected noise profile on the camera, then exit Play mode.

##### Warning

If you edit the properties of the Cinemachine Basic Multi Channel Perlin component and then change the **Noise** selection from the Cinemachine Camera component, your edits are lost.

For further noise behavior adjustments, see the [Cinemachine Basic Multi Channel Perlin component reference](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/CinemachineBasicMultiChannelPerlin.html) and [Noise Settings asset reference](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/CinemachineNoiseProfiles.html).

## Add a Cinemachine Camera Extension

To optionally add an Extension to the Cinemachine Camera when you need to get a specific or advanced behavior:

1.  In the Inspector, in the **Cinemachine Camera** component, click on **(select)** at the right of **Add Extension**.

2.  Select an Extension in the list.

    Unity adds the corresponding Extension component to the GameObject.

##### Note

You can add as many Extensions as needed to the same Cinemachine Camera GameObject. You can remove an Extension as any other [GameObject component](https://docs.unity3d.com/Manual/UsingComponents.html).

See the [Reference](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/Reference.html) to get the list of all available Cinemachine Camera Extensions and access their detailed descriptions.

## Next steps

Here are potential tasks you might want to do now:

-   [Create multiple Cinemachine Cameras and manage transitions between them](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/setup-multiple-cameras.html).
-   [Manage a choreographed sequence of Cinemachine Camera shots with Timeline](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/setup-timeline.html).
