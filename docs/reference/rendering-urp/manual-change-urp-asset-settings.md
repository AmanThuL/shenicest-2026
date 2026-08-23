---
title: "Change URP asset settings at runtime"
page_title: "Unity - Manual: Change URP asset settings at runtime"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/quality/change-urp-asset-settings.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/quality/change-urp-asset-settings.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Change URP asset settings at runtime

You can change some properties of the URP asset at runtime with C# scripts. This can help fine tune performance on devices with hardware that doesn’t perfectly match any of the quality levels in your project.

> **Note**: To change a property of the URP asset with a C# script, the property must have a `set` method. For more information on these properties, refer to [Universal Render Pipeline asset API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.universal@17.2/api/UnityEngine.Rendering.Universal.UniversalRenderPipelineAsset.html#properties).

The following example uses the QualityControls script and QualityController object from the [Change Quality Level](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/quality/quality-settings-through-code.html) section, and extends the functionality to locate the active URP asset and change some of its properties to fit the performance level of the hardware.

1.  Open the QualityControls script.

2.  At the top of the script add `using UnityEngine.Rendering` and `using UnityEngine.Rendering.Universal`.

3.  Add a method with the name `ChangeAssetProperties` and the type `void` to the `QualityControls` class as shown below.

    ``` lang-cs
    using System.Collections;
    using System.Collections.Generic;
    using UnityEngine;
    using UnityEngine.Rendering;
    using UnityEngine.Rendering.Universal;

    public class QualityController : MonoBehaviour
    
        private void SwitchQualityLevel()
        
        private void ChangeAssetProperties()
        
    }
    ```

4.  Retrieve the active Render Pipeline asset with `GraphicsSettings.currentRenderPipeline` as shown below.

    > **Note**: You must use the `as` keyword to cast the Render Pipeline asset as the `UniversalRenderPipelineAsset` type for the script to work correctly.

    ``` lang-cs
    using System.Collections;
    using System.Collections.Generic;
    using UnityEngine;
    using UnityEngine.Rendering;
    using UnityEngine.Rendering.Universal;

    public class QualityController : MonoBehaviour
    
        private void SwitchQualityLevel()
        
        private void ChangeAssetProperties()
        
    }
    ```

5.  Add a `switch` statement in the ChangeAssetProperties method to set the value of the URP asset properties.

    ``` lang-cs
    using System.Collections;
    using System.Collections.Generic;
    using UnityEngine;
    using UnityEngine.Rendering;
    using UnityEngine.Rendering.Universal;

    public class QualityController : MonoBehaviour
    
        private void SwitchQualityLevel()
        
        private void ChangeAssetProperties()
        
        }
    }
    ```

6.  Add a call to the `ChangeAssetProperties` method in the `Start` method. This ensures that the URP asset only changes when the scene first loads.

    ``` lang-cs
    using System.Collections;
    using System.Collections.Generic;
    using UnityEngine;
    using UnityEngine.Rendering;
    using UnityEngine.Rendering.Universal;

    public class QualityController : MonoBehaviour
    
        private void SwitchQualityLevel()
        
        private void ChangeAssetProperties()
        
        }
    }
    ```

Now when this scene loads, Unity detects the system’s total graphics memory and sets the URP asset properties accordingly.

You can use this method of changing particular URP asset properties in conjunction with changing quality levels to fine tune the performance of your project for different systems without the need to create a quality level for every target hardware configuration.
