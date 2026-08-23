---
title: "Corresponding old and new APIs"
page_title: "Corresponding old and new APIs | Input System | 1.20.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/corresponding-old-new-api.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/corresponding-old-new-api.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Corresponding old and new APIs

Below is a list comparing the API from the old Input Manager with the corresponding API for the new Input System package. All of the new Input System package APIs listed below are in the `UnityEngine.InputSystem` namespace. The namespace is omitted here for brevity.

## Action-based input

Action-based input refers to reading pre-configured named axes, buttons, or other controls. ([Read more about Action-based input](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/using-actions-workflow.html))

-   In the old Input Manager, these are defined in the **Axes** list, in the **Input Manager** section of the **Project Settings** window. *(Below, left)*
-   In the new Input System, these are defined in the [Actions Editor](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/actions-editor.html), which can be found in the **Input System Package** section of the **Project Settings** window, or by opening an [action asset](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/action-assets.html). *(Below, right)*

![On the left, the old Input Manager Axes Configuration window, in Project settings. On the right, the new Input System's Actions Editor](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/images/InputManagerVsInputActions.png)  
*On the left, the old Input Manager Axes Configuration window, in Project settings. On the right, the new Input System's Actions Editor.*

##### Note

In some cases for named axes and buttons, the new Input System requires slightly more code than the old Input Manager, but this results in better performance. This is because in the new Input System, the logic is separated into two parts: the first is to find and store a reference to the action (usually done once, for example in your `Start` method), and the second is to read the action (usually done every frame, for example in your `Update` method). In contrast, the old Input Manager used a string-based API to "find" and "read" the value at the same time, because it was not possible to store a reference to a button or axis. This results in worse performance, because the axis or button is looked up each time the value is read.

To find and store references to actions, which can be axes or buttons use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionAsset.html" class="xref"><code>FindAction</code></a>. For example:

     // A 2D axis action named "Move"
    InputAction moveAction = InputSystem.actions.FindAction("Move");

     // A button action named "Jump"
    InputAction jumpAction = InputSystem.actions.FindAction("Jump");

Then, to read the action values, use the following:

<table><colgroup><col style="width: 50%" /><col style="width: 50%" /></colgroup><thead><tr class="header"><th>Input Manager (Old)</th><th>Input System (New)</th></tr></thead><tbody><tr class="odd"><td><a href="https://docs.unity3d.com/ScriptReference/Input.GetAxis.html"><code>Input.GetAxis</code></a><br />
In the old Input Manager System, all axes are 1D and return float values. For example, to read the horizontal and vertical axes:<br />
<code>float h = Input.GetAxis("Horizontal");</code><br />
<code>float v = Input.GetAxis("Vertical");</code><br />
<br />
</td><td>Use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBindingComposite-1.html" class="xref"><code>ReadValue</code></a> on the reference to the action to read the current value of the axis. In the new Input System, axes can be 1D, 2D or other value types. You must specify the correct value type that corresponds with how the action is set up. This example shows a 2D axis:<br />
<code>Vector2 moveVector = moveAction.ReadValue&lt;Vector2&gt;();</code>.<br />
<br />
</td></tr><tr class="even"><td><a href="https://docs.unity3d.com/ScriptReference/Input.GetButton.html"><code>Input.GetButton</code></a><br />
Example:<br />
<code>bool jumpValue = Input.GetButton("Jump");</code><br />
<br />
</td><td>Use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html" class="xref"><code>IsPressed</code></a> on the reference to the action to read the button value.<br />
Example:<br />
<code>bool jumpValue = jumpAction.IsPressed();</code>.<br />
<br />
</td></tr><tr class="odd"><td><a href="https://docs.unity3d.com/ScriptReference/Input.GetButtonDown.html"><code>Input.GetButtonDown</code></a><br />
Example: <code>bool jump = Input.GetButtonDown("Jump");</code><br />
<br />
</td><td>Use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html" class="xref"><code>WasPressedThisFrame</code></a> on the reference to the action to read if the button was pressed this frame.<br />
Example: <code>bool jumpValue = jumpAction.WasPressedThisFrame();</code>.<br />
<br />
</td></tr><tr class="even"><td><a href="https://docs.unity3d.com/ScriptReference/Input.GetButtonUp.html"><code>Input.GetButtonUp</code></a><br />
Example: <code>bool jump = Input.GetButtonUp("Jump");</code><br />
<br />
</td><td>Use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html" class="xref"><code>WasReleasedThisFrame</code></a> on the reference to the action to read whether the button was released this frame.<br />
Example: <code>bool jumpValue = jumpAction.WasReleasedThisFrame();</code>.<br />
<br />
</td></tr><tr class="odd"><td><a href="https://docs.unity3d.com/ScriptReference/Input.GetAxisRaw.html"><code>Input.GetAxisRaw</code></a><br />
For example, to read the raw values of the horizontal and vertical axes:<br />
<code>float h = Input.GetAxisRaw("Horizontal");</code><br />
<code>float v = Input.GetAxisRaw("Vertical");</code><br />
<br />
</td><td>No direct equivalent, but if there are <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/Processors.html">processors</a> associated with the action, you can use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl-1.html" class="xref"><code>InputControl&lt;&gt;.ReadUnprocessedValue()</code></a> to read unprocessed values.<br />
Example: <code>Vector2 moveVector = moveAction.ReadUnprocessedValue();</code><br />
Note: This returns the same value as ReadValue when there are no processors on the action.</td></tr></tbody></table>

## Directly reading Gamepad and Joystick controls

Directly reading hardware controls bypasses the new Input System's action-based workflow, which has some benefits and some drawbacks. ([Read more about directly reading devices](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/using-direct-workflow.html))

<table><colgroup><col style="width: 50%" /><col style="width: 50%" /></colgroup><thead><tr class="header"><th>Input Manager (Old)</th><th>Input System (New)</th></tr></thead><tbody><tr class="odd"><td><a href="https://docs.unity3d.com/ScriptReference/Input.GetKey.html"><code>Input.GetKey</code></a><br />
Example: <code>Input.GetKey(KeyCode.JoystickButton0)</code><br />
<br />
</td><td>Use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Controls.ButtonControl.html" class="xref"><code>isPressed</code></a> on the corresponding Gamepad button.<br />
Example: <code>InputSystem.GamePad.current.buttonNorth.isPressed</code>.<br />
</td></tr><tr class="even"><td><a href="https://docs.unity3d.com/ScriptReference/Input.GetKeyDown.html"><code>Input.GetKeyDown</code></a><br />
Example: <code>Input.GetKeyDown(KeyCode.JoystickButton0)</code><br />
<br />
</td><td>Use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Controls.ButtonControl.html" class="xref"><code>wasPressedThisFrame</code></a> on the corresponding Gamepad button.<br />
Example: <code>InputSystem.GamePad.current.buttonNorth.WasPressedThisFrame</code>.<br />
</td></tr><tr class="odd"><td><a href="https://docs.unity3d.com/ScriptReference/Input.GetKeyUp.html"><code>Input.GetKeyUp</code></a><br />
Example: <code>Input.GetKeyUp(KeyCode.JoystickButton0)</code><br />
<br />
</td><td>Use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Controls.ButtonControl.html" class="xref"><code>wasReleasedThisFrame</code></a> on the corresponding Gamepad button.<br />
Example: <code>InputSystem.GamePad.current.buttonNorth.wasReleasedThisFrame</code>.<br />
</td></tr><tr class="even"><td><a href="https://docs.unity3d.com/ScriptReference/Input.GetJoystickNames.html"><code>Input.GetJoystickNames</code></a></td><td>There is no API that corresponds to this exactly, but there are examples of <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/query-gamepads.html#discover-all-connected-devices">how to read all connected devices here</a>.</td></tr><tr class="odd"><td><a href="https://docs.unity3d.com/ScriptReference/Input.IsJoystickPreconfigured.html"><code>Input.IsJoystickPreconfigured</code></a></td><td>Not needed. Devices which derive from <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Gamepad.html" class="xref"><code>Gamepad</code></a> always correctly implement the mapping of axes and buttons to the corresponding <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControl.html" class="xref"><code>InputControl</code></a> members of the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Gamepad.html" class="xref"><code>Gamepad</code></a> class. <a href="https://docs.unity3d.com/ScriptReference/Input.ResetInputAxes.html"><code>Input.ResetInputAxes</code></a></td></tr></tbody></table>

## Keyboard

<table><colgroup><col style="width: 50%" /><col style="width: 50%" /></colgroup><thead><tr class="header"><th>Input Manager (Old)</th><th>Input System (New)</th></tr></thead><tbody><tr class="odd"><td><a href="https://docs.unity3d.com/ScriptReference/Input.GetKey.html"><code>Input.GetKey</code></a><br />
Example: <code>Input.GetKey(KeyCode.Space)</code><br />
<br />
</td><td>Use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Controls.ButtonControl.html" class="xref"><code>isPressed</code></a> on the corresponding key.<br />
Example: <code>InputSystem.Keyboard.current.spaceKey.isPressed</code><br />
<br />
</td></tr><tr class="even"><td><a href="https://docs.unity3d.com/ScriptReference/Input.GetKeyDown.html"><code>Input.GetKeyDown</code></a><br />
Example: <code>Input.GetKeyDown(KeyCode.Space)</code><br />
<br />
</td><td>Use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Controls.ButtonControl.html" class="xref"><code>wasPressedThisFrame</code></a> on the corresponding key.<br />
Example: <code>InputSystem.Keyboard.current.spaceKey.wasPressedThisFrame</code><br />
<br />
</td></tr><tr class="odd"><td><a href="https://docs.unity3d.com/ScriptReference/Input.GetKeyUp.html"><code>Input.GetKeyUp</code></a><br />
Example: <code>Input.GetKeyUp(KeyCode.Space)</code><br />
<br />
</td><td>Use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Controls.ButtonControl.html" class="xref"><code>wasReleasedThisFrame</code></a> on the corresponding key.<br />
Example: <code>InputSystem.Keyboard.current.spaceKey.wasReleasedThisFrame</code><br />
<br />
</td></tr><tr class="even"><td><a href="https://docs.unity3d.com/ScriptReference/Input-anyKey.html"><code>Input.anyKey</code></a></td><td>Use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html" class="xref"><code>onAnyButtonPress</code></a>.<br />
This also includes controller buttons as well as keyboard keys.</td></tr><tr class="odd"><td><a href="https://docs.unity3d.com/ScriptReference/Input-anyKeyDown.html"><code>Input.anyKeyDown</code></a></td><td>Use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Keyboard.html" class="xref"><code>Keyboard.current.anyKey.wasUpdatedThisFrame</code></a></td></tr><tr class="even"><td><a href="https://docs.unity3d.com/ScriptReference/Input-compositionCursorPos.html"><code>Input.compositionCursorPos</code></a></td><td>Use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Keyboard.html" class="xref"><code>Keyboard.current.SetIMECursorPosition(myPosition)</code></a></td></tr><tr class="odd"><td><a href="https://docs.unity3d.com/ScriptReference/Input-compositionString.html"><code>Input.compositionString</code></a></td><td>Subscribe to the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Keyboard.html" class="xref"><code>Keyboard.onIMECompositionChange</code></a>.</td></tr><tr class="even"><td><a href="https://docs.unity3d.com/ScriptReference/Input-imeCompositionMode.html"><code>Input.imeCompositionMode</code></a></td><td>Use: <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Keyboard.html" class="xref"><code>Keyboard.current.SetIMEEnabled(true)</code></a><br />
Refer to <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/read-keyboard-text-input.html#working-with-input-from-input-method-editors">Keyboard text input documentation</a>.</td></tr><tr class="odd"><td><a href="https://docs.unity3d.com/ScriptReference/Input-imeIsSelected.html"><code>Input.imeIsSelected</code></a></td><td>Use: <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Keyboard.html" class="xref"><code>Keyboard.current.imeSelected</code></a></td></tr><tr class="even"><td><a href="https://docs.unity3d.com/ScriptReference/Input-inputString.html"><code>Input.inputString</code></a></td><td>Subscribe to the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Keyboard.html" class="xref"><code>Keyboard.onTextInput</code></a> event:<br />
<code>Keyboard.current.onTextInput += character =&gt; /* ... */;</code></td></tr></tbody></table>

## Mouse

`MonoBehaviour.OnMouse` events, such as [MonoBehaviour.OnMouseDown](https://docs.unity3d.com/ScriptReference/MonoBehaviour.OnMouseDown.html), are supported in Unity 6.4 and later.

<table><colgroup><col style="width: 50%" /><col style="width: 50%" /></colgroup><thead><tr class="header"><th>Input Manager (Old)</th><th>Input System (New)</th></tr></thead><tbody><tr class="odd"><td><a href="https://docs.unity3d.com/ScriptReference/Input.GetMouseButton.html"><code>Input.GetMouseButton</code></a><br />
Example: <code>Input.GetMouseButton(0)</code></td><td>Use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Controls.ButtonControl.html" class="xref"><code>isPressed</code></a> on the corresponding mouse button.<br />
Example: <code>InputSystem.Mouse.current.leftButton.isPressed</code></td></tr><tr class="even"><td><a href="https://docs.unity3d.com/ScriptReference/Input.GetMouseButtonDown.html"><code>Input.GetMouseButtonDown</code></a><br />
Example: <code>Input.GetMouseButtonDown(0)</code></td><td>Use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Controls.ButtonControl.html" class="xref"><code>wasPressedThisFrame</code></a> on the corresponding mouse button.<br />
Example: <code>InputSystem.Mouse.current.leftButton.wasPressedThisFrame</code></td></tr><tr class="odd"><td><a href="https://docs.unity3d.com/ScriptReference/Input.GetMouseButtonUp.html"><code>Input.GetMouseButtonUp</code></a><br />
Example: <code>Input.GetMouseButtonUp(0)</code></td><td>Use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Controls.ButtonControl.html" class="xref"><code>wasReleasedThisFrame</code></a> on the corresponding mouse button.<br />
Example: <code>InputSystem.Mouse.current.leftButton.wasReleasedThisFrame</code></td></tr><tr class="even"><td><a href="https://docs.unity3d.com/ScriptReference/Input-mousePosition.html"><code>Input.mousePosition</code></a></td><td>Use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Mouse.html" class="xref"><code>Mouse.current.position.ReadValue()</code></a><br />
Example: <code>Vector2 position = Mouse.current.position.ReadValue();</code><br />
<strong>Note:</strong> Mouse simulation from touch isn't implemented yet.</td></tr><tr class="odd"><td><a href="https://docs.unity3d.com/ScriptReference/Input-mousePresent.html"><code>Input.mousePresent</code></a></td><td>No corresponding API yet.</td></tr></tbody></table>

## Touch and Pen

<table><colgroup><col style="width: 50%" /><col style="width: 50%" /></colgroup><thead><tr class="header"><th>Input Manager (Old)</th><th>Input System (New)</th></tr></thead><tbody><tr class="odd"><td><a href="https://docs.unity3d.com/ScriptReference/Input.GetTouch.html"><code>Input.GetTouch</code></a><br />
For example:<br />
<code>Touch touch = Input.GetTouch(0);</code><br />
<code>Vector2 touchPos = touch.position;</code></td><td>Use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.EnhancedTouch.Touch.html" class="xref"><code>EnhancedTouch.Touch.activeTouches[i]</code></a><br />
Example: <code>Vector2 touchPos = EnhancedTouch.Touch.activeTouches[0].position;</code><br />
<strong>Note:</strong> Enable enhanced touch support first by calling <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.EnhancedTouch.EnhancedTouchSupport.html" class="xref"><code>EnhancedTouch.Enable()</code></a>.</td></tr><tr class="even"><td><a href="https://docs.unity3d.com/ScriptReference/Input-multiTouchEnabled.html"><code>Input.multiTouchEnabled</code></a></td><td>No corresponding API yet.</td></tr><tr class="odd"><td><a href="https://docs.unity3d.com/ScriptReference/Input-multiTouchEnabled.html"><code>Input.simulateMouseWithTouches</code></a></td><td>No corresponding API yet.</td></tr><tr class="even"><td><a href="https://docs.unity3d.com/ScriptReference/Input-stylusTouchSupported.html"><code>Input.stylusTouchSupported</code></a></td><td>No corresponding API yet.</td></tr><tr class="odd"><td><a href="https://docs.unity3d.com/ScriptReference/Input-touchCount.html"><code>Input.touchCount</code></a></td><td><a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.EnhancedTouch.Touch.html" class="xref"><code>EnhancedTouch.Touch.activeTouches.Count</code></a><br />
<strong>Note:</strong> Enable enhanced touch support first by calling <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.EnhancedTouch.EnhancedTouchSupport.html" class="xref"><code>EnhancedTouchSupport.Enable()</code></a></td></tr><tr class="even"><td><a href="https://docs.unity3d.com/scriptreference/input-touches.html"><code>Input.touches</code></a></td><td><a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.EnhancedTouch.Touch.html" class="xref"><code>EnhancedTouch.Touch.activeTouches</code></a><br />
<strong>Note:</strong> Enable enhanced touch support first by calling <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.EnhancedTouch.EnhancedTouchSupport.html" class="xref"><code>EnhancedTouch.Enable()</code></a></td></tr><tr class="odd"><td><a href="https://docs.unity3d.com/ScriptReference/Input-touchPressureSupported.html"><code>Input.touchPressureSupported</code></a></td><td>No corresponding API yet.</td></tr><tr class="even"><td><a href="https://docs.unity3d.com/ScriptReference/Input-touchSupported.html"><code>Input.touchSupported</code></a></td><td><a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Touchscreen.html" class="xref"><code>Touchscreen.current != null</code></a></td></tr><tr class="odd"><td><a href="https://docs.unity3d.com/ScriptReference/Input-backButtonLeavesApp.html"><code>Input.backButtonLeavesApp</code></a></td><td>No corresponding API yet.</td></tr><tr class="even"><td><a href="https://docs.unity3d.com/ScriptReference/Input.GetPenEvent.html"><code>GetPenEvent</code></a><br />
<a href="https://docs.unity3d.com/ScriptReference/Input.GetLastPenContactEvent.html"><code>GetLastPenContactEvent</code></a><br />
<a href="https://docs.unity3d.com/ScriptReference/Input.ResetPenEvents.html"><code>ResetPenEvents</code></a><br />
<a href="https://docs.unity3d.com/ScriptReference/Input.ClearLastPenContactEvent.html"><code>ClearLastPenContactEvent</code></a></td><td>Use: <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Pen.html" class="xref"><code>Pen.current</code></a><br />
See the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/devices-pen.html">Pen, tablet and stylus support</a> docs for more information.</td></tr></tbody></table>

------------------------------------------------------------------------

Note: [`UnityEngine.TouchScreenKeyboard`](https://docs.unity3d.com/ScriptReference/TouchScreenKeyboard.html) is not part of the old Input Manager API, so you can continue to use it when migrating to the new Input System package.

## Sensors

<table><colgroup><col style="width: 50%" /><col style="width: 50%" /></colgroup><thead><tr class="header"><th>Input Manager (Old)</th><th>Input System (New)</th></tr></thead><tbody><tr class="odd"><td><a href="https://docs.unity3d.com/ScriptReference/Input-acceleration.html"><code>Input.acceleration</code></a></td><td><a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Accelerometer.html" class="xref"><code>Accelerometer.current.acceleration.ReadValue()</code></a>.</td></tr><tr class="even"><td><a href="https://docs.unity3d.com/ScriptReference/Input-accelerationEventCount.html"><code>Input.accelerationEventCount</code></a><br />
<a href="https://docs.unity3d.com/ScriptReference/Input-accelerationEvents.html"><code>Input.accelerationEvents</code></a></td><td>Acceleration events aren't made available separately from other input events. See the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/query-sensors.html#measure-a-devices-acceleration">accelerometer code sample on the Sensors page</a>.</td></tr><tr class="odd"><td><a href="https://docs.unity3d.com/ScriptReference/Input-compass.html"><code>Input.compass</code></a></td><td>No corresponding API yet.</td></tr><tr class="even"><td><a href="https://docs.unity3d.com/ScriptReference/Input-compensateSensors.html"><code>Input.compensateSensors</code></a></td><td><a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.html" class="xref"><code>InputSettings.compensateForScreenOrientation</code></a>.</td></tr><tr class="odd"><td><a href="https://docs.unity3d.com/ScriptReference/Input-deviceOrientation.html"><code>Input.deviceOrientation</code></a></td><td>No corresponding API yet.</td></tr><tr class="even"><td><a href="https://docs.unity3d.com/ScriptReference/Input-gyro.html"><code>Input.gyro</code></a></td><td>The <code>UnityEngine.Gyroscope</code> class is replaced by multiple separate sensor Devices in the new Input System:<br />
<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Gyroscope.html" class="xref"><code>Gyroscope</code></a> to measure angular velocity.<br />
<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.GravitySensor.html" class="xref"><code>GravitySensor</code></a> to measure the direction of gravity.<br />
<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.AttitudeSensor.html" class="xref"><code>AttitudeSensor</code></a> to measure the orientation of the device.<br />
<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Accelerometer.html" class="xref"><code>Accelerometer</code></a> to measure the total acceleration applied to the device.<br />
<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LinearAccelerationSensor.html" class="xref"><code>LinearAccelerationSensor</code></a> to measure acceleration applied to the device, compensating for gravity.</td></tr><tr class="odd"><td><a href="https://docs.unity3d.com/ScriptReference/Gyroscope-attitude.html"><code>Input.gyro.attitude</code></a></td><td><a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.AttitudeSensor.html" class="xref"><code>AttitudeSensor.current.orientation.ReadValue()</code></a>.</td></tr><tr class="even"><td><a href="https://docs.unity3d.com/ScriptReference/Gyroscope-enabled.html"><code>Input.gyro.enabled</code></a></td><td>Get: <code>Gyroscope.current.enabled</code><br />
Set:<br />
<code>EnableDevice(Gyroscope.current);</code><br />
<code>DisableDevice(Gyroscope.current);</code><br />
<br />
<strong>Note:</strong> The new Input System replaces <code>UnityEngine.Gyroscope</code> with multiple separate sensor devices. Substitute <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Gyroscope.html" class="xref"><code>Gyroscope</code></a> with other sensors in the sample as needed. See the notes for <code>Input.gyro</code> above for details.</td></tr><tr class="odd"><td><a href="https://docs.unity3d.com/ScriptReference/Gyroscope-gravity.html"><code>Input.gyro.gravity</code></a></td><td><a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.GravitySensor.html" class="xref"><code>GravitySensor.current.gravity.ReadValue()</code></a></td></tr><tr class="even"><td><a href="https://docs.unity3d.com/ScriptReference/Gyroscope-rotationRate.html"><code>Input.gyro.rotationRate</code></a></td><td><a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Gyroscope.html" class="xref"><code>Gyroscope.current.angularVelocity.ReadValue()</code></a>.</td></tr><tr class="odd"><td><a href="https://docs.unity3d.com/ScriptReference/Gyroscope-rotationRateUnbiased.html"><code>Input.gyro.rotationRateUnbiased</code></a></td><td>No corresponding API yet.</td></tr><tr class="even"><td><a href="https://docs.unity3d.com/ScriptReference/Gyroscope-updateInterval.html"><code>Input.gyro.updateInterval</code></a></td><td><a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Sensor.html" class="xref"><code>Sensor.samplingFrequency</code></a><br />
Example:<br />
<code>Gyroscope.current.samplingFrequency = 1.0f / updateInterval;</code><br />
<br />
<strong>Notes</strong>:<br />
<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Sensor.html" class="xref"><code>samplingFrequency</code></a> is in Hz, not in seconds as <a href="https://docs.unity3d.com/ScriptReference/Gyroscope-updateInterval.html"><code>updateInterval</code></a>, so you need to divide 1 by the value.<br />
<br />
The new Input System replaces <code>UnityEngine.Gyroscope</code> with multiple separate sensor devices. Substitute <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Gyroscope.html" class="xref"><code>Gyroscope</code></a> with other sensors in the sample as needed. See the notes for <code>Input.gyro</code> above for details.</td></tr><tr class="odd"><td><a href="https://docs.unity3d.com/ScriptReference/Gyroscope-userAcceleration.html"><code>Input.gyro.userAcceleration</code></a></td><td><a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LinearAccelerationSensor.html" class="xref"><code>LinearAccelerationSensor.current.acceleration.ReadValue()</code></a></td></tr><tr class="even"><td><a href="https://docs.unity3d.com/ScriptReference/Input-location.html"><code>Input.location</code></a></td><td>No corresponding API yet.</td></tr><tr class="odd"><td><a href="https://docs.unity3d.com/ScriptReference/Input.GetAccelerationEvent.html"><code>Input.GetAccelerationEvent</code></a></td><td>See notes for <code>Input.accelerationEvents</code> above.</td></tr></tbody></table>
