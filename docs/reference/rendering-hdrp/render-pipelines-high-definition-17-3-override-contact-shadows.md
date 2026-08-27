---
title: "Use contact shadows"
page_title: "Use contact shadows | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Override-Contact-Shadows.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Override-Contact-Shadows.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Use contact shadows

Contact Shadows are shadows that HDRP [ray marches](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Glossary.html#RayMarching) in screen space, inside the depth buffer, at a close range. Use Contact Shadows to provide shadows for geometry details that regular shadow mapping algorithms usually fail to capture.

24 Lights (Direction, Point or Spot) can cast Contact Shadows at a time.

For information about contact shadow properties, refer to [Contact shadows override reference](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/reference-contact-shadows-override.html).

<span id="enable-contact-shadows"></span>

## Enable contact shadows

To use this feature in your Scene, you must first enable it for your project and then enable it for your Cameras. To enable features in your project, you use the [HDRP Asset](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html) and to enable features for your Cameras, you use [Frame Settings](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Frame-Settings.html). You can enable features either for all Cameras, using the Default Frame Settings, or for specific Cameras, by overriding each Camera's individual Frame Settings.

Enable the following properties:

- In the HDRP Asset: **Lighting \> Shadows \> Use Contact Shadows**.
- In the Frame Settings window: **Lighting \> Contact Shadows**.

<span id="use-contact-shadows"></span>

## Use contact shadows

**Contact Shadows** use the [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) framework, so to enable and modify **Contact Shadow** properties, you must add a **Contact Shadows** override to a [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) in your Scene. To add **Contact Shadows** to a Volume:

1.  In the Scene or Hierarchy view, select a GameObject that contains a Volume component to view it in the Inspector.
2.  In the Inspector, navigate to **Add Override \> Shadowing** and click on **Contact Shadows**. HDRP now applies **Contact Shadows** to any Camera this Volume affects.

You can enable Contact Shadows on a per Light basis for Directional, Point, and Spot Lights. Tick the **Enable** checkbox under the **Contact Shadows** drop-down in the **Shadows** section of each Light to indicate that HDRP should calculate Contact Shadows for that Light.

If you use both contact shadows and [realtime shadows](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/realtime-shadows.html), there might be a visible seam between the two types of shadow. To avoid this issue, set shadow maps to use a high resolution. For more information, refer to [Control shadow resolution and quality](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Shadows-in-HDRP.html).

**Note**: A Light casts Contact Shadows for every Mesh Renderer that uses a Material that writes to the depth buffer. This is regardless of whether you enable or disable the **Cast Shadows** property on the Mesh Renderer. This means that you can disable **Cast Shadows** on small GameObjects/props and still have them cast Contact Shadows. This is good if you do not want HDRP to render these GameObjects in shadow maps. If you do not want this behavior, use Shader Graph to author a Material that does not write to the depth buffer.

### API

To access and control this override at runtime, use the [Volume scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#changing-volume-profile-properties). Because of how the Volume system works, you edit properties in a different way to standard Unity components. There are also other nuances to be aware of too, such as each property has an [overrideState](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest/index.html?subfolder=/api/UnityEngine.Rendering.VolumeParameter.html%23UnityEngine_Rendering_VolumeParameter_overrideState). This indicates to the Volume system whether to use the property value you set, or use the default value stored in the [Volume Profile](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-volume-profile.html). For information on how to use the API correctly, see [Volume scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#changing-volume-profile-properties).

## Details

- For Mesh Renderer components, setting **Cast Shadows** to **Off** does not apply to Contact Shadows.

- Contact shadow have a variable cost between 0.5 and 1.3 ms on the base PS4 at 1080p.
