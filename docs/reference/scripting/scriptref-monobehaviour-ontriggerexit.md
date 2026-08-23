---
title: "Scripting API: MonoBehaviour.OnTriggerExit"
page_title: "Unity - Scripting API: MonoBehaviour.OnTriggerExit(Collider)"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnTriggerExit.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnTriggerExit.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html).OnTriggerExit(Collider)

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

| Parameter | Description                                    |
|-----------|------------------------------------------------|
| other     | The other collider involved in this collision. |

### Description

OnTriggerExit is called when a collider stops touching a trigger.

`OnTriggerExit` is called during whichever iteration of the physics `FixedUpdate` loop Unity detects that a collider is no longer touching a trigger it was previously touching.  
  
Both GameObjects must contain a [Collider](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Collider.html) component. At least one of the colliders must be a trigger collider and at least one must be a physics body collider. For more information, refer to [OnTrigger events](https://docs.unity3d.com/6000.3/Documentation/Manual/collider-interactions-ontrigger.html).  
  
Trigger events are sent to disabled MonoBehaviours, to allow enabling Behaviours in response to collisions. Deactivating or destroying a collider while it is inside a trigger volume does not cause an `OnTriggerExit` message to be sent.  
  
Both the trigger and the collider that touches the trigger receive `OnTriggerEnter` if they have implemented it.  
  
`OnTriggerExit` can be a coroutine.

``` codeExampleCS
// Destroy everything that leaves the trigger

using UnityEngine;
using System.Collections;

public class ExampleClass : MonoBehaviour

}
```
