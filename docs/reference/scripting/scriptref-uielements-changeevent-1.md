---
title: "Scripting API: UIElements.ChangeEvent<T>"
page_title: "Unity - Scripting API: ChangeEvent<T0>"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.ChangeEvent_1.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.ChangeEvent_1.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# ChangeEvent\<T0>

class in UnityEngine.UIElements

/

Inherits from:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.EventBase_1.html" class="cl">UIElements.EventBase_1</a>

/

Implemented in:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UnityEngine.UIElementsModule.html" class="cl">UnityEngine.UIElementsModule</a>

<span id="scrollToFeedback">Leave feedback</span>

  

Implements interfaces:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.IChangeEvent.html" class="cl">IChangeEvent</a>

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

Sends an event when a value in a field changes.

### Properties

| Property                                                                                                                   | Description                          |
|----------------------------------------------------------------------------------------------------------------------------|--------------------------------------|
| [newValue](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.ChangeEvent_1-newValue.html)           | The new value.                       |
| [previousValue](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.ChangeEvent_1-previousValue.html) | The value before the change occured. |

### Constructors

| Constructor                                                                                                       | Description  |
|-------------------------------------------------------------------------------------------------------------------|--------------|
| [ChangeEvent_1](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.ChangeEvent_1-ctor.html) | Constructor. |

### Protected Methods

| Method                                                                                                   | Description                          |
|----------------------------------------------------------------------------------------------------------|--------------------------------------|
| [Init](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.ChangeEvent_1.Init.html) | Sets the event to its initial state. |

### Static Methods

| Method                                                                                                             | Description                                                                                                                                                                                                                                  |
|--------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [GetPooled](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.ChangeEvent_1.GetPooled.html) | Gets an event from the event pool and initializes it with the given values. Use this function instead of creating new events. Events obtained using this method need to be released back to the pool. You can use Dispose() to release them. |

### Inherited Members

### Properties

| Property                                                                                                                                               | Description                                                                                                                                                                                                                       |
|--------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [bubbles](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.EventBase-bubbles.html)                                             | Returns whether this event type bubbles up in the event propagation path during the BubbleUp phase.                                                                                                                               |
| [currentTarget](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.EventBase-currentTarget.html)                                 | The current target of the event. This is the VisualElement, in the propagation path, for which event handlers are currently being executed.                                                                                       |
| [dispatch](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.EventBase-dispatch.html)                                           | Indicates whether the event is being dispatched to a visual element. An event cannot be redispatched while it being dispatched. If you need to recursively dispatch an event, it is recommended that you use a copy of the event. |
| [ignoreDisabledElements](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.EventBase-ignoreDisabledElements.html)               | If this property is true, callbacks for this event are not invoked when the current target is disabled, unless those callbacks are registered using the CallbackOptions.IncludeDisabled option.                                   |
| [imguiEvent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.EventBase-imguiEvent.html)                                       | The IMGUIEvent at the source of this event. The source can be null since not all events are generated by IMGUI.                                                                                                                   |
| [isImmediatePropagationStopped](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.EventBase-isImmediatePropagationStopped.html) | Indicates whether StopImmediatePropagation was called for this event.                                                                                                                                                             |
| [isPropagationStopped](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.EventBase-isPropagationStopped.html)                   | Returns true if StopPropagation or StopImmediatePropagation was called for this event.                                                                                                                                            |
| [originalMousePosition](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.EventBase-originalMousePosition.html)                 | The original mouse position of the IMGUI event, before it is transformed to the current target local coordinates.                                                                                                                 |
| [pooled](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.EventBase-pooled.html)                                               | Whether the event is allocated from a pool of events.                                                                                                                                                                             |
| [propagationPhase](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.EventBase-propagationPhase.html)                           | The current propagation phase for this event.                                                                                                                                                                                     |
| [target](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.EventBase-target.html)                                               | The target visual element that received this event. Unlike currentTarget, this target does not change when the event is sent to other elements along the propagation path.                                                        |
| [timestamp](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.EventBase-timestamp.html)                                         | The time when the event was dispatched, in milliseconds.                                                                                                                                                                          |
| [tricklesDown](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.EventBase-tricklesDown.html)                                   | Returns whether this event is sent down the event propagation path during the TrickleDown phase.                                                                                                                                  |
| [eventTypeId](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.EventBase_1-eventTypeId.html)                                   | See EventBase.eventTypeId.                                                                                                                                                                                                        |

### Public Methods

| Method                                                                                                                                       | Description                                                                                                                           |
|----------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------|
| [StopImmediatePropagation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.EventBase.StopImmediatePropagation.html) | Stops the propagation of the event to other targets, and prevents other subscribers to the event on this target to receive the event. |
| [StopPropagation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.EventBase.StopPropagation.html)                   | Stops the propagation of the event to other targets. All subscribers to the event on this target still receive the event.             |
| [Dispose](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.EventBase_1.Dispose.html)                                 | Implementation of IDispose.                                                                                                           |

### Protected Methods

| Method                                                                                                               | Description                                                                    |
|----------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------|
| [PostDispatch](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.EventBase.PostDispatch.html) | Allows subclasses to perform custom logic after the event has been dispatched. |
| [PreDispatch](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.EventBase.PreDispatch.html)   | Allows subclasses to perform custom logic before the event is dispatched.      |

### Static Methods

| Method                                                                                                                           | Description                                                                                                                                                                                         |
|----------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [RegisterEventType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.EventBase.RegisterEventType.html)   | Registers an event class to the event type system.                                                                                                                                                  |
| [GetPooled](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.EventBase_1.GetPooled.html)                 | Gets an event from the event pool. Use this function instead of creating new events. Events obtained using this method need to be released back to the pool. You can use Dispose() to release them. |
| [SetCreateFunction](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.EventBase_1.SetCreateFunction.html) | Allows to provide a function to create the event instance without relying on Activator.CreateInstance.                                                                                              |
| [TypeId](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.EventBase_1.TypeId.html)                       | Retrieves the type ID for this event instance.                                                                                                                                                      |
