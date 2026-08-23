---
title: "Scripting API: MonoBehaviour.LateUpdate()"
page_title: "Unity - Scripting API: MonoBehaviour.LateUpdate()"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.LateUpdate.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.LateUpdate.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html).LateUpdate()

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

LateUpdate is called every frame, if the [Behaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Behaviour.html) is enabled.

LateUpdate is called after all Update functions have been called. This is useful to order script execution. For example a follow camera should always be implemented in LateUpdate because it tracks objects that might have moved inside Update.

``` codeExampleCS
using UnityEngine;
using System.Collections;

public class ExampleClass : MonoBehaviour

}
```

In order to get the elapsed time since last call to LateUpdate, use [Time.deltaTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-deltaTime.html). This function is only called if the [Behaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Behaviour.html) is enabled. Override this function in order to provide your component's functionality.
