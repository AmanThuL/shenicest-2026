---
title: "Cinemachine Follow"
page_title: "Cinemachine Follow component | Cinemachine | 3.1.7"
source_url: "https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/CinemachineFollow.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/CinemachineFollow.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Cinemachine Follow component

This CinemachineCamera **Position Control** behavior moves the CinemachineCamera to maintain a fixed offset relative to the **Tracking Target**. It also applies damping.

The fixed offset can be interpreted in various ways, depending on the Binding Mode.

## Properties

<table><colgroup><col style="width: 50%" /><col style="width: 50%" /></colgroup><thead><tr class="header"><th style="text-align: left;">Property</th><th style="text-align: left;">Function</th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong><a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/CinemachineFollow.html#binding-modes">Binding Mode</a></strong></td><td style="text-align: left;">How to use to interpret the offset from the target.<ul><li><strong>World Space</strong>: The offset is interpreted in world space relative to the origin of the Follow target. The camera will not change position when the target rotates.</li><li><strong>Lock To Target</strong>: Makes the CinemachineCamera use the local frame of the Follow target. When the target rotates, the camera moves with it to maintain the offset and to maintain the same view of the target.</li><li><strong>Lock To Target With World Up</strong>: Makes the CinemachineCamera use the local frame of the Follow target with tilt and roll set to 0. This binding mode ignores all target rotations except yaw.</li><li><strong>Lock To Target No Roll</strong>: Makes the CinemachineCamera use the local frame of the Follow target, with roll set to 0.</li><li><strong>Lock To Target On Assign</strong>: Makes the orientation of the CinemachineCamera match the local frame of the Follow target, at the moment when the CinemachineCamera is activated or when the target is assigned. This offset remains constant in world space. The camera does not rotate along with the target.</li><li><strong>Lazy Follow</strong>: Lazy follow interprets the offset and damping values in camera-local space. This mode emulates the action a human camera operator would take when instructed to follow a target. The camera attempts to move as little as possible to maintain the same distance from the target; the direction of the camera with respect to the target does not matter. Regardless of the orientation of the target, the camera tries to preserve the same distance and height from it.</li></ul></td></tr><tr class="even"><td style="text-align: left;"><strong>Follow Offset</strong></td><td style="text-align: left;">The desired offset from the target at which the CinemachineCamera will be positioned. Set X, Y, and Z to 0 to place the camera at the center of the target. The default is 0, 0, and -10, respectively, which places the camera behind the target.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Position Damping</strong></td><td style="text-align: left;">How responsively the camera tries to maintain the offset in the x, y, and z axes. Small numbers make the camera more responsive. Larger numbers make the camera respond more slowly.</td></tr><tr class="even"><td style="text-align: left;"><strong>Angular Damping Mode</strong></td><td style="text-align: left;">Can be Euler or Quaternion. In Euler mode, individual values can be set for Pitch, Roll, and Yaw damping, but gimbal lock may become an issue. In Quaternion mode, only a single value is used, but it is impervious to gimbal lock.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Rotation Damping</strong></td><td style="text-align: left;">How responsively the camera tracks the target's pitch, yaw, and roll, when in Euler angular damping mode. Small numbers make the camera more responsive. Larger numbers make the camera respond more slowly.</td></tr><tr class="even"><td style="text-align: left;"><strong>Quaternion Damping</strong></td><td style="text-align: left;">How responsively the camera tracks the target's rotation, when in Quaternion Angular Damping Mode.</td></tr></tbody></table>

## Binding Modes

When following a target with an offset from the target, the binding mode defines the coordinate space Unity uses to interpret the camera offset from the target and to apply the damping.  
  

### Lock To Target

Makes the CinemachineCamera use the local frame of the Follow target. When the target rotates, the camera rotates with it to maintain the offset and to maintain the same view of the target.

| Start                                                                                                                                                      | Pitch, 45 degrees                                                                                                                                                                                   |
|:-----------------------------------------------------------------------------------------------------------------------------------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ![Camera locked to the target, at start.](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/images/cm-binding-mode-lock-target-start.png) | ![Effect on the camera when you apply a 45 degree downward pitch on the target.](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/images/cm-binding-mode-lock-target-pitch45.png) |

| Yaw, 45 degrees                                                                                                                                                                             | Roll, 45 degrees                                                                                                                                                                                     |
|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ![Effect on the camera when you yaw 45 degree to the right on the target.](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/images/cm-binding-mode-lock-target-yaw45.png) | ![Effect on the camera when you apply a 45 degree roll to the left on the target.](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/images/cm-binding-mode-lock-target-roll45.png) |

  
  

### Lock To Target No Roll

Makes the CinemachineCamera use the local frame of the Follow target, with roll set to 0.

