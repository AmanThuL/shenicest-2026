---
title: "Scripting API: MonoBehaviour.FixedUpdate()"
page_title: "Unity - Scripting API: MonoBehaviour.FixedUpdate()"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.FixedUpdate.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.FixedUpdate.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html).FixedUpdate()

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

### Description

Update called at regular, fixed intervals as part of Unity's physics update loop.

The interval between calls is determined by the value of [Time.fixedDeltaTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-fixedDeltaTime.html). You can modify this value from code or by updating the **Fixed Timestep** value in the Unity Editor's [Time settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-TimeManager.html). The default is 0.02 seconds (50 calls per second).  
  
Use `FixedUpdate` to perform physics system calculations. For example, use `FixedUpdate` when applying a force to a [Rigidbody](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.html).  
  
Unlike [MonoBehaviour.Update](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Update.html), which is called once per rendered frame, `FixedUpdate` may be called zero, one, or multiple times per frame depending on the frame rate and simulation needs. This ensures that physics calculations remain consistent and deterministic, regardless of how fast the game renders frames. Use [Application.targetFrameRate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-targetFrameRate.html) to set a target frame rate. For more information on managing frame rate variation, refer to [Handling variation in time](https://docs.unity3d.com/6000.3/Documentation/Manual/time-handling-variations.html).  
  
The following example compares the number of `Update` calls against the number of `FixedUpdate` calls.

``` codeExampleCS
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

// GameObject.FixedUpdate example.
//
// Measure frame rate comparing FixedUpdate against Update.
// Show the rates every second.

public class ExampleScript : MonoBehaviour

    // Increase the number of calls to Update.
    void Update()
    
    // Increase the number of calls to FixedUpdate.
    void FixedUpdate()
    
    // Show the number of calls to both messages.
    void OnGUI()
    
    // Update both CountsPerSecond values every second.
    IEnumerator Loop()
    
    }
}
```
