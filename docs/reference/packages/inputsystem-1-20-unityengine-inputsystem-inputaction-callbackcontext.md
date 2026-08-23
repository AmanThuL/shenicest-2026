---
title: "InputAction.CallbackContext API"
page_title: "Struct InputAction.CallbackContext
 | Input System | 1.20.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Struct InputAction.CallbackContext

Information provided to action callbacks about what triggered an action.

##### Inherited Members

<a href="https://learn.microsoft.com/dotnet/api/system.valuetype.equals" class="xref">ValueType.Equals(object)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.valuetype.gethashcode" class="xref">ValueType.GetHashCode()</a>

###### **Namespace**: <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.html" class="xref">UnityEngine</a>.<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.html" class="xref">InputSystem</a>

###### **Assembly**: Unity.InputSystem.dll

##### Syntax

``` lang-csharp
public struct InputAction.CallbackContext
```

##### **Remarks**

The callback context represents the current state of an <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_action" class="xref">action</a> associated with the callback and provides information associated with the bound <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_control" class="xref">control</a>, its value, and its <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_phase" class="xref">phase</a>.

The callback context provides you with a way to consume events (push-based input) as part of an update when using input action callback notifications. For example, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_started" class="xref">started</a>, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_performed" class="xref">performed</a>, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_canceled" class="xref">canceled</a> rather than relying on pull-based reading. Also see [Responding To Actions](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.11/manual/RespondingToActions.html) for additional information on differences between callbacks and polling.

Use this struct to read the current input value through any of the read-method overloads: <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_ReadValue__1" class="xref">ReadValue&lt;TValue&gt;()</a>, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_ReadValueAsButton" class="xref">ReadValueAsButton()</a>, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_ReadValueAsObject" class="xref">ReadValueAsObject()</a> or <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_ReadValue_System_Void__System_Int32_" class="xref">ReadValue(void*, int)</a> (unsafe). If you don't know the expected value type, you might need to check <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_valueType" class="xref">valueType</a> before reading the value.

Use the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_phase" class="xref">phase</a> property to get the current phase of the associated action or evaluate it directly using any of the convenience methods <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_started" class="xref">started</a>, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_performed" class="xref">performed</a>, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_canceled" class="xref">canceled</a>.

To obtain information about the current timestamp of the associated event, or to check when the event started, use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_time" class="xref">time</a> or <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_startTime" class="xref">startTime</a> respectively.

You should not use or keep this struct outside of the callback.

##### **Examples**

``` lang-csharp
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.InputSystem.Interactions;

public class MyController : MonoBehaviour
 
     void OnEnable()
     
     void OnDisable()
     
     void MovePerformed(InputAction.CallbackContext context)
     
     void FirePerformed(InputAction.CallbackContext context)
     
 }
```

### Properties

<span id="UnityEngine_InputSystem_InputAction_CallbackContext_action_" uid="UnityEngine.InputSystem.InputAction.CallbackContext.action*"></span>

#### action

The associated action that triggered the callback.

##### Declaration

``` lang-csharp
public InputAction action 
```

##### Property Value

| Type                                                                                                                                             | Description |
|--------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html" class="xref">InputAction</a> |             |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_performed" class="xref">performed</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_started" class="xref">started</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_canceled" class="xref">canceled</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html#UnityEngine_InputSystem_InputActionMap_actionTriggered" class="xref">actionTriggered</a>

<span id="UnityEngine_InputSystem_InputAction_CallbackContext_canceled_" uid="UnityEngine.InputSystem.InputAction.CallbackContext.canceled*"></span>

#### canceled

Whether the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_action" class="xref">action</a> has just been canceled.

##### Declaration

``` lang-csharp
public bool canceled 
```

##### Property Value

| Type                                                                                  | Description |
|---------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">bool</a> |             |

##### Remarks

If true, the action was just canceled.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_canceled" class="xref">canceled</a>

<span id="UnityEngine_InputSystem_InputAction_CallbackContext_control_" uid="UnityEngine.InputSystem.InputAction.CallbackContext.control*"></span>

#### control

The control that triggered the action.

##### Declaration

``` lang-csharp
public InputControl control 
```

##### Property Value

| Type                                                                                                                                               | Description |
|----------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html" class="xref">InputControl</a> |             |

##### Remarks

In case of a composite binding, this is the control of the composite that activated the composite as a whole. For example, in case of a WASD-style binding, it could be the W key.

