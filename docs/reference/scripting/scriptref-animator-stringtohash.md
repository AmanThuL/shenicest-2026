---
title: "Scripting API: Animator.StringToHash"
page_title: "Unity - Scripting API: Animator.StringToHash"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.StringToHash.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.StringToHash.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Animator](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.html).StringToHash

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-Animator.html" class="switch-link gray-btn sbtn left show" title="Go to Animator Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

## Declaration

public static int <span class="sig-kw">StringToHash</span>(string <span class="sig-kw">name</span>);

### Parameters

| Parameter | Description                     |
|-----------|---------------------------------|
| name      | The string to convert to an id. |

### Returns

**int** The hash of the input string.

### Description

Generates a parameter id from a string.

This method uses CRC32 to generate an id from a string. Use a generated id to optimize assigning and retrieving parameters. A generated id is valid as long as the input string doesn't change. This means that a generated id persists between sessions and can be used for networking.

``` codeExampleCS
using UnityEngine;

// Press the space key in Play Mode to switch to the Bounce state.

[RequireComponent(typeof(Animator))]
public class AnimatorPlayExample : MonoBehaviour

    void Update()
    
    }
}
```
