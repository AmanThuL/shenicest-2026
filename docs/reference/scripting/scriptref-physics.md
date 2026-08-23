---
title: "Scripting API: Physics"
page_title: "Unity - Scripting API: Physics"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Physics

class in UnityEngine

/

Implemented in:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UnityEngine.PhysicsModule.html" class="cl">UnityEngine.PhysicsModule</a>

<span id="scrollToFeedback">Leave feedback</span>

<span class="blue-btn sbtn">Suggest a change</span>

## Success!

Thank you for helping us improve the quality of Unity Documentation. Although we cannot accept all submissions, we do read each suggested change from our users and will make updates where applicable.

<span class="gray-btn sbtn close">Close</span>

## Submission failed

For some reason your suggested change could not be submitted. Please \<a>try again\</a> in a few minutes. And thank you for taking the time to help us improve the quality of Unity Documentation.

<span class="gray-btn sbtn close">Close</span>

Your name Your email Suggestion<span class="r">\*</span>

Submit suggestion

<span class="cancel left lh42 cn">Cancel</span>

<span style="color:red;"> </span>

### Description

Global physics properties and helper methods.

### Static Properties

| Property                                                                                                                                      | Description                                                                                                                                         |
|-----------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------|
| [AllLayers](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.AllLayers.html)                                             | Layer mask constant to select all layers.                                                                                                           |
| [bounceThreshold](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics-bounceThreshold.html)                                 | Two colliding objects with a relative velocity below this will not bounce (default 2). Must be positive.                                            |
| [clothGravity](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics-clothGravity.html)                                       | Cloth Gravity setting. Set gravity for all cloth components.                                                                                        |
| [defaultContactOffset](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics-defaultContactOffset.html)                       | The default contact offset of the newly created colliders.                                                                                          |
| [defaultMaxAngularSpeed](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics-defaultMaxAngularSpeed.html)                   | Default maximum angular speed of the dynamic Rigidbody, in radians (default 50).                                                                    |
| [defaultMaxDepenetrationVelocity](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics-defaultMaxDepenetrationVelocity.html) | The maximum default velocity needed to move a Rigidbody's collider out of another collider's surface penetration. Must be positive.                 |
| [defaultPhysicsScene](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics-defaultPhysicsScene.html)                         | The PhysicsScene automatically created when Unity starts.                                                                                           |
| [DefaultRaycastLayers](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.DefaultRaycastLayers.html)                       | Layer mask constant to select default raycast layers.                                                                                               |
| [defaultSolverIterations](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics-defaultSolverIterations.html)                 | The defaultSolverIterations determines how accurately Rigidbody joints and collision contacts are resolved. (default 6). Must be positive.          |
| [defaultSolverVelocityIterations](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics-defaultSolverVelocityIterations.html) | The defaultSolverVelocityIterations affects how accurately the Rigidbody joints and collision contacts are resolved. (default 1). Must be positive. |
| [gravity](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics-gravity.html)                                                 | The gravity applied to all rigid bodies in the Scene.                                                                                               |
| [IgnoreRaycastLayer](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.IgnoreRaycastLayer.html)                           | Layer mask constant to select ignore raycast layer.                                                                                                 |
| [improvedPatchFriction](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics-improvedPatchFriction.html)                     | Enables an improved patch friction mode that guarantees static and dynamic friction do not exceed analytical results.                               |
| [interCollisionDistance](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics-interCollisionDistance.html)                   | Sets the minimum separation distance for cloth inter-collision.                                                                                     |
| [interCollisionStiffness](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics-interCollisionStiffness.html)                 | Sets the cloth inter-collision stiffness.                                                                                                           |
| [invokeCollisionCallbacks](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics-invokeCollisionCallbacks.html)               | Whether or not MonoBehaviour collision messages will be sent by the physics system.                                                                 |
| [queriesHitBackfaces](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics-queriesHitBackfaces.html)                         | Whether physics queries should hit back-face triangles.                                                                                             |
| [queriesHitTriggers](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics-queriesHitTriggers.html)                           | Specifies whether queries (raycasts, spherecasts, overlap tests, etc.) hit Triggers by default.                                                     |
| [reuseCollisionCallbacks](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics-reuseCollisionCallbacks.html)                 | Determines whether the garbage collector should reuse only a single instance of a Collision type for all collision callbacks.                       |
| [simulationMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics-simulationMode.html)                                   | Controls when Unity executes the physics simulation.                                                                                                |
| [sleepThreshold](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics-sleepThreshold.html)                                   | The mass-normalized energy threshold, below which objects start going to sleep.                                                                     |

### Static Methods

