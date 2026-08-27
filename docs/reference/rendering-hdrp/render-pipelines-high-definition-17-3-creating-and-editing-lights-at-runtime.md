---
title: "Create and edit lights at runtime"
page_title: "Create and edit lights at runtime | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/creating-and-editing-lights-at-runtime.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/creating-and-editing-lights-at-runtime.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Create and edit lights at runtime

The High Definition Render Pipeline (HDRP) extends Unity's [Light](https://docs.unity3d.com/Manual/class-Light.html) component with additional data and functionality. To do this, it adds the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/api/UnityEngine.Rendering.HighDefinition.HDAdditionalLightData.html" class="xref">HDAdditionalLightData</a> component to the GameObject that the Light component is attached to. Because of this, you cannot create and edit Lights at runtime in the usual way. This document explains how to create an HDRP [Light](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Light-Component.html) at runtime and how to edit its properties.

## Create a new light

HDRP provides a utility function that adds both the Light and HDAdditionalLightData components to a GameObject, and sets up its dependencies. The function is <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/api/UnityEngine.Rendering.HighDefinition.GameObjectExtension.html#UnityEngine_Rendering_HighDefinition_GameObjectExtension_AddHDLight_" class="xref"><code>AddHDLight</code></a>. The light unit for the intensity will be determined depending on the light type and shape. To learn more about light units and shapes, refer to [Create and configure light sources](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Light-Component.html).

```
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

public class LightScript : MonoBehaviour

}
```

There is also a [RemoveHDLight](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@latest?subfolder=/api/UnityEngine.Rendering.HighDefinition.GameObjectExtension.html#UnityEngine_Rendering_HighDefinition_GameObjectExtension_RemoveHDLight_UnityEngine_GameObject_) method to remove the light created with AddHDLight.

Note: Another good way of spawning lights is simply by spawning prefabs of lights you configured in the editor, this is also more efficient than manually adding components and setting values.

## Change the intensity

Set the light intensity using the Light component. Follow these steps:

1.  Set the units using the `lightUnit` property of the Light component. For example:

    ```
    lightComponent.lightUnit = LightUnit.Lumen;
    ```

2.  Set the intensity using the `ConvertIntensity` method of the `LightUnitUtils` class, to convert to the correct unit for the light type and shape.

    For example:

    ```
    LightUnit nativeUnit = LightUnitUtils.GetNativeLightUnit(lightComponent.type);
    lightComponent.intensity = LightUnitUtils.ConvertIntensity(lightComponent, 600f, LightUnit.Lumen, nativeUnit);
    ```

## Change the color

Set the light color using the HDAdditionalLightData component. For example:

```
hdLight.color = Color.red;
```

Set light color temperature in Kelvin:

```
hdLight.SetColor(Color.white, 1900); // 1900K is the color of a candle
```

Note: when you set the color/intensity of the light, it also affects the emissive plane color of area lights if enabled.

## Animate lights

Light in HDRP can be animated like regular lights, though an important thing to note is that the values recorded in the animation are coming from both the HDAdditionalLightData component and Light component.

Also, animated lights have a slightly more expensive cost on the CPU because of the additional calculation that needs to be made when light values are changing.
