---
title: "Creating models for optimal performance"
page_title: "Unity - Manual: Creating models for optimal performance"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/ModelingOptimizedCharacters.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/ModelingOptimizedCharacters.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Creating models for optimal performance

Here are a few tips for creating models for optimal performance. Some of these tips apply to all models, and some apply only to animated models:

-   [Minimize the polygon count](https://docs.unity3d.com/6000.3/Documentation/Manual/ModelingOptimizedCharacters.html#polygons)
-   [Use as few Materials as possible](https://docs.unity3d.com/6000.3/Documentation/Manual/ModelingOptimizedCharacters.html#mats)
-   [Use a single skinned Mesh Renderer](https://docs.unity3d.com/6000.3/Documentation/Manual/ModelingOptimizedCharacters.html#single)
-   [Use as few bones as possible](https://docs.unity3d.com/6000.3/Documentation/Manual/ModelingOptimizedCharacters.html#bones)
-   [Keep forward and inverse kinematics separate](https://docs.unity3d.com/6000.3/Documentation/Manual/ModelingOptimizedCharacters.html#ikfk)

Using these techniques might help increase the animation and rendering speed of your models, but be aware that they might also reduce the visual fidelity and realistic effects you are trying to achieve. There is no single answer for every situation that can produce a perfect balance between better performance and visual realism. You have to find the perfect balance according to the complexity of your characters and your scene, vs. the overall appearance and realism that you require.

<span id="polygons"></span>

## Minimize the polygon count

The number of polygons you should use depends on the visual quality you require and the platform you are targeting. These two competing facts are equally true:

-   The fewer the polygons you use in your meshes, the faster your application runs. This is because every vertex, edge, or face requires computing resources.
-   The more polygons you use in your Meshes, the more detailed and organic your GameObjects look, because smaller polygons give you more control over the shape.

Also consider what else is competing for rendering resources. If you have a lot of GameObjects or Terrain objects on screen at the same time, consider reducing the polygon count per meshes.

Note that the actual number of vertices that graphics hardware has to process is usually not the same as the number reported by a modelling application. Modeling applications usually display the number of distinct corner points that make up a model (known as the geometric vertex count). For a graphics card, however, some geometric vertices need to be split into two or more logical vertices for rendering purposes: for example, a vertex must be split if it has multiple normals, UV coordinates or vertex colors. Consequently, the vertex count in Unity is usually higher than the count given by the 3D application.

<span id="mats"></span>

## Use as few materials as possible

Keep the number of [materials](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Material.html) on each model as low as possible. Only use more than one material on a character when you need to use different shaders for different parts; for example, you might use a special shaders for the eyes on a character model.

<span id="single"></span>

## Use a single skinned mesh

For animated character models that use a [Skinned Mesh Renderer](https://docs.unity3d.com/6000.3/Documentation/Manual/class-SkinnedMeshRenderer.html), you should use only one of these components per character. Unity’s animation system optimizes animation using visibility culling and bounding volume updates. It only activates these optimizations if you use one [Animation component](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Animation.html) and one Skinned Mesh Renderer on a model.

Using two skinned meshes in place of a single one could roughly double the rendering time for a model, and there is seldom any practical advantage in using multiple meshes.

<span id="bones"></span>

## Use as few bones as possible

In general, the fewer bones you use, the better the performance is. However, sometimes you need to create character models with a large number of bones: for example, when you want a lot of customizable attachments. These extra bones increase the size of the build, and may have a relative processing cost for each additional bone. For example, 15 additional bones on a rig that already has 30 bones takes Unity 50% more operations to solve in **Generic** mode, which might impact the time it takes to solve.

Note that you can have additional bones for [Generic](https://docs.unity3d.com/6000.3/Documentation/Manual/GenericAnimations.html) and [Humanoid](https://docs.unity3d.com/6000.3/Documentation/Manual/ConfiguringtheAvatar.html) types. When you have no animations playing using the additional bones, the processing cost should be negligible. This cost is even lower if their attachments are non-existent or hidden.

For performance reasons, use linear blend **skinning** with a maximum of four influences per vertex. However, some 3D modeling applications allow more than four bones to influence vertices, so you have to weigh the performance cost against greater control.

<span id="ikfk"></span>

## Keep forward and inverse kinematics separate

When Unity imports animations, it bakes a Model’s inverse kinematic (IK) nodes into forward kinematics (FK), and so Unity doesn’t need the IK nodes at all. However, if they are left in the model, then Unity still includes them in calculations, even though they don’t affect the animation. You can either delete the redundant IK nodes in Unity or in your 3D modeling application. To facilitate removing the IK nodes, keep separate IK and FK hierarchies while modeling.
