---
title: "Scripting API: Events.UnityAction"
page_title: "Unity - Scripting API: .UnityAction"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Events.UnityAction.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Events.UnityAction.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# UnityAction

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

public delegate void <span class="sig-kw">UnityAction</span>();

### Description

Zero argument delegate used by UnityEvents.

Use this to create some dynamic functionality in your scripts. Unity Actions allow you to dynamically call multiple functions. Since Unity Actions have no arguments, functions they call must also have no arguments. See [Delegates](https://unity3d.com/learn/tutorials/topics/scripting/delegates) for more information.

``` codeExampleCS
//Attach this script to a GameObject. Attach a Renderer and Button component to the same GameObject for this example.
//This script will change the Color of the GameObject as well as output messages to the Console saying which function was run by the UnityAction.

using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Events;

public class UnityActionExample : MonoBehaviour

    void MyFunction()
    
    void MySecondFunction()
    
}
```
