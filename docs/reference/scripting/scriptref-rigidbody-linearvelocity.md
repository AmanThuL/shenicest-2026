---
title: "Scripting API: Rigidbody.linearVelocity"
page_title: "Unity - Scripting API: Rigidbody.linearVelocity"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody-linearVelocity.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody-linearVelocity.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Rigidbody](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.html).linearVelocity

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

<span style="color:red;"> </span>public [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">linearVelocity</span>;

### Description

The linear velocity vector of the rigidbody. It represents the rate of change of Rigidbody position.

In most cases you should not modify the velocity directly, as this can result in unrealistic behaviour - use AddForce instead Do not set the linear velocity of an object every physics step, this will lead to unrealistic physics simulation. A typical usage is where you would change the velocity is when jumping in a first person shooter, because you want an immediate change in velocity.  
  
**Note:** The linearVelocity is a world-space property.

``` codeExampleCS
using UnityEngine;
using UnityEngine.InputSystem;

// The velocity along the y axis is 10 units per second.  If the GameObject starts at (0,0,0) then
// it will reach (0,100,0) units after 10 seconds.

public class ExampleClass : MonoBehaviour

    void Update()
    
    void FixedUpdate()
    
        if (isMoving)
        
        }
    }
}
```

**Note:** A velocity in Unity is units per second. The units are often thought of as metres but could be millimetres or light years. Unity velocity also has the speed in X, Y, and Z defining the direction. Additionally, setting the linear velocity of a kinematic rigidbody is not allowed and will have no effect.
