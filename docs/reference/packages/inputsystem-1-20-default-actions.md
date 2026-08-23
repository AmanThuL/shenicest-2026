---
title: "Default actions"
page_title: "The default project-wide actions | Input System | 1.20.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/default-actions.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/default-actions.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# The default project-wide actions

When you [create and assign default project-wide actions](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/create-project-wide-actions.html) the action assets comes pre-configured with some default actions such as "Move", "Jump", and more, which suit many common app and game scenarios. They are configured to read input from the most common types of input controller such as Keyboard, Mouse, Gamepad, Touchscreen, and extended reality (XR).

![image alt text](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/images/ProjectSettingsInputActionsSimpleShot.png) *The Input System Package Project Settings after creating and assigning the default actions*

These default actions mean that in many cases, you can start scripting with the Input System without any configuration by referring to the names of the default actions that are already configured for you. You can also rename and reconfigure the default actions, or delete these default configurations to suit your needs.

### The legacy default Actions Asset

##### Note

The default actions asset is entirely separate from the [default project-wide actions](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/about-project-wide-actions.html). It is a legacy asset that is included in the package for backwards compatibility.

The Input System package provides an asset called `DefaultInputActions.inputactions` which you can reference directly in your projects like any other Unity asset. The asset is also available in code form through the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.DefaultInputActions.html" class="xref"><code>DefaultInputActions</code></a> class.

``` lang-CSharp
void Start()

```
