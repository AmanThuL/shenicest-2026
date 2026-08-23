---
title: "Animation Parameters"
page_title: "Unity - Manual: Animation Parameters"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/AnimationParameters.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/AnimationParameters.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Animation Parameters

Animation Parameters are variables that are defined within an Animator Controller that can be accessed and assigned values from scripts. This is how a script can control or affect the flow of the state machine.

![Animation Parameters in the Animator window.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/AnimationEditorParametersSection.png)

For example, the value of a parameter can be updated by an [animation curve](https://docs.unity3d.com/6000.3/Documentation/Manual/animeditor-AnimationCurves.html) and then accessed from a script so that, say, the pitch of a sound effect can be varied as if it were a piece of animation. Likewise, a script can set parameter values to be picked up by Mecanim. For example, a script can set a parameter to control a [Blend Tree](https://docs.unity3d.com/6000.3/Documentation/Manual/class-BlendTree.html).

Default parameter values can be set up using the Parameters section of the Animator window, selectable in the top right corner of the Animator window. They can be of four basic types:

-   *Integer* - a whole number
-   *Float* - a number with a fractional part
-   *Bool* - true or false value (represented by a checkbox)
-   *Trigger* - a boolean parameter that is reset by the controller when consumed by a transition (represented by a circle button)

Parameters can be assigned values from a script using functions in the Animator class: [SetFloat](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.SetFloat.html), [SetInteger](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.SetInteger.html), [SetBool](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.SetBool.html), [SetTrigger](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.SetTrigger.html), and [ResetTrigger](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.ResetTrigger.html).

Here’s an example of a script that modifies parameters based on user input and collision detection:

``` lang-cs
using UnityEngine;
using System.Collections;

public class SimplePlayer : MonoBehaviour 
    // Update is called once per frame
    void Update () 
    void OnCollisionEnter(Collision col) 
    }
}
```
