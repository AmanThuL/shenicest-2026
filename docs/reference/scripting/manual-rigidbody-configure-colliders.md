---
title: "Configure Rigidbody Colliders"
page_title: "Unity - Manual: Configure Rigidbody Colliders"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/rigidbody-configure-colliders.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/rigidbody-configure-colliders.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Configure Rigidbody Colliders

[Colliders](https://docs.unity3d.com/6000.3/Documentation/Manual/collision-section.html) define the physical boundaries of a Rigidbody. To allow collisions to occur, you must add Colliders to a GameObject alongside a Rigidbody.

If one Rigidbody collides with another, the physics engine only calculates a collision if both GameObjects have a Collider attached. If one GameObject has a Rigidbody but no Collider, it passes through other GameObjects, and Unity does not include it in collision calculations.

![Colliders define the physical boundaries of a Rigidbody](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/RigidbodyandCollider.png)

The relative **Mass** of each Rigidbody in a collision determines how they react when they collide with each other.

See [Collision](https://docs.unity3d.com/6000.3/Documentation/Manual/collision-section.html) for more information.

## Convex and concave collider geometry

The PhysX physics system requires that any collider you place on a non-kinematic Rigidbody is convex, not concave. All primitive shapes in Unity are convex. However, Unity considers a [Mesh Collider](https://docs.unity3d.com/6000.3/Documentation/Manual/class-MeshCollider.html) concave by default.

If you apply a default Mesh Collider to a non-kinematic Rigidbody, Unity throws an error at runtime. To ensure that your non-kinematic Rigidbody receives physics-based forces, you need to instruct Unity to make the Mesh Collider convex. To do this, enable the Mesh Collider’s **Convex** property. When **Convex** is enabled, Unity automatically calculates a convex collider shape (called a hull) based on the associated mesh. However, because the convex hull of the mesh is only an approximation of the original shape, it can lead to inaccurate simulation.

For a more accurate collision simulation, you can use one of the following approaches:

-   Use a DCC tool to split the mesh into several parts, so that when Unity calculates their convex hulls, they represent the total shape better.
-   Use several primitive Colliders to manually build a [Compound Collider](https://docs.unity3d.com/6000.3/Documentation/Manual/compound-colliders.html) that is the same shape as the mesh.
-   Use automatic tools that calculate convex approximations of any mesh, such as Unity’s [V-HACD](https://github.com/Unity-Technologies/VHACD).

If a Rigidbody is kinematic (that is, it receives no physics-based forces), you can apply any collider to it.
