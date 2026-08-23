---
title: "Polling actions"
page_title: "Polling actions | Input System | 1.20.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/polling-actions.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/polling-actions.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Polling actions

Polling actions is one of the two main [ways to respond to actions](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/about-responding-to-input.html) using the recommended workflow.

Polling refers to the act of repeatedly checking the status or value of an action. This is in contrast to using callbacks which are only triggered when an action is performed.

The code required to poll an action depends on the [action type](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/action-type-reference.html), and whether you want to read the action's values or use the [interaction state](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/Interactions.html) instead.

## Poll value-type actions

To poll an action whose type is **Value** or **Pass-through**, use:

-   <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html" class="xref"><code>ReadValue&lt;&gt;()</code></a>

You must use the corresponding type that matches the action's [control type's](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/action-and-control-types.html) value. For example, `ReadValue<Vector2>()` for a 2D axis.

## Poll button-type actions

To poll an action whose type is **Button**, use:

-   <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html" class="xref"><code>IsPressed()</code></a>
-   <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html" class="xref"><code>WasPressedThisFrame()</code></a>
-   <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html" class="xref"><code>WasReleasedThisFrame()</code></a>

Buttons have no applicable value other than whether they are pressed or released.

## Poll using interaction phases

Actions have [interaction phases](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/introduction-interactions.html) which can be either `Waiting`, `Started`, `Performed` or `Canceled`. The interaction phase changes depending on the action's [interaction type](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/built-in-interactions.html), if one is assigned, or the [default interaction](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/default-interactions.html) otherwise. You can poll an action's interaction phase using the following methods:

-   <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html" class="xref"><code>phase</code></a>
-   <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html" class="xref"><code>WasPerformedThisFrame()</code></a>
-   <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html" class="xref"><code>WasCompletedThisFrame()</code></a>

## Examples

### Polling actions example with a 2D axis and a button action

This example shows polling two actions in `Update`.

The `Move` action is a value-type, and the `Jump` action is a button-type.

``` lang-CSharp
using UnityEngine;
using UnityEngine.InputSystem;

public class Example : MonoBehaviour

    void Update()
    
    }
}
```

### Polling actions example using interaction phase

This example uses the Interact action from the [default actions](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/default-actions.html), which has a [Hold](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/built-in-interactions.html#hold) interaction to make it perform only after the bound control is held for a period of time (for example, 0.4s):

``` lang-CSharp
using UnityEngine;
using UnityEngine.InputSystem;

public class Example : MonoBehaviour

    void Update()
    
        if (interactAction.WasCompletedThisFrame())
        
    }
}
```

### Polling button actions example

This example uses three actions called Shield, Teleport, and Submit (which are not included in the [default actions](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/default-actions.html)):

``` lang-CSharp
using UnityEngine;
using UnityEngine.InputSystem;

public class Example : MonoBehaviour

    void Update()
    
        if (teleportAction.WasPressedThisFrame())
        
            if (submitAction.WasReleasedThisFrame())
        
    }
}
```
