---
title: "Scripting API: Awaitable.BackgroundThreadAsync"
page_title: "Unity - Scripting API: Awaitable.BackgroundThreadAsync"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.BackgroundThreadAsync.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.BackgroundThreadAsync.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Awaitable](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.html).BackgroundThreadAsync

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

<span style="color:red;"> </span>

## Declaration

public static BackgroundThreadAwaitable <span class="sig-kw">BackgroundThreadAsync</span>();

### Returns

**BackgroundThreadAwaitable** Awaitable object that completes when switching to a background thread.

### Description

Resumes execution on a ThreadPool background thread. Completes immediately when called from a background thread.

``` codeExampleCS
public async Awaitable Start()

```
