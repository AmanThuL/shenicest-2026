---
title: "Scripting API: Time.time"
page_title: "Unity - Scripting API: Time.time"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-time.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-time.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Time](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time.html).time

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

<span style="color:red;"> </span>public static float <span class="sig-kw">time</span>;

### Description

The time at the beginning of the current frame in seconds since the start of the application (Read Only).

This is the time in seconds since the start of the application, which [Time.timeScale](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-timeScale.html) scales and [Time.maximumDeltaTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-maximumDeltaTime.html) adjusts. When called from inside [MonoBehaviour.FixedUpdate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.FixedUpdate.html), it returns [Time.fixedTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-fixedTime.html).  
  
This value is undefined during Awake messages and starts after all of these messages are finished. This value does not update if the Editor is paused. See [Time.realtimeSinceStartup](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-realtimeSinceStartup.html) for a time value that is unaffected by pausing.  
  
See [Time and Frame Rate Management](https://docs.unity3d.com/6000.3/Documentation/Manual/managing-time-and-frame-rate.html) in the User Manual for more information about how this property relates to the other Time properties.

``` codeExampleCS
//If the Fire1 button is pressed, a projectile
//will be Instantiated every 0.5 seconds.

using UnityEngine;
using System.Collections;

public class Example : MonoBehaviour

    }
}
```
