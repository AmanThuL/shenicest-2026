---
title: "Reducing shader variants in URP"
page_title: "Unity - Manual: Reducing shader variants in URP"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/shader-stripping-landing.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/shader-stripping-landing.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Reducing shader variants in URP

The shaders in the Universal Render Pipeline (URP) use [shader keywords](https://docs.unity3d.com/6000.3/Documentation/Manual/shader-keywords.html) to support many different features, which might mean Unity compiles a lot of [shader variants](https://docs.unity3d.com/6000.3/Documentation/Manual/shader-variants.html).

The following resources are about speeding up builds by reducing the number of shader variants URP compiles.

For more information, refer to [Reduce shader variants](https://docs.unity3d.com/6000.3/Documentation/Manual/shader-variant-stripping.html), which applies to all render pipelines.

| **Page**                                                                                                                                                     | **Description**                                                                                          |
|:-------------------------------------------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------------|
| [Check how many shader variants your build has](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/shader-stripping-check.html)                        | Log how many shader variants Unity compiles and strips.                                                  |
| [Strip shader variants](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/shader-stripping-features.html)                                             | Remove shader variants for features you don’t use.                                                       |
| [Enable dynamic branching in shaders](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/shader-stripping-fog.html)                                    | Make Unity use dynamic branching in prebuilt or custom shaders, instead of keywords and shader variants. |
| [Settings and keywords reference for shader stripping](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/shader-stripping-features-and-keywords.html) | Explore the settings and shader keywords you can use to strip shader variants.                           |

## Additional resources

-   [Graphics performance and profiling in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/graphics-performance-and-profiling-in-urp.html)
-   [Troubleshooting shaders](https://docs.unity3d.com/6000.3/Documentation/Manual/shader-troubleshooting.html)
