---
title: "Scripting API: Animator.GetCurrentAnimatorStateInfo"
page_title: "Unity - Scripting API: Animator.GetCurrentAnimatorStateInfo"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.GetCurrentAnimatorStateInfo.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.GetCurrentAnimatorStateInfo.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Animator](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.html).GetCurrentAnimatorStateInfo

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

public [AnimatorStateInfo](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimatorStateInfo.html) <span class="sig-kw">GetCurrentAnimatorStateInfo</span>(int <span class="sig-kw">layerIndex</span>);

### Parameters

| Parameter  | Description      |
|------------|------------------|
| layerIndex | The layer index. |

### Returns

**AnimatorStateInfo** An [AnimatorStateInfo](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimatorStateInfo.html) with the information on the current state.

### Description

Returns an [AnimatorStateInfo](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimatorStateInfo.html) with the information on the current state.

Fetches the data from the current state in the Animator. Use this to get details from the state, including accessing the state’s speed, length, name and other variables. For gathering information from the clips that the states hold, see [Animator.GetCurrentAnimatorClipInfo](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.GetCurrentAnimatorClipInfo.html).

``` codeExampleCS
//Create a GameObject and attach an Animator component (Click the Add Component button in the Inspector window, go to Miscellaneous>Animator).
//Create an Animator by going to Assets >  Create > Animator Controller. Attach this Controller to the Animator attached to your GameObject
//In the Animator Controller, create a Trigger parameter in the Parameters tab and name it “Jump”. Then create states and transition arrows that use this parameter.

//This script triggers an Animation parameter when you press the space key.

using UnityEngine;

public class Example : MonoBehaviour

    void Update()
    
        //When entering the Jump state in the Animator, output the message in the console
        if (m_Animator.GetCurrentAnimatorStateInfo(0).IsName("Jump"))
        
    }

    void OnGUI()
    
}
```