Note that an action may also change its <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_phase" class="xref">phase</a> in response to a timeout. For example, a <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Interactions.TapInteraction.html" class="xref">TapInteraction</a> will cancel itself if the button control is not released within a certain time. When this happens, the `control` property will be the control that last fed input into the action.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_controls" class="xref">controls</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBinding.html#UnityEngine_InputSystem_InputBinding_path" class="xref">path</a>

<span id="UnityEngine_InputSystem_InputAction_CallbackContext_duration_" uid="UnityEngine.InputSystem.InputAction.CallbackContext.duration*"></span>

#### duration

Time difference between <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_time" class="xref">time</a> and <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_startTime" class="xref">startTime</a>.

##### Declaration

``` lang-csharp
public double duration 
```

##### Property Value

| Type                                                                                   | Description |
|----------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.double" class="xref">double</a> |             |

##### Remarks

This property can be used, for example, to determine how long a button was held down.

##### Examples

``` lang-csharp
// Let's create a button action bound to the A button
// on the gamepad.
var action = new InputAction(
    type: InputActionType.Button,
    binding: "<Gamepad>/buttonSouth");

// When the action is performed (which will happen when the
// button is pressed and then released) we take the duration
// of the press to determine how many projectiles to spawn.
action.performed +=
    context =>
    
    };
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_performed" class="xref">performed</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_started" class="xref">started</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_canceled" class="xref">canceled</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html#UnityEngine_InputSystem_InputActionMap_actionTriggered" class="xref">actionTriggered</a>

<span id="UnityEngine_InputSystem_InputAction_CallbackContext_interaction_" uid="UnityEngine.InputSystem.InputAction.CallbackContext.interaction*"></span>

#### interaction

The interaction that triggered the action or `null` if the binding that triggered does not have any particular interaction set on it.

##### Declaration

``` lang-csharp
public IInputInteraction interaction 
```

##### Property Value

| Type                                                                                                                                                         | Description |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.IInputInteraction.html" class="xref">IInputInteraction</a> |             |

##### Remarks

``` lang-csharp
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.InputSystem.Interactions;
class Example : MonoBehaviour

void OnEnable() => fire.action.Enable();
void OnDisable() => fire.action.Disable();

void FirePerformed(InputAction.CallbackContext context)

