---
title: "UnityEvent (Unity 6.3 Scripting API)"
page_title: "Unity - Scripting API: UnityEvent"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Events.UnityEvent.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Events.UnityEvent.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# UnityEvent

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

A zero-argument event callback that persists with the Scene and allows the registration of runtime and persistent listeners.

You can use this class to add runtime listeners or define persistent listeners in the Unity Editor. You can also use this class to manage callbacks for game events or UI interactions. This is particularly useful for game components to communicate without tight coupling. UnityEvent can also be awaited in any async method.

``` codeExampleCS
using UnityEngine;
using UnityEngine.Events;

public class ExampleClass : MonoBehaviour

    void Update()
    
    }

    void OnEventTriggered()
    
}
```

### Constructors

| Constructor                                                                                             | Description                                         |
|---------------------------------------------------------------------------------------------------------|-----------------------------------------------------|
| [UnityEvent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Events.UnityEvent-ctor.html) | Initializes a new instance of the UnityEvent class. |

### Public Methods

| Method                                                                                                                | Description                                                  |
|-----------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------|
| [AddListener](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Events.UnityEvent.AddListener.html)       | Adds a runtime listener to the UnityEvent.                   |
| [Invoke](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Events.UnityEvent.Invoke.html)                 | Invoke all registered callbacks both runtime and persistent. |
| [RemoveListener](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Events.UnityEvent.RemoveListener.html) | Removes a runtime listener from the UnityEvent.              |

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
