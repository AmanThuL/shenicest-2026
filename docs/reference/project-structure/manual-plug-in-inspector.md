---
title: "Import and configure plug-ins"
page_title: "Unity - Manual: Import and configure plug-ins"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/plug-in-inspector.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/plug-in-inspector.html"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Import and configure plug-ins

If you have a [managed plug-in](https://docs.unity3d.com/6000.3/Documentation/Manual/plug-ins-managed.html) or a [native plug-in](https://docs.unity3d.com/6000.3/Documentation/Manual/plug-ins-native.html), you can import it into Unity, then configure it. The Unity Editor treats a plug-in as an asset, similar to a script, and you can configure it in an Inspector window.

You can use the plug-in configurations to specify where a plug-in runs, on which platforms and platform configurations, and under what conditions.

## Import a plug-in

The easiest way to import a plug-in to your project is to click and drag the plug-in to the Assets folder or one of its subfolders. Unity recognizes specific file and folder types as plug-ins. It can also apply default settings that match the plug-in’s intended platform.

**Note**: After Unity loads a native plug-in into memory, it remains loaded in the Unity Editor session. To change a native plug-in’s code after it has been loaded, you must restart Unity. Otherwise, the previous version of the plug-in remains in use. This problem only affects native plug-ins that run in the Editor, including in Play mode when the native plug-in architecture matches that of the currently running Editor.

### Supported plug-in file and folder types

Unity treats files with the following extensions as a plug-in:

-   .a
-   .aar
-   .bc
-   .c
-   .cc
-   .cpp
-   .dll
-   .def
-   .dylib
-   .h
-   .jar
-   .jslib
-   .jspre
-   .m
-   .mm
-   .prx
-   .rpl
-   .so
-   .sprx
-   .suprx
-   .swift
-   .winmd
-   .xcframework
-   .xex
-   .xib

Unity also treats certain folders as bundled plug-ins. Unity doesn’t look for additional plug-in files within these folders, so everything within the folder is considered a single plug-in. Unity treats folders with the following extensions as a bundled plug-in:

-   .androidlib
-   .bundle
-   .framework
-   .plugin

### Plug-in default settings

Unity automatically applies platform-specific default settings to the plug-in if the plug-in’s path within the Assets folder matches a platform-specific pattern. If the path doesn’t match any pattern, Unity applies the Editor platform default settings to the plug-in.

The following table shows the path patterns Unity recognizes. Portions of the path that appear in brackets are optional. When the path includes double dots, it can include more folders.

<table><thead><tr class="header"><th style="text-align: left;"><strong>Folder path patterns</strong></th><th style="text-align: left;"><strong>Default settings</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Assets/../Editor/(x86</strong> or <strong>x86_64 or x64)</strong></td><td style="text-align: left;"><strong>Platform</strong>: Editor only<br />
<br />
<strong>CPU</strong> (optional): Based on the subfolder, if present.</td></tr><tr class="even"><td style="text-align: left;"><strong>Assets/../Plugins/(x86_64</strong> or <strong>x86 or x64)</strong></td><td style="text-align: left;"><strong>Platform</strong>: Windows, Linux and macOS<br />
<br />
<strong>CPU</strong> (optional): Based on the subfolder, if present.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Assets/Plugins/iOS</strong></td><td style="text-align: left;"><strong>Platform</strong>: iOS</td></tr><tr class="even"><td style="text-align: left;"><strong>Assets/Plugins/WSA/(SDK80</strong> or <strong>SDK81</strong> or <strong>PhoneSDK81)/(x86</strong> or <strong>ARM)</strong></td><td style="text-align: left;"><strong>Platform</strong>: Universal Windows Platform<br />
<br />
<strong>SDK</strong> (optional): Based on the subfolder, if present. For compatibility reasons, SDK81 is Win81, PhoneSDK81 is WindowsPhone81.<br />
<br />
<strong>CPU</strong> (optional): Based on the subfolder, if present<br />
<br />
<strong>Note</strong>: You can use the keyword <strong>Metro</strong> instead of <strong>WSA</strong>.</td></tr></tbody></table>

## Change plug-in settings

In Unity, plug-ins are either **managed** or **native**. The following table shows which settings are relevant for each type of plug-in:

| **Setting**                                                                                                                | **Managed** | **Native** |
|:---------------------------------------------------------------------------------------------------------------------------|:------------|:-----------|
| [Select platforms for plugin](https://docs.unity3d.com/6000.3/Documentation/Manual/plug-in-inspector.html#select-platform) | yes         | yes        |
| [Platform settings](https://docs.unity3d.com/6000.3/Documentation/Manual/plug-in-inspector.html#platform-settings)         | yes         | yes        |
| [Asset Labels](https://docs.unity3d.com/6000.3/Documentation/Manual/organizing-assets-with-labels.html)                    | yes         | yes        |
| [Asset Bundles](https://docs.unity3d.com/6000.3/Documentation/Manual/AssetBundles-Workflow)                                | yes         | yes        |
| [General](https://docs.unity3d.com/6000.3/Documentation/Manual/plug-in-inspector.html#general)                             | yes         |            |
| [Define Constraints](https://docs.unity3d.com/6000.3/Documentation/Manual/plug-in-inspector.html#define-constraints)       | yes         |            |
| [Plugin load settings](https://docs.unity3d.com/6000.3/Documentation/Manual/plug-in-inspector.html#plugin-load-settings)   |             | yes        |

To view and change plug-in settings in the **Inspector**, select the plug-in file in the **Project** window.

![Settings for a managed plug-in (left) and a native plug-in (right).](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/PlugInsCombined.png)

**Note:** If a plug-in is a Roslyn source code generator or analyzer, you must assign `RoslynAnalyzer` as an **Asset Label** in the plug-in settings.

## Common plug-in settings

**Select platform for plugin** and **Platform settings** specify in which builds Unity includes the plug-in.

### Select platform for plugin

| **Platform**            | **Description**                                                                                                                                                                                        |
|:------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Any Platform**        | Allows the plug-in to work with any platforms, including those that aren’t installed yet. If selected, this option changes the following individual platform selections from include to exclude logic. |
| **Editor**              | For Play mode and for any scripts that run in Edit mode.                                                                                                                                               |
| **Standalone**          | Windows, Linux and macOS.                                                                                                                                                                              |
| Any installed platform. | Any platform included in your Unity installation, such as Android, iOS and Web.                                                                                                                        |

### Platform settings

For each selected platform, you can specify additional platform-specific settings such as CPU architecture and dependencies. Unity shows only settings that apply to your platforms and, where possible, to the specific plug-in type on that platform. For example, a native plug-in file with a .dll extension can only run on Windows, so Unity shows only Windows settings.

**Note:** Platforms can have their own specific plug-in settings, which aren’t described here. Refer to the appropriate [Platform development](https://docs.unity3d.com/6000.3/Documentation/Manual/PlatformSpecific.html) topic for information about settings and behavior on individual platforms.

<table><thead><tr class="header"><th style="text-align: left;"><strong>Platform</strong></th><th style="text-align: left;"><strong>Options</strong></th><th style="text-align: left;"><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;">Editor</td><td style="text-align: left;"><ul><li>CPU architecture</li><li>OS</li></ul></td><td style="text-align: left;">Most managed plug-ins are compatible with any CPU and OS.<br />
<br />
Most native plug-ins are only compatible with a single OS and, depending on how they were compiled, might be compatible with only a single CPU architecture.</td></tr><tr class="even"><td style="text-align: left;">Windows, Linux and macOS</td><td style="text-align: left;"><ul><li>CPU architecture</li><li>OS</li></ul></td><td style="text-align: left;">Managed libraries are typically compatible with any OS and CPU architecture, unless they access specific system APIs.<br />
<br />
Native libraries are only compatible with a single OS, but can be compatible with the 32-bit, the 64-bit, or both CPU architectures.</td></tr><tr class="odd"><td style="text-align: left;">Universal Windows Platform</td><td style="text-align: left;"><ul><li>SDK</li><li>CPU architecture</li><li>Scripting backend</li></ul></td><td style="text-align: left;">For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/uwp-il2cpp-plugins.html">Use UWP plug-ins with IL2CPP</a>.</td></tr><tr class="even"><td style="text-align: left;">Android</td><td style="text-align: left;">CPU architecture</td><td style="text-align: left;">The CPU architecture must match the architecture that the library was compiled for. Unity does not validate your settings.<br />
<br />
See also: <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/AndroidAARPlugins.html">AAR plug-ins and Android Libraries</a>.</td></tr><tr class="odd"><td style="text-align: left;">iOS and tvOS</td><td style="text-align: left;"><ul><li>Framework dependencies</li><li>CPU architecture</li><li>Add to Embedded Binaries</li><li>Compile flags</li></ul><br />
</td><td style="text-align: left;">Specify the CPU architecture your plug-in is compatible with. Unity provides ARM64 and X64 Simulator architectures for testing purposes.<br />
<br />
When you select <strong>Add to Embedded Binaries</strong> option, Unity sets the Xcode project options to copy the plug-in file into the final application package. Do this for:<br />
• Dynamically loaded libraries.<br />
• Bundles and frameworks containing dynamically loaded libraries.<br />
• Any assets and resources that need to be loaded at run time.<br />
<br />
In the <strong>Compile Flags</strong> field, set the compile flags for plug-in source code files that Unity must compile as part of the build.</td></tr></tbody></table>

**Tip**: For information on the other common settings, see [Asset Bundles](https://docs.unity3d.com/6000.3/Documentation/Manual/AssetBundlesIntro.html) and [Searching in the Editor](https://docs.unity3d.com/6000.3/Documentation/Manual/editor-searching.html).

### Managed plug-in settings

Managed plug-ins can be third-party libraries or user-compiled assemblies that you want to include in the project.

### General - Auto Reference

The **Auto Reference** setting controls how assembly definitions in the project reference a plug-in file. When you enable Auto Reference, all predefined assemblies and assembly definitions automatically reference the plug-in file.

**Auto Reference** is enabled by default.

To limit the scope in which a plug-in can be referenced, disable **Auto Reference**. You then need to explicitly declare all references to that plug-in. You might want to do this if:

-   You want to prevent scripts from mistakenly using the plug-in.
-   You are iterating on the plug-in and want to reduce compilation time. If you explicitly declare a plug-in, Unity recompiles only the dependent assemblies, not your entire project.
-   You want to prevent plug-ins used in an [Asset Store package](https://docs.unity3d.com/6000.3/Documentation/Manual/AssetStorePackages.html) from conflicting with other code in a project into which the package is imported.

When you disable **Auto Reference** Unity cannot reference a plug-in from the predefined assemblies it creates for your project. These predefined assemblies contain all the scripts in your project that you have not assigned to another assembly using an assembly definition file. To reference classes, functions, or other resources from a plug-in that has the **Auto Reference** property disabled, the referencing code must be in an assembly created with an assembly definition file. For example, if a set of scripts in your project uses a plug-in, you must create an assembly definition file for those scripts, and add an explicit reference to the plug-in in the definition file.

More than one assembly can use the plug-in, but all assemblies must explicitly declare the dependency. To learn more about assembly definitions in Unity, refer to [Assembly definitions](https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definition-files.html).

**Note**: The **Auto Reference** option has no effect on whether a file is included in the build. To control build settings for plug-ins use [Platform settings](https://docs.unity3d.com/6000.3/Documentation/Manual/plug-in-inspector.html#platform-settings).

### General - Validate References

Unity can check that your plug-in’s references are available in the project. If you don’t perform this validation, users can encounter runtime errors when the application tries to use a missing reference.

Enable the **Validate References** option to check:

-   Whether the plug-in’s references exist. For example, if your plug-in references the plug-in Newtonsoft.Json.dll, and Unity cannot find Newtonsoft.Json.dll, Unity displays an error.
-   Whether strong named references will be able to load. This is important because strong named references need to match the version. For example, if you compile a plug-in with a reference to “b.dll” version 2.0.0, that version must be in the project.

If you don’t want to check strong named references, but still want to check that references exist:

1.  In the **Plugin** inspector, enable **Validate References**.
2.  In **Project Settings** > **Player** > **Other Settings** > disable **Assembly Version Validation**.

### Define Constraints

You can specify conditions under which Unity loads the plug-in to memory and references it. These conditions are symbols that must be satisfied, which means either defined or undefined.

Constraints work like the #if preprocessor directive in C#, but on the assembly level instead of the script level. You can learn more about constraints in [Assembly Definition properties](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AssemblyDefinitionImporter.html).

You can use any of Unity’s built-in define symbols, or add symbols in **Project Settings** \> **Player** \> **Other Settings** \> **Script Compilation** \> **Scripting Define Symbols**. The symbols you add are platform-specific, so you need to define them for each relevant platform. See [Platform dependent compilation](https://docs.unity3d.com/6000.3/Documentation/Manual/platform-dependent-compilation.html) for more information, including a list of the built-in symbols.

**Tip**: To specify that a symbol must be undefined, prefix it with a negating ! (exclamation mark) symbol.

In the following example, we want Unity to load and reference the plug-in only on non-IL2CPP scripting runtimes for Unity 2018.3 or newer. We define two constraints, and both must be met:

-   `ENABLE_IL2CPP` is not defined
-   `UNITY_2018_3_OR_NEWER` is defined

![Define Constraints for a specific runtime and Unity version](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/Define_Constraints.png)

## Plugin load settings - Load on startup

You can start executing unmanaged code that is independent of graphics initialization, scripts, asset loading, scenes, and so on. This is different to the default way a player loads a native plug-in, which is to wait until the first call to one of the plug-in’s functions, usually performed by a script.

To load plug-ins before the application executes any scripts:

1.  Implement `UnityPluginLoad` in the plug-in. Refer to [Low-level native plug-in interface](https://docs.unity3d.com/6000.3/Documentation/Manual/native-plugin-interface.html).
2.  In the Editor, select **Plugin load settings** > **Load on startup**.

**Tip**: For an example of a C# script calling plug-in functions, refer to [Manual: Native plug-ins](https://docs.unity3d.com/6000.3/Documentation/Manual/plug-ins-native.html).

## Additional resources

-   [Managed plug-ins](https://docs.unity3d.com/6000.3/Documentation/Manual/plug-ins-managed.html)
-   [Native plug-ins](https://docs.unity3d.com/6000.3/Documentation/Manual/plug-ins-native.html)
-   [Plugins for desktop](https://docs.unity3d.com/6000.3/Documentation/Manual/plug-ins-for-desktop.html)
-   [Native plug-in interface](https://docs.unity3d.com/6000.3/Documentation/Manual/native-plugin-interface.html)
