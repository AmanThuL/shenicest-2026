---
title: "Channel Mixer"
page_title: "Channel Mixer | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Channel-Mixer.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Channel-Mixer.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Channel Mixer

The Channel Mixer effect modifies the influence of each input color channel on the overall mix of the output channel. For example, if you increase the influence of the green channel on the overall mix of the red channel, all areas of the final image that are green (including neutral/monochrome) tint to a more reddish hue.

## Using Channel Mixer

**Channel Mixer** uses the [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) framework, so to enable and modify **Channel Mixer** properties, you must add a **Channel Mixer** override to a [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) in your Scene. To add **Channel Mixer** to a Volume:

1.  In the Scene or Hierarchy view, select a GameObject that contains a Volume component to view it in the Inspector.
2.  In the Inspector, go to **Add Override** \> **Post-processing** and select **Channel Mixer**. HDRP now applies **Channel Mixer** to any Camera this Volume affects.

### API

To access and control this override at runtime, use the [Volume scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#changing-volume-profile-properties). Because of how the Volume system works, you edit properties in a different way to standard Unity components. There are also other nuances to be aware of too, such as each property has an [overrideState](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest/index.html?subfolder=/api/UnityEngine.Rendering.VolumeParameter.html%23UnityEngine_Rendering_VolumeParameter_overrideState). This indicates to the Volume system whether to use the property value you set, or use the default value stored in the [Volume Profile](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-volume-profile.html). For information on how to use the API correctly, see [Volume scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#changing-volume-profile-properties).

## Properties

The Channel Mixer component has the following properties.

### Output channels

Before you modify the influence of each input channel, you must select the output color channel to influence. To do this, click the button for the channel that you want to set the influence for.

| **Property** | **Description** |
|----|----|
| **Red Output Channel** | Use the slider to set the influence of each channel on the red output channel. |
| **Green Output Channel** | Use the slider to set the influence of each channel on the green output channel. |
| **Blue Output Channel** | Use the slider to set the influence of each channel on the blue output channel. |
