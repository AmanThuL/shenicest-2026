---
title: "User rebinding at runtime"
page_title: "User rebinding at runtime | Input System | 1.20.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/user-rebinding-runtime.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/user-rebinding-runtime.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# User rebinding at runtime

A common requirement in games is to allow your users to rebind the controls to a configuration of their preference. For example, choosing which button on their controller maps to particular actions in the game. Learn how to implement user rebinding in this section.

| **Topic**                                                                                                                           | **Description**                                                                  |
|:------------------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------|
| **[Look up bindings](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/look-up-bindings.html)**                   | Retrieve the bindings of an action using its `InputAction.bindings`.             |
| **[Display bindings](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/display-bindings.html)**                   | Use `InputBinding.effectivePath` to get the currently active path for a binding. |
| **[Rebind an action at runtime](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/rebind-action-runtime.html)**   | Allow users of your application to set their own bindings.                       |
| **[Save and load rebinds](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/save-load-rebinds.html)**             | Serialize override properties of bindings as JSON strings.                       |
| **[Restore original bindings](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/restore-original-bindings.html)** | Remove binding overrides to restore defaults.                                    |

## Additional resources

-   [Bindings](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/bindings.html)
-   [Configure actions](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/configure-actions.html)
-   [Setting up input](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/setting-up-input.html)
-   [Input for user interfaces](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/ui-input.html)
