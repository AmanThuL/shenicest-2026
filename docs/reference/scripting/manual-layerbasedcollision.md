---
title: "Layer-based collision detection"
page_title: "Unity - Manual: Layer-based collision detection"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/LayerBasedCollision.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/LayerBasedCollision.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Layer-based collision detection

Layer-based collision detection is a way to make a GameObject collide with another GameObject that’s set up on a specific layer or layers.

![Layer Collision Matrix selected in the Project Settings window.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/layer-collision-matrix.png)

The Layer Collision Matrix defines which GameObjects can collide with which Layers. To open the Layer Collision Matrix go to **Edit \> Project Settings \> Physics**.

In the image, the Layer Collision Matrix is set up so that only GameObjects that belong to the same layer can collide:

-   Layer 1 is checked for Layer 1 only
-   Layer 2 is checked for Layer 2 only
-   Layer 3 is checked for Layer 3 only

If, for example, you want Layer 1 to collide with Layer 2 and 3, but not with Layer 1, find the row for **Layer 1**, then check the boxes for the **Layer 2** and **Layer 3** columns, and leave the **Layer 1** column checkbox blank.

## Set up layer-based collision detection

1.  Select the GameObject you want to assign a layer to.

2.  In the Inspector, select the **Layer** dropdown at the top, and either choose a Layer or add a new Layer. Repeat for each GameObject until you have finished assigning your GameObjects to Layers.

    ![Cube selected in the Inspector, with Layer 1 assigned to it.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/layer-collision-selection.png)

3.  In the Unity menu bar, go to **Edit** > **Project Settings**, then select the **Physics** category to open the [Physics](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PhysicsManager.html) window.

4.  Select the layers on the Collision Matrix that you want to interact with the other layers.

## Additional resources

-   [Essential Unity concepts](https://learn.unity.com/pathway/unity-essentials)
-   [Tags and layers](https://docs.unity3d.com/6000.3/Documentation/Manual/class-TagManager.html)
-   [Collision detection](https://docs.unity3d.com/6000.3/Documentation/Manual/collision-detection.html)
-   [Layers](https://docs.unity3d.com/6000.3/Documentation/Manual/Layers.html)
