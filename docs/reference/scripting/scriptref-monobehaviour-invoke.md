---
title: "Scripting API: MonoBehaviour.Invoke"
page_title: "Unity - Scripting API: MonoBehaviour.Invoke"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Invoke.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Invoke.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html).Invoke

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

## Declaration

public void <span class="sig-kw">Invoke</span>(string <span class="sig-kw">methodName</span>, float <span class="sig-kw">time</span>);

### Description

Invokes the method `methodName` in time seconds.

If time is set to 0 and Invoke is called before the first frame update, the method is invoked at the next Update cycle before [MonoBehaviour.Update](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Update.html). In this case, it's better to call the function directly.  
  
Note: Setting time to negative values is identical to setting it to 0.  
  
In other cases, the order of execution of the method depends on the timing of the invocation.  
  
If you need to pass parameters to your method, consider using [Coroutine](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Coroutine.html) instead. Coroutines also provide better performance.

``` codeExampleCS
using UnityEngine;
using System.Collections.Generic;

public class ExampleScript : MonoBehaviour

    void LaunchProjectile()
    
}
```
