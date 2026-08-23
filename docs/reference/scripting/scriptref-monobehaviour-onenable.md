---
title: "Scripting API: MonoBehaviour.OnEnable()"
page_title: "Unity - Scripting API: MonoBehaviour.OnEnable()"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnEnable.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnEnable.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html).OnEnable()

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

Called when a component of an active GameObject is first enabled.

`OnEnable` is called in the following scenarios:

-   When entering Play mode, if the GameObject is active ([GameObject.activeInHierarchy](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject-activeInHierarchy.html) == `true`) and the script component is enabled ([Behaviour.enabled](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Behaviour-enabled.html) == `true`).
-   When enabling the script component at runtime (via code or the Inspector), if the GameObject is already active.
-   When activating the GameObject (or one of its inactive parent GameObjects) at runtime, if the script component is already enabled.

`OnEnable` is always called after [MonoBehaviour.Awake](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Awake.html) and before [MonoBehaviour.Start](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Start.html) on entering Play Mode.  
  
`OnEnable` cannot be a [coroutine](https://docs.unity3d.com/6000.3/Documentation/Manual/Coroutines.html).  
  
Additional resources: [MonoBehaviour.OnDisable](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnDisable.html).

``` codeExampleCS
// Implement OnDisable and OnEnable script functions.
// These functions will be called when the script component
// is enabled.
// This example also supports the Editor. The Update function
// will be called, for example, when the position of the
// GameObject is changed.

using UnityEngine;

[ExecuteInEditMode]
public class PrintOnOff : MonoBehaviour

    void OnEnable()
    
    void Update()
    
}
```
