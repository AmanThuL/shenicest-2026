---
title: "Scripting API: Vector3.SmoothDamp"
page_title: "Unity - Scripting API: Vector3.SmoothDamp"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.SmoothDamp.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.SmoothDamp.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html).SmoothDamp

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

public static [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">SmoothDamp</span>([Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">current</span>, [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">target</span>, ref [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">currentVelocity</span>, float <span class="sig-kw">smoothTime</span>, float <span class="sig-kw">maxSpeed</span> = Mathf.Infinity, float <span class="sig-kw">deltaTime</span> = Time.deltaTime);

### Parameters

| Parameter       | Description                                                                                                                                        |
|-----------------|----------------------------------------------------------------------------------------------------------------------------------------------------|
| current         | The initial position.                                                                                                                              |
| target          | The position to move towards.                                                                                                                      |
| currentVelocity | The initial velocity. This value is modified by the function each time it runs in the `Update` function. Pass this parameter as a reference value. |
| smoothTime      | Approximately the time it will take to reach the target. A smaller value will reach the target faster.                                             |
| maxSpeed        | The maximum speed to reach in the motion. By default, there is no maximum speed.                                                                   |
| deltaTime       | The time between calls to this function. The default value is `Time.deltaTime`, such that `SmoothDamp` is called once per frame.                   |

### Returns

**Vector3** The new position, moved part of the way from `current` towards `target`.

### Description

Gradually changes a vector towards a desired goal over time.

The vector is smoothed by a spring-like damper function, such that the speed slows as it nears the target position. The motion doesn't overshoot the target position.  
  
A common use of this method is smoothing the motion of a follow camera.

``` codeExampleCS
// This example creates a sphere and moves the attached GameObject to  
// just in front of the sphere. 
// Attach this example to a camera object to view the movement.
using UnityEngine;

public class SmoothDampExample : MonoBehaviour

    void Update()
    
}
```