```

}

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBinding.html#UnityEngine_InputSystem_InputBinding_interactions" class="xref">interactions</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_interactions" class="xref">interactions</a>

<span id="UnityEngine_InputSystem_InputAction_CallbackContext_performed_" uid="UnityEngine.InputSystem.InputAction.CallbackContext.performed*"></span>

#### performed

Whether the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_action" class="xref">action</a> has just been performed.

##### Declaration

``` lang-csharp
public bool performed 
```

##### Property Value

| Type                                                                                  | Description |
|---------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">bool</a> |             |

##### Remarks

If true, the action was just performed.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_performed" class="xref">performed</a>

<span id="UnityEngine_InputSystem_InputAction_CallbackContext_phase_" uid="UnityEngine.InputSystem.InputAction.CallbackContext.phase*"></span>

#### phase

Current phase of the action. Equivalent to accessing <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_phase" class="xref">phase</a> on <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_action" class="xref">action</a>.

##### Declaration

``` lang-csharp
public InputActionPhase phase 
```

##### Property Value

| Type                                                                                                                                                       | Description                  |
|------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionPhase.html" class="xref">InputActionPhase</a> | Current phase of the action. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_started" class="xref">started</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_performed" class="xref">performed</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_canceled" class="xref">canceled</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_phase" class="xref">phase</a>

<span id="UnityEngine_InputSystem_InputAction_CallbackContext_startTime_" uid="UnityEngine.InputSystem.InputAction.CallbackContext.startTime*"></span>

#### startTime

Time at which the action was <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_started" class="xref">started</a> with relation to `Time.realtimeSinceStartup`.

##### Declaration

``` lang-csharp
public double startTime 
```

##### Property Value

| Type                                                                                   | Description |
|----------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.double" class="xref">double</a> |             |

##### Remarks

This is only relevant for actions that go through distinct a <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionPhase.html#UnityEngine_InputSystem_InputActionPhase_Started" class="xref">Started</a> cycle as driven by <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.IInputInteraction.html" class="xref">interactions</a>.

The value of this property is that of <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_time" class="xref">time</a> when <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_started" class="xref">started</a> was called. See the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_time" class="xref">time</a> property for how the timestamp works.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_performed" class="xref">performed</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_started" class="xref">started</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_canceled" class="xref">canceled</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html#UnityEngine_InputSystem_InputActionMap_actionTriggered" class="xref">actionTriggered</a>

<span id="UnityEngine_InputSystem_InputAction_CallbackContext_started_" uid="UnityEngine.InputSystem.InputAction.CallbackContext.started*"></span>

#### started

Whether the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_action" class="xref">action</a> has just been started.

##### Declaration

``` lang-csharp
public bool started 
```

##### Property Value

| Type                                                                                  | Description |
|---------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">bool</a> |             |

##### Remarks

If true, the action was just started.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_started" class="xref">started</a>

<span id="UnityEngine_InputSystem_InputAction_CallbackContext_time_" uid="UnityEngine.InputSystem.InputAction.CallbackContext.time*"></span>

#### time

The time at which the action got triggered.

##### Declaration

``` lang-csharp
public double time 
```

##### Property Value

| Type                                                                                   | Description |
|----------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.double" class="xref">double</a> |             |

##### Remarks

Time is relative to <a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Time-realtimeSinceStartup.html" class="xref">realtimeSinceStartup</a> at which the action got triggered.

This is usually determined by the timestamp of the input event that activated a control bound to the action. What this means is that this is normally *not* the value of `Time.realtimeSinceStartup` when the input system calls the callback but rather the time at which the input was generated that triggered the action.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.InputEvent.html#UnityEngine_InputSystem_LowLevel_InputEvent_time" class="xref">time</a>

<span id="UnityEngine_InputSystem_InputAction_CallbackContext_valueSizeInBytes_" uid="UnityEngine.InputSystem.InputAction.CallbackContext.valueSizeInBytes*"></span>

#### valueSizeInBytes

Size of values returned by <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_ReadValue_System_Void__System_Int32_" class="xref">ReadValue(void*, int)</a> in bytes.

##### Declaration

``` lang-csharp
public int valueSizeInBytes 
```

##### Property Value

| Type                                                                               | Description |
|------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.int32" class="xref">int</a> |             |

##### Remarks

All input values passed around by the system are required to be "blittable", i.e. they cannot contain references, cannot be heap objects themselves, and must be trivially mem-copyable. This means that any value can be read out and retained in a raw byte buffer.

The value of this property determines how many bytes will be written by <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_ReadValue_System_Void__System_Int32_" class="xref">ReadValue(void*, int)</a>.

This property indirectly maps to the value of <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html#UnityEngine_InputSystem_InputControl_valueSizeInBytes" class="xref">valueSizeInBytes</a> or <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBindingComposite-1.html#UnityEngine_InputSystem_InputBindingComposite_1_valueSizeInBytes" class="xref">valueSizeInBytes</a>.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_performed" class="xref">performed</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_started" class="xref">started</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_canceled" class="xref">canceled</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html#UnityEngine_InputSystem_InputActionMap_actionTriggered" class="xref">actionTriggered</a>

<span id="UnityEngine_InputSystem_InputAction_CallbackContext_valueType_" uid="UnityEngine.InputSystem.InputAction.CallbackContext.valueType*"></span>

#### valueType

Type of value returned by <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_ReadValueAsObject" class="xref">ReadValueAsObject()</a> and expected by <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_ReadValue__1" class="xref">ReadValue&lt;TValue&gt;()</a>.

##### Declaration

``` lang-csharp
public Type valueType 
```

##### Property Value

| Type                                                                               | Description |
|------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Type</a> |             |

##### Remarks

The type of value returned by an action is usually determined by the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html" class="xref">InputControl</a> that triggered the action, i.e. by the control referenced from <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_control" class="xref">control</a>. However, if the binding that triggered is a composite, then the composite will determine values and not the individual control that triggered (that one just feeds values into the composite).

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html#UnityEngine_InputSystem_InputControl_valueType" class="xref">valueType</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBindingComposite.html#UnityEngine_InputSystem_InputBindingComposite_valueType" class="xref">valueType</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_activeValueType" class="xref">activeValueType</a>

### Methods

<span id="UnityEngine_InputSystem_InputAction_CallbackContext_ReadValue_" uid="UnityEngine.InputSystem.InputAction.CallbackContext.ReadValue*"></span>

#### ReadValue(void\*, int)

Read the value of the action as a raw byte buffer.

##### Declaration

``` lang-csharp
public void ReadValue(void* buffer, int bufferSize)
```

##### Parameters

| Type                                                                                 | Name                                          | Description                                                                                                                                                                                                                                                                                        |
|--------------------------------------------------------------------------------------|-----------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.void" class="xref">void</a>\* | <span class="parametername">buffer</span>     | Memory buffer to read the value into.                                                                                                                                                                                                                                                              |
| <a href="https://learn.microsoft.com/dotnet/api/system.int32" class="xref">int</a>   | <span class="parametername">bufferSize</span> | Size of buffer allocated at `buffer`. Must be at least <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_valueSizeInBytes" class="xref">valueSizeInBytes</a>. |

##### Remarks

This allows reading values without having to know value types but also, unlike <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_ReadValueAsObject" class="xref">ReadValueAsObject()</a>, without allocating GC heap memory.

##### Examples

``` lang-csharp
// Read a Vector2 using the raw memory ReadValue API.
// Here we just read into a local variable which we could
// just as well (and more easily) do using ReadValue<Vector2>.
// Still, it serves as a demonstration for how the API
// operates in general.
unsafe

