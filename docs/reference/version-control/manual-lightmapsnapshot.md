---
title: "Unity 6.3 Manual: Lighting Data Assets"
page_title: "Unity - Manual: Lighting Data Assets"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/LightmapSnapshot.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/LightmapSnapshot.html"
topic: "version-control"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Lighting Data Assets

A Lighting Data <span class="notooltip">Asset stores</span> precomputed lighting data for a Scene in the Unity Editor. Lighting Data Assets exist as separate files in your Project for workflow reasons; storing precomputed lighting data in a separate file means that changes to the precomputed lighting data do not result in changes to the Scene file. Lighting Data Assets are not intended for users to edit.

Unity stores precomputed lighting data in a Lighting Data Asset when you invoke a lighting precompute, either by using the **Generate Lighting** button in the [Lighting window](https://docs.unity3d.com/6000.3/Documentation/Manual/lighting-window.html), or by using the [Lightmapping.Bake](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Lightmapping.Bake.html) or [Lightmapping.BakeAsync](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Lightmapping.BakeAsync.html) APIs.

The Lighting Data Asset contains global illumination data and all the supporting files needed to recreate the lighting for a scene. This asset references the renderers, the real-time lightmaps, the baked lightmaps, light probes, reflection probes and a data structure which stores the relationships between these elements. It also includes all the precomputed Enlighten Realtime Global Illumination data needed to update how real-time global illumination looks in the Player.

When you change the scene, for instance by breaking a prefab connection on a GameObject that is marked as **Contribute GI**, the asset data will get out of date and has to be rebuilt.

The intermediate files that are generated during the lighting build process, but is not needed for generating a Player build is not part of the asset, they are stored in the [GI Cache](https://docs.unity3d.com/6000.3/Documentation/Manual/GICache.html) instead.

The build time for the Lighting Data Asset can vary. If your [GI Cache](https://docs.unity3d.com/6000.3/Documentation/Manual/GICache.html) is fully populated i.e. you have done a bake on the machine before (with the scene in its current state) it will be fast. If you are pulling the scene to a machine with a blank cache or the cache data needed has been removed due to the cache size limit, the cache will have to be populated with the intermediate files first which requires the precompute and bake processes to run. These steps can take some time.

<span id="default-lighting-data-assets"></span>

## Default Lighting Data Assets

When you add a new scene, Unity uses a default Lighting Data Asset. The asset references a hidden ambient probe and a hidden Reflection Probe that capture environment lighting from Unity’s built-in Default Skybox. The asset doesn’t appear in the Project window.

The data in the hidden probes is fixed. For example, if you change the **Skybox Material** in the Lighting window, the data in the probes doesn’t change, so environment lighting on objects stays the same.

To stop using the default Lighting Data Asset, select **Generate Lighting** or **Clear Baked Data** in the Lighting window. Unity then creates and uses a new default Lighting Data Asset and a new baked Reflection Probe (the ambient Reflection Probe). These assets appear in the Project window, and update when you select **Generate Lighting**.
