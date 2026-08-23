---
title: "Transforms"
page_title: "Unity - Manual: Transforms"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-Transform.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-Transform.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Transforms

<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html" class="switch-link gray-btn sbtn left" title="Go to Transform page in the Scripting Reference">Switch to Scripting</a>

The **Transform** stores a GameObject’s **Position**, **Rotation**, **Scale** and parenting state. A GameObject always has a Transform component attached: you can’t remove a Transform or create a GameObject without a Transform component.

## The Transform Component

The Transform component determines the **Position**, **Rotation**, and **Scale** of each GameObject in the scene. Every GameObject has a Transform.

![The Transform component](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/TransformExample4.png)

**Tip**: You can change the colors of the Transform axes (and other UI elements) (**Menu: Unity \> Preferences** and then select the **Colors & keys** panel).

## Properties

| **Property:**                      | **Function:**                                                                                                                                    |
|:-----------------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------|
| **Position**                       | Position of the Transform in the x, y, and z coordinates.                                                                                        |
| **Rotation**                       | Rotation of the Transform around the x-axis, y-axis, and z-axis, measured in degrees.                                                            |
| **Scale**                          | Scale of the Transform along the x-axis, y-axis, and z-axis. The value “1” is the original size (the size at which you imported the GameObject). |
| **Enable Constrained Proportions** | Force the scale to maintain its current proportions, so that changing one axis changes the other two axes. Disabled by default.                  |

Unity measures the **Position**, **Rotation** and **Scale** values of a Transform relative to the Transform’s parent. If the Transform has no parent, Unity measures the properties in world space.

## Editing Transforms

In 2D space, you can manipulate Transforms on the x-axis or the y-axis only. In 3D space, you can manipulate Transforms on the x-axis, y-axis, and z-axis. In Unity, these axes are represented by the colors red, green, and blue respectively.

![A Transform showing the color-coding of the axes](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/TransformExample2.png)

There are three primary ways you can edit a Transform’s properties:

