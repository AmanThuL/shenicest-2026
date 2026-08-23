---
title: "Scripting API: Camera.WorldToScreenPoint"
page_title: "Unity - Scripting API: Camera.WorldToScreenPoint"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Camera.WorldToScreenPoint.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Camera.WorldToScreenPoint.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Camera](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Camera.html).WorldToScreenPoint

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-Camera.html" class="switch-link gray-btn sbtn left show" title="Go to Camera Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

## Declaration

public [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">WorldToScreenPoint</span>([Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">position</span>);

<span style="color:red;"> </span>

## Declaration

public [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">WorldToScreenPoint</span>([Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">position</span>, [Camera.MonoOrStereoscopicEye](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Camera.MonoOrStereoscopicEye.html) <span class="sig-kw">eye</span>);

### Parameters

| Parameter | Description                                                                                |
|-----------|--------------------------------------------------------------------------------------------|
| position  | A 3D point in world space.                                                                 |
| eye       | Optional argument that can be used to specify which eye transform to use. Default is Mono. |

### Description

Transforms `position` from world space into screen space.

Screen space is defined in pixels. The lower left pixel of the screen is (0,0). The upper right pixel of the screen is (screen width in pixels - 1, screen height in pixels - 1).  
  
The z coordinate is the distance from the camera in world units.  
  
If `position` is outside the Camera's viewing volume, Unity returns a screen position that's off-screen.

``` codeExampleCS
using UnityEngine;
using System.Collections;

public class ExampleClass : MonoBehaviour

    void Update()
    
}
```
