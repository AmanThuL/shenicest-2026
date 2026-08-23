---
title: "InputAction API"
page_title: "Class InputAction
 | Input System | 1.20.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Class InputAction

A named input signal that can flexibly decide which input data to tap.

##### Inheritance

<a href="https://learn.microsoft.com/dotnet/api/system.object" class="xref">object</a>

<span class="xref">InputAction</span>

##### Implements

<a href="https://learn.microsoft.com/dotnet/api/system.icloneable" class="xref">ICloneable</a>

<a href="https://learn.microsoft.com/dotnet/api/system.idisposable" class="xref">IDisposable</a>

###### **Namespace**: <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.html" class="xref">UnityEngine</a>.<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.html" class="xref">InputSystem</a>

###### **Assembly**: Unity.InputSystem.dll

##### Syntax

``` lang-csharp
[Serializable]
public sealed class InputAction : ICloneable, IDisposable
```

##### **Remarks**

An input action is an abstraction over the source of input(s) it receives. They are most useful for representing input as "logical" concepts (e.g. "jump") rather than as "physical" inputs (e.g. "space bar on keyboard pressed").

In its most basic form, an action is simply an object along with a collection of bindings that trigger the action.

``` lang-csharp
// A simple action can be created directly using `new`. If desired, a binding
// can be specified directly as part of construction.
var action = new InputAction(binding: "<Gamepad>/buttonSouth");
// Additional bindings can be added using AddBinding.
action.AddBinding("<Mouse>/leftButton");
```

Bindings use control path expressions to reference controls. See <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBinding.html" class="xref">InputBinding</a> for more details. There may be arbitrary many bindings targeting a single action. The list of bindings targeting an action can be obtained through <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_bindings" class="xref">bindings</a>.

By itself an action does not do anything until it is enabled:

``` lang-csharp
action.Enable();
```

Once enabled, the action will actively monitor all controls on devices present in the system (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_devices" class="xref">devices</a>) that match any of the binding paths associated with the action. If you want to restrict the set of bindings used at runtime or restrict the set of devices which controls are chosen from, you can do so using <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_bindingMask" class="xref">bindingMask</a> or, if the action is part of an <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref">InputActionMap</a>, by setting the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html#UnityEngine_InputSystem_InputActionMap_devices" class="xref">devices</a> property of the action map. The controls that an action uses can be queried using the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_controls" class="xref">controls</a> property.

When input is received on controls bound to an action, the action will trigger callbacks in response. These callbacks are <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_started" class="xref">started</a>, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_performed" class="xref">performed</a>, and <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_canceled" class="xref">canceled</a>. The callbacks are triggered as part of input system updates (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_Update" class="xref">Update()</a>), i.e. they happen before the respective `MonoBehaviour.Update` or `MonoBehaviour.FixedUpdate` methods get executed (depending on which <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.html#UnityEngine_InputSystem_InputSettings_updateMode" class="xref">updateMode</a> the system is set to).

In what order and how those callbacks get triggered depends on both the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_type" class="xref">type</a> of the action as well as on the interactions (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.IInputInteraction.html" class="xref">IInputInteraction</a>) present on the bindings of the action. The default behavior is that when a control is actuated (that is, moving away from its resting position), <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_started" class="xref">started</a> is called and then <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_performed" class="xref">performed</a>. Subsequently, whenever the a control further changes value to anything other than its default value, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_performed" class="xref">performed</a> will be called again. Finally, when the control moves back to its default value (i.e. resting position), <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_canceled" class="xref">canceled</a> is called.

To hook into the callbacks, there are several options available to you. The most obvious one is to hook directly into <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_started" class="xref">started</a>, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_performed" class="xref">performed</a>, and/or <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_canceled" class="xref">canceled</a>. In these callbacks, you will receive a <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html" class="xref">InputAction.CallbackContext</a> with information about how the action got triggered. For example, you can use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_ReadValue__1" class="xref">ReadValue&lt;TValue&gt;()</a> to read the value from the binding that triggered or use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_interaction" class="xref">interaction</a> to find the interaction that is in progress.

``` lang-csharp
action.started += context => Debug.Log($"{context.action} started");
action.performed += context => Debug.Log($"{context.action} performed");
action.canceled += context => Debug.Log($"{context.action} canceled");
```

Alternatively, you can use the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html#UnityEngine_InputSystem_InputActionMap_actionTriggered" class="xref">actionTriggered</a> callback for actions that are part of an action map or the global <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_onActionChange" class="xref">onActionChange</a> callback to globally listen for action activity. To simply record action activity instead of responding to it directly, you can use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Utilities.InputActionTrace.html" class="xref">InputActionTrace</a>.

If you prefer to poll an action directly as part of your `MonoBehaviour.Update` or `MonoBehaviour.FixedUpdate` logic, you can do so using the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_triggered" class="xref">triggered</a> and <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_ReadValue__1" class="xref">ReadValue&lt;TValue&gt;()</a> methods.

``` lang-csharp
protected void Update()

Note that actions are not generally frame-based. What this means is that an action will observe any value change on its connected controls, even if the control changes value multiple times in the same frame. In practice, this means that, for example, no button press will get missed.

Actions can be grouped into maps (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref">InputActionMap</a>) which can in turn be grouped into assets (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionAsset.html" class="xref">InputActionAsset</a>).

Please note that actions are a player-only feature. They are not supported in edit mode.

For more in-depth reading on actions, see the [manual](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/Actions.html).

### Constructors

<span id="UnityEngine_InputSystem_InputAction__ctor_" uid="UnityEngine.InputSystem.InputAction.#ctor*"></span>

#### InputAction()

Construct an unnamed, free-standing action that is not part of any map or asset and has no bindings. Bindings can be added with <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionSetupExtensions.html#UnityEngine_InputSystem_InputActionSetupExtensions_AddBinding_UnityEngine_InputSystem_InputAction_System_String_System_String_System_String_System_String_" class="xref">AddBinding(InputAction, string, string, string, string)</a>. The action type defaults to <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionType.html#UnityEngine_InputSystem_InputActionType_Value" class="xref">Value</a>.

##### Declaration

``` lang-csharp
public InputAction()
```

##### Remarks

The action will not have an associated <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref">InputActionMap</a> and <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_actionMap" class="xref">actionMap</a> will thus be `null`. Use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionSetupExtensions.html#UnityEngine_InputSystem_InputActionSetupExtensions_AddAction_UnityEngine_InputSystem_InputActionMap_System_String_UnityEngine_InputSystem_InputActionType_System_String_System_String_System_String_System_String_System_String_" class="xref">AddAction(InputActionMap, string, InputActionType, string, string, string, string, string)</a> instead if you want to add a new action to an action map.

The action will remain disabled after construction and thus not listen/react to input yet. Use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_Enable" class="xref">Enable()</a> to enable the action.

``` lang-csharp
// Create an action with two bindings.
var action = new InputAction();
action.AddBinding("<Gamepad>/leftStick");
action.AddBinding("<Mouse>/delta");
action.performed += ctx => Debug.Log("Value: " + ctx.ReadValue<Vector2>());
action.Enable();
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref">InputActionMap</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionAsset.html" class="xref">InputActionAsset</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBinding.html" class="xref">InputBinding</a>

<span id="UnityEngine_InputSystem_InputAction__ctor_" uid="UnityEngine.InputSystem.InputAction.#ctor*"></span>

#### InputAction(string, InputActionType, string, string, string, string)

Construct a free-standing action that is not part of an <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref">InputActionMap</a>.

##### Declaration

``` lang-csharp
public InputAction(string name = null, InputActionType type = InputActionType.Value, string binding = null, string interactions = null, string processors = null, string expectedControlType = null)
```

##### Parameters

