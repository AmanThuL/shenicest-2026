---
title: "Unity 6.3 Manual: Create and configure a trigger collider"
page_title: "Unity - Manual: Create and configure a trigger collider"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/collider-interactions-create-trigger.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/collider-interactions-create-trigger.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Create and configure a trigger collider

A trigger collider does not collide with other colliders; instead, other colliders pass through it.

To create a trigger collider:

1.  Create a GameObject:
    1.  To make an invisible trigger collider, create an empty GameObject. In most cases, trigger colliders are invisible.
    2.  To make a visible trigger collider, create a GameObject that has a mesh. You should only create a visible trigger collider if it is okay for other GameObjects to visibly pass through it at run time.
2.  Add a Collider to the GameObject.
3.  Make the collider a trigger:
    1.  To do this in the Editor, navigate to the collider’s Inspector and enable the **Is Trigger** property.
    2.  To do this via script, set the collider’s `IsTrigger` to `true`.

## Configure trigger collisions

Make sure there is at least one [dynamic collider](https://docs.unity3d.com/6000.3/Documentation/Manual/collider-types-introduction.html) in the collision. At least one GameObject involved in a trigger collision must have a physics body (a Rigidbody or an ArticulationBody). In most cases, trigger colliders are stationary and static (that is, they have no physics body), and the colliders that pass through them are moving and dynamic (that is, they have a physics body).

Experiment with the size and shape of your trigger collider. For gameplay and simulation, triggers might need some adjustment to make them feel intuitive for the player. For example, you could experiment with making a trigger collider slightly larger than its associated visible GameObject, so that it has a wider radius.
