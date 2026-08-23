---
title: "Scripting API: Vector3.Dot"
page_title: "Unity - Scripting API: Vector3.Dot"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.Dot.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.Dot.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html).Dot

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

public static float <span class="sig-kw">Dot</span>([Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">lhs</span>, [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">rhs</span>);

### Parameters

| Parameter | Description                           |
|-----------|---------------------------------------|
| lhs       | The left operand of the dot product.  |
| rhs       | The right operand of the dot product. |

### Returns

**float** The dot product of the lhs and rhs vectors.

### Description

Calculates the dot product of two three-dimensional vectors defined in the same coordinate space.

The dot product is a float value equal to the product of the magnitudes of the lhs and rhs vectors and the cosine of the angle between them.  
  
For [normalized](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3-normalized.html) vectors Dot returns 1 if they point in exactly the same direction, -1 if they point in completely opposite directions and zero if the vectors are perpendicular.  
  
The dot product can also be used to find the scalar component of one vector in the direction of another vector.

``` codeExampleCS
// detects if other transform is behind this object

using UnityEngine;
using System.Collections;

public class Vector3DotProductExample : MonoBehaviour

        }
    }
}
```
