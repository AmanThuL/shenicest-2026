---
title: "Scripting API: Awaitable.WaitForSecondsAsync"
page_title: "Unity - Scripting API: Awaitable.WaitForSecondsAsync"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.WaitForSecondsAsync.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.WaitForSecondsAsync.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Awaitable](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.html).WaitForSecondsAsync

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

public static [Awaitable](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.html) <span class="sig-kw">WaitForSecondsAsync</span>(float <span class="sig-kw">seconds</span>, CancellationToken <span class="sig-kw">cancellationToken</span>);

### Parameters

| Parameter         | Description                  |
|-------------------|------------------------------|
| seconds           | Seconds to wait for.         |
| cancellationToken | Optional cancellation token. |

### Description

Resumes execution after the specified number of seconds.

This method can only be called from the main thread and always completes on main thread.  
  
**Note:**: `Awaitable.WaitForSecondsAsync` throws `OperationCanceledException` if the provided `CancellationToken` is canceled during the wait. This aborts the wait rather than interrupting it and continuing. If you use cancellation to indicate that a task has completed early and expect execution to proceed to subsequent statements, you must handle the exception explicitly or avoid passing a token here. Otherwise, code that awaits a delay with a token and then runs follow-up logic might skip that logic when the token is triggered.

``` codeExampleCS
async Awaitable Foo()
```