| Type                                                                                                                                                     | Name                                                   | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
|----------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a>                                                                   | <span class="parametername">name</span>                | Name of the action. If null or empty, the action will be unnamed.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionType.html" class="xref">InputActionType</a> | <span class="parametername">type</span>                | Type of action to create. Defaults to <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionType.html#UnityEngine_InputSystem_InputActionType_Value" class="xref">Value</a>, i.e. an action that provides continuous values.                                                                                                                                                                                                                                                                                                                                                                     |
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a>                                                                   | <span class="parametername">binding</span>             | If not null or empty, a binding with the given path will be added to the action right away. The format of the string is the as for <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBinding.html#UnityEngine_InputSystem_InputBinding_path" class="xref">path</a>.                                                                                                                                                                                                                                                                                                                                |
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a>                                                                   | <span class="parametername">interactions</span>        | If `binding` is not null or empty, this parameter represents the interaction to apply to the newly created binding (i.e. <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBinding.html#UnityEngine_InputSystem_InputBinding_interactions" class="xref">interactions</a>). If `binding` is not supplied, this parameter represents the interactions to apply to the action (i.e. the value of <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_interactions" class="xref">interactions</a>). |
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a>                                                                   | <span class="parametername">processors</span>          | If `binding` is not null or empty, this parameter represents the processors to apply to the newly created binding (i.e. <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBinding.html#UnityEngine_InputSystem_InputBinding_processors" class="xref">processors</a>). If `binding` is not supplied, this parameter represents the processors to apply to the action (i.e. the value of <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_processors" class="xref">processors</a>).            |
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a>                                                                   | <span class="parametername">expectedControlType</span> | The optional expected control type for the action (i.e. <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_expectedControlType" class="xref">expectedControlType</a>).                                                                                                                                                                                                                                                                                                                                                                              |

##### Remarks

The action will not have an associated <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref">InputActionMap</a> and <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_actionMap" class="xref">actionMap</a> will thus be `null`. Use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionSetupExtensions.html#UnityEngine_InputSystem_InputActionSetupExtensions_AddAction_UnityEngine_InputSystem_InputActionMap_System_String_UnityEngine_InputSystem_InputActionType_System_String_System_String_System_String_System_String_System_String_" class="xref">AddAction(InputActionMap, string, InputActionType, string, string, string, string, string)</a> instead if you want to add a new action to an action map.

The action will remain disabled after construction and thus not listen/react to input yet. Use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_Enable" class="xref">Enable()</a> to enable the action.

Additional bindings can be added with <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionSetupExtensions.html#UnityEngine_InputSystem_InputActionSetupExtensions_AddBinding_UnityEngine_InputSystem_InputAction_System_String_System_String_System_String_System_String_" class="xref">AddBinding(InputAction, string, string, string, string)</a>.

``` lang-csharp
// Create a button action responding to the gamepad A button.
var action = new InputAction(type: InputActionType.Button, binding: "<Gamepad>/buttonSouth");
action.performed += ctx => Debug.Log("Pressed");
action.Enable();
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref">InputActionMap</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionAsset.html" class="xref">InputActionAsset</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBinding.html" class="xref">InputBinding</a>

### Properties

<span id="UnityEngine_InputSystem_InputAction_Priority_" uid="UnityEngine.InputSystem.InputAction.Priority*"></span>

#### Priority

Priority of this action when multiple bindings resolve to the same control.

##### Declaration

``` lang-csharp
public int Priority 
```

##### Property Value

| Type                                                                               | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.int32" class="xref">int</a> | Effective range is <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine.InputSystem.InputAction.MinPriority" class="xref">MinPriority</a>–<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine.InputSystem.InputAction.MaxPriority" class="xref">MaxPriority</a>. Values outside that range are clamped when set; the stored value always matches what overlap resolution uses. |

##### Remarks

Applies to all bindings that target this action. At runtime this value is used only when <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.html#UnityEngine_InputSystem_InputSettings_shortcutKeysUseActionPriority" class="xref">shortcutKeysUseActionPriority</a> is enabled. In that mode the system orders overlapping bindings on a shared control by priority, and when the action reaches <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionPhase.html#UnityEngine_InputSystem_InputActionPhase_Performed" class="xref">Performed</a>, a value greater than zero can mark the underlying input event as handled so lower-priority actions in the same group are suppressed; priority zero does not mark the event handled for that purpose. When action priority is disabled, overlap resolution instead follows <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.html#UnityEngine_InputSystem_InputSettings_shortcutKeysConsumeInput" class="xref">shortcutKeysConsumeInput</a> (automatic composite complexity) and does not consult this property.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref">InputActionMap</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionAsset.html" class="xref">InputActionAsset</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBinding.html" class="xref">InputBinding</a>

<span id="UnityEngine_InputSystem_InputAction_actionMap_" uid="UnityEngine.InputSystem.InputAction.actionMap*"></span>

#### actionMap

The map the action belongs to.

##### Declaration

``` lang-csharp
public InputActionMap actionMap 
```

##### Property Value

| Type                                                                                                                                                   | Description                                                                                                                                                                                |
|--------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref">InputActionMap</a> | <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref">InputActionMap</a> that the action belongs to or null. |

##### Remarks

If the action is a loose action created in code, this will be `null`.

``` lang-csharp
var action1 = new InputAction(); // action1.actionMap will be null
var actionMap = new InputActionMap();
var action2 = actionMap.AddAction("action"); // action2.actionMap will point to actionMap
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionSetupExtensions.html#UnityEngine.InputSystem.InputActionSetupExtensions.AddAction(UnityEngine.InputSystem.InputActionMap,System.String,UnityEngine.InputSystem.InputActionType,System.String,System.String,System.String,System.String,System.String)" class="xref">AddAction</a>(<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref">InputActionMap</a>, <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a>, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionType.html" class="xref">InputActionType</a>, <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a>, <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a>, <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a>, <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a>, <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a>)

<span id="UnityEngine_InputSystem_InputAction_activeControl_" uid="UnityEngine.InputSystem.InputAction.activeControl*"></span>

#### activeControl

The currently active control that is driving the action. [null](https://learn.microsoft.com/dotnet/csharp/language-reference/keywords/null) while the action is in waiting (<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionPhase.html#UnityEngine_InputSystem_InputActionPhase_Waiting" class="xref">Waiting</a>) or canceled (<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionPhase.html#UnityEngine_InputSystem_InputActionPhase_Canceled" class="xref">Canceled</a>) state. Otherwise the control that last had activity on it which wasn't ignored.

##### Declaration

``` lang-csharp
public InputControl activeControl 
```

##### Property Value

| Type                                                                                                                                               | Description |
|----------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html" class="xref">InputControl</a> |             |

##### Remarks

Note that the control's value does not necessarily correspond to the value of the action (<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_ReadValue__1" class="xref">ReadValue&lt;TValue&gt;()</a>) as the control may be part of a composite.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_control" class="xref">control</a>

<span id="UnityEngine_InputSystem_InputAction_activeValueType_" uid="UnityEngine.InputSystem.InputAction.activeValueType*"></span>

#### activeValueType

Type of value returned by <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_ReadValueAsObject" class="xref">ReadValueAsObject()</a> and currently expected by <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_ReadValue__1" class="xref">ReadValue&lt;TValue&gt;()</a>. [null](https://learn.microsoft.com/dotnet/csharp/language-reference/keywords/null) while the action is in waiting (<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionPhase.html#UnityEngine_InputSystem_InputActionPhase_Waiting" class="xref">Waiting</a>) or canceled (<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionPhase.html#UnityEngine_InputSystem_InputActionPhase_Canceled" class="xref">Canceled</a>) state as this is based on the currently active control that is driving the action.

##### Declaration

``` lang-csharp
public Type activeValueType 
```

##### Property Value

| Type                                                                               | Description                                   |
|------------------------------------------------------------------------------------|-----------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Type</a> | Type of object returned when reading a value. |

##### Remarks

The type of value returned by an action is usually determined by the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html" class="xref">InputControl</a> that triggered the action, i.e. by the control referenced from <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_activeControl" class="xref">activeControl</a>.

However, if the binding that triggered is a composite, then the composite will determine values and not the individual control that triggered (that one just feeds values into the composite).

The active value type may change depending on which controls are actuated if there are multiple bindings with different control types. This property can be used to ensure you are calling the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_ReadValue__1" class="xref">ReadValue&lt;TValue&gt;()</a> method with the expected type parameter if your action is configured to allow multiple control types as otherwise that method will throw an <a href="https://learn.microsoft.com/dotnet/api/system.invalidoperationexception" class="xref">InvalidOperationException</a> if the type of the control that triggered the action does not match the type parameter.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html#UnityEngine_InputSystem_InputControl_valueType" class="xref">valueType</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBindingComposite.html#UnityEngine_InputSystem_InputBindingComposite_valueType" class="xref">valueType</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_activeControl" class="xref">activeControl</a>

<span id="UnityEngine_InputSystem_InputAction_bindingMask_" uid="UnityEngine.InputSystem.InputAction.bindingMask*"></span>

#### bindingMask

An optional mask that determines which bindings of the action to enable and which to ignore.

##### Declaration

``` lang-csharp
public InputBinding? bindingMask 
```

##### Property Value

| Type                                                                                                                                                | Description                                                           |
|-----------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBinding.html" class="xref">InputBinding</a>? | Optional mask that determines which bindings on the action to enable. |

##### Remarks

Binding masks can be applied at three different levels: for an entire asset through <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionAsset.html#UnityEngine_InputSystem_InputActionAsset_bindingMask" class="xref">bindingMask</a>, for a specific map through <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html#UnityEngine_InputSystem_InputActionMap_bindingMask" class="xref">bindingMask</a>, and for single actions through this property. By default, none of the masks will be set (i.e. they will be `null`).

When an action is enabled, all the binding masks that apply to it are taken into account. Specifically, this means that any given binding on the action will be enabled only if it matches the mask applied to the asset, the mask applied to the map that contains the action, and the mask applied to the action itself. All the masks are individually optional.

Masks are matched against bindings using <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBinding.html#UnityEngine_InputSystem_InputBinding_Matches_UnityEngine_InputSystem_InputBinding_" class="xref">Matches(InputBinding)</a>.

Note that if you modify the masks applicable to an action while it is enabled, the action's <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_controls" class="xref">controls</a> will get updated immediately to respect the mask. To avoid repeated binding resolution, it is most efficient to apply binding masks before enabling actions.

Binding masks are non-destructive. All the bindings on the action are left in place. Setting a mask will not affect the value of the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_bindings" class="xref">bindings</a> property.

``` lang-csharp
// Create a free-standing action with two bindings, one in the
// "Keyboard" group and one in the "Gamepad" group.
var action = new InputAction();
action.AddBinding("<Gamepad>/buttonSouth", groups: "Gamepad");
action.AddBinding("<Keyboard>/space", groups: "Keyboard");
// By default, all bindings will be enabled. This means if both
// a keyboard and gamepad (or several of them) is present, the action
// will respond to input from all of them.
action.Enable();
// With a binding mask we can restrict the action to just specific
// bindings. For example, to only enable the gamepad binding:
action.bindingMask = InputBinding.MaskByGroup("Gamepad");
// Note that we can mask by more than just by group. Masking by path
// or by action as well as a combination of these is also possible.
// We could, for example, mask for just a specific binding path:
action.bindingMask = new InputBinding()
{
// Select the keyboard binding based on its specific path.
path = "<Keyboard>/space"
};
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBinding.html#UnityEngine.InputSystem.InputBinding.MaskByGroup(System.String)" class="xref">MaskByGroup</a>(<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a>)

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html#UnityEngine_InputSystem_InputActionMap_bindingMask" class="xref">bindingMask</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionAsset.html#UnityEngine_InputSystem_InputActionAsset_bindingMask" class="xref">bindingMask</a>

<span id="UnityEngine_InputSystem_InputAction_bindings_" uid="UnityEngine.InputSystem.InputAction.bindings*"></span>

#### bindings

The list of bindings associated with the action.

##### Declaration

``` lang-csharp
public ReadOnlyArray<InputBinding> bindings 
```

##### Property Value

| Type                                                                                                                                                                                                                                                                                                                   | Description                      |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Utilities.ReadOnlyArray-1.html" class="xref">ReadOnlyArray</a>\<<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBinding.html" class="xref">InputBinding</a>\> | List of bindings for the action. |

##### Remarks

This list contains all bindings from <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html#UnityEngine_InputSystem_InputActionMap_bindings" class="xref">bindings</a> of the action's <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_actionMap" class="xref">actionMap</a> that reference the action through their <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBinding.html#UnityEngine_InputSystem_InputBinding_action" class="xref">action</a> property.

Note that on the first call, the list may have to be extracted from the action map first which may require allocating GC memory. However, once initialized, no further GC allocation hits should occur. If the binding setup on the map is changed, re-initialization may be required.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html#UnityEngine_InputSystem_InputActionMap_bindings" class="xref">bindings</a>

<span id="UnityEngine_InputSystem_InputAction_controls_" uid="UnityEngine.InputSystem.InputAction.controls*"></span>

#### controls

The set of controls to which the action's <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_bindings" class="xref">bindings</a> resolve.

##### Declaration

``` lang-csharp
public ReadOnlyArray<InputControl> controls 
```

##### Property Value

| Type                                                                                                                                                                                                                                                                                                                   | Description                                                                                                                                                                                                                     |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Utilities.ReadOnlyArray-1.html" class="xref">ReadOnlyArray</a>\<<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html" class="xref">InputControl</a>\> | Controls resolved from the action's <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_bindings" class="xref">bindings</a>. |

##### Remarks

This property can be queried whether the action is enabled or not and will return the set of controls that match the action's bindings according to the current setup of binding masks (<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_bindingMask" class="xref">bindingMask</a>) and device restrictions (<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html#UnityEngine_InputSystem_InputActionMap_devices" class="xref">devices</a>).

Note that internally, controls are not stored on a per-action basis. This means that on the first read of this property, the list of controls for just the action may have to be extracted which in turn may allocate GC memory. After the first read, no further GC allocations should occur except if the set of controls is changed (e.g. by changing the binding mask or by adding/removing devices to/from the system).

If the property is queried when the action has not been enabled yet, the system will first resolve controls on the action (and for all actions in the map and/or the asset). See [Binding Resolution](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/ActionBindings.html#binding-resolution) in the manual for details.

To map a control in this array to an index into <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_bindings" class="xref">bindings</a>, use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionRebindingExtensions.html#UnityEngine_InputSystem_InputActionRebindingExtensions_GetBindingIndexForControl_UnityEngine_InputSystem_InputAction_UnityEngine_InputSystem_InputControl_" class="xref">GetBindingIndexForControl(InputAction, InputControl)</a>.

``` lang-csharp
// Map control list to binding indices.
var bindingIndices = myAction.controls.Select(c => myAction.GetBindingIndexForControl(c));
```

Note that this array will not contain the same control multiple times even if more than one binding on an action references the same control.

``` lang-csharp
var action1 = new InputAction();
action1.AddBinding("<Gamepad>/buttonSouth");
action1.AddBinding("<Gamepad>/buttonSouth"); // This binding will be ignored.
// Contains only one instance of buttonSouth which is associated
// with the first binding (at index #0).
var action1Controls = action1.controls;
var action2 = new InputAction();
action2.AddBinding("<Gamepad>/buttonSouth");
// Add a binding that implicitly matches the first binding, too. When binding resolution
// happens, this binding will only receive buttonNorth, buttonWest, and buttonEast, but not
// buttonSouth as the first binding already received that control.
action2.AddBinding("<Gamepad>/button*");
// Contains only all four face buttons (buttonSouth, buttonNorth, buttonEast, buttonWest)
// but buttonSouth is associated with the first button and only buttonNorth, buttonEast,
// and buttonWest are associated with the second binding.
var action2Controls = action2.controls;
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionRebindingExtensions.html#UnityEngine.InputSystem.InputActionRebindingExtensions.GetBindingIndexForControl(UnityEngine.InputSystem.InputAction,UnityEngine.InputSystem.InputControl)" class="xref">GetBindingIndexForControl</a>(<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html" class="xref">InputAction</a>, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html" class="xref">InputControl</a>)

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_bindings" class="xref">bindings</a>

<span id="UnityEngine_InputSystem_InputAction_enabled_" uid="UnityEngine.InputSystem.InputAction.enabled*"></span>

#### enabled

Whether the action is currently enabled, i.e. responds to input, or not.

##### Declaration

``` lang-csharp
public bool enabled 
```

##### Property Value

| Type                                                                                  | Description                              |
|---------------------------------------------------------------------------------------|------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">bool</a> | True if the action is currently enabled. |

##### Remarks

An action is enabled by either calling <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_Enable" class="xref">Enable()</a> on it directly or by calling <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html#UnityEngine_InputSystem_InputActionMap_Enable" class="xref">Enable()</a> on the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref">InputActionMap</a> containing the action. When enabled, an action will listen for changes on the controls it is bound to and trigger callbacks such as <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_started" class="xref">started</a>, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_performed" class="xref">performed</a>, and <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_canceled" class="xref">canceled</a> in response.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_Enable" class="xref">Enable()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_Disable" class="xref">Disable()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html#UnityEngine.InputSystem.InputActionMap.Enable" class="xref">Enable</a>()

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html#UnityEngine.InputSystem.InputActionMap.Disable" class="xref">Disable</a>()

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine.InputSystem.InputSystem.ListEnabledActions" class="xref">ListEnabledActions</a>()

<span id="UnityEngine_InputSystem_InputAction_expectedControlType_" uid="UnityEngine.InputSystem.InputAction.expectedControlType*"></span>

#### expectedControlType

Name of control layout expected for controls bound to this action.

##### Declaration

``` lang-csharp
public string expectedControlType 
```

##### Property Value

| Type                                                                                   | Description |
|----------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> |             |

##### Remarks

This is optional and is null by default.

Constraining an action to a particular control layout allows determine the value type and expected input behavior of an action without being reliant on any particular binding.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref">InputActionMap</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionAsset.html" class="xref">InputActionAsset</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBinding.html" class="xref">InputBinding</a>

<span id="UnityEngine_InputSystem_InputAction_id_" uid="UnityEngine.InputSystem.InputAction.id*"></span>

#### id

A stable, unique identifier for the action.

##### Declaration

``` lang-csharp
public Guid id 
```

##### Property Value

| Type                                                                               | Description              |
|------------------------------------------------------------------------------------|--------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.guid" class="xref">Guid</a> | Unique ID of the action. |

##### Remarks

This can be used instead of the name to refer to the action. Doing so allows referring to the action such that renaming the action does not break references.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref">InputActionMap</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionAsset.html" class="xref">InputActionAsset</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBinding.html" class="xref">InputBinding</a>

<span id="UnityEngine_InputSystem_InputAction_inProgress_" uid="UnityEngine.InputSystem.InputAction.inProgress*"></span>

#### inProgress

True if the action is currently in <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionPhase.html#UnityEngine_InputSystem_InputActionPhase_Started" class="xref">Started</a> or <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionPhase.html#UnityEngine_InputSystem_InputActionPhase_Performed" class="xref">Performed</a> phase. False in all other cases.

##### Declaration

``` lang-csharp
public bool inProgress 
```

##### Property Value

| Type                                                                                  | Description |
|---------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">bool</a> |             |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref">InputActionMap</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionAsset.html" class="xref">InputActionAsset</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBinding.html" class="xref">InputBinding</a>

<span id="UnityEngine_InputSystem_InputAction_interactions_" uid="UnityEngine.InputSystem.InputAction.interactions*"></span>

#### interactions

Interactions applied to every binding on the action.

##### Declaration

``` lang-csharp
public string interactions 
```

##### Property Value

| Type                                                                                   | Description                                       |
|----------------------------------------------------------------------------------------|---------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> | Interactions added to all bindings on the action. |

##### Remarks

This property is equivalent to appending the same string to the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBinding.html#UnityEngine_InputSystem_InputBinding_interactions" class="xref">interactions</a> field of every binding that targets the action. It is thus simply a means of avoiding the need configure the same interaction the same way on every binding in case it uniformly applies to all of them.

``` lang-csharp
var action = new InputAction(interactions: "press");
// Both of the following bindings will implicitly have a
// Press interaction applied to them.
action.AddBinding("<Gamepad>/buttonSouth");
action.AddBinding("<Joystick>/trigger");
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBinding.html#UnityEngine_InputSystem_InputBinding_interactions" class="xref">interactions</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.IInputInteraction.html" class="xref">IInputInteraction</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine.InputSystem.InputSystem.RegisterInteraction%60%601(System.String)" class="xref">RegisterInteraction</a>\<T>(<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a>)

<span id="UnityEngine_InputSystem_InputAction_name_" uid="UnityEngine.InputSystem.InputAction.name*"></span>

#### name

Name of the action.

##### Declaration

``` lang-csharp
public string name 
```

##### Property Value

| Type                                                                                   | Description                    |
|----------------------------------------------------------------------------------------|--------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> | Plain-text name of the action. |

##### Remarks

Can be null for anonymous actions created in code.

If the action is part of an <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref">InputActionMap</a>, it will have a name and the name will be unique in the map. The name is just the name of the action alone, not a "mapName/actionName" combination.

The name should not contain slashes or dots but can contain spaces and other punctuation.

An action can be renamed after creation using <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionSetupExtensions.html#UnityEngine_InputSystem_InputActionSetupExtensions_Rename_UnityEngine_InputSystem_InputAction_System_String_" class="xref">Rename(InputAction, string)</a>..

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html#UnityEngine.InputSystem.InputActionMap.FindAction(System.String,System.Boolean)" class="xref">FindAction</a>(<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a>, <a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">bool</a>)

<span id="UnityEngine_InputSystem_InputAction_phase_" uid="UnityEngine.InputSystem.InputAction.phase*"></span>

#### phase

The current phase of the action.

##### Declaration

``` lang-csharp
public InputActionPhase phase 
```

##### Property Value

| Type                                                                                                                                                       | Description |
|------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionPhase.html" class="xref">InputActionPhase</a> |             |

##### Remarks

When listening for control input and when responding to control value changes, actions will go through several possible phases.

In general, when an action starts receiving input, it will go to <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionPhase.html#UnityEngine_InputSystem_InputActionPhase_Started" class="xref">Started</a> and when it stops receiving input, it will go to <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionPhase.html#UnityEngine_InputSystem_InputActionPhase_Canceled" class="xref">Canceled</a>. When <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionPhase.html#UnityEngine_InputSystem_InputActionPhase_Performed" class="xref">Performed</a> is used depends primarily on the type of action. <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionType.html#UnityEngine_InputSystem_InputActionType_Value" class="xref">Value</a> will trigger <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionPhase.html#UnityEngine_InputSystem_InputActionPhase_Performed" class="xref">Performed</a> whenever the value of the control changes (including the first time; i.e. it will first trigger <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionPhase.html#UnityEngine_InputSystem_InputActionPhase_Started" class="xref">Started</a> and then <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionPhase.html#UnityEngine_InputSystem_InputActionPhase_Performed" class="xref">Performed</a> right after) whereas <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionType.html#UnityEngine_InputSystem_InputActionType_Button" class="xref">Button</a> will trigger <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionPhase.html#UnityEngine_InputSystem_InputActionPhase_Performed" class="xref">Performed</a> as soon as the button press threshold (<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.html#UnityEngine_InputSystem_InputSettings_defaultButtonPressPoint" class="xref">defaultButtonPressPoint</a>) has been crossed.

Note that both interactions and the action <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_type" class="xref">type</a> can affect the phases that an action goes through. <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionType.html#UnityEngine_InputSystem_InputActionType_PassThrough" class="xref">PassThrough</a> actions will only ever use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionPhase.html#UnityEngine_InputSystem_InputActionPhase_Performed" class="xref">Performed</a> and not go to <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionPhase.html#UnityEngine_InputSystem_InputActionPhase_Started" class="xref">Started</a> or <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionPhase.html#UnityEngine_InputSystem_InputActionPhase_Canceled" class="xref">Canceled</a> (as pass-through actions do not follow the start-performed-canceled model in general).

While an action is disabled, its phase is <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionPhase.html#UnityEngine_InputSystem_InputActionPhase_Disabled" class="xref">Disabled</a>.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref">InputActionMap</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionAsset.html" class="xref">InputActionAsset</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBinding.html" class="xref">InputBinding</a>

<span id="UnityEngine_InputSystem_InputAction_processors_" uid="UnityEngine.InputSystem.InputAction.processors*"></span>

#### processors

Processors applied to every binding on the action.

##### Declaration

``` lang-csharp
public string processors 
```

##### Property Value

| Type                                                                                   | Description                                     |
|----------------------------------------------------------------------------------------|-------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> | Processors added to all bindings on the action. |

##### Remarks

This property is equivalent to appending the same string to the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBinding.html#UnityEngine_InputSystem_InputBinding_processors" class="xref">processors</a> field of every binding that targets the action. It is thus simply a means of avoiding the need configure the same processor the same way on every binding in case it uniformly applies to all of them.

``` lang-csharp
var action = new InputAction(processors: "scaleVector2(x=2, y=2)");
// Both of the following bindings will implicitly have a
// ScaleVector2Processor applied to them.
action.AddBinding("<Gamepad>/leftStick");
action.AddBinding("<Joystick>/stick");
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBinding.html#UnityEngine_InputSystem_InputBinding_processors" class="xref">processors</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputProcessor.html" class="xref">InputProcessor</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine.InputSystem.InputSystem.RegisterProcessor%60%601(System.String)" class="xref">RegisterProcessor</a>\<T>(<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a>)

<span id="UnityEngine_InputSystem_InputAction_triggered_" uid="UnityEngine.InputSystem.InputAction.triggered*"></span>

#### triggered

Equivalent to <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasPerformedThisFrame" class="xref">WasPerformedThisFrame()</a>.

##### Declaration

``` lang-csharp
public bool triggered 
```

##### Property Value

| Type                                                                                  | Description |
|---------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">bool</a> |             |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasPerformedThisFrame" class="xref">WasPerformedThisFrame()</a>

<span id="UnityEngine_InputSystem_InputAction_type_" uid="UnityEngine.InputSystem.InputAction.type*"></span>

#### type

Behavior type of the action.

##### Declaration

``` lang-csharp
public InputActionType type 
```

##### Property Value

| Type                                                                                                                                                     | Description                          |
|----------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionType.html" class="xref">InputActionType</a> | General behavior type of the action. |

##### Remarks

Determines how the action gets triggered in response to control value changes.

For details about how the action type affects an action, see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionType.html" class="xref">InputActionType</a>.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref">InputActionMap</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionAsset.html" class="xref">InputActionAsset</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBinding.html" class="xref">InputBinding</a>

<span id="UnityEngine_InputSystem_InputAction_wantsInitialStateCheck_" uid="UnityEngine.InputSystem.InputAction.wantsInitialStateCheck*"></span>

#### wantsInitialStateCheck

Whether the action wants a state check on its bound controls as soon as it is enabled. This is always true for <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionType.html#UnityEngine_InputSystem_InputActionType_Value" class="xref">Value</a> actions but can optionally be enabled for <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionType.html#UnityEngine_InputSystem_InputActionType_Button" class="xref">Button</a> or <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionType.html#UnityEngine_InputSystem_InputActionType_PassThrough" class="xref">PassThrough</a> actions.

##### Declaration

``` lang-csharp
public bool wantsInitialStateCheck 
```

##### Property Value

| Type                                                                                  | Description |
|---------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">bool</a> |             |

##### Remarks

Usually, when an action is <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_enabled" class="xref">enabled</a> (e.g. via <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_Enable" class="xref">Enable()</a>), it will start listening for input and then trigger once the first input arrives. However, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_controls" class="xref">controls</a> bound to an action may already be actuated when an action is enabled. For example, if a "jump" action is bound to <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Keyboard.html#UnityEngine_InputSystem_Keyboard_spaceKey" class="xref">spaceKey</a>, the space bar may already be pressed when the jump action is enabled.

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionType.html#UnityEngine_InputSystem_InputActionType_Value" class="xref">Value</a> actions handle this differently by immediately performing an "initial state check" in the next input update (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_Update" class="xref">Update()</a>) after being enabled. If any of the bound controls is already actuated, the action will trigger right away -- even with no change in state on the controls.

This same behavior can be enabled explicitly for <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionType.html#UnityEngine_InputSystem_InputActionType_Button" class="xref">Button</a> and <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionType.html#UnityEngine_InputSystem_InputActionType_PassThrough" class="xref">PassThrough</a> actions using this property.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_Enable" class="xref">Enable()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionType.html#UnityEngine_InputSystem_InputActionType_Value" class="xref">Value</a>

### Methods

<span id="UnityEngine_InputSystem_InputAction_Clone_" uid="UnityEngine.InputSystem.InputAction.Clone*"></span>

#### Clone()

Return an identical instance of the action.

##### Declaration

``` lang-csharp
public InputAction Clone()
```

##### Returns

| Type                                                                                                                                             | Description                      |
|--------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html" class="xref">InputAction</a> | An identical clone of the action |

##### Remarks

Note that if you clone an action that is part of an <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref">InputActionMap</a>, you will not get a new action that is part of the same map. Instead, you will get a free-standing action not associated with any action map.

Also, note that the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_id" class="xref">id</a> of the action is not cloned. Instead, the clone will receive a new unique ID. Also, callbacks install on events such as <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_started" class="xref">started</a> will not be copied over to the clone.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref">InputActionMap</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionAsset.html" class="xref">InputActionAsset</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBinding.html" class="xref">InputBinding</a>

<span id="UnityEngine_InputSystem_InputAction_Disable_" uid="UnityEngine.InputSystem.InputAction.Disable*"></span>

#### Disable()

Disable the action such that is stop listening/responding to input.

##### Declaration

``` lang-csharp
public void Disable()
```

##### Remarks

If the action is already disabled, this method does nothing.

If the action is currently in progress, i.e. if <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_phase" class="xref">phase</a> is <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionPhase.html#UnityEngine_InputSystem_InputActionPhase_Started" class="xref">Started</a>, the action will be canceled as part of being disabled. This means that you will see a call on <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_canceled" class="xref">canceled</a> from within the call to `Disable()`.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_enabled" class="xref">enabled</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_Enable" class="xref">Enable()</a>

<span id="UnityEngine_InputSystem_InputAction_Dispose_" uid="UnityEngine.InputSystem.InputAction.Dispose*"></span>

#### Dispose()

Release internal state held on to by the action.

##### Declaration

``` lang-csharp
public void Dispose()
```

##### Remarks

Once enabled, actions will allocate a block of state internally that they will hold on to until disposed of. For free-standing actions, that state is private to just the action. For actions that are part of <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref">InputActionMap</a>s, the state is shared by all actions in the map and, if the map itself is part of an <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionAsset.html" class="xref">InputActionAsset</a>, also by all the maps that are part of the asset.

Note that the internal state holds on to GC heap memory as well as memory from the unmanaged, C++ heap.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref">InputActionMap</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionAsset.html" class="xref">InputActionAsset</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBinding.html" class="xref">InputBinding</a>

<span id="UnityEngine_InputSystem_InputAction_Enable_" uid="UnityEngine.InputSystem.InputAction.Enable*"></span>

#### Enable()

Enable the action such that it actively listens for input and runs callbacks in response.

##### Declaration

``` lang-csharp
public void Enable()
```

##### Remarks

If the action is already enabled, this method does nothing.

By default, actions start out disabled, i.e. with <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_enabled" class="xref">enabled</a> being false. When enabled, two things happen.

First, if it hasn't already happened, an action will resolve all of its bindings to <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html" class="xref">InputControl</a>s. This also happens if, since the action was last enabled, the setup of devices in the system has changed such that it may impact the action.

Second, for all the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_controls" class="xref">controls</a> bound to an action, change monitors (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.IInputStateChangeMonitor.html" class="xref">IInputStateChangeMonitor</a>) will be added to the system. If any of the controls changes state in the future, the action will get notified and respond.

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionType.html#UnityEngine_InputSystem_InputActionType_Value" class="xref">Value</a> type actions will also perform an initial state check in the input system update following the call to Enable. This means that if any of the bound controls are already actuated and produce a non-`default` value, the action will immediately trigger in response.

Note that this method only enables a single action. This is also allowed for action that are part of an <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref">InputActionMap</a>. To enable all actions in a map, call <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html#UnityEngine_InputSystem_InputActionMap_Enable" class="xref">Enable()</a>.

The <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref">InputActionMap</a> associated with an action (if any), will immediately toggle to being enabled (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html#UnityEngine_InputSystem_InputActionMap_enabled" class="xref">enabled</a>) as soon as the first action in the map is enabled and for as long as any action in the map is still enabled.

The first time an action is enabled, it will allocate a block of state internally that it will hold on to until disposed of. For free-standing actions, that state is private to just the action. For actions that are part of <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref">InputActionMap</a>s, the state is shared by all actions in the map and, if the map itself is part of an <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionAsset.html" class="xref">InputActionAsset</a>, also by all the maps that are part of the asset.

To dispose of the state, call <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_Dispose" class="xref">Dispose()</a>.

``` lang-csharp
var gamepad = InputSystem.AddDevice<Gamepad>();
var action = new InputAction(type: InputActionType.Value, binding: "<Gamepad>/leftTrigger");
action.performed = ctx => Debug.Log("Action triggered!");
// Perform some fake input on the gamepad. Note that the action
// will NOT get triggered as it is not enabled.
// NOTE: We use Update() here only for demonstration purposes. In most cases,
//       it's not a good method to call directly as it basically injects artificial
//       input frames into the player loop. Usually a recipe for breakage.
InputSystem.QueueStateEvent(gamepad, new GamepadState );
InputSystem.Update();
action.Enable();
// Now, with the left trigger already being down and the action enabled, it will
// trigger in the next frame.
InputSystem.Update();
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_Disable" class="xref">Disable()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_enabled" class="xref">enabled</a>

<span id="UnityEngine_InputSystem_InputAction_GetControlMagnitude_" uid="UnityEngine.InputSystem.InputAction.GetControlMagnitude*"></span>

#### GetControlMagnitude()

Read the current amount of actuation of the control that is driving this action.

##### Declaration

``` lang-csharp
public float GetControlMagnitude()
```

##### Returns

| Type                                                                                  | Description                                                                                                                                   |
|---------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.single" class="xref">float</a> | Returns the current level of control actuation (usually \[0..1\]) or -1 if the control is actuated but does not support computing magnitudes. |

##### Remarks

Magnitudes do not make sense for all types of controls. Controls that have no meaningful magnitude will return -1 when calling this method. Any negative magnitude value should be considered an invalid value.

The magnitude returned by an action is usually determined by the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html" class="xref">InputControl</a> that triggered the action, i.e. by the control referenced from <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_activeControl" class="xref">activeControl</a>. See <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html#UnityEngine_InputSystem_InputControl_EvaluateMagnitude" class="xref">EvaluateMagnitude()</a> and <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBindingComposite.html#UnityEngine_InputSystem_InputBindingComposite_EvaluateMagnitude_UnityEngine_InputSystem_InputBindingCompositeContext__" class="xref">EvaluateMagnitude(ref InputBindingCompositeContext)</a> for additional information.

However, if the binding that triggered is a composite, then the composite will determine the magnitude and not the individual control that triggered. Instead, the value of the control that triggered the action will be fed into the composite magnitude calculation.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref">InputActionMap</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionAsset.html" class="xref">InputActionAsset</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBinding.html" class="xref">InputBinding</a>

<span id="UnityEngine_InputSystem_InputAction_GetTimeoutCompletionPercentage_" uid="UnityEngine.InputSystem.InputAction.GetTimeoutCompletionPercentage*"></span>

#### GetTimeoutCompletionPercentage()

Return the completion percentage of the timeout (if any) running on the current interaction.

##### Declaration

``` lang-csharp
public float GetTimeoutCompletionPercentage()
```

##### Returns

| Type                                                                                  | Description                                                                                                           |
|---------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.single" class="xref">float</a> | A value \>= 0 (no progress) and \<= 1 (finished) indicating the level of completion of the currently running timeout. |

##### Remarks

This method is useful, for example, when providing UI feedback for an ongoing action. If, say, you have a <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Interactions.HoldInteraction.html" class="xref">HoldInteraction</a> on a binding, you might want to show a progress indicator in the UI and need to know how far into the hold the action current is. Once the hold has been started, this method will return how far into the hold the action currently is.

Note that if an interaction performs and stays performed (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputInteractionContext.html#UnityEngine_InputSystem_InputInteractionContext_PerformedAndStayPerformed" class="xref">PerformedAndStayPerformed()</a>), the completion percentage will remain at 1 until the interaction is canceled.

Also note that completion is based on the progression of time and not dependent on input updates. This means that if, for example, the timeout for a <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Interactions.HoldInteraction.html" class="xref">HoldInteraction</a> has expired according the current time but the expiration has not yet been processed by an input update (thus causing the hold to perform), the returned completion percentage will still be 1. In other words, there isn't always a correlation between the current completion percentage and <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_phase" class="xref">phase</a>.

The meaning of the timeout is dependent on the interaction in play. For a <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Interactions.HoldInteraction.html" class="xref">HoldInteraction</a>, "completion" represents the duration timeout (that is, the time until a "hold" is considered to be performed), whereas for a <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Interactions.TapInteraction.html" class="xref">TapInteraction</a> "completion" represents "time to failure" (that is, the remaining time window that the interaction can be completed within).

Note that an interaction might run multiple timeouts in succession. One such example is <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Interactions.MultiTapInteraction.html" class="xref">MultiTapInteraction</a>. In this case, progression towards a single timeout does not necessarily mean progression towards completion of the whole interaction. An interaction can call <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputInteractionContext.html#UnityEngine_InputSystem_InputInteractionContext_SetTotalTimeoutCompletionTime_System_Single_" class="xref">SetTotalTimeoutCompletionTime(float)</a> to inform the Input System of the total length of timeouts to run. If this is done, the result of the `GetTimeoutCompletionPercentage` method will return a value reflecting the progression with respect to total time.

``` lang-csharp
// Scale a UI element in response to the completion of a hold on the gamepad's A button.
Transform uiObjectToScale;
InputAction holdAction;
void OnEnable()

holdAction.Enable();

// Hide the UI object until the action is started.
uiObjectToScale.gameObject.SetActive(false);
```

}

void OnDisable() 
void Update() 
##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.IInputInteraction.html" class="xref">IInputInteraction</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputInteractionContext.html#UnityEngine.InputSystem.InputInteractionContext.SetTimeout(System.Single)" class="xref">SetTimeout</a>(<a href="https://learn.microsoft.com/dotnet/api/system.single" class="xref">float</a>)

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputInteractionContext.html#UnityEngine.InputSystem.InputInteractionContext.SetTotalTimeoutCompletionTime(System.Single)" class="xref">SetTotalTimeoutCompletionTime</a>(<a href="https://learn.microsoft.com/dotnet/api/system.single" class="xref">float</a>)

<span id="UnityEngine_InputSystem_InputAction_IsInProgress_" uid="UnityEngine.InputSystem.InputAction.IsInProgress*"></span>

#### IsInProgress()

Whether the action has been <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionPhase.html#UnityEngine_InputSystem_InputActionPhase_Started" class="xref">Started</a> or <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionPhase.html#UnityEngine_InputSystem_InputActionPhase_Performed" class="xref">Performed</a>.

##### Declaration

``` lang-csharp
public bool IsInProgress()
```

##### Returns

| Type                                                                                  | Description                                 |
|---------------------------------------------------------------------------------------|---------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">bool</a> | True if the action is currently triggering. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_phase" class="xref">phase</a>

<span id="UnityEngine_InputSystem_InputAction_IsPressed_" uid="UnityEngine.InputSystem.InputAction.IsPressed*"></span>

#### IsPressed()

Check whether the current actuation of the action has crossed the press threshold (see remarks) and has not yet fallen back below the release threshold (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.html#UnityEngine_InputSystem_InputSettings_buttonReleaseThreshold" class="xref">buttonReleaseThreshold</a>).

##### Declaration

``` lang-csharp
public bool IsPressed()
```

##### Returns

| Type                                                                                  | Description                                                                 |
|---------------------------------------------------------------------------------------|-----------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">bool</a> | True if the action is considered to be in "pressed" state, false otherwise. |

##### Remarks

This method is different from simply reading the action's current `float` value and comparing it to the press threshold and is also different from comparing the current actuation of <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_activeControl" class="xref">activeControl</a> to it. This is because the current level of actuation might have already fallen below the press threshold but might not yet have reached the release threshold.

This method works with any <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_type" class="xref">type</a> of action, not just buttons.

Also note that because this operates on the results of <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html#UnityEngine_InputSystem_InputControl_EvaluateMagnitude" class="xref">EvaluateMagnitude()</a>, it works with many kind of controls, not just buttons. For example, if an action is bound to a <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Controls.StickControl.html" class="xref">StickControl</a>, the control will be considered "pressed" once the magnitude of the Vector2 of the control has crossed the press threshold.

The same press threshold rules apply to APIs such as <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasPressedThisFrame" class="xref">WasPressedThisFrame()</a> and <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasReleasedThisFrame" class="xref">WasReleasedThisFrame()</a>.

Press threshold (based on <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html#UnityEngine_InputSystem_InputControl_EvaluateMagnitude" class="xref">EvaluateMagnitude()</a> for the driving control):

1.  If the binding lists one or more <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Interactions.PressInteraction.html" class="xref">PressInteraction</a> instances, use the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Interactions.PressInteraction.html#UnityEngine_InputSystem_Interactions_PressInteraction_pressPoint" class="xref">pressPoint</a> from the first in interaction list order whose `pressPoint` is greater than zero (earlier interactions that are not <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Interactions.PressInteraction.html" class="xref">PressInteraction</a>, or that leave `pressPoint` at the default of zero, are skipped) so this API stays aligned with the interaction.
2.  Otherwise, if the driving control is a <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Controls.ButtonControl.html" class="xref">ButtonControl</a>, use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Controls.ButtonControl.html#UnityEngine_InputSystem_Controls_ButtonControl_pressPointOrDefault" class="xref">pressPointOrDefault</a>.
3.  Otherwise (for example a <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Controls.Vector2Control.html" class="xref">Vector2Control</a> or <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Controls.StickControl.html" class="xref">StickControl</a>), use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.html#UnityEngine_InputSystem_InputSettings_defaultButtonPressPoint" class="xref">defaultButtonPressPoint</a>.

For composite bindings, interaction parameters are read from the composite binding.

``` lang-csharp
var up = playerInput.actions["up"];
if (up.IsPressed())
   transform.Translate(0, 10 * Time.deltaTime, 0);
```

Disabled actions will always return false from this method, even if a control bound to the action is currently pressed. Also, re-enabling an action will not restore the state to when the action was disabled even if the control is still actuated.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.html#UnityEngine_InputSystem_InputSettings_defaultButtonPressPoint" class="xref">defaultButtonPressPoint</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Controls.ButtonControl.html#UnityEngine_InputSystem_Controls_ButtonControl_pressPoint" class="xref">pressPoint</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine.InputSystem.InputAction.CallbackContext.ReadValueAsButton" class="xref">ReadValueAsButton</a>()

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasPressedThisFrame" class="xref">WasPressedThisFrame()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasReleasedThisFrame" class="xref">WasReleasedThisFrame()</a>

<span id="UnityEngine_InputSystem_InputAction_ReadValueAsObject_" uid="UnityEngine.InputSystem.InputAction.ReadValueAsObject*"></span>

#### ReadValueAsObject()

Same as <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_ReadValue__1" class="xref">ReadValue&lt;TValue&gt;()</a> but read the value without having to know the value type of the action.

##### Declaration

``` lang-csharp
public object ReadValueAsObject()
```

##### Returns

| Type                                                                                   | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|----------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.object" class="xref">object</a> | The current value of the action or `null` if the action is not currently in <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionPhase.html#UnityEngine_InputSystem_InputActionPhase_Started" class="xref">Started</a> or <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionPhase.html#UnityEngine_InputSystem_InputActionPhase_Performed" class="xref">Performed</a> phase. |

##### Remarks

This method allocates GC memory and is thus not a good choice for getting called as part of gameplay logic.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_ReadValue__1" class="xref">ReadValue&lt;TValue&gt;()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine.InputSystem.InputAction.CallbackContext.ReadValueAsObject" class="xref">ReadValueAsObject</a>()

<span id="UnityEngine_InputSystem_InputAction_ReadValue_" uid="UnityEngine.InputSystem.InputAction.ReadValue*"></span>

#### ReadValue\<TValue>()

Read the current value of the control that is driving this action. If no bound control is actuated, returns default(TValue), but note that binding processors are always applied.

##### Declaration

``` lang-csharp
public TValue ReadValue<TValue>() where TValue : struct
```

##### Returns

| Type                             | Description                                                                                               |
|----------------------------------|-----------------------------------------------------------------------------------------------------------|
| <span class="xref">TValue</span> | The current value of the control/binding that is driving this action with all binding processors applied. |

##### Type Parameters

| Name                                      | Description                                                                          |
|-------------------------------------------|--------------------------------------------------------------------------------------|
| <span class="parametername">TValue</span> | Value type to read. Must match the value type of the binding/control that triggered. |

##### Remarks

This method can be used as an alternative to hooking into <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_started" class="xref">started</a>, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_performed" class="xref">performed</a>, and/or <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_canceled" class="xref">canceled</a> and reading out the value using <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine_InputSystem_InputAction_CallbackContext_ReadValue__1" class="xref">ReadValue&lt;TValue&gt;()</a> there. Instead, this API acts more like a polling API that can be called, for example, as part of `MonoBehaviour.Update`.

``` lang-csharp
// Let's say you have a MyControls.inputactions file with "Generate C# Class" enabled
// and it has an action map called "gameplay" with a "move" action of type Vector2.
public class MyBehavior : MonoBehaviour

protected void OnEnable()

protected void OnDisable()

protected void Update()

```

}

If the action has button-like behavior, then <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_triggered" class="xref">triggered</a> is usually a better alternative to reading out a float and checking if it is above the button press point.

##### Exceptions

| Type                                                                                                                         | Condition                                                                                                       |
|------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.invalidoperationexception" class="xref">InvalidOperationException</a> | The given `TValue` type does not match the value type of the control or composite currently driving the action. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_triggered" class="xref">triggered</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_ReadValueAsObject" class="xref">ReadValueAsObject()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine.InputSystem.InputAction.CallbackContext.ReadValue%60%601" class="xref">ReadValue</a>\<TValue>()

<span id="UnityEngine_InputSystem_InputAction_Reset_" uid="UnityEngine.InputSystem.InputAction.Reset*"></span>

#### Reset()

Reset the action state to default.

##### Declaration

``` lang-csharp
public void Reset()
```

##### Remarks

This method can be used to forcibly cancel an action even while it is in progress. Note that unlike disabling an action, for example, this also effects APIs such as <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasPressedThisFrame" class="xref">WasPressedThisFrame()</a>.

Note that invoking this method will not modify enabled state.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_inProgress" class="xref">inProgress</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_phase" class="xref">phase</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_Enable" class="xref">Enable()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_Disable" class="xref">Disable()</a>

<span id="UnityEngine_InputSystem_InputAction_ToString_" uid="UnityEngine.InputSystem.InputAction.ToString*"></span>

#### ToString()

Return a string version of the action. Mainly useful for debugging.

##### Declaration

``` lang-csharp
public override string ToString()
```

##### Returns

| Type                                                                                   | Description                     |
|----------------------------------------------------------------------------------------|---------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> | A string version of the action. |

##### Overrides

<a href="https://learn.microsoft.com/dotnet/api/system.object.tostring" class="xref">object.ToString()</a>

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref">InputActionMap</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionAsset.html" class="xref">InputActionAsset</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBinding.html" class="xref">InputBinding</a>

<span id="UnityEngine_InputSystem_InputAction_WasCompletedThisDynamicUpdate_" uid="UnityEngine.InputSystem.InputAction.WasCompletedThisDynamicUpdate*"></span>

#### WasCompletedThisDynamicUpdate()

Check whether <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_phase" class="xref">phase</a> transitioned from <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionPhase.html#UnityEngine_InputSystem_InputActionPhase_Performed" class="xref">Performed</a> to any other phase value at least once in the MonoBehaviour Update cycle (rendering frame).

##### Declaration

``` lang-csharp
public bool WasCompletedThisDynamicUpdate()
```

##### Returns

| Type                                                                                  | Description                                                                        |
|---------------------------------------------------------------------------------------|------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">bool</a> | True if the action completed in this MonoBehaviour Update cycle (rendering frame). |

##### Remarks

Unlike <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasCompletedThisFrame" class="xref">WasCompletedThisFrame()</a>, this method will return true only if the InputSystem was updated and the action was completed in the current dynamic Update cycle (in between the previous and the current frame). This can be used in dynamic update if the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.html#UnityEngine_InputSystem_InputSettings_updateMode" class="xref">updateMode</a> is set to <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.UpdateMode.html#UnityEngine_InputSystem_InputSettings_UpdateMode_ProcessEventsInFixedUpdate" class="xref">ProcessEventsInFixedUpdate</a> or <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.UpdateMode.html#UnityEngine_InputSystem_InputSettings_UpdateMode_ProcessEventsManually" class="xref">ProcessEventsManually</a>. If the update mode is set to <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.UpdateMode.html#UnityEngine_InputSystem_InputSettings_UpdateMode_ProcessEventsInDynamicUpdate" class="xref">ProcessEventsInDynamicUpdate</a>, this method will behave exactly like <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasCompletedThisFrame" class="xref">WasCompletedThisFrame()</a>.

When processing input events manually, updating the InputSystem in the dynamic Update cycle will lead to a delay of one frame for WasCompletedThisDynamicUpdate, you may want to use WasCompletedThisFrame to avoid this, or set the input update mode to InputSettings.UpdateMode.ProcessEventsInDynamicUpdate.

##### Examples

``` lang-csharp
var teleport = playerInput.actions["Teleport"];
if (teleport.WasPerformedThisDynamicUpdate())
    InitiateTeleport();
else if (teleport.WasCompletedThisDynamicUpdate())
    StopTeleport();
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasPerformedThisFrame" class="xref">WasPerformedThisFrame()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasCompletedThisFrame" class="xref">WasCompletedThisFrame()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasPressedThisFrame" class="xref">WasPressedThisFrame()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_phase" class="xref">phase</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.html#UnityEngine_InputSystem_InputSettings_updateMode" class="xref">updateMode</a>

<span id="UnityEngine_InputSystem_InputAction_WasCompletedThisFrame_" uid="UnityEngine.InputSystem.InputAction.WasCompletedThisFrame*"></span>

#### WasCompletedThisFrame()

Check whether <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_phase" class="xref">phase</a> transitioned from <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionPhase.html#UnityEngine_InputSystem_InputActionPhase_Performed" class="xref">Performed</a> to any other phase value at least once in the current frame.

##### Declaration

``` lang-csharp
public bool WasCompletedThisFrame()
```

##### Returns

| Type                                                                                  | Description                              |
|---------------------------------------------------------------------------------------|------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">bool</a> | True if the action completed this frame. |

##### Remarks

Although <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionPhase.html#UnityEngine_InputSystem_InputActionPhase_Disabled" class="xref">Disabled</a> is technically a phase, this method does not consider disabling the action while the action is in <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionPhase.html#UnityEngine_InputSystem_InputActionPhase_Performed" class="xref">Performed</a> to be "completed".

This method is different from <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasReleasedThisFrame" class="xref">WasReleasedThisFrame()</a> in that it depends directly on the interaction(s) driving the action (including the default interaction if no specific interaction has been added to the action or binding).

For example, let's say the action is bound to the space bar and that the binding has a <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Interactions.HoldInteraction.html" class="xref">HoldInteraction</a> assigned to it. In the frame where the space bar is pressed, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasPressedThisFrame" class="xref">WasPressedThisFrame()</a> will be true (because the button/key is now pressed) but <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasPerformedThisFrame" class="xref">WasPerformedThisFrame()</a> will still be false (because the hold has not been performed yet). If at that time the space bar is released, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasReleasedThisFrame" class="xref">WasReleasedThisFrame()</a> will be true (because the button/key is now released) but `WasCompletedThisFrame` will still be false (because the hold had not been performed yet). If instead the space bar is held down for long enough for the hold interaction, the phase will change to and stay <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionPhase.html#UnityEngine_InputSystem_InputActionPhase_Performed" class="xref">Performed</a> and <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasPerformedThisFrame" class="xref">WasPerformedThisFrame()</a> will be true for one frame as it meets the duration threshold. Once released, `WasCompletedThisFrame` will be true (because the action is no longer performed) and only in the frame where the hold transitioned away from Performed.

For another example where the action could be considered pressed but also completed, let's say the action is bound to the thumbstick and that the binding has a Sector interaction from the XR Interaction Toolkit assigned to it such that it only performs in the forward sector area past a button press threshold. In the frame where the thumbstick is pushed forward, both <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasPressedThisFrame" class="xref">WasPressedThisFrame()</a> will be true (because the thumbstick actuation is now considered pressed) and <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasPerformedThisFrame" class="xref">WasPerformedThisFrame()</a> will be true (because the thumbstick is in the forward sector). If the thumbstick is then moved to the left in a sweeping motion, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_IsPressed" class="xref">IsPressed()</a> will still be true. However, `WasCompletedThisFrame` will also be true (because the thumbstick is no longer in the forward sector while still crossed the button press threshold) and only in the frame where the thumbstick was no longer within the forward sector. For more details about the Sector interaction, see [`SectorInteraction`](https://docs.unity3d.com/Packages/com.unity.xr.interaction.toolkit@2.5/api/UnityEngine.XR.Interaction.Toolkit.Inputs.Interactions.SectorInteraction.html) in the XR Interaction Toolkit Scripting API documentation.

Unlike <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_ReadValue__1" class="xref">ReadValue&lt;TValue&gt;()</a>, which will reset when the action goes back to waiting state, this property will stay true for the duration of the current frame (that is, until the next <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_Update" class="xref">Update()</a> runs) as long as the action was completed at least once.

This method will disregard whether the action is currently enabled or disabled. It will keep returning true for the duration of the frame even if the action was subsequently disabled in the frame.

\> \[!NOTE\] \> If the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.html#UnityEngine_InputSystem_InputSettings_updateMode" class="xref">updateMode</a> is set to <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.UpdateMode.html#UnityEngine_InputSystem_InputSettings_UpdateMode_ProcessEventsInFixedUpdate" class="xref">ProcessEventsInFixedUpdate</a> or <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.UpdateMode.html#UnityEngine_InputSystem_InputSettings_UpdateMode_ProcessEventsManually" class="xref">ProcessEventsManually</a> and InputSystem.Update() is not called in \> the dynamic Update, use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasCompletedThisDynamicUpdate" class="xref">WasCompletedThisDynamicUpdate()</a> to access this during dynamic Update instead.

##### Examples

``` lang-csharp
var teleport = playerInput.actions["Teleport"];
if (teleport.WasPerformedThisFrame())
    InitiateTeleport();
else if (teleport.WasCompletedThisFrame())
    StopTeleport();
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasCompletedThisDynamicUpdate" class="xref">WasCompletedThisDynamicUpdate()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasPerformedThisFrame" class="xref">WasPerformedThisFrame()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasReleasedThisFrame" class="xref">WasReleasedThisFrame()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_phase" class="xref">phase</a>

<span id="UnityEngine_InputSystem_InputAction_WasPerformedThisDynamicUpdate_" uid="UnityEngine.InputSystem.InputAction.WasPerformedThisDynamicUpdate*"></span>

#### WasPerformedThisDynamicUpdate()

Check whether <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_phase" class="xref">phase</a> was <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionPhase.html#UnityEngine_InputSystem_InputActionPhase_Performed" class="xref">Performed</a> at any point in the MonoBehaviour Update cycle (rendering frame).

##### Declaration

``` lang-csharp
public bool WasPerformedThisDynamicUpdate()
```

##### Returns

| Type                                                                                  | Description                                                                       |
|---------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">bool</a> | True if the action performed in the MonoBehaviour Update cycle (rendering frame). |

##### Remarks

Unlike <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasPerformedThisFrame" class="xref">WasPerformedThisFrame()</a>, this method will return true only if the InputSystem was updated and the action was performed in the current dynamic Update cycle (in between the previous and the current frame). This can be used in dynamic update if the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.html#UnityEngine_InputSystem_InputSettings_updateMode" class="xref">updateMode</a> is set to <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.UpdateMode.html#UnityEngine_InputSystem_InputSettings_UpdateMode_ProcessEventsInFixedUpdate" class="xref">ProcessEventsInFixedUpdate</a> or <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.UpdateMode.html#UnityEngine_InputSystem_InputSettings_UpdateMode_ProcessEventsManually" class="xref">ProcessEventsManually</a>. If the update mode is set to <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.UpdateMode.html#UnityEngine_InputSystem_InputSettings_UpdateMode_ProcessEventsInDynamicUpdate" class="xref">ProcessEventsInDynamicUpdate</a>, this method will behave exactly like <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasPerformedThisFrame" class="xref">WasPerformedThisFrame()</a>.

When processing input events manually, updating the InputSystem in the dynamic Update cycle will lead to a delay of one frame for WasPerformedThisDynamicUpdate, you may want to use WasPerformedThisFrame to avoid this, or set the input update mode to InputSettings.UpdateMode.ProcessEventsInDynamicUpdate.

##### Examples

``` lang-csharp
var warp = playerInput.actions["Warp"];
if (warp.WasPerformedThisDynamicUpdate())
    InitiateWarp();
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasPerformedThisFrame" class="xref">WasPerformedThisFrame()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasCompletedThisFrame" class="xref">WasCompletedThisFrame()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasPressedThisFrame" class="xref">WasPressedThisFrame()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_phase" class="xref">phase</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.html#UnityEngine_InputSystem_InputSettings_updateMode" class="xref">updateMode</a>

<span id="UnityEngine_InputSystem_InputAction_WasPerformedThisFrame_" uid="UnityEngine.InputSystem.InputAction.WasPerformedThisFrame*"></span>

#### WasPerformedThisFrame()

Check whether <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_phase" class="xref">phase</a> was <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionPhase.html#UnityEngine_InputSystem_InputActionPhase_Performed" class="xref">Performed</a> at any point in the current frame.

##### Declaration

``` lang-csharp
public bool WasPerformedThisFrame()
```

##### Returns

| Type                                                                                  | Description                              |
|---------------------------------------------------------------------------------------|------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">bool</a> | True if the action performed this frame. |

##### Remarks

This method is different from <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasPressedThisFrame" class="xref">WasPressedThisFrame()</a> in that it depends directly on the interaction(s) driving the action (including the default interaction if no specific interaction has been added to the action or binding).

For example, let's say the action is bound to the space bar and that the binding has a <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Interactions.HoldInteraction.html" class="xref">HoldInteraction</a> assigned to it. In the frame where the space bar is pressed, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasPressedThisFrame" class="xref">WasPressedThisFrame()</a> will be true (because the button/key is now pressed) but `WasPerformedThisFrame` will still be false (because the hold has not been performed yet). Only after the hold time has expired will `WasPerformedThisFrame` be true and only in the frame where the hold performed.

This is different from checking <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_phase" class="xref">phase</a> directly as the action might have already progressed to a different phase after performing. In other words, even if an action performed in a frame, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_phase" class="xref">phase</a> might no longer be <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionPhase.html#UnityEngine_InputSystem_InputActionPhase_Performed" class="xref">Performed</a>, whereas `WasPerformedThisFrame` will remain true for the entirety of the frame regardless of what else the action does.

Unlike <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_ReadValue__1" class="xref">ReadValue&lt;TValue&gt;()</a>, which will reset when the action goes back to waiting state, this property will stay true for the duration of the current frame (that is, until the next <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_Update" class="xref">Update()</a> runs) as long as the action was triggered at least once.

