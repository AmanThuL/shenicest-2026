---
title: "Safe Mode"
page_title: "Unity - Manual: Safe Mode"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/SafeMode.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/SafeMode.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Safe Mode

## Overview

Unity’s Safe Mode is a mode that the Unity Editor can enter when you open a project that has script compilation errors. Safe Mode is designed to provide the best environment for resolving compilation errors, so that you can quickly return your project to a functional state.

In Safe Mode, Unity provides a minimal version of the Editor user interface, with limited functions. It only imports script-related assets, and prevents the import of non-script assets (such as models, materials, textures and prefabs). This is because Safe Mode is not meant for content production, only for resolving compilation errors.

Safe Mode never allows managed code to run from your project, or its packages. This means your own scripts such as [Editor scripts](https://docs.unity3d.com/6000.3/Documentation/Manual/ExtendingTheEditor.html), [asset post-processors](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.html), and [scripted importers](https://docs.unity3d.com/6000.3/Documentation/Manual/ScriptedImporters.html) do not run. Safe Mode also disables [assembly overrides](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AssemblyDefinitionImporter.html#assembly-references), and the [Burst](https://docs.unity3d.com/6000.3/Documentation/Manual/com.unity.burst.html) and [Roslyn](https://docs.unity3d.com/6000.3/Documentation/Manual/roslyn-analyzers.html) Analysers. This ensures the Editor in Safe Mode is always fully functional and reliable, even when it opens a project in a very broken state.

Unity automatically exits Safe Mode when it detects there are no more compilation errors. When it exits Safe Mode, Unity imports your project in full, and the Editor restores its normal full functionality.

## Common causes of compilation errors

Some common scenarios that might result in you encountering compilation errors occur when you:

-   Upgrade a project from an older version of Unity to a newer version.
-   Open a project in a different version of Unity from the one it was created in.
-   Open a project with a missing [package](https://docs.unity3d.com/6000.3/Documentation/Manual/PackagesList.html), or an incorrect version of a package.
-   Open a project which has errors in your own scripts.
-   Open a project under [version control](https://docs.unity3d.com/6000.3/Documentation/Manual/VersionControl.html), where the latest changes you pulled contained compilation errors.

Opening a project that has compilation errors without Safe Mode can cause many kinds of problems. For example, [packages](https://docs.unity3d.com/6000.3/Documentation/Manual/PackagesList.html) in your project might not load or function properly, and your assets might be imported incorrectly, resulting in incorrect cached artifacts in your [Library](https://docs.unity3d.com/6000.3/Documentation/Manual/ImportingAssets.html#asset-processing) or in your [Cache Server](https://docs.unity3d.com/6000.3/Documentation/Manual/UnityAccelerator.html).

In these situations, you usually don’t want to wait for the rest of the project to import before you can resolve the errors. Safe Mode provides you with the tools to resolve these script-related problems yourself, or to use version control to update your project to a newer version that resolves the errors, without waiting for a full import of the project.

## Entering Safe Mode

When you open a project which has compilation errors, the Editor displays a dialog to ask whether you want to enter Safe Mode:

![The Enter Safe Mode? dialog prompts you to enter Safe Mode when you open a project with compilation errors](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/SafeModeDialog.png)

At this point you have three choices:

-   **Enter Safe Mode**
-   **Ignore** the errors and open your project
-   **Quit** Unity

In most cases, you should select **Enter Safe Mode** to resolve the errors in your project (or, if you’re working with version control, to pull changes which contain fixes to the errors). Safe Mode provides the best environment for resolving compilation errors, so that you can quickly return your project to a functional state before Unity imports the rest of your project.

However, there are some cases where you might not want to enter Safe Mode, in which case you can **Quit** Unity, or **Ignore** the errors.

**Note**: *You can disable this dialog in ****Edit \> Preferences \> Asset Pipeline \> Show Enter Safe Mode Dialog****. If you disable the dialog, Unity automatically enters Safe Mode when it opens a project with compilation errors.*

### Quitting without entering Safe Mode

Safe Mode is specifically designed for fixing compilation errors. If you are working on a Unity project as part of a team, but you are not responsible for the scripts that are causing errors, and don’t know what to do, you should select **Quit** in the dialog, and contact the programmers on your team for advice.

<span id="IgnoringErrors"></span>

### Ignoring the errors and continuing import

There are some situations where you don’t need the project to be in a usable state (for example, if you are opening an old project to copy some parts out, or to simply inspect how it is configured). In this case, you can ignore the errors and open your project in a broken state anyway.

If you select **Ignore**, and later want to open the project in Safe Mode, you can close and re-open Unity to access the “Enter Safe Mode” dialog again.

### Implications of ignoring compilation errors

If you choose to ignore the errors, Unity continues to import the rest of your assets and opens your project fully. Potential implications here include:

-   Your project might not be in a usable state. You might not be able to enter Play Mode, or create builds of your project, until the errors are resolved. In addition, any packages in your project might not load correctly, or at all.

-   Unity might need to import your assets twice; once at launch, and again after you resolve the project’s compilation errors. This increases the amount of time it takes to load your project in a usable state.

-   If your project uses a [Scriptable Render Pipeline](https://docs.unity3d.com/6000.3/Documentation/Manual/scriptable-render-pipeline-introduction.html), your render pipeline might not load, resulting in visual problems such as the [error shader](https://docs.unity3d.com/6000.3/Documentation/Manual/shader-error.html).

-   Script compilation errors can cause secondary errors within your project. For example, if a [scripted importer](https://docs.unity3d.com/6000.3/Documentation/Manual/ScriptedImporters.html) in your project is unable to load because of compilation errors, your assets might import in an incorrect state.

Safe Mode is designed to help you avoid all of these problems.

## The Editor in Safe Mode

In Safe Mode, Unity provides a minimal Editor interface with limited functions.

![The Unity Editor in Safe Mode](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/SafeModeEditor.png)

The Unity Editor displays a Safe Mode banner in the toolbar section at the top of the Editor, which replaces the standard Editor toolbar. The toolbar indicates that you are in Safe Mode, and provides an **Exit Safe Mode** button, which allows you to ignore the remaining errors and exit Safe Mode. The banner also indicates whether your project uses [preview packages](https://docs.unity3d.com/6000.3/Documentation/Manual/pack-preview.html).

The Unity Editor retains its [integration with code editors](https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-ide-support.html) in Safe Mode, so you can double-click on script assets or [console error](https://docs.unity3d.com/6000.3/Documentation/Manual/Console.html)[s](https://docs.unity3d.com/6000.3/Documentation/Manual/Console.html) to open their associated scripts, and you can open the C# project via the **Assets** menu. It also retains its integration with [Version Control systems](https://docs.unity3d.com/6000.3/Documentation/Manual/VersionControl.html).

### The restricted set of windows in Safe Mode

The Editor displays a limited selection of windows in Safe Mode. These are:

-   The Console window
-   The Project window
-   The Inspector window
-   The Package Manager window

These are the only windows available because they relate to fixing compilation errors. No other windows are available in Safe Mode.

### The Editor Menu in Safe Mode

The options available in the Editor’s main menu are restricted to a limited set while in Safe Mode. You can only see and select the menu options which relate to working with scripts; the regular options for creating and working with other content are not available. For example, you cannot create or open Scenes, or create non-script assets such as primitive shapes, lights, or cameras. The **GameObject** and **Component** menus are not present, and the **Window** menu only offers a restricted set of windows.

![The restricted Editor Menu as it appears in Safe Mode, displaying the available options for creating assets.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/SafeModeLimitedMenu.png)

### The Project window in Safe Mode

In Safe Mode, the Project window has some functional differences compared with its normal behavior outside of Safe Mode.

The primary difference is that you can only select compilation-related assets. Other asset types are not selectable. They remain visible as grayed-out entries in the Project window, but you cannot select or edit them.

Specifically, the compilation-related asset types that you can interact with are:

-   C# files (.cs)
-   DLL files (.dll)
-   Assembly definitions (.asm)
-   Response files (.rsp)
-   Ruleset files (.ruleset)

In addition, the icons for the non-selectable assets do not show a preview of the content of the asset. Instead, they show a generic icon to represent the asset’s type.

![The Project window displays generic icons for non-selectable assets.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/SafeModeProjectWindow.png)

The **create (+)** menu button is disabled, and the Project window context menu has a reduced set of options available.

![The ****create (+)**** menu button in the project window, disabled in Safe Mode](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/SafeModeCreateButton.png)

## Exiting Safe Mode

Unity automatically exits Safe Mode when you have resolved all the compilation errors. Unity then continues to open your project and import your assets.

To exit Safe Mode while there are still compilation errors remaining, select the **Exit Safe Mode** button in the Safe Mode toolbar. This is not recommended (see [Implications of ignoring compilation errors](https://docs.unity3d.com/6000.3/Documentation/Manual/SafeMode.html#IgnoringErrors)), and Unity prompts you with a dialog to confirm your decision.

![The **Exit Safe Mode** button in the Safe Mode toolbar](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/SafeModeExitButton.png)

If you exit Safe Mode while errors remain in your project, and later want to return to Safe Mode, you can close and re-open Unity to access the “Enter Safe Mode” dialog again..

## Safe Mode in Batch Mode

In Batch Mode, Unity automatically quits if there are compilation errors in your project, unless you use the `-ignoreCompilerErrors` [command line argument](https://docs.unity3d.com/6000.3/Documentation/Manual/CommandLineArguments.html).
