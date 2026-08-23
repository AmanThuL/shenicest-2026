---
title: "Unity 6.3 Manual: Bake lighting"
page_title: "Unity - Manual: Bake lighting"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/Lightmapping-bake.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/Lightmapping-bake.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Bake lighting

To generate lightmaps for your Scene:

1.  Open the [Lighting window](https://docs.unity3d.com/6000.3/Documentation/Manual/lighting-window.html) (menu: **Window** > **Rendering** > **Lighting**)

2.  At the bottom of the **Scene** tab on the Lighting window, select **Generate Lighting**.

3.  A progress bar appears in Unity Editor’s status bar, in the bottom-right corner.

When lightmapping is complete, Unity’s Scene and Game views update automatically and you can view the resulting lightmaps by going to the **Baked Lightmaps** tab in the Lighting Window.

When you generate lighting, Unity adds [Lighting Data Assets](https://docs.unity3d.com/6000.3/Documentation/Manual/LightmapSnapshot.html), [baked lightmaps](https://docs.unity3d.com/6000.3/Documentation/Manual/lighting-window.html) and [Reflection Probes](https://docs.unity3d.com/6000.3/Documentation/Manual/ReflectionProbes.html) to the [Assets](https://docs.unity3d.com/6000.3/Documentation/Manual/SpecialFolders.html) folder.

## Bake lightmaps automatically

To set Unity to bake lightmaps automatically when you open a scene that has no lighting data, follow these steps:

1.  Go to **Window** > **Rendering** > **Lighting**.

2.  Set **Bake on Scene Load** to **If Missing Lighting Data**.

If you share your project with someone else, you can use this option to reduce the size of your project by not including lighting data. When a scene is opened by someone else, Unity calculates the missing lighting data.
