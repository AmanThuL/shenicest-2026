---
title: "Scripting API: Quaternion.Slerp"
page_title: "Unity - Scripting API: Quaternion.Slerp"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.Slerp.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.Slerp.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Quaternion](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.html).Slerp

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

public static [Quaternion](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.html) <span class="sig-kw">Slerp</span>([Quaternion](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.html) <span class="sig-kw">a</span>, [Quaternion](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.html) <span class="sig-kw">b</span>, float <span class="sig-kw">t</span>);

### Parameters

| Parameter | Description                                                  |
|-----------|--------------------------------------------------------------|
| a         | Start unit quaternion value, returned when t = 0.            |
| b         | End unit quaternion value, returned when t = 1.              |
| t         | Interpolation ratio. Value is clamped to the range \[0, 1\]. |

### Returns

**Quaternion** A unit quaternion spherically interpolated between quaternions `a` and `b`.

### Description

Spherically linear interpolates between unit quaternions `a` and `b` by a ratio of `t`.

Use this to create a rotation which smoothly interpolates between the first unit quaternion `a` to the second unit quaternion `b`, based on the value of the parameter `t`. If the value of the parameter is close to 0, the output will be close to `a`, if it is close to 1, the output will be close to `b`.

``` codeExampleCS
// Interpolates rotation between the rotations "from" and "to"
// (Choose from and to not to be the same as
// the object you attach this script to)

using UnityEngine;
using System.Collections;

public class ExampleClass : MonoBehaviour

}
```

Additional resources: [Lerp](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.Lerp.html), [SlerpUnclamped](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.SlerpUnclamped.html).
