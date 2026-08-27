---
title: "Control exposure"
page_title: "Control exposure | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Override-Exposure.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Override-Exposure.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Control exposure

To work with physically based lighting and Materials, you need to set up the Scene exposure correctly. The High Definition Render Pipeline (HDRP) includes several methods for calculating exposure to suit most situations. HDRP expresses all exposure values that it uses in [EV<sub>100</sub>](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Physical-Light-Units.html#EV).

## Use the exposure volume override

**Exposure** uses the [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) framework, so to enable and modify **Exposure** properties, you must add an **Exposure** override to a [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) in your Scene. To add **Exposure** to a Volume:

1.  In the Scene or Hierarchy view, select a GameObject that contains a Volume component to view it in the Inspector.
2.  In the Inspector, go to **Add Override** and select **Exposure**.

HDRP applies **Exposure** correction to any Camera this Volume affects.

### API

To access and control this override at runtime, use the [Volume scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#changing-volume-profile-properties). Because of how the Volume system works, you edit properties in a different way to standard Unity components. There are also other nuances to be aware of too, such as each property has an [overrideState](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest/index.html?subfolder=/api/UnityEngine.Rendering.VolumeParameter.html%23UnityEngine_Rendering_VolumeParameter_overrideState). This indicates to the Volume system whether to use the property value you set, or use the default value stored in the [Volume Profile](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-volume-profile.html). For information on how to use the API correctly, see [Volume scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#changing-volume-profile-properties).

To learn how to use exposure properties, refer to [exposure volume override reference](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/reference-override-exposure.html).

<span id="DebugModes"></span>

### Exposure Debug modes

HDRP offers several debug modes to help you to set the correct exposure for your scene. You can activate these in the [Debug window](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/rendering-debugger-window-reference.html). For more information, refer to [Debug exposure](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/test-debug-exposure.html).
