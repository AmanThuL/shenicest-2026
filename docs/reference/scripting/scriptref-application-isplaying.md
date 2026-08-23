---
title: "Scripting API: Application.isPlaying"
page_title: "Unity - Scripting API: Application.isPlaying"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-isPlaying.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-isPlaying.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Application](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application.html).isPlaying

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

<span style="color:red;"> </span>public static bool <span class="sig-kw">isPlaying</span>;

### Description

Returns true when called in any kind of built Player, or when called in the Editor in Play mode (Read Only).

In a built Player, this method always returns true.  
  
In the Editor, it returns true if the Editor is in Play mode.  
  
Unity might throw an exception when `Application.isPlaying` is accessed in the class constructor or its value is assigned to a variable.  
  
**Note**: In the Editor for [ScriptableObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.html) assets, this property returns false in OnEnable. After reloading the domain, when reloading assemblies, Unity invokes OnEnable on all [ScriptableObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.html) instances. This happens before isPlaying is set to true.  
  
Additional resources: [Application.IsPlaying](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application.IsPlaying.html), [ExecuteAlways](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ExecuteAlways.html).

``` codeExampleCS
using UnityEngine;

class Example : MonoBehaviour

    }
}
```
