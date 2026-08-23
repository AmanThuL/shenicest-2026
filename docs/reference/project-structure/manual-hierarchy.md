---
title: "Manage GameObjects in the Hierarchy window"
page_title: "Unity - Manual: Manage GameObjects in the Hierarchy window"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/Hierarchy.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/Hierarchy.html"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Manage GameObjects in the Hierarchy window

Use the Hierarchy window to create and organize GameObjects and control their visibility in a scene.

The Hierarchy window displays every [GameObject](https://docs.unity3d.com/6000.3/Documentation/Manual/GameObjects.html) in a scene, including models, cameras, and [prefabs](https://docs.unity3d.com/6000.3/Documentation/Manual/Prefabs.html). You can use the Hierarchy window to manage and group the GameObjects you use in a scene. When you add or remove GameObjects in the Scene view, you also add or remove them from the Hierarchy window.

![The default Hierarchy window view when you open a new Unity project](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/hierarchy-window.png)

The Hierarchy window can also display other scenes, with each scene containing their own GameObjects. You can have more than one scene open in the Hierarchy window at the same time. For more information, refer to [Work with multiple scenes in Unity](https://docs.unity3d.com/6000.3/Documentation/Manual/MultiSceneEditing.html).

## Create a new GameObject

To create a new GameObject in the Hierarchy window:

1.  Right-click on empty space in the Hierarchy window under your selected scene.
2.  Select the GameObject you want to create from the context menu.

You can also use the keyboard shortcut **Ctrl**+**Shift**+**N** (macOS: **Command**+**Shift**+**N**) to create a new empty GameObject.

**Note**: By default, Unity creates new GameObjects in rename mode. To disable this behavior, select the **More** (⋮) menu in the Hierarchy window and deselect **Rename New Objects**.

## Duplicate a GameObject

To duplicate a GameObject, right-click the target GameObject and select **Duplicate**.

You can also use the keyboard shortcut **Ctrl\~**+**D** (macOS: **Command**+**D**) to duplicate the selected GameObject.

## Reorder items in the Hierarchy window

By default, the Hierarchy window lists GameObjects by order of creation, with the most recently created GameObjects at the bottom. You can reorder the GameObjects by dragging them up or down.

## Group items using parenting

Unity uses the concept of parent-child hierarchies, or parenting, to group GameObjects. An object can contain other GameObjects that inherit some of its properties. Child GameObjects inherit the movement and rotation of the parent GameObject. To learn more, refer to [Transform component](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Transform.html).

You can link GameObjects together to help move, scale, or transform a collection of GameObjects. When you move the top-level object, or parent GameObject, you also move all child GameObjects.

To group items into a parent-child hierarchy, select the child object and drag it onto the parent object. To ungroup items, select the child object and drag it to a different position in the Hierarchy window.

You can also create nested parent-child GameObjects. All nested objects are still descendants of the original parent GameObject, or root GameObject.

To set parent-child relationships in a C# script, use the Transform.SetParent method or the Transform.parent property of the child GameObject.

![**Child 1** and **Child 2** are the child GameObjects of **Parent**. **Child 3** is a child GameObject of **Child 2**, and a descendant GameObject of **Parent**.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/parenting-in-hierarchy-window.png)

### Create a child GameObject

To create a child GameObject:

-   Drag the GameObject onto the parent GameObject in the Hierarchy.

### Paste GameObjects as child

You can cut or copy a selected GameObject and then paste it as a child of another GameObject. Pasted child GameObjects keep their world position.

To paste a GameObject as child:

1.  Right-click the selected GameObject, and then select **Cut** or **Copy**.
2.  Right-click the intended parent GameObject, and then select **Paste as Child**.

You can also press **Ctrl**+**Shift**+**V** (macOS: **Command**+**Shift**+**V**) to paste a GameObject as a child.

### Create a parent GameObject

You can add a new GameObject into the Hierarchy view as the parent of existing GameObjects.

To create a parent GameObject:

1.  Right-click a GameObject, or select multiple GameObjects on the same level and right-click.
2.  Select **Create Empty Parent**.

You can also use the keyboard shortcut **Ctrl+Shift+G** (Windows) or **Command+Shift+G** (macOS) to create a parent GameObject when you have selected a GameObject.

## Show or hide child GameObjects in the Hierarchy window

To toggle the visibility of child GameObjects in the Hierarchy window:

1.  Select the foldout arrow (►) to the left of the parent GameObject.
2.  Hold **Alt** while clicking the foldout arrow (►) to toggle visibility of all descendant GameObjects of the root GameObject.
3.  Select the drop-down arrow again (▼) to collapse all descendant GameObjects.

### Organize GameObjects with default parent

You can make any GameObject in the Hierarchy window the default parent. When you create a new GameObject, or drag a GameObject into the Scene view, Unity automatically makes this GameObject a child of the default parent GameObject.

To set a GameObject as the default parent:

1.  In the Hierarchy window, right-click on the GameObject.
2.  Select **Set as Default Parent**.

The name of the default parent GameObject in the Hierarchy window is bold.

To remove default parent status from a GameObject:

1.  In the Hierarchy window, right-click on the GameObject.
2.  Select **Clear Default Parent**.

You can only set one default parent per Scene. In the Hierarchy window, if you set a GameObject as the default parent, and then you make a different GameObject in the same Scene the default parent, only the second GameObject is the default parent.

If you have multiple Scenes in the Hierarchy window, and you set default parents in each Scene, when you drag a GameObject into the Scene view, Unity makes the default parent GameObject in the active Scene the parent of the new GameObject.

You can set a keyboard shortcut for the default parent setting in the [Shortcuts manager](https://docs.unity3d.com/6000.3/Documentation/Manual/ShortcutsManager.html). On the Shortcuts window, assign a keyboard shortcut to **Hierarchy View** \> **Set as Default Parent**. If there’s no default parent set, and in the Hierarchy window you select a GameObject, use the shortcut to make this GameObject the default parent. When a default parent is set, use the shortcut to remove default parent status from any GameObject that has it.

## Set Scene visibility and pickability

If you have a scene with many GameObjects, it can be difficult to find and select specific GameObjects in the [**Scene** view](https://docs.unity3d.com/6000.3/Documentation/Manual/UsingTheSceneView.html). To clear the **Scene** view without impacting the visibility or behavior of GameObjects in the game, you can toggle the visibility and pickability of GameObjects from the **Hierarchy** window:

-   To hide and show the GameObject, select **Scene visibility** (eye icon).
-   To toggle the GameObject’s pickability, select **Scene picking** (hand icon).

**Note:** If you select multiple GameObjects, press **H** to hide and show them, and **L** to toggle their pickability.

For more information, refer to [Scene visibility](https://docs.unity3d.com/6000.3/Documentation/Manual/SceneVisibility.html) and [Scene picking](https://docs.unity3d.com/6000.3/Documentation/Manual/ScenePicking.html).

## Change the Hierarchy view

You can enable the [**New Hierarchy** setting](https://docs.unity3d.com/6000.3/Documentation/Manual/preferences-general.html) in the Preferences window (**Edit** \> **Preferences** (macOS: **Unity \> Settings**) \> **General**) to change the view of the Hierarchy window. This view displays extra information about the GameObjects in your scene such as their [layers](https://docs.unity3d.com/6000.3/Documentation/Manual/Layers.html) and [tags](https://docs.unity3d.com/6000.3/Documentation/Manual/Tags.html), and optionally highlights each alternate row for easier navigation of items. For more information, refer to [New Hierarchy](https://docs.unity3d.com/6000.3/Documentation/Manual/hierarchy-reference.html#new-hierarchy).

**Important**: The **New Hierarchy** setting is in preview and might change in future versions of Unity.

## Additional resources

-   [Hierarchy window reference](https://docs.unity3d.com/6000.3/Documentation/Manual/hierarchy-reference.html)
-   [The GameObject class](https://docs.unity3d.com/6000.3/Documentation/Manual/class-GameObject.html)
-   [The Scene view](https://docs.unity3d.com/6000.3/Documentation/Manual/UsingTheSceneView.html)
-   [The Inspector window](https://docs.unity3d.com/6000.3/Documentation/Manual/UsingTheInspector.html)
