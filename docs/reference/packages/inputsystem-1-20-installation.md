---
title: "Input System - Installation"
page_title: "Installation guide | Input System | 1.20.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/Installation.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/Installation.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Installation guide

This page describes how to install and activate the **Input System** package for your Unity Project.

##### Note

This version of the new Input System requires the .NET 4 runtime. It doesn't work in projects using the old .NET 3.5 runtime.

This package is only compatible with Unity Editor release versions 2021.3 and later. If you are working in a release version of the Editor prior to 2021.3, you need to use the package version that works with that version of the Editor, indicated by the **Release** tag in the [Unity Package Manager](https://docs.unity3d.com/Manual/upm-ui.html) window.

## Install the package

To install the new Input System:

1.  In the main menu of the Unity Editor, go to **Window** > **Package Manager** to open the Unity Package Manager.

2.  Select **Unity Registry** from the navigation panel.

3.  Select the **Input System** package from the list.

    The Package Manager automatically selects that version to install by default.

4.  Select **Install**, follow any prompts to [enable the backends](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/Installation.html#) for the new Input System.

This package also provides several samples that demonstrate how to work with the new Input System, which are also available on the [Unity Package Manager](https://docs.unity3d.com/Manual/upm-ui.html) window. Refer to [Install samples](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/Installation.html#install-samples).

## Enable the new input backends

By default, Unity's classic Input Manager (`UnityEngine.Input`) is active, and support for the new Input System is inactive. This allows existing Unity Projects to keep working as they are.

When you install the Input System package, Unity will ask whether you want to enable the new backends. Click **Yes** to enable the new backends and disable the old backends. The Editor restarts during this process.

![Editor Restart Warning](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/images/EditorRestartWarning.png)

You can find the corresponding setting in **Edit** \> **Project Settings** \> **Player** \> **Other Settings** \> **Active Input Handling**. If you change this setting you must restart the Editor for it to take effect.

##### Note

You can enable **both** the old **and** the new system at the same time. To do so, set **Active Input Handling** to **Both**.

![Active Input Handling](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/images/ActiveInputHandling.png)

When the new input backends are enabled, the `ENABLE_INPUT_SYSTEM=1` C# `#define` is added to builds. Similarly, when the old input backends are enabled, the `ENABLE_LEGACY_INPUT_MANAGER=1` C# `#define` is added. Because both can be enabled at the same time, it is possible for **both** defines to be 1 at the same time.

## Install samples

The package comes with a number of samples. You can install these directly from the Package Manager window in Unity (**Window \> Package Manager**).

To view the list of samples:

1.  Select the package in the **Package Manager** window.
2.  Select the **Samples** tab.
3.  Select **Import** next to any sample name to import that sample into the current project.

![Install Samples](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/images/InstallSamples.png)

For a more comprehensive demo project for the Input System, refer to the [InputSystem_Warriors](https://github.com/UnityTechnologies/InputSystem_Warriors) GitHub repository.
