---
title: "Scripting API: ExecuteAlways"
page_title: "Unity - Scripting API: ExecuteAlways"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ExecuteAlways.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ExecuteAlways.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# ExecuteAlways

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

Causes a MonoBehaviour-derived class to execute in Edit mode and prefab editing mode in addition to at runtime.

By default, MonoBehaviour [event functions](https://docs.unity3d.com/6000.3/Documentation/Manual/event-functions.html) only execute at runtime. Applying `ExecuteAlways` to a MonoBehaviour-derived class causes the event functions for any instance of that class to also execute in Edit mode and Prefab mode.  
  
This attribute targets classes, but it only has an effect on classes that inherit from [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html).  
  
Use the `[ExecuteAlways]` attribute when you want your script to perform actions or respond to events at authoring time, which are not necessarily related to what happens at application runtime in the Editor's Play mode or a standalone Player. Sometimes the runtime functionality of such a script is identical to its Edit mode functionality, while other times they differ greatly.  
  
It's important to ensure that a MonoBehaviour script using this attribute does not have runtime code which could incorrectly execute and modify the parent GameObject while it's being edited in Edit mode or prefab editing mode. To avoid this, you can put your runtime code inside a conditional block that only runs if [Application.IsPlaying](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application.IsPlaying.html) is `true` for the script's own parent GameObject, as shown in the following code example.  
  
If your script makes use of static variables or Singleton patterns, you should ensure that instances of the script that belong to the playing world and instances that don't will not accidentally affect each other through those variables or Singletons.  
  
In Edit mode, event functions are not called as frequently or under all the same conditions as they are at runtime. Event functions are called under the following conditions:

-   [Awake](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Awake.html) is called only when a new instance of the script component is created. This happens when Unity loads a scene that contains the component or when you create a new component in the Editor, for example through the **Component** menu.
-   [Update](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Update.html) is called on every redraw of the **Scene** view or **Game** view. This hapens when something in the scene changes, for example, the position of a GameObject or when you navigate the scene with the mouse or keys.
-   [OnGUI](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnGUI.html) is called when the **Game** view receives a non-Editor-only [Event](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Event.html) that it doesn't use and doesn't forward to the Editor's keyboard shortcut system. For example, `OnGUI` is called on receiving an instance of [EventType.ScrollWheel](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EventType.ScrollWheel.html) that's not forwarded to [EventType.KeyDown](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EventType.KeyDown.html) or [EventType.KeyUp](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EventType.KeyUp.html). Events forwarded to the **Game** view are added to a queue and aren't guaranteed to be processed immediately.
-   [OnRenderObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnRenderObject.html) and the other rendering callback functions are called on every redraw of the **Scene** view or **Game** view.

See Also: [Application.IsPlaying](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application.IsPlaying.html), [runInEditMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour-runInEditMode.html), [EditorApplication.QueuePlayerLoopUpdate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorApplication.QueuePlayerLoopUpdate.html).

``` codeExampleCS
using UnityEngine;

[ExecuteAlways]
public class ExampleClass : MonoBehaviour

        else
        
    }
}
```