``` lang-csharp
var warp = playerInput.actions["Warp"];
if (warp.WasPerformedThisFrame())
    InitiateWarp();
```

This method will disregard whether the action is currently enabled or disabled. It will keep returning true for the duration of the frame even if the action was subsequently disabled in the frame.

##### Note

If the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.html#UnityEngine_InputSystem_InputSettings_updateMode" class="xref">updateMode</a> is set to <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.UpdateMode.html#UnityEngine_InputSystem_InputSettings_UpdateMode_ProcessEventsInFixedUpdate" class="xref">ProcessEventsInFixedUpdate</a> or <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.UpdateMode.html#UnityEngine_InputSystem_InputSettings_UpdateMode_ProcessEventsManually" class="xref">ProcessEventsManually</a> and InputSystem.Update() is not called in the dynamic Update, use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasPerformedThisDynamicUpdate" class="xref">WasPerformedThisDynamicUpdate()</a> when trying to access in dynamic Update instead.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasPerformedThisDynamicUpdate" class="xref">WasPerformedThisDynamicUpdate()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasCompletedThisFrame" class="xref">WasCompletedThisFrame()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasPressedThisFrame" class="xref">WasPressedThisFrame()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_phase" class="xref">phase</a>

<span id="UnityEngine_InputSystem_InputAction_WasPressedThisDynamicUpdate_" uid="UnityEngine.InputSystem.InputAction.WasPressedThisDynamicUpdate*"></span>

