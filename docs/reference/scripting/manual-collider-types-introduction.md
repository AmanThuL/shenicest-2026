---
title: "Introduction to collider types"
page_title: "Unity - Manual: Introduction to collider types"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/collider-types-introduction.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/collider-types-introduction.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to collider types

A collider’s type defines how it interacts with other colliders, based on the configuration of its GameObject’s collider and physics body components.

The Unity documentation refers to the following collider types:

-   Static colliders: The GameObject has a collider but no physics body (Rigidbody or ArticulationBody).
-   Physics body colliders: The GameObject has a collider and a physics body.
    -   Dynamic colliders: The GameObject’s physics body is dynamic (that is, it has **Is Kinematic** disabled).
    -   Kinematic Rigidbody colliders: The GameObject’s Rigidbody is kinematic (that is, it has **Is Kinematic** enabled). An ArticulationBody cannot be kinematic.

For details on how the different collider types interact, refer to [Interaction between collider types](https://docs.unity3d.com/6000.3/Documentation/Manual/collider-types-interaction.html).

<span id="static-colliders"></span>

## Static colliders

A Static collider is a collider that has no associated Rigidbody or ArticulationBody (that is, there is no Rigidbody or ArticulationBody on the associated GameObject), and therefore doesn’t respond to simulated physics forces. Other colliders can collide with Static colliders, but Static colliders don’t move in response to collisions.

Use Static colliders for geometry that always stays in the same place and never moves around (for example, floors, walls and other motionless elements of a Scene).

The only way to move a static collider at run time is via the Transform. However, in most cases you should not do this. The physics system cannot immediately take Transform-led movement into consideration while calculating physics updates, and you might see unintended side-effects if you move a static collider via the Transform. Instead, you should only use Static colliders for collider geometry that does not move at run time. If you want a collider that does not respond to physics forces but which can move at run time in a way that the physics system can detect and calculate, consider using a kinematic physics body collider.

Because Static colliders are not designed to be moving or temporary colliders, the physics system does not recalculate or awaken physics bodies in response to Static colliders moving or disappearing. For example: if you place a car (with a physics body and Wheel Colliders) on a static collider, the Wheel Colliders detect the collider and rest on it. After a few frames without input, the car’s physics body and colliders go to sleep. If the static collider moves, you might expect the car to travel with it, or fall. However, the physics system does not awaken the car’s physics body in response to the static collider’s movement, so the car stays where it is.

## Physics body colliders

A physics body collider is a collider on the same GameObject as a physics body (a Rigidbody or an ArticulationBody). Physics body colliders are included in physics calculations, but behave differently depending on whether they are dynamic or kinematic (that is, whether **Is Kinematic** is disabled or enabled).

A Rigidbody can be either dynamic or kinematic. An ArticulationBody can only be dynamic; it cannot be kinematic.

### Dynamic colliders

A dynamic collider is a collider on the same GameObject as a dynamic physics body. Dynamic colliders respond to simulated physics forces. They can collide with other objects (including static colliders), and other colliders can move them or apply force to them.

Use dynamic colliders for any GameObject that you want the physics system to include in physics calculations, and to move via physics forces.

Physics body colliders are dynamic by default.

### Kinematic colliders

A kinematic collider is a collider on the same GameObject as a kinematic Rigidbody. An ArticulationBody cannot be kinematic.

Like static colliders, kinematic colliders do not respond to simulated physics forces. Other colliders can collide with kinematic colliders, but kinematic colliders don’t move in response to collisions.

Unlike a static collider, the physics system can include a kinematic collider in physics calculations. Kinematic colliders can:

-   Wake other colliders from a sleeping state when they make contact
-   Act as a [trigger collider](https://docs.unity3d.com/6000.3/Documentation/Manual/collider-interactions.html), and receive trigger events from other colliders
-   Apply [friction](https://docs.unity3d.com/6000.3/Documentation/Manual/collider-surface-friction.html) to other colliders

Use kinematic colliders for colliders that act like static colliders most of the time, but which you also want to be able to occasionally move (for example, a sliding door that normally acts as an immovable physical obstacle but can open when necessary).

You can use [`Rigidbody.isKinematic`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody-isKinematic.html) to switch a Rigidbody collider between dynamic and kinematic via script as needed at run time. This can be a useful way to manage performance on colliders that don’t always need to be dynamic. For example, a common use case for switching collider types is to create a “ragdoll” effect, where a character normally moves under animation but responds physically to a heavy collision. The character’s limbs can be kinematic by default and move via animation, but a particular collider can trigger the Rigidbody to disable `IsKinematic`, so that the limbs are dynamic and behave like physics objects.

## Collider interactions

The different collider types (static, kinematic, and dynamic) interact differently depending on the configuration of each pair of colliders. For more details, see [Collider interactions](https://docs.unity3d.com/6000.3/Documentation/Manual/collider-interactions.html).
