---
title: "Integrating third-party code libraries (plug-ins)"
page_title: "Unity - Manual: Integrating third-party code libraries (plug-ins)"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/plug-ins.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/plug-ins.html"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Integrating third-party code libraries (plug-ins)

In Unity, you normally use **scripts** to create functionality, but you can also include code created outside Unity in the form of a **plug-in**. You can use two different kinds of plug-in in Unity:

-   **Managed plug-ins**: [managed .NET assemblies](https://docs.unity3d.com/6000.3/Documentation/Manual/dotnet-profile-support.html) you can create with tools like Visual Studio. They only contain .NET code, which means they can’t access any features that the .NET libraries do not support. For more information, refer to [Microsoft’s documentation of managed code](https://docs.microsoft.com/en-us/dotnet/standard/managed-code).
-   **Native plug-ins**: platform-specific native code libraries. They can access features like operating system calls and third-party code libraries that would otherwise be unavailable to Unity.

Managed code is accessible to the standard .NET tools that Unity uses to compile scripts. The only difference between managed plug-in code and Unity script code is that the plug-ins are compiled outside of Unity and so Unity might not be able to access the source. When using native plug-ins, Unity’s tools can’t access third-party code libraries in the same way that they can access the managed libraries. For example, if you forget to add a managed plug-in file to the project, you will get standard compiler error messages. Whereas, if you forget to add a native plug-in file to the project, you will only get an error report when you try to run the project.

The following pages explain how to create and use plug-ins in your Unity Projects:

| **Topic**                                                                                                                 | **Description**                                             |
|:--------------------------------------------------------------------------------------------------------------------------|:------------------------------------------------------------|
| [Import and configure plug-ins](https://docs.unity3d.com/6000.3/Documentation/Manual/plug-in-inspector.html)              | Import and configure managed or native plug-ins.            |
| [Managed plug-ins](https://docs.unity3d.com/6000.3/Documentation/Manual/plug-ins-managed.html)                            | Details on using managed plug-ins.                          |
| [Native plug-ins](https://docs.unity3d.com/6000.3/Documentation/Manual/plug-ins-native.html)                              | Details on using native plug-ins.                           |
| [Building plug-ins for desktop platforms](https://docs.unity3d.com/6000.3/Documentation/Manual/plug-ins-for-desktop.html) | Deploy native code libraries for macOS, Windows, and Linux. |
| [Low-level native plug-in interface](https://docs.unity3d.com/6000.3/Documentation/Manual/native-plugin-interface.html)   | Implement low-level rendering in your native plug-ins.      |

## Additional resources

-   [Unity .NET features](https://docs.unity3d.com/6000.3/Documentation/Manual/overview-of-dot-net-in-unity.html)
