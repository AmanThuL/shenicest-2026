---
title: "Scripting API: Debug"
page_title: "Unity - Scripting API: Debug"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Debug

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-Debug.html" class="switch-link gray-btn sbtn left show" title="Go to Debug Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

### Description

Class containing methods to ease debugging while developing a game.

### Static Properties

| Property                                                                                                                    | Description                                                                   |
|-----------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------|
| [developerConsoleEnabled](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug-developerConsoleEnabled.html) | Allows you to enable or disable the developer console.                        |
| [developerConsoleVisible](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug-developerConsoleVisible.html) | Controls whether the development console is visible.                          |
| [isDebugBuild](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug-isDebugBuild.html)                       | In the Build Settings dialog there is a check box called "Development Build". |
| [unityLogger](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug-unityLogger.html)                         | Get default debug logger.                                                     |

### Static Methods

| Method                                                                                                                        | Description                                                                                                                                                                       |
|-------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Assert](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.Assert.html)                                     | Assert a condition and logs an error message to the Unity console on failure.                                                                                                     |
| [AssertFormat](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.AssertFormat.html)                         | Assert a condition and logs a formatted error message to the Unity console on failure.                                                                                            |
| [Break](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.Break.html)                                       | Pauses the editor.                                                                                                                                                                |
| [CheckIntegrity](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.CheckIntegrity.html)                     | Performs an integrity check of the currently running process and return discovered errors.                                                                                        |
| [ClearDeveloperConsole](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.ClearDeveloperConsole.html)       | Clears all previously printed messages, warnings, and errors from the developer console.                                                                                          |
| [DrawLine](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.DrawLine.html)                                 | Draws a line between specified start and end points.                                                                                                                              |
| [DrawRay](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.DrawRay.html)                                   | Draws a line from start to start + dir in world coordinates.                                                                                                                      |
| [ExtractStackTraceNoAlloc](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.ExtractStackTraceNoAlloc.html) | Populate an unmanaged buffer with the current managed call stack as a sequence of UTF-8 bytes, without allocating GC memory. Returns the number of bytes written into the buffer. |
| [IsValidationLevelEnabled](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.IsValidationLevelEnabled.html) | Returns whether a given validation level is currently enabled.                                                                                                                    |
| [Log](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.Log.html)                                           | Logs a message to the Unity Console.                                                                                                                                              |
| [LogAssertion](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.LogAssertion.html)                         | A variant of Debug.Log that logs an assertion message to the console.                                                                                                             |
| [LogAssertionFormat](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.LogAssertionFormat.html)             | Logs a formatted assertion message to the Unity console.                                                                                                                          |
| [LogError](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.LogError.html)                                 | A variant of Debug.Log that logs an error message to the console.                                                                                                                 |
| [LogErrorFormat](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.LogErrorFormat.html)                     | Logs a formatted error message to the Unity console.                                                                                                                              |
| [LogException](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.LogException.html)                         | A variant of Debug.Log that logs an error message from an exception to the console.                                                                                               |
| [LogFormat](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.LogFormat.html)                               | Logs a formatted message to the Unity Console.                                                                                                                                    |
| [LogWarning](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.LogWarning.html)                             | A variant of Debug.Log that logs a warning message to the console.                                                                                                                |
| [LogWarningFormat](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.LogWarningFormat.html)                 | Logs a formatted warning message to the Unity Console.                                                                                                                            |
| [RetrieveStartupLogs](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.RetrieveStartupLogs.html)           | Returns any captured startup logs                                                                                                                                                 |
