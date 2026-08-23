---
title: "Introduction to rendering paths in URP"
page_title: "Unity - Manual: Introduction to rendering paths in URP"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering-paths-introduction-urp.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering-paths-introduction-urp.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to rendering paths in URP

You can select one of the following rendering paths in the Universal Render Pipeline (URP):

-   Forward
-   Forward+
-   Deferred
-   Deferred+

Each rendering path affects how Unity draws and lights objects, which affects lighting results and rendering time. The effects depend on the platform you build for.

For more information about choosing a rendering path, refer to [Choose a rendering path in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering-paths-comparison.html).

## Rendering path requirements in URP

| **Feature**                  | **Forward and Forward+** | **Deferred and Deferred+** |
|:-----------------------------|:-------------------------|:---------------------------|
| Minimum shader model         | 2.0                      | 4.5                        |
| OpenGL and OpenGL ES support | Yes                      | No                         |

## Additional resources

-   [Understanding Rendering Paths](https://learn.unity.com/tutorial/understanding-rendering-paths-2019-3) on the Unity Learn site
-   [Unity LTS 2022 Release Live!](https://www.youtube.com/watch?v=oUQapNQgpRI&t=8183s) - a Unity YouTube video that demonstrates the Forward+ rendering path
