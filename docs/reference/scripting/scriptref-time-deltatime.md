---
title: "Scripting API: Time.deltaTime"
page_title: "Unity - Scripting API: Time.deltaTime"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-deltaTime.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-deltaTime.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Time](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time.html).deltaTime

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

<span style="color:red;"> </span>public static float <span class="sig-kw">deltaTime</span>;

### Description

The interval in seconds from the last frame to the current one (Read Only).

When called from inside [MonoBehaviour.FixedUpdate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.FixedUpdate.html) or anywhere in the Physics update loop, including coroutines that yield [WaitForFixedUpdate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/WaitForFixedUpdate.html), `deltaTime` returns [Time.fixedDeltaTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-fixedDeltaTime.html). The maximum value for `deltaTime` is defined by [Time.maximumDeltaTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-maximumDeltaTime.html).  
  
The value `deltaTime` is scaled according to [Time.timeScale](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-timeScale.html). If the game is paused by setting [Time.timeScale](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-timeScale.html) to `0`, then `deltaTime` also becomes `0`. The first frames after changing [Time.timeScale](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-timeScale.html) can produce unexpected `deltaTime` values. Use [Time.unscaledDeltaTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-unscaledDeltaTime.html) instead if you need wall-clock time during pause.  
  
The value of `deltaTime` can be unreliable in callbacks that might be invoked multiple times per frame, such as [MonoBehaviour.OnGUI](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnGUI.html) or UI layout or repaint events.  
  
The first frame `Update` can produce a very small or zero `deltaTime` on some platforms, as can the first frame after a domain and scene reload.  
  
Depending on the platform and the [Application.runInBackground](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-runInBackground.html) setting, when the application loses focus or is in the background, `Update` might be called infrequently or with long gaps, producing large `deltaTime` values.  
  
The following example rotates a GameObject around its z axis at a constant speed.  
  
For more information on how this property relates to the other time properties, refer to [Time and Frame Rate Management](https://docs.unity3d.com/6000.3/Documentation/Manual/managing-time-and-frame-rate.html) in the Unity manual.

``` codeExampleCS
using UnityEngine;
// Rotate around the z axis at a constant speed
public class ConstantRotation : MonoBehaviour

}
```

The following example implements a timer. The timer adds deltaTime each frame. The example displays the timer value and resets it when it reaches 2 seconds. [Time.timeScale](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-timeScale.html) controls the speed at which time passes and how fast the timer resets.

``` codeExampleCS
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

// Time.deltaTime example.
//
// Wait two seconds and display waited time.
// This is typically just beyond 2 seconds.
// Allow the speed of the time to be increased or decreased.
// It can range between 0.5 and 2.0. These changes only
// happen when the timer restarts.

public class ScriptExample : MonoBehaviour

    void Update()
    
    }

    void OnGUI()
    
}
```
