---
title: "Scripting API: Animator.SetFloat"
page_title: "Unity - Scripting API: Animator.SetFloat"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.SetFloat.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.SetFloat.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Animator](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.html).SetFloat

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

public void <span class="sig-kw">SetFloat</span>(string <span class="sig-kw">name</span>, float <span class="sig-kw">value</span>);

<span style="color:red;"> </span>

## Declaration

public void <span class="sig-kw">SetFloat</span>(string <span class="sig-kw">name</span>, float <span class="sig-kw">value</span>, float <span class="sig-kw">dampTime</span>, float <span class="sig-kw">deltaTime</span>);

<span style="color:red;"> </span>

## Declaration

public void <span class="sig-kw">SetFloat</span>(int <span class="sig-kw">id</span>, float <span class="sig-kw">value</span>);

<span style="color:red;"> </span>

## Declaration

public void <span class="sig-kw">SetFloat</span>(int <span class="sig-kw">id</span>, float <span class="sig-kw">value</span>, float <span class="sig-kw">dampTime</span>, float <span class="sig-kw">deltaTime</span>);

### Parameters

| Parameter | Description                           |
|-----------|---------------------------------------|
| name      | The parameter name.                   |
| id        | The parameter ID.                     |
| value     | The new parameter value.              |
| dampTime  | The damper total time.                |
| deltaTime | The delta time to give to the damper. |

### Description

Send float values to the Animator to affect transitions.

Use SetFloat in a script to send float values to the Animator in order to activate transitions. In the Animator, define what values affect how certain animations transition. This is useful in various situations, especially in animation cycles such as movement animations where you might require the character to walk or run depending on the button pressure applied.

``` codeExampleCS
//The code below shows how to send the horizontal value of the controller or keys to the Animator.
//You must assign the same parameter name in the Animator as you set in SetFloat, in this case “horizontalSpeed”. You must also handle the transition conditions in the Animator, to tell which values should cause each transition.
//For example, the walking animation triggers when the horizontal value is above 0, and the running animation triggers when the horizontal value reaches past 0.5. Assigning animations to states are also done in the Animator.

using UnityEngine;

public class Example : MonoBehaviour

    void Update()
    
}
```

![](https://docs.unity3d.com/6000.3/Documentation/StaticFiles/ScriptRefImages/AnimatorSetFloat.png)  
  
Above is an example setup of the Animator for accepting floats.
