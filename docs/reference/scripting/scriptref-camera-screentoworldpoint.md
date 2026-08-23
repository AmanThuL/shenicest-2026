---
title: "Scripting API: Camera.ScreenToWorldPoint"
page_title: "Unity - Scripting API: Camera.ScreenToWorldPoint"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Camera.ScreenToWorldPoint.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Camera.ScreenToWorldPoint.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Camera](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Camera.html).ScreenToWorldPoint

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

public [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">ScreenToWorldPoint</span>([Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">position</span>);

<span style="color:red;"> </span>

## Declaration

public [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">ScreenToWorldPoint</span>([Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">position</span>, [Camera.MonoOrStereoscopicEye](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Camera.MonoOrStereoscopicEye.html) <span class="sig-kw">eye</span>);

### Parameters

| Parameter | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|-----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| position  | A 2D screen space point in pixels, plus a z coordinate for the distance from the camera in world units. The lower left pixel of the screen is (0,0). The upper right pixel of the screen is (screen width in pixels - 1, screen height in pixels - 1).                                                                                                                                                                                                                                                          |
| eye       | By default, [Camera.MonoOrStereoscopicEye.Mono](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Camera.MonoOrStereoscopicEye.Mono.html). Can be set to [Camera.MonoOrStereoscopicEye.Left](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Camera.MonoOrStereoscopicEye.Left.html) or [Camera.MonoOrStereoscopicEye.Right](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Camera.MonoOrStereoscopicEye.Right.html) for use in stereoscopic rendering (e.g., for VR). |

### Returns

**Vector3** The world space point created by converting the screen space point at the provided distance z from the camera plane.

### Description

Transforms a point from screen space into world space, where world space is defined as the coordinate system at the very top of your game's hierarchy.

World space coordinates can still be calculated even when provided as an off-screen coordinate, for example for instantiating an off-screen object near a specific corner of the screen.  
  
To make sure the world space point is part of the camera's view volume, the z coordinate you provide must be between the camera's `nearClipPlane` and `farClipPlane`.

``` codeExampleCS
// Convert the 2D position of the mouse into a
// 3D position.  Display these on the game window.

using UnityEngine;

public class ExampleClass : MonoBehaviour

    void OnGUI()
    
}
```
