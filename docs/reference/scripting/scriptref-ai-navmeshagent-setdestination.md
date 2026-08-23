---
title: "Scripting API: AI.NavMeshAgent.SetDestination"
page_title: "Unity - Scripting API: AI.NavMeshAgent.SetDestination"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent.SetDestination.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent.SetDestination.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [NavMeshAgent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent.html).SetDestination

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

public bool <span class="sig-kw">SetDestination</span>([Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">target</span>);

### Parameters

| Parameter | Description                      |
|-----------|----------------------------------|
| target    | The target point to navigate to. |

### Returns

**bool** True if the destination was requested successfully, otherwise false.

### Description

Sets or updates the destination thus triggering the calculation for a new path.

Note that the path may not become available until after a few frames later. While the path is being computed, [pathPending](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent-pathPending.html) will be true. If a valid path becomes available then the agent will resume movement.

``` codeExampleCS
using UnityEngine;
using UnityEngine.AI;

public class Example : MonoBehaviour

    void Update()
    
    }

    void SetDestinationToMousePosition()
    
    }
}
```
