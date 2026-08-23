---
title: "Interaction between collider types"
page_title: "Unity - Manual: Interaction between collider types"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/collider-types-interaction.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/collider-types-interaction.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Interaction between collider types

The following collision matrix table describe which event messages Unity generates based on the configuration of each collider in a collision pair:

| **Collider types**             | **Static collider**                                       | **Dynamic collider**                                      | **Kinematic collider**                                    | **Static trigger collider**        | **Dynamic trigger collider**       | **Kinematic trigger collider**     |
|:-------------------------------|:----------------------------------------------------------|:----------------------------------------------------------|:----------------------------------------------------------|:-----------------------------------|:-----------------------------------|:-----------------------------------|
| **Static collider**            | No collision event message sent                           | Collision detection occurs and messages sent on collision | No collision event message sent                           | No collision event message sent    | Trigger messages sent on collision | Trigger messages sent on collision |
| **Dynamic collider**           | Collision detection occurs and messages sent on collision | Collision detection occurs and messages sent on collision | Collision detection occurs and messages sent on collision | Trigger messages sent on collision | Trigger messages sent on collision | Trigger messages sent on collision |
| **Kinematic collider**         | No collision event message sent                           | Collision detection occurs and messages sent on collision | No collision event message sent                           | Trigger messages sent on collision | Trigger messages sent on collision | Trigger messages sent on collision |
| **Static trigger collider**    | No collision event message sent                           | Trigger messages sent on collision                        | Trigger messages sent on collision                        | No collision event message sent    | Trigger messages sent on collision | Trigger messages sent on collision |
| **Dynamic trigger collider**   | Trigger messages sent on collision                        | Trigger messages sent on collision                        | Trigger messages sent on collision                        | Trigger messages sent on collision | Trigger messages sent on collision | Trigger messages sent on collision |
| **Kinematic trigger collider** | Trigger messages sent on collision                        | Trigger messages sent on collision                        | Trigger messages sent on collision                        | Trigger messages sent on collision | Trigger messages sent on collision | Trigger messages sent on collision |

## Collision generates collision detection messages

When a pair of colliders make contact, they generate collision detection messages if the following are both true:

-   There is at least one dynamic collider.
-   The other collider is a static collider, a kinematic collider, or another dynamic collider.

Trigger colliders don’t generate collision detection messages.

Unity only applies physics forces to collider GameObjects that have a physics body (a Rigidbody or ArticulationBody). When a physics body collider collides with a static collider, only the physics body collider behavior changes as a result of the collision (for example, it might bounce or slow down as a result of the collision).

## Collision generates trigger messages

Trigger messages occur in the following circumstances:

-   A dynamic or kinematic trigger collider collides with any collider type.
-   A static trigger collider collides with any dynamic or Kinematic collider.
