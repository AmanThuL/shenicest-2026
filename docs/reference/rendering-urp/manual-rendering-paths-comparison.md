---
title: "Choose a rendering path in URP"
page_title: "Unity - Manual: Choose a rendering path in URP"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering-paths-comparison.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering-paths-comparison.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Choose a rendering path in URP

<span id="rendering-path-comparison"></span> Deciding on which [rendering path](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering-paths-introduction-urp.html) is most suitable for your Universal Render Pipeline (URP) project depends on the type of project, and on the target hardware.

Use the default Forward rendering path if you don’t have many lights in the scene or you’re rendering on a mobile or low-end platform, because Unity limits both the number of lights and the number of per-pixel lights.

Choose the Forward+ rendering path in the following cases:

-   You have many lights in your scene, and the Deferred rendering path renders too slowly on the platform you build for.
-   You need to blend more than 2 Reflection Probes.
-   You use the [Entities package](https://docs.unity3d.com/Packages/com.unity.entities@1.3/manual/index.html).

Choose the Deferred rendering path in the following cases:

-   You don’t need to use [Rendering Layers](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/features/rendering-layers.html). URP renders an extra G-buffer render target if you use Rendering Layers in the Deferred rendering path, which might impact performance.
-   You don’t need accurate terrain blending. For more information, refer to [Introduction to the deferred rendering path](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering/deferred-rendering-path-introduction.html).

Choose the Deferred+ rendering path in the following cases:

-   You have many lights in your scene.
-   You don’t need to use [Rendering Layers](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/features/rendering-layers.html). URP renders an extra G-buffer render target if you use Rendering Layers in the Deferred rendering path, which might impact performance.
-   You don’t need accurate terrain blending. For more information, refer to [Introduction to the deferred rendering path](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering/deferred-rendering-path-introduction.html).

Avoid using lights with a Subtractive or Shadowmask [Lighting Mode](https://docs.unity3d.com/6000.3/Documentation/Manual/lighting-mode-landing.html) with the Deferred rendering path, because these lights are optimized only for the Forward rendering path.

Unity falls back to a different rendering path in the following situations:

-   If you select the Deferred rendering path but a shader doesn’t support deferred shading. Unity renders the GameObject using a Forward rendering path at the end of rendering.
-   If the GPU on the device you build for doesn’t support the rendering path you select. Unity falls back to a different rendering path.

## Rendering path comparison

The following table lists the differences between the rendering paths in URP.

| **Feature**                                                                                                              | **Forward**                          | **Forward+**                                                                                                                                                            | **Deferred**                                                                                                                                                                                                                                                                                  |
|:-------------------------------------------------------------------------------------------------------------------------|:-------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Mobile performance                                                                                                       | Low performance impact.              | Low performance impact.                                                                                                                                                 | High performance impact, because Unity adds extra render passes to render the G-buffer.                                                                                                                                                                                                       |
| Render passes per object                                                                                                 | 1                                    | 1                                                                                                                                                                       | 1                                                                                                                                                                                                                                                                                             |
| [Realtime lights per object](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/lighting/light-limits-in-urp.html) | 9                                    | Unlimited                                                                                                                                                               | Unlimited for opaque objects. 9 for transparent objects.                                                                                                                                                                                                                                      |
| [Realtime lights per camera](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/lighting/light-limits-in-urp.html) | Up to 257 depending on the platform. | Up to 256 depending on the platform. The Forward+ Rendering Path treats the Main Light and Additional Lights the same way, so the per-camera limits are one light less. | Up to 257 depending on the platform.                                                                                                                                                                                                                                                          |
| Per-vertex lights                                                                                                        | Yes                                  | No                                                                                                                                                                      | No                                                                                                                                                                                                                                                                                            |
| Disable the Main Light                                                                                                   | Yes                                  | No                                                                                                                                                                      | No                                                                                                                                                                                                                                                                                            |
| Per-pixel normals                                                                                                        | Accurate, with no encoding.          | Accurate, with no encoding.                                                                                                                                             | Less accurate encoded normals, or you can select more accurate but slower normals. For more information, refer to [G-buffer layout in the Deferred rendering path](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering/g-buffer-layout.html).                                  |
| [Multisample anti-aliasing (MSAA)](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/anti-aliasing.html)          | Yes                                  | Yes                                                                                                                                                                     | No                                                                                                                                                                                                                                                                                            |
| [Camera stacking](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/camera-stacking.html)                         | Yes                                  | Yes                                                                                                                                                                     | Yes, but the Base Camera uses the Deferred rendering path, and Overlay Cameras use the Forward rendering path. For more information, refer to [Introduction to camera render types](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/camera-types-and-render-type-introduction.html). |

## Additional resources

-   [Light limits in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/lighting/light-limits-in-urp.html)
-   [Per-pixel and per-vertex lights](https://docs.unity3d.com/6000.3/Documentation/Manual/PerPixelLights.html)
-   [Rendering paths in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering-paths-introduction-urp.html)
