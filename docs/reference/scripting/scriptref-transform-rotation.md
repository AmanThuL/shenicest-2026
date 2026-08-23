---
title: "Scripting API: Transform.rotation"
page_title: "Unity - Scripting API: Transform.rotation"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform-rotation.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform-rotation.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html).rotation

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-Transform.html" class="switch-link gray-btn sbtn left show" title="Go to Transform Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>public [Quaternion](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.html) <span class="sig-kw">rotation</span>;

### Description

A [Quaternion](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.html) that stores the rotation of the Transform in world space.

[Transform.rotation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform-rotation.html) stores a [Quaternion](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.html). You can use [rotation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform-rotation.html) to rotate a GameObject or provide the current rotation. Do not attempt to edit/modify [rotation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform-rotation.html). [Transform.rotation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform-rotation.html) is less than 180 degrees.  
  
[Transform.rotation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform-rotation.html) has no gimbal lock.  
  
To rotate a [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html), use [Transform.Rotate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.Rotate.html), which uses Euler Angles.  
  
If you want to match values you see in the Inspector, use the [Quaternion.eulerAngles](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion-eulerAngles.html) property on the returned [Quaternion](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.html).

``` codeExampleCS
using UnityEngine;

// Transform.rotation example.

// Rotate a GameObject using a Quaternion.
// Tilt the cube using the arrow keys. When the arrow keys are released
// the cube will be rotated back to the center using Slerp.

public class ExampleScript : MonoBehaviour

}
```

In the above example, the [rotation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform-rotation.html) is described by a quaternion. For more advice, see [Rotation and Orientation in Unity](https://docs.unity3d.com/6000.3/Documentation/Manual/QuaternionAndEulerRotationsInUnity.html).
