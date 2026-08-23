---
title: "Scripting API: Debug.LogWarning"
page_title: "Unity - Scripting API: Debug.LogWarning"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.LogWarning.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.LogWarning.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Debug](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.html).LogWarning

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-Debug.html" class="switch-link gray-btn sbtn left show" title="Go to Debug Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

## Declaration

public static void <span class="sig-kw">LogWarning</span>(object <span class="sig-kw">message</span>);

<span style="color:red;"> </span>

## Declaration

public static void <span class="sig-kw">LogWarning</span>(object <span class="sig-kw">message</span>, [Object](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html) <span class="sig-kw">context</span>);

### Parameters

| Parameter | Description                                                            |
|-----------|------------------------------------------------------------------------|
| message   | String or object to be converted to string representation for display. |
| context   | Object to which the message applies.                                   |

### Description

A variant of Debug.Log that logs a warning message to the console.

When you select the message in the Editor's console, the `context` object to which the message applies is highlighted in the Hierarchy window. You can click the hyperlinks in the stack trace to go directly to the relevant lines of code in your code editor.  
  
When the message is a string, rich text markup can be used to add emphasis. See the manual page about [rich text](https://docs.unity3d.com/6000.3/Documentation/Manual/StyledText.html) for details of the different markup tags available.  
  
Additional resources: [Debug.unityLogger](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug-unityLogger.html), [ILogger](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ILogger.html), [Logger.LogWarning](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Logger.LogWarning.html).

``` codeExampleCS
using UnityEngine;
using System.Collections;

public class MyGameClass : MonoBehaviour

}
```
