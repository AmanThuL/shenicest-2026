---
title: "Scripting API: Awaitable.FromAsyncOperation"
page_title: "Unity - Scripting API: Awaitable.FromAsyncOperation"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.FromAsyncOperation.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.FromAsyncOperation.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Awaitable](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.html).FromAsyncOperation

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

public static [Awaitable](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.html) <span class="sig-kw">FromAsyncOperation</span>([AsyncOperation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AsyncOperation.html) <span class="sig-kw">op</span>, CancellationToken <span class="sig-kw">cancellationToken</span>);

### Parameters

| Parameter         | Description                  |
|-------------------|------------------------------|
| op                | Async operation object.      |
| cancellationToken | Optional cancellation token. |

### Description

Creates an Awaitable from an existing [AsyncOperation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AsyncOperation.html) object.
