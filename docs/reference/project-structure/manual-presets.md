---
title: "Reusing settings with preset assets"
page_title: "Unity - Manual: Reusing settings with preset assets"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/Presets.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/Presets.html"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Reusing settings with preset assets

Presets are assets that you can use to save and apply identical property settings across multiple components, assets, or [Project Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/comp-ManagerGroup.html) windows. You can also use presets to specify default settings for new components and default [import settings](https://docs.unity3d.com/6000.3/Documentation/Manual/ImportingAssets.html) for assets in the [Preset Manager](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PresetManager.html). The Preset Manager supports any importers, components, or scriptable objects you add to the Unity Editor.

You can only apply Presets in the Editor. Presets have no effect at runtime. You can use scripting to [support presets](https://docs.unity3d.com/6000.3/Documentation/Manual/SupportingPresets.html) in your own MonoBehaviour, ScriptableObject or ScriptedImporter classes.

| **Topic**                                                                                                                         | **Description**                                                                                                                                                                              |
|:----------------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **[Create presets to save and reuse settings](https://docs.unity3d.com/6000.3/Documentation/Manual/presets-creating-using.html)** | Save the property configuration of a component, asset, or Project Settings window as a preset asset and apply the same settings to a different component, asset, or Project Settings window. |
| **[Supporting presets for custom types](https://docs.unity3d.com/6000.3/Documentation/Manual/SupportingPresets.html)**            | Add preset support for your own custom C# types.                                                                                                                                             |
| **[Apply default presets to assets by folder](https://docs.unity3d.com/6000.3/Documentation/Manual/DefaultPresetsByFolder.html)** | Apply default presets based on the location of an asset.                                                                                                                                     |

## Additional resources

-   [Preset Manager](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PresetManager.html)
-   [Project Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/comp-ManagerGroup.html)