| Method                                                                                                                          | Description                                                                                                                                                                                                                                                                                         |
|---------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [BakeMesh](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.BakeMesh.html)                                 | Prepares the mesh for use with a MeshCollider and uses default cooking options.                                                                                                                                                                                                                     |
| [BoxCast](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.BoxCast.html)                                   | Casts the box along a ray and returns detailed information on what was hit.                                                                                                                                                                                                                         |
| [BoxCastAll](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.BoxCastAll.html)                             | Like Physics.BoxCast, but returns all hits.                                                                                                                                                                                                                                                         |
| [BoxCastNonAlloc](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.BoxCastNonAlloc.html)                   | Cast the box along the direction, and store hits in the provided buffer.                                                                                                                                                                                                                            |
| [CapsuleCast](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.CapsuleCast.html)                           | Casts a capsule against all colliders in the Scene and returns detailed information on what was hit.                                                                                                                                                                                                |
| [CapsuleCastAll](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.CapsuleCastAll.html)                     | Like Physics.CapsuleCast, but this function will return all hits the capsule sweep intersects.                                                                                                                                                                                                      |
| [CapsuleCastNonAlloc](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.CapsuleCastNonAlloc.html)           | Casts a capsule against all colliders in the Scene and returns detailed information on what was hit into the buffer.                                                                                                                                                                                |
| [CheckBox](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.CheckBox.html)                                 | Check whether the given box overlaps with other colliders or not.                                                                                                                                                                                                                                   |
| [CheckCapsule](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.CheckCapsule.html)                         | Checks if any colliders overlap a capsule-shaped volume in world space.                                                                                                                                                                                                                             |
| [CheckSphere](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.CheckSphere.html)                           | Returns true if there are any colliders overlapping the sphere defined by position and radius in world coordinates.                                                                                                                                                                                 |
| [ClosestPoint](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.ClosestPoint.html)                         | Returns a point on the given collider that is closest to the specified location.                                                                                                                                                                                                                    |
| [ComputePenetration](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.ComputePenetration.html)             | Compute the minimal translation required to separate the given colliders apart at specified poses.                                                                                                                                                                                                  |
| [GetIgnoreCollision](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.GetIgnoreCollision.html)             | Checks whether the collision detection system will ignore all collisions/triggers between collider1 and collider2 or not.                                                                                                                                                                           |
| [GetIgnoreLayerCollision](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.GetIgnoreLayerCollision.html)   | Are collisions between layer1 and layer2 being ignored?                                                                                                                                                                                                                                             |
| [IgnoreCollision](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.IgnoreCollision.html)                   | Makes the collision detection system ignore all collisions between collider1 and collider2.                                                                                                                                                                                                         |
| [IgnoreLayerCollision](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.IgnoreLayerCollision.html)         | Makes the collision detection system ignore all collisions between any collider in layer1 and any collider in layer2.Note that IgnoreLayerCollision will reset the trigger state of affected colliders, so you might receive OnTriggerExit and OnTriggerEnter messages in response to calling this. |
| [Linecast](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.Linecast.html)                                 | Returns true if there is any collider intersecting the line between start and end.                                                                                                                                                                                                                  |
| [OverlapBox](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.OverlapBox.html)                             | Find all colliders touching or inside of the given box.                                                                                                                                                                                                                                             |
| [OverlapBoxNonAlloc](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.OverlapBoxNonAlloc.html)             | Find all colliders touching or inside of the given box, and store them into the buffer.                                                                                                                                                                                                             |
| [OverlapCapsule](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.OverlapCapsule.html)                     | Check the given capsule against the physics world and return all overlapping colliders.                                                                                                                                                                                                             |
| [OverlapCapsuleNonAlloc](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.OverlapCapsuleNonAlloc.html)     | Check the given capsule against the physics world and return all overlapping colliders in the user-provided buffer.                                                                                                                                                                                 |
| [OverlapSphere](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.OverlapSphere.html)                       | Computes and stores colliders touching or inside the sphere.                                                                                                                                                                                                                                        |
| [OverlapSphereNonAlloc](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.OverlapSphereNonAlloc.html)       | Computes and stores colliders touching or inside the sphere into the provided buffer.                                                                                                                                                                                                               |
| [Raycast](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.Raycast.html)                                   | Casts a ray, from point origin, in direction direction, of length maxDistance, against all colliders in the Scene.                                                                                                                                                                                  |
| [RaycastAll](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.RaycastAll.html)                             | Casts a ray through the Scene and returns all hits. Note that order of the results is undefined.                                                                                                                                                                                                    |
| [RaycastNonAlloc](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.RaycastNonAlloc.html)                   | Cast a ray through the Scene and store the hits into the buffer.                                                                                                                                                                                                                                    |
| [RebuildBroadphaseRegions](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.RebuildBroadphaseRegions.html) | Rebuild the broadphase interest regions as well as set the world boundaries.                                                                                                                                                                                                                        |
| [Simulate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.Simulate.html)                                 | Simulate physics in the Scene.                                                                                                                                                                                                                                                                      |
| [SphereCast](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.SphereCast.html)                             | Casts a sphere along a ray and returns detailed information on what was hit.                                                                                                                                                                                                                        |
| [SphereCastAll](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.SphereCastAll.html)                       | Like Physics.SphereCast, but this function will return all hits the sphere sweep intersects.                                                                                                                                                                                                        |
| [SphereCastNonAlloc](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.SphereCastNonAlloc.html)             | Cast sphere along the direction and store the results into buffer.                                                                                                                                                                                                                                  |
| [SyncTransforms](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.SyncTransforms.html)                     | Apply Transform changes to the physics engine.                                                                                                                                                                                                                                                      |

### Events

| Event                                                                                                                     | Description                                                                                            |
|---------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------|
| [ContactEvent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.ContactEvent.html)                   | Subscribe to this event to read all collisions that occurred during the physics simulation step.       |
| [ContactModifyEvent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.ContactModifyEvent.html)       | Subscribe to this event to be able to customize the collision response for contact pairs.              |
| [ContactModifyEventCCD](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.ContactModifyEventCCD.html) | Subscribe to this event to be able to customize the collision response of CCD generated contact pairs. |

### Delegates

| Delegate                                                                                                                | Description |
|-------------------------------------------------------------------------------------------------------------------------|-------------|
| [ContactEventDelegate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.ContactEventDelegate.html) |             |
