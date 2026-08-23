---
title: "Scripting API: Awaitable<T>"
page_title: "Unity - Scripting API: Awaitable<T0>"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable_1.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable_1.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Awaitable\<T0>

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

### Public Methods

| Method                                                                                          | Description                                                                                                        |
|-------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------|
| [Cancel](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable_1.Cancel.html) | Cancel the awaitable. If the awaitable is being awaited, the awaiter will get a System.OperationCanceledException. |
