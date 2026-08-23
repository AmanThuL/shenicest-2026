---
title: "Scripting API: Rigidbody.MoveRotation"
page_title: "Unity - Scripting API: Rigidbody.MoveRotation"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.MoveRotation.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.MoveRotation.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Rigidbody](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.html).MoveRotation

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

public void <span class="sig-kw">MoveRotation</span>([Quaternion](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.html) <span class="sig-kw">rotation</span>);

### Parameters

| Parameter | Description                         |
|-----------|-------------------------------------|
| rotation  | The new rotation for the Rigidbody. |

### Description

Rotates the rigidbody to `rotation`.

Use [Rigidbody.MoveRotation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.MoveRotation.html) to rotate a [Rigidbody](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.html), complying with the Rigidbody's interpolation setting.  
  
If Rigidbody interpolation is enabled on the [Rigidbody](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.html), calling [Rigidbody.MoveRotation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.MoveRotation.html) will resulting in a smooth transition between the two rotations in any intermediate frames rendered. This should be used if you want to continuously rotate a rigidbody in each [FixedUpdate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayerLoop.FixedUpdate.html).  
  
Set [Rigidbody.rotation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody-rotation.html) instead, if you want to teleport a rigidbody from one rotation to another, with no intermediate positions being rendered.

``` codeExampleCS
using UnityEngine;

public class Example : MonoBehaviour

    void FixedUpdate()
    
}
```
