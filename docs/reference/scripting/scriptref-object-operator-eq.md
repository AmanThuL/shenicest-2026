---
title: "Scripting API: Object.operator =="
page_title: "Unity - Scripting API: Object.operator =="
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-operator_eq.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-operator_eq.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Object](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html).operator ==

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-Object.html" class="switch-link gray-btn sbtn left show" title="Go to Object Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>public static bool <span class="sig-kw">operator ==</span>([Object](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html) <span class="sig-kw">x</span>, [Object](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html) <span class="sig-kw">y</span>);

### Parameters

| Parameter | Description                              |
|-----------|------------------------------------------|
| x         | The first object.                        |
| y         | The object to compare against the first. |

### Description

Compares two object references to see if they refer to the same object.

When comparing with `null`, Unity's implementation of the equality operator can give different results than `Object.ReferenceEquals` or `==` in standard C#.  
  
In addition to checking if the managed object reference is `null`, the custom `==` operator in `UnityEngine.Object` also checks if the underlying native object pointer is null. If either is true, `== null` evaluates to `true`.  
  
For more information on why and how some managed objects can exist in a so-called detached state without a counterpart native object, refer to [Object](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Object.html).

``` codeExampleCS
using UnityEngine;

public class Example : MonoBehaviour

    }
}
```

Return early if there is no target:

``` codeExampleCS
using UnityEngine;

public class Example : MonoBehaviour

    }
}
```
