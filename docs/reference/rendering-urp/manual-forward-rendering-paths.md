---
title: "Forward and Forward+ rendering paths in URP"
page_title: "Unity - Manual: Forward and Forward+ rendering paths in URP"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering/forward-rendering-paths.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering/forward-rendering-paths.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Forward and Forward+ rendering paths in URP

The Universal Render Pipeline (URP) has the following forward rendering paths:

-   Forward
-   Forward+

## Forward rendering path

The Forward rendering path is the default rendering path in URP. Unity lights each GameObject in turn, and there’s a limit to the number of lights that can affect each GameObject.

## Forward+ rendering path

The Forward+ rendering path is similar to the Forward rendering path, but there’s no limit to the number of lights that can affect each GameObject. There’s still a limit on the number of lights visible per-camera.

Using the Forward+ rendering path reduces the number of lights Unity calculates for each GameObject. Unity divides the screen into tiles, then identifies which lights affect which tiles. When Unity calculates the lighting for a GameObject, it uses only the lights that affect the tile the GameObject is in.

![An example of the Lighting Complexity [Debug Draw Mode](https://docs.unity3d.com/6000.3/Documentation/Manual/GIVis.html) using the Forward+ rendering path. Each grid square is a tile, and each value represents the number of lights affecting the tile.](https://docs.unity3d.com/6000.3/Documentation/uploads/urp/lighting-complexity.png)

Unity ignores the following settings if you select the Forward+ rendering path:

-   **Additional Lights** in the URP asset.
-   **Main Light** in the URP asset.
-   **Additional Lights** > **Per Object Limit** in the URP asset.

## Additional resources

-   [Light limits in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/lighting/light-limits-in-urp.html)
-   [Introduction to rendering paths in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering-paths-introduction-urp.html)
