---
title: "Use Input System with Cinemachine"
page_title: "Use Input System with Cinemachine | Cinemachine | 3.1.7"
source_url: "https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/InputSystemComponents.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/InputSystemComponents.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Use Input System with Cinemachine

For more complex input configurations like supporting multiple devices, you will need to receive inputs from the `PlayerInput` component provided by the Input System package. The following section assumes you already know how to setup this component. For more information, see the [Input System](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.5/manual/index.html) documentation and samples.

### Read from PlayerInput

To read values from a `PlayerInput` with a `behaviour` set to `InvokeCSharpEvents`, you need to create a custom `InputAxisController` that subscribes to `onActionTriggered`. The example below shows how to receive and wire those inputs accordingly. Add this script to your `CinemachineCamera` and assign the `PlayerInput` field.

``` lang-cs
using System;
using UnityEngine;
using UnityEngine.InputSystem;
using Unity.Cinemachine;

// This class receives input from a PlayerInput component and dispatches it
// to the appropriate Cinemachine InputAxis.  The playerInput component should
// be on the same GameObject, or specified in the PlayerInput field.
class CustomInputHandler : InputAxisControllerBase<CustomInputHandler.Reader>
{
    [Header("Input Source Override")]
    public PlayerInput PlayerInput;

    void Awake()
    {
        // When the PlayerInput receives an input, send it to all the controllers
        if (PlayerInput == null)
            TryGetComponent(out PlayerInput);
        if (PlayerInput == null)
            Debug.LogError("Cannot find PlayerInput component");
        else
        {
            PlayerInput.notificationBehavior = PlayerNotifications.InvokeCSharpEvents;
            PlayerInput.onActionTriggered += (value) =>
            {
                for (var i = 0; i < Controllers.Count; i++)
                    Controllers[i].Input.ProcessInput(value.action);
            };
        }
    }

    // We process user input on the Update clock
    void Update()
    
    // Controllers will be instances of this class.
    [Serializable]
    public class Reader : IInputAxisReader
    
        }

        // IInputAxisReader interface: Called by the framework to read the input value
        public float GetValue(UnityEngine.Object context, IInputAxisOwner.AxisDescriptor.Hints hint)
        
    }
}
```

For more information, see the [Cinemachine Multiple Camera](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/CinemachineMultipleCameras.html) documentation and example if you need to dynamically instantiate cameras.
