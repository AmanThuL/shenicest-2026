---
title: "Event functions (Unity 6.3 Manual)"
page_title: "Unity - Manual: Event functions"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/event-functions.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/event-functions.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Event functions

Event functions are a set of predefined callbacks that all [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/Manual/class-MonoBehaviour.html) script components can potentially receive. The callbacks are triggered by various Unity Editor and Engine events, including:

-   [Regular frame and physics updates](https://docs.unity3d.com/6000.3/Documentation/Manual/event-functions.html#regular-updates)
-   Scene and object [lifecycle events](https://docs.unity3d.com/6000.3/Documentation/Manual/event-functions.html#initialization-events), such as initialization and destruction of objects in a scene.
-   [UI events](https://docs.unity3d.com/6000.3/Documentation/Manual/event-functions.html#gui-events)
-   [Input events](https://docs.unity3d.com/6000.3/Documentation/Manual/event-functions.html#input-events)
-   [Physics events](https://docs.unity3d.com/6000.3/Documentation/Manual/event-functions.html#physics-events)

Implement the appropriate method signature in your `MonoBehaviour`-derived class to allow your game objects to react to the source events.

For a full list of the available callbacks, refer to the [`MonoBehaviour`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html) API reference where they are listed under **Messages**. The rest of this section gives an overview of some of the key groups of event functions.

<span id="regular-updates"></span>

## Regular update events

A playing game continuously renders a series of frames. A key concept in games programming is making changes to position, state, and behavior of objects just before each frame is rendered. The [`Update`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Update.html) function is the main place for this kind of code in Unity. `Update` is called before the frame is rendered and also before animations are calculated.

The physics system also updates in discrete time steps in a similar way to the frame rendering. A separate event function called [`FixedUpdate`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.FixedUpdate.html) is called just before each physics update. Since the physics updates and frame updates don’t occur with the same frequency, you can get more accurate results from physics code if you place it in the `FixedUpdate` function rather than `Update`.

It’s also sometimes useful to make additional changes at a point after the `Update` and `FixedUpdate` functions have been called for all objects in the scene, and after all animations have been calculated. Some examples of this scenario are:

-   When a camera should remain trained on a target object. The adjustment to the camera’s orientation must be made after the target object has moved.
-   When the script code should override the effect of an animation. For example, to make a character’s head look towards a target object in the scene.

The [`LateUpdate`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.LateUpdate.html) function can be used for these kinds of situations.

For an overview of how frame and physics updates fit into the overall event function update sequence, refer to [Event function execution order](https://docs.unity3d.com/6000.3/Documentation/Manual/execution-order.html).

<span id="initialization-events"></span>

## Initialization events

It’s often useful to be able to call initialization code in advance of any updates that occur during gameplay. The [`Start`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Start.html) function is called before the first frame or physics update on an object. The [`Awake`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Awake.html) function is called for each object in the scene at the time when the scene loads. Note that although the various objects’ `Start` and `Awake` functions are called in arbitrary order, all instances of `Awake` will have finished before the first `Start` is called. This means that code in a `Start` function can make use of other initializations previously carried out in the `Awake` phase.

For an overview of how initialization functions fit into the overall event function update sequence, refer to [Event function execution order](https://docs.unity3d.com/6000.3/Documentation/Manual/execution-order.html).

<span id="gui-events"></span>

## GUI events

For projects that use the legacy [IMGUI UI system](https://docs.unity3d.com/6000.3/Documentation/Manual/gui-Basics.html), the [`MonoBehavior.OnGUI`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnGUI.html) callback is called periodically to draw and manage UI elements.

**Note**: Adding an `OnGUI` callback, even if empty, to any object in a scene also adds IMGUI processing to the frame handling process, which creates extra overhead. Only use `OnGUI` if your project uses the [IMGUI UI system](https://docs.unity3d.com/6000.3/Documentation/Manual/gui-Basics.html), which is no longer recommended.

For more information, refer to [UI systems](https://docs.unity3d.com/6000.3/Documentation/Manual/UIToolkits.html).

<span id="input-events"></span>

## Input events

The `MonoBehaviour` class also has a set of event functions named with the prefix `OnMouse` (e.g., [`OnMouseOver`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnMouseOver.html), [`OnMouseDown`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnMouseDown.html)) for reacting to user actions with the mouse. These callbacks are only supported for projects using the legacy [Input Manager](https://docs.unity3d.com/6000.3/Documentation/Manual/class-InputManager.html), which is no longer recommended.

For more information, refer to [Input](https://docs.unity3d.com/6000.3/Documentation/Manual/Input.html).

<span id="physics-events"></span>

## Physics events

The physics system reports collisions against an object by calling event functions on that object’s script component.

The [`OnCollisionEnter`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnCollisionEnter.html), [`OnCollisionStay`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnCollisionStay.html) and [`OnCollisionExit`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnCollisionExit.html) functions are called as contact is made, held and broken. The corresponding [`OnTriggerEnter`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnTriggerEnter.html), [`OnTriggerStay`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnTriggerStay.html) and [`OnTriggerExit`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnTriggerExit.html) functions are called when the object’s collider is configured as a trigger collider.

For more information on physics event functions, refer to [Collider interactions](https://docs.unity3d.com/6000.3/Documentation/Manual/collider-interactions.html).

## Additional resources

-   [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/Manual/class-MonoBehaviour.html)
-   [Event function execution order](https://docs.unity3d.com/6000.3/Documentation/Manual/execution-order.html)
-   [`MonoBehaviour` API reference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html)
