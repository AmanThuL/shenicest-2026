---
title: "Scripting API: Camera.ScreenPointToRay"
page_title: "Unity - Scripting API: Camera.ScreenPointToRay"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Camera.ScreenPointToRay.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Camera.ScreenPointToRay.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Camera](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Camera.html).ScreenPointToRay

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

public [Ray](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Ray.html) <span class="sig-kw">ScreenPointToRay</span>([Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">pos</span>);

<span style="color:red;"> </span>

## Declaration

public [Ray](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Ray.html) <span class="sig-kw">ScreenPointToRay</span>([Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">pos</span>, [Camera.MonoOrStereoscopicEye](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Camera.MonoOrStereoscopicEye.html) <span class="sig-kw">eye</span>);

### Parameters

| Parameter | Description                                                                                                                                                                                                                                                           |
|-----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| pos       | A 3D point, with the x and y coordinates containing a 2D screen space point in pixels. The lower left pixel of the screen is (0,0). The upper right pixel of the screen is (screen width in pixels - 1, screen height in pixels - 1). Unity ignores the z coordinate. |
| eye       | Optional argument that can be used to specify which eye transform to use. Default is Mono.                                                                                                                                                                            |

### Description

Returns a ray going from camera through a screen point.

Resulting ray is in world space, starting on the near plane of the camera and going through position's (x,y) pixel coordinates on the screen.

``` codeExampleCS
//Attach this script to your Camera
//This draws a line in the Scene view going through a point 200 pixels from the lower-left corner of the screen
//To see this, enter Play Mode and switch to the Scene tab. Zoom into your Camera's position.
using UnityEngine;
using System.Collections;

public class ExampleClass : MonoBehaviour

    void Update()
    
}
```