#### WasPressedThisDynamicUpdate()

Returns true if the action's value crossed the press threshold (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasPressedThisFrame" class="xref">WasPressedThisFrame()</a> remarks) in the MonoBehaviour Update cycle (rendering frame).

##### Declaration

``` lang-csharp
public bool WasPressedThisDynamicUpdate()
```

##### Returns

| Type                                                                                  | Description                                                                         |
|---------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">bool</a> | True if the action was pressed in the MonoBehaviour Update cycle (rendering frame). |

##### Remarks

Unlike <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasPressedThisFrame" class="xref">WasPressedThisFrame()</a>, this method will return true only if the InputSystem was updated and the action was pressed in the current dynamic Update cycle (in between the previous and the current frame). This can be used in dynamic update if the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.html#UnityEngine_InputSystem_InputSettings_updateMode" class="xref">updateMode</a> is set to <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.UpdateMode.html#UnityEngine_InputSystem_InputSettings_UpdateMode_ProcessEventsInFixedUpdate" class="xref">ProcessEventsInFixedUpdate</a> or <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.UpdateMode.html#UnityEngine_InputSystem_InputSettings_UpdateMode_ProcessEventsManually" class="xref">ProcessEventsManually</a>. If the update mode is set to <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.UpdateMode.html#UnityEngine_InputSystem_InputSettings_UpdateMode_ProcessEventsInDynamicUpdate" class="xref">ProcessEventsInDynamicUpdate</a>, this method will behave exactly like <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasPressedThisFrame" class="xref">WasPressedThisFrame()</a>.

