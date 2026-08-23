---
title: "Scripting API: Vector3.Distance"
page_title: "Unity - Scripting API: Vector3.Distance"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.Distance.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.Distance.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html).Distance

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

<span style="color:red;"> </span>

## Declaration

public static float <span class="sig-kw">Distance</span>([Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">a</span>, [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">b</span>);

### Parameters

| Parameter | Description                                      |
|-----------|--------------------------------------------------|
| a         | The first three-dimensional point as a Vector3.  |
| b         | The second three-dimensional point as a Vector3. |

### Returns

**float** The scalar distance between points `a` and `b`.

### Description

Calculates the distance between two three-dimensional points.

This method calculates the shortest distance between the two input points. Both points should be defined in the same coordinate space. `Vector3.Distance(a,b)` returns the same result as `(a-b).magnitude`. The resulting value is always \>= 0.

``` codeExampleCS
using UnityEngine;

public class Vector3DistanceExample : MonoBehaviour

    }
}
```
