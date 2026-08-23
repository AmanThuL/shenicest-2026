---
title: "Scripting API: Cursor.visible"
page_title: "Unity - Scripting API: Cursor.visible"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Cursor-visible.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Cursor-visible.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Cursor](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Cursor.html).visible

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

<span style="color:red;"> </span>public static bool <span class="sig-kw">visible</span>;

### Description

Determines whether the hardware pointer is visible or not.

Set this to true to reveal the cursor. Set it to false to hide the cursor. Note that in [CursorLockMode.Locked](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/CursorLockMode.Locked.html) mode, the cursor is invisible regardless of the value of this property.

``` codeExampleCS
using UnityEngine;
using System.Collections;

public class CursorScript : MonoBehaviour

}
```
