---
title: "Scripting API: Time.timeScale"
page_title: "Unity - Scripting API: Time.timeScale"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-timeScale.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-timeScale.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Time](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time.html).timeScale

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

<span style="color:red;"> </span>public static float <span class="sig-kw">timeScale</span>;

### Description

The rate at which in-game time passes relative to real time.

This can be used for slow motion effects or to speed up your application. When `timeScale` is 1.0, time passes at the same rate as real time. When `timeScale` is 0.5 time passes at half the rate of real time.  
  
When `timeScale` is set to zero your application acts as if paused if all your functions are frame rate independent. Negative values are ignored.  
  
Changing the `timeScale` only takes effect on the following frames.  
  
`FixedUpdate` functions and suspended Coroutines with [WaitForSeconds](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/WaitForSeconds.html) are not called when `timeScale` is set to zero.  
  
If you change [Time.timeScale](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-timeScale.html) but not [Time.fixedDeltaTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-fixedDeltaTime.html), the physics simulation rate remains constant relative to in-game time but not real time. To keep the physics simulation constant relative to real time instead, you can multiply [Time.fixedDeltaTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-fixedDeltaTime.html) by the new `timeScale`. Usually the desired behavior is for the physics simulation to remain consistent relative to in-game time, but some gameplay, audio syncing, or effects logic might rely on a steady real-time fixed update rate.  
  
The following example toggles the time scale between 1 and 0.7 whenever the user hits the Fire1 button, and adjusts fixed delta time according to the new time scale so that the physics simulation remains consistent relative to real time instead of in-game time.

``` codeExampleCS
using UnityEngine;

public class Example : MonoBehaviour

    void Update()
    
    }
}
```