-   In the [Scene view](https://docs.unity3d.com/6000.3/Documentation/Manual/UsingTheSceneView.html).
-   In the [Inspector window](https://docs.unity3d.com/6000.3/Documentation/Manual/UsingTheInspector.html).
-   In your [C# scripts](https://docs.unity3d.com/6000.3/Documentation/Manual/scripting.html).

### Scene view

In the Scene view, you can use the Move, Rotate and Scale tools to modify Transforms. These tools are located in the upper left-hand corner of the Unity Editor.

![The Hand, Move, Rotate, and Scale tools](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/Transform-Tools.png)

You can use the Transform tools on any GameObject in a scene. When you select a GameObject, the tool **Gizmo** appears within it. The appearance of the Gizmo depends on which tool you select.

![The transform Gizmo with keyboard shortcuts in brackets.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/TransformGizmo35.png)

When you click and drag on one of the three Gizmo axes, the axis’s color changes to yellow. While you drag the mouse, the GameObject moves, rotates, or scales along the selected axis. When you release the mouse button, the axis remains selected

While moving the GameObject, you can lock movement to a particular plane (that is, change two of the axes and keep the third unchanged). To activate the lock for each plane, select the three small coloured squares around the center of the Move Gizmo. The colors correspond to the axis that locks when you select the square (for example, select the blue square to lock the z-axis).

### Inspector window

In the Inspector window, you can use the Transform component to edit the Transform properties of a selected GameObject. There are two ways to edit the Transform property values in the component:

-   Enter values into the property value fields manually. This is useful for very specific adjustments.
-   Click a value field and drag up or down to increase or decrease the value. This is useful for less specific adjustments.

### From code

Use the `Transform` class in your C# code to modify a GameObject’s position, rotation, and scale, as well as its hierarchical relationship to parent and child GameObjects.

For a complete reference of every member of the `Transform` class and usage examples, refer to the [`Transform`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) API reference.

<span id="parent"></span>

## Grouping GameObjects

In Unity, you can group GameObjects into parent-child hierarchies:

-   A parent GameObject has other GameObjects connected to it that take on its Transform properties.
-   A child GameObject is connected to another GameObject, and takes on that GameObject’s Transform properties.

In the Hierarchy window, child GameObjects appear directly underneath parent GameObjects and are indented in the list. You can select the fold-out icon to hide or reveal a parent GameObject’s child GameObjects.

A child GameObject moves, rotates, and scales exactly as its parent does. Child GameObjects can also have child GameObjects of their own. A GameObject can have multiple child GameObjects, but only one parent GameObject.

These multiple levels of parent-child relationships between GameObjects form a Transform hierarchy. The GameObject at the top of a hierarchy (that is, the only GameObject in the hierarchy that doesn’t have a parent) is known as the **root** GameObject.

To create a parent GameObject, drag any GameObject in the Hierarchy window onto another. This creates a parent-child relationship between the two GameObjects.

![Example of a Parent-Child hierarchy. GameObjects with foldout arrows to the left of their names are parents.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/ParentingExample.png)

### Editing Transforms for parent and child GameObjects

You can group GameObjects into parent-child hierarchies.

The Transform values for any child GameObject are displayed relative to the parent GameObject’s Transform values. These values are called **local coordinates**. For scene construction, it is usually sufficient to work with local coordinates for child GameObjects. In gameplay, it is often useful to find their **global coordinates** or their exact position in world space. [The scripting API for the Transform component](https://docs.unity3d.com/ScriptReference/Transform.html) has separate properties for local and global **Position**, **Rotation** and **Scale**, and lets you convert between local and global coordinates.

**Tip**: When you parent Transforms, it is useful to set the parent’s location to \<0,0,0> before you add the child Transform. This means that the local coordinates for the child Transform will be the same as the global coordinates, which makes it easier to ensure the child Transform is in the right position.

## Transforms and Scale

The **Scale** of the Transform determines the difference between the size of a mesh in your modeling application and the size of that mesh in Unity. The mesh’s size in Unity (and therefore the Transform’s **Scale**) is important, especially during physics simulation. By default, the physics engine assumes that one unit in world space corresponds to one meter. If a GameObject is very large, it can appear to fall in “slow motion”; the simulation is correct because you are watching a very large GameObject fall a great distance.

Three factors affect the **Scale** of your GameObject:

-   The size of your mesh in your 3D modeling application.
-   The **Mesh Scale Factor** setting in the GameObject’s **Import Settings**.
-   The **Scale** values of your Transform Component.

Don’t adjust the **Scale** of your GameObject in the Transform component. If you create your models at real-life scale, you won’t have to change your Transform’s **Scale**. You can also adjust the scale at which your mesh is imported because some optimizations occur based on the import size. Do this in the **Import settings** for your individual mesh. Instantiating a GameObject that has an adjusted **Scale** value can decrease performance.

Never set any **Scale** axis to 0 in the Transform component. Doing so can cause undefined results for math calculations, such as NaN (Not a Number) values in rendering, which leads to incorrect graphical artifacts on screen.

Changing the **Scale** affects the position of child Transforms. For example, scaling the parent Transform to (0,0,0) positions all child Transforms at (0,0,0) relative to the parent Transform.

## Non-uniform scaling

Non-uniform scaling is when the Scale in a Transform has different values for x, y, and z; for example (2, 4, 2). In contrast, uniform scaling has the same value for x, y, and z; for example (3, 3, 3). Non-uniform scaling can be useful in a few specific cases but it behaves differently to uniform scaling:

-   Some components don’t fully support non-uniform scaling. For example, some components have a circular or spherical element defined by a **Radius** property, such as Sphere Collider, Capsule Collider, Light and Audio Source. This means the circular shape remains circular under non-uniform scaling instead of elliptical.
-   If a child GameObject has a non-uniformly scaled parent GameObject and is rotated relative to that parent GameObject, it might appear skewed or “sheared”. There are components that support simple non-uniform scaling but that don’t work correctly when skewed like this. For example, a skewed Box Collider does not match the shape of the rendered mesh accurately.
-   A child GameObject of a non-uniformly scaled parent GameObject does not have its scale automatically updated when it rotates. As a result, the child GameObject’s shape might appear to change abruptly when you eventually update the scale, for example, if the child GameObject is detached from the parent GameObject.

## Additional Resources

-   [Position GameObjects](https://docs.unity3d.com/6000.3/Documentation/Manual/PositioningGameObjects.html)
-   [Grid Snapping](https://docs.unity3d.com/6000.3/Documentation/Manual/GridSnapping.html)

<span class="search-words">Transform</span>
