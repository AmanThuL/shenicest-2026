---
title: "Scripting API: MonoBehaviour.Start()"
page_title: "Unity - Scripting API: MonoBehaviour.Start()"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Start.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Start.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html).Start()

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

Start is called on the frame when a script is enabled just before any of the Update methods are called the first time.

`Start` is called exactly once in the lifetime of the script and always after [MonoBehaviour.Awake](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Awake.html). `Start` might not be called on the same frame as `Awake` if the script is not enabled at initialization time.  
  
`Start` is not called on any object until `Awake` has been called on every object in the scene. In cases where object A's initialization code relies on object B already being initialized, you can initialize B in B's `Awake` and initialize A in A's `Start`.  
  
If you instantiate objects at runtime from [MonoBehaviour.Update](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Update.html), `Awake` and `Start` are called on the instantiated objects before the end of the current frame.  
  
`Start` can be defined as a [coroutine](https://docs.unity3d.com/6000.3/Documentation/Manual/Coroutines.html).

``` codeExampleCS
// Initializes the target variable.
// target is private and thus not editable in the Inspector

// The ExampleClass starts with Awake.  The GameObject class has activeSelf
// set to false.  When activeSelf is set to true the Start() and Update()
// functions will be called causing the ExampleClass to run.
// Note that ExampleClass (Script) in the Inspector is turned off.  It
// needs to be ticked to make script call Start.

using UnityEngine;
using System.Collections;

public class ExampleClass : MonoBehaviour

    IEnumerator Start()
    
    void Update()
    
    }
}
```
