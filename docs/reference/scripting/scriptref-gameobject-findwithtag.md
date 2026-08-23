---
title: "Scripting API: GameObject.FindWithTag"
page_title: "Unity - Scripting API: GameObject.FindWithTag"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.FindWithTag.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.FindWithTag.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html).FindWithTag

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-GameObject.html" class="switch-link gray-btn sbtn left show" title="Go to GameObject Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

## Declaration

public static [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html) <span class="sig-kw">FindWithTag</span>(string <span class="sig-kw">tag</span>);

### Parameters

| Parameter | Description            |
|-----------|------------------------|
| tag       | The tag to search for. |

### Description

Retrieves the first active [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html) tagged with the specified tag. Returns null if no GameObject has the tag.

Tags must be declared in the tag manager before using them. A `UnityException` is thrown if the tag does not exist or if an empty string or `null` is supplied as the `tag` parameter.  
  
**Note:** This method returns the first GameObject it finds with the specified tag. If a scene contains multiple active GameObjects with the specified tag, there is no guarantee this method will return a specific GameObject.

``` codeExampleCS
using UnityEngine;
using System.Collections;

public class ExampleClass : MonoBehaviour

}
```
