---
title: "Scripting API: Quaternion.Euler"
page_title: "Unity - Scripting API: Quaternion.Euler"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.Euler.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.Euler.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Quaternion](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.html).Euler

<span id="scrollToFeedback">Leave feedback</span>

<span class="blue-btn sbtn">Suggest a change</span>

## Success!

Thank you for helping us improve the quality of Unity Documentation. Although we cannot accept all submissions, we do read each suggested change from our users and will make updates where applicable.

<span class="gray-btn sbtn close">Close</span>

## Submission failed

For some reason your suggested change could not be submitted. Please \<a>try again\</a> in a few minutes. And thank you for taking the time to help us improve the quality of Unity Documentation.

<span class="gray-btn sbtn close">Close</span>

Your name Your email Suggestion<span class="r">\*</span>

Submit suggestion

<span class="cancel left lh42 cn">Cancel</span>

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-Quaternion.html" class="switch-link gray-btn sbtn left show" title="Go to Quaternion Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

## Declaration

public static [Quaternion](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.html) <span class="sig-kw">Euler</span>(float <span class="sig-kw">x</span>, float <span class="sig-kw">y</span>, float <span class="sig-kw">z</span>);

### Parameters

| Parameter | Description                            |
|-----------|----------------------------------------|
| x         | Rotation in degrees around the x-axis. |
| y         | Rotation in degrees around the y-axis. |
| z         | Rotation in degrees around the z-axis. |

### Returns

**Quaternion** The Euler angle rotation specified by the angles x,y,z converted to a Quaternion. The rotation order is ZXY.

### Description

Converts an input Euler angle rotation specified as three floats to a Quaternion.

Returns a rotation that rotates z degrees around the z-axis, x degrees around the x-axis, and y degrees around the y-axis. Rotations are applied in ZXY order. The output is represented as a Quaternion. The rotation direction is counter-clockwise when looking from the origin along the axis of rotation. For more information, refer to [Rotation and Orientation in Unity](https://docs.unity3d.com/6000.3/Documentation/Manual/QuaternionAndEulerRotationsInUnity.html).

``` codeExampleCS
using UnityEngine;

public class EulerToQuaternionExample : MonoBehaviour

}
```

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static [Quaternion](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.html) <span class="sig-kw">Euler</span>([Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">euler</span>);

### Parameters

| Parameter | Description                                                                                                              |
|-----------|--------------------------------------------------------------------------------------------------------------------------|
| euler     | The x,y,z vector components of euler represent the input Euler angle rotations in degrees around the corresponding axes. |

### Returns

**Quaternion** The Euler angle rotation specified by the angles euler.x,euler.y,euler.z converted to a Quaternion. The rotation order is ZXY.

### Description

Converts an input Euler angle rotation specified as a Vector3 to a Quaternion.

Returns a rotation that rotates `euler.z` degrees around the z-axis, `euler.x` degrees around the x-axis, and `euler.y` degrees around the y-axis. Rotations are applied in ZXY order. The output is represented as a Quaternion. For more information, refer to [Rotation and Orientation in Unity](https://docs.unity3d.com/6000.3/Documentation/Manual/QuaternionAndEulerRotationsInUnity.html).

``` codeExampleCS
using UnityEngine;

public class EulerToQuaternionExample : MonoBehaviour

}
```
