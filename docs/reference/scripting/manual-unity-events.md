---
title: "Inspector-configurable custom events (UnityEvent) (Unity 6.3 Manual)"
page_title: "Unity - Manual: Inspector-configurable custom events"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/unity-events.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/unity-events.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Inspector-configurable custom events

Unity provides the [UnityEvent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Events.UnityEvent.html) API as a Unity-specific alternative to standard C# [events and delegates](https://learn.microsoft.com/en-us/dotnet/standard/events/). The main advantage of Unity events over standard C# events is that Unity events are serializable, meaning you can configure them in the [Inspector window](https://docs.unity3d.com/6000.3/Documentation/Manual/UsingTheInspector.html).

A `UnityEvent` can be added to any `MonoBehaviour` and is executed at runtime like a standard C# delegate. When a `UnityEvent` is declared in a `MonoBehaviour` it appears in the **Inspector** window where you can define callbacks that persist between Edit time and runtime.

Unity events have similar limitations to standard C# delegates:

-   They hold references to the target object, which stops the target object being garbage collected.
-   If you have a managed (C#) `UnityEngine.Object` as the target and the unmanaged (C++) counterpart object has been destroyed, the callback will not be invoked. For more information, refer to [Object](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Object.html).

## Configure Unity events

### Prerequisites

-   Create a MonoBehaviour script which includes `using UnityEngine.Events`
-   Declare at least one field of type `UnityEvent`

### Configure callbacks in the Inspector window:

1.  Select the GameObject with the script component that contains your declared `UnityEvent` field(s).

2.  Click the + button under the name of an event to add a slot for a callback.

3.  Select the [UnityEngine.Object](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Object.html) you want to receive the callback. You can use the object selector or drag and drop an object into the field.

4.  Select the function you want to be called when the event happens. The dropdown selector is populated with filtered lists of [appropriate methods](https://docs.unity3d.com/6000.3/Documentation/Manual/unity-events.html#static-dynamic-calls) available on the GameObject and its components.

5.  Repeat steps 1–4 as required to add additional callbacks for the same event.

![Configuring callbacks for events called Trigger Entered and Trigger Exited in the Inspector window](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/unityevents-inspector.png)

<span id="static-dynamic-calls"></span>

### Static and dynamic calls

When configuring a `UnityEvent` in the **Inspector** window there are two types of function calls that are supported:

-   **Static** calls are entirely preconfigured at authoring time, with their target and parameter values defined in the Inspector window. When the callback is invoked, the target function is invoked with the parameter values defined in the Inspector. This is appropriate for values that won’t vary at runtime, for example when you want to decrement a health value by a set amount every time a particular collision occurs. Statically bound functions appear under **Static Parameters** in the function selection list.
-   **Dynamic** calls are invoked programatically from your code, with parameters matching the type of `UnityEvent` being invoked. This is appropriate for values that vary at runtime, for example a `float` representing a variable amount of damage that a character sustains on each attack. The UI filters the callbacks and only shows the dynamic functions with signatures that are valid for the type of `UnityEvent`. For example, if you have a `UnityEvent<string>`, the function selector lists any functions that accept a `string` parameter under the **Dynamic string** header.

![Choosing between static or dynamic functions whose signatures match the event type in the Inspector window](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/unityevents-dynamic-static.png)

## Generic support in UnityEvent

By default a `UnityEvent` in a `Monobehaviour` binds dynamically to a `void` function. But you can create a `UnityEvent` with up to four generic type parameters as shown in the following example:

``` lang-cs
using UnityEngine;
using UnityEngine.Events;

public class GenericTest : MonoBehaviour

        myEvent.AddListener(Ping);
    }

    // Update is called once per frame
    void Update()
    
    }

    void Ping(int i, int j, bool print, string text)
    
    }
}
```

## Additional resources

-   [Set up doors, triggers, etc. with drag-and-drop events](https://youtu.be/tmmvhxQcbJk)
-   [UnityEvent API reference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Events.UnityEvent.html)
