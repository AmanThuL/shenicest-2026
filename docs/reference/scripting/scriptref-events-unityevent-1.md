---
title: "Scripting API: Events.UnityEvent<T>"
page_title: "Unity - Scripting API: UnityEvent<T0>"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Events.UnityEvent_1.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Events.UnityEvent_1.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# UnityEvent\<T0>

class in UnityEngine.Events

/

Inherits from:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Events.UnityEventBase.html" class="cl">Events.UnityEventBase</a>

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

One argument version of [UnityEvent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Events.UnityEvent.html).

Generics are supported, specify a type parameter on initialization as shown in the example. Refer to [Configure callbacks in the Inspector](https://docs.unity3d.com/6000.3/Documentation/Manual/UnityEvents.html) for details on configuring callbacks in the Inspector window.

``` codeExampleCS
using UnityEngine;
using UnityEngine.Events;

public class ExampleClass : MonoBehaviour

    void Update()
    
    }

    void DoSomething(int i)
    
}
```

Note: UnityEvent can also be awaited in any async method.

### Inherited Members

### Public Methods

| Method                                                                                                                                            | Description                                                                  |
|---------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------|
| [GetPersistentEventCount](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Events.UnityEventBase.GetPersistentEventCount.html)       | Get the number of registered persistent listeners.                           |
| [GetPersistentListenerState](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Events.UnityEventBase.GetPersistentListenerState.html) | Returns the execution state of a persistent listener.                        |
| [GetPersistentMethodName](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Events.UnityEventBase.GetPersistentMethodName.html)       | Get the target method name of the listener at index index.                   |
| [GetPersistentTarget](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Events.UnityEventBase.GetPersistentTarget.html)               | Get the target component of the listener at index index.                     |
| [RemoveAllListeners](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Events.UnityEventBase.RemoveAllListeners.html)                 | Remove all non-persistent (ie created from script) listeners from the event. |
| [SetPersistentListenerState](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Events.UnityEventBase.SetPersistentListenerState.html) | Modify the execution state of a persistent listener.                         |

### Static Methods

| Method                                                                                                                            | Description                                                                                 |
|-----------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------|
| [GetValidMethodInfo](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Events.UnityEventBase.GetValidMethodInfo.html) | Given an object, function name, and a list of argument types; find the method that matches. |
