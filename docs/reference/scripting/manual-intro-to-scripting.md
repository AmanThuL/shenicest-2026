---
title: "Introduction to programming in Unity"
page_title: "Unity - Manual: Introduction to programming in Unity"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/intro-to-scripting.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/intro-to-scripting.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to programming in Unity

Unity is customizable and extensible by design and almost everything is scriptable to some extent. Many items you can configure through the various [Editor views](https://docs.unity3d.com/6000.3/Documentation/Manual/unity-editor.html) have a corresponding public C# class representation that you can interact with in code.

You can use Editor APIs to customize and extend the Editor authoring tools to improve your development workflows. You can use Engine APIs to define the runtime functionality of your application, including graphics, physics, character behavior, and responses to user input.

The [Scripting API reference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/index.html) provides the complete and authoritative reference for all public Unity APIs. The Manual provides additional context and guidance.

## The Unity scripting environment

Unity supports scripting in the C# programming language. C# (pronounced C-sharp) is a managed, object-oriented programming language, which is part of the .NET platform and runs in the cross-platform .NET runtime. Other .NET languages can be used with Unity if they can compile a compatible DLL, refer to [Managed plugins](https://docs.unity3d.com/6000.3/Documentation/Manual/plug-ins-managed.html) for further details.

The scripting environment refers to both:

-   Your own local environment or context in which you’re writing code. This includes your code editor (IDE) and integrated source control solution and operating system.
-   The C# scripting enviroment Unity provides. A given version of Unity supports given versions of the .NET platform, which determines the .NET libraries you can use in your code.

For more information on the scripting environment and tools, refer to [Environment and tools](https://docs.unity3d.com/6000.3/Documentation/Manual/environment-and-tools.html).

## How scripting in Unity works

C# scripts (files with a `.cs` file extension) are [assets](https://docs.unity3d.com/6000.3/Documentation/Manual/AssetWorkflow.html) in your project, stored in the `Assets` folder and saved as part of the [asset database](https://docs.unity3d.com/6000.3/Documentation/Manual/AssetDatabase.html). You can create template scripts that derive from the common [built-in Unity types](https://docs.unity3d.com/6000.3/Documentation/Manual/fundamental-unity-types.html) through the **Scripting** submenu of the **Assets \> Create** menu.

You configure a default [External Script Editor](https://docs.unity3d.com/6000.3/Documentation/Manual/preferences-external-tools.html), which is the program Unity opens your script assets in for editing. Usually this will be one of the [supported IDEs](https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-ide-support.html) for Unity development.

You can create your own regular C# types and logic to use in your game, as long as the code you write is compatible with the active [.NET profile](https://docs.unity3d.com/6000.3/Documentation/Manual/dotnet-profile-support.html). But your scripted types gain additional functionality in Unity when they inherit from a built-in Unity type.

If your custom types inherit from [UnityEngine.Object](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Object.html), they’ll be assignable to fields in the Inspector window. Inheriting from [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/Manual/class-MonoBehaviour.html) allows a script to be attached to a GameObject as a component to control the behaviour of a GameObject in a scene.

For more information on fundamental Unity types you can inherit from, refer to [Fundamental Unity types](https://docs.unity3d.com/6000.3/Documentation/Manual/fundamental-unity-types.html).

For more information on viewing scripts and editing script components in the Inspector, refer to [Inspecting scripts](https://docs.unity3d.com/6000.3/Documentation/Manual/inspecting-scripts.html).

## Editor and runtime scripts

There are two distinct contexts in which your code might run:

-   In the Unity Editor at authoring time, usually as part of custom editing tools and windows that support your own development process.
-   In your application at runtime, as part of your user’s experience.

Source files that contain Editor-only code are commonly referred to as Editor scripts and can be excluded from Player builds either by placing them in folders named `Editor` or by using [assembly definition files](https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definition-files.html) to define Editor-only assemblies. For more information, refer to [Editor folder](https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definitions-intro.html#special-folders).

Regions of code can also be conditionally compiled for Editor-only use with the `#if UNITY_EDITOR` preprocessor directive. For more information, refer to [Conditional compilation](https://docs.unity3d.com/6000.3/Documentation/Manual/conditional-compilation.html).

The majority of Unity’s core public APIs are in either the `UnityEditor` or `UnityEngine` namespaces. APIs in the `UnityEditor` namespace are only available in the Editor and attempting to use them in runtime code produces compilation errors.

While working in the Editor, you might have some code that you want to run in both Edit mode and Play mode. You might call some `UnityEditor` APIs while in Play mode for the purposes of testing, visualization, or triggering asset operations. Likewise, you might want to call `UnityEngine` APIs in Edit mode by using [`[ExecuteInEditMode]`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ExecuteInEditMode.html) or [`[ExecuteAlways]`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ExecuteAlways.html) attributes on those sections of code.

However, always remember to exclude Editor scripts and code that uses `UnityEditor` APIs from your runtime Player builds.

## Compilation and code reload

[Compilation](https://docs.unity3d.com/6000.3/Documentation/Manual/script-compilation.html) transforms the C# code you write into code that runs on a given target platform. Some aspects of compilation are under your control and others aren’t. By [organizing your scripts into assemblies](https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definition-files.html) you can reduce unnecessary recompilation and manage your dependencies effectively. With [conditional compilation](https://docs.unity3d.com/6000.3/Documentation/Manual/conditional-compilation.html) you can selectively include or exclude sections of your code from compilation.

Depending on your settings, Unity [recompiles and reloads your code](https://docs.unity3d.com/6000.3/Documentation/Manual/compilation-and-code-reload.html) in various contexts. Reloading code is important for changes to take effect or to preserve state when transitioning between Edit mode and Play mode, but it also impacts performance and iteration times. It’s important to understand these costs and how you can configure Unity’s code reload behavior to mitigate them.

## Additional resources

-   [Creating scripts](https://docs.unity3d.com/6000.3/Documentation/Manual/creating-scripts.html)
-   [Naming scripts](https://docs.unity3d.com/6000.3/Documentation/Manual/naming-scripts.html)
-   [Scripts in the Inspector window](https://docs.unity3d.com/6000.3/Documentation/Manual/inspecting-scripts.html)
-   [Fundamental Unity types](https://docs.unity3d.com/6000.3/Documentation/Manual/fundamental-unity-types.html)
