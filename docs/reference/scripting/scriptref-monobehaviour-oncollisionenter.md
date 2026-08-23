---
title: "Scripting API: MonoBehaviour.OnCollisionEnter"
page_title: "Unity - Scripting API: MonoBehaviour.OnCollisionEnter(Collision)"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnCollisionEnter.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnCollisionEnter.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html).OnCollisionEnter(Collision)

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-MonoBehaviour.html" class="switch-link gray-btn sbtn left show" title="Go to MonoBehaviour Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

### Parameters

| Parameter | Description                                                                                                                        |
|-----------|------------------------------------------------------------------------------------------------------------------------------------|
| collision | The [Collision](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Collision.html) data associated with this collision. |

### Description

OnCollisionEnter is called when this collider/rigidbody has begun touching another rigidbody/collider.

`OnCollisionEnter` receives an instance of the [Collision](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Collision.html) class as the `collision` parameter. This parameter contains information about the collision such as contact points and impact velocity. If you don't use this collision data in your `OnCollisionEnter` callback, leave out the `collision` parameter from the method declaration to avoid unneccessary calculations.  
  
**Note:** Collision events are only sent if one of the colliders also has a non-kinematic rigidbody attached. Collision events will be sent to disabled MonoBehaviours, to allow enabling Behaviours in response to collisions.  
  
`OnCollisionEnter` can be a [coroutine](https://docs.unity3d.com/6000.3/Documentation/Manual/Coroutines.html)

``` codeExampleCS
using UnityEngine;
using System.Collections;

public class ExampleClass : MonoBehaviour

    void OnCollisionEnter(Collision collision)
    
        if (collision.relativeVelocity.magnitude > 2)
            audioSource.Play();
    }
}
```
