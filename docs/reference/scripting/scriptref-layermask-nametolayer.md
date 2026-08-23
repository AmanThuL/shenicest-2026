---
title: "Scripting API: LayerMask.NameToLayer"
page_title: "Unity - Scripting API: LayerMask.NameToLayer"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/LayerMask.NameToLayer.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/LayerMask.NameToLayer.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [LayerMask](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/LayerMask.html).NameToLayer

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

## Declaration

public static int <span class="sig-kw">NameToLayer</span>(string <span class="sig-kw">layerName</span>);

### Description

Given a layer name, returns the layer index as defined by either a Builtin or a User Layer in the [Tags and Layers manager](https://docs.unity3d.com/6000.3/Documentation/Manual/class-TagManager.html).

Returns -1 if not found.

``` codeExampleCS
using UnityEngine;

public class Example : MonoBehaviour

}
```
