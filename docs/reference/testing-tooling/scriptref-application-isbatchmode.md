---
title: "Application.isBatchMode (Scripting API)"
page_title: "Unity - Scripting API: Application.isBatchMode"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-isBatchMode.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-isBatchMode.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Application](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application.html).isBatchMode

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

<span style="color:red;"> </span>public static bool <span class="sig-kw">isBatchMode</span>;

### Description

Returns true when Unity is launched with the **-batchmode** flag from the command line (Read Only).

In batch mode, Unity runs from the command line without user interaction, typically used for automation (builds, tests, CI). For details, refer to [EditorCommandLineArguments](https://docs.unity3d.com/6000.3/Documentation/Manual/EditorCommandLineArguments.html).

``` codeExampleCS
using UnityEngine;

public class Example : MonoBehaviour

    }
}
```
