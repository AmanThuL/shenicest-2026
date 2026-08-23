---
title: "Scripting API: Debug.DrawRay"
page_title: "Unity - Scripting API: Debug.DrawRay"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.DrawRay.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.DrawRay.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Debug](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.html).DrawRay

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-Debug.html" class="switch-link gray-btn sbtn left show" title="Go to Debug Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

## Declaration

public static void <span class="sig-kw">DrawRay</span>([Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">start</span>, [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">dir</span>, [Color](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Color.html) <span class="sig-kw">color</span> = Color.white, float <span class="sig-kw">duration</span> = 0.0f, bool <span class="sig-kw">depthTest</span> = true);

### Parameters

| Parameter | Description                                                       |
|-----------|-------------------------------------------------------------------|
| start     | Point in world space where the ray should start.                  |
| dir       | Direction and length of the ray.                                  |
| color     | Color of the drawn line.                                          |
| duration  | How long the line will be visible for (in seconds).               |
| depthTest | Determines whether objects closer to the camera obscure the line. |

### Description

Draws a line from `start` to `start` + `dir` in world coordinates.

The `duration` parameter determines how long the line will be visible after the frame it is drawn. If duration is 0 (the default) then the line is rendered 1 frame.  
  
If `depthTest` is set to true then the line will be obscured by other objects in the Scene that are nearer to the camera.  
  
The line will be drawn in the Scene view of the editor. If gizmo drawing is enabled in the game view, the line will also be drawn there.

``` codeExampleCS
using UnityEngine;

public class Example : MonoBehaviour

}
```

``` codeExampleCS
using UnityEngine;

public class Example : MonoBehaviour

}
```
