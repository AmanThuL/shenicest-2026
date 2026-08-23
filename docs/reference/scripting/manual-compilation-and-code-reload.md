---
title: "Compilation and code reload"
page_title: "Unity - Manual: Compilation and code reload"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/compilation-and-code-reload.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/compilation-and-code-reload.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Compilation and code reload

Compilation transforms the code you write into code that runs in a given context on a given platform. As you work in the Unity Editor, there are several scenarios where Unity may recompile and reload your code. Depending on your settings and the location of your code, opening the Editor for the first time, modifying your code, reimporting a script asset, and entering Play mode can all trigger code reload.

Reloading code is an important way to preserve or reset data between context switches and to ensure relevant changes take effect, but it can negatively impact your development iteration times. It’s important to understand when, why, and how Unity compiles and reloads scripts and other assets and how you can configure this behavior. It’s also important to understand how Unity prioritizes executing different parts of your compiled code to ensure things happen in the order you intend them to.

| **Topic**                                                                                                                      | **Description**                                                                                                                                                                                     |
|:-------------------------------------------------------------------------------------------------------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Script compilation](https://docs.unity3d.com/6000.3/Documentation/Manual/script-compilation.html)                             | How and in what order Unity compiles your scripts and how you can organize your scripts into assemblies.                                                                                            |
| [Code and scene reload on entering Play mode](https://docs.unity3d.com/6000.3/Documentation/Manual/code-reloading-editor.html) | Understand what Unity reloads by default on entering Play mode and how you can configure this behavior for faster development iteration times.                                                      |
| [Script serialization](https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization.html)                         | Details of how Unity transforms your scripted data structures and object states into a serialized format for storage or reconstruction later on, and how this affects your application performance. |
| [Integrating third-party code libraries (plug-ins)](https://docs.unity3d.com/6000.3/Documentation/Manual/plug-ins.html)        | Add third-party code libraries to your Unity project.                                                                                                                                               |

## Additional resources

-   [C# Compiler](https://docs.unity3d.com/6000.3/Documentation/Manual/csharp-compiler.html)
