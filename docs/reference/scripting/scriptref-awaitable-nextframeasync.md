---
title: "Scripting API: Awaitable.NextFrameAsync"
page_title: "Unity - Scripting API: Awaitable.NextFrameAsync"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.NextFrameAsync.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.NextFrameAsync.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Awaitable](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.html).NextFrameAsync

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

public static [Awaitable](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.html) <span class="sig-kw">NextFrameAsync</span>(CancellationToken <span class="sig-kw">cancellationToken</span>);

### Parameters

| Parameter         | Description                  |
|-------------------|------------------------------|
| cancellationToken | Optional cancellation token. |

### Description

Resumes execution on the next frame.

**Note:** This method can only be called from the main thread and always completes on main thread.

``` codeExampleCS
async Awaitable SampleSchedulingJobsForNextFrame()

JobHandle ScheduleSomethingWithJobSystem()

```
