---
title: "Scripting API: Vector3.MoveTowards"
page_title: "Unity - Scripting API: Vector3.MoveTowards"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.MoveTowards.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.MoveTowards.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html).MoveTowards

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

public static [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">MoveTowards</span>([Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">current</span>, [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">target</span>, float <span class="sig-kw">maxDistanceDelta</span>);

### Parameters

| Parameter        | Description                          |
|------------------|--------------------------------------|
| current          | The position to move from.           |
| target           | The position to move towards.        |
| maxDistanceDelta | Distance to move `current` per call. |

### Returns

**Vector3** The new position.

### Description

Moves vector incrementally towards a target point.

This method moves a vector from `current` to `target` points, moving no farther each call than the distance specified by `maxDistanceDelta`.  
  
By updating an object's position each frame using the position calculated by this function, you can move it towards the target smoothly.  
  
Control the speed of movement with the `maxDistanceDelta` parameter. To make sure that object speed is independent of frame rate, multiply the `maxDistanceDelta` value by [Time.deltaTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-deltaTime.html) (or [Time.fixedDeltaTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-fixedDeltaTime.html) in a `FixedUpdate` loop).  
  
If the `current` position is already closer to the `target` than `maxDistanceDelta`, the value returned is equal to `target`. This method doesn't overshoot `target`.  
  
You can set `maxDistanceDelta` to a negative value to move away from `target`.

``` codeExampleCS
// To run this example, create a cube GameObject positioned at the origin of the scene. 
// Attach this script to the cube. 
//
// This example creates a cylinder GameObject that becomes the target position for the 
// cube. When the cube reaches the cylinder, the cylinder is re-positioned to the 
// initial location of the cube. The cube then changes direction and moves towards the 
// cylinder again.

using UnityEngine;

public class MoveTowardsExample : MonoBehaviour

    void Update()
    
    }
}
```
