---
title: "Scripting API: MonoBehaviour.OnDisable()"
page_title: "Unity - Scripting API: MonoBehaviour.OnDisable()"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnDisable.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnDisable.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html).OnDisable()

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

Called when a component itself is disabled or its parent GameObject is deactivated.

`OnDisable` is called in the following scenarios:

-   When a component of an active GameObject is disabled via code or the Inspector.
-   When an enabled component's parent GameObject is deactivated.
-   When the component or parent GameObject is destroyed by calling [Object.Destroy](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.Destroy.html).
-   When the scene is unloaded.
-   When scripts are reloaded as part of a domain reload.

`OnDisable` cannot be a [coroutine](https://docs.unity3d.com/6000.3/Documentation/Manual/Coroutines.html).  
  
Additional resources: [MonoBehaviour.OnEnable](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnEnable.html).

``` codeExampleCS
// Implement OnDisable and OnEnable script functions.
// These functions will be called when the attached GameObject
// is activated/deactivated or the script component is enabled/disabled.
// This example also supports running in the Editor. The Update function
// will be called, for example, when the position of the
// GameObject is changed.

using UnityEngine;

[ExecuteInEditMode]
public class PrintOnOff : MonoBehaviour

    void OnEnable()
    
    void Update()
    
}
```
