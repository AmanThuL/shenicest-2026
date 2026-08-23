---
title: "Stack trace logging"
page_title: "Unity - Manual: Stack trace logging"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/stack-trace.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/stack-trace.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Stack trace logging

Unity Console messages and log files can include detailed stack trace information. The console also links to the line of code that generated the message. This is useful when you want to identify the line, method, or sequence of function calls that caused the log entry to appear.

**Tip:** Another way to inspect your code is to [attach a debugger](https://docs.unity3d.com/6000.3/Documentation/Manual/managed-code-debugging.html) to the Editor or your built player.

## Stack trace for managed and unmanaged code

Unity can provide stack trace information for both managed and unmanaged code:

-   **Managed code:** Managed DLLs or C# scripts running in Unity. These can be scripts that ship with Unity, custom scripts that you write, third-party scripts included with an Asset store plug-in, or any other C# script that runs in the engine.

-   **Unmanaged code:** Native Unity engine code, or code from a native plugin running directly on your machine or on a target build platform. Unmanaged code is usually compiled from C or C++ code. You can only access it if you have the original source code of the native binary. Typically, you will use stack trace for unmanaged code only if you need to determine whether an error is caused by your code or the engine code, and which part of the engine code.

Unity offers three stack trace options:

-   **None:** Unity doesn’t output stack trace information.
-   **ScriptOnly:** Unity outputs stack trace information only for managed code. This is the default option.
-   **Full:** Unity outputs stack trace information for both managed and unmanaged code.

You can set each of these stack trace options independently for each [log message type](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/LogType.html): Error, Assert, Warning, Log, and Exception.

## Stack trace resource requirements

Resolving a stack trace, especially a full stack trace, is a resource-intensive operation. Some best practices for stack traces include:

-   Use stack traces only to debug. Do not deploy an application to users with stack trace enabled.
-   Limit the type of messages that display a stack trace. For example, consider using stack trace only for exceptions and warnings.

## Setting the stack trace type

You can configure the stack trace option in the following ways:

-   From the [Console window](https://docs.unity3d.com/6000.3/Documentation/Manual/Console.html) menu:
    -   To select a stack trace option for all log message types, navigate to **Stack Trace Logging** > **All** and select the stack trace option for all log message types.
    -   To select a stack trace option for one type of log message, navigate to **Stack Trace Logging** > **\[MESSAGE TYPE\]** and select the stack trace option for that log message type.
-   From the [Player Settings window](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PlayerSettings.html):
    -   Go to **Edit** > **Project Settings** > **Player** > **Other Settings**.
    -   Under **Stack Trace**, use the checkboxes to set the stack trace option for the different log message types.
-   From code, using the [`Application.SetStackTraceLogType`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application.SetStackTraceLogType.html) method.

![Stack trace logging options from the Console. This example shows the options for Exception.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/StackTraceInConsole.png)

**Note:** Changes to stack trace options take effect immediately in the Editor but you must [rebuild your application](https://docs.unity3d.com/6000.3/Documentation/Manual/building-and-publishing.html) for changes to take effect in a built Player.

## Open source files from the stack trace output

The full text of a message includes references to specific lines in code files with links. Click any link to open the file in your IDE at the referenced line.

## Find the output log file of a built application

Built applications do not output to the Console. To see the stack trace, [use the application’s log file](https://docs.unity3d.com/6000.3/Documentation/Manual/log-files.html).

## Additional resources

-   [Console window](https://docs.unity3d.com/6000.3/Documentation/Manual/Console.html)
-   [Log files](https://docs.unity3d.com/6000.3/Documentation/Manual/log-files.html)
