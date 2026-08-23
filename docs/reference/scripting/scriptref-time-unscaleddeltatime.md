---
title: "Scripting API: Time.unscaledDeltaTime"
page_title: "Unity - Scripting API: Time.unscaledDeltaTime"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-unscaledDeltaTime.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-unscaledDeltaTime.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Time](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time.html).unscaledDeltaTime

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

<span style="color:red;"> </span>public static float <span class="sig-kw">unscaledDeltaTime</span>;

### Description

The timeScale-independent interval in seconds from the last frame to the current one (Read Only).

When called from inside MonoBehaviour's [MonoBehaviour.FixedUpdate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.FixedUpdate.html), it returns the unscaled fixed framerate delta time.  
  
Unlike [Time.deltaTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-deltaTime.html) this value is not affected by [Time.timeScale](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-timeScale.html).  
  
See [Time and Frame Rate Management](https://docs.unity3d.com/6000.3/Documentation/Manual/managing-time-and-frame-rate.html) in the User Manual for more information about how this property relates to the other Time properties.  
  
**Note**: On Android platforms, Time.unscaledDeltaTime may return very small values on the first frame after the application resumes from a paused or unfocused state. This can occur when very little real time has elapsed between frames. This behavior is expected and transient. Scripts should account for this when relying on Time.unscaledDeltaTime.
