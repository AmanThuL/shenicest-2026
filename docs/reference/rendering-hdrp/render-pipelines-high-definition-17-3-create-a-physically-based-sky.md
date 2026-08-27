---
title: "Create a physically based sky"
page_title: "Create a physically based sky | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-physically-based-sky.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-physically-based-sky.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Create a physically based sky

The Physically Based Sky Volume Override lets you configure how the High Definition Render Pipeline (HDRP) renders physically based sky.

![A forest in daytime, with a clear sky and a hazy sun.](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/Override-PhysicallyBasedSky2.png)

![The same forest at night, with the trees in silhouette and the sky a gradient of dark yellow and orange.](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/Override-PhysicallyBasedSky3.png)

## Using Physically Based Sky

Physically Based Sky uses the [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) framework. To enable and modify **Physically Based Sky** properties, add a **Physically Based Sky** override to a [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) in your Scene. To add **Physically Based Sky** to a Volume:

1.  In the Scene or Hierarchy view, select a GameObject that contains a Volume component to view it in the Inspector.
2.  In the Inspector, go to **Add Override \> Sky** and select **Physically Based Sky**.
3.  If the Scene doesn't contain a Directional [Light](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Light-Component.html), create one (menu: **GameObject \> Light \> Directional Light**). For physically correct results, set the Light's intensity to 130,000 lux.

Next, set the Volume to use **Physically Based Sky**. The [Visual Environment](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Override-Visual-Environment.html) override controls which type of sky the Volume uses. In the **Visual Environment** override, navigate to the **Sky** section and set the **Type** to **Physically Based Sky**. HDRP now renders a **Physically Based Sky** for any Camera this Volume affects.

To change how much the atmosphere attenuates light, you can change the density of both air and aerosol molecules (participating media) in the atmosphere. You can also use aerosols to simulate real-world pollution or fog.

**Note**: HDRP only takes into account Lights that have **Affect Physically Based Sky** enabled. After Unity bakes the lighting in your project, Physically Based Sky ignores all Lights that have their **Mode** property set to **Baked**. To fix this, set the **Mode** to **Realtime** or **Mixed**.

Refer to the [Physically Based Sky Volume Override Reference](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/physically-based-sky-volume-override-reference.html) for more information.

### API

To access and control this override at runtime, use the [Volume scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#changing-volume-profile-properties). Because of how the Volume system works, you edit properties in a different way to standard Unity components. There are also other nuances to be aware of too, such as each property has an [overrideState](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest/index.html?subfolder=/api/UnityEngine.Rendering.VolumeParameter.html%23UnityEngine_Rendering_VolumeParameter_overrideState). This indicates to the Volume system whether to use the property value you set, or use the default value stored in the [Volume Profile](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-volume-profile.html). For information on how to use the API correctly, see [Volume scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#changing-volume-profile-properties).

## Set the surface of the planet

Where the surface of the planet is depends on the planet settings that are in the [Visual Environment](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Override-Visual-Environment.html).

- If you set the **Rendering Space** to **World**, and the **Center** to **Automatic**, the surface of the planet will be at the worlds origin and the center is derived from the **Radius** property.
- If you set the **Rendering Space** to **Camera**, the planet will move with the camera and the surface of the planet will always be under the camera.

The planet does not render in the depth buffer, this means it won't occlude lens flare and will not behave correctly when using motion blur.

Refer to the [Physically Based Sky Volume Override Reference](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/physically-based-sky-volume-override-reference.html) for more information.

## Viewing the Physically Based Sky from space

As discussed above, when the **Rendering Space** is in **World** mode, the camera can go in the sky and see the planet from outer space. For performance reasons, by default the sun light attenuation from the atmosphere is computed as if the objects are situated on the ground. Also the LUT used to compute atmospheric attenuation on objects has a maximum range of 128km. These approximations have very limited impact on visuals as long as the camera is not too high in the atmosphere, but can be noticeable when the camera is in outer space. HDRP supports using more correct computations to cover these scenarios using more complex shaders, which has a slight performance cost. In order to do that, you have to set the PrecomputedAtmosphericAttenuation value to `0` in the **ShaderOptions** enum of the HDRP config package. For information on how to set up and use the HDRP Config package, see [HDRP Config](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/configure-a-project-using-the-hdrp-config-package.html).