```

##### Exceptions

| Type                                                                                                                 | Condition                  |
|----------------------------------------------------------------------------------------------------------------------|----------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentnullexception" class="xref">ArgumentNullException</a> | `buffer` is `null`.        |
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentexception" class="xref">ArgumentException</a>         | `bufferSize` is too small. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControlExtensions.html#UnityEngine.InputSystem.InputControlExtensions.ReadValueIntoBuffer(UnityEngine.InputSystem.InputControl,System.Void*,System.Int32)" class="xref">ReadValueIntoBuffer</a>(<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html" class="xref">InputControl</a>, <a href="https://learn.microsoft.com/dotnet/api/system.void" class="xref">void</a>\*, <a href="https://learn.microsoft.com/dotnet/api/system.int32" class="xref">int</a>)

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine.InputSystem.InputAction.ReadValue%60%601" class="xref">ReadValue</a>\<TValue>()

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_ReadValue__1" class="xref">ReadValue&lt;TValue&gt;()</a>

<span id="UnityEngine_InputSystem_InputAction_CallbackContext_ReadValueAsButton_" uid="UnityEngine.InputSystem.InputAction.CallbackContext.ReadValueAsButton*"></span>

#### ReadValueAsButton()

Read the current value of the action as a `float` and return true if it is equal to or greater than the button press threshold.

##### Declaration

``` lang-csharp
public bool ReadValueAsButton()
```

##### Returns

| Type                                                                                  | Description                                                           |
|---------------------------------------------------------------------------------------|-----------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">bool</a> | True if the action is considered in "pressed" state, false otherwise. |

##### Remarks

The same press rules as <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_IsPressed" class="xref">IsPressed()</a> apply; see that method's remarks.

##### Examples

``` lang-csharp
using UnityEngine;
using UnityEngine.InputSystem;

public class Example : MonoBehaviour
{
    public InputActionReference fire;

    void Awake()
    {
        if (fire.action != null)
        {
            fire.action.performed += context =>
            {
                // ReadValueAsButton attempts to interpret the value as a button.
                Debug.Log($"Is firing: {context.ReadValueAsButton()}");
            };
        }
    }

    void OnEnable()
    
    void OnDisable()
    
}
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.html#UnityEngine_InputSystem_InputSettings_defaultButtonPressPoint" class="xref">defaultButtonPressPoint</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Controls.ButtonControl.html#UnityEngine_InputSystem_Controls_ButtonControl_pressPoint" class="xref">pressPoint</a>

<span id="UnityEngine_InputSystem_InputAction_CallbackContext_ReadValueAsObject_" uid="UnityEngine.InputSystem.InputAction.CallbackContext.ReadValueAsObject*"></span>

#### ReadValueAsObject()

Same as <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_ReadValue__1" class="xref">ReadValue&lt;TValue&gt;()</a> except that it is not necessary to know the type of the value at compile time.

##### Declaration

``` lang-csharp
public object ReadValueAsObject()
```

##### Returns

| Type                                                                                   | Description                                                                                                        |
|----------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.object" class="xref">object</a> | The current value from the binding that triggered the action or `null` if the action is not currently in progress. |

##### Remarks

