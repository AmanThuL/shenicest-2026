---
title: "Scripting API: Rigidbody.MovePosition"
page_title: "Unity - Scripting API: Rigidbody.MovePosition"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.MovePosition.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.MovePosition.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Rigidbody](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.html).MovePosition

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-Rigidbody.html" class="switch-link gray-btn sbtn left show" title="Go to Rigidbody Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

## Declaration

public void <span class="sig-kw">MovePosition</span>([Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">position</span>);

### Parameters

| Parameter | Description                                                                                                                         |
|-----------|-------------------------------------------------------------------------------------------------------------------------------------|
| position  | Provides the new position for the [Rigidbody](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.html) object. |

### Description

Moves the kinematic [Rigidbody](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.html) towards `position`.

[Rigidbody.MovePosition](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.MovePosition.html) moves a Rigidbody and complies with the interpolation settings. When Rigidbody interpolation is enabled, [Rigidbody.MovePosition](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.MovePosition.html) creates a smooth transition between frames. Unity moves a [Rigidbody](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.html) in each `FixedUpdate` call. The `position` occurs in world space. To teleport a [Rigidbody](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.html) from one position to another, use [Rigidbody.position](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody-position.html) instead of [MovePosition](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.MovePosition.html).

``` codeExampleCS
using UnityEngine;
using UnityEngine.InputSystem;

public class Example : MonoBehaviour

    private void OnDisable()
    
    void Awake()
    
    void FixedUpdate()
    
}
```
