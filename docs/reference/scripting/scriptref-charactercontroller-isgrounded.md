---
title: "Scripting API: CharacterController.isGrounded"
page_title: "Unity - Scripting API: CharacterController.isGrounded"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/CharacterController-isGrounded.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/CharacterController-isGrounded.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [CharacterController](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/CharacterController.html).isGrounded

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-CharacterController.html" class="switch-link gray-btn sbtn left show" title="Go to CharacterController Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>public bool <span class="sig-kw">isGrounded</span>;

### Description

Was the CharacterController touching the ground during the last move?

Indicates whether the CharacterController was touching the ground during the most recent call to CharacterController.Move or CharacterController.SimpleMove.  
  
This property is updated after each call to Move, based on collision detection with the ground. It returns true if the controller collided with any object below it during the movement — typically used to determine if the character is standing on a surface (e.g., terrain, platform, floor).

``` codeExampleCS
using UnityEngine;

public class Example : MonoBehaviour

    void Update()
    
    }
}
```
