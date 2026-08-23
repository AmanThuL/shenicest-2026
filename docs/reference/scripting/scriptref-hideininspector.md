---
title: "Scripting API: HideInInspector"
page_title: "Unity - Scripting API: HideInInspector"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/HideInInspector.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/HideInInspector.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# HideInInspector

class in UnityEngine

/

Implemented in:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UnityEngine.CoreModule.html" class="cl">UnityEngine.CoreModule</a>

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

<span style="color:red;"> </span>

### Description

Flags a variable to not appear in the Inspector.

By default, a serialized variable automatically appears in the Inspector, even if the variable is private. A variable with this attribute can be serialized and not display in the Inspector.  
  
Additional resources: [SerializedObject.forceChildVisibility](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SerializedObject-forceChildVisibility.html), [SerializedProperty.NextVisible](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SerializedProperty.NextVisible.html), [SerializedProperty.hasVisibleChildren](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SerializedProperty-hasVisibleChildren.html).

``` codeExampleCS
using UnityEngine;

public class HideInInspectorExample : MonoBehaviour

```
