---
title: "Scripting with actions API overview"
page_title: "Scripting with actions API overview | Input System | 1.20.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/api-overview.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/api-overview.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Scripting with actions API overview

When scripting with actions in the Input System, there are number of important APIs you can use, listed here.

## Namespace

The Input System's API is contained in the `UnityEngine.InputSystem` namespace. To use it, include the namespace as follows:

    using UnityEngine.InputSystem;

## Important APIs

| API name                                                                                                                                                              | Description                                                                                                                                                                                                                                                                                                                                                                  |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html" class="xref"><code>InputSystem.actions</code></a> | A reference to the set of actions assigned as the [project-wide Actions](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/about-project-wide-actions.html).                                                                                                                                                                                               |
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html" class="xref"><code>InputAction</code></a>         | The class which represents an action. You can use a reference to an action to read the current value of the controls that it is bound to, or to trigger callbacks in response to input. This class corresponds to an entry in the **Actions** column of the [Input Actions editor](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/actions-editor.html). |
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref"><code>InputActionMap</code></a>   | The class which represents an [action map](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/create-edit-delete-action-maps.html). The API equivalent to an entry in the **Action Maps** column of the [Input Actions editor](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/actions-editor.html).                                    |
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputBinding.html" class="xref"><code>InputBinding</code></a>       | The relationship between an action and the specific device controls for which it receives input. For more information about bindings and how to use them, refer to [Bindings](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/bindings.html).                                                                                                            |

## Actions

The <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html" class="xref"><code>InputAction</code></a> class represents an action in the Input System. These are the same actions that you [create in the actions editor](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/Actions.html).

With a reference to an action, you can then read values and state changes using either the [polling](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/polling-actions.html) or [callbacks](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/set-callbacks-on-actions.html) workflow.

Each action has a name (<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html" class="xref"><code>InputAction.name</code></a>), which must be unique within the action map that the action belongs to, if any (refer to <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html" class="xref"><code>InputAction.actionMap</code></a>). Each action also has a unique ID (<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html" class="xref"><code>InputAction.id</code></a>), which you can use to reference the action. The ID remains the same even if you rename the action.

## Action maps

Each action map has a name (<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref"><code>InputActionMap.name</code></a>), which must also be unique with respect to the other action maps present, if any. Each action map also has a unique ID (<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref"><code>InputActionMap.id</code></a>), which you can use to reference the action map. The ID remains the same even if you rename the action map.

With a reference to an action map, you can then read all the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref"><code>actions</code></a> which belong to that map.
