---
title: "Scripting API: Object.Destroy"
page_title: "Unity - Scripting API: Object.Destroy"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.Destroy.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.Destroy.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Object](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html).Destroy

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-Object.html" class="switch-link gray-btn sbtn left show" title="Go to Object Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

## Declaration

public static void <span class="sig-kw">Destroy</span>([Object](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html) <span class="sig-kw">obj</span>, float <span class="sig-kw">t</span> = 0.0F);

### Parameters

| Parameter | Description                                                        |
|-----------|--------------------------------------------------------------------|
| obj       | The object to destroy.                                             |
| t         | The optional amount of time to delay before destroying the object. |

### Description

Removes a GameObject, component, or asset.

Destroys the specified object. If a time delay (`t`) is specified, destruction occurs after t seconds have elapsed. The timer starts from the moment `Destroy` is called. Actual object destruction is always delayed until after the current Update loop, but always happens before rendering.  
  
If the object is a component, only that component is removed and destroyed. If the object is a GameObject, the GameObject, all its components, and all its transform children are destroyed together.  
  
Once `Destroy(obj, t)` is called, the object is scheduled for destruction after `t` seconds, regardless of whether the script component that called it is later disabled or destroyed.  
  
`Destroy` is safe to call on objects that might already be destroyed or null. If the object is already destroyed before the scheduled time, no error is thrown when the timer expires. Unity’s internal system tracks the object's state and won't attempt to destroy it again.  
  
The delay parameter `t` is affected by [Time.timeScale](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-timeScale.html). If [Time.timeScale](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-timeScale.html) is set to 0 (for example, if the game is paused), the destruction is delayed until time resumes.  
  
Additional resources: [Object.DestroyImmediate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.DestroyImmediate.html)

``` codeExampleCS
using UnityEngine;

public class ScriptExample : MonoBehaviour

    void DestroyScriptInstance()
    
    void DestroyComponent()
    
    void DestroyObjectDelayed()
    
    // When the user presses Ctrl, it will remove the
    // BoxCollider component from the game object
    void Update()
    
    }
}
```

Destroy is inherited from the UnityEngine.Object base class.
