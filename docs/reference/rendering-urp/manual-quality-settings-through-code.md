---
title: "Change the active URP asset at runtime"
page_title: "Unity - Manual: Change the active URP asset at runtime"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/quality/quality-settings-through-code.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/quality/quality-settings-through-code.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Change the active URP asset at runtime

Unity has several preset levels of [Quality settings](https://docs.unity3d.com/Manual/class-QualitySettings.html) and you might add more to your project. To accommodate different hardware specifications, you can switch between these levels and the associated URP asset from C# scripts. The following examples show how to use API to change Quality setting levels and the active URP asset, and how to change specific settings in the URP asset at runtime.

**Note**: You should only change Quality settings and URP asset settings at runtime at points where performance is not essential, such as during loading screens or on static menus. This is because these changes cause a temporary but significant performance impact.

## Change the active URP asset

Each quality level uses a URP asset to control many of the specific graphics settings. You can assigning different URP assets to each quality level and switch between them at runtime.

### Configure Project Quality settings

To use Quality settings to switch between URP assets, ensure that the quality levels of your project are configured to use different URP assets. The URP 3D Sample scene has this configuration by default.

1.  Create a URP asset for each quality level. To do this, right-click in the Project window and select **Create** > **Rendering** > **URP Asset (with Universal Renderer)**.

    > **Note**: These instructions are also valid for URP assets that use the 2D Renderer.

2.  Configure and name the new URP assets as necessary.

3.  Open the Quality section in the Project Settings (**Edit** > **Project Settings** > **Quality**).

4.  Assign each URP asset to a quality level. To do this, select a quality level from the Levels list, then go to **Rendering** > **Render Pipeline Asset** and choose the URP asset you created for this quality level. Do this for each quality level.

The quality levels of your project are now ready to be used to change between URP assets at runtime.

<span id="change-quality-level"></span>

### Change Quality Level

You can change the quality level Unity uses at runtime through the [QualitySettings API](https://docs.unity3d.com/ScriptReference/QualitySettings.html). With the quality levels setup as shown previously, this enables you to switch between URP assets as well as Quality settings presets.

In the following simple example, the C# script uses the system’s total Graphics Memory to determine the appropriate quality level without any input from the user when they open the built project.

1.  Create a new C# script with the name QualityControls.

2.  Open the QualityControls script and add the `SwitchQualityLevel` method to the `QualityControls` class.

    ``` lang-cs
    using System.Collections;
    using System.Collections.Generic;
    using UnityEngine;

    public class QualityControls : MonoBehaviour
    
        private void SwitchQualityLevel()
        
    }
    ```

3.  Add a `switch` statement in the `SwitchQualityLevel` method to select the quality level with the `QualitySettings.SetQualityLevel()` method as shown below.

    > **Note**: Each Quality level has an index that matches the level’s position in the list in the Quality section of the Project Settings window. The quality level at the top of the list has an index of 0. This index only counts quality levels which you specified as enabled for the target platform of any built version of your project.

    ``` lang-cs
    using System.Collections;
    using System.Collections.Generic;
    using UnityEngine;

    public class QualityControls : MonoBehaviour
    
        private void SwitchQualityLevel()
        
        }
    }
    ```

4.  Add a call to the `SwitchQualityLevel` method in the `Start` method. This ensures that the quality level only changes when the scene first loads.

    ``` lang-cs
    using System.Collections;
    using System.Collections.Generic;
    using UnityEngine;

    public class QualityControls : MonoBehaviour
    
        private void SwitchQualityLevel()
        
        }
    }
    ```

5.  Open the first scene that your built project loads on startup.

6.  Create an empty GameObject and call it QualityController. To do this, right-click in the Hierarchy Window and select **Create Empty**.

7.  Open the QualityController object in the Inspector.

8.  Add the QualityControls script to the QualityController as a component.

Now when this scene loads, Unity runs the `SwitchQualityLevel` method in the QualityControls script which detects the system’s total graphics memory and sets the quality level. The quality level sets the URP asset as the active Render Pipeline asset.

You can create more complex systems and sequences of checks to determine which quality level to use, but the fundamental process remains the same. When the project starts, run a script which uses [`QualitySettings.SetQualityLevel`](https://docs.unity3d.com/ScriptReference/QualitySettings.SetQualityLevel.html) to select a quality level and through that select the URP asset for the project to use at runtime.
