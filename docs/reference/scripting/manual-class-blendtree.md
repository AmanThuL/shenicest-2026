---
title: "Animation Blend Trees"
page_title: "Unity - Manual: Animation Blend Trees"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-BlendTree.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-BlendTree.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Animation Blend Trees

A common task in game animation is to blend between two or more similar motions. Perhaps the best known example is the blending of walking and running animations according to the character’s speed. Another example is a character leaning to the left or right as it turns during a run.

It is important to distinguish between Transitions and Blend Trees. While both are used for creating smooth animation, they are used for different kinds of situations.

-   Use **Transitions** to smoothly transition from one Animation State to another over a given amount of time. Transitions are specified as part of an [Animation State Machine](https://docs.unity3d.com/6000.3/Documentation/Manual/AnimationStateMachines.html). A transition from one motion to a completely different motion is usually fine if the transition is quick.

-   Use **Blend Trees** to smoothly blend multiple animations by incorporating parts of each animation, at varying degrees. The amount that each of the motions contributes to the final effect is controlled using a blending parameter, which is just one of the numeric [animation parameters](https://docs.unity3d.com/6000.3/Documentation/Manual/AnimationParameters.html) associated with the Animator Controller. In order for the blended motion to make sense, the motions that are blended must be of similar nature and timing. Blend Trees are a special type of state in an Animation State Machine.

Examples of similar motions could be various walk and run animations. In order for the blend to work well, the movements in the clips must take place at the same points in normalized time. For example, walking and running animations can be aligned so that the moments of contact of foot to the floor take place at the same points in normalized time (e.g. the left foot hits at 0.0 and the right foot at 0.5). Since normalized time is used, it doesn’t matter if the clips are of different length.

## Using Blend Trees

To start working with a new Blend Tree, do the following:

1.  Right-click on an empty space in the Animator Controller view.
2.  Select **Create State** > **From New Blend Tree** from the context menu.
3.  Double-click the Blend Tree to enter the Blend Tree Graph.

The Animator window displays a graph of the entire Blend Tree while the Inspector shows the currently selected node and its immediate children, if applicable.

![For example, the Blend Tree on the left displays only the root Blend Node because it does not have child nodes. The Blend Tree on the right has a root with three Animation Clips as child nodes.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/MecanimBlendTreeStateDiagramCombined.png)

To add animation clips to the blend tree you can select the blend tree, then click the plus icon in the motion field in the inspector.

![A Blend Node in the inspector before motions are added. Use the plus icon to add animation clips or child blend trees.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/MecanimBlendTreeInitial.png)

You can also right-click and use the context menu to add animation clips or child blend nodes:

![The context menu when you right-click on a blend tree node.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/AnimatorBlendTreeContextMenu.png)

When the blend tree has Animation clips and input parameters, the Inspector window displays a graphical representation of how the animations are combined. Use the slider

This visualization changes as the parameter value changes (as you drag the slider, the arrows from the tree root change their shading to show the dominant animation clip).

![A 2D Blend Tree with five animation clips](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/AnimatorBlendTreeInspectorPreview.jpg)

Select any of the nodes in the Blend Tree graph to display it in the Inspector window. If the selected node is an Animation Clip, the Inspector for that Animation Clip will be shown. The settings will be read-only if the animation is imported from a model. If the node is a Blend Node, the Inspector for Blend Nodes will be shown.

Select either 1D or 2D blending from the **Blend Type** menu. The following topics provide more details on these blend types and the settings available in the Inspector window:

-   [1D Blending](https://docs.unity3d.com/6000.3/Documentation/Manual/BlendTree-1DBlending.html)
-   [2D Blending](https://docs.unity3d.com/6000.3/Documentation/Manual/BlendTree-2DBlending.html)
-   [Direct Blending](https://docs.unity3d.com/6000.3/Documentation/Manual/BlendTree-DirectBlending.html)
-   [Common Blend Tree Options](https://docs.unity3d.com/6000.3/Documentation/Manual/BlendTree-AdditionalOptions.html)
