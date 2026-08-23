---
title: "Generate C# API from actions"
page_title: "Generate C# API from actions | Input System | 1.20.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/generate-cs-api-from-actions.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/generate-cs-api-from-actions.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Generate C# API from actions

Input action assets allow you to **generate a C# class** from your action definitions, which allow you to refer to your actions in a type-safe manner from code.

This removes the need to manually look up Actions and action maps using their names, and also provides an easy way to set up callbacks.

##### Note

This is an alternative workflow to [project-wide actions](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/about-project-wide-actions.html), and provides a different way to access the actions defined in your action asset.

To enable type-safe C# API generation:

1.  Select the action asset in the Project window.
2.  In the Inpsector window, enable the **Generate C# Class** option.
3.  Select **Apply**.

![MyPlayerControls Importer Settings](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/images/FireActionInputAssetInspector.png)

You can optionally choose a path name, class name, and namespace for the generated script, or keep the default values.

Once applied, the Input System creates a C# script containing API that matches the actions defined in the asset which you can access directly in code. The following example demonstrates this, assuming there is an action map named "gameplay" containing two actions, "use" and "move" defined in the action asset:

``` lang-CSharp
using UnityEngine;
using UnityEngine.InputSystem;

// IGameplayActions is an interface generated from the newly added "gameplay"
// action map, triggered by the "Generate Interfaces" checkbox. Note that if
// you change the default values for the action map, the name of the interface
// will be different.

public class MyPlayerScript : MonoBehaviour, IGameplayActions

        controls.gameplay.Enable();
    }

    public void OnDisable()
    
    public void OnUse(InputAction.CallbackContext context)
    
    public void OnMove(InputAction.CallbackContext context)
    
}
```

##### Note

To regenerate the .cs file, right-click the .inputactions asset in the Project Browser and select **Reimpor**.
