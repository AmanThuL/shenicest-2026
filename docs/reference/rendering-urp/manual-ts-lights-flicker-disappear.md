---
title: "Troubleshooting lights flickering or disappearing"
page_title: "Unity - Manual: Troubleshooting lights flickering or disappearing"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/ts-lights-flicker-disappear.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/ts-lights-flicker-disappear.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Troubleshooting lights flickering or disappearing

Fix issues causing lights to flicker or disappear, and causing objects to not cast shadows.

![Two images of the same scene of a room containing a 3 by 3 grid of spheres. The first image displays how there are no shadows or specular highlights when the pixel light count set to zero. The second image shows the same scene with the pixel light count set to nine, with the spheres casting shadows.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/ex-light-flicker.png)

## Symptoms

Real-time lights and specular highlights are missing or flicker in the scene, and also cause objects to not cast shadows.

## Cause

When you use the [Forward rendering path](https://docs.unity3d.com/6000.3/Documentation/Manual/RenderTech-ForwardRendering.html), Unity converts pixel lights to more performant vertex lights when the number of pixel lights exceeds a certain value. This can result in flickering or disappearing lights in the scene.

**Note:** This limitation affects only the Built-in Render Pipeline and the Universal Render Pipeline (URP). When you use the High Definition Render Pipeline (HDRP), Unity doesn’t convert pixel lights to vertex lights.

## Resolution - Adjust the Render Mode property

![Light component in URP.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/ex-ts-render-mode-property.png)

To control the probability of Unity converting a light into a vertex light, you can adjust their **Render Mode** priority in the **Light** component property settings.

For lights of high importance, set its **Render Mode** to **Important** to reduce the probability of Unity converting the selected lights to vertex lights. When **Render Mode** is set to **Auto**, Unity will check the light’s intensity and its relative distance from the camera before converting it.

Lights which have **Render Mode** set to **Not Important** will always be converted to vertex lights.

## Resolution - Switch to a different rendering path

If you need many [mixed](https://docs.unity3d.com/6000.3/Documentation/Manual/LightModes-introduction.html#mixed) or [real-time](https://docs.unity3d.com/6000.3/Documentation/Manual/LightModes-introduction.html#realtime) lights in the scene, switch to a different rendering path that supports more lights.

If you’re using the Built-in Render Pipeline, follow these steps:

1.  Go to **Project Settings** > **Graphics**.
2.  Under [Tier Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-GraphicsSettings.html#Tier), disable the **Use Defaults** checkbox for your selected [graphics tier](https://docs.unity3d.com/6000.3/Documentation/Manual/graphics-tiers.html).
3.  Set the **Rendering Path** to [Deferred](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering/deferred-rendering-path-landing.html).

If you’re using the Universal Rendering pipeline (URP):

1.  Select the [Render Pipeline Asset](https://docs.unity3d.com/Packages/com.unity.render-pipelines.universal@latest?subfolder=/manual/universalrp-asset.html).
2.  Under **Rendering**, set the **Rendering Path** to [Forward+](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering/forward-rendering-paths.html) or [Deferred](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering/deferred-rendering-path-landing.html) depending on the rendering path that [best fits](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering-paths-comparison.html) your project needs.

## Resolution - Switch to baked lights

To mitigate pixel light limitations, use baked lights. Go to the [Light](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Light.html) component and set its **Mode** to **Baked**.
