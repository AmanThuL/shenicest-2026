---
title: "Introduction to compound colliders"
page_title: "Unity - Manual: Introduction to compound colliders"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/compound-colliders-introduction.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/compound-colliders-introduction.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to compound colliders

A **compound collider** is a collection of colliders on the same Rigidbody GameObject.

Compound colliders collectively behave like a single Rigidbody collider. They are useful when you need an accurate collider for a concave shape, or if you have a model that would be too computationally demanding to simulate with a [Mesh collider](https://docs.unity3d.com/6000.3/Documentation/Manual/mesh-colliders.html).

## Construction of a compound collider

A compound collider is made of the following elements:

-   A parent GameObject that has a Rigidbody
-   Empty child GameObjects that contain colliders

A compound collider should only have one Rigidbody, which should be on the root GameObject.

For more guidance on how to create a compound collider, see [Create a compound collider](https://docs.unity3d.com/6000.3/Documentation/Manual/create-compound-collider.html).

![A compound collider setup on a gun model. Five colliders make up an approximation of the model’s shape.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/CompoundCollider.jpg)

In the above picture, the **Gun Model** GameObject has a Rigidbody attached to its parent GameObject, and several child GameObjects that each have a primitive collider. When physics forces move the Rigidbody parent, the child colliders move along with it. The primitive colliders can collide with other colliders in the environment, and the parent Rigidbody alters the way it moves based on these collisions.

This configuration offers more flexibility than a single GameObject that contains a Rigidbody and several colliders. When each collider is on a different GameObject, you can modify the Transform of each collider individually. However, you should monitor the Rigidbody’s behavior when you reposition colliders. Changes to collider position and scale can change the Rigidbody’s center of mass, which can result in some unexpected behavior if continuous change is made over several frames at runtime. If this happens, you can use [`rigidbody.centerOfMass`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody-centerOfMass.html) to manually set the center of mass.

## How a compound collider works

When you attach several colliders to the same Rigidbody, the physics system treats the whole collection as a single Rigidbody collider. The [collider type](https://docs.unity3d.com/6000.3/Documentation/Manual/collider-types-introduction.html) (dynamic or kinematic) is defined by the Rigidbody configuration.

When a compound collider touches another collider, Unity registers collisions per each individual collider in the compound. For this reason, you should try to arrange your colliders so that you only get the collision pairs you want at runtime, or use collider labels to determine behaviors caused by specific colliders.

## Benefits and limitations of compound colliders

In most cases, compound colliders offer a similar solution to [Mesh colliders](https://docs.unity3d.com/6000.3/Documentation/Manual/mesh-colliders.html): their primary purpose is to provide accurate collisions for items with complex shapes. When considering the benefits and limitations of compound colliders, you are usually comparing them to Mesh colliders.

The main benefits of compound colliders are:

-   You can get collisions for complex concave shapes. Mesh colliders are more accurate, but they don’t support accurate collisions for concave shapes.
-   In some cases, compound colliders can be less computationally demanding than Mesh colliders. This is often the case for simpler shapes which only require a few colliders to approximate, or for shapes that don’t need to be too accurate. For example, a Mesh collider might generate hundreds of polygons in order to precisely match a complex shape, but an approximation with primitive colliders might require far fewer.

However, compound colliders also have some significant limitations:

-   Compound colliders are not as accurate. In most cases, you build a compound collider out of simpler shapes, which allow you to approximate but not perfectly match the shape of the item.
-   Compound colliders take longer to produce. Compound colliders require you to arrange each collider manually, which takes more time.
-   In some cases, compound colliders can be more computationally demanding than Mesh colliders. This is often the case for very complex shapes which require a high number of colliders to approximate. One Mesh collider might be more efficient than several primitive colliders.

The decision is always unique to your project, so you should test each configuration and use the Physics Profiler to understand the efficiency of your collider setup.
