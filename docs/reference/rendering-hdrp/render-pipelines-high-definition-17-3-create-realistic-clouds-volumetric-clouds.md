---
title: "Create realistic clouds (Volumetric Clouds)"
page_title: "Create realistic clouds (volumetric clouds) | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-realistic-clouds-volumetric-clouds.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-realistic-clouds-volumetric-clouds.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Create realistic clouds (volumetric clouds)

Volumetric clouds are interactable clouds that can render shadows, and receive fog and volumetric light.

Refer to [Understand clouds](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-clouds.html) for more information about clouds in the High Definition Render Pipeline (HDRP).

## Enabling Volumetric Clouds

The [**Volumetric Clouds** Volume component override](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/volumetric-clouds-volume-override-reference.html) controls settings relevant to rendering volumetric clouds.

To use this feature in your Scene, you must first enable it for your project and then enable it for your Cameras. To enable features in your project, you use the [HDRP Asset](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html) and to enable features for your Cameras, you use [Frame Settings](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Frame-Settings.html). You can enable features either for all Cameras, using the Default Frame Settings, or for specific Cameras, by overriding each Camera's individual Frame Settings.

- In your [HDRP Asset](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html) go to **Lighting \> Volumetrics \> Volumetric Clouds**.

- In your [Frame Settings](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Frame-Settings.html) go to **Lighting \> Volumetric Clouds**.

## Using Volumetric Clouds

**Volumetric Clouds** uses the [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) framework, so to enable and modify **Volumetric Clouds** properties, you must add a **Volumetric Clouds** override to a [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) in your Scene. To add a **Volumetric Clouds** override to a Volume:

1.  In the Scene or Hierarchy view, select a GameObject that contains a Volume component to view it in the Inspector.
2.  In the Inspector, navigate to **Add Override \> Sky** and click on **Volumetric Clouds**.

**Note**: When editing Volumetric Cloud properties in the Editor, set **Temporal Accumulation Factor** to a lower value. This allows you to see changes instantly, rather than blended over time.

![Volumetric Clouds example.](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/volumetric-clouds-2.png)

Refer to the [Volumetric Clouds Volume Override reference](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/volumetric-clouds-volume-override-reference.html) for more information.

**Note**: The volumetric clouds depend on the planet settings that are set in the [Visual Environment override](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/visual-environment-volume-override-reference.html). When **Rendering Space** is set to **World**, the camera can navigate inside the clouds and the clouds are positioned around the planet. When **Rendering Space** is set to **Camera**, the clouds are always located above the camera.

### API

To access and control this override at runtime, use the [Volume scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#changing-volume-profile-properties). Because of how the Volume system works, you edit properties in a different way to standard Unity components. There are also other nuances to be aware of too, such as each property has an [overrideState](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest/index.html?subfolder=/api/UnityEngine.Rendering.VolumeParameter.html%23UnityEngine_Rendering_VolumeParameter_overrideState). This indicates to the Volume system whether to use the property value you set, or use the default value stored in the [Volume Profile](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-volume-profile.html). For information on how to use the API correctly, see [Volume scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#changing-volume-profile-properties).

By default, animation data for clouds gets incremented automatically depending on the wind parameters. In some cases, it can be useful to manually set the animation time, which can be done by using the following script on a Camera:

```
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

public class CloudSync : MonoBehaviour

    }
}
```
