---
title: "Adjust settings to improve performance in URP"
page_title: "Unity - Manual: Adjust settings to improve performance in URP"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/optimize-for-better-performance.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/optimize-for-better-performance.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Adjust settings to improve performance in URP

If the performance of your Universal Render Pipeline (URP) project seems slow, you can adjust settings to increase performance.

Based on your [analysis](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/analyze-your-project.html), you can adjust the following settings in the [Universal Render Pipeline (URP) Asset](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/universalrp-asset.html) or the [Universal Renderer asset](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/urp-universal-renderer.html) to improve the performance of your project.

Depending on your project or the platforms you target, some settings might not have a significant effect. There might also be other settings that have an effect on performance in your project.

| **Setting**                                          | **Where the setting is**                                                                                                    | **What to do for better performance**                                                                             |
|:-----------------------------------------------------|:----------------------------------------------------------------------------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------|
| **Accurate G-buffer normals**                        | [Universal Renderer](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/urp-universal-renderer.html) \> **Rendering** | Disable if you use the Deferred rendering path                                                                    |
| **Additional Lights** \> **Cast Shadows**            | [URP asset](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/universalrp-asset.html) \> **Lighting**                | Disable                                                                                                           |
| **Additional Lights** \> **Cookie Atlas Format**     | URP asset \> **Lighting**                                                                                                   | Set to **Color Low**                                                                                              |
| **Additional Lights** \> **Cookie Atlas Resolution** | URP asset \> **Lighting**                                                                                                   | Set to the lowest you can accept                                                                                  |
| **Additional Lights** \> **Per Object Limit**        | URP asset \> **Lighting**                                                                                                   | Set to the lowest you can accept. This setting has no effect if you use the Deferred or Forward+ rendering paths. |
| **Additional Lights** \> **Shadow Atlas Resolution** | URP asset \> **Lighting**                                                                                                   | Set to the lowest you can accept                                                                                  |
| **Additional Lights** \> **Shadow Resolution**       | URP asset \> **Lighting**                                                                                                   | Set to the lowest you can accept                                                                                  |
| **Cascade Count**                                    | URP asset \> **Shadows**                                                                                                    | Set to the lowest you can accept                                                                                  |
| **Conservative Enclosing Sphere**                    | URP asset \> **Shadows**                                                                                                    | Enable                                                                                                            |
| **Technique**                                        | [Decal Renderer Feature](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/renderer-feature-decal.html)              | Set to **Screen Space**, and set **Normal Blend** to **Low** or **Medium**                                        |
| **Fast sRGB/Linear conversion**                      | URP asset \> **Post Processing**                                                                                            | Enable                                                                                                            |
| **Grading Mode**                                     | URP asset \> **Post Processing**                                                                                            | Set to **Low Dynamic Range**                                                                                      |
| **LOD Cross Fade Dither**                            | URP asset \> **Quality**                                                                                                    | Set to **Bayer Matrix**                                                                                           |
| **LUT size**                                         | URP asset \> **Post Processing**                                                                                            | Set to the lowest you can accept                                                                                  |
| **Main Light** \> **Cast Shadows**                   | URP asset \> **Lighting**                                                                                                   | Disable                                                                                                           |
| **Max Distance**                                     | URP asset \> **Shadows**                                                                                                    | Reduce                                                                                                            |
| **Opaque Downsampling**                              | URP asset \> **Rendering**                                                                                                  | If **Opaque Texture** is enabled in the URP asset, set to **4x Bilinear**                                         |
| **Render Scale**                                     | URP asset \> **Quality**                                                                                                    | Set to below 1.0                                                                                                  |
| **Soft Shadows**                                     | URP asset \> **Shadows**                                                                                                    | Disable, or set to **Low**                                                                                        |
| **Upscaling Filter**                                 | URP asset \> **Quality**                                                                                                    | Set to **Bilinear** or **Nearest-Neighbor**                                                                       |

Refer to the following for more information on the settings:

-   [Deferred Rendering Path in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering/deferred-rendering-path-landing.html)
-   [Forward rendering paths in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering/forward-rendering-paths.html)
-   [Decal Renderer Feature](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/renderer-feature-decal.html)
-   [Universal Render Pipeline asset](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/universalrp-asset.html)
-   [Universal Renderer](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/urp-universal-renderer.html)

## Additional resources

-   [Understand performance in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/understand-performance.html)
-   [Configure for better performance](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/configure-for-better-performance.html)
-   [Graphics performance and profiling](https://docs.unity3d.com/Manual/graphics-performance-profiling.html)
-   [Best practices for profiling game performance](https://unity.com/how-to/best-practices-for-profiling-game-performance)
-   [Tools for profiling and debugging](https://unity.com/how-to/profiling-and-debugging-tools)
-   [Graphics rendering: Getting the best performance with Unity 6](https://www.youtube.com/watch?v=Oc6T4hh5gaI)
-   [Performance tips and tricks from a Unity consultant](https://www.youtube.com/watch?v=CmD8MVGkDxQ)
