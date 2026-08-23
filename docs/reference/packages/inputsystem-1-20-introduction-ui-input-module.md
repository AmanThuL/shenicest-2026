---
title: "Introduction to the UI Input Module"
page_title: "Introduction to the UI Input Module | Input System | 1.20.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/introduction-ui-input-module.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/introduction-ui-input-module.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to the UI Input Module

The UI Input Module passes actions from your Input System to your UI, alongside some other UI-related input settings.

You must use the **UI Input Module** when working with Unity UI (uGUI), or when using UI Toolkit in versions of Unity prior to Unity 2023.2.

You don't need to specify to the UI Input Module which UI system you are using. Input support for both [Unity UI](https://docs.unity3d.com/Manual/com.unity.ugui.html) and [UI Toolkit](https://docs.unity3d.com/Manual/UIElements.html) is based on the same [Event System](https://docs.unity3d.com/Packages/com.unity.ugui@1.0/manual/EventSystem.html) and [BaseInputModule](https://docs.unity3d.com/Packages/com.unity.ugui@1.0/manual/InputModules.html) subsystem.

The UI Input module is implemented in the class <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.UI.InputSystemUIInputModule.html" class="xref"><code>InputSystemUIInputModule</code></a>.

## Input priority

If you have an instance of the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.UI.InputSystemUIInputModule.html" class="xref">Input System UI Input Module</a> component in your scene, the settings on that component takes priority and are used instead of the UI settings in your project-wide actions. The UI action map is enabled, along with the default action map specified on any UI Input Module component in the scene.
