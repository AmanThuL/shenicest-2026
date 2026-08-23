---
title: "Scripting API: GameObject.CompareTag"
page_title: "Unity - Scripting API: GameObject.CompareTag"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.CompareTag.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.CompareTag.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html).CompareTag

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

public bool <span class="sig-kw">CompareTag</span>(string <span class="sig-kw">tag</span>);

### Parameters

| Parameter | Description                             |
|-----------|-----------------------------------------|
| tag       | The tag to check for on the GameObject. |

### Returns

**bool** `true` if the GameObject has the given tag, `false` otherwise.

### Description

Checks if the specified tag is attached to the GameObject.

The example below calls `CompareTag` on a [Collider](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Collider.html) to check if it has the `Player` tag.

``` codeExampleCS
// Immediate death trigger.
// Destroys any colliders that enter the trigger, if they are tagged "Player".
using UnityEngine;
using System.Collections;

public class ExampleClass : MonoBehaviour

    }
}
```

Additional resources: [GameObject.FindWithTag](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.FindWithTag.html)

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public bool <span class="sig-kw">CompareTag</span>([TagHandle](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/TagHandle.html) <span class="sig-kw">tag</span>);

### Parameters

| Parameter | Description                                                                                                                                      |
|-----------|--------------------------------------------------------------------------------------------------------------------------------------------------|
| tag       | A [TagHandle](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/TagHandle.html) representing the tag to check for on the GameObject. |

### Returns

**bool** `true` if the GameObject has the given tag, `false` otherwise.

### Description

Checks if the specified tag is attached to the GameObject.

This overload of the method, which takes a [TagHandle](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/TagHandle.html), can be faster than the overload which takes a string, particularly if the same `TagHandle` can be reused for many calls.  
  
The example below calls `CompareTag` with a `TagHandle` on a [Collider](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Collider.html) to check if it has the `Player` tag:

``` codeExampleCS
// Immediate death trigger.
// Destroys any colliders that enter the trigger, if they are tagged "Player".
using UnityEngine;
using System.Collections;

public class ExampleClass : MonoBehaviour

    void OnTriggerEnter(Collider other)
    
    }
}
```

Additional resources: [TagHandle](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/TagHandle.html)
