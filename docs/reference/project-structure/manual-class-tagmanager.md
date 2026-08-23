---
title: "Unity 6.3 Manual: Tags and Layers"
page_title: "Unity - Manual: Tags and Layers"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-TagManager.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-TagManager.html"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Tags and Layers

The **Tags and Layers** settings (main menu: **Edit** \> **Project Settings**, then select the **Tags and Layers** category) allows you to set up [Tags](https://docs.unity3d.com/6000.3/Documentation/Manual/class-TagManager.html#Tags), [Sorting Layers](https://docs.unity3d.com/6000.3/Documentation/Manual/class-TagManager.html#SortingLayers) and [Layers](https://docs.unity3d.com/6000.3/Documentation/Manual/class-TagManager.html#Layers).

![The Tags and Layers Manager, before any custom tags or layers have been defined](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/TagManager55.png)

<span id="Tags"></span>

## Tags

**Tags** are marker values that you can use to identify objects in your Project (see documentation on [Tags](https://docs.unity3d.com/6000.3/Documentation/Manual/Tags.html) for further details). To add a new Tag, click the plus button (+) at the bottom-right of the list, and name your new Tag.

![Adding a new Tag](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/TagManagerAddNew.png)

Note that once you have named a Tag, you cannot rename it. To remove a Tag, click on it and then click the minus (-) button at the bottom-right of the list.

![The tags list showing four custom tags](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/TagManagerAddedNew.png)

<span id="SortingLayers"></span>

## Sorting Layers

Sorting Layers are used in conjunction with [Sprite](https://docs.unity3d.com/6000.3/Documentation/Manual/sprite/sprite-landing.html) graphics in the 2D system. *Sorting* refers to the overlay order of different Sprites.

![Adding a new Sorting Layer](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/SortingLayerManagerAddNew.png)

To add and remove Sorting Layers, use the plus and minus (+/-) buttons at the bottom-right of the list. To change their order, drag the handle at the left-hand side of each Layer item.

![The Sorting Layers list, showing four custom sorting layers](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/SortingLayerManagerAddedNew.png)

<span id="Layers"></span>

## Layers

Use Layers throughout the Unity Editor as a way to create groups of objects that share particular characteristics (see documentation on [Layers](https://docs.unity3d.com/6000.3/Documentation/Manual/Layers.html) for further details). Use Layers primarily to restrict operations such as raycasting or rendering, so that they are only applied to the relevant groups of objects. Layers marked as **Builtin Layer** are default layers used by Unity, which you cannot edit. You can customise layers marked as **User Layer**.

![Adding a new Layer](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/LayerManagerAddNew.png)

To customise **User Layers**, type a custom name into the text field for each one you wish to use. Note that you can’t add to the number of Layers but, unlike Tags, you can rename Layers.

<span id="RenderingLayers"></span>

## Rendering Layers

If your project uses the Universal Render Pipeline (URP) or the High Definition Render Pipeline (HDRP), this section lists the names of Rendering Layers. Use Rendering Layers to configure which lights or decals affect which GameObjects. Refer to the following for more information:

-   [Rendering Layers in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/features/rendering-layers.html)
-   [Rendering Layers in HDRP](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.0/manual/Rendering-Layers.html)

The Built-In Rendering Pipeline doesn’t support Rendering Layers.

<span class="search-words">TagManager</span>
