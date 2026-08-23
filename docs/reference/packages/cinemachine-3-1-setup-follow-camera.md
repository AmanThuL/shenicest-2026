---
title: "Follow and frame a character"
page_title: "Follow and frame a character | Cinemachine | 3.1.7"
source_url: "https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/setup-follow-camera.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/setup-follow-camera.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Follow and frame a character

Create and set up a Cinemachine Camera that automatically follows and frames a character.

##### Note

Your Scene must include a GameObject you can target to follow it with the Cinemachine Camera.

## Add a "Follow" Cinemachine Camera

1.  In the Unity menu, select **GameObject** > **Cinemachine** > **Targeted Cameras** > **Follow Camera**.

    Unity adds a new GameObject with:

    -   A [Cinemachine Camera](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/CinemachineCamera.html) component,
    -   A [Cinemachine Follow](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/CinemachineFollow.html) component handling the Cinemachine Camera behavior for **Position Control**, and
    -   A [Cinemachine Rotation Composer](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/CinemachineRotationComposer.html) component handling the Cinemachine Camera behavior for **Rotation Control**.

2.  [Verify](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/setup-cinemachine-environment.html#verify-the-cinemachine-brain-presence) that the Unity Camera includes a [Cinemachine Brain](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/CinemachineBrain.html) component.

3.  In the Inspector, in the **Cinemachine Camera** component, set the **Tracking Target** property to specify the GameObject to follow and look at.

    The CinemachineCamera automatically positions the Unity camera relative to this GameObject at all times, and rotates the camera to look at the GameObject, even as you move it in the Scene.

##### Note

If you invoked th **Follow Camera** menu item by right-clicking on the GameObject that you want to follow, the "Tracking Target" of the new camera will automatically be populated with the object on which you right-clicked.

## Adjust the Cinemachine Camera behavior

1.  Use the Inspector to access the [Cinemachine Camera component](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/CinemachineCamera.html) properties for further configuration.

2.  Adjust the properties such as:

    -   The follow offset
    -   The follow damping
    -   The screen composition, and
    -   The damping used when re-aiming the camera
    -   The Lens settings
