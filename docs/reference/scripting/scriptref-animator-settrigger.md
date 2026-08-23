---
title: "Scripting API: Animator.SetTrigger"
page_title: "Unity - Scripting API: Animator.SetTrigger"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.SetTrigger.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.SetTrigger.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Animator](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.html).SetTrigger

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

public void <span class="sig-kw">SetTrigger</span>(string <span class="sig-kw">name</span>);

<span style="color:red;"> </span>

## Declaration

public void <span class="sig-kw">SetTrigger</span>(int <span class="sig-kw">id</span>);

### Parameters

| Parameter | Description         |
|-----------|---------------------|
| name      | The parameter name. |
| id        | The parameter ID.   |

### Description

Sets the value of the given trigger parameter.

This method allows you to set (i.e. activate) an animation trigger, to cause a change in flow in the state machine of an animator controller. The [Animation Parameters](https://docs.unity3d.com/6000.3/Documentation/Manual/AnimationParameters.html) page describes the purpose of the Animator Controller Parameters window. `Trigger` is one of the 4 selectable options. Selecting this adds a `Trigger` to the list of chosen parameters. Once this is added to the selected list it can be named. Unlike `bool`s which have the same `true/false` option, `Trigger`s have a `true` option which automatically returns back to `false`. A typical example might be to have a Jump option. If this option is entered during run-time the character will jump. At the end of the Jump the previous motion (perhaps a walk or run state) will be returned to.  
  
In the example script below, pressing `UpArrow` or `DownArrow` activates the Jump or Crouch triggers using [SetTrigger](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.SetTrigger.html).

``` codeExampleCS
//Attach this script to a GameObject with an Animator component attached.
//For this example, create parameters in the Animator and name them “Crouch” and “Jump”
//Apply these parameters to your transitions between states

//This script allows you to trigger an Animator parameter and reset the other that could possibly still be active. Press the up and down arrow keys to do this.

using UnityEngine;

public class Example : MonoBehaviour

    void Update()
    
        if (Input.GetKey(KeyCode.DownArrow))
        
    }
}
```
