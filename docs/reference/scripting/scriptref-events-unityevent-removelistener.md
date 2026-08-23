---
title: "Scripting API: Events.UnityEvent.RemoveListener"
page_title: "Unity - Scripting API: Events.UnityEvent.RemoveListener"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Events.UnityEvent.RemoveListener.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Events.UnityEvent.RemoveListener.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [UnityEvent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Events.UnityEvent.html).RemoveListener

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

public void <span class="sig-kw">RemoveListener</span>([Events.UnityAction](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Events.UnityAction.html) <span class="sig-kw">call</span>);

### Parameters

| Parameter | Description                      |
|-----------|----------------------------------|
| call      | The callback function to remove. |

### Description

Removes a runtime listener from the UnityEvent.

This method removes all occurrences of the specified listener from the UnityEvent. If you have added the same listener multiple times, this method will remove all occurrences of it. Use this to clean up listeners and avoid unintended callbacks.

``` codeExampleCS
//Attach this script to a GameObject
//This script creates a UnityEvent that calls a method when a key is pressed
//Note that 'q' exits this application.
using UnityEngine;
using UnityEngine.Events;

public class Example : MonoBehaviour

    void Update()
    
        //Press any other key to begin the action if the Event exists
        if (Input.anyKeyDown && m_MyEvent != null)
        
    }

    void OnKeyPressed()
    
}
```
