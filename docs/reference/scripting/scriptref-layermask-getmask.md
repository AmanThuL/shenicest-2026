---
title: "Scripting API: LayerMask.GetMask"
page_title: "Unity - Scripting API: LayerMask.GetMask"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/LayerMask.GetMask.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/LayerMask.GetMask.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [LayerMask](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/LayerMask.html).GetMask

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

public static int <span class="sig-kw">GetMask</span>(params string\[\] <span class="sig-kw">layerNames</span>);

### Parameters

| Parameter  | Description                                     |
|------------|-------------------------------------------------|
| layerNames | List of layer names to convert to a layer mask. |

### Returns

**int** The layer mask created from the `layerNames`.

### Description

Given a set of layer names as defined by either a Builtin or a User Layer in the [Tags and Layers manager](https://docs.unity3d.com/6000.3/Documentation/Manual/class-TagManager.html), returns the equivalent layer mask for all of them.

``` codeExampleCS
using UnityEngine;

public class Example : MonoBehaviour

}
```

**Note:** Suppose `UserLayerA` and `UserLayerB` are the tenth and eleventh layers. These will have a User Layer values of 10 and 11. To obtain their layer mask value their names can be passed into [GetMask](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/LayerMask.GetMask.html). The argument can either be a list of their names or an array of strings storing their names. In this case the return value will be 2^10 + 2^11 = 3072.