This method allocates GC heap memory due to boxing. Using it during normal gameplay will lead to frame-rate instabilities.

##### Examples

``` lang-csharp
using UnityEngine;
using UnityEngine.InputSystem;

public class Example : MonoBehaviour
{
    public InputActionReference move;

    void Awake()
    {
        if (move.action != null)
        {
            move.action.performed += context =>
            {
                // ReadValueAsObject allows reading the associated value as a boxed reference type.
                object obj = context.ReadValueAsObject();
                if (obj is Vector2)
                    Debug.Log($"Current value is Vector2 type: {obj}");
                else
                    Debug.Log($"Current value is of another type: {context.valueType}");
            };
        }
    }

    void OnEnable()
    
    void OnDisable()
    
}
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_ReadValue__1" class="xref">ReadValue&lt;TValue&gt;()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine.InputSystem.InputAction.ReadValueAsObject" class="xref">ReadValueAsObject</a>()

<span id="UnityEngine_InputSystem_InputAction_CallbackContext_ReadValue_" uid="UnityEngine.InputSystem.InputAction.CallbackContext.ReadValue*"></span>

#### ReadValue\<TValue>()

Read the current value of the associated action.

##### Declaration

``` lang-csharp
public TValue ReadValue<TValue>() where TValue : struct
```

##### Returns

| Type                             | Description                                                    |
|----------------------------------|----------------------------------------------------------------|
| <span class="xref">TValue</span> | The current value of type `TValue` associated with the action. |

##### Type Parameters

| Name                                      | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|-------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <span class="parametername">TValue</span> | Type of value to read. This must correspond to the expected by either <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_control" class="xref">control</a> or, if it is a composite, by the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBindingComposite.html" class="xref">InputBindingComposite</a> in use. |

##### Remarks

The following example shows how to read the current value of a specific type:

##### Examples

``` lang-csharp
using UnityEngine;
using UnityEngine.InputSystem;

public class Example : MonoBehaviour
{
    public InputActionReference move;

    void Awake()
    {
        if (move.action != null)
        {
            move.action.performed += context =>
            {
                // Note: Assumes the underlying value type is Vector2.
                Debug.Log($"Value is: {context.ReadValue<Vector2>()}");
            };
        }
    }

    void OnEnable()
    
    void OnDisable()
    
}
```

##### Exceptions

| Type                                                                                                                         | Condition                                                                                           |
|------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.invalidoperationexception" class="xref">InvalidOperationException</a> | The given type `TValue` does not match the value type expected by the control or binding composite. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine.InputSystem.InputAction.ReadValue%60%601" class="xref">ReadValue</a>\<TValue>()

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_ReadValue_System_Void__System_Int32_" class="xref">ReadValue(void*, int)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_ReadValueAsObject" class="xref">ReadValueAsObject()</a>

<span id="UnityEngine_InputSystem_InputAction_CallbackContext_ToString_" uid="UnityEngine.InputSystem.InputAction.CallbackContext.ToString*"></span>

#### ToString()

Return a string representation of the context useful for debugging.

##### Declaration

``` lang-csharp
public override string ToString()
```

##### Returns

| Type                                                                                   | Description                           |
|----------------------------------------------------------------------------------------|---------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> | String representation of the context. |

##### Overrides

<a href="https://learn.microsoft.com/dotnet/api/system.valuetype.tostring" class="xref">ValueType.ToString()</a>

##### Remarks

The following example illustrates how to log callback context to console when a callback is received for debugging purposes:

##### Examples

``` lang-csharp
using UnityEngine;
using UnityEngine.InputSystem;

public class Example : MonoBehaviour
{
    public InputActionReference move;

    void Awake()
    {
        if (move.action != null)
        {
            move.action.performed += context =>
            {
                // Outputs the associated callback context in its textual representation which may
                // be useful for debugging purposes.
                Debug.Log(context.ToString());
            };
        }
    }

    void OnEnable() => move.action.Enable();
    void OnDisable() => move.action.Disable();
}
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_performed" class="xref">performed</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_started" class="xref">started</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_canceled" class="xref">canceled</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html#UnityEngine_InputSystem_InputActionMap_actionTriggered" class="xref">actionTriggered</a>

### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_performed" class="xref">performed</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_started" class="xref">started</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_canceled" class="xref">canceled</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html#UnityEngine_InputSystem_InputActionMap_actionTriggered" class="xref">actionTriggered</a>
