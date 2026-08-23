---
title: "Scripting API: Debug.Assert"
page_title: "Unity - Scripting API: Debug.Assert"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.Assert.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.Assert.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Debug](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.html).Assert

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

public static void <span class="sig-kw">Assert</span>(bool <span class="sig-kw">condition</span>);

<span style="color:red;"> </span>

## Declaration

public static void <span class="sig-kw">Assert</span>(bool <span class="sig-kw">condition</span>, [Object](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html) <span class="sig-kw">context</span>);

<span style="color:red;"> </span>

## Declaration

public static void <span class="sig-kw">Assert</span>(bool <span class="sig-kw">condition</span>, object <span class="sig-kw">message</span>);

<span style="color:red;"> </span>

## Declaration

public static void <span class="sig-kw">Assert</span>(bool <span class="sig-kw">condition</span>, object <span class="sig-kw">message</span>, [Object](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html) <span class="sig-kw">context</span>);

### Parameters

| Parameter | Description                                                            |
|-----------|------------------------------------------------------------------------|
| condition | Condition you expect to be true.                                       |
| context   | Object to which the message applies.                                   |
| message   | String or object to be converted to string representation for display. |

### Description

Assert a condition and logs an error message to the Unity console on failure.

Message of a type of [LogType.Assert](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/LogType.Assert.html) is logged.  
  
Note that these methods work only if UNITY_ASSERTIONS symbol is defined. This means that if you are building assemblies externally, you need to define this symbol otherwise the call becomes a no-op. (For more details see [System.Diagnostics.ConditionalAttribute](https://msdn.microsoft.com/en-us/library/system.diagnostics.conditionalattribute(v=vs.110).aspx) on the MSDN website.
