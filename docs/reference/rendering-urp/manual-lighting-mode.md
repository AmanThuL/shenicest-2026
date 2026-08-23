---
title: "Lighting Mode"
page_title: "Unity - Manual: Lighting Mode"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/lighting-mode.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/lighting-mode.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Lighting Mode

To control the behaviour of all the lights in a scene that have a Light Mode of Mixed, set the Lighting Mode in the [Lighting Settings Asset](https://docs.unity3d.com/6000.3/Documentation/Manual/class-LightingSettings.html).

There are four options for Lighting Mode, in order of visual fidelity:

-   Distance Shadowmask mode renders realistic lighting at a long distance, but has the most performance impact. You can use this mode for open worlds on high-end or mid-range platforms.
-   Shadowmask mode is similar to Distance Shadowmask but has fewer real-time shadows and less performance impact.
-   Baked Indirect mode renders realistic lighting and [realtime shadows](https://docs.unity3d.com/6000.3/Documentation/Manual/shadow-realtime.html).
-   Subtractive mode renders simple lighting and low-fidelity shadows, but has a low performance impact. You can use this mode for low-end hardware, simple scenes with few lights, or stylized art such as cel shading.

For information about which render pipeline supports which Lighting Mode, refer to [Render pipeline feature comparison reference](https://docs.unity3d.com/6000.3/Documentation/Manual/render-pipelines-feature-comparison.html#lighting).

## How Unity calculates lighting

The following table shows how Unity calculates lighting from Mixed lights for each Lighting Mode.

| **Lighting from Mixed lights**                                                                                                           | **Baked Indirect Lighting Mode** | **Shadowmask Lighting Mode**                     | **Distance Shadowmask Lighting Mode**            | **Subtractive Lighting Mode**                                       |
|:-----------------------------------------------------------------------------------------------------------------------------------------|:---------------------------------|:-------------------------------------------------|:-------------------------------------------------|:--------------------------------------------------------------------|
| Direct lighting                                                                                                                          | Real-time                        | Real-time                                        | Real-time                                        | Real-time for dynamic GameObjects, baked for static GameObjects.    |
| Indirect lighting                                                                                                                        | Baked                            | Baked                                            | Baked                                            | Baked                                                               |
| Specular highlights                                                                                                                      | Yes                              | Yes                                              | Yes                                              | Dynamic GameObjects only                                            |
| Shadows from dynamic GameObjects, up to [**Shadow Distance**](https://docs.unity3d.com/6000.3/Documentation/Manual/shadow-distance.html) | Real-time                        | Real-time                                        | Real-time                                        | Real-time, from the single highest-intensity Directional Light only |
| Shadows from static GameObjects, up to [**Shadow Distance**](https://docs.unity3d.com/6000.3/Documentation/Manual/shadow-distance.html)  | Real-time                        | Baked, from a maximum of 4 lights per GameObject | Real-time                                        | Baked, from a maximum of 4 lights per GameObject                    |
| Shadows from static GameObjects, beyond [**Shadow Distance**](https://docs.unity3d.com/6000.3/Documentation/Manual/shadow-distance.html) | No shadows                       | Baked, from a maximum of 4 lights per GameObject | Baked, from a maximum of 4 lights per GameObject | No shadows                                                          |

## Where Unity stores lighting data

Unity stores baked indirect lighting in the following places:

-   Light Probes store indirect lighting of dynamic GameObjects.
-   Lightmap textures store indirect lighting of static GameObjects. In Subtractive mode, lightmap textures also store direct lighting.

Unity stores shadows in the following places:

-   [Shadowmap textures](https://docs.unity3d.com/6000.3/Documentation/Manual/shadow-mapping.html) store real-time shadows, if the Lighting Mode supports them.
-   Light Probes and shadow mask textures store baked shadows from static GameObjects, if the Lighting Mode supports them. In Subtractive mode, lightmaps store them instead.

![An example of a lightmap texture with shadows. The square area with yellow lines is the baked surface lighting of a plane. The white circle is a bright spot light, and the two black areas are shadows from other objects.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/lightmap-with-shadows-example.jpg)

In Subtractive mode, real-time and baked shadows might not blend correctly, because lightmaps don’t contain enough data to calculate blending accurately. To improve blending, adjust the **Realtime Shadow Color** setting in the [Lighting window](https://docs.unity3d.com/6000.3/Documentation/Manual/lighting-window.html).

<span id="shadowmask"></span>

### Shadow mask textures

If you select Shadowmask mode or Distance Shadowmask mode, Unity creates shadow mask textures to store baked shadows for static GameObjects. Each shadow mask texture stores occlusion information about baked lights, and has the following characteristics:

-   Uses the same UV layout and resolution as its corresponding lightmap texture.
-   Stores up to four lights per texel, with each light stored in an RGBA channel.

![An example of a baked shadow mask texture. The square area with yellow lines represents a plane. The two grey areas are shadows.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/baked-shadow-mask-example.jpg)

If more than four lights overlap each other at any point in space, Unity bakes the remaining lights. If you bake again, the same lights stay baked unless you change the overlapping lights. To check which lights overlap, use the **Light Overlap** [Debug Draw Mode for lighting](https://docs.unity3d.com/6000.3/Documentation/Manual/GIVis.html).

## Additional resources

-   [Direct and indirect lighting](https://docs.unity3d.com/6000.3/Documentation/Manual/direct-and-indirect-lighting.html)
-   [Setting a light as realtime or baked](https://docs.unity3d.com/6000.3/Documentation/Manual/LightModes-landing.html)
-   [Enable shadows](https://docs.unity3d.com/6000.3/Documentation/Manual/shadow-configuration.html)
