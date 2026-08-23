---
title: "Scripting API: Rigidbody.linearDamping"
page_title: "Unity - Scripting API: Rigidbody.linearDamping"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody-linearDamping.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody-linearDamping.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Rigidbody](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.html).linearDamping

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

<span style="color:red;"> </span>public float <span class="sig-kw">linearDamping</span>;

### Description

The linear damping of the Rigidbody linear velocity.

linearDamping can be used to slow down an object. Zero indicates that no damping should be used whereas higher values increase the damping, effectively slowing down the linear motion faster. **Note:** The following formula is how the linear damping is applied: `linearVelocity *= ( 1 - linearDamping * dt )` Additional resources: [Rigidbody.angularDamping](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody-angularDamping.html).

``` codeExampleCS
using UnityEngine;
using UnityEngine.InputSystem;

public class ExampleClass : MonoBehaviour

    void OpenParachute()
    
    void Update()
    
}
```