When processing input events manually, updating the InputSystem in the dynamic Update cycle will lead to a delay of one frame for WasPressedThisDynamicUpdate, you may want to use WasPressedThisFrame to avoid this, or set the input update mode to InputSettings.UpdateMode.ProcessEventsInDynamicUpdate.

Press threshold behavior matches <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_IsPressed" class="xref">IsPressed()</a>; see that member's remarks.

##### Examples

``` lang-csharp
var fire = playerInput.actions["fire"];
if (fire.WasPressedThisDynamicUpdate() && fire.IsPressed())
    StartFiring();
else if (fire.WasReleasedThisDynamicUpdate())
    StopFiring();
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_IsPressed" class="xref">IsPressed()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasPressedThisFrame" class="xref">WasPressedThisFrame()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasReleasedThisFrame" class="xref">WasReleasedThisFrame()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasPerformedThisFrame" class="xref">WasPerformedThisFrame()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.html#UnityEngine_InputSystem_InputSettings_updateMode" class="xref">updateMode</a>

<span id="UnityEngine_InputSystem_InputAction_WasPressedThisFrame_" uid="UnityEngine.InputSystem.InputAction.WasPressedThisFrame*"></span>

#### WasPressedThisFrame()

Returns true if the action's value crossed the press threshold (see remarks) at any point in the frame.

##### Declaration

``` lang-csharp
public bool WasPressedThisFrame()
```

##### Returns

| Type                                                                                  | Description                                |
|---------------------------------------------------------------------------------------|--------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">bool</a> | True if the action was pressed this frame. |

##### Remarks

This method is different from <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasPerformedThisFrame" class="xref">WasPerformedThisFrame()</a> in that it is not bound to <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_phase" class="xref">phase</a>. Instead, if the action's level of actuation (that is, the level of magnitude -- see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html#UnityEngine_InputSystem_InputControl_EvaluateMagnitude" class="xref">EvaluateMagnitude()</a> -- of the control(s) bound to the action) crossed the press threshold at any point in the frame, this method will return true. It will do so even if there is an interaction on the action that has not yet performed the action in response to the press.

This method works with any <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_type" class="xref">type</a> of action, not just buttons.

Also note that because this operates on the results of <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html#UnityEngine_InputSystem_InputControl_EvaluateMagnitude" class="xref">EvaluateMagnitude()</a>, it works with many kind of controls, not just buttons. For example, if an action is bound to a <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Controls.StickControl.html" class="xref">StickControl</a>, the control will be considered "pressed" once the magnitude of the Vector2 of the control has crossed the press threshold.

Press threshold is defined the same way as for <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_IsPressed" class="xref">IsPressed()</a>; see that member's remarks.

``` lang-csharp
var fire = playerInput.actions["fire"];
if (fire.WasPressedThisFrame() && fire.IsPressed())
    StartFiring();
