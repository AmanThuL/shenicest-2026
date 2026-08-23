---
title: "Scripting API: Quaternion.LookRotation"
page_title: "Unity - Scripting API: Quaternion.LookRotation"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.LookRotation.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.LookRotation.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Quaternion](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.html).LookRotation

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

public static [Quaternion](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.html) <span class="sig-kw">LookRotation</span>([Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">forward</span>, [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">upwards</span> = Vector3.up);

### Parameters

| Parameter | Description                                                             |
|-----------|-------------------------------------------------------------------------|
| forward   | The direction to look in, in world coordinates.                         |
| upwards   | The vector that defines in which direction up is, in world coordinates. |

### Description

Creates a rotation with the specified `forward` and `upwards` directions.

Z axis will be aligned with `forward`, X axis aligned with cross product between `forward` and `upwards`, and Y axis aligned with cross product between Z and X.  
  
If the `forward` vector is zero, the method logs an error in the console and returns `identity`.  
If `forward` and `upwards` are colinear, or if the magnitude of `upwards` is zero, the result is the same as [Quaternion.FromToRotation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.FromToRotation.html) with `fromDirection` set to the positive Z-axis (0, 0, 1) and `toDirection` set to the normalized `forward` direction.

``` codeExampleCS
// You can also use transform.LookAt

using UnityEngine;
using System.Collections;

public class ExampleClass : MonoBehaviour

}
```

Additional resources: [SetLookRotation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.SetLookRotation.html).
