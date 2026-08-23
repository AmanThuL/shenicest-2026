---
title: "Scripting API: Rigidbody.isKinematic"
page_title: "Unity - Scripting API: Rigidbody.isKinematic"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody-isKinematic.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody-isKinematic.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Rigidbody](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.html).isKinematic

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

<span style="color:red;"> </span>public bool <span class="sig-kw">isKinematic</span>;

### Description

Controls whether physics affects the rigidbody.

If isKinematic is enabled, Forces, collisions or joints will not affect the rigidbody anymore. The rigidbody will be under full control of animation or script control by changing transform.position. Kinematic bodies also affect the motion of other rigidbodies through collisions or joints. Eg. can connect a kinematic rigidbody to a normal rigidbody with a joint and the rigidbody will be constrained with the motion of the kinematic body. Kinematic rigidbodies are also particularly useful for making characters which are normally driven by an animation, but on certain events can be quickly turned into a ragdoll by setting isKinematic to false.

``` codeExampleCS
using UnityEngine;
using System.Collections;

public class ExampleClass : MonoBehaviour

    // Let the rigidbody take control and detect collisions.
    void EnableRagdoll()
    
    // Let animation control the rigidbody and ignore collisions.
    void DisableRagdoll()
    
}
```
