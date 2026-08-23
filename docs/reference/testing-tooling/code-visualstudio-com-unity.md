---
title: "Unity Development with VS Code (Microsoft)"
page_title: "Unity Development with VS Code"
source_url: "https://code.visualstudio.com/docs/other/unity"
final_url: "https://code.visualstudio.com/docs/other/unity"
topic: "testing-tooling"
publisher: "third-party"
fetched: "2026-08-23"
kind: "html"
---

# Unity Development with VS Code

<span class="codicon codicon-copy" aria-hidden="true"></span> Copy as Markdown

<span class="codicon codicon-chevron-down docs-markdown-chevron" aria-hidden="true"></span>

-   <span class="codicon codicon-copy" aria-hidden="true"></span> Copy as Markdown
-   <span class="codicon codicon-file" aria-hidden="true"></span> View as Markdown <span class="codicon codicon-link-external" aria-hidden="true"></span>

# Unity Development with VS Code

Visual Studio Code makes it easy to write and debug your C# scripts for Unity.

[![Unity Overview](https://code.visualstudio.com/assets/docs/other/unity/unity-overview.png)](https://code.visualstudio.com/assets/docs/other/unity/unity-overview.png)

This guide will help you make Unity and Visual Studio Code work together. If you're looking for resources to learn C#, check out our C# curriculum.

<a href="https://aka.ms/selfguidedcsharp" class="install-extension-btn">Learn C# Curriculum</a>

If you're looking for resources to learn Unity, check out the learning section of the Unity website.

<a href="https://unity.com/learn" class="install-extension-btn">Learn Unity</a>

Read on to find out how to configure Unity and your project to get the best possible experience.

## Install

1.  You will need at least <a href="https://www.unity.com" class="external-link">Unity</a> 2021 installed.

2.  If you haven't already done so, [install Visual Studio Code](https://code.visualstudio.com).

3.  Next, install the <a href="https://aka.ms/vscode-unity" class="external-link">Unity for Visual Studio Code</a> extension from the Visual Studio Marketplace. For additional details on installing extensions, read [Extension Marketplace](https://code.visualstudio.com/docs/configure/extensions/extension-marketplace). The Unity extension is published by Microsoft.

Installing the Unity extension installs all its dependencies required to write [C#](https://code.visualstudio.com/docs/languages/csharp) with Visual Studio Code, including the <a href="https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csdevkit" class="external-link">C# Dev Kit</a>.

## Set up Unity

### Update the Visual Studio Package

The Unity extension for Visual Studio Code depends on the `Visual Studio Editor` Unity Package. In Unity, open up **Windows**, **Packages**. Make sure the `Visual Studio Editor` package is upgraded to `2.0.20` or above.

![Unity Package Manager](https://code.visualstudio.com/assets/docs/other/unity/unity-packagemanager.png)

> **Note**: The `Visual Studio Code Editor` package published by Unity is a legacy package from Unity that is not maintained anymore.

## Set VS Code as Unity's external editor

Open up **Unity Preferences**, **External Tools**, then select Visual Studio Code as **External Script Editor**.

![Unity Preferences](https://code.visualstudio.com/assets/docs/other/unity/unity-externaltools.png)

## Editing Evolved

You are now ready to start editing with Visual Studio Code. Double-clicking on a C# script in Unity will open Visual Studio Code. Here is a list of some of the things you can expect:

-   Syntax Highlighting
-   Bracket matching
-   IntelliSense
-   Snippets
-   CodeLens
-   Peek
-   Go-to Definition
-   Code Actions/Lightbulbs
-   Go to symbol
-   Hover

Two topics that will help you are [Basic Editing](https://code.visualstudio.com/docs/editing/codebasics) and [C#](https://code.visualstudio.com/docs/languages/csharp). In the image below, you can see VS Code showing hover context, peeking references, and more.

![editing evolved example](https://code.visualstudio.com/assets/docs/other/unity/peekreferences.png)

## Debugging

By default, your Unity project is setup with a debugger configuration to attach the Unity debugger to the Unity Editor instance opened on the project. Press <span class="dynamic-keybinding" commandid="workbench.action.debug.start" linux="F5" osx="F5" win="F5"><span class="keybinding">F5</span></span> to start a debugging session.

If you want to debug a Unity standalone player, the easiest way is to use the **Attach Unity Debugger** command.

Alternatively, you can modify the `.vscode/launch.json` file in your project and add a new debugger configuration for an IP endpoint you control:

``` shiki

```

## Next steps

Read on to learn more about:

-   [Basic Editing](https://code.visualstudio.com/docs/editing/codebasics) - Learn about the powerful Visual Studio Code editor.
-   [Code Navigation](https://code.visualstudio.com/docs/editing/editingevolved) - Move quickly through your source code.
-   [C#](https://code.visualstudio.com/docs/languages/csharp) - Learn about the C# support in Visual Studio Code.

8/4/2023
