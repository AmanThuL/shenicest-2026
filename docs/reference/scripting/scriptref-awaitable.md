---
title: "Scripting API: Awaitable"
page_title: "Unity - Scripting API: Awaitable"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Awaitable

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

Custom Unity type that can be awaited and used as an async return type in the C# asynchronous programming model.

`Awaitable` is usually a preferable alternative to .NET `Task` for asynchronous code in Unity. It's important, however, to know the differences between the two. Most notably, instances of the \`Awaitable\` class are pooled and therefore not safe to `await` multiple times in the same method.  
  
For more information, refer to [Asynchronous programming with the Awaitable class](https://docs.unity3d.com/6000.3/Documentation/Manual/async-await-support.html) in the Manual.

``` codeExampleCS
private async Awaitable DoSomethingAsync()

```

### Properties

| Property                                                                                                | Description                                       |
|---------------------------------------------------------------------------------------------------------|---------------------------------------------------|
| [IsCompleted](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.IsCompleted.html) | Indicates if the awaitable has run to completion. |

### Public Methods

| Method                                                                                        | Description                                                                                                         |
|-----------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------|
| [Cancel](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.Cancel.html) | Cancels the awaitable. If the awaitable is being awaited, the awaiter receives a System.OperationCanceledException. |

### Static Methods

| Method                                                                                                                      | Description                                                                                                      |
|-----------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------|
| [BackgroundThreadAsync](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.BackgroundThreadAsync.html) | Resumes execution on a ThreadPool background thread. Completes immediately when called from a background thread. |
| [EndOfFrameAsync](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.EndOfFrameAsync.html)             | Resumes execution after all Unity subsystems have run for the current frame.                                     |
| [FixedUpdateAsync](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.FixedUpdateAsync.html)           | Resumes execution on the next fixed update frame.                                                                |
| [FromAsyncOperation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.FromAsyncOperation.html)       | Creates an Awaitable from an existing AsyncOperation object.                                                     |
| [MainThreadAsync](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.MainThreadAsync.html)             | Resumes execution on the Unity main thread. Completes immediately when called from the main thread.              |
| [NextFrameAsync](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.NextFrameAsync.html)               | Resumes execution on the next frame.                                                                             |
| [WaitForSecondsAsync](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.WaitForSecondsAsync.html)     | Resumes execution after the specified number of seconds.                                                         |
