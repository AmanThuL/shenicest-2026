---
title: "Scripting API: AwaitableCompletionSource"
page_title: "Unity - Scripting API: AwaitableCompletionSource"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AwaitableCompletionSource.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AwaitableCompletionSource.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# AwaitableCompletionSource

class in UnityEngine

/

Implemented in:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UnityEngine.CoreModule.html" class="cl">UnityEngine.CoreModule</a>

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

### Description

Objects allowing to control completion of an Awaitable object from user code.

### Properties

| Property                                                                                                            | Description                                            |
|---------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------|
| [Awaitable](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AwaitableCompletionSource.Awaitable.html) | Get the awaitable controlled by the completion source. |

### Public Methods

| Method                                                                                                                          | Description                                                                                   |
|---------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------|
| [Reset](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AwaitableCompletionSource.Reset.html)                     | Reset the completion source (this will set the Awaitable property to a new Awaitable object). |
| [SetCanceled](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AwaitableCompletionSource.SetCanceled.html)         | Raise cancellation.                                                                           |
| [SetException](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AwaitableCompletionSource.SetException.html)       | Raise completion with an exception.                                                           |
| [SetResult](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AwaitableCompletionSource.SetResult.html)             | Raise completion.                                                                             |
| [TrySetCanceled](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AwaitableCompletionSource.TrySetCanceled.html)   | Raise cancellation (returns false if the awaitable was already completed or canceled).        |
| [TrySetException](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AwaitableCompletionSource.TrySetException.html) | Raise completion with an exception.                                                           |
| [TrySetResult](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AwaitableCompletionSource.TrySetResult.html)       | Raise the awaitable completion.                                                               |
