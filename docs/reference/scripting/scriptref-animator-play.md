---
title: "Scripting API: Animator.Play"
page_title: "Unity - Scripting API: Animator.Play"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.Play.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.Play.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Animator](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.html).Play

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

public void <span class="sig-kw">Play</span>(string <span class="sig-kw">stateName</span>, int <span class="sig-kw">layer</span> = -1, float <span class="sig-kw">normalizedTime</span> = float.NegativeInfinity);

<span style="color:red;"> </span>

## Declaration

public void <span class="sig-kw">Play</span>(int <span class="sig-kw">stateNameHash</span>, int <span class="sig-kw">layer</span> = -1, float <span class="sig-kw">normalizedTime</span> = float.NegativeInfinity);

### Parameters

| Parameter      | Description                                                                                  |
|----------------|----------------------------------------------------------------------------------------------|
| stateName      | The state name.                                                                              |
| stateNameHash  | The state hash name. If stateNameHash is 0, it changes the current state time.               |
| layer          | The layer index. If layer is -1, it plays the first state with the given state name or hash. |
| normalizedTime | The time offset between zero and one.                                                        |

### Description

Plays a state.

When you specify a state name, or the string used to generate a hash, it should include the name of the parent layer. For example, if you have a `Bounce` state in the `Base Layer`, the name is `Base Layer.Bounce`. When you use the `stateName` parameter, this method calls [Animator.StringToHash](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.StringToHash.html) internally. If you use this method with the same `stateName` often, precompute the hash and use the `stateHashName` parameter to improve performance.  
  
The `normalizedTime` parameter varies between 0 and 1. If this parameter is left at zero then [Play](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.Play.html) will operate as expected. A different starting point can be given. An example could be `normalizedTime` set to 0.5, which means the animation starts halfway through. If the transition from one state switches to another, it may or may not be blended. If the transition starts at 0.75 it will be blended with the other state. If no transition is set up then [Play](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.Play.html) will continue to 1.0 with no changes.  
  
![](https://docs.unity3d.com/6000.3/Documentation/StaticFiles/ScriptRefImages/AnimatorPlay.png)  
*The following example script animates a cube.*  
  
This cube has two Animator states called `Rest` and `Bounce`. An empty animation is played in the `Rest` state. When the Space key is pressed the cube switches into the `Bounce` state. This causes the cube to jump up and down twice. The cube then returns to the `Rest` state. Because `Bounce` is selected from the [Animator.Play](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.Play.html) script, no Transition is needed. However the return from `Bounce` to `Rest` does have a Transition. `Has Exit Time` is ticked to make `Bounce` last for its one second. Attach this script to the GameObject you want to animate.

``` codeExampleCS
using UnityEngine;

// Press the space key in Play Mode to switch to the Bounce state.

[RequireComponent(typeof(Animator))]
public class AnimatorPlayExample : MonoBehaviour

    void Update()
    
    }
}
```

Additional resources: [Animator.StringToHash](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.StringToHash.html) for how to get a hash from the name.
