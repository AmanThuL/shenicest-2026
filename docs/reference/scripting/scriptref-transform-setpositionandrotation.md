---
title: "Scripting API: Transform.SetPositionAndRotation"
page_title: "Unity - Scripting API: Transform.SetPositionAndRotation"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.SetPositionAndRotation.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.SetPositionAndRotation.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html).SetPositionAndRotation

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-Transform.html" class="switch-link gray-btn sbtn left show" title="Go to Transform Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

## Declaration

public void <span class="sig-kw">SetPositionAndRotation</span>([Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">position</span>, [Quaternion](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.html) <span class="sig-kw">rotation</span>);

### Parameters

| Parameter | Description                                         |
|-----------|-----------------------------------------------------|
| position  | The world space position to apply to the transform. |
| rotation  | The world space rotation to apply to the transform. |

### Description

Sets the world space position and rotation of the Transform component.

When setting both the position and rotation of a transform, calling this method is more efficient than assigning to [Transform.position](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform-position.html) and [Transform.rotation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform-rotation.html) individually.
