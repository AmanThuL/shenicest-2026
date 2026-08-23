---
title: "Scripting API: Application.logMessageReceived"
page_title: "Unity - Scripting API: Application.logMessageReceived"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-logMessageReceived.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-logMessageReceived.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Application](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application.html).logMessageReceived

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

Event that is fired if a log message is received.

This event only ever triggers on the main thread. Use it if your handler requires accessing parts of the Unity API that are restricted to the main thread or if for other reasons your handler isn't thread-safe.

``` codeExampleCS
using UnityEngine;
using System.Collections;

public class ExampleClass : MonoBehaviour

    void OnDisable()
    
    void HandleLog(string logString, string stackTrace, LogType type)
    
}
```

Additional resources: [Application.logMessageReceived](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-logMessageReceived.html), [LogType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/LogType.html), [Application.logMessageReceivedThreaded](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-logMessageReceivedThreaded.html).