else if (fire.WasReleasedThisFrame())
    StopFiring();
```

This method will disregard whether the action is currently enabled or disabled. It will keep returning true for the duration of the frame even if the action was subsequently disabled in the frame.

##### Note

If the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.html#UnityEngine_InputSystem_InputSettings_updateMode" class="xref">updateMode</a> is set to <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.UpdateMode.html#UnityEngine_InputSystem_InputSettings_UpdateMode_ProcessEventsInFixedUpdate" class="xref">ProcessEventsInFixedUpdate</a> or <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.UpdateMode.html#UnityEngine_InputSystem_InputSettings_UpdateMode_ProcessEventsManually" class="xref">ProcessEventsManually</a> and InputSystem.Update() is not called in the dynamic Update, use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasPressedThisDynamicUpdate" class="xref">WasPressedThisDynamicUpdate()</a> during dynamic Update instead.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_IsPressed" class="xref">IsPressed()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasPressedThisDynamicUpdate" class="xref">WasPressedThisDynamicUpdate()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasReleasedThisFrame" class="xref">WasReleasedThisFrame()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine.InputSystem.InputAction.CallbackContext.ReadValueAsButton" class="xref">ReadValueAsButton</a>()

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasPerformedThisFrame" class="xref">WasPerformedThisFrame()</a>

<span id="UnityEngine_InputSystem_InputAction_WasReleasedThisDynamicUpdate_" uid="UnityEngine.InputSystem.InputAction.WasReleasedThisDynamicUpdate*"></span>

#### WasReleasedThisDynamicUpdate()

Returns true if the action's value crossed the release threshold (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.html#UnityEngine_InputSystem_InputSettings_buttonReleaseThreshold" class="xref">buttonReleaseThreshold</a>) at any point in the MonoBehaviour Update cycle (rendering frame), after having been in the pressed state described by <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasReleasedThisFrame" class="xref">WasReleasedThisFrame()</a>.

##### Declaration

``` lang-csharp
public bool WasReleasedThisDynamicUpdate()
```

##### Returns

| Type                                                                                  | Description                                                                          |
|---------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">bool</a> | True if the action was released in the MonoBehaviour Update cycle (rendering frame). |

##### Remarks

Unlike <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasReleasedThisFrame" class="xref">WasReleasedThisFrame()</a>, this method will return true only if the InputSystem was updated and the action was released in the current dynamic Update cycle (in between the previous and the current frame). This can be used in dynamic update if the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.html#UnityEngine_InputSystem_InputSettings_updateMode" class="xref">updateMode</a> is set to <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.UpdateMode.html#UnityEngine_InputSystem_InputSettings_UpdateMode_ProcessEventsInFixedUpdate" class="xref">ProcessEventsInFixedUpdate</a> or <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.UpdateMode.html#UnityEngine_InputSystem_InputSettings_UpdateMode_ProcessEventsManually" class="xref">ProcessEventsManually</a>. If the update mode is set to <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.UpdateMode.html#UnityEngine_InputSystem_InputSettings_UpdateMode_ProcessEventsInDynamicUpdate" class="xref">ProcessEventsInDynamicUpdate</a>, this method will behave exactly like <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasReleasedThisFrame" class="xref">WasReleasedThisFrame()</a>.

When processing input events manually, updating the InputSystem in the dynamic Update cycle will lead to a delay of one frame for WasReleasedThisDynamicUpdate, you may want to use WasReleasedThisFrame to avoid this, or set the input update mode to InputSettings.UpdateMode.ProcessEventsInDynamicUpdate.

Press and release threshold behavior matches <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasReleasedThisFrame" class="xref">WasReleasedThisFrame()</a>; see its remarks.

##### Examples

``` lang-csharp
var fire = playerInput.actions["fire"];
if (fire.WasPressedThisDynamicUpdate() && fire.IsPressed())
    StartFiring();
