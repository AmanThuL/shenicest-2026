---
title: "Scripting API: MonoBehaviour.Reset"
page_title: "Unity - Scripting API: MonoBehaviour.Reset()"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Reset.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Reset.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html).Reset()

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

Reset a component to default values.

Reset is called when you select **Reset** in the Inspector's context menu or when you add a component for the first time, either by dragging and dropping in the Inspector or by calling [GameObject.AddComponent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.AddComponent.html) from an Editor script.  
  
Reset is most commonly used to give good default values in the Inspector.  
  
**Note**: `Reset` is only called in Edit mode. If you add components at runtime, `Reset` won't be called.

``` codeExampleCS
// Sets target to a default value.
// This could be used in a follow camera.

using UnityEngine;

public class Example : MonoBehaviour

}
```
