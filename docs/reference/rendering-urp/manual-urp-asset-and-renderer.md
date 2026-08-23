---
title: "Universal Render Pipeline asset"
page_title: "Unity - Manual: Universal Render Pipeline asset"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/urp-asset-and-renderer.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/urp-asset-and-renderer.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Universal Render Pipeline asset

Any Unity project that uses the Universal Render Pipeline (URP) must have a URP asset to configure the settings. When you create a project using the URP template, Unity creates the URP assets in the **Settings** project folder and assigns them in Project Settings. If you are migrating an existing project to URP, you need to [create a URP asset and assign the asset in the Graphics settings](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/InstallURPIntoAProject.html).

The URP asset controls several graphical features and quality settings for the Universal Render Pipeline. It is a scriptable object that inherits from ‘RenderPipelineAsset’. When you assign the asset in the Graphics settings, Unity switches from the built-in render pipeline to the URP. You can then adjust the corresponding settings directly in the URP, instead of looking for them elsewhere.

You can have multiple URP assets and switch between them. For example, you can have one with Shadows on and one with Shadows off. If you switch between the assets to understand the effects, you don’t have to manually toggle the corresponding settings for shadows every time. You cannot, however, switch between HDRP/SRP and URP assets, as the render pipelines are incompatible.

## Additional resources

-   [URP asset reference](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/universalrp-asset.html)
