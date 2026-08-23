---
title: "Scripting API: Input"
page_title: "Unity - Scripting API: Input"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Input

class in UnityEngine

/

Implemented in:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UnityEngine.InputLegacyModule.html" class="cl">UnityEngine.InputLegacyModule</a>

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

Interface into the Legacy Input system.

**Note**: The `Input` class is part of the legacy Input Manager. The recommended best practice is that you don't use this API in new projects. For new projects, use the [new Input System](https://docs.unity3d.com/Packages/com.unity.inputsystem@latest/index.html) package.  
  
[KeyCode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/KeyCode.html) maps to physical keys only if "Use Physical Keys" is enabled in [Input Manager settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-InputManager.html), otherwise it maps to layout and platform dependent key mapping. Starting from 2022.1 "Use Physical Keys" is enabled by default.  
  
Use this class to read the axes set up in the [Conventional Game Input](https://docs.unity3d.com/6000.3/Documentation/Manual/ConventionalGameInput.html), and to access multi-touch/accelerometer data on mobile devices.  
  
To read an axis use [Input.GetAxis](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input.GetAxis.html) with one of the following default axes: "Horizontal" and "Vertical" are mapped to joystick, `A`, `W`, `S`, `D` and the arrow keys. "Mouse X" and "Mouse Y" are mapped to the mouse delta. "Fire1", "Fire2" "Fire3" are mapped to `Ctrl`, `Alt`, `Cmd` keys and three mouse or joystick buttons. New input axes can be added. See [Input Manager](https://docs.unity3d.com/6000.3/Documentation/Manual/class-InputManager.html) for this.  
  
If you are using input for any kind of movement behaviour use [Input.GetAxis](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input.GetAxis.html). It gives you smoothed and configurable input that can be mapped to a keyboard, joystick or mouse. Use [Input.GetButton](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input.GetButton.html) for action-like events only. Do not use it for movement. [Input.GetAxis](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input.GetAxis.html) will make the script code smaller and simpler.  
  
**Note:** [Input](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input.html) flags are not reset until `Update`. You should make all the [Input](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input.html) calls in the `Update` Loop.  
  
Additional resources: [KeyCode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/KeyCode.html) which lists all of the key press, mouse and joystick options.  
  
**Mobile Devices:**  
  
iOS and Android devices are capable of tracking multiple fingers touching the screen simultaneously. You can access data on the status of each finger touching screen during the last frame by using the [Input.touches](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input-touches.html) property array.  
  
As a device moves, its accelerometer hardware reports linear acceleration changes along the three primary axes in three-dimensional space. You can use this data to detect both the current orientation of the device (relative to the ground) and any immediate changes to that orientation.  
  
Acceleration along each axis is reported directly by the hardware as G-force values. A value of 1.0 represents a load of about +1g along a given axis while a value of -1.0 represents -1g. If you hold the device upright (with the home button at the bottom) in front of you, the X axis is positive along the right, the Y axis is positive directly up, and the Z axis is positive pointing toward you.  
  
You can use the [Input.acceleration](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input-acceleration.html) property to get the accelerometer reading. You can also use the [Input.deviceOrientation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input-deviceOrientation.html) property to get a discrete evaluation of the device's orientation in three-dimensional space. Detecting a change in orientation can be useful if you want to create game behaviors when the user rotates the device to hold it differently.  
  
Note that the accelerometer hardware can be polled more than once per frame. To access all accelerometer samples since the last frame, you can use the [Input.accelerationEvents](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input-accelerationEvents.html) property array. This can be useful when reconstructing player motions, feeding acceleration data into a predictor, or implementing other precise motion analysis.

``` codeExampleCS
using UnityEngine;
using System.Collections;

public class ExampleClass : MonoBehaviour

    }
}
```

This component relates to legacy methods for drawing UI textures and images to the screen. You should instead use UI system. This is also unrelated to the IMGUI system.

### Static Properties

| Property                                                                                                                      | Description                                                                                                                  |
|-------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------|
| [acceleration](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input-acceleration.html)                         | Last measured linear acceleration of a device in three-dimensional space. (Read Only)                                        |
| [accelerationEventCount](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input-accelerationEventCount.html)     | Number of acceleration measurements which occurred during last frame.                                                        |
| [accelerationEvents](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input-accelerationEvents.html)             | Returns list of acceleration measurements which occurred during the last frame. (Read Only) (Allocates temporary variables). |
| [anyKey](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input-anyKey.html)                                     | Is any key or mouse button currently held down? (Read Only)                                                                  |
| [anyKeyDown](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input-anyKeyDown.html)                             | Returns true the first frame the user hits any key or mouse button. (Read Only)                                              |
| [backButtonLeavesApp](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input-backButtonLeavesApp.html)           | Should Back button quit the application?                                                                                     |
| [compass](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input-compass.html)                                   | Property for accessing compass (handheld devices only). (Read Only)                                                          |
| [compensateSensors](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input-compensateSensors.html)               | This property controls if input sensors should be compensated for screen orientation.                                        |
| [compositionCursorPos](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input-compositionCursorPos.html)         | The current text input position used by IMEs to open windows.                                                                |
| [compositionString](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input-compositionString.html)               | The current IME composition string being typed by the user.                                                                  |
| [deviceOrientation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input-deviceOrientation.html)               | Device physical orientation as reported by OS. (Read Only)                                                                   |
| [gyro](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input-gyro.html)                                         | Returns default gyroscope.                                                                                                   |
| [imeCompositionMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input-imeCompositionMode.html)             | Controls enabling and disabling of IME input composition.                                                                    |
| [imeIsSelected](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input-imeIsSelected.html)                       | Does the user have an IME keyboard input source selected?                                                                    |
| [inputString](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input-inputString.html)                           | Returns the keyboard input entered this frame. (Read Only)                                                                   |
| [location](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input-location.html)                                 | Property for accessing device location (handheld devices only). (Read Only)                                                  |
| [mousePosition](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input-mousePosition.html)                       | The current mouse position in pixel coordinates. (Read Only).                                                                |
| [mousePositionDelta](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input-mousePositionDelta.html)             | The current mouse position delta in pixel coordinates. (Read Only).                                                          |
| [mousePresent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input-mousePresent.html)                         | Indicates if a mouse device is detected.                                                                                     |
| [mouseScrollDelta](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input-mouseScrollDelta.html)                 | The current mouse scroll delta. (Read Only)                                                                                  |
| [multiTouchEnabled](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input-multiTouchEnabled.html)               | Property indicating whether the system handles multiple touches.                                                             |
| [penEventCount](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input-penEventCount.html)                       | Returns the number of queued pen events that can be accessed by calling \[\[GetPenEvent()\]\].                               |
| [simulateMouseWithTouches](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input-simulateMouseWithTouches.html) | Enables/Disables mouse simulation with touches. By default this option is enabled.                                           |
| [stylusTouchSupported](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input-stylusTouchSupported.html)         | Returns true when Stylus Touch is supported by a device or platform.                                                         |
| [touchCount](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input-touchCount.html)                             | Number of touches. Guaranteed not to change throughout the frame. (Read Only)                                                |
| [touches](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input-touches.html)                                   | Returns list of objects representing status of all touches during last frame. (Read Only) (Allocates temporary variables).   |
| [touchPressureSupported](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input-touchPressureSupported.html)     | Bool value which let's users check if touch pressure is supported.                                                           |
| [touchSupported](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input-touchSupported.html)                     | Returns whether the device on which application is currently running supports touch input.                                   |

### Static Methods

| Method                                                                                                                        | Description                                                                                                          |
|-------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------|
| [ClearLastPenContactEvent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input.ClearLastPenContactEvent.html) | Clears the last stored pen event. Calling this function may impact event handling for UIToolKit elements.            |
| [GetAccelerationEvent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input.GetAccelerationEvent.html)         | Returns specific acceleration measurement which occurred during last frame. (Does not allocate temporary variables). |
| [GetAxis](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input.GetAxis.html)                                   | Returns the value of the virtual axis identified by axisName.                                                        |
| [GetAxisRaw](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input.GetAxisRaw.html)                             | Returns the value of the virtual axis identified by axisName with no smoothing filtering applied.                    |
| [GetButton](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input.GetButton.html)                               | Returns true while the virtual button identified by buttonName is held down.                                         |
| [GetButtonDown](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input.GetButtonDown.html)                       | Returns true during the frame the user pressed down the virtual button identified by buttonName.                     |
| [GetButtonUp](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input.GetButtonUp.html)                           | Returns true the first frame the user releases the virtual button identified by buttonName.                          |
| [GetJoystickNames](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input.GetJoystickNames.html)                 | Retrieves a list of input device names corresponding to the index of an Axis configured within Input Manager.        |
| [GetKey](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input.GetKey.html)                                     | Returns true while the user holds down the key identified by name.                                                   |
| [GetKeyDown](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input.GetKeyDown.html)                             | Returns true during the frame the user starts pressing down the key identified by name.                              |
| [GetKeyUp](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input.GetKeyUp.html)                                 | Returns true during the frame the user releases the key identified by name.                                          |
| [GetLastPenContactEvent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input.GetLastPenContactEvent.html)     | Returns the PenData for the last stored pen up or down event.                                                        |
| [GetMouseButton](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input.GetMouseButton.html)                     | Returns whether the given mouse button is held down.                                                                 |
| [GetMouseButtonDown](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input.GetMouseButtonDown.html)             | Returns true during the frame the user pressed the given mouse button.                                               |
| [GetMouseButtonUp](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input.GetMouseButtonUp.html)                 | Returns true during the frame the user releases the given mouse button.                                              |
| [GetPenEvent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input.GetPenEvent.html)                           | Returns the PenData for the pen event at the given index in the pen event queue.                                     |
| [GetTouch](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input.GetTouch.html)                                 | Call Input.GetTouch to obtain a Touch struct.                                                                        |
| [IsJoystickPreconfigured](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input.IsJoystickPreconfigured.html)   | Determine whether a particular joystick model has been preconfigured by Unity. (Linux-only).                         |
| [ResetInputAxes](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input.ResetInputAxes.html)                     | Resets all input. After ResetInputAxes all axes return to 0 and all buttons return to 0 for one frame.               |
| [ResetPenEvents](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input.ResetPenEvents.html)                     | Clears the pen event queue.                                                                                          |