| Start                                                                                                                                                                           | Pitch, 45 degrees                                                                                                                                                                                           |
|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ![Camera locked to the target with no roll, at start.](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/images/cm-binding-mode-lock-target-no-roll-start.png) | ![Effect on the camera when you apply a 45 degree downward pitch on the target.](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/images/cm-binding-mode-lock-target-no-roll-pitch45.png) |

| Yaw, 45 degrees                                                                                                                                                                                     | Roll, 45 degrees                                                                                                                                                                                             |
|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ![Effect on the camera when you yaw 45 degree to the right on the target.](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/images/cm-binding-mode-lock-target-no-roll-yaw45.png) | ![Effect on the camera when you apply a 45 degree roll to the left on the target.](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/images/cm-binding-mode-lock-target-no-roll-roll45.png) |

  
  

### Lock To Target On Assign

Makes the orientation of the CinemachineCamera match the local frame of the Follow target, at the moment when the CinemachineCamera is activated or when the target is assigned. This offset remains constant in world space. The camera does not rotate along with the target.

| Start                                                                                                                                                                          | Pitch, 45 degrees                                                                                                                                                                                             |
|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ![Camera locked to the target on assign, at start.](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/images/cm-binding-mode-lock-target-on-assign-start.png) | ![Effect on the camera when you apply a 45 degree downward pitch on the target.](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/images/cm-binding-mode-lock-target-on-assign-pitch45.png) |

| Yaw, 45 degrees                                                                                                                                                                                       | Roll, 45 degrees                                                                                                                                                                                               |
|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ![Effect on the camera when you yaw 45 degree to the right on the target.](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/images/cm-binding-mode-lock-target-on-assign-yaw45.png) | ![Effect on the camera when you apply a 45 degree roll to the left on the target.](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/images/cm-binding-mode-lock-target-on-assign-roll45.png) |

  
  

### Lock To Target With World Up

Makes the CinemachineCamera use the local frame of the Follow target with tilt and roll set to 0. This binding mode ignores all target rotations except yaw.

| Start                                                                                                                                                                             | Pitch, 45 degrees                                                                                                                                                                                            |
|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ![Camera locked to the target with world up, at start.](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/images/cm-binding-mode-lock-target-world-up-start.png) | ![Effect on the camera when you apply a 45 degree downward pitch on the target.](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/images/cm-binding-mode-lock-target-world-up-pitch45.png) |

| Yaw, 45 degrees                                                                                                                                                                                      | Roll, 45 degrees                                                                                                                                                                                              |
|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ![Effect on the camera when you yaw 45 degree to the right on the target.](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/images/cm-binding-mode-lock-target-world-up-yaw45.png) | ![Effect on the camera when you apply a 45 degree roll to the left on the target.](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/images/cm-binding-mode-lock-target-world-up-roll45.png) |

  
  

### World Space

The offset is interpreted in world space relative to the origin of the Follow target. The camera will not change position when the target rotates.

| Start                                                                                                                                                                         | Pitch, 45 degrees                                                                                                                                                                                   |
|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ![Camera set to follow the target in world space, at start.](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/images/cm-binding-mode-world-space-start.png) | ![Effect on the camera when you apply a 45 degree downward pitch on the target.](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/images/cm-binding-mode-world-space-pitch45.png) |

| Yaw, 45 degrees                                                                                                                                                                             | Roll, 45 degrees                                                                                                                                                                                     |
|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ![Effect on the camera when you yaw 45 degree to the right on the target.](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/images/cm-binding-mode-world-space-yaw45.png) | ![Effect on the camera when you apply a 45 degree roll to the left on the target.](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/images/cm-binding-mode-world-space-roll45.png) |

  
  

### Lazy Follow

Lazy follow interprets the offset and damping values in camera-local space. This mode emulates the action a human camera operator would take when instructed to follow a target.

The camera attempts to move as little as possible to maintain the same distance from the target; the direction of the camera with respect to the target does not matter. Regardless of the orientation of the target, the camera tries to preserve the same distance and height from it.

| Start                                                                                                                                                                                         | Pitch, 45 degrees                                                                                                                                                                                              |
|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ![Camera set to follow the target in lazy follow mode, at start.](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/images/cm-binding-mode-simple-follow-world-up-start.png) | ![Effect on the camera when you apply a 45 degree downward pitch on the target.](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/images/cm-binding-mode-simple-follow-world-up-pitch45.png) |

| Yaw, 45 degrees                                                                                                                                                                                        | Roll, 45 degrees                                                                                                                                                                                                |
|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ![Effect on the camera when you yaw 45 degree to the right on the target.](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/images/cm-binding-mode-simple-follow-world-up-yaw45.png) | ![Effect on the camera when you apply a 45 degree roll to the left on the target.](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/images/cm-binding-mode-simple-follow-world-up-roll45.png) |
