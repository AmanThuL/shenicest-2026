---
title: "Scripting API: MonoBehaviour.OnTriggerEnter"
page_title: "Unity - Scripting API: MonoBehaviour.OnTriggerEnter(Collider)"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnTriggerEnter.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnTriggerEnter.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html).OnTriggerEnter(Collider)

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

| Parameter | Description                                                                                                                   |
|-----------|-------------------------------------------------------------------------------------------------------------------------------|
| other     | The other [Collider](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Collider.html) involved in this collision. |

### Description

Called when a collider enters a trigger collider.

`OnTriggerEnter` is called on whichever iteration of the physics `FixedUpdate` loop Unity first detects that the collider has entered the trigger. The colliders involved are not always at the point of initial contact when Unity detects the collision.  
  
Both GameObjects must contain a [Collider](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Collider.html) component. At least one of the colliders must be a trigger collider and at least one must be a physics body collider. For more information, refer to [OnTrigger events](https://docs.unity3d.com/6000.3/Documentation/Manual/collider-interactions-ontrigger.html).  
  
Both the trigger and the collider that touches the trigger receive `OnTriggerEnter` if they have implemented it. Trigger events are sent to disabled MonoBehaviours to allow enabling Behaviours in response to collisions.

``` codeExampleCS
using UnityEngine;

public class Example : MonoBehaviour

    //Upon collision with another GameObject, this GameObject will reverse direction
    private void OnTriggerEnter(Collider other)
    
}
```
