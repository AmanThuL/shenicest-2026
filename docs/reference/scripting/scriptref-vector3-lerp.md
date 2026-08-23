---
title: "Scripting API: Vector3.Lerp"
page_title: "Unity - Scripting API: Vector3.Lerp"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.Lerp.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.Lerp.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html).Lerp

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

public static [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">Lerp</span>([Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">a</span>, [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">b</span>, float <span class="sig-kw">t</span>);

### Parameters

| Parameter | Description                                                                                                                          |
|-----------|--------------------------------------------------------------------------------------------------------------------------------------|
| a         | Start value. This value is returned when `t = 0`.                                                                                    |
| b         | End value. This value is returned when `t = 1`.                                                                                      |
| t         | Value used to interpolate between `a` and `b`. Values greater than one are clamped to `1`. Values less than zero are clamped to `0`. |

### Returns

**Vector3** Interpolated value. This value always lies on a line between points `a` and `b`.

### Description

Interpolates linearly between two points.

The interpolant parameter `t` is clamped to the range \[0, 1\].  
  
This method is useful for finding a point some fraction of the way along a line between two endpoints. For example, to move an object gradually between those points.  
  
The returned value **V** equals  
**V** = **A** + (**B** − **A**) × t  
where 0 \< `t` \< 1.  
  
The method interpolates between points `a` and `b`, such that:

-   When `t` ≤ 0, this method returns vector `a`.
-   When 0 \< `t` \< 1, this method returns a vector that points along the line between `a` and `b`. The distance along the line corresponds to the fraction represented by `t`.
-   When `t` > 1, this method returns vector `b`.

``` codeExampleCS
// This example creates three primitive cubes. Using linear interpolation, one cube moves along the line between the others.
// Because the interpolation is clamped to the start and end points, the moving cube never passes the end cube, and remains at the end position after the interpolation frame limit is reached.    
// Attach this script to any GameObject in your scene. 

using UnityEngine;

public class LerpExample : MonoBehaviour

    void Update()
    
}
```

``` codeExampleCS
// A longer example of Vector3.Lerp usage.
// Drop this script under an object in your scene, and specify 2 other objects in the "startMarker"/"endMarker" variables in the script inspector window.
// At play time, the script will move the object along a path between the position of those two markers.

using UnityEngine;
using System.Collections;

public class ExampleClass : MonoBehaviour

    // Move to the target end position.
    void Update()
    
}
```

Additional resources: [Slerp](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.Slerp.html), [LerpUnclamped](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.LerpUnclamped.html).
