---
title: "White Balance"
page_title: "White Balance | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-White-Balance.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-White-Balance.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# White Balance

The White Balance component applies a white balance effect that removes unrealistic color casts, so that items that would appear white in real life render as white in your final image. You can also use white balance to create an overall colder or warmer feel in the final render.

## Using White Balance

**White Balance** uses the [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) framework, so to enable and modify **White Balance** properties, you must add a **White Balance** override to a [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) in your Scene. To add **White Balance** to a Volume:

1.  In the Scene or Hierarchy view, select a GameObject that contains a Volume component to view it in the Inspector.
2.  In the Inspector, go to **Add Override** \> **Post-processing** and select **White Balance**. HDRP now applies **White Balance** to any Camera this Volume affects.

### API

To access and control this override at runtime, use the [Volume scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#changing-volume-profile-properties). Because of how the Volume system works, you edit properties in a different way to standard Unity components. There are also other nuances to be aware of too, such as each property has an [overrideState](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest/index.html?subfolder=/api/UnityEngine.Rendering.VolumeParameter.html%23UnityEngine_Rendering_VolumeParameter_overrideState). This indicates to the Volume system whether to use the property value you set, or use the default value stored in the [Volume Profile](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-volume-profile.html). For information on how to use the API correctly, see [Volume scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#changing-volume-profile-properties).

## Properties

| **Property** | **Description** |
|----|----|
| **Temperature** | Use the slider to set the white balance to a custom color temperature. Higher values result in a warmer color temperature and lower values result in a colder color temperature. See [Wikipedia: Color balance](https://en.wikipedia.org/wiki/Color_balance) for more information about color temperature. |
| **Tint** | Use the slider to compensate for a green or magenta tint. |