else if (fire.WasReleasedThisDynamicUpdate())
    StopFiring();
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_IsPressed" class="xref">IsPressed()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasPressedThisFrame" class="xref">WasPressedThisFrame()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasReleasedThisFrame" class="xref">WasReleasedThisFrame()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine.InputSystem.InputAction.CallbackContext.ReadValueAsButton" class="xref">ReadValueAsButton</a>()

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasCompletedThisFrame" class="xref">WasCompletedThisFrame()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.html#UnityEngine_InputSystem_InputSettings_updateMode" class="xref">updateMode</a>

<span id="UnityEngine_InputSystem_InputAction_WasReleasedThisFrame_" uid="UnityEngine.InputSystem.InputAction.WasReleasedThisFrame*"></span>

#### WasReleasedThisFrame()

Returns true if the action's value crossed the release threshold (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.html#UnityEngine_InputSystem_InputSettings_buttonReleaseThreshold" class="xref">buttonReleaseThreshold</a>) at any point in the frame after being in pressed state (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_IsPressed" class="xref">IsPressed()</a> remarks for press threshold).

##### Declaration

``` lang-csharp
public bool WasReleasedThisFrame()
```

##### Returns

| Type                                                                                  | Description                                 |
|---------------------------------------------------------------------------------------|---------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">bool</a> | True if the action was released this frame. |

##### Remarks

This method works with any <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_type" class="xref">type</a> of action, not just buttons.

Also note that because this operates on the results of <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html#UnityEngine_InputSystem_InputControl_EvaluateMagnitude" class="xref">EvaluateMagnitude()</a>, it works with many kind of controls, not just buttons. For example, if an action is bound to a <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Controls.StickControl.html" class="xref">StickControl</a>, the control will be considered "pressed" once the magnitude of the Vector2 of the control has crossed the press threshold.

Press threshold is defined the same way as for <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_IsPressed" class="xref">IsPressed()</a>; see that member's remarks.

``` lang-csharp
var fire = playerInput.actions["fire"];
if (fire.WasPressedThisFrame() && fire.IsPressed())
    StartFiring();
else if (fire.WasReleasedThisFrame())
    StopFiring();
```

This method will disregard whether the action is currently enabled or disabled. It will keep returning true for the duration of the frame even if the action was subsequently disabled in the frame.

##### Note

If the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.html#UnityEngine_InputSystem_InputSettings_updateMode" class="xref">updateMode</a> is set to <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.UpdateMode.html#UnityEngine_InputSystem_InputSettings_UpdateMode_ProcessEventsInFixedUpdate" class="xref">ProcessEventsInFixedUpdate</a> or <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.UpdateMode.html#UnityEngine_InputSystem_InputSettings_UpdateMode_ProcessEventsManually" class="xref">ProcessEventsManually</a> and InputSystem.Update() is not called in the dynamic Update, use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasReleasedThisDynamicUpdate" class="xref">WasReleasedThisDynamicUpdate()</a> during dynamic Update instead.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_IsPressed" class="xref">IsPressed()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasReleasedThisDynamicUpdate" class="xref">WasReleasedThisDynamicUpdate()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasPressedThisFrame" class="xref">WasPressedThisFrame()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html#UnityEngine.InputSystem.InputAction.CallbackContext.ReadValueAsButton" class="xref">ReadValueAsButton</a>()

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_WasCompletedThisFrame" class="xref">WasCompletedThisFrame()</a>

### Events

#### canceled

Event that is triggered when the action has been <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_started" class="xref">started</a> but then canceled before being fully <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_performed" class="xref">performed</a>.

##### Declaration

``` lang-csharp
public event Action<InputAction.CallbackContext> canceled
```

##### Event Type

| Type                                                                                                                                                                                                                                                                                                                                                                                                              | Description |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.action-1" class="xref">Action</a>\<<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html" class="xref">InputAction</a>.<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html" class="xref">CallbackContext</a>\> |             |

##### Remarks

See <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_phase" class="xref">phase</a> for details of how an action progresses through phases and triggers this callback.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref">InputActionMap</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionAsset.html" class="xref">InputActionAsset</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBinding.html" class="xref">InputBinding</a>

#### performed

Event that is triggered when the action has been fully performed.

##### Declaration

``` lang-csharp
public event Action<InputAction.CallbackContext> performed
```

##### Event Type

| Type                                                                                                                                                                                                                                                                                                                                                                                                              | Description |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.action-1" class="xref">Action</a>\<<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html" class="xref">InputAction</a>.<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html" class="xref">CallbackContext</a>\> |             |

##### Remarks

See <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_phase" class="xref">phase</a> for details of how an action progresses through phases and triggers this callback.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref">InputActionMap</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionAsset.html" class="xref">InputActionAsset</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBinding.html" class="xref">InputBinding</a>

#### started

Event that is triggered when the action has been started.

##### Declaration

``` lang-csharp
public event Action<InputAction.CallbackContext> started
```

##### Event Type

| Type                                                                                                                                                                                                                                                                                                                                                                                                              | Description |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.action-1" class="xref">Action</a>\<<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html" class="xref">InputAction</a>.<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html" class="xref">CallbackContext</a>\> |             |

##### Remarks

See <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_phase" class="xref">phase</a> for details of how an action progresses through phases and triggers this callback.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref">InputActionMap</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionAsset.html" class="xref">InputActionAsset</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBinding.html" class="xref">InputBinding</a>

### Implements

<a href="https://learn.microsoft.com/dotnet/api/system.icloneable" class="xref">ICloneable</a>

<a href="https://learn.microsoft.com/dotnet/api/system.idisposable" class="xref">IDisposable</a>

