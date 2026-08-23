---
title: "Create layers"
page_title: "Unity - Manual: Create functional layers in Unity"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/create-layers.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/create-layers.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Create functional layers in Unity

Layers can help to organize the GameObjects in your scene. If you create a layer and assign GameObjects to it, you can edit how your GameObjects interact with other GameObjects, dependent on the layer.

## Add a new layer

There are two ways you can create a new layer:

-   Select the [Tags and Layers window](https://docs.unity3d.com/6000.3/Documentation/Manual/class-TagManager.html) (main menu: **Edit** > **Project Settings** > **Tags and Layers** > **Layers**).
-   Select a GameObject, select the **Layer** dropdown in the Inspector window, and select **Add Layer** from the menu.

To remember the intended function for a layer, give it a descriptive name.

**Warning**: Layer 31 is used internally by the Editor’s Preview window mechanics. To prevent clashes, do not use this layer.

### Built-in layers

When you open the layer menu, you can see that some layers are already named. Except for Default and Ignore Raycast, Unity no longer uses these built-in layers for many dedicated purposes; they exist mainly for backward compatibility:

| **Layer number** | **Layer name** | **Description**                                                                                                                                                 |
|:-----------------|:---------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **0**            | Default        | The default layer for all scene elements.                                                                                                                       |
| **1**            | TransparentFX  | Unity uses this layer in the [flare system](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Flare.html).                                             |
| **2**            | Ignore Raycast | Physics ray cast APIs ignore this layer by default.                                                                                                             |
| **4**            | Water          | Unity’s [Standard Assets for Unity 2018.4](https://assetstore.unity.com/packages/essentials/asset-packs/standard-assets-for-unity-2018-4-32351) use this layer. |
| **5**            | UI             | The [Unity UI](https://docs.unity3d.com/Packages/com.unity.ugui@latest/index.html) uses this as the default layer for UI elements.                              |

You can still use these layers, but you can’t rename or delete them.

## Add GameObjects to a layer

To assign a GameObject to a layer, select the GameObject, go to the Inspector window and select the dropdown next to **Layer**. This menu shows the layers that have names so you can select which one works best for your GameObject.

You can only assign each GameObject to one layer, but you can add multiple GameObjects to one layer.

## Additional resources

-   [Essential Unity concepts](https://learn.unity.com/pathway/unity-essentials)
-   [Tags and layers](https://docs.unity3d.com/6000.3/Documentation/Manual/class-TagManager.html)
-   [Layer-based collision detection](https://docs.unity3d.com/6000.3/Documentation/Manual/LayerBasedCollision.html)
