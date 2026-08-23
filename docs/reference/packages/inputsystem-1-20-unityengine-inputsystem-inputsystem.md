---
title: "InputSystem static API"
page_title: "Class InputSystem
 | Input System | 1.20.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Class InputSystem

This is the central hub for the input system.

##### Inheritance

<a href="https://learn.microsoft.com/dotnet/api/system.object" class="xref">object</a>

<span class="xref">InputSystem</span>

###### **Namespace**: <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.html" class="xref">UnityEngine</a>.<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.html" class="xref">InputSystem</a>

###### **Assembly**: Unity.InputSystem.dll

##### Syntax

``` lang-csharp
public static class InputSystem
```

##### **Remarks**

This class has the central APIs for working with the input system. You can manage devices available in the system (<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_AddDevice__1_System_String_" class="xref">AddDevice&lt;TDevice&gt;(string)</a>, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_devices" class="xref">devices</a>, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_onDeviceChange" class="xref">onDeviceChange</a> and related APIs) or extend the input system with custom functionality (<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RegisterLayout__1_System_String_System_Nullable_UnityEngine_InputSystem_Layouts_InputDeviceMatcher__" class="xref">RegisterLayout&lt;T&gt;(string, InputDeviceMatcher?)</a>, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RegisterInteraction__1_System_String_" class="xref">RegisterInteraction&lt;T&gt;(string)</a>, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RegisterProcessor__1_System_String_" class="xref">RegisterProcessor&lt;T&gt;(string)</a>, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RegisterBindingComposite__1_System_String_" class="xref">RegisterBindingComposite&lt;T&gt;(string)</a>, and related APIs).

To control haptics globally, you can use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_PauseHaptics" class="xref">PauseHaptics()</a>, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_ResumeHaptics" class="xref">ResumeHaptics()</a>, and <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_ResetHaptics" class="xref">ResetHaptics()</a>.

To enable and disable individual devices (such as <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Sensor.html" class="xref">Sensor</a> devices), you can use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_EnableDevice_UnityEngine_InputSystem_InputDevice_" class="xref">EnableDevice(InputDevice)</a> and <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_DisableDevice_UnityEngine_InputSystem_InputDevice_System_Boolean_" class="xref">DisableDevice(InputDevice, bool)</a>.

The input system is initialized as part of Unity starting up. It is generally safe to call the APIs here from any of Unity's script callbacks.

Note that, like most Unity APIs, most of the properties and methods in this API can only be called on the main thread. However, select APIs like <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_QueueEvent_UnityEngine_InputSystem_LowLevel_InputEventPtr_" class="xref">QueueEvent(InputEventPtr)</a> can be called from threads. Where this is the case, it is stated in the documentation.

### Properties

<span id="UnityEngine_InputSystem_InputSystem_actions_" uid="UnityEngine.InputSystem.InputSystem.actions*"></span>

#### actions

An input action asset (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionAsset.html" class="xref">InputActionAsset</a>) which is always available if assigned in Input System Package settings in Edit, Project Settings, Input System Package in editor.

##### Declaration

``` lang-csharp
public static InputActionAsset actions 
```

##### Property Value

| Type                                                                                                                                                       | Description |
|------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionAsset.html" class="xref">InputActionAsset</a> |             |

##### Remarks

Project-wide actions may only be assigned in Edit Mode and any attempt to change this property in Play Mode will result in an `System.Exception` being thrown. A default set of actions and action maps are installed and enabled by default on every project that enables Project-wide Input Actions by assigning a project-wide asset in Project Settings. These actions and their bindings may be modified in the Project Settings.

All actions in the associated `InputActionAsset` will be automatically enabled when entering Play Mode and automatically disabled when exiting Play Mode. The asset associated with this property will be included in a Player build as a preloaded asset.

Note that attempting to assign a non-persisted `InputActionAsset` to this property will result in `ArgumentException` being thrown.

##### Examples

``` lang-csharp
 public class MyScript : MonoBehaviour

    }
}
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionAsset.html" class="xref">InputActionAsset</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref">InputActionMap</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html" class="xref">InputAction</a>

<span id="UnityEngine_InputSystem_InputSystem_devices_" uid="UnityEngine.InputSystem.InputSystem.devices*"></span>

#### devices

The list of currently connected devices.

##### Declaration

``` lang-csharp
public static ReadOnlyArray<InputDevice> devices 
```

##### Property Value

| Type                                                                                                                                                                                                                                                                                                                 | Description                  |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Utilities.ReadOnlyArray-1.html" class="xref">ReadOnlyArray</a>\<<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a>\> | Currently connected devices. |

##### Remarks

Note that accessing this property does not allocate. It gives read-only access directly to the system's internal array of devices.

The value returned by this property should not be held on to. When the device setup in the system changes, any value previously returned by this property may become invalid. Query the property directly whenever you need it.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_AddDevice__1_System_String_" class="xref">AddDevice&lt;TDevice&gt;(string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RemoveDevice_UnityEngine_InputSystem_InputDevice_" class="xref">RemoveDevice(InputDevice)</a>

<span id="UnityEngine_InputSystem_InputSystem_disconnectedDevices_" uid="UnityEngine.InputSystem.InputSystem.disconnectedDevices*"></span>

#### disconnectedDevices

Devices that have been disconnected but are retained by the input system in case they are plugged back in.

##### Declaration

``` lang-csharp
public static ReadOnlyArray<InputDevice> disconnectedDevices 
```

##### Property Value

| Type                                                                                                                                                                                                                                                                                                                 | Description                                                                           |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Utilities.ReadOnlyArray-1.html" class="xref">ReadOnlyArray</a>\<<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a>\> | Devices that have been retained by the input system in case they are plugged back in. |

##### Remarks

During gameplay it is undesirable to have the system allocate and release managed memory as devices are unplugged and plugged back in as it would ultimately lead to GC spikes during gameplay. To avoid that, input devices that have been reported by the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.IInputRuntime.html" class="xref">runtime</a> and are removed through <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.DeviceRemoveEvent.html" class="xref">events</a> are retained by the system and then reused if the device is plugged back in.

Note that the devices moved to disconnected status will still see a <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDeviceChange.html#UnityEngine_InputSystem_InputDeviceChange_Removed" class="xref">Removed</a> notification and a <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDeviceChange.html#UnityEngine_InputSystem_InputDeviceChange_Added" class="xref">Added</a> notification when plugged back in.

To determine if a newly discovered device is one we have seen before, the system uses a simple approach of comparing <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputDeviceDescription.html" class="xref">device descriptions</a>. Note that there can be errors and a device may be incorrectly classified as <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDeviceChange.html#UnityEngine_InputSystem_InputDeviceChange_Reconnected" class="xref">Reconnected</a> when in fact it is a different device from before. The problem is that based on information made available by platforms, it can be inherently difficult to determine whether a device is indeed the very same one.

For example, it is often not possible to determine with 100% certainty whether an identical looking device to one we've previously seen on a different USB port is indeed the very same device. OSs will usually reattach a USB device to its previous instance if it is plugged into the same USB port but create a new instance of the same device is plugged into a different port.

For devices that do relay their <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputDeviceDescription.html#UnityEngine_InputSystem_Layouts_InputDeviceDescription_serial" class="xref">serials</a> the matching is reliable.

The list can be purged by calling <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_FlushDisconnectedDevices" class="xref">FlushDisconnectedDevices()</a>. Doing so, will release all reference we hold to the devices or any controls inside of them and allow the devices to be reclaimed by the garbage collector.

Note that if you call <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RemoveDevice_UnityEngine_InputSystem_InputDevice_" class="xref">RemoveDevice(InputDevice)</a> explicitly, the given device is not retained by the input system and will not appear on this list.

Also note that devices on this list will be lost when domain reloads happen in the editor (i.e. on script recompilation and when entering play mode).

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_FlushDisconnectedDevices" class="xref">FlushDisconnectedDevices()</a>

<span id="UnityEngine_InputSystem_InputSystem_metrics_" uid="UnityEngine.InputSystem.InputSystem.metrics*"></span>

#### metrics

Get various up-to-date metrics about the input system.

##### Declaration

``` lang-csharp
public static InputMetrics metrics 
```

##### Property Value

| Type                                                                                                                                                        | Description                                  |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.InputMetrics.html" class="xref">InputMetrics</a> | Up-to-date metrics on input system activity. |

<span id="UnityEngine_InputSystem_InputSystem_onAnyButtonPress_" uid="UnityEngine.InputSystem.InputSystem.onAnyButtonPress*"></span>

#### onAnyButtonPress

Listen through <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_onEvent" class="xref">onEvent</a> for a button to be pressed.

##### Declaration

``` lang-csharp
public static IObservable<InputControl> onAnyButtonPress 
```

##### Property Value

| Type                                                                                                                                                                                                                                                     | Description |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.iobservable-1" class="xref">IObservable</a>\<<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html" class="xref">InputControl</a>\> |             |

##### Remarks

The listener will get triggered whenever a <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Controls.ButtonControl.html" class="xref">ButtonControl</a> on any device in the list of <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_devices" class="xref">devices</a> goes from not being pressed to being pressed.

``` lang-csharp
// Response to the first button press. Calls our delegate
// and then immediately stops listening.
InputSystem.onAnyButtonPress
    .CallOnce(ctrl => Debug.Log($"Button {ctrl} was pressed"));
```

Note that the listener will get triggered from the first button that was found in a pressed state in a given <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.InputEvent.html" class="xref">InputEvent</a>. If multiple buttons are pressed in an event, the listener will not get triggered multiple times. To get all button presses in an event, use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControlExtensions.html#UnityEngine_InputSystem_InputControlExtensions_GetAllButtonPresses_UnityEngine_InputSystem_LowLevel_InputEventPtr_System_Single_System_Boolean_" class="xref">GetAllButtonPresses(InputEventPtr, float, bool)</a> and instead listen directly through <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_onEvent" class="xref">onEvent</a>.

``` lang-csharp
InputSystem.onEvent
    .Where(e => e.HasButtonPress())
    .CallOnce(eventPtr =>
    {
        foreach (var button in l.eventPtr.GetAllButtonPresses())
            Debug.Log($"Button {button} was pressed");
    });
```

There is a certain overhead to listening for button presses so it is best to have listeners installed only while the information is actually needed.

``` lang-csharp
// Script that will spawn a new player when a button on a device is pressed.
public class JoinPlayerOnPress : MonoBehaviour

// When disabled, we remove our button press listener.
void OnDisable()

void OnButtonPressed(InputControl button)

```

}

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Controls.ButtonControl.html#UnityEngine_InputSystem_Controls_ButtonControl_isPressed" class="xref">isPressed</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_onEvent" class="xref">onEvent</a>

<span id="UnityEngine_InputSystem_InputSystem_onEvent_" uid="UnityEngine.InputSystem.InputSystem.onEvent*"></span>

#### onEvent

Called during <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_Update" class="xref">Update()</a> for each event that is processed.

##### Declaration

``` lang-csharp
public static InputEventListener onEvent 
```

##### Property Value

| Type                                                                                                                                                                    | Description |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.InputEventListener.html" class="xref">InputEventListener</a> |             |

##### Remarks

Every time the input system updates (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.html#UnityEngine_InputSystem_InputSettings_updateMode" class="xref">updateMode</a> or <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_Update" class="xref">Update()</a> for details about when and how this happens), it flushes all events from the internal event buffer.

As the Input System reads events from the buffer one by one, it will trigger this callback for each event which originates from a recognized device, before then proceeding to process the event. If any of the callbacks sets <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.InputEvent.html#UnityEngine_InputSystem_LowLevel_InputEvent_handled" class="xref">handled</a> to true, the event will be skipped and ignored.

Note that a device that is disabled (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html#UnityEngine_InputSystem_InputDevice_enabled" class="xref">enabled</a>) may still get this event signalled for it. A <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.DisableDeviceCommand.html" class="xref">DisableDeviceCommand</a> will usually be sent to backends when a device is disabled but a backend may or may not respond to the command and thus may or may not keep sending events for the device.

Note that the Input System does NOT sort events by timestamps (<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.InputEvent.html#UnityEngine_InputSystem_LowLevel_InputEvent_time" class="xref">time</a>). Instead, they are consumed in the order they are produced. This means that they will also surface on this callback in that order.

``` lang-csharp
// Treat left+right mouse button as middle mouse button.
// (Note: This example is more for demonstrative purposes; it isn't necessarily a good use case)
InputSystem.onEvent +=
   (eventPtr, device) =>
   {
       // Only deal with state events.
       if (!eventPtr.IsA<StateEvent>())
           return;
   if (!(device is Mouse mouse))
       return;

   mouse.leftButton.ReadValueFromEvent(eventPtr, out var lmbDown);
   mouse.rightButton.ReadValueFromEvent(eventPtr, out var rmbDown);

   if (lmbDown > 0 && rmbDown > 0)
       mouse.middleButton.WriteValueIntoEvent(1f, eventPtr);
```

};

The property returns an <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.InputEventListener.html" class="xref">InputEventListener</a> struct that, beyond adding and removing callbacks, can be used to flexibly listen in on the event stream.

``` lang-csharp
// Listen for mouse events.
InputSystem.onEvent
    .ForDevice(Mouse.current)
    .Call(e => Debug.Log("Mouse event"));
```

If you are looking for a way to capture events, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.InputEventTrace.html" class="xref">InputEventTrace</a> may be of interest and an alternative to directly hooking into this event.

If you are looking to monitor changes to specific input controls, state change monitors (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.InputState.html#UnityEngine_InputSystem_LowLevel_InputState_AddChangeMonitor_UnityEngine_InputSystem_InputControl_UnityEngine_InputSystem_LowLevel_IInputStateChangeMonitor_System_Int64_System_UInt32_" class="xref">AddChangeMonitor(InputControl, IInputStateChangeMonitor, long, uint)</a> are usually a more efficient and convenient way to set this up.

##### Exceptions

| Type                                                                                                                 | Condition                     |
|----------------------------------------------------------------------------------------------------------------------|-------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentnullexception" class="xref">ArgumentNullException</a> | Delegate reference is `null`. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_QueueEvent_UnityEngine_InputSystem_LowLevel_InputEventPtr_" class="xref">QueueEvent(InputEventPtr)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.InputEvent.html" class="xref">InputEvent</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_Update" class="xref">Update()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.html#UnityEngine_InputSystem_InputSettings_updateMode" class="xref">updateMode</a>

<span id="UnityEngine_InputSystem_InputSystem_pollingFrequency_" uid="UnityEngine.InputSystem.InputSystem.pollingFrequency*"></span>

#### pollingFrequency

Frequency at which devices that need polling are being queried in the background.

##### Declaration

``` lang-csharp
public static float pollingFrequency 
```

##### Property Value

| Type                                                                                  | Description                                |
|---------------------------------------------------------------------------------------|--------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.single" class="xref">float</a> | Polled device sampling frequency in Hertz. |

##### Remarks

Input data is gathered from platform APIs either as events or polled periodically.

In the former case, where we get input as events, the platform is responsible for monitoring input devices and sending their state changes which the Unity runtime receives and queues as <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.InputEvent.html" class="xref">InputEvent</a>s. This form of input collection usually happens on a system-specific thread (which may be Unity's main thread) as part of how the Unity player loop operates. In most cases, this means that this form of input will invariably get picked up once per frame.

In the latter case, where input has to be explicitly polled from the system, the Unity runtime will periodically sample the state of input devices and send it off as input events. Wherever possible, this happens in the background at a fixed frequency on a dedicated thread. The `pollingFrequency` property controls the rate at which this sampling happens.

The unit is Hertz. A value of 120, for example, means that devices are sampled 120 times per second.

The default polling frequency is at least 60 Hz or what is suitable for the target device.

For devices that are polled, the frequency setting will directly translate to changes in the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.InputEvent.html#UnityEngine_InputSystem_LowLevel_InputEvent_time" class="xref">time</a> patterns. At 60 Hz, for example, timestamps for a specific, polled device will be spaced at roughly 1/60th of a second apart.

Note that it depends on the platform which devices are polled (if any). On Win32, for example, only XInput gamepads are polled.

Also note that the polling frequency applies to all devices that are polled. It is not possible to set polling frequency on a per-device basis.

<span id="UnityEngine_InputSystem_InputSystem_remoting_" uid="UnityEngine.InputSystem.InputSystem.remoting*"></span>

#### remoting

The local InputRemoting instance which can mirror local input to a remote input system or can make input in a remote system available locally.

##### Declaration

``` lang-csharp
public static InputRemoting remoting 
```

##### Property Value

| Type                                                                                                                                                 | Description |
|------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputRemoting.html" class="xref">InputRemoting</a> |             |

##### Remarks

In the editor, this is always initialized. In players, this will be null if remoting is disabled (which it is by default in release players).

<span id="UnityEngine_InputSystem_InputSystem_settings_" uid="UnityEngine.InputSystem.InputSystem.settings*"></span>

#### settings

The current configuration of the input system.

##### Declaration

``` lang-csharp
public static InputSettings settings 
```

##### Property Value

| Type                                                                                                                                                 | Description                                       |
|------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.html" class="xref">InputSettings</a> | Global configuration object for the input system. |

##### Remarks

The input system can be configured on a per-project basis. Settings can either be created and installed on the fly or persisted as assets in the project.

##### Exceptions

| Type                                                                                                                 | Condition                                |
|----------------------------------------------------------------------------------------------------------------------|------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentnullexception" class="xref">ArgumentNullException</a> | Value is null when setting the property. |

<span id="UnityEngine_InputSystem_InputSystem_version_" uid="UnityEngine.InputSystem.InputSystem.version*"></span>

#### version

The current version of the input system package.

##### Declaration

``` lang-csharp
public static Version version 
```

##### Property Value

| Type                                                                                     | Description                          |
|------------------------------------------------------------------------------------------|--------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.version" class="xref">Version</a> | Current version of the input system. |

### Methods

<span id="UnityEngine_InputSystem_InputSystem_AddDevice_" uid="UnityEngine.InputSystem.InputSystem.AddDevice*"></span>

#### AddDevice(string, string, string)

Add a new device by instantiating the given device layout.

##### Declaration

``` lang-csharp
public static InputDevice AddDevice(string layout, string name = null, string variants = null)
```

##### Parameters

| Type                                                                                   | Name                                        | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
|----------------------------------------------------------------------------------------|---------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> | <span class="parametername">layout</span>   | Name of the layout to instantiate. Must be a device layout. Note that layout names are case-insensitive.                                                                                                                                                                                                                                                                                                                                                          |
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> | <span class="parametername">name</span>     | Name to assign to the device. If null, the layout's display name (<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputControlLayout.html#UnityEngine_InputSystem_Layouts_InputControlLayout_displayName" class="xref">displayName</a> is used instead. Note that device names are made unique automatically by the system by appending numbers to them (e.g. "gamepad", "gamepad1", "gamepad2", etc.). |
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> | <span class="parametername">variants</span> | Semicolon-separated list of layout variants to use for the device.                                                                                                                                                                                                                                                                                                                                                                                                |

##### Returns

| Type                                                                                                                                             | Description                     |
|--------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a> | The newly created input device. |

##### Remarks

The device will be added to the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_devices" class="xref">devices</a> list and a notification on <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_onDeviceChange" class="xref">onDeviceChange</a> will be triggered.

Note that adding a device to the system will allocate and also create garbage on the GC heap.

``` lang-csharp
// This is one way to instantiate the "Gamepad" layout.
InputSystem.AddDevice("Gamepad");
// In this case, because the "Gamepad" layout is based on the Gamepad
// class, we can also do this instead:
InputSystem.AddDevice<Gamepad>();
```

##### Exceptions

| Type                                                                                                                 | Condition                    |
|----------------------------------------------------------------------------------------------------------------------|------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentnullexception" class="xref">ArgumentNullException</a> | `layout` is `null` or empty. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_AddDevice__1_System_String_" class="xref">AddDevice&lt;TDevice&gt;(string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RemoveDevice_UnityEngine_InputSystem_InputDevice_" class="xref">RemoveDevice(InputDevice)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_onDeviceChange" class="xref">onDeviceChange</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDeviceChange.html#UnityEngine_InputSystem_InputDeviceChange_Added" class="xref">Added</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_devices" class="xref">devices</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RegisterLayout_System_Type_System_String_System_Nullable_UnityEngine_InputSystem_Layouts_InputDeviceMatcher__" class="xref">RegisterLayout(Type, string, InputDeviceMatcher?)</a>

<span id="UnityEngine_InputSystem_InputSystem_AddDevice_" uid="UnityEngine.InputSystem.InputSystem.AddDevice*"></span>

#### AddDevice(InputDevice)

Add the given device back to the system.

##### Declaration

``` lang-csharp
public static void AddDevice(InputDevice device)
```

##### Parameters

| Type                                                                                                                                             | Name                                      | Description                                                                                                                                                                                                                                                                                                |
|--------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a> | <span class="parametername">device</span> | An input device. If the device is currently already added to the system (i.e. is in <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_devices" class="xref">devices</a>), the method will do nothing. |

##### Remarks

This can be used when a device has been manually removed with <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RemoveDevice_UnityEngine_InputSystem_InputDevice_" class="xref">RemoveDevice(InputDevice)</a>.

The device will be added to the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_devices" class="xref">devices</a> list and a notification on <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_onDeviceChange" class="xref">onDeviceChange</a> will be triggered.

It may be tempting to do the following but this will not work:

``` lang-csharp
// This will *NOT* work.
var device = new Gamepad();
InputSystem.AddDevice(device);
```

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a>s, like <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html" class="xref">InputControl</a>s in general, cannot simply be instantiated with `new` but must be created by the input system instead.

##### Exceptions

| Type                                                                                                                 | Condition |
|----------------------------------------------------------------------------------------------------------------------|-----------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentnullexception" class="xref">ArgumentNullException</a> |           |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RemoveDevice_UnityEngine_InputSystem_InputDevice_" class="xref">RemoveDevice(InputDevice)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_AddDevice__1_System_String_" class="xref">AddDevice&lt;TDevice&gt;(string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_devices" class="xref">devices</a>

<span id="UnityEngine_InputSystem_InputSystem_AddDevice_" uid="UnityEngine.InputSystem.InputSystem.AddDevice*"></span>

#### AddDevice(InputDeviceDescription)

Tell the input system that a new device has become available.

##### Declaration

``` lang-csharp
public static InputDevice AddDevice(InputDeviceDescription description)
```

##### Parameters

| Type                                                                                                                                                                           | Name                                           | Description                      |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------|----------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputDeviceDescription.html" class="xref">InputDeviceDescription</a> | <span class="parametername">description</span> | Description of the input device. |

##### Returns

| Type                                                                                                                                             | Description                                                                                                                                                                                                                               |
|--------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a> | The newly created device that has been added to <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_devices" class="xref">devices</a>. |

##### Remarks

This method is different from methods such as <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_AddDevice_System_String_System_String_System_String_" class="xref">AddDevice(string, string, string)</a> or <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_AddDevice__1_System_String_" class="xref">AddDevice&lt;TDevice&gt;(string)</a> in that it employs the usual matching process the same way that it happens when the Unity runtime reports an input device.

In particular, the same procedure described in the documentation for <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_onFindLayoutForDevice" class="xref">onFindLayoutForDevice</a> is employed where all registered <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputDeviceMatcher.html" class="xref">InputDeviceMatcher</a>s are matched against the supplied device description and the most suitable match determines the layout to use. This in turn is run through <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_onFindLayoutForDevice" class="xref">onFindLayoutForDevice</a> to determine the final layout to use.

If no suitable layout can be found, the method throws `ArgumentException`.

``` lang-csharp
InputSystem.AddDevice(
    new InputDeviceDescription
    {
        interfaceName = "Custom",
        product = "Product"
    });
```

##### Exceptions

| Type                                                                                                         | Condition                                                                                                 |
|--------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentexception" class="xref">ArgumentException</a> | The given `description` is empty -or- no layout can be found that matches the given device `description`. |

<span id="UnityEngine_InputSystem_InputSystem_AddDeviceUsage_" uid="UnityEngine.InputSystem.InputSystem.AddDeviceUsage*"></span>

#### AddDeviceUsage(InputDevice, string)

Add a usage tag to the given device.

##### Declaration

``` lang-csharp
public static void AddDeviceUsage(InputDevice device, string usage)
```

##### Parameters

| Type                                                                                                                                             | Name                                      | Description                     |
|--------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------|---------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a> | <span class="parametername">device</span> | Device to add the usage to.     |
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a>                                                           | <span class="parametername">usage</span>  | New usage to add to the device. |

##### Remarks

Usages allow to "tag" a specific device such that the tag can then be used in lookups and bindings. A common use is for identifying the handedness of an <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.XR.XRController.html" class="xref">XRController</a> but the usages can be arbitrary strings.

This method adds a new usage to the device's set of usages. If the device already has the given usage, the method does nothing. To instead set the device's usages to a single one, use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_SetDeviceUsage_UnityEngine_InputSystem_InputDevice_System_String_" class="xref">SetDeviceUsage(InputDevice, string)</a>. To remove usages from a device, call <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RemoveDeviceUsage_UnityEngine_InputSystem_InputDevice_System_String_" class="xref">RemoveDeviceUsage(InputDevice, string)</a>.

The set of usages a device has can be queried with <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html#UnityEngine_InputSystem_InputControl_usages" class="xref">usages</a> (a device is an <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html" class="xref">InputControl</a> and thus, like controls, has an associated set of usages).

If the set of usages on the device changes as a result of calling this method, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_onDeviceChange" class="xref">onDeviceChange</a> will be triggered with <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDeviceChange.html#UnityEngine_InputSystem_InputDeviceChange_UsageChanged" class="xref">UsageChanged</a>.

##### Exceptions

| Type                                                                                                                 | Condition                 |
|----------------------------------------------------------------------------------------------------------------------|---------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentnullexception" class="xref">ArgumentNullException</a> | `device` is null.         |
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentexception" class="xref">ArgumentException</a>         | `usage` is null or empty. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html#UnityEngine_InputSystem_InputControl_usages" class="xref">usages</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_SetDeviceUsage_UnityEngine_InputSystem_InputDevice_System_String_" class="xref">SetDeviceUsage(InputDevice, string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RemoveDeviceUsage_UnityEngine_InputSystem_InputDevice_System_String_" class="xref">RemoveDeviceUsage(InputDevice, string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.CommonUsages.html" class="xref">CommonUsages</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDeviceChange.html#UnityEngine_InputSystem_InputDeviceChange_UsageChanged" class="xref">UsageChanged</a>

<span id="UnityEngine_InputSystem_InputSystem_AddDeviceUsage_" uid="UnityEngine.InputSystem.InputSystem.AddDeviceUsage*"></span>

#### AddDeviceUsage(InputDevice, InternedString)

Add a usage tag to the given device.

##### Declaration

``` lang-csharp
public static void AddDeviceUsage(InputDevice device, InternedString usage)
```

##### Parameters

| Type                                                                                                                                                             | Name                                      | Description                     |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------|---------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a>                 | <span class="parametername">device</span> | Device to add the usage to.     |
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Utilities.InternedString.html" class="xref">InternedString</a> | <span class="parametername">usage</span>  | New usage to add to the device. |

##### Remarks

Usages allow to "tag" a specific device such that the tag can then be used in lookups and bindings. A common use is for identifying the handedness of an <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.XR.XRController.html" class="xref">XRController</a> but the usages can be arbitrary strings.

This method adds a new usage to the device's set of usages. If the device already has the given usage, the method does nothing. To instead set the device's usages to a single one, use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_SetDeviceUsage_UnityEngine_InputSystem_InputDevice_UnityEngine_InputSystem_Utilities_InternedString_" class="xref">SetDeviceUsage(InputDevice, InternedString)</a>. To remove usages from a device, call <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RemoveDeviceUsage_UnityEngine_InputSystem_InputDevice_UnityEngine_InputSystem_Utilities_InternedString_" class="xref">RemoveDeviceUsage(InputDevice, InternedString)</a>.

The set of usages a device has can be queried with <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html#UnityEngine_InputSystem_InputControl_usages" class="xref">usages</a> (a device is an <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html" class="xref">InputControl</a> and thus, like controls, has an associated set of usages).

If the set of usages on the device changes as a result of calling this method, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_onDeviceChange" class="xref">onDeviceChange</a> will be triggered with <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDeviceChange.html#UnityEngine_InputSystem_InputDeviceChange_UsageChanged" class="xref">UsageChanged</a>.

##### Exceptions

| Type                                                                                                                 | Condition         |
|----------------------------------------------------------------------------------------------------------------------|-------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentnullexception" class="xref">ArgumentNullException</a> | `device` is null. |
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentexception" class="xref">ArgumentException</a>         | `usage` is empty. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html#UnityEngine_InputSystem_InputControl_usages" class="xref">usages</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_SetDeviceUsage_UnityEngine_InputSystem_InputDevice_UnityEngine_InputSystem_Utilities_InternedString_" class="xref">SetDeviceUsage(InputDevice, InternedString)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RemoveDeviceUsage_UnityEngine_InputSystem_InputDevice_UnityEngine_InputSystem_Utilities_InternedString_" class="xref">RemoveDeviceUsage(InputDevice, InternedString)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.CommonUsages.html" class="xref">CommonUsages</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDeviceChange.html#UnityEngine_InputSystem_InputDeviceChange_UsageChanged" class="xref">UsageChanged</a>

<span id="UnityEngine_InputSystem_InputSystem_AddDevice_" uid="UnityEngine.InputSystem.InputSystem.AddDevice*"></span>

#### AddDevice\<TDevice>(string)

Add a new device by instantiating the layout registered for type `TDevice`.

##### Declaration

``` lang-csharp
public static TDevice AddDevice<TDevice>(string name = null) where TDevice : InputDevice
```

##### Parameters

| Type                                                                                   | Name                                    | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
|----------------------------------------------------------------------------------------|-----------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> | <span class="parametername">name</span> | Name to assign to the device. If null, the layout's display name (<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputControlLayout.html#UnityEngine_InputSystem_Layouts_InputControlLayout_displayName" class="xref">displayName</a> is used instead. Note that device names are made unique automatically by the system by appending numbers to them (e.g. "gamepad", "gamepad1", "gamepad2", etc.). |

##### Returns

| Type                              | Description             |
|-----------------------------------|-------------------------|
| <span class="xref">TDevice</span> | The newly added device. |

##### Type Parameters

| Name                                       | Description            |
|--------------------------------------------|------------------------|
| <span class="parametername">TDevice</span> | Type of device to add. |

##### Remarks

The device will be added to the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_devices" class="xref">devices</a> list and a notification on <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_onDeviceChange" class="xref">onDeviceChange</a> will be triggered.

Note that adding a device to the system will allocate and also create garbage on the GC heap.

``` lang-csharp
// Add a gamepad.
InputSystem.AddDevice<Gamepad>();
```

##### Exceptions

| Type                                                                                                                         | Condition                                                                          |
|------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.invalidoperationexception" class="xref">InvalidOperationException</a> | Instantiating the layout for `TDevice` did not produce a device of type `TDevice`. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RemoveDevice_UnityEngine_InputSystem_InputDevice_" class="xref">RemoveDevice(InputDevice)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_onDeviceChange" class="xref">onDeviceChange</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDeviceChange.html#UnityEngine_InputSystem_InputDeviceChange_Added" class="xref">Added</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_devices" class="xref">devices</a>

<span id="UnityEngine_InputSystem_InputSystem_DisableAllEnabledActions_" uid="UnityEngine.InputSystem.InputSystem.DisableAllEnabledActions*"></span>

#### DisableAllEnabledActions()

Disable all actions (and implicitly all action sets) that are currently enabled.

##### Declaration

``` lang-csharp
public static void DisableAllEnabledActions()
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_ListEnabledActions" class="xref">ListEnabledActions()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine.InputSystem.InputAction.Disable" class="xref">Disable</a>()

<span id="UnityEngine_InputSystem_InputSystem_DisableDevice_" uid="UnityEngine.InputSystem.InputSystem.DisableDevice*"></span>

#### DisableDevice(InputDevice, bool)

Disable the given device, i.e. "mute" it.

##### Declaration

``` lang-csharp
public static void DisableDevice(InputDevice device, bool keepSendingEvents = false)
```

##### Parameters

<table class="table table-bordered table-striped table-condensed"><colgroup><col style="width: 33%" /><col style="width: 33%" /><col style="width: 33%" /></colgroup><thead><tr class="header"><th>Type</th><th>Name</th><th>Description</th></tr></thead><tbody><tr class="odd"><td><a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a></td><td><span class="parametername">device</span></td><td><p>Device to disable. If already disabled, the method will do nothing.</p></td></tr><tr class="even"><td><a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">bool</a></td><td><span class="parametername">keepSendingEvents</span></td><td><p>If true, no <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.DisableDeviceCommand.html" class="xref">DisableDeviceCommand</a> will be sent for the device. This means that the backend sending input events will not be notified about the device being disabled and will thus keep sending events. This can be useful when input is being rerouted from one device to another. For example, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.EnhancedTouch.TouchSimulation.html" class="xref">TouchSimulation</a> uses this to disable the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Mouse.html" class="xref">Mouse</a> while redirecting its events to input on a <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Touchscreen.html" class="xref">Touchscreen</a>.<br />
<br />
This parameter is false by default.</p></td></tr></tbody></table>

##### Remarks

A disabled device will not receive input and will remain in its default state. It will remain present in the system but without actually feeding input into it.

Disabling devices is most useful for <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Sensor.html" class="xref">Sensor</a> devices on battery-powered platforms where having a sensor enabled will increase energy consumption. Sensors will usually start out in disabled state and can be enabled, when needed, with <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_EnableDevice_UnityEngine_InputSystem_InputDevice_" class="xref">EnableDevice(InputDevice)</a> and disabled again wth this method.

However, disabling a device can be useful in other situations, too. For example, when simulating input (say, mouse input) locally from a remote source, it can be desirable to turn off the respective local device.

To remove a device altogether, use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RemoveDevice_UnityEngine_InputSystem_InputDevice_" class="xref">RemoveDevice(InputDevice)</a> instead. This will not only silence input but remove the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a> instance from the system altogether.

##### Exceptions

| Type                                                                                                                 | Condition           |
|----------------------------------------------------------------------------------------------------------------------|---------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentnullexception" class="xref">ArgumentNullException</a> | `device` is `null`. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_EnableDevice_UnityEngine_InputSystem_InputDevice_" class="xref">EnableDevice(InputDevice)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html#UnityEngine_InputSystem_InputDevice_enabled" class="xref">enabled</a>

<span id="UnityEngine_InputSystem_InputSystem_EnableDevice_" uid="UnityEngine.InputSystem.InputSystem.EnableDevice*"></span>

#### EnableDevice(InputDevice)

(Re-)enable the given device.

##### Declaration

``` lang-csharp
public static void EnableDevice(InputDevice device)
```

##### Parameters

| Type                                                                                                                                             | Name                                      | Description                                                       |
|--------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------|-------------------------------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a> | <span class="parametername">device</span> | Device to enable. If already enabled, the method will do nothing. |

##### Remarks

This can be used after a device has been disabled with <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_DisableDevice_UnityEngine_InputSystem_InputDevice_System_Boolean_" class="xref">DisableDevice(InputDevice, bool)</a> or with devices that start out in disabled state (usually the case for all <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Sensor.html" class="xref">Sensor</a> devices).

When enabled, a device will receive input when available.

``` lang-csharp
// Enable the gyroscope, if present.
if (Gyroscope.current != null)
    InputSystem.EnableDevice(Gyroscope.current);
```

##### Exceptions

| Type                                                                                                                 | Condition           |
|----------------------------------------------------------------------------------------------------------------------|---------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentnullexception" class="xref">ArgumentNullException</a> | `device` is `null`. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_DisableDevice_UnityEngine_InputSystem_InputDevice_System_Boolean_" class="xref">DisableDevice(InputDevice, bool)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html#UnityEngine_InputSystem_InputDevice_enabled" class="xref">enabled</a>

<span id="UnityEngine_InputSystem_InputSystem_FindControl_" uid="UnityEngine.InputSystem.InputSystem.FindControl*"></span>

#### FindControl(string)

Find the first control that matches the given control path.

##### Declaration

``` lang-csharp
public static InputControl FindControl(string path)
```

##### Parameters

| Type                                                                                   | Name                                    | Description                                                                                                                                                                                                                    |
|----------------------------------------------------------------------------------------|-----------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> | <span class="parametername">path</span> | Path of a control, e.g. `"<Gamepad>/buttonSouth"`. See <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControlPath.html" class="xref">InputControlPath</a> for details. |

##### Returns

| Type                                                                                                                                               | Description                                                                    |
|----------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html" class="xref">InputControl</a> | The first control that matches the given path or `null` if no control matches. |

##### Remarks

If multiple controls match the given path, which result is considered the first is indeterminate.

``` lang-csharp
// Add gamepad.
InputSystem.AddDevice<Gamepad>();
// Look up various controls on it.
var aButton = InputSystem.FindControl("<Gamepad>/buttonSouth");
var leftStickX = InputSystem.FindControl("/leftStick/x");
var bButton = InputSystem.FindControl"/");
// This one returns the gamepad itself as devices are also controls.
var gamepad = InputSystem.FindControl("<Gamepad>");
```

##### Exceptions

| Type                                                                                                                 | Condition                  |
|----------------------------------------------------------------------------------------------------------------------|----------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentnullexception" class="xref">ArgumentNullException</a> | `path` is `null` or empty. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControlPath.html" class="xref">InputControlPath</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html#UnityEngine_InputSystem_InputControl_path" class="xref">path</a>

<span id="UnityEngine_InputSystem_InputSystem_FindControls_" uid="UnityEngine.InputSystem.InputSystem.FindControls*"></span>

#### FindControls(string)

Find all controls that match the given <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControlPath.html" class="xref">control path</a>.

##### Declaration

``` lang-csharp
public static InputControlList<InputControl> FindControls(string path)
```

##### Parameters

| Type                                                                                   | Name                                    | Description                |
|----------------------------------------------------------------------------------------|-----------------------------------------|----------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> | <span class="parametername">path</span> | Control path to search for |

##### Returns

| Type                                                                                                                                                                                                                                                                                                               | Description                                                                                                                                                                                        |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControlList-1.html" class="xref">InputControlList</a>\<<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html" class="xref">InputControl</a>\> | List of <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html" class="xref">InputControl</a> which matched the given search criteria |

##### Examples

``` lang-csharp
// Find all gamepads (literally: that use the "Gamepad" layout).
InputSystem.FindControls("<Gamepad>");

// Find all sticks on all gamepads.
InputSystem.FindControls("<Gamepad>/*stick");

// Same but filter stick by type rather than by name.
InputSystem.FindControls<StickControl>("<Gamepad>/*");
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_FindControls__1_System_String_" class="xref">FindControls&lt;TControl&gt;(string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_FindControls__1_System_String_UnityEngine_InputSystem_InputControlList___0___" class="xref">FindControls&lt;TControl&gt;(string, ref InputControlList&lt;TControl&gt;)</a>

<span id="UnityEngine_InputSystem_InputSystem_FindControls_" uid="UnityEngine.InputSystem.InputSystem.FindControls*"></span>

#### FindControls\<TControl>(string)

Find all controls that match the given <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControlPath.html" class="xref">control path</a>.

##### Declaration

``` lang-csharp
public static InputControlList<TControl> FindControls<TControl>(string path) where TControl : InputControl
```

##### Parameters

| Type                                                                                   | Name                                    | Description                |
|----------------------------------------------------------------------------------------|-----------------------------------------|----------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> | <span class="parametername">path</span> | Control path to search for |

##### Returns

| Type                                                                                                                                                                    | Description                                                                                                                                                                                                |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControlList-1.html" class="xref">InputControlList</a>\<TControl> | Generic list of <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html" class="xref">InputControl</a> which matched the given search criteria |

##### Type Parameters

| Name                                        | Description                                                                                                                                                         |
|---------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <span class="parametername">TControl</span> | Type of control <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html" class="xref">InputControl</a>. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_FindControls__1_System_String_" class="xref">FindControls&lt;TControl&gt;(string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_FindControls__1_System_String_UnityEngine_InputSystem_InputControlList___0___" class="xref">FindControls&lt;TControl&gt;(string, ref InputControlList&lt;TControl&gt;)</a>

<span id="UnityEngine_InputSystem_InputSystem_FindControls_" uid="UnityEngine.InputSystem.InputSystem.FindControls*"></span>

#### FindControls\<TControl>(string, ref InputControlList\<TControl>)

Populate a list with all controls that match the given <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControlPath.html" class="xref">control path</a>.

##### Declaration

``` lang-csharp
public static int FindControls<TControl>(string path, ref InputControlList<TControl> controls) where TControl : InputControl
```

##### Parameters

| Type                                                                                                                                                                    | Name                                        | Description                                                                                                                                                                                            |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a>                                                                                  | <span class="parametername">path</span>     | Control path to search for                                                                                                                                                                             |
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControlList-1.html" class="xref">InputControlList</a>\<TControl> | <span class="parametername">controls</span> | Generic list of <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html" class="xref">InputControl</a> to populate with the search results |

##### Returns

| Type                                                                               | Description                                               |
|------------------------------------------------------------------------------------|-----------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.int32" class="xref">int</a> | Count of controls which matched the given search criteria |

##### Type Parameters

| Name                                        | Description                                                                                                                                                         |
|---------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <span class="parametername">TControl</span> | Type of control <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html" class="xref">InputControl</a>. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_FindControls__1_System_String_" class="xref">FindControls&lt;TControl&gt;(string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_FindControls__1_System_String_UnityEngine_InputSystem_InputControlList___0___" class="xref">FindControls&lt;TControl&gt;(string, ref InputControlList&lt;TControl&gt;)</a>

<span id="UnityEngine_InputSystem_InputSystem_FlushDisconnectedDevices_" uid="UnityEngine.InputSystem.InputSystem.FlushDisconnectedDevices*"></span>

#### FlushDisconnectedDevices()

Purge all disconnected devices from <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_disconnectedDevices" class="xref">disconnectedDevices</a>.

##### Declaration

``` lang-csharp
public static void FlushDisconnectedDevices()
```

##### Remarks

This will release all references held on to for these devices or any of their controls and will allow the devices to be reclaimed by the garbage collector.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_disconnectedDevices" class="xref">disconnectedDevices</a>

<span id="UnityEngine_InputSystem_InputSystem_GetDevice_" uid="UnityEngine.InputSystem.InputSystem.GetDevice*"></span>

#### GetDevice(string)

Return the device with given name or layout . Returns null if no such device currently exists.

##### Declaration

``` lang-csharp
public static InputDevice GetDevice(string nameOrLayout)
```

##### Parameters

| Type                                                                                   | Name                                            | Description                                 |
|----------------------------------------------------------------------------------------|-------------------------------------------------|---------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> | <span class="parametername">nameOrLayout</span> | Unique device name or layout to search for. |

##### Returns

| Type                                                                                                                                             | Description                                            |
|--------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a> | The device matching the given search criteria or null. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_GetDevice_System_Type_" class="xref">GetDevice(Type)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_GetDevice__1" class="xref">GetDevice&lt;TDevice&gt;()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_AddDevice__1_System_String_" class="xref">AddDevice&lt;TDevice&gt;(string)</a>

<span id="UnityEngine_InputSystem_InputSystem_GetDevice_" uid="UnityEngine.InputSystem.InputSystem.GetDevice*"></span>

#### GetDevice(Type)

Return the most recently used device that is assignable to the given type . Returns null if no such device currently exists.

##### Declaration

``` lang-csharp
public static InputDevice GetDevice(Type type)
```

##### Parameters

| Type                                                                               | Name                                    | Description        |
|------------------------------------------------------------------------------------|-----------------------------------------|--------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Type</a> | <span class="parametername">type</span> | Type of the device |

##### Returns

| Type                                                                                                                                             | Description                                              |
|--------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a> | The device that is assignable to the given type or null. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_GetDevice_System_String_" class="xref">GetDevice(string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_GetDevice__1" class="xref">GetDevice&lt;TDevice&gt;()</a>

<span id="UnityEngine_InputSystem_InputSystem_GetDeviceById_" uid="UnityEngine.InputSystem.InputSystem.GetDeviceById*"></span>

#### GetDeviceById(int)

Look up a device by its unique ID.

##### Declaration

``` lang-csharp
public static InputDevice GetDeviceById(int deviceId)
```

##### Parameters

| Type                                                                               | Name                                        | Description                                                                                                                                                                                                                                       |
|------------------------------------------------------------------------------------|---------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.int32" class="xref">int</a> | <span class="parametername">deviceId</span> | Unique ID of device. Such as given by <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.InputEvent.html#UnityEngine_InputSystem_LowLevel_InputEvent_deviceId" class="xref">deviceId</a>. |

##### Returns

| Type                                                                                                                                             | Description                                                                                      |
|--------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a> | The device for the given ID or null if no device with the given ID exists (or no longer exists). |

##### Remarks

Device IDs are not reused in a given session of the application (or Unity editor).

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.InputEvent.html#UnityEngine_InputSystem_LowLevel_InputEvent_deviceId" class="xref">deviceId</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html#UnityEngine_InputSystem_InputDevice_deviceId" class="xref">deviceId</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.IInputRuntime.html#UnityEngine.InputSystem.LowLevel.IInputRuntime.AllocateDeviceId" class="xref">AllocateDeviceId</a>()

<span id="UnityEngine_InputSystem_InputSystem_GetDevice_" uid="UnityEngine.InputSystem.InputSystem.GetDevice*"></span>

#### GetDevice\<TDevice>()

Return the most recently used device that is assignable to the given type `TDevice`. Returns null if no such device currently exists.

##### Declaration

``` lang-csharp
public static TDevice GetDevice<TDevice>() where TDevice : InputDevice
```

##### Returns

| Type                              | Description                                              |
|-----------------------------------|----------------------------------------------------------|
| <span class="xref">TDevice</span> | The device that is assignable to the given type or null. |

##### Type Parameters

| Name                                       | Description                 |
|--------------------------------------------|-----------------------------|
| <span class="parametername">TDevice</span> | Type of device to look for. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_GetDevice_System_String_" class="xref">GetDevice(string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_GetDevice_System_Type_" class="xref">GetDevice(Type)</a>

<span id="UnityEngine_InputSystem_InputSystem_GetDevice_" uid="UnityEngine.InputSystem.InputSystem.GetDevice*"></span>

#### GetDevice\<TDevice>(string)

Return the device of the given type `TDevice` that has the given usage assigned. Returns null if no such device currently exists.

##### Declaration

``` lang-csharp
public static TDevice GetDevice<TDevice>(string usage) where TDevice : InputDevice
```

##### Parameters

| Type                                                                                   | Name                                     | Description                           |
|----------------------------------------------------------------------------------------|------------------------------------------|---------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> | <span class="parametername">usage</span> | Usage of the device, e.g. "LeftHand". |

##### Returns

| Type                              | Description                                       |
|-----------------------------------|---------------------------------------------------|
| <span class="xref">TDevice</span> | The device with the given type and usage or null. |

##### Type Parameters

| Name                                       | Description                 |
|--------------------------------------------|-----------------------------|
| <span class="parametername">TDevice</span> | Type of device to look for. |

##### Remarks

Devices usages are most commonly employed to "tag" devices for a specific role. A common scenario, for example, is to distinguish which hand a specific <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.XR.XRController.html" class="xref">XRController</a> is associated with. However, arbitrary usages can be assigned to devices.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_GetDevice__1_UnityEngine_InputSystem_Utilities_InternedString_" class="xref">GetDevice&lt;TDevice&gt;(InternedString)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_SetDeviceUsage_UnityEngine_InputSystem_InputDevice_System_String_" class="xref">SetDeviceUsage(InputDevice, string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html#UnityEngine_InputSystem_InputControl_usages" class="xref">usages</a>

<span id="UnityEngine_InputSystem_InputSystem_GetDevice_" uid="UnityEngine.InputSystem.InputSystem.GetDevice*"></span>

#### GetDevice\<TDevice>(InternedString)

Return the device of the given type `TDevice` that has the given usage assigned. Returns null if no such device currently exists.

##### Declaration

``` lang-csharp
public static TDevice GetDevice<TDevice>(InternedString usage) where TDevice : InputDevice
```

##### Parameters

| Type                                                                                                                                                             | Name                                     | Description                           |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------|---------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Utilities.InternedString.html" class="xref">InternedString</a> | <span class="parametername">usage</span> | Usage of the device, e.g. "LeftHand". |

##### Returns

| Type                              | Description                                       |
|-----------------------------------|---------------------------------------------------|
| <span class="xref">TDevice</span> | The device with the given type and usage or null. |

##### Type Parameters

| Name                                       | Description                 |
|--------------------------------------------|-----------------------------|
| <span class="parametername">TDevice</span> | Type of device to look for. |

##### Remarks

Devices usages are most commonly employed to "tag" devices for a specific role. A common scenario, for example, is to distinguish which hand a specific <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.XR.XRController.html" class="xref">XRController</a> is associated with. However, arbitrary usages can be assigned to devices.

``` lang-csharp
// Get the left hand XRController.
var leftHand = InputSystem.GetDevice<XRController>(CommonUsages.leftHand);

// Mark gamepad #2 as being for player 1.
InputSystem.SetDeviceUsage(Gamepad.all[1], "Player1");
// And later look it up.
var player1Gamepad = InputSystem.GetDevice<Gamepad>(new InternedString("Player1"));
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_GetDevice_System_String_" class="xref">GetDevice(string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_SetDeviceUsage_UnityEngine_InputSystem_InputDevice_System_String_" class="xref">SetDeviceUsage(InputDevice, string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html#UnityEngine_InputSystem_InputControl_usages" class="xref">usages</a>

<span id="UnityEngine_InputSystem_InputSystem_GetNameOfBaseLayout_" uid="UnityEngine.InputSystem.InputSystem.GetNameOfBaseLayout*"></span>

#### GetNameOfBaseLayout(string)

Return the name of the layout that the layout registered as `layoutName` is based on.

##### Declaration

``` lang-csharp
public static string GetNameOfBaseLayout(string layoutName)
```

##### Parameters

| Type                                                                                   | Name                                          | Description                                                                                                                                                                                                                                                                                                                                                                                                |
|----------------------------------------------------------------------------------------|-----------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> | <span class="parametername">layoutName</span> | Name of a layout as registered with a method such as <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RegisterLayout__1_System_String_System_Nullable_UnityEngine_InputSystem_Layouts_InputDeviceMatcher__" class="xref">RegisterLayout&lt;T&gt;(string, InputDeviceMatcher?)</a>. Case-insensitive. |

##### Returns

| Type                                                                                   | Description                                                                                                                                                                         |
|----------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> | Name of the immediate parent layout of `layoutName` or `null` if no layout with the given name is registered or if it is not based on another layout or if it is a layout override. |

##### Remarks

This method does not work for layout overrides (which can be based on multiple base layouts). To find out which layouts a specific override registered with <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RegisterLayoutOverride_System_String_System_String_" class="xref">RegisterLayoutOverride(string, string)</a> is based on, load the layout with <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_LoadLayout_System_String_" class="xref">LoadLayout(string)</a> and inspect <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputControlLayout.html#UnityEngine_InputSystem_Layouts_InputControlLayout_baseLayouts" class="xref">baseLayouts</a>. This method will return `null` when `layoutName` is the name of a layout override.

One advantage of this method over calling <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_LoadLayout_System_String_" class="xref">LoadLayout(string)</a> and looking at <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputControlLayout.html#UnityEngine_InputSystem_Layouts_InputControlLayout_baseLayouts" class="xref">baseLayouts</a> is that this method does not have to actually load the layout but instead only performs a simple lookup.

``` lang-csharp
// Prints "Pointer".
Debug.Log(InputSystem.GetNameOfBaseLayout("Mouse"));
// Also works for control layouts. Prints "Axis".
Debug.Log(InputSystem.GetNameOfBaseLayout("Button"));
```

##### Exceptions

| Type                                                                                                                 | Condition                        |
|----------------------------------------------------------------------------------------------------------------------|----------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentnullexception" class="xref">ArgumentNullException</a> | `layoutName` is `null` or empty. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputControlLayout.html#UnityEngine_InputSystem_Layouts_InputControlLayout_baseLayouts" class="xref">baseLayouts</a>

<span id="UnityEngine_InputSystem_InputSystem_GetUnsupportedDevices_" uid="UnityEngine.InputSystem.InputSystem.GetUnsupportedDevices*"></span>

#### GetUnsupportedDevices()

Return the list of devices that have been reported by the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.IInputRuntime.html" class="xref">runtime</a> but could not be matched to any known <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputControlLayout.html" class="xref">layout</a>.

##### Declaration

``` lang-csharp
public static List<InputDeviceDescription> GetUnsupportedDevices()
```

##### Returns

| Type                                                                                                                                                                                                                                                                                       | Description                                                     |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.collections.generic.list-1" class="xref">List</a>\<<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputDeviceDescription.html" class="xref">InputDeviceDescription</a>\> | A list of descriptions of devices that could not be recognized. |

##### Remarks

If new layouts are added to the system or if additional <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputDeviceMatcher.html" class="xref">matches</a> are added to existing layouts, devices in this list may appear or disappear.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputDeviceMatcher.html" class="xref">InputDeviceMatcher</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RegisterLayoutMatcher_System_String_UnityEngine_InputSystem_Layouts_InputDeviceMatcher_" class="xref">RegisterLayoutMatcher(string, InputDeviceMatcher)</a>

<span id="UnityEngine_InputSystem_InputSystem_GetUnsupportedDevices_" uid="UnityEngine.InputSystem.InputSystem.GetUnsupportedDevices*"></span>

#### GetUnsupportedDevices(List\<InputDeviceDescription>)

Populate a list of devices that have been reported by the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.IInputRuntime.html" class="xref">runtime</a> but could not be matched to any known <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputControlLayout.html" class="xref">layout</a>.

##### Declaration

``` lang-csharp
public static int GetUnsupportedDevices(List<InputDeviceDescription> descriptions)
```

##### Parameters

| Type                                                                                                                                                                                                                                                                                       | Name                                            | Description                                                                       |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------|-----------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.collections.generic.list-1" class="xref">List</a>\<<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputDeviceDescription.html" class="xref">InputDeviceDescription</a>\> | <span class="parametername">descriptions</span> | A list to be populated with descriptions of devices that could not be recognized. |

##### Returns

| Type                                                                               | Description                                         |
|------------------------------------------------------------------------------------|-----------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.int32" class="xref">int</a> | The number of devices that could not be recognized. |

##### Remarks

If new layouts are added to the system or if additional <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputDeviceMatcher.html" class="xref">matches</a> are added to existing layouts, devices in this list may appear or disappear.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputDeviceMatcher.html" class="xref">InputDeviceMatcher</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RegisterLayoutMatcher_System_String_UnityEngine_InputSystem_Layouts_InputDeviceMatcher_" class="xref">RegisterLayoutMatcher(string, InputDeviceMatcher)</a>

<span id="UnityEngine_InputSystem_InputSystem_HasNativeObject_" uid="UnityEngine.InputSystem.InputSystem.HasNativeObject*"></span>

#### HasNativeObject(Object)

We have this function to hide away instanceId -> entityId migration that happened in Unity 6.3

##### Declaration

``` lang-csharp
public static bool HasNativeObject(Object obj)
```

##### Parameters

| Type                                                                                                        | Name                                   | Description |
|-------------------------------------------------------------------------------------------------------------|----------------------------------------|-------------|
| <a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Object.html" class="xref">Object</a> | <span class="parametername">obj</span> |             |

##### Returns

| Type                                                                                  | Description |
|---------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">bool</a> |             |

<span id="UnityEngine_InputSystem_InputSystem_IsFirstLayoutBasedOnSecond_" uid="UnityEngine.InputSystem.InputSystem.IsFirstLayoutBasedOnSecond*"></span>

#### IsFirstLayoutBasedOnSecond(string, string)

Check whether the first layout is based on the second.

##### Declaration

``` lang-csharp
public static bool IsFirstLayoutBasedOnSecond(string firstLayoutName, string secondLayoutName)
```

##### Parameters

| Type                                                                                   | Name                                                | Description                                                                                                                                                                                  |
|----------------------------------------------------------------------------------------|-----------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> | <span class="parametername">firstLayoutName</span>  | Name of a registered <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputControlLayout.html" class="xref">InputControlLayout</a>. |
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> | <span class="parametername">secondLayoutName</span> | Name of a registered <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputControlLayout.html" class="xref">InputControlLayout</a>. |

##### Returns

| Type                                                                                  | Description                                               |
|---------------------------------------------------------------------------------------|-----------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">bool</a> | True if `firstLayoutName` is based on `secondLayoutName`. |

##### Remarks

This is

##### Exceptions

| Type                                                                                                                 | Condition                                                                        |
|----------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentnullexception" class="xref">ArgumentNullException</a> | `firstLayoutName` is `null` or empty -or- `secondLayoutName` is `null` or empty. |

<span id="UnityEngine_InputSystem_InputSystem_ListEnabledActions_" uid="UnityEngine.InputSystem.InputSystem.ListEnabledActions*"></span>

#### ListEnabledActions()

Return a list of all the actions that are currently enabled in the system.

##### Declaration

``` lang-csharp
public static List<InputAction> ListEnabledActions()
```

##### Returns

| Type                                                                                                                                                                                                                                                         | Description                                                   |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.collections.generic.list-1" class="xref">List</a>\<<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html" class="xref">InputAction</a>\> | A new list instance containing all currently enabled actions. |

##### Remarks

To avoid allocations, use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_ListEnabledActions_System_Collections_Generic_List_UnityEngine_InputSystem_InputAction__" class="xref">ListEnabledActions(List&lt;InputAction&gt;)</a>.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_enabled" class="xref">enabled</a>

<span id="UnityEngine_InputSystem_InputSystem_ListEnabledActions_" uid="UnityEngine.InputSystem.InputSystem.ListEnabledActions*"></span>

#### ListEnabledActions(List\<InputAction>)

Add all actions that are currently enabled in the system to the given list.

##### Declaration

``` lang-csharp
public static int ListEnabledActions(List<InputAction> actions)
```

##### Parameters

| Type                                                                                                                                                                                                                                                         | Name                                       | Description             |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------|-------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.collections.generic.list-1" class="xref">List</a>\<<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html" class="xref">InputAction</a>\> | <span class="parametername">actions</span> | List to add actions to. |

##### Returns

| Type                                                                               | Description                              |
|------------------------------------------------------------------------------------|------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.int32" class="xref">int</a> | The number of actions added to the list. |

##### Remarks

If the capacity of the given list is large enough, this method will not allocate memory.

##### Exceptions

| Type                                                                                                                 | Condition          |
|----------------------------------------------------------------------------------------------------------------------|--------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentnullexception" class="xref">ArgumentNullException</a> | `actions` is null. |

<span id="UnityEngine_InputSystem_InputSystem_ListInteractions_" uid="UnityEngine.InputSystem.InputSystem.ListInteractions*"></span>

#### ListInteractions()

Gets the names of of all currently registered interactions.

##### Declaration

``` lang-csharp
public static IEnumerable<string> ListInteractions()
```

##### Returns

| Type                                                                                                                                                                                                             | Description                                       |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.collections.generic.ienumerable-1" class="xref">IEnumerable</a>\<<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a>\> | A list of currently registered interaction names. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.IInputInteraction.html" class="xref">IInputInteraction</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RegisterInteraction_System_Type_System_String_" class="xref">RegisterInteraction(Type, string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_TryGetInteraction_System_String_" class="xref">TryGetInteraction(string)</a>

<span id="UnityEngine_InputSystem_InputSystem_ListLayouts_" uid="UnityEngine.InputSystem.InputSystem.ListLayouts*"></span>

#### ListLayouts()

Return a list with the names of all layouts that have been registered.

##### Declaration

``` lang-csharp
public static IEnumerable<string> ListLayouts()
```

##### Returns

| Type                                                                                                                                                                                                             | Description             |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.collections.generic.ienumerable-1" class="xref">IEnumerable</a>\<<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a>\> | A list of layout names. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_LoadLayout_System_String_" class="xref">LoadLayout(string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_ListLayoutsBasedOn_System_String_" class="xref">ListLayoutsBasedOn(string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RegisterLayout_System_Type_System_String_System_Nullable_UnityEngine_InputSystem_Layouts_InputDeviceMatcher__" class="xref">RegisterLayout(Type, string, InputDeviceMatcher?)</a>

<span id="UnityEngine_InputSystem_InputSystem_ListLayoutsBasedOn_" uid="UnityEngine.InputSystem.InputSystem.ListLayoutsBasedOn*"></span>

#### ListLayoutsBasedOn(string)

List all the layouts that are based on the given layout.

##### Declaration

``` lang-csharp
public static IEnumerable<string> ListLayoutsBasedOn(string baseLayout)
```

##### Parameters

| Type                                                                                   | Name                                          | Description                  |
|----------------------------------------------------------------------------------------|-----------------------------------------------|------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> | <span class="parametername">baseLayout</span> | Name of a registered layout. |

##### Returns

| Type                                                                                                                                                                                                             | Description                                                |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.collections.generic.ienumerable-1" class="xref">IEnumerable</a>\<<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a>\> | The names of all registered layouts based on `baseLayout`. |

##### Remarks

The list will not include layout overrides (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RegisterLayoutOverride_System_String_System_String_" class="xref">RegisterLayoutOverride(string, string)</a>).

``` lang-csharp
// List all gamepad layouts in the system.
Debug.Log(string.Join("\n", InputSystem.ListLayoutsBasedOn("Gamepad"));
```

##### Exceptions

| Type                                                                                                                 | Condition                        |
|----------------------------------------------------------------------------------------------------------------------|----------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentnullexception" class="xref">ArgumentNullException</a> | `baseLayout` is `null` or empty. |

<span id="UnityEngine_InputSystem_InputSystem_ListProcessors_" uid="UnityEngine.InputSystem.InputSystem.ListProcessors*"></span>

#### ListProcessors()

List the names of all processors have been registered.

##### Declaration

``` lang-csharp
public static IEnumerable<string> ListProcessors()
```

##### Returns

| Type                                                                                                                                                                                                             | Description                    |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.collections.generic.ienumerable-1" class="xref">IEnumerable</a>\<<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a>\> | List of registered processors. |

##### Remarks

Note that the result will include both "proper" names and aliases registered for processors. If, for example, a given type `JitterProcessor` has been registered under both "Jitter" and "Randomize", it will appear in the list with both those names.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_TryGetProcessor_System_String_" class="xref">TryGetProcessor(string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RegisterProcessor__1_System_String_" class="xref">RegisterProcessor&lt;T&gt;(string)</a>

<span id="UnityEngine_InputSystem_InputSystem_LoadLayout_" uid="UnityEngine.InputSystem.InputSystem.LoadLayout*"></span>

#### LoadLayout(string)

Load a registered layout.

##### Declaration

``` lang-csharp
public static InputControlLayout LoadLayout(string name)
```

##### Parameters

| Type                                                                                   | Name                                    | Description                                                              |
|----------------------------------------------------------------------------------------|-----------------------------------------|--------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> | <span class="parametername">name</span> | Name of the layout to load. Note that layout names are case-insensitive. |

##### Returns

| Type                                                                                                                                                                   | Description                                                                              |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputControlLayout.html" class="xref">InputControlLayout</a> | The constructed layout instance or `null` if no layout of the given name could be found. |

##### Remarks

The result of this method is what's called a "fully merged" layout, i.e. a layout with the information of all the base layouts as well as from all overrides merged into it. See <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputControlLayout.html#UnityEngine_InputSystem_Layouts_InputControlLayout_MergeLayout_UnityEngine_InputSystem_Layouts_InputControlLayout_" class="xref">MergeLayout(InputControlLayout)</a> for details.

What this means in practice is that all inherited controls and settings will be present on the layout.

// List all controls defined for gamepads. var gamepadLayout = InputSystem.LoadLayout("Gamepad"); foreach (var control in gamepadLayout.controls) { // There may be control elements that are not introducing new controls but rather // change settings on controls added indirectly by other layouts referenced from // Gamepad. These are not adding new controls so we skip them here. if (control.isModifyingExistingControl) continue;

    Debug.Log($"Control: {control.name} (
However, note that controls which are added from other layouts referenced by the loaded layout will not necessarily be visible on it (they will only if referenced by a <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputControlLayout.ControlItem.html" class="xref">InputControlLayout.ControlItem</a> where <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputControlLayout.ControlItem.html#UnityEngine_InputSystem_Layouts_InputControlLayout_ControlItem_isModifyingExistingControl" class="xref">isModifyingExistingControl</a> is `true`). For example, let's assume we have the following layout which adds a device with a single stick.

``` lang-csharp
InputSystem.RegisterLayout(@"
    
        ]
    }
");
```

If we load this layout, the `"stick"` control will be visible on the layout but the X and Y (as well as up/down/left/right) controls added by the `"Stick"` layout will not be.

##### Exceptions

| Type                                                                                                                 | Condition                  |
|----------------------------------------------------------------------------------------------------------------------|----------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentnullexception" class="xref">ArgumentNullException</a> | `name` is `null` or empty. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RegisterLayout_System_Type_System_String_System_Nullable_UnityEngine_InputSystem_Layouts_InputDeviceMatcher__" class="xref">RegisterLayout(Type, string, InputDeviceMatcher?)</a>

<span id="UnityEngine_InputSystem_InputSystem_LoadLayout_" uid="UnityEngine.InputSystem.InputSystem.LoadLayout*"></span>

#### LoadLayout\<TControl>()

Load the layout registered for the given type.

##### Declaration

``` lang-csharp
public static InputControlLayout LoadLayout<TControl>() where TControl : InputControl
```

##### Returns

| Type                                                                                                                                                                   | Description                                                              |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputControlLayout.html" class="xref">InputControlLayout</a> | The layout registered for `TControl` or `null` if no such layout exists. |

##### Type Parameters

| Name                                        | Description           |
|---------------------------------------------|-----------------------|
| <span class="parametername">TControl</span> | An InputControl type. |

##### Remarks

This method is equivalent to calling <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_LoadLayout_System_String_" class="xref">LoadLayout(string)</a> with the name of the layout under which `TControl` has been registered.

``` lang-csharp
// Load the InputControlLayout generated from StickControl.
var stickLayout = InputSystem.LoadLayout<StickControl>();
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_LoadLayout_System_String_" class="xref">LoadLayout(string)</a>

<span id="UnityEngine_InputSystem_InputSystem_PauseHaptics_" uid="UnityEngine.InputSystem.InputSystem.PauseHaptics*"></span>

#### PauseHaptics()

Pause haptic effect playback on all devices.

##### Declaration

``` lang-csharp
public static void PauseHaptics()
```

##### Remarks

Calls <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Haptics.IHaptics.html#UnityEngine_InputSystem_Haptics_IHaptics_PauseHaptics" class="xref">PauseHaptics()</a> on all <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">input devices</a> that implement the interface.

##### Examples

``` lang-csharp
// When going into the menu from gameplay, pause haptics.
gameplayControls.backAction.onPerformed +=
    ctx =>
    {
        gameplayControls.Disable();
        menuControls.Enable();
        InputSystem.PauseHaptics();
    };
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_ResumeHaptics" class="xref">ResumeHaptics()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_ResetHaptics" class="xref">ResetHaptics()</a>

<span id="UnityEngine_InputSystem_InputSystem_QueueConfigChangeEvent_" uid="UnityEngine.InputSystem.InputSystem.QueueConfigChangeEvent*"></span>

#### QueueConfigChangeEvent(InputDevice, double)

Queue a <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.DeviceConfigurationEvent.html" class="xref">DeviceConfigurationEvent</a> that signals that the configuration of the given device has changed and that cached configuration will thus have to be refreshed.

##### Declaration

``` lang-csharp
public static void QueueConfigChangeEvent(InputDevice device, double time = -1)
```

##### Parameters

| Type                                                                                                                                             | Name                                      | Description                                                              |
|--------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------|--------------------------------------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a> | <span class="parametername">device</span> | Device whose configuration has changed.                                  |
| <a href="https://learn.microsoft.com/dotnet/api/system.double" class="xref">double</a>                                                           | <span class="parametername">time</span>   | Timestamp for the event. If not supplied, the current time will be used. |

##### Remarks

All state of an input device that is not input or output state is considered its "configuration".

A simple example is keyboard layouts. A <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Keyboard.html" class="xref">Keyboard</a> will typically have an associated keyboard layout that dictates the function of each key and which can be changed by the user at the system level. In the input system, the current keyboard layout can be queried via <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Keyboard.html#UnityEngine_InputSystem_Keyboard_keyboardLayout" class="xref">keyboardLayout</a>. When the layout changes at the system level, the input backend sends a configuration change event to signal that the configuration of the keyboard has changed and that cached data may be outdated. In response, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Keyboard.html" class="xref">Keyboard</a> will flush out cached information such as the name of the keyboard layout and display names (<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html#UnityEngine_InputSystem_InputControl_displayName" class="xref">displayName</a>) of individual keys which causes them to be fetched again from the backend the next time they are accessed.

##### Exceptions

| Type                                                                                                                         | Condition                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentnullexception" class="xref">ArgumentNullException</a>         | `device` is null.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| <a href="https://learn.microsoft.com/dotnet/api/system.invalidoperationexception" class="xref">InvalidOperationException</a> | `device` has not been added (<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html#UnityEngine_InputSystem_InputDevice_added" class="xref">added</a>; <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_AddDevice_UnityEngine_InputSystem_InputDevice_" class="xref">AddDevice(InputDevice)</a>) and thus cannot receive events. |

<span id="UnityEngine_InputSystem_InputSystem_QueueDeltaStateEvent_" uid="UnityEngine.InputSystem.InputSystem.QueueDeltaStateEvent*"></span>

#### QueueDeltaStateEvent\<TDelta>(InputControl, TDelta, double)

Queue a <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.DeltaStateEvent.html" class="xref">DeltaStateEvent</a> to update part of the input state of the given device.

##### Declaration

``` lang-csharp
public static void QueueDeltaStateEvent<TDelta>(InputControl control, TDelta delta, double time = -1) where TDelta : struct
```

##### Parameters

| Type                                                                                                                                               | Name                                       | Description                                                                   |
|----------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------|-------------------------------------------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html" class="xref">InputControl</a> | <span class="parametername">control</span> | Control on a device to update state of.                                       |
| <span class="xref">TDelta</span>                                                                                                                   | <span class="parametername">delta</span>   | New state for the control. Type of state must match the state of the control. |
| <a href="https://learn.microsoft.com/dotnet/api/system.double" class="xref">double</a>                                                             | <span class="parametername">time</span>    |                                                                               |

##### Type Parameters

| Name                                      | Description |
|-------------------------------------------|-------------|
| <span class="parametername">TDelta</span> |             |

##### Exceptions

| Type                                                                                                                         | Condition          |
|------------------------------------------------------------------------------------------------------------------------------|--------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentnullexception" class="xref">ArgumentNullException</a>         | `control` is null. |
| <a href="https://learn.microsoft.com/dotnet/api/system.invalidoperationexception" class="xref">InvalidOperationException</a> |                    |
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentexception" class="xref">ArgumentException</a>                 |                    |

<span id="UnityEngine_InputSystem_InputSystem_QueueEvent_" uid="UnityEngine.InputSystem.InputSystem.QueueEvent*"></span>

#### QueueEvent(InputEventPtr)

Add an event to the internal event queue.

##### Declaration

``` lang-csharp
public static void QueueEvent(InputEventPtr eventPtr)
```

##### Parameters

| Type                                                                                                                                                          | Name                                        | Description                                |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------|--------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.InputEventPtr.html" class="xref">InputEventPtr</a> | <span class="parametername">eventPtr</span> | Event to add to the internal event buffer. |

##### Remarks

The event will be copied in full to the internal event buffer meaning that you can release memory for the event after it has been queued. The internal event buffer is flushed on the next input system update (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_Update" class="xref">Update()</a>). Note that if input is process in `FixedUpdate()` (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.html#UnityEngine_InputSystem_InputSettings_updateMode" class="xref">updateMode</a>), then the event may not get processed until its <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.InputEvent.html#UnityEngine_InputSystem_LowLevel_InputEvent_time" class="xref">time</a> timestamp is within the update window of the input system.

As part of queuing, the event will receive its own unique ID (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.InputEvent.html#UnityEngine_InputSystem_LowLevel_InputEvent_eventId" class="xref">eventId</a>). Note that this ID will be written into the memory buffer referenced by meaning that after calling `QueueEvent`, you will see the event ID with which the event was queued.

Events that are queued during event processing will get processed in the same update. This happens, for example, when queuing input from within <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_onEvent" class="xref">onEvent</a> or from action callbacks such as <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_performed" class="xref">performed</a>.

The total size of <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.InputEvent.html" class="xref">InputEvent</a>s processed in a single update is limited by <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.html#UnityEngine_InputSystem_InputSettings_maxEventBytesPerUpdate" class="xref">maxEventBytesPerUpdate</a>. This also prevents deadlocks when each processing of an event leads to one or more additional events getting queued.

``` lang-csharp
// Queue an input event on the first gamepad.
var gamepad = Gamepad.all[0];
using (StateEvent.From(gamepad, out var eventPtr))

```

##### Exceptions

| Type                                                                                                                         | Condition                                                                                                                                                                                                                                 |
|------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentexception" class="xref">ArgumentException</a>                 | `eventPtr` is not valid (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.InputEventPtr.html#UnityEngine_InputSystem_LowLevel_InputEventPtr_valid" class="xref">valid</a>). |
| <a href="https://learn.microsoft.com/dotnet/api/system.invalidoperationexception" class="xref">InvalidOperationException</a> | The method was called from within event processing more than 1000 times. To avoid deadlocking, this results in an exception being thrown.                                                                                                 |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_Update" class="xref">Update()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_onEvent" class="xref">onEvent</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_onBeforeUpdate" class="xref">onBeforeUpdate</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.InputEvent.html" class="xref">InputEvent</a>

<span id="UnityEngine_InputSystem_InputSystem_QueueEvent_" uid="UnityEngine.InputSystem.InputSystem.QueueEvent*"></span>

#### QueueEvent\<TEvent>(ref TEvent)

Add an event to the internal event queue.

##### Declaration

``` lang-csharp
public static void QueueEvent<TEvent>(ref TEvent inputEvent) where TEvent : struct, IInputEventTypeInfo
```

##### Parameters

| Type                             | Name                                          | Description                                |
|----------------------------------|-----------------------------------------------|--------------------------------------------|
| <span class="xref">TEvent</span> | <span class="parametername">inputEvent</span> | Event to add to the internal event buffer. |

##### Type Parameters

| Name                                      | Description                    |
|-------------------------------------------|--------------------------------|
| <span class="parametername">TEvent</span> | Type of event to look enqueue. |

##### Remarks

The event will be copied in full to the internal event buffer. The internal event buffer is flushed on the next input system update (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_Update" class="xref">Update()</a>). Note that if input is process in `FixedUpdate()` (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.html#UnityEngine_InputSystem_InputSettings_updateMode" class="xref">updateMode</a>), then the event may not get processed until its <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.InputEvent.html#UnityEngine_InputSystem_LowLevel_InputEvent_time" class="xref">time</a> timestamp is within the update window of the input system.

As part of queuing, the event will receive its own unique ID (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.InputEvent.html#UnityEngine_InputSystem_LowLevel_InputEvent_eventId" class="xref">eventId</a>). Note that this ID will be written into `inputEvent` meaning that after calling this method, you will see the event ID with which the event was queued.

``` lang-csharp
// Queue a disconnect event on the first gamepad.
var inputEvent = DeviceRemoveEvent(Gamepad.all[0].deviceId);
InputSystem.QueueEvent(inputEvent);
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_Update" class="xref">Update()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_onEvent" class="xref">onEvent</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_onBeforeUpdate" class="xref">onBeforeUpdate</a>

<span id="UnityEngine_InputSystem_InputSystem_QueueStateEvent_" uid="UnityEngine.InputSystem.InputSystem.QueueStateEvent*"></span>

#### QueueStateEvent\<TState>(InputDevice, TState, double)

Queue a <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.StateEvent.html" class="xref">StateEvent</a> to update the input state of the given device.

##### Declaration

``` lang-csharp
public static void QueueStateEvent<TState>(InputDevice device, TState state, double time = -1) where TState : struct, IInputStateTypeInfo
```

##### Parameters

| Type                                                                                                                                             | Name                                      | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|--------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a> | <span class="parametername">device</span> | Device whose input state to update                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| <span class="xref">TState</span>                                                                                                                 | <span class="parametername">state</span>  |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| <a href="https://learn.microsoft.com/dotnet/api/system.double" class="xref">double</a>                                                           | <span class="parametername">time</span>   | Timestamp for the event. If not supplied, the current time is used. Note that if the given time is in the future and events processed in [FixedUpdate](https://docs.unity3d.com/ScriptReference/MonoBehaviour.FixedUpdate.html) (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.html#UnityEngine_InputSystem_InputSettings_updateMode" class="xref">updateMode</a>), the event will only get processed once the actual time has caught up with the given time. |

##### Type Parameters

| Name                                      | Description                                                                                                                                                                                                                              |
|-------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <span class="parametername">TState</span> | Type of input state, such as <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.MouseState.html" class="xref">MouseState</a>. Must match the expected type of state of `device`. |

##### Remarks

The given state must match exactly what is expected by the given device. If unsure, an alternative is to grab the state as an event directly from the device using <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.StateEvent.html#UnityEngine_InputSystem_LowLevel_StateEvent_From_UnityEngine_InputSystem_InputDevice_UnityEngine_InputSystem_LowLevel_InputEventPtr__Unity_Collections_Allocator_" class="xref">From(InputDevice, out InputEventPtr, Allocator)</a> which can then be queued using <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_QueueEvent_UnityEngine_InputSystem_LowLevel_InputEventPtr_" class="xref">QueueEvent(InputEventPtr)</a>.

``` lang-csharp
// Allocates temporary, unmanaged memory for the event.
// using statement automatically disposes the memory once we have queued the event.
using (StateEvent.From(Mouse.current, out var eventPtr))

The event will only be queued and not processed right away. This means that the state of `device` will not change immediately as a result of calling this method. Instead, the event will be processed as part of the next input update.

Note that this method updates the complete input state of the device including all of its controls. To update just part of the state of a device, you can use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_QueueDeltaStateEvent__1_UnityEngine_InputSystem_InputControl___0_System_Double_" class="xref">QueueDeltaStateEvent&lt;TDelta&gt;(InputControl, TDelta, double)</a> (however, note that there are some restrictions; see documentation).

``` lang-csharp
InputSystem.QueueStateEvent(Mouse.current, new MouseState { position = new Vector(123, 234) });
```

##### Exceptions

| Type                                                                                                                         | Condition                                                                                                                                                                                                                                                                                                                  |
|------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentnullexception" class="xref">ArgumentNullException</a>         | `device` is null.                                                                                                                                                                                                                                                                                                          |
| <a href="https://learn.microsoft.com/dotnet/api/system.invalidoperationexception" class="xref">InvalidOperationException</a> | `device` has not been added to the system (<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_AddDevice_UnityEngine_InputSystem_InputDevice_" class="xref">AddDevice(InputDevice)</a>) and thus cannot receive events. |
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentexception" class="xref">ArgumentException</a>                 |                                                                                                                                                                                                                                                                                                                            |

<span id="UnityEngine_InputSystem_InputSystem_QueueTextEvent_" uid="UnityEngine.InputSystem.InputSystem.QueueTextEvent*"></span>

#### QueueTextEvent(InputDevice, char, double)

Queue a <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.TextEvent.html" class="xref">TextEvent</a> on the given device.

##### Declaration

``` lang-csharp
public static void QueueTextEvent(InputDevice device, char character, double time = -1)
```

##### Parameters

| Type                                                                                                                                             | Name                                         | Description                                                                |
|--------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------|----------------------------------------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a> | <span class="parametername">device</span>    | Device to queue the event on.                                              |
| <a href="https://learn.microsoft.com/dotnet/api/system.char" class="xref">char</a>                                                               | <span class="parametername">character</span> | Text character to input through the event.                                 |
| <a href="https://learn.microsoft.com/dotnet/api/system.double" class="xref">double</a>                                                           | <span class="parametername">time</span>      | Optional event time stamp. If not supplied, the current time will be used. |

##### Remarks

Text input is sent to devices character by character. This allows sending strings of arbitrary length without necessary incurring GC overhead.

For the event to have any effect on `device`, the device must implement <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.ITextInputReceiver.html" class="xref">ITextInputReceiver</a>. It will see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.ITextInputReceiver.html#UnityEngine_InputSystem_LowLevel_ITextInputReceiver_OnTextInput_System_Char_" class="xref">OnTextInput(char)</a> being called when the event is processed.

##### Exceptions

| Type                                                                                                                         | Condition                                                   |
|------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentnullexception" class="xref">ArgumentNullException</a>         | `device` is null.                                           |
| <a href="https://learn.microsoft.com/dotnet/api/system.invalidoperationexception" class="xref">InvalidOperationException</a> | `device` is a device that has not been added to the system. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Keyboard.html#UnityEngine_InputSystem_Keyboard_onTextInput" class="xref">onTextInput</a>

<span id="UnityEngine_InputSystem_InputSystem_RegisterBindingComposite_" uid="UnityEngine.InputSystem.InputSystem.RegisterBindingComposite*"></span>

#### RegisterBindingComposite(Type, string)

Register a new type of binding composite with the system.

##### Declaration

``` lang-csharp
public static void RegisterBindingComposite(Type type, string name)
```

##### Parameters

| Type                                                                                   | Name                                    | Description                                                                                                                                                                                                                    |
|----------------------------------------------------------------------------------------|-----------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Type</a>     | <span class="parametername">type</span> | Type that implements the binding composite. Must support <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBindingComposite.html" class="xref">InputBindingComposite</a>. |
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> | <span class="parametername">name</span> | Name to register the binding composite with. This is used in bindings to refer to the composite.                                                                                                                               |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBindingComposite.html" class="xref">InputBindingComposite</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RegisterBindingComposite__1_System_String_" class="xref">RegisterBindingComposite&lt;T&gt;(string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_TryGetBindingComposite_System_String_" class="xref">TryGetBindingComposite(string)</a>

<span id="UnityEngine_InputSystem_InputSystem_RegisterBindingComposite_" uid="UnityEngine.InputSystem.InputSystem.RegisterBindingComposite*"></span>

#### RegisterBindingComposite\<T>(string)

Register a new type of binding composite with the system.

##### Declaration

``` lang-csharp
public static void RegisterBindingComposite<T>(string name = null)
```

##### Parameters

| Type                                                                                   | Name                                    | Description                                                                                      |
|----------------------------------------------------------------------------------------|-----------------------------------------|--------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> | <span class="parametername">name</span> | Name to register the binding composite with. This is used in bindings to refer to the composite. |

##### Type Parameters

| Name                                 | Description                                                                                                                                                                                                                    |
|--------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <span class="parametername">T</span> | Type that implements the binding composite. Must support <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBindingComposite.html" class="xref">InputBindingComposite</a>. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBindingComposite.html" class="xref">InputBindingComposite</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RegisterBindingComposite_System_Type_System_String_" class="xref">RegisterBindingComposite(Type, string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_TryGetBindingComposite_System_String_" class="xref">TryGetBindingComposite(string)</a>

<span id="UnityEngine_InputSystem_InputSystem_RegisterInteraction_" uid="UnityEngine.InputSystem.InputSystem.RegisterInteraction*"></span>

#### RegisterInteraction(Type, string)

Register a new type of interaction with the system.

##### Declaration

``` lang-csharp
public static void RegisterInteraction(Type type, string name = null)
```

##### Parameters

| Type                                                                                   | Name                                    | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|----------------------------------------------------------------------------------------|-----------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Type</a>     | <span class="parametername">type</span> | Type that implements the interaction. Must support <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputInteraction.html" class="xref">InputInteraction</a>.                                                                                                                                                                                                                                                                                                                  |
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> | <span class="parametername">name</span> | Name to register the interaction with. This is used in bindings to refer to the interaction (e.g. an interactions called "Tap" can be added to a binding by listing it in its <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBinding.html#UnityEngine_InputSystem_InputBinding_interactions" class="xref">interactions</a> property). If no name is supplied, the short name of `type` is used (with "Interaction" clipped off the name if the type name ends in that). |

##### Examples

``` lang-csharp
// Interaction that is performed when control resets to default state.
public class ResetInteraction : InputInteraction

}

// Make interaction globally available on bindings.
// "Interaction" suffix in type name will get dropped automatically.
InputSystem.RegisterInteraction(typeof(ResetInteraction));

// Set up action with binding that has the 'reset' interaction applied to it.
var action = new InputAction(binding: "/<Gamepad>/buttonSouth", interactions: "reset");
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.IInputInteraction.html" class="xref">IInputInteraction</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RegisterInteraction__1_System_String_" class="xref">RegisterInteraction&lt;T&gt;(string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_TryGetInteraction_System_String_" class="xref">TryGetInteraction(string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_ListInteractions" class="xref">ListInteractions()</a>

<span id="UnityEngine_InputSystem_InputSystem_RegisterInteraction_" uid="UnityEngine.InputSystem.InputSystem.RegisterInteraction*"></span>

#### RegisterInteraction\<T>(string)

Register a new type of interaction with the system.

##### Declaration

``` lang-csharp
public static void RegisterInteraction<T>(string name = null)
```

##### Parameters

| Type                                                                                   | Name                                    | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|----------------------------------------------------------------------------------------|-----------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> | <span class="parametername">name</span> | Name to register the interaction with. This is used in bindings to refer to the interaction (e.g. an interactions called "Tap" can be added to a binding by listing it in its <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBinding.html#UnityEngine_InputSystem_InputBinding_interactions" class="xref">interactions</a> property). If no name is supplied, the short name of `T` is used (with "Interaction" clipped off the name if the type name ends in that). |

##### Type Parameters

| Name                                 | Description                                                                                                                                                                                                    |
|--------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <span class="parametername">T</span> | Type that implements the interaction. Must support <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputInteraction.html" class="xref">InputInteraction</a>. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.IInputInteraction.html" class="xref">IInputInteraction</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RegisterInteraction_System_Type_System_String_" class="xref">RegisterInteraction(Type, string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_TryGetInteraction_System_String_" class="xref">TryGetInteraction(string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_ListInteractions" class="xref">ListInteractions()</a>

<span id="UnityEngine_InputSystem_InputSystem_RegisterLayout_" uid="UnityEngine.InputSystem.InputSystem.RegisterLayout*"></span>

#### RegisterLayout(string, string, InputDeviceMatcher?)

Register a layout in JSON format.

##### Declaration

``` lang-csharp
public static void RegisterLayout(string json, string name = null, InputDeviceMatcher? matches = null)
```

##### Parameters

| Type                                                                                                                                                                    | Name                                       | Description                                                                                                                                                                                                                                                                                                                        |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a>                                                                                  | <span class="parametername">json</span>    | JSON data describing the layout.                                                                                                                                                                                                                                                                                                   |
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a>                                                                                  | <span class="parametername">name</span>    | Optional name of the layout. If null or empty, the name is taken from the "name" property of the JSON data. If it is supplied, it will override the "name" property if present. If neither is supplied, an <a href="https://learn.microsoft.com/dotnet/api/system.argumentexception" class="xref">ArgumentException</a> is thrown. |
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputDeviceMatcher.html" class="xref">InputDeviceMatcher</a>? | <span class="parametername">matches</span> | Optional device matcher. If this is supplied, the layout will automatically be instantiated for newly discovered devices that match the description.                                                                                                                                                                               |

##### Remarks

The JSON format makes it possible to create new device and control layouts completely in data. They have to ultimately be based on a layout backed by a C# type, however (e.g. <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Gamepad.html" class="xref">Gamepad</a>).

Note that most errors in layouts will only be detected when instantiated (i.e. when a device or control is being created from a layout). The JSON data will, however, be parsed once on registration to check for a device description in the layout. JSON format errors will thus be detected during registration.

``` lang-csharp
InputSystem.RegisterLayout(@"
   
       ]
   }
);
```

##### Exceptions

| Type                                                                                                                 | Condition                                                                    |
|----------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentnullexception" class="xref">ArgumentNullException</a> | `json` is null or empty.                                                     |
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentexception" class="xref">ArgumentException</a>         | No name has been supplied either through `name` or the "name" JSON property. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RemoveLayout_System_String_" class="xref">RemoveLayout(string)</a>

<span id="UnityEngine_InputSystem_InputSystem_RegisterLayout_" uid="UnityEngine.InputSystem.InputSystem.RegisterLayout*"></span>

#### RegisterLayout(Type, string, InputDeviceMatcher?)

Register a control layout based on a type.

##### Declaration

``` lang-csharp
public static void RegisterLayout(Type type, string name = null, InputDeviceMatcher? matches = null)
```

##### Parameters

| Type                                                                                                                                                                    | Name                                       | Description                                                                                                                                                                                                    |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Type</a>                                                                                      | <span class="parametername">type</span>    | Type to derive a control layout from. Must be derived from <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html" class="xref">InputControl</a>. |
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a>                                                                                  | <span class="parametername">name</span>    | Name to use for the layout. If null or empty, the short name of the type (`Type.Name`) will be used.                                                                                                           |
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputDeviceMatcher.html" class="xref">InputDeviceMatcher</a>? | <span class="parametername">matches</span> | Optional device matcher. If this is supplied, the layout will automatically be instantiated for newly discovered devices that match the description.                                                           |

##### Remarks

When the layout is instantiated, the system will reflect on all public fields and properties of the type which have a value type derived from <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html" class="xref">InputControl</a> or which are annotated with <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputControlAttribute.html" class="xref">InputControlAttribute</a>.

The type can be annotated with <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputControlLayoutAttribute.html" class="xref">InputControlLayoutAttribute</a> for additional options but the attribute is not necessary for a type to be usable as a control layout. Note that if the type does have <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputControlLayoutAttribute.html" class="xref">InputControlLayoutAttribute</a> and has set <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputControlLayoutAttribute.html#UnityEngine_InputSystem_Layouts_InputControlLayoutAttribute_stateType" class="xref">stateType</a>, the system will *not* reflect on properties and fields in the type but do that on the given state type instead.

``` lang-csharp
// InputControlLayoutAttribute attribute is only necessary if you want
// to override default behavior that occurs when registering your device
// as a layout.
// The most common use of InputControlLayoutAttribute is to direct the system
// to a custom "state struct" through the `stateType` property. See below for details.
[InputControlLayout(displayName = "My Device", stateType = typeof(MyDeviceState))]
#if UNITY_EDITOR
[InitializeOnLoad]
#endif
public class MyDevice : InputDevice

    public AxisControl axis 
// Register the device.
static MyDevice()

// This is only to trigger the static class constructor to automatically run
// in the player.
[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.BeforeSceneLoad)]
internal static void InitializeInPlayer() 
protected override void FinishSetup()

```

}

// A "state struct" describes the memory format used by a device. Each device can // receive and store memory in its custom format. InputControls are then connected // the individual pieces of memory and read out values from them. \[StructLayout(LayoutKind.Explicit, Size = 32)\] public struct MyDeviceState : IInputStateTypeInfo 
Note that if `matches` is supplied, it will immediately be matched against the descriptions (<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputDeviceDescription.html" class="xref">InputDeviceDescription</a>) of all available devices. If it matches any description where no layout matched before, a new device will immediately be created (except if suppressed by <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.html#UnityEngine_InputSystem_InputSettings_supportedDevices" class="xref">supportedDevices</a>). If it matches a description better (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputDeviceMatcher.html#UnityEngine_InputSystem_Layouts_InputDeviceMatcher_MatchPercentage_UnityEngine_InputSystem_Layouts_InputDeviceDescription_" class="xref">MatchPercentage(InputDeviceDescription)</a>) than the currently used layout, the existing device will be a removed and a new device with the newly registered layout will be created.

See <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Controls.StickControl.html" class="xref">StickControl</a> or <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Gamepad.html" class="xref">Gamepad</a> for examples of layouts.

##### Exceptions

| Type                                                                                                                 | Condition         |
|----------------------------------------------------------------------------------------------------------------------|-------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentnullexception" class="xref">ArgumentNullException</a> | `type` is `null`. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputControlLayout.html" class="xref">InputControlLayout</a>

<span id="UnityEngine_InputSystem_InputSystem_RegisterLayoutBuilder_" uid="UnityEngine.InputSystem.InputSystem.RegisterLayoutBuilder*"></span>

#### RegisterLayoutBuilder(Func\<InputControlLayout>, string, string, InputDeviceMatcher?)

Register a builder that delivers an <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputControlLayout.html" class="xref">InputControlLayout</a> instance on demand.

##### Declaration

``` lang-csharp
public static void RegisterLayoutBuilder(Func<InputControlLayout> buildMethod, string name, string baseLayout = null, InputDeviceMatcher? matches = null)
```

##### Parameters

| Type                                                                                                                                                                                                                                                           | Name                                           | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.func-1" class="xref">Func</a>\<<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputControlLayout.html" class="xref">InputControlLayout</a>\> | <span class="parametername">buildMethod</span> | Method to invoke to generate a layout when the layout is chosen. Should not cache the layout but rather return a fresh instance every time.                                                                                                                                                                                                                                                                                                                                                                                                                          |
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a>                                                                                                                                                                         | <span class="parametername">name</span>        | Name under which to register the layout. If a layout with the same name is already registered, the call to this method will replace the existing layout.                                                                                                                                                                                                                                                                                                                                                                                                             |
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a>                                                                                                                                                                         | <span class="parametername">baseLayout</span>  | Name of the layout that the layout returned from `buildMethod` will be based on. The system needs to know this in advance in order to update devices correctly if layout registrations in the system are changed.                                                                                                                                                                                                                                                                                                                                                    |
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputDeviceMatcher.html" class="xref">InputDeviceMatcher</a>?                                                                                        | <span class="parametername">matches</span>     | Optional matcher for an <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputDeviceDescription.html" class="xref">InputDeviceDescription</a>. If supplied, it is equivalent to calling <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RegisterLayoutMatcher_System_String_UnityEngine_InputSystem_Layouts_InputDeviceMatcher_" class="xref">RegisterLayoutMatcher(string, InputDeviceMatcher)</a>. |

##### Remarks

Layout builders are most useful for procedurally building device layouts from metadata supplied by external systems. A good example is <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.HID.html" class="xref">UnityEngine.InputSystem.HID</a> where the "HID" standard includes a way for input devices to describe their various inputs and outputs in the form of a <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.HID.HID.HIDDeviceDescriptor.html" class="xref">HID.HIDDeviceDescriptor</a>. While not sufficient to build a perfectly robust <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a>, these descriptions are usually enough to at least make the device work out-of-the-box to some extent.

The builder method would usually use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputControlLayout.Builder.html" class="xref">InputControlLayout.Builder</a> to build the actual layout.

``` lang-csharp
InputSystem.RegisterLayoutBuilder(
    () =>
    {
        var builder = new InputControlLayout.Builder()
            .WithType<MyDevice>();
        builder.AddControl("button1").WithLayout("Button");
        return builder.Build();
    }, "MyCustomLayout"
}
```

Layout builders can be used in combination with <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_onFindLayoutForDevice" class="xref">onFindLayoutForDevice</a> to build layouts dynamically for devices as they are connected to the system.

Be aware that the same builder *must* not build different layouts. Each layout registered in the system is considered to be immutable for as long as it is registered. So, if a layout builder is registered under the name "Custom", for example, then every time the builder is invoked, it must return the same identical <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputControlLayout.html" class="xref">InputControlLayout</a>.

##### Exceptions

| Type                                                                                                                 | Condition                                               |
|----------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentnullexception" class="xref">ArgumentNullException</a> | `buildMethod` is `null` -or- `name` is `null` or empty. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputControlLayout.html" class="xref">InputControlLayout</a>.<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputControlLayout.Builder.html" class="xref">Builder</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_onFindLayoutForDevice" class="xref">onFindLayoutForDevice</a>

<span id="UnityEngine_InputSystem_InputSystem_RegisterLayoutMatcher_" uid="UnityEngine.InputSystem.InputSystem.RegisterLayoutMatcher*"></span>

#### RegisterLayoutMatcher(string, InputDeviceMatcher)

Add an additional device matcher to an existing layout.

##### Declaration

``` lang-csharp
public static void RegisterLayoutMatcher(string layoutName, InputDeviceMatcher matcher)
```

##### Parameters

| Type                                                                                                                                                                   | Name                                          | Description                                                                                                                                                                                                                                                                          |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a>                                                                                 | <span class="parametername">layoutName</span> | Name of the device layout that should be instantiated if `matcher` matches an <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputDeviceDescription.html" class="xref">InputDeviceDescription</a> of a discovered device. |
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputDeviceMatcher.html" class="xref">InputDeviceMatcher</a> | <span class="parametername">matcher</span>    | Specification to match against <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputDeviceDescription.html" class="xref">InputDeviceDescription</a> instances.                                                             |

##### Remarks

Each device layout can have zero or more matchers associated with it. If any one of the matchers matches a given <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputDeviceDescription.html" class="xref">InputDeviceDescription</a> (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputDeviceMatcher.html#UnityEngine_InputSystem_Layouts_InputDeviceMatcher_MatchPercentage_UnityEngine_InputSystem_Layouts_InputDeviceDescription_" class="xref">MatchPercentage(InputDeviceDescription)</a>) better than any other matcher (for the same or any other layout), then the given layout will be used for the discovered device.

Note that registering a matcher may immediately lead to devices being created or recreated. If `matcher` matches any devices currently on the list of unsupported devices (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_GetUnsupportedDevices" class="xref">GetUnsupportedDevices()</a>), new <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a>s will be created using the layout called `layoutName`. Also, if `matcher` matches the description of a device better than the matcher (if any) for the device's currently used layout, the device will be recreated using the given layout.

##### Exceptions

| Type                                                                                                                 | Condition                                                                                                                                                                                                                                |
|----------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentnullexception" class="xref">ArgumentNullException</a> | `layoutName` is `null` or empty/                                                                                                                                                                                                         |
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentexception" class="xref">ArgumentException</a>         | `matcher` is empty (<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputDeviceMatcher.html#UnityEngine_InputSystem_Layouts_InputDeviceMatcher_empty" class="xref">empty</a>). |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RegisterLayout_System_Type_System_String_System_Nullable_UnityEngine_InputSystem_Layouts_InputDeviceMatcher__" class="xref">RegisterLayout(Type, string, InputDeviceMatcher?)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_TryFindMatchingLayout_UnityEngine_InputSystem_Layouts_InputDeviceDescription_" class="xref">TryFindMatchingLayout(InputDeviceDescription)</a>

<span id="UnityEngine_InputSystem_InputSystem_RegisterLayoutMatcher_" uid="UnityEngine.InputSystem.InputSystem.RegisterLayoutMatcher*"></span>

#### RegisterLayoutMatcher\<TDevice>(InputDeviceMatcher)

Add an additional device matcher to the layout registered for `TDevice`.

##### Declaration

``` lang-csharp
public static void RegisterLayoutMatcher<TDevice>(InputDeviceMatcher matcher) where TDevice : InputDevice
```

##### Parameters

| Type                                                                                                                                                                   | Name                                       | Description       |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------|-------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputDeviceMatcher.html" class="xref">InputDeviceMatcher</a> | <span class="parametername">matcher</span> | A device matcher. |

##### Type Parameters

| Name                                       | Description                                                                                                                                                                                                                                                                                                                                                                        |
|--------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <span class="parametername">TDevice</span> | Type that has been registered as a layout. See <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RegisterLayout__1_System_String_System_Nullable_UnityEngine_InputSystem_Layouts_InputDeviceMatcher__" class="xref">RegisterLayout&lt;T&gt;(string, InputDeviceMatcher?)</a>. |

##### Remarks

Calling this method is equivalent to calling <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RegisterLayoutMatcher_System_String_UnityEngine_InputSystem_Layouts_InputDeviceMatcher_" class="xref">RegisterLayoutMatcher(string, InputDeviceMatcher)</a> with the name under which `TDevice` has been registered.

##### Exceptions

| Type                                                                                                         | Condition                                                                                                                                                                                                                                                                                   |
|--------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentexception" class="xref">ArgumentException</a> | `matcher` is empty (<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputDeviceMatcher.html#UnityEngine_InputSystem_Layouts_InputDeviceMatcher_empty" class="xref">empty</a>) -or- `TDevice` has not been registered as a layout. |

<span id="UnityEngine_InputSystem_InputSystem_RegisterLayoutOverride_" uid="UnityEngine.InputSystem.InputSystem.RegisterLayoutOverride*"></span>

#### RegisterLayoutOverride(string, string)

Register a layout that applies overrides to one or more other layouts.

##### Declaration

``` lang-csharp
public static void RegisterLayoutOverride(string json, string name = null)
```

##### Parameters

| Type                                                                                   | Name                                    | Description                                                                                                                                                                                                                                                                                                                        |
|----------------------------------------------------------------------------------------|-----------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> | <span class="parametername">json</span> | Layout in JSON format.                                                                                                                                                                                                                                                                                                             |
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> | <span class="parametername">name</span> | Optional name of the layout. If null or empty, the name is taken from the "name" property of the JSON data. If it is supplied, it will override the "name" property if present. If neither is supplied, an <a href="https://learn.microsoft.com/dotnet/api/system.argumentexception" class="xref">ArgumentException</a> is thrown. |

##### Remarks

Layout overrides are layout pieces that are applied on top of existing layouts. This can be used to modify any layout in the system non-destructively. The process works the same as extending an existing layout except that instead of creating a new layout by merging the derived layout and the base layout, the overrides are merged directly into the base layout.

The layout merging logic used for overrides, is the same as the one used for derived layouts, i.e. <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputControlLayout.html#UnityEngine_InputSystem_Layouts_InputControlLayout_MergeLayout_UnityEngine_InputSystem_Layouts_InputControlLayout_" class="xref">MergeLayout(InputControlLayout)</a>.

Layouts used as overrides look the same as normal layouts and have the same format. The only difference is that they are explicitly registered as overrides.

Note that unlike "normal" layouts, layout overrides have the ability to extend multiple base layouts. The changes from the override will simply be merged into each of the layouts it extends. Use the `extendMultiple` rather than the `extend` property in JSON to give a list of base layouts instead of a single one.

``` lang-csharp
// Override default button press points on the gamepad triggers.
InputSystem.RegisterLayoutOverride(@"
    {
        ""name"" : ""CustomTriggerPressPoints"",
        ""extend"" : ""Gamepad"",
        ""controls"" : [
            { ""name"" : ""leftTrigger"", ""parameters"" : ""pressPoint=0.25"" },
            
        ]
    }
");
```

<span id="UnityEngine_InputSystem_InputSystem_RegisterLayout_" uid="UnityEngine.InputSystem.InputSystem.RegisterLayout*"></span>

#### RegisterLayout\<T>(string, InputDeviceMatcher?)

Register a type as a control layout.

##### Declaration

``` lang-csharp
public static void RegisterLayout<T>(string name = null, InputDeviceMatcher? matches = null) where T : InputControl
```

##### Parameters

| Type                                                                                                                                                                    | Name                                       | Description                                                                                                                                          |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a>                                                                                  | <span class="parametername">name</span>    | Name to use for the layout. If null or empty, the short name of the type will be used.                                                               |
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputDeviceMatcher.html" class="xref">InputDeviceMatcher</a>? | <span class="parametername">matches</span> | Optional device matcher. If this is supplied, the layout will automatically be instantiated for newly discovered devices that match the description. |

##### Type Parameters

| Name                                 | Description                           |
|--------------------------------------|---------------------------------------|
| <span class="parametername">T</span> | Type to derive a control layout from. |

##### Remarks

This method is equivalent to calling <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RegisterLayout_System_Type_System_String_System_Nullable_UnityEngine_InputSystem_Layouts_InputDeviceMatcher__" class="xref">RegisterLayout(Type, string, InputDeviceMatcher?)</a> with `typeof(T)`. See that method for details of the layout registration process.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RegisterLayout_System_Type_System_String_System_Nullable_UnityEngine_InputSystem_Layouts_InputDeviceMatcher__" class="xref">RegisterLayout(Type, string, InputDeviceMatcher?)</a>

<span id="UnityEngine_InputSystem_InputSystem_RegisterPrecompiledLayout_" uid="UnityEngine.InputSystem.InputSystem.RegisterPrecompiledLayout*"></span>

#### RegisterPrecompiledLayout\<TDevice>(string)

Register a "baked" version of a device layout.

##### Declaration

``` lang-csharp
public static void RegisterPrecompiledLayout<TDevice>(string metadata) where TDevice : InputDevice, new()
```

##### Parameters

| Type                                                                                   | Name                                        | Description                                                  |
|----------------------------------------------------------------------------------------|---------------------------------------------|--------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> | <span class="parametername">metadata</span> | Metadata automatically generated for the precompiled layout. |

##### Type Parameters

| Name                                       | Description                                                                                           |
|--------------------------------------------|-------------------------------------------------------------------------------------------------------|
| <span class="parametername">TDevice</span> | C# class that represents the precompiled version of the device layout that the class is derived from. |

##### Remarks

This method is used to register device implementations for which their layout has been "baked" into a C# class. To generate such a class, right-click a device layout in the input debugger and select "Generate Precompiled Layout". This generates a C# file containing a class that represents the precompiled version of the device layout. The class can be registered using this method.

Note that registering a precompiled layout will not implicitly register the "normal" version of the layout. In other words, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RegisterLayout__1_System_String_System_Nullable_UnityEngine_InputSystem_Layouts_InputDeviceMatcher__" class="xref">RegisterLayout&lt;T&gt;(string, InputDeviceMatcher?)</a> must be called before calling this method.

``` lang-csharp
// Register the non-precompiled, normal version of the layout.
InputSystem.RegisterLayout<MyDevice>();
// Register a precompiled version of the layout.
InputSystem.RegisterPrecompiledLayout<PrecompiledMyDevice>(PrecompiledMyDevice.metadata);
// This implicitly uses the precompiled version.
InputSystem.AddDevice<MyDevice>();
```

The main advantage of precompiled layouts is that instantiating them is many times faster than the default device creation path. By default, when creating an <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a>, the system will have to load the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputControlLayout.html" class="xref">InputControlLayout</a> for the device as well as any layouts used directly or indirectly by that layout. This in itself is a slow process that generates GC heap garbage and uses .NET reflection (which itself may add additional permanent data to the GC heap). In addition, interpreting the layouts to construct an <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a> and populate it with <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html" class="xref">InputControl</a> children is not a fast process.

A precompiled layout, however, has all necessary construction steps "baked" into the generated code. It will not use reflection and will generally generate little to no GC heap garbage.

A precompiled layout derives from the C# device class whose layout is "baked". If, for example, you generate a precompiled version for <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Keyboard.html" class="xref">Keyboard</a>, the resulting class will be derived from <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Keyboard.html" class="xref">Keyboard</a>. When registering the precompiled layout. If someone afterwards creates a <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Keyboard.html" class="xref">Keyboard</a>, the precompiled version will implicitly be instantiated and thus skips the default device creation path that will construct a <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Keyboard.html" class="xref">Keyboard</a> device from an <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputControlLayout.html" class="xref">InputControlLayout</a> (it will thus not require the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Keyboard.html" class="xref">Keyboard</a> layout or any other layout it depends on to be loaded).

Note that when layout overrides (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RegisterLayoutOverride_System_String_System_String_" class="xref">RegisterLayoutOverride(string, string)</a>) or new versions of existing layouts are registered (e.g. if you replace the built-in "Button" layout by registering a new layout with that name), precompiled layouts affected by the change will automatically be *removed*. This causes the system to fall back to the default device creation path which can take runtime layout changes into account.

<span id="UnityEngine_InputSystem_InputSystem_RegisterProcessor_" uid="UnityEngine.InputSystem.InputSystem.RegisterProcessor*"></span>

#### RegisterProcessor(Type, string)

Register an <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputProcessor-1.html" class="xref">InputProcessor&lt;TValue&gt;</a> with the system.

##### Declaration

``` lang-csharp
public static void RegisterProcessor(Type type, string name = null)
```

##### Parameters

| Type                                                                                   | Name                                    | Description                                                                                                                                                                                             |
|----------------------------------------------------------------------------------------|-----------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Type</a>     | <span class="parametername">type</span> | Type that implements <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputProcessor.html" class="xref">InputProcessor</a>.                            |
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> | <span class="parametername">name</span> | Name to use for the processor. If `null` or empty, name will be taken from the short name of `type` (if it ends in "Processor", that suffix will be clipped from the name). Names are case-insensitive. |

##### Remarks

Processors are used by both bindings (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBinding.html" class="xref">InputBinding</a>) and by controls (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html" class="xref">InputControl</a>) to post-process input values as they are being requested from calls such as <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_ReadValue__1" class="xref">ReadValue&lt;TValue&gt;()</a> or <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl-1.html#UnityEngine_InputSystem_InputControl_1_ReadValue" class="xref">ReadValue()</a>.

``` lang-csharp
// Let's say that we want to define a processor that adds some random jitter to its input.
// We have to pick a value type to operate on if we want to derive from InputProcessor<T>
// so we go with float here.
//
// Also, as we will need to place our call to RegisterProcessor somewhere, we add attributes
// to hook into Unity's initialization. This works differently in the editor and in the player,
// so we use both [InitializeOnLoad] and [RuntimeInitializeOnLoadMethod].
#if UNITY_EDITOR
[InitializeOnLoad]
#endif
public class JitterProcessor : InputProcessor<float>

// [InitializeOnLoad] will call the static class constructor which
// we use to call Register.
#if UNITY_EDITOR
static JitterProcessor()

#endif

// [RuntimeInitializeOnLoadMethod] will make sure that Register gets called
// in the player on startup.
// NOTE: This will also get called when going into play mode in the editor. In that
//       case we get two calls to Register instead of one. We don't bother with that
//       here. Calling RegisterProcessor twice here doesn't do any harm.
[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.BeforeSceneLoad)]
static void Register()

```

}

// It doesn't really make sense in our case as the default parameter editor is just // fine (it will pick up the tooltip we defined above) but let's say we want to replace // the default float edit field we get on the "amount" parameter with a slider. We can // do so by defining a custom parameter editor. // // NOTE: We don't need to have a registration call here. The input system will automatically // find our parameter editor based on the JitterProcessor type parameter we give to // InputParameterEditor\<T>. #if UNITY_EDITOR public class JitterProcessorEditor : InputParameterEditor\<JitterProcessor> 
    private GUIContent m_AmountLabel = new GUIContent("Amount",
        "Amount of jitter to apply. Will add a random value in the range [-amount..amount] "
            + "to each input value.);

} #endif

Note that it is allowed to register the same processor type multiple types with different names. When doing so, the first registration is considered as the "proper" name for the processor and all subsequent registrations will be considered aliases.

See the [manual](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/UsingProcessors.html) for more details.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputProcessor-1.html" class="xref">InputProcessor</a>\<TValue>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBinding.html#UnityEngine_InputSystem_InputBinding_processors" class="xref">processors</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_processors" class="xref">processors</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputControlLayout.ControlItem.html#UnityEngine_InputSystem_Layouts_InputControlLayout_ControlItem_processors" class="xref">processors</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Editor.InputParameterEditor-1.html" class="xref">InputParameterEditor</a>\<TObject>

<span id="UnityEngine_InputSystem_InputSystem_RegisterProcessor_" uid="UnityEngine.InputSystem.InputSystem.RegisterProcessor*"></span>

#### RegisterProcessor\<T>(string)

Register an <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputProcessor-1.html" class="xref">InputProcessor&lt;TValue&gt;</a> with the system.

##### Declaration

``` lang-csharp
public static void RegisterProcessor<T>(string name = null)
```

##### Parameters

| Type                                                                                   | Name                                    | Description                                                                                                                                                                                          |
|----------------------------------------------------------------------------------------|-----------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> | <span class="parametername">name</span> | Name to use for the processor. If `null` or empty, name will be taken from the short name of `T` (if it ends in "Processor", that suffix will be clipped from the name). Names are case-insensitive. |

##### Type Parameters

| Name                                 | Description                                                                                                                                                                  |
|--------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <span class="parametername">T</span> | Type that implements <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputProcessor.html" class="xref">InputProcessor</a>. |

##### Remarks

Processors are used by both bindings (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBinding.html" class="xref">InputBinding</a>) and by controls (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html" class="xref">InputControl</a>) to post-process input values as they are being requested from calls such as <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_ReadValue__1" class="xref">ReadValue&lt;TValue&gt;()</a> or <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl-1.html#UnityEngine_InputSystem_InputControl_1_ReadValue" class="xref">ReadValue()</a>.

``` lang-csharp
// Let's say that we want to define a processor that adds some random jitter to its input.
// We have to pick a value type to operate on if we want to derive from InputProcessor<T>
// so we go with float here.
//
// Also, as we will need to place our call to RegisterProcessor somewhere, we add attributes
// to hook into Unity's initialization. This works differently in the editor and in the player,
// so we use both [InitializeOnLoad] and [RuntimeInitializeOnLoadMethod].
#if UNITY_EDITOR
[InitializeOnLoad]
#endif
public class JitterProcessor : InputProcessor<float>

// [InitializeOnLoad] will call the static class constructor which
// we use to call Register.
#if UNITY_EDITOR
static JitterProcessor()

#endif

// [RuntimeInitializeOnLoadMethod] will make sure that Register gets called
// in the player on startup.
// NOTE: This will also get called when going into play mode in the editor. In that
//       case we get two calls to Register instead of one. We don't bother with that
//       here. Calling RegisterProcessor twice here doesn't do any harm.
[RuntimeInitializeOnLoadMethod]
static void Register()

```

}

// It doesn't really make sense in our case as the default parameter editor is just // fine (it will pick up the tooltip we defined above) but let's say we want to replace // the default float edit field we get on the "amount" parameter with a slider. We can // do so by defining a custom parameter editor. // // NOTE: We don't need to have a registration call here. The input system will automatically // find our parameter editor based on the JitterProcessor type parameter we give to // InputParameterEditor\<T>. #if UNITY_EDITOR public class JitterProcessorEditor : InputParameterEditor\<JitterProcessor> 
    private GUIContent m_AmountLabel = new GUIContent("Amount",
        "Amount of jitter to apply. Will add a random value in the range [-amount..amount] "
            + "to each input value.);

} #endif

Note that it is allowed to register the same processor type multiple types with different names. When doing so, the first registration is considered as the "proper" name for the processor and all subsequent registrations will be considered aliases.

See the [manual](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/UsingProcessors.html) for more details.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputProcessor-1.html" class="xref">InputProcessor</a>\<TValue>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBinding.html#UnityEngine_InputSystem_InputBinding_processors" class="xref">processors</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_processors" class="xref">processors</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputControlLayout.ControlItem.html#UnityEngine_InputSystem_Layouts_InputControlLayout_ControlItem_processors" class="xref">processors</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Editor.InputParameterEditor-1.html" class="xref">InputParameterEditor</a>\<TObject>

<span id="UnityEngine_InputSystem_InputSystem_RemoveDevice_" uid="UnityEngine.InputSystem.InputSystem.RemoveDevice*"></span>

#### RemoveDevice(InputDevice)

Remove a device from the system such that it no longer receives input and is no longer part of the set of devices in <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_devices" class="xref">devices</a>.

##### Declaration

``` lang-csharp
public static void RemoveDevice(InputDevice device)
```

##### Parameters

| Type                                                                                                                                             | Name                                      | Description                                                                                                                                                                                                                                                                                |
|--------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a> | <span class="parametername">device</span> | Device to remove. If the device has already been removed (i.e. if <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html#UnityEngine_InputSystem_InputDevice_added" class="xref">added</a> is false), the method does nothing. |

##### Remarks

Actions that are bound to controls on the device will automatically unbind when the device is removed.

When a device is removed, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_onDeviceChange" class="xref">onDeviceChange</a> will be triggered with <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDeviceChange.html#UnityEngine_InputSystem_InputDeviceChange_Removed" class="xref">Removed</a>. The device will be removed from <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_devices" class="xref">devices</a> as well as from any device-specific getters such as <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Gamepad.html#UnityEngine_InputSystem_Gamepad_all" class="xref">all</a>.

##### Exceptions

| Type                                                                                                                 | Condition         |
|----------------------------------------------------------------------------------------------------------------------|-------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentnullexception" class="xref">ArgumentNullException</a> | `device` is null. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html#UnityEngine_InputSystem_InputDevice_added" class="xref">added</a>

<span id="UnityEngine_InputSystem_InputSystem_RemoveDeviceUsage_" uid="UnityEngine.InputSystem.InputSystem.RemoveDeviceUsage*"></span>

#### RemoveDeviceUsage(InputDevice, string)

Remove a usage tag from the given device.

##### Declaration

``` lang-csharp
public static void RemoveDeviceUsage(InputDevice device, string usage)
```

##### Parameters

| Type                                                                                                                                             | Name                                      | Description                      |
|--------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------|----------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a> | <span class="parametername">device</span> | Device to remove the usage from. |
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a>                                                           | <span class="parametername">usage</span>  | Usage to remove from the device. |

##### Remarks

This method removes an existing usage from the given device. If the device does not have the given usage tag, the method does nothing. Use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_SetDeviceUsage_UnityEngine_InputSystem_InputDevice_System_String_" class="xref">SetDeviceUsage(InputDevice, string)</a> or <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_AddDeviceUsage_UnityEngine_InputSystem_InputDevice_System_String_" class="xref">AddDeviceUsage(InputDevice, string)</a> to add usages to a device.

The set of usages a device has can be queried with <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html#UnityEngine_InputSystem_InputControl_usages" class="xref">usages</a> (a device is an <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html" class="xref">InputControl</a> and thus, like controls, has an associated set of usages).

If the set of usages on the device changes as a result of calling this method, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_onDeviceChange" class="xref">onDeviceChange</a> will be triggered with <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDeviceChange.html#UnityEngine_InputSystem_InputDeviceChange_UsageChanged" class="xref">UsageChanged</a>.

##### Exceptions

| Type                                                                                                                 | Condition                 |
|----------------------------------------------------------------------------------------------------------------------|---------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentnullexception" class="xref">ArgumentNullException</a> | `device` is null.         |
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentexception" class="xref">ArgumentException</a>         | `usage` is null or empty. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html#UnityEngine_InputSystem_InputControl_usages" class="xref">usages</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_SetDeviceUsage_UnityEngine_InputSystem_InputDevice_System_String_" class="xref">SetDeviceUsage(InputDevice, string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_AddDeviceUsage_UnityEngine_InputSystem_InputDevice_System_String_" class="xref">AddDeviceUsage(InputDevice, string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.CommonUsages.html" class="xref">CommonUsages</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDeviceChange.html#UnityEngine_InputSystem_InputDeviceChange_UsageChanged" class="xref">UsageChanged</a>

<span id="UnityEngine_InputSystem_InputSystem_RemoveDeviceUsage_" uid="UnityEngine.InputSystem.InputSystem.RemoveDeviceUsage*"></span>

#### RemoveDeviceUsage(InputDevice, InternedString)

Remove a usage tag from the given device.

##### Declaration

``` lang-csharp
public static void RemoveDeviceUsage(InputDevice device, InternedString usage)
```

##### Parameters

| Type                                                                                                                                                             | Name                                      | Description                      |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------|----------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a>                 | <span class="parametername">device</span> | Device to remove the usage from. |
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Utilities.InternedString.html" class="xref">InternedString</a> | <span class="parametername">usage</span>  | Usage to remove from the device. |

##### Remarks

This method removes an existing usage from the given device. If the device does not have the given usage tag, the method does nothing. Use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_SetDeviceUsage_UnityEngine_InputSystem_InputDevice_UnityEngine_InputSystem_Utilities_InternedString_" class="xref">SetDeviceUsage(InputDevice, InternedString)</a> or <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_AddDeviceUsage_UnityEngine_InputSystem_InputDevice_UnityEngine_InputSystem_Utilities_InternedString_" class="xref">AddDeviceUsage(InputDevice, InternedString)</a> to add usages to a device.

The set of usages a device has can be queried with <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html#UnityEngine_InputSystem_InputControl_usages" class="xref">usages</a> (a device is an <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html" class="xref">InputControl</a> and thus, like controls, has an associated set of usages).

If the set of usages on the device changes as a result of calling this method, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_onDeviceChange" class="xref">onDeviceChange</a> will be triggered with <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDeviceChange.html#UnityEngine_InputSystem_InputDeviceChange_UsageChanged" class="xref">UsageChanged</a>.

##### Exceptions

| Type                                                                                                                 | Condition         |
|----------------------------------------------------------------------------------------------------------------------|-------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentnullexception" class="xref">ArgumentNullException</a> | `device` is null. |
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentexception" class="xref">ArgumentException</a>         | `usage` is empty. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html#UnityEngine_InputSystem_InputControl_usages" class="xref">usages</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_SetDeviceUsage_UnityEngine_InputSystem_InputDevice_UnityEngine_InputSystem_Utilities_InternedString_" class="xref">SetDeviceUsage(InputDevice, InternedString)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_AddDeviceUsage_UnityEngine_InputSystem_InputDevice_UnityEngine_InputSystem_Utilities_InternedString_" class="xref">AddDeviceUsage(InputDevice, InternedString)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.CommonUsages.html" class="xref">CommonUsages</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDeviceChange.html#UnityEngine_InputSystem_InputDeviceChange_UsageChanged" class="xref">UsageChanged</a>

<span id="UnityEngine_InputSystem_InputSystem_RemoveLayout_" uid="UnityEngine.InputSystem.InputSystem.RemoveLayout*"></span>

#### RemoveLayout(string)

Remove an already registered layout from the system.

##### Declaration

``` lang-csharp
public static void RemoveLayout(string name)
```

##### Parameters

| Type                                                                                   | Name                                    | Description                                                                |
|----------------------------------------------------------------------------------------|-----------------------------------------|----------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> | <span class="parametername">name</span> | Name of the layout to remove. Note that layout names are case-insensitive. |

##### Remarks

Note that removing a layout also removes all devices that directly or indirectly use the layout.

This method can be used to remove both control or device layouts.

<span id="UnityEngine_InputSystem_InputSystem_ResetDevice_" uid="UnityEngine.InputSystem.InputSystem.ResetDevice*"></span>

#### ResetDevice(InputDevice, bool)

Reset the state of the given device.

##### Declaration

``` lang-csharp
public static void ResetDevice(InputDevice device, bool alsoResetDontResetControls = false)
```

##### Parameters

| Type                                                                                                                                             | Name                                                          | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|--------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a> | <span class="parametername">device</span>                     | Device to reset. Must be <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html#UnityEngine_InputSystem_InputDevice_added" class="xref">added</a> to the system.                                                                                                                                                                                                                                                                         |
| <a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">bool</a>                                                            | <span class="parametername">alsoResetDontResetControls</span> | If true, also reset controls that are marked as <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputControlAttribute.html#UnityEngine_InputSystem_Layouts_InputControlAttribute_dontReset" class="xref">dontReset</a>. Leads to <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDeviceChange.html#UnityEngine_InputSystem_InputDeviceChange_HardReset" class="xref">HardReset</a>. |

##### Remarks

There are two different kinds of resets performed by the input system: a "soft" reset and a "hard" reset.

A "hard" reset resets all controls on the device to their default state and also sends a <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.RequestResetCommand.html" class="xref">RequestResetCommand</a> to the backend, instructing to also reset its own internal state (if any) to the default.

A "soft" reset will reset only controls that are not marked as <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputControlAttribute.html#UnityEngine_InputSystem_Layouts_InputControlAttribute_noisy" class="xref">noisy</a> and not marked as <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputControlAttribute.html#UnityEngine_InputSystem_Layouts_InputControlAttribute_dontReset" class="xref">dontReset</a>. It will also not set a <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.RequestResetCommand.html" class="xref">RequestResetCommand</a> to the backend, i.e. the reset will be internal to the input system only (and thus can be partial in nature).

By default, the method will perform a "soft" reset if `device` has <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputControlAttribute.html#UnityEngine_InputSystem_Layouts_InputControlAttribute_noisy" class="xref">noisy</a> or <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputControlAttribute.html#UnityEngine_InputSystem_Layouts_InputControlAttribute_dontReset" class="xref">dontReset</a> controls. If it does not, it will perform a "hard" reset.

A "hard" reset can be forced by setting `alsoResetDontResetControls` to true.

``` lang-csharp
// "Soft" reset the mouse. This will leave controls such as the mouse position intact
// but will reset button press states.
InputSystem.ResetDevice(Mouse.current);
// "Hard" reset the mouse. This will wipe everything and reset the mouse to its default
// state.
InputSystem.ResetDevice(Mouse.current, alsoResetDontResetControls: true);
```

Resetting a device will trigger a <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDeviceChange.html#UnityEngine_InputSystem_InputDeviceChange_SoftReset" class="xref">SoftReset</a> or <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDeviceChange.html#UnityEngine_InputSystem_InputDeviceChange_HardReset" class="xref">HardReset</a> (based on the value of `alsoResetDontResetControls`) notification on <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_onDeviceChange" class="xref">onDeviceChange</a>. Also, all <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html" class="xref">InputAction</a>s currently in progress from controls on `device` will be cancelled (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_canceled" class="xref">canceled</a>) in a way that guarantees for them to not get triggered. That is, a reset is semantically different from simply sending an event with default state. Using the latter, a button may be considered as going from pressed to released whereas with a device reset, the change back to unpressed state will not be considered a button release (and thus not trigger interactions that are waiting for a button release).

##### Exceptions

| Type                                                                                                                         | Condition                                                                                                                                                                                                   |
|------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentnullexception" class="xref">ArgumentNullException</a>         | `device` is `null`.                                                                                                                                                                                         |
| <a href="https://learn.microsoft.com/dotnet/api/system.invalidoperationexception" class="xref">InvalidOperationException</a> | `device` has not been <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html#UnityEngine_InputSystem_InputDevice_added" class="xref">added</a>. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_TrySyncDevice_UnityEngine_InputSystem_InputDevice_" class="xref">TrySyncDevice(InputDevice)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDeviceChange.html#UnityEngine_InputSystem_InputDeviceChange_HardReset" class="xref">HardReset</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDeviceChange.html#UnityEngine_InputSystem_InputDeviceChange_SoftReset" class="xref">SoftReset</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.DeviceResetEvent.html" class="xref">DeviceResetEvent</a>

<span id="UnityEngine_InputSystem_InputSystem_ResetHaptics_" uid="UnityEngine.InputSystem.InputSystem.ResetHaptics*"></span>

#### ResetHaptics()

Stop haptic effect playback on all devices.

##### Declaration

``` lang-csharp
public static void ResetHaptics()
```

##### Remarks

Will reset haptics effects on all devices to their default state.

Calls <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Haptics.IHaptics.html#UnityEngine_InputSystem_Haptics_IHaptics_ResetHaptics" class="xref">ResetHaptics()</a> on all <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">input devices</a> that implement the interface.

<span id="UnityEngine_InputSystem_InputSystem_ResumeHaptics_" uid="UnityEngine.InputSystem.InputSystem.ResumeHaptics*"></span>

#### ResumeHaptics()

Resume haptic effect playback on all devices.

##### Declaration

``` lang-csharp
public static void ResumeHaptics()
```

##### Remarks

Calls <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Haptics.IHaptics.html#UnityEngine_InputSystem_Haptics_IHaptics_ResumeHaptics" class="xref">ResumeHaptics()</a> on all <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">input devices</a> that implement the interface.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_PauseHaptics" class="xref">PauseHaptics()</a>

<span id="UnityEngine_InputSystem_InputSystem_SetDeviceUsage_" uid="UnityEngine.InputSystem.InputSystem.SetDeviceUsage*"></span>

#### SetDeviceUsage(InputDevice, string)

Set the usage tag of the given device to `usage`.

##### Declaration

``` lang-csharp
public static void SetDeviceUsage(InputDevice device, string usage)
```

##### Parameters

| Type                                                                                                                                             | Name                                      | Description                 |
|--------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------|-----------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a> | <span class="parametername">device</span> | Device to set the usage on. |
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a>                                                           | <span class="parametername">usage</span>  | New usage for the device.   |

##### Remarks

Usages allow to "tag" a specific device such that the tag can then be used in lookups and bindings. A common use is for identifying the handedness of an <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.XR.XRController.html" class="xref">XRController</a> but the usages can be arbitrary strings.

This method either sets the usages of the device to a single string (meaning it will clear whatever, if any usages, the device has when the method is called) or, if `usage` is null or empty, resets the usages of the device to be empty. To add to a device's set of usages, call <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_AddDeviceUsage_UnityEngine_InputSystem_InputDevice_System_String_" class="xref">AddDeviceUsage(InputDevice, string)</a>. To remove usages from a device, call <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RemoveDeviceUsage_UnityEngine_InputSystem_InputDevice_System_String_" class="xref">RemoveDeviceUsage(InputDevice, string)</a>.

The set of usages a device has can be queried with <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html#UnityEngine_InputSystem_InputControl_usages" class="xref">usages</a> (a device is an <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html" class="xref">InputControl</a> and thus, like controls, has an associated set of usages).

``` lang-csharp
// Tag a gamepad to be associated with player #1.
InputSystem.SetDeviceUsage(myGamepad, "Player1");
// Create an action that binds to player #1's gamepad specifically.
var action = new InputAction(binding: "<Gamepad>/buttonSouth");
// Move the tag from one gamepad to another.
InputSystem.SetDeviceUsage(myGamepad, null); // Clears usages on 'myGamepad'.
InputSystem.SetDeviceUsage(otherGamepad, "Player1");
```

##### Exceptions

| Type                                                                                                                 | Condition         |
|----------------------------------------------------------------------------------------------------------------------|-------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentnullexception" class="xref">ArgumentNullException</a> | `device` is null. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html#UnityEngine_InputSystem_InputControl_usages" class="xref">usages</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_AddDeviceUsage_UnityEngine_InputSystem_InputDevice_System_String_" class="xref">AddDeviceUsage(InputDevice, string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RemoveDeviceUsage_UnityEngine_InputSystem_InputDevice_System_String_" class="xref">RemoveDeviceUsage(InputDevice, string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.CommonUsages.html" class="xref">CommonUsages</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDeviceChange.html#UnityEngine_InputSystem_InputDeviceChange_UsageChanged" class="xref">UsageChanged</a>

<span id="UnityEngine_InputSystem_InputSystem_SetDeviceUsage_" uid="UnityEngine.InputSystem.InputSystem.SetDeviceUsage*"></span>

#### SetDeviceUsage(InputDevice, InternedString)

Set the usage tag of the given device to `usage`.

##### Declaration

``` lang-csharp
public static void SetDeviceUsage(InputDevice device, InternedString usage)
```

##### Parameters

| Type                                                                                                                                                             | Name                                      | Description                 |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------|-----------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a>                 | <span class="parametername">device</span> | Device to set the usage on. |
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Utilities.InternedString.html" class="xref">InternedString</a> | <span class="parametername">usage</span>  | New usage for the device.   |

##### Remarks

Usages allow to "tag" a specific device such that the tag can then be used in lookups and bindings. A common use is for identifying the handedness of an <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.XR.XRController.html" class="xref">XRController</a> but the usages can be arbitrary strings.

This method either sets the usages of the device to a single string (meaning it will clear whatever, if any usages, the device has when the method is called) or, if `usage` is null or empty, resets the usages of the device to be empty. To add to a device's set of usages, call <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_AddDeviceUsage_UnityEngine_InputSystem_InputDevice_UnityEngine_InputSystem_Utilities_InternedString_" class="xref">AddDeviceUsage(InputDevice, InternedString)</a>. To remove usages from a device, call <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RemoveDeviceUsage_UnityEngine_InputSystem_InputDevice_UnityEngine_InputSystem_Utilities_InternedString_" class="xref">RemoveDeviceUsage(InputDevice, InternedString)</a>.

The set of usages a device has can be queried with <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html#UnityEngine_InputSystem_InputControl_usages" class="xref">usages</a> (a device is an <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html" class="xref">InputControl</a> and thus, like controls, has an associated set of usages).

If the set of usages on the device changes as a result of calling this method, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_onDeviceChange" class="xref">onDeviceChange</a> will be triggered with <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDeviceChange.html#UnityEngine_InputSystem_InputDeviceChange_UsageChanged" class="xref">UsageChanged</a>.

``` lang-csharp
// Tag a gamepad to be associated with player #1.
InputSystem.SetDeviceUsage(myGamepad, new InternedString("Player1"));
// Create an action that binds to player #1's gamepad specifically.
var action = new InputAction(binding: "<Gamepad>/buttonSouth");
// Move the tag from one gamepad to another.
InputSystem.SetDeviceUsage(myGamepad, null); // Clears usages on 'myGamepad'.
InputSystem.SetDeviceUsage(otherGamepad, new InternedString("Player1"));
```

##### Exceptions

| Type                                                                                                                 | Condition         |
|----------------------------------------------------------------------------------------------------------------------|-------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentnullexception" class="xref">ArgumentNullException</a> | `device` is null. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html#UnityEngine_InputSystem_InputControl_usages" class="xref">usages</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_AddDeviceUsage_UnityEngine_InputSystem_InputDevice_UnityEngine_InputSystem_Utilities_InternedString_" class="xref">AddDeviceUsage(InputDevice, InternedString)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RemoveDeviceUsage_UnityEngine_InputSystem_InputDevice_UnityEngine_InputSystem_Utilities_InternedString_" class="xref">RemoveDeviceUsage(InputDevice, InternedString)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.CommonUsages.html" class="xref">CommonUsages</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDeviceChange.html#UnityEngine_InputSystem_InputDeviceChange_UsageChanged" class="xref">UsageChanged</a>

<span id="UnityEngine_InputSystem_InputSystem_TryFindMatchingLayout_" uid="UnityEngine.InputSystem.InputSystem.TryFindMatchingLayout*"></span>

#### TryFindMatchingLayout(InputDeviceDescription)

Try to match a description for an input device to a layout.

##### Declaration

``` lang-csharp
public static string TryFindMatchingLayout(InputDeviceDescription deviceDescription)
```

##### Parameters

| Type                                                                                                                                                                           | Name                                                 | Description                     |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------|---------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputDeviceDescription.html" class="xref">InputDeviceDescription</a> | <span class="parametername">deviceDescription</span> | Description of an input device. |

##### Returns

| Type                                                                                   | Description                                                                                                |
|----------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> | Name of the layout that has been matched to the given description or null if no matching layout was found. |

##### Remarks

This method performs the same matching process that is invoked if a device is reported by the Unity runtime or using <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_AddDevice_UnityEngine_InputSystem_Layouts_InputDeviceDescription_" class="xref">AddDevice(InputDeviceDescription)</a>. The result depends on the matches (<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputDeviceMatcher.html" class="xref">InputDeviceMatcher</a>) registered for the device layout in the system.

``` lang-csharp
var layoutName = InputSystem.TryFindMatchingLayout(
    new InputDeviceDescription
    
);
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RegisterLayoutMatcher__1_UnityEngine_InputSystem_Layouts_InputDeviceMatcher_" class="xref">RegisterLayoutMatcher&lt;TDevice&gt;(InputDeviceMatcher)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RegisterLayoutMatcher_System_String_UnityEngine_InputSystem_Layouts_InputDeviceMatcher_" class="xref">RegisterLayoutMatcher(string, InputDeviceMatcher)</a>

<span id="UnityEngine_InputSystem_InputSystem_TryGetBindingComposite_" uid="UnityEngine.InputSystem.InputSystem.TryGetBindingComposite*"></span>

#### TryGetBindingComposite(string)

Search for a registered binding composite type with the given name.

##### Declaration

``` lang-csharp
public static Type TryGetBindingComposite(string name)
```

##### Parameters

| Type                                                                                   | Name                                    | Description                                             |
|----------------------------------------------------------------------------------------|-----------------------------------------|---------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> | <span class="parametername">name</span> | Name of the registered binding composite to search for. |

##### Returns

| Type                                                                               | Description                                                                                             |
|------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Type</a> | The type of the binding composite, if one was previously registered with the give name, otherwise null. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBindingComposite.html" class="xref">InputBindingComposite</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RegisterBindingComposite_System_Type_System_String_" class="xref">RegisterBindingComposite(Type, string)</a>

<span id="UnityEngine_InputSystem_InputSystem_TryGetInteraction_" uid="UnityEngine.InputSystem.InputSystem.TryGetInteraction*"></span>

#### TryGetInteraction(string)

Search for a registered interaction type with the given name.

##### Declaration

``` lang-csharp
public static Type TryGetInteraction(string name)
```

##### Parameters

| Type                                                                                   | Name                                    | Description                                       |
|----------------------------------------------------------------------------------------|-----------------------------------------|---------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> | <span class="parametername">name</span> | Name of the registered interaction to search for. |

##### Returns

| Type                                                                               | Description                                                                                       |
|------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Type</a> | The type of the interaction, if one was previously registered with the give name, otherwise null. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.IInputInteraction.html" class="xref">IInputInteraction</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RegisterInteraction_System_Type_System_String_" class="xref">RegisterInteraction(Type, string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_ListInteractions" class="xref">ListInteractions()</a>

<span id="UnityEngine_InputSystem_InputSystem_TryGetProcessor_" uid="UnityEngine.InputSystem.InputSystem.TryGetProcessor*"></span>

#### TryGetProcessor(string)

Return the processor type registered under the given name. If no such processor has been registered, return `null`.

##### Declaration

``` lang-csharp
public static Type TryGetProcessor(string name)
```

##### Parameters

| Type                                                                                   | Name                                    | Description                          |
|----------------------------------------------------------------------------------------|-----------------------------------------|--------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> | <span class="parametername">name</span> | Name of processor. Case-insensitive. |

##### Returns

| Type                                                                               | Description                                      |
|------------------------------------------------------------------------------------|--------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Type</a> | The given processor type or `null` if not found. |

##### Exceptions

| Type                                                                                                                 | Condition                  |
|----------------------------------------------------------------------------------------------------------------------|----------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentnullexception" class="xref">ArgumentNullException</a> | `name` is `null` or empty. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RegisterProcessor__1_System_String_" class="xref">RegisterProcessor&lt;T&gt;(string)</a>

<span id="UnityEngine_InputSystem_InputSystem_TrySyncDevice_" uid="UnityEngine.InputSystem.InputSystem.TrySyncDevice*"></span>

#### TrySyncDevice(InputDevice)

Issue a <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.RequestSyncCommand.html" class="xref">RequestSyncCommand</a> on `device`. This requests the device to send its current state as an event. If successful, the device will be updated in the next <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_Update" class="xref">Update()</a>.

##### Declaration

``` lang-csharp
public static bool TrySyncDevice(InputDevice device)
```

##### Parameters

| Type                                                                                                                                             | Name                                      | Description                                                                                                                                                                                                                                                                                                                                                             |
|--------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a> | <span class="parametername">device</span> | An <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a> that is currently part of <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_devices" class="xref">devices</a>. |

##### Returns

| Type                                                                                  | Description                                       |
|---------------------------------------------------------------------------------------|---------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">bool</a> | True if the request succeeded, false if it fails. |

##### Remarks

It depends on the backend/platform implementation whether explicit synchronization is supported. If it is, the method will return true. If it is not, the method will return false and the request is ignored.

##### Exceptions

| Type                                                                                                                         | Condition                                                                                                                                                                                                   |
|------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentnullexception" class="xref">ArgumentNullException</a>         | `device` is `null`.                                                                                                                                                                                         |
| <a href="https://learn.microsoft.com/dotnet/api/system.invalidoperationexception" class="xref">InvalidOperationException</a> | `device` has not been <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html#UnityEngine_InputSystem_InputDevice_added" class="xref">added</a>. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.RequestSyncCommand.html" class="xref">RequestSyncCommand</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_ResetDevice_UnityEngine_InputSystem_InputDevice_System_Boolean_" class="xref">ResetDevice(InputDevice, bool)</a>

<span id="UnityEngine_InputSystem_InputSystem_Update_" uid="UnityEngine.InputSystem.InputSystem.Update*"></span>

#### Update()

Run a single update of input state.

##### Declaration

``` lang-csharp
public static void Update()
```

##### Remarks

Except in tests and when using <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.UpdateMode.html#UnityEngine_InputSystem_InputSettings_UpdateMode_ProcessEventsManually" class="xref">ProcessEventsManually</a>, this method should not normally be called. The input system will automatically update as part of the player loop as determined by <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.html#UnityEngine_InputSystem_InputSettings_updateMode" class="xref">updateMode</a>. Calling this method is equivalent to inserting extra frames, i.e. it will advance the entire state of the input system by one complete frame.

When using <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.InputUpdateType.html#UnityEngine_InputSystem_LowLevel_InputUpdateType_Manual" class="xref">Manual</a>, this method MUST be called for input to update in the player. Not calling the method as part of the player loop may result in excessive memory consumption and/or potential loss of input.

Each update will flush out buffered input events and cause them to be processed. This in turn will update the state of input devices (<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a>) and trigger actions (<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html" class="xref">InputAction</a>) that monitor affected device state.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.InputUpdateType.html" class="xref">InputUpdateType</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.html#UnityEngine_InputSystem_InputSettings_updateMode" class="xref">updateMode</a>

### Events

#### customBindingPathValidators

##### Declaration

``` lang-csharp
public static event Func<string, Action> customBindingPathValidators
```

##### Event Type

| Type                                                                                                                                                                                                                                                                   | Description |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.func-2" class="xref">Func</a>\<<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a>, <a href="https://learn.microsoft.com/dotnet/api/system.action" class="xref">Action</a>\> |             |

#### onActionChange

Event that is signalled when the state of enabled actions in the system changes or when actions are triggered.

##### Declaration

``` lang-csharp
public static event Action<object, InputActionChange> onActionChange
```

##### Event Type

| Type                                                                                                                                                                                                                                                                                                                                             | Description |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.action-2" class="xref">Action</a>\<<a href="https://learn.microsoft.com/dotnet/api/system.object" class="xref">object</a>, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionChange.html" class="xref">InputActionChange</a>\> |             |

##### Remarks

The object received by the callback is either an <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html" class="xref">InputAction</a>, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref">InputActionMap</a>, or <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionAsset.html" class="xref">InputActionAsset</a> depending on whether the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionChange.html" class="xref">InputActionChange</a> affects a single action, an entire action map, or an entire action asset.

For <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionChange.html#UnityEngine_InputSystem_InputActionChange_BoundControlsAboutToChange" class="xref">BoundControlsAboutToChange</a> and <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionChange.html#UnityEngine_InputSystem_InputActionChange_BoundControlsChanged" class="xref">BoundControlsChanged</a>, the given object is an <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html" class="xref">InputAction</a> if the action is not part of an action map, an <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref">InputActionMap</a> if the actions are part of a map but not part of an asset, and an <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionAsset.html" class="xref">InputActionAsset</a> if the actions are part of an asset. In other words, the notification is sent for the topmost object in the hierarchy.

##### Examples

``` lang-csharp
InputSystem.onActionChange +=
    (obj, change) =>
    
        else if (change == InputActionChange.ActionMapEnabled)
        
        else if (change == InputActionChange.BoundControlsChanged)
        
    };
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_controls" class="xref">controls</a>

#### onActionsChange

Event that is triggered if the instance assigned to property <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_actions" class="xref">actions</a> changes.

##### Declaration

``` lang-csharp
public static event Action onActionsChange
```

##### Event Type

| Type                                                                                   | Description |
|----------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.action" class="xref">Action</a> |             |

##### Remarks

Note that any event handlers registered to this event will only receive callbacks in Edit mode since assigning `InputSystem.actions` is not possible in Play mode.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_actions" class="xref">actions</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionAsset.html" class="xref">InputActionAsset</a>

#### onAfterUpdate

Event that is fired after the input system has completed an update and processed all pending events.

##### Declaration

``` lang-csharp
public static event Action onAfterUpdate
```

##### Event Type

| Type                                                                                   | Description |
|----------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.action" class="xref">Action</a> |             |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_onBeforeUpdate" class="xref">onBeforeUpdate</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_Update" class="xref">Update()</a>

#### onBeforeUpdate

Event that is fired before the input system updates.

##### Declaration

``` lang-csharp
public static event Action onBeforeUpdate
```

##### Event Type

| Type                                                                                   | Description |
|----------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.action" class="xref">Action</a> |             |

##### Remarks

The input system updates in sync with player loop and editor updates. Input updates are run right before the respective script update. For example, an input update for <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.InputUpdateType.html#UnityEngine_InputSystem_LowLevel_InputUpdateType_Dynamic" class="xref">Dynamic</a> is run before `MonoBehaviour.Update` methods are executed.

The update callback itself is triggered before the input system runs its own update and before it flushes out its event queue. This means that events queued from a callback will be fed right into the upcoming update.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_onAfterUpdate" class="xref">onAfterUpdate</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_Update" class="xref">Update()</a>

#### onDeviceChange

Event that is signalled when the device setup in the system changes.

##### Declaration

``` lang-csharp
public static event Action<InputDevice, InputDeviceChange> onDeviceChange
```

##### Event Type

| Type                                                                                                                                                                                                                                                                                                                                                                                                       | Description                                   |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.action-2" class="xref">Action</a>\<<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a>, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDeviceChange.html" class="xref">InputDeviceChange</a>\> | Callback when device setup ni system changes. |

##### Remarks

This can be used to detect when devices are added or removed as well as detecting when existing devices change their configuration.

``` lang-csharp
InputSystem.onDeviceChange +=
    (device, change) =>
    
    };
```

##### Exceptions

| Type                                                                                                                 | Condition                     |
|----------------------------------------------------------------------------------------------------------------------|-------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentnullexception" class="xref">ArgumentNullException</a> | Delegate reference is `null`. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_devices" class="xref">devices</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_AddDevice__1_System_String_" class="xref">AddDevice&lt;TDevice&gt;(string)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RemoveDevice_UnityEngine_InputSystem_InputDevice_" class="xref">RemoveDevice(InputDevice)</a>

#### onDeviceCommand

Event that is signalled when an <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.InputDeviceCommand.html" class="xref">InputDeviceCommand</a> is sent to an <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a>.

##### Declaration

``` lang-csharp
public static event InputDeviceCommandDelegate onDeviceCommand
```

##### Event Type

| Type                                                                                                                                                                                    | Description                                                                                                                                                                                            |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.InputDeviceCommandDelegate.html" class="xref">InputDeviceCommandDelegate</a> | Event that gets signalled on <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.InputDeviceCommand.html" class="xref">InputDeviceCommand</a>s. |

##### Remarks

This can be used to intercept commands and optionally handle them without them reaching the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.IInputRuntime.html" class="xref">IInputRuntime</a>.

The first delegate in the list that returns a result other than `null` is considered to have handled the command. If a command is handled by a delegate in the list, it will not be sent on to the runtime.

##### Exceptions

| Type                                                                                                                 | Condition                     |
|----------------------------------------------------------------------------------------------------------------------|-------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentnullexception" class="xref">ArgumentNullException</a> | Delegate reference is `null`. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html#UnityEngine.InputSystem.InputDevice.ExecuteCommand%60%601(%60%600@)" class="xref">ExecuteCommand</a>\<TCommand>(ref TCommand)

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.IInputRuntime.html#UnityEngine.InputSystem.LowLevel.IInputRuntime.DeviceCommand(System.Int32,UnityEngine.InputSystem.LowLevel.InputDeviceCommand*)" class="xref">DeviceCommand</a>(<a href="https://learn.microsoft.com/dotnet/api/system.int32" class="xref">int</a>, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.InputDeviceCommand.html" class="xref">InputDeviceCommand</a>\*)

#### onFindLayoutForDevice

Event that is signalled when the system is trying to match a layout to a device it has discovered.

##### Declaration

``` lang-csharp
public static event InputDeviceFindControlLayoutDelegate onFindLayoutForDevice
```

##### Event Type

| Type                                                                                                                                                                                                       | Description |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputDeviceFindControlLayoutDelegate.html" class="xref">InputDeviceFindControlLayoutDelegate</a> |             |

##### Remarks

This event allows customizing the layout discovery process and to generate layouts on the fly, if need be. When a device is reported from the Unity runtime or through <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_AddDevice_UnityEngine_InputSystem_Layouts_InputDeviceDescription_" class="xref">AddDevice(InputDeviceDescription)</a>, it is reported in the form of an <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputDeviceDescription.html" class="xref">InputDeviceDescription</a>. The system will take that description and run it through all the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputDeviceMatcher.html" class="xref">InputDeviceMatcher</a>s that have been registered for layouts (<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RegisterLayoutMatcher__1_UnityEngine_InputSystem_Layouts_InputDeviceMatcher_" class="xref">RegisterLayoutMatcher&lt;TDevice&gt;(InputDeviceMatcher)</a>). Based on that, it will come up with either no matching layout or with a single layout that has the highest matching score according to <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputDeviceMatcher.html#UnityEngine_InputSystem_Layouts_InputDeviceMatcher_MatchPercentage_UnityEngine_InputSystem_Layouts_InputDeviceDescription_" class="xref">MatchPercentage(InputDeviceDescription)</a> (or, in case multiple layouts have the same score, the first one to achieve that score -- which is quasi-non-deterministic).

It will then take this layout name (which, again, may be empty) and invoke this event here passing it not only the layout name but also information such as the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputDeviceDescription.html" class="xref">InputDeviceDescription</a> for the device. Each of the callbacks hooked into the event will be run in turn. The *first* one to return a string that is not `null` and not empty will cause a switch from the layout the system has chosen to the layout that has been returned by the callback. The remaining layouts after that will then be invoked with that newly selected name but will not be able to change the name anymore.

If none of the callbacks returns a string that is not `null` or empty, the system will stick with the layout that it had initially selected.

Once all callbacks have been run, the system will either have a final layout name or not. If it does, a device is created using that layout. If it does not, no device is created.

One thing this allows is to generate callbacks on the fly. Let's say that if an input device is reported with the "Custom" interface, we want to generate a layout for it on the fly. For details about how to build layouts dynamically from code, see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputControlLayout.Builder.html" class="xref">InputControlLayout.Builder</a> and <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RegisterLayoutBuilder_System_Func_UnityEngine_InputSystem_Layouts_InputControlLayout__System_String_System_String_System_Nullable_UnityEngine_InputSystem_Layouts_InputDeviceMatcher__" class="xref">RegisterLayoutBuilder(Func&lt;InputControlLayout&gt;, string, string, InputDeviceMatcher?)</a>.

``` lang-csharp
InputSystem.onFindLayoutForDevice +=
    (deviceId, description, matchedLayout, runtime) =>
    {
        // If the system does have a matching layout, we do nothing.
        // This could be the case, for example, if we already generated
        // a layout for the device or if someone explicitly registered
        // a layout.
        if (!string.IsNullOrEmpty(matchedLayout))
            return null; // Tell system we did nothing.
    // See if the reported device uses the "Custom" interface. We
    // are only interested in those.
    if (description.interfaceName != "Custom")
        return null; // Tell system we did nothing.

    // So now we know that we want to build a layout on the fly
    // for this device. What we do is to register what's called a
    // layout builder. These can use C# code to build an InputControlLayout
    // on the fly.

    // First we need to come up with a sufficiently unique name for the layout
    // under which we register the builder. This will usually involve some
    // information from the InputDeviceDescription we have been supplied with.
    // Let's say we can sufficiently tell devices on our interface apart by
    // product name alone. So we just do this:
    var layoutName = "Custom" + description.product;

    // We also need an InputDeviceMatcher that in the future will automatically
    // select our newly registered layout whenever a new device of the same type
    // is connected. We can get one simply like so:
    var matcher = InputDeviceMatcher.FromDescription(description);

    // With these pieces in place, we can register our builder which
    // mainly consists of a delegate that will get invoked when an instance
    // of InputControlLayout is needed for the layout.
    InputSystem.RegisterLayoutBuilder(
        () =>
        {
            // Here is where we do the actual building. In practice,
            // this would probably look at the 'capabilities' property
            // of the InputDeviceDescription we got and create a tailor-made
            // layout. But what you put in the layout here really depends on
            // the specific use case you have.
            //
            // We just add some preset things here which should still sufficiently
            // serve as a demonstration.
            //
            // Note that we can base our layout here on whatever other layout
            // in the system. We could extend Gamepad, for example. If we don't
            // choose a base layout, the system automatically implies InputDevice.

            var builder = new InputControlLayout.Builder()
                .WithDisplayName(description.product);

            // Add controls.
            builder.AddControl("stick")
                .WithLayout("Stick");

            return builder.Build();
        },
        layoutName,
        matches: matcher);

    // So, we want the system to use our layout for the device that has just
    // been connected. We return it from this callback to do that.
    return layoutName;
};</code></pre>
```

Note that it may appear like one could simply use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RegisterLayoutBuilder_System_Func_UnityEngine_InputSystem_Layouts_InputControlLayout__System_String_System_String_System_Nullable_UnityEngine_InputSystem_Layouts_InputDeviceMatcher__" class="xref">RegisterLayoutBuilder(Func&lt;InputControlLayout&gt;, string, string, InputDeviceMatcher?)</a> like below instead of going through `onFindLayoutForDevice`.

``` lang-csharp
InputSystem.RegisterLayoutBuilder(
    () =>
    {
        // Layout building code from above...
    },
    "CustomLayout",
    matches: new InputDeviceMatcher().WithInterface("Custom"));
```

However, the difference here is that all devices using the "Custom" interface will end up with the same single layout -- which has to be identical. By hooking into `onFindLayoutForDevice`, it is possible to register a new layout for every new type of device that is discovered and thus build a multitude of different layouts.

It is best to register for this callback during startup. One way to do it is to use `InitializeOnLoadAttribute` and `RuntimeInitializeOnLoadMethod`.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_RegisterLayoutBuilder_System_Func_UnityEngine_InputSystem_Layouts_InputControlLayout__System_String_System_String_System_Nullable_UnityEngine_InputSystem_Layouts_InputDeviceMatcher__" class="xref">RegisterLayoutBuilder(Func&lt;InputControlLayout&gt;, string, string, InputDeviceMatcher?)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputControlLayout.html" class="xref">InputControlLayout</a>

#### onLayoutChange

Event that is signalled when the layout setup in the system changes.

##### Declaration

``` lang-csharp
public static event Action<string, InputControlLayoutChange> onLayoutChange
```

##### Event Type

| Type                                                                                                                                                                                                                                                                                                                                                           | Description |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.action-2" class="xref">Action</a>\<<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a>, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControlLayoutChange.html" class="xref">InputControlLayoutChange</a>\> |             |

##### Remarks

First parameter is the name of the layout that has changed and second parameter is the type of change that has occurred.

``` lang-csharp
InputSystem.onLayoutChange +=
    (name, change) =>
    {
        switch (change)
        {
            case InputControlLayoutChange.Added:
                Debug.Log($"New layout {name} has been added");
                break;
            case InputControlLayoutChange.Removed:
                Debug.Log($"Layout {name} has been removed");
                break;
            case InputControlLayoutChange.Replaced:
                Debug.Log($"Layout {name} has been updated");
                break;
        }
    }
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Layouts.InputControlLayout.html" class="xref">InputControlLayout</a>

#### onSettingsChange

Event that is triggered if any of the properties in <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_settings" class="xref">settings</a> changes or if <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_settings" class="xref">settings</a> is replaced entirely with a new <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.html" class="xref">InputSettings</a> object.

##### Declaration

``` lang-csharp
public static event Action onSettingsChange
```

##### Event Type

| Type                                                                                   | Description |
|----------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.action" class="xref">Action</a> |             |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html#UnityEngine_InputSystem_InputSystem_settings" class="xref">settings</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.html" class="xref">InputSettings</a>
