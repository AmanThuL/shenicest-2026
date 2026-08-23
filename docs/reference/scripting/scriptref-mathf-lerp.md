---
title: "Scripting API: Mathf.Lerp"
page_title: "Unity - Scripting API: Mathf.Lerp"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.Lerp.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.Lerp.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Mathf](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.html).Lerp

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-Mathf.html" class="switch-link gray-btn sbtn left show" title="Go to Mathf Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

## Declaration

public static float <span class="sig-kw">Lerp</span>(float <span class="sig-kw">a</span>, float <span class="sig-kw">b</span>, float <span class="sig-kw">t</span>);

### Parameters

| Parameter | Description                                     |
|-----------|-------------------------------------------------|
| a         | The start value.                                |
| b         | The end value.                                  |
| t         | The interpolation value between the two floats. |

### Returns

**float** The interpolated float result between the two float values.

### Description

Linearly interpolates between `a` and `b` by `t`.

The parameter `t` is clamped to the range \[0, 1\].  
  
When `t` = 0 returns `a`.  
When `t` = 1 return `b`.  
When `t` = 0.5 returns the midpoint of `a` and `b`.

``` codeExampleCS
using UnityEngine;

public class Example : MonoBehaviour

    }
}
```

Additional resources: [LerpUnclamped](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.LerpUnclamped.html), [LerpAngle](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.LerpAngle.html), [InverseLerp](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.InverseLerp.html).
