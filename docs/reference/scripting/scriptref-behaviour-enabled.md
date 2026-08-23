---
title: "Scripting API: Behaviour.enabled"
page_title: "Unity - Scripting API: Behaviour.enabled"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Behaviour-enabled.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Behaviour-enabled.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Behaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Behaviour.html).enabled

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

<span style="color:red;"> </span>public bool <span class="sig-kw">enabled</span>;

### Description

True if this Behaviour is enabled, otherwise false.

You typically interact with this property via the derived [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html) class. You can enable a MonoBehaviour through the checkbox in the **Inspector** window or by setting this value from code.  
  
Disabled MonoBehaviours don't receive regular lifecycle callbacks such as [MonoBehaviour.Update](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Update.html) but they still receive the following:

-   [MonoBehaviour.Awake](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Awake.html)
-   [MonoBehaviour.Reset](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Reset.html)
-   [MonoBehaviour.OnDestroy](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnDestroy.html)

``` codeExampleCS
using UnityEngine;
using System.Collections;
using UnityEngine.UI; // Required when Using UI elements.

public class Example : MonoBehaviour

}
```
