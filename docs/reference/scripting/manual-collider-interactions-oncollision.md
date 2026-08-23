---
title: "OnCollision events"
page_title: "Unity - Manual: OnCollision events"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/collider-interactions-oncollision.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/collider-interactions-oncollision.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# OnCollision events

Collision events occur when two non-trigger colliders make contact.

Example uses for collision events include:

-   When a projectile hits a target, destroy both the projectile and the enemy.
-   When a player character touches a door, trigger an animation to open the door.
-   When a player character touches a power-up, increase the player’s size.

Working with collision events primarily involves the following API functions:

-   [`Collider.OnCollisionEnter`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Collider.OnCollisionEnter.html): Unity calls this function on each collider when two colliders first make contact.
-   [`Collider.OnCollisionStay`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Collider.OnCollisionStay.html): Unity calls this function on each collider once per physics update while two colliders are in contact.
-   [`Collider.OnCollisionExit`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Collider.OnCollisionExit.html): Unity calls this function on each collider when two colliders cease contact.

For collision events, at least one of the objects involved must have a dynamic physics body (that is, a Rigidbody or ArticulationBody that has **Is Kinematic** disabled). If both GameObjects in a collision are kinematic physics bodies, the collision does not call `OnCollision` functions.

The following example prints a message to the console when Unity calls each function.

``` lang-cs
using UnityEngine;
using System.Collections;

public class DoorObject : MonoBehaviour

    void OnCollisionStay (Collision other)
    
    void OnCollisionExit (Collision other)
    
}
```

For examples of practical applications for `OnCollision` events, refer to [example scripts for collider events](https://docs.unity3d.com/6000.3/Documentation/Manual/collider-interactions-example-scripts.html).

## Additional resources

-   [Collider interactions](https://docs.unity3d.com/6000.3/Documentation/Manual/collider-interactions.html)
-   [Collision](https://docs.unity3d.com/6000.3/Documentation/Manual/collision-section.html)
-   [Collider](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Collider.html)
