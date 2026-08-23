---
title: "Scripting API: Vector3.sqrMagnitude"
page_title: "Unity - Scripting API: Vector3.sqrMagnitude"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3-sqrMagnitude.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3-sqrMagnitude.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html).sqrMagnitude

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

<span style="color:red;"> </span>public float <span class="sig-kw">sqrMagnitude</span>;

### Description

Returns the squared length of this vector (Read Only).

The magnitude of a vector `v` is calculated as Mathf.Sqrt(Vector3.Dot(v, v)). However, the Sqrt calculation is quite complicated and takes longer to execute than the normal arithmetic operations. Calculating the squared magnitude instead of using the [magnitude](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3-magnitude.html) property is much faster - the calculation is basically the same only without the slow Sqrt call. If you are using magnitudes simply to compare distances, then you can just as well compare squared magnitudes against the squares of distances since the comparison will give the same result.  
  
Additional resources: [magnitude](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3-magnitude.html).

``` codeExampleCS
using UnityEngine;
using System.Collections;

public class ExampleClass : MonoBehaviour

        }
    }
}
```