### Extension Methods

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionRebindingExtensions.html#UnityEngine_InputSystem_InputActionRebindingExtensions_ApplyBindingOverride_UnityEngine_InputSystem_InputAction_System_Int32_System_String_" class="xref">InputActionRebindingExtensions.ApplyBindingOverride(InputAction, int, string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionRebindingExtensions.html#UnityEngine_InputSystem_InputActionRebindingExtensions_ApplyBindingOverride_UnityEngine_InputSystem_InputAction_System_Int32_UnityEngine_InputSystem_InputBinding_" class="xref">InputActionRebindingExtensions.ApplyBindingOverride(InputAction, int, InputBinding)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionRebindingExtensions.html#UnityEngine_InputSystem_InputActionRebindingExtensions_ApplyBindingOverride_UnityEngine_InputSystem_InputAction_System_String_System_String_System_String_" class="xref">InputActionRebindingExtensions.ApplyBindingOverride(InputAction, string, string, string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionRebindingExtensions.html#UnityEngine_InputSystem_InputActionRebindingExtensions_ApplyBindingOverride_UnityEngine_InputSystem_InputAction_UnityEngine_InputSystem_InputBinding_" class="xref">InputActionRebindingExtensions.ApplyBindingOverride(InputAction, InputBinding)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionRebindingExtensions.html#UnityEngine_InputSystem_InputActionRebindingExtensions_ApplyBindingOverridesOnMatchingControls_UnityEngine_InputSystem_InputAction_UnityEngine_InputSystem_InputControl_" class="xref">InputActionRebindingExtensions.ApplyBindingOverridesOnMatchingControls(InputAction, InputControl)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionRebindingExtensions.html#UnityEngine_InputSystem_InputActionRebindingExtensions_ApplyParameterOverride_UnityEngine_InputSystem_InputAction_System_String_UnityEngine_InputSystem_Utilities_PrimitiveValue_System_Int32_" class="xref">InputActionRebindingExtensions.ApplyParameterOverride(InputAction, string, PrimitiveValue, int)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionRebindingExtensions.html#UnityEngine_InputSystem_InputActionRebindingExtensions_ApplyParameterOverride_UnityEngine_InputSystem_InputAction_System_String_UnityEngine_InputSystem_Utilities_PrimitiveValue_UnityEngine_InputSystem_InputBinding_" class="xref">InputActionRebindingExtensions.ApplyParameterOverride(InputAction, string, PrimitiveValue, InputBinding)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionRebindingExtensions.html#UnityEngine_InputSystem_InputActionRebindingExtensions_ApplyParameterOverride__2_UnityEngine_InputSystem_InputAction_System_Linq_Expressions_Expression_System_Func___0___1_____1_UnityEngine_InputSystem_InputBinding_" class="xref">InputActionRebindingExtensions.ApplyParameterOverride&lt;TObject, TValue&gt;(InputAction, Expression&lt;Func&lt;TObject, TValue&gt;&gt;, TValue, InputBinding)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionRebindingExtensions.html#UnityEngine_InputSystem_InputActionRebindingExtensions_GetBindingDisplayString_UnityEngine_InputSystem_InputAction_System_Int32_System_String__System_String__UnityEngine_InputSystem_InputBinding_DisplayStringOptions_" class="xref">InputActionRebindingExtensions.GetBindingDisplayString(InputAction, int, out string, out string, InputBinding.DisplayStringOptions)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionRebindingExtensions.html#UnityEngine_InputSystem_InputActionRebindingExtensions_GetBindingDisplayString_UnityEngine_InputSystem_InputAction_System_Int32_UnityEngine_InputSystem_InputBinding_DisplayStringOptions_" class="xref">InputActionRebindingExtensions.GetBindingDisplayString(InputAction, int, InputBinding.DisplayStringOptions)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionRebindingExtensions.html#UnityEngine_InputSystem_InputActionRebindingExtensions_GetBindingDisplayString_UnityEngine_InputSystem_InputAction_UnityEngine_InputSystem_InputBinding_UnityEngine_InputSystem_InputBinding_DisplayStringOptions_" class="xref">InputActionRebindingExtensions.GetBindingDisplayString(InputAction, InputBinding, InputBinding.DisplayStringOptions)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionRebindingExtensions.html#UnityEngine_InputSystem_InputActionRebindingExtensions_GetBindingDisplayString_UnityEngine_InputSystem_InputAction_UnityEngine_InputSystem_InputBinding_DisplayStringOptions_System_String_" class="xref">InputActionRebindingExtensions.GetBindingDisplayString(InputAction, InputBinding.DisplayStringOptions, string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionRebindingExtensions.html#UnityEngine_InputSystem_InputActionRebindingExtensions_GetBindingForControl_UnityEngine_InputSystem_InputAction_UnityEngine_InputSystem_InputControl_" class="xref">InputActionRebindingExtensions.GetBindingForControl(InputAction, InputControl)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionRebindingExtensions.html#UnityEngine_InputSystem_InputActionRebindingExtensions_GetBindingIndex_UnityEngine_InputSystem_InputAction_System_String_System_String_" class="xref">InputActionRebindingExtensions.GetBindingIndex(InputAction, string, string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionRebindingExtensions.html#UnityEngine_InputSystem_InputActionRebindingExtensions_GetBindingIndex_UnityEngine_InputSystem_InputAction_UnityEngine_InputSystem_InputBinding_" class="xref">InputActionRebindingExtensions.GetBindingIndex(InputAction, InputBinding)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionRebindingExtensions.html#UnityEngine_InputSystem_InputActionRebindingExtensions_GetBindingIndexForControl_UnityEngine_InputSystem_InputAction_UnityEngine_InputSystem_InputControl_" class="xref">InputActionRebindingExtensions.GetBindingIndexForControl(InputAction, InputControl)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionRebindingExtensions.html#UnityEngine_InputSystem_InputActionRebindingExtensions_GetParameterValue_UnityEngine_InputSystem_InputAction_System_String_System_Int32_" class="xref">InputActionRebindingExtensions.GetParameterValue(InputAction, string, int)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionRebindingExtensions.html#UnityEngine_InputSystem_InputActionRebindingExtensions_GetParameterValue_UnityEngine_InputSystem_InputAction_System_String_UnityEngine_InputSystem_InputBinding_" class="xref">InputActionRebindingExtensions.GetParameterValue(InputAction, string, InputBinding)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionRebindingExtensions.html#UnityEngine_InputSystem_InputActionRebindingExtensions_GetParameterValue__2_UnityEngine_InputSystem_InputAction_System_Linq_Expressions_Expression_System_Func___0___1___UnityEngine_InputSystem_InputBinding_" class="xref">InputActionRebindingExtensions.GetParameterValue&lt;TObject, TValue&gt;(InputAction, Expression&lt;Func&lt;TObject, TValue&gt;&gt;, InputBinding)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionRebindingExtensions.html#UnityEngine_InputSystem_InputActionRebindingExtensions_LoadBindingOverridesFromJson_UnityEngine_InputSystem_InputAction_System_String_System_Boolean_" class="xref">InputActionRebindingExtensions.LoadBindingOverridesFromJson(InputAction, string, bool)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionRebindingExtensions.html#UnityEngine_InputSystem_InputActionRebindingExtensions_PerformInteractiveRebinding_UnityEngine_InputSystem_InputAction_System_Int32_" class="xref">InputActionRebindingExtensions.PerformInteractiveRebinding(InputAction, int)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionRebindingExtensions.html#UnityEngine_InputSystem_InputActionRebindingExtensions_RemoveAllBindingOverrides_UnityEngine_InputSystem_InputAction_" class="xref">InputActionRebindingExtensions.RemoveAllBindingOverrides(InputAction)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionRebindingExtensions.html#UnityEngine_InputSystem_InputActionRebindingExtensions_RemoveBindingOverride_UnityEngine_InputSystem_InputAction_System_Int32_" class="xref">InputActionRebindingExtensions.RemoveBindingOverride(InputAction, int)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionRebindingExtensions.html#UnityEngine_InputSystem_InputActionRebindingExtensions_RemoveBindingOverride_UnityEngine_InputSystem_InputAction_UnityEngine_InputSystem_InputBinding_" class="xref">InputActionRebindingExtensions.RemoveBindingOverride(InputAction, InputBinding)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionRebindingExtensions.html#UnityEngine_InputSystem_InputActionRebindingExtensions_SaveBindingOverridesAsJson_UnityEngine_InputSystem_InputAction_" class="xref">InputActionRebindingExtensions.SaveBindingOverridesAsJson(InputAction)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionSetupExtensions.html#UnityEngine_InputSystem_InputActionSetupExtensions_AddBinding_UnityEngine_InputSystem_InputAction_System_String_System_String_System_String_System_String_" class="xref">InputActionSetupExtensions.AddBinding(InputAction, string, string, string, string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionSetupExtensions.html#UnityEngine_InputSystem_InputActionSetupExtensions_AddBinding_UnityEngine_InputSystem_InputAction_UnityEngine_InputSystem_InputBinding_" class="xref">InputActionSetupExtensions.AddBinding(InputAction, InputBinding)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionSetupExtensions.html#UnityEngine_InputSystem_InputActionSetupExtensions_AddBinding_UnityEngine_InputSystem_InputAction_UnityEngine_InputSystem_InputControl_" class="xref">InputActionSetupExtensions.AddBinding(InputAction, InputControl)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionSetupExtensions.html#UnityEngine_InputSystem_InputActionSetupExtensions_AddCompositeBinding_UnityEngine_InputSystem_InputAction_System_String_System_String_System_String_" class="xref">InputActionSetupExtensions.AddCompositeBinding(InputAction, string, string, string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionSetupExtensions.html#UnityEngine_InputSystem_InputActionSetupExtensions_ChangeBinding_UnityEngine_InputSystem_InputAction_System_Int32_" class="xref">InputActionSetupExtensions.ChangeBinding(InputAction, int)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionSetupExtensions.html#UnityEngine_InputSystem_InputActionSetupExtensions_ChangeBinding_UnityEngine_InputSystem_InputAction_System_String_" class="xref">InputActionSetupExtensions.ChangeBinding(InputAction, string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionSetupExtensions.html#UnityEngine_InputSystem_InputActionSetupExtensions_ChangeBinding_UnityEngine_InputSystem_InputAction_UnityEngine_InputSystem_InputBinding_" class="xref">InputActionSetupExtensions.ChangeBinding(InputAction, InputBinding)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionSetupExtensions.html#UnityEngine_InputSystem_InputActionSetupExtensions_ChangeBindingWithGroup_UnityEngine_InputSystem_InputAction_System_String_" class="xref">InputActionSetupExtensions.ChangeBindingWithGroup(InputAction, string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionSetupExtensions.html#UnityEngine_InputSystem_InputActionSetupExtensions_ChangeBindingWithId_UnityEngine_InputSystem_InputAction_System_Guid_" class="xref">InputActionSetupExtensions.ChangeBindingWithId(InputAction, Guid)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionSetupExtensions.html#UnityEngine_InputSystem_InputActionSetupExtensions_ChangeBindingWithId_UnityEngine_InputSystem_InputAction_System_String_" class="xref">InputActionSetupExtensions.ChangeBindingWithId(InputAction, string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionSetupExtensions.html#UnityEngine_InputSystem_InputActionSetupExtensions_ChangeBindingWithPath_UnityEngine_InputSystem_InputAction_System_String_" class="xref">InputActionSetupExtensions.ChangeBindingWithPath(InputAction, string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionSetupExtensions.html#UnityEngine_InputSystem_InputActionSetupExtensions_ChangeCompositeBinding_UnityEngine_InputSystem_InputAction_System_String_" class="xref">InputActionSetupExtensions.ChangeCompositeBinding(InputAction, string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionSetupExtensions.html#UnityEngine_InputSystem_InputActionSetupExtensions_RemoveAction_UnityEngine_InputSystem_InputAction_" class="xref">InputActionSetupExtensions.RemoveAction(InputAction)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionSetupExtensions.html#UnityEngine_InputSystem_InputActionSetupExtensions_Rename_UnityEngine_InputSystem_InputAction_System_String_" class="xref">InputActionSetupExtensions.Rename(InputAction, string)</a>

### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref">InputActionMap</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionAsset.html" class="xref">InputActionAsset</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBinding.html" class="xref">InputBinding</a>
