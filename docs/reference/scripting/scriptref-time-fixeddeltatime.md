---
title: "Scripting API: Time.fixedDeltaTime"
page_title: "Unity - Scripting API: Time.fixedDeltaTime"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-fixedDeltaTime.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-fixedDeltaTime.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Time](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time.html).fixedDeltaTime

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

<span style="color:red;"> </span>public static float <span class="sig-kw">fixedDeltaTime</span>;

### Description

The interval in seconds of in-game time at which physics and other fixed frame rate updates (like MonoBehaviour's [MonoBehaviour.FixedUpdate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.FixedUpdate.html)) are performed.

The `fixedDeltaTime` interval is always relative to the in-game time which [Time.timeScale](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-timeScale.html) affects. A `fixedDeltaTime` of 1 second in a game with a [Time.timeScale](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-timeScale.html) of 0.5 means fixed updates occur every 2 seconds of real time.  
  
**Note**: To support high-precision simulation and prevent time drift in long-running games, Unity uses a more complex internal representation for time steps. When you set `Time.fixedDeltaTime`, the value is quantized to align with the internal high-resolution grid. When this value is cast back to a float for the `fixedDeltaTime` getter, it can differ by a single bit (one unit of least precision) from the original value due to this internal conversion.  
  
For more information on how this property relates to the other time properties, refer to [Time and Frame Rate Management](https://docs.unity3d.com/6000.3/Documentation/Manual/managing-time-and-frame-rate.html) in the Unity manual.
