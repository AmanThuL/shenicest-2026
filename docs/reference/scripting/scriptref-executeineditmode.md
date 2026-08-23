---
title: "Scripting API: ExecuteInEditMode"
page_title: "Unity - Scripting API: ExecuteInEditMode"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ExecuteInEditMode.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ExecuteInEditMode.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# ExecuteInEditMode

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

Causes a MonoBehaviour-derived class to execute in Edit mode in addition to at runtime.

By default, MonoBehaviour [event functions](https://docs.unity3d.com/6000.3/Documentation/Manual/event-functions.html) only execute at runtime. Applying `ExecuteInEditMode` to a MonoBehaviour-derived class causes the event functions for any instance of that class to also execute in Edit mode.  
  
This attribute targets classes, but it only has an effect on classes that inherit from [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html).  
  
This attribute is not recommended because it is not compatible with editing in prefab editing mode. The recommended alternative is [ExecuteAlways](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ExecuteAlways.html).  
  
If you're editing a prefab containing a MonoBehaviour with the `ExecuteInEditMode` attribute in prefab editing mode and you then enter Play mode, Unity exits prefab editing mode to prevent accidental modification to the prefab caused by logic intended for Play mode only.  
  
To keep prefab editing mode open while in Play mode, use the [ExecuteAlways](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ExecuteAlways.html) attribute instead. If you do this, you must take care to ensure your runtime MonoBehaviour code does not modify the prefab you're editing in ways intended to occur only during gameplay. For more details, refer to [ExecuteAlways](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ExecuteAlways.html).  
  
In Edit mode, event functions are not called as frequently or under all the same conditions as they are at runtime. Event functions are called under the following conditions:

-   [Awake](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Awake.html) is called only when a new instance of the script component is created. This happens when Unity loads a scene that contains the component or when you create a new component in the Editor, for example through the **Component** menu.
-   [Update](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Update.html) is called on every redraw of the **Scene** view or **Game** view. This happens when something in the scene changes, for example, the position of a GameObject or when you navigate the scene with the mouse or keys.
-   [OnGUI](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnGUI.html) is called when the **Game** view receives a non-Editor-only [Event](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Event.html) that it doesn't use and doesn't forward to the Editor's keyboard shortcut system. For example, `OnGUI` is called on receiving an instance of [EventType.ScrollWheel](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EventType.ScrollWheel.html) that's not forwarded to [EventType.KeyDown](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EventType.KeyDown.html) or [EventType.KeyUp](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EventType.KeyUp.html). Events forwarded to the **Game** view are added to a queue and aren't guaranteed to be processed immediately.
-   [OnRenderObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnRenderObject.html) and other rendering callback functions are called on every redraw of the **Scene** view or **Game** view.

See Also: [ExecuteAlways](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ExecuteAlways.html), [Application.IsPlaying](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application.IsPlaying.html), [runInEditMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour-runInEditMode.html), [EditorApplication.QueuePlayerLoopUpdate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorApplication.QueuePlayerLoopUpdate.html).

``` codeExampleCS
// The PrintAwake script is placed on a GameObject. Usually, the Awake function is
// called when the GameObject with this script is initialized at runtime. Due to the ExecuteInEditMode
// attribute, the Editor also calls Awake when the script component is created via an Editor menu or when a scene that contains it is loaded.
// The Update function is called when the Scene view needs to render, which happens when something in the scene changes or you navigate the scene with mouse or keyboard inputs.

using UnityEngine;

[ExecuteInEditMode]
public class PrintAwake : MonoBehaviour

    void Update()
    
}
```
