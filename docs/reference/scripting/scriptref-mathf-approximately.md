---
title: "Scripting API: Mathf.Approximately"
page_title: "Unity - Scripting API: Mathf.Approximately"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.Approximately.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.Approximately.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Mathf](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.html).Approximately

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

public static bool <span class="sig-kw">Approximately</span>(float <span class="sig-kw">a</span>, float <span class="sig-kw">b</span>);

### Description

Compares two floating point values and returns true if they are similar.

Floating point imprecision makes comparing floats using the equals operator inaccurate. For example, `(1.0 == 10.0 / 10.0)` might not return true every time. Approximately() compares two floats and returns true if they are within a small value ([Epsilon](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.Epsilon.html)) of each other.

``` codeExampleCS
using UnityEngine;

public class ScriptExample : MonoBehaviour

    }
}
```
