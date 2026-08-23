---
title: "Debug C# code in Unity"
page_title: "Unity - Manual: Debug C# code in Unity"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/managed-code-debugging.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/managed-code-debugging.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Debug C# code in Unity

You can use a debugger to inspect your source code while your application is running. Each supported IDE has dependencies you must install to enable the IDE to integrate properly with Unity. For details of what’s required to configure each supported IDE for debugging in Unity, refer to [Integrated development environment (IDE) support](https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-ide-support.html).

Although these IDEs vary slightly in the debugging features they support, they all provide basic functionality such as break points, single stepping, and variable inspection. You can attach your IDE to the Unity Editor or Unity Player to debug your code.

Managed code debugging in Unity works on all platforms except Web. It works with both the [Mono](https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-backends-mono.html) and [IL2CPP](https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-backends-il2cpp.html) scripting backends.

## Debug in the Unity Editor

To debug your Edit mode or Play mode code as it runs in the Editor:

1.  [Configure your IDE](https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-ide-support.html) for Unity development and debugging.
2.  Set the [Editor’s code optimization](https://docs.unity3d.com/6000.3/Documentation/Manual/managed-code-debugging.html#code-optimization) mode to Debug.
3.  [Attach your IDE](https://docs.unity3d.com/6000.3/Documentation/Manual/managed-code-debugging.html#AttachToEditor) to the Unity Editor process.

**Tip**: When running the Editor in batch mode, you can use the [command-line argument](https://docs.unity3d.com/6000.3/Documentation/Manual/EditorCommandLineArguments.html#debugging-arguments) `-wait-for-managed-debugger` to make the Editor wait for a managed debugger to attach before launching.

## Debug in the Unity Player

To debug your Play mode code as it runs in a Unity Player:

1.  [Configure your IDE](https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-ide-support.html) for Unity development and debugging.
2.  [Build](https://docs.unity3d.com/6000.3/Documentation/Manual/building-introduction.html) your project with the **Development Build** and **Script Debugging** [options](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles-reference.html#shared-build-settings) enabled. Optionally, enable the **Wait For Managed Debugger** option to make the Player wait for a debugger to attach before launching and running any script code.
3.  [Attach your IDE](https://docs.unity3d.com/6000.3/Documentation/Manual/managed-code-debugging.html#AttachToEditor) to the Unity Player process.

**Note**: When running the Player in batch mode, you can use the [command-line argument](https://docs.unity3d.com/6000.3/Documentation/Manual/PlayerCommandLineArguments.html) `-wait-for-managed-debugger` to make the Player wait for a managed debugger to attach before launching.

<span id="code-optimization"></span>

## Setting the Unity Editor’s code optimization mode

The Editor’s code optimization setting has two modes:

-   **Debug**: Allows attaching to an external debugger, but code runs slower in Play mode.
-   **Release**: Code runs faster in Play mode, but you can’t attach to an external debugger.

To [attach a debugger to your Editor](https://docs.unity3d.com/6000.3/Documentation/Manual/managed-code-debugging.html#AttachToEditor), you first need to set the Editor’s code optimization mode to debug mode. You can change the code optimization setting in the following ways:

-   From the Editor status bar: Click the code optimization mode button (bug icon) in the bottom right of the [status bar](https://docs.unity3d.com/6000.3/Documentation/Manual/StatusBar.html). A small pop-up window opens with a button you can use to switch modes.
-   From the **Preferences** window: To change which mode the Unity Editor starts up in, go to **Edit** > **Preferences** (macOS: **Unity** > **Settings**) > **General** and change the **Code Optimization On Startup** setting.
-   From code: You can change the code optimization mode with the [ManagedDebugger](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Scripting.ManagedDebugger.html), [Compilation.CompilationPipeline-codeOptimization](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Compilation.CompilationPipeline-codeOptimization.html), and [Compilation.CodeOptimization](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Compilation.CodeOptimization.html) APIs.
-   From the command line: Use the command-line argument `-releaseCodeOptimization` to start the Editor in release mode and `-debugCodeOptimization` to start it in debug mode. For more information, refer to [Debugging arguments](https://docs.unity3d.com/6000.3/Documentation/Manual/EditorCommandLineArguments.html#debugging).

## Setting breakpoints

Breakpoints allow you to specify points in your code where you want to pause its execution. In your IDE, you can set a breakpoint on a line of code where you want the debugger to stop. While the IDE is at a breakpoint, you can view the contents of variables step by step.

If you [attach your IDE to the Unity Editor](https://docs.unity3d.com/6000.3/Documentation/Manual/managed-code-debugging.html#AttachToEditor), the Editor becomes unresponsive at breakpoints until you choose the continue option in your IDE, or stop debugging.

For more information of how to set breakpoints, refer to the relevant documentation for your IDE:

-   [Visual Studio](https://learn.microsoft.com/en-us/visualstudio/debugger/get-started-with-breakpoints).
-   [Visual Studio Code](https://code.visualstudio.com/docs/editor/debugging#_breakpoints).
-   [Rider](https://www.jetbrains.com/help/rider/Using_Breakpoints.html).

<span id="AttachToEditor"></span>

## Attaching your IDE to the Unity Editor or Player process

How you attach your IDE to the Unity Editor or Player process is specific to the IDE you use. Some IDEs have a Unity-specific attach option that differs from the standard process for attaching to other applications.

For information on how to attach to Unity for debugging, refer to the relevant documentation for your IDE:

-   Visual Studio: [Using Visual Studio Tools for Unity (Windows)](https://docs.microsoft.com/en-us/visualstudio/gamedev/unity/get-started/using-visual-studio-tools-for-unity?pivots=windows#unity-debugging)
-   Visual Studio Code: [Unity Development with VS Code](https://code.visualstudio.com/docs/other/unity)
-   Jetbrains Rider: [Debug Unity Applications](https://www.jetbrains.com/help/rider/Debugging_Unity_Applications.html)

Once you’ve attached to the Unity Editor, return to the Unity Editor and enter Play mode to start debugging.

To attach to the built Player, select the IP address (or machine name) and port of your Player from your IDE. When you’ve attached the debugger, you can begin debugging normally.

**Note**: Your IDE displays all instances of Unity that are available to debug. Make sure you distinguish the Editor process from the Player process if both are running.

### Android

To debug a Unity Player running on an Android device, connect to the device using USB or TCP. For example, to connect to an Android device in Visual Studio, select **Debug** \> **Attach Unity Debugger** option. A list of devices running a Player instance appears.

For more information, refer to [Debug on Android devices](https://docs.unity3d.com/6000.3/Documentation/Manual/android-debugging-on-an-android-device.html).

### iOS

To debug a Unity Player running on an iOS device, connect to the device using TCP.

Ensure that the device only has one active network interface (Wi-Fi recommended, turn off cellular data) and that there is no firewall between the IDE and the device blocking the TCP port (port number 56000 in the above screenshot).

**Important**: iOS doesn’t support debugging over USB.

For more information, refer to [Test and debug an iOS application](https://docs.unity3d.com/6000.3/Documentation/Manual/ios-testing-and-debugging.html).

## Additional resources

-   [Troubleshooting debugging](https://docs.unity3d.com/6000.3/Documentation/Manual/managed-debugging-troubleshooting.html)
-   [Integrated development environment (IDE) support](https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-ide-support.html)
