---
title: "Scripting back ends"
page_title: "Unity - Manual: Scripting back ends"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-backends.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-backends.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Scripting back ends

In Unity, the scripting back end is the runtime technology that compiles and executes your C# scripts. It determines how your code is turned into executable instructions and what runtime manages it on target platforms.

| **Topic**                                                                                                                     | **Description**                                                                                                                                                                                           |
|:------------------------------------------------------------------------------------------------------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **[Introduction to scripting back ends](https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-backends-intro.html)** | Understand the available scripting backends and their effects on your project.                                                                                                                            |
| **[Mono scripting back end](https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-backends-mono.html)**              | Mono is a stable, mature .NET runtime that provides a managed environment for the just-in-time (JIT) compilation of your C# code.                                                                         |
| **[IL2CPP scripting back end](https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-backends-il2cpp.html)**          | IL2CPP is Unity’s ahead-of-time (AOT) pipeline that converts C# intermediate language (IL) to C++, then compiles to native code. It’s required on several platforms where Mono and JIT are not supported. |

## Additional resources

-   [Unity .NET features](https://docs.unity3d.com/6000.3/Documentation/Manual/overview-of-dot-net-in-unity.html)
-   [Build profiles](https://docs.unity3d.com/6000.3/Documentation/Manual/BuildSettings.html)
