---
title: "Scripting API: Animator.SetBool"
page_title: "Unity - Scripting API: Animator.SetBool"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.SetBool.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.SetBool.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Animator](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.html).SetBool

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

public void <span class="sig-kw">SetBool</span>(string <span class="sig-kw">name</span>, bool <span class="sig-kw">value</span>);

<span style="color:red;"> </span>

## Declaration

public void <span class="sig-kw">SetBool</span>(int <span class="sig-kw">id</span>, bool <span class="sig-kw">value</span>);

### Parameters

| Parameter | Description              |
|-----------|--------------------------|
| name      | The parameter name.      |
| id        | The parameter ID.        |
| value     | The new parameter value. |

### Description

Sets the value of the given boolean parameter.

Use Animator.SetBool to pass Boolean values to an [Animator Controller](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AnimatorController.html) via script.  
  
Use this to trigger transitions between Animator states. For example, triggering a death animation by setting an “alive” boolean to false. See documentation on [Animation](https://docs.unity3d.com/6000.3/Documentation/Manual/AnimatorControllerCreation.html) for more information on setting up Animators.  
  
Note: You can identify the parameter by name or by ID number, but the name or ID number must be the same as the parameter you want to change in the Animator.

``` codeExampleCS
//Set up a new Boolean parameter in the Unity Animator and name it, in this case “Jump”.
//Set up transitions between each state that the animation could follow. For example, the player could be running or idle before they jump, so both would need transitions into the animation.
//If the “Jump” boolean is set to true at any point, the m_Animator plays the animation. However, if it is ever set to false, the animation would return to the appropriate state (“Idle”).
//This script enables and disables this boolean in this case by listening for the mouse click or a tap of the screen.

using UnityEngine;

public class Example : MonoBehaviour

    void Update()
    
}
```
