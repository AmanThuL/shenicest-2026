---
title: "Scripting API: AI.NavMeshAgent"
page_title: "Unity - Scripting API: NavMeshAgent"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# NavMeshAgent

class in UnityEngine.AI

/

Inherits from:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Behaviour.html" class="cl">Behaviour</a>

/

Implemented in:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UnityEngine.AIModule.html" class="cl">UnityEngine.AIModule</a>

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

Navigation mesh agent.

Attach this component to a mobile character in the game to allow the character to use the NavMesh to navigate the scene. For more details refer to [AI Navigation](https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/index.html).

### Properties

| Property                                                                                                                              | Description                                                                                                               |
|---------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------|
| [acceleration](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent-acceleration.html)                       | The maximum acceleration of an agent as it follows a path, given in units / sec^2.                                        |
| [agentTypeID](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent-agentTypeID.html)                         | The type ID for the agent.                                                                                                |
| [angularSpeed](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent-angularSpeed.html)                       | Maximum turning speed in (deg/s) while following a path.                                                                  |
| [areaMask](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent-areaMask.html)                               | Specifies which NavMesh areas are passable. Changing areaMask will make the path stale (see isPathStale).                 |
| [autoBraking](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent-autoBraking.html)                         | Should the agent brake automatically to avoid overshooting the destination point?                                         |
| [autoRepath](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent-autoRepath.html)                           | Should the agent attempt to acquire a new path if the existing path becomes invalid?                                      |
| [autoTraverseOffMeshLink](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent-autoTraverseOffMeshLink.html) | Should the agent move across OffMeshLinks automatically?                                                                  |
| [avoidancePriority](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent-avoidancePriority.html)             | The avoidance priority level.                                                                                             |
| [baseOffset](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent-baseOffset.html)                           | The relative vertical displacement of the owning GameObject.                                                              |
| [currentOffMeshLinkData](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent-currentOffMeshLinkData.html)   | The current OffMeshLinkData.                                                                                              |
| [desiredVelocity](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent-desiredVelocity.html)                 | The desired velocity of the agent including any potential contribution from avoidance. (Read Only)                        |
| [destination](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent-destination.html)                         | Gets or attempts to set the destination of the agent in world-space units.                                                |
| [hasPath](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent-hasPath.html)                                 | Does the agent currently have a path? (Read Only)                                                                         |
| [height](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent-height.html)                                   | The height of the agent for purposes of passing under obstacles, etc.                                                     |
| [isOnNavMesh](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent-isOnNavMesh.html)                         | Is the agent currently bound to the navmesh? (Read Only)                                                                  |
| [isOnOffMeshLink](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent-isOnOffMeshLink.html)                 | Is the agent currently positioned on an OffMeshLink? (Read Only)                                                          |
| [isPathStale](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent-isPathStale.html)                         | Is the current path stale. (Read Only)                                                                                    |
| [isStopped](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent-isStopped.html)                             | Use this property to set, or get, whether the NavMesh agent stops or continues its movement along the current path.       |
| [navMeshOwner](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent-navMeshOwner.html)                       | Returns the owning object of the NavMesh the agent is currently placed on (Read Only).                                    |
| [nextOffMeshLinkData](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent-nextOffMeshLinkData.html)         | The next OffMeshLinkData on the current path.                                                                             |
| [nextPosition](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent-nextPosition.html)                       | Gets or sets the simulation position of the navmesh agent.                                                                |
| [obstacleAvoidanceType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent-obstacleAvoidanceType.html)     | The level of quality of avoidance.                                                                                        |
| [path](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent-path.html)                                       | Property to get and set the current path.                                                                                 |
| [pathPending](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent-pathPending.html)                         | Is a path in the process of being computed but not yet ready? (Read Only)                                                 |
| [pathStatus](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent-pathStatus.html)                           | The status of the current path (complete, partial or invalid).                                                            |
| [radius](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent-radius.html)                                   | The avoidance radius for the agent.                                                                                       |
| [remainingDistance](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent-remainingDistance.html)             | The distance between the agent's position and the destination on the current path. (Read Only)                            |
| [speed](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent-speed.html)                                     | Maximum movement speed when following a path.                                                                             |
| [steeringTarget](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent-steeringTarget.html)                   | Get the current steering target along the path. (Read Only)                                                               |
| [stoppingDistance](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent-stoppingDistance.html)               | Stop within this distance from the target position.                                                                       |
| [updatePosition](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent-updatePosition.html)                   | Gets or sets whether the transform position is synchronized with the simulated agent position. The default value is true. |
| [updateRotation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent-updateRotation.html)                   | Should the agent update the transform orientation?                                                                        |
| [updateUpAxis](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent-updateUpAxis.html)                       | Allows you to specify whether the agent should be aligned to the up-axis of the NavMesh or link that it is placed on.     |
| [velocity](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent-velocity.html)                               | Access the current velocity of the NavMeshAgent component, or set a velocity to control the agent manually.               |

### Public Methods

| Method                                                                                                                                      | Description                                                                             |
|---------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------|
| [ActivateCurrentOffMeshLink](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent.ActivateCurrentOffMeshLink.html) | Enables or disables the current off-mesh link.                                          |
| [CalculatePath](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent.CalculatePath.html)                           | Calculate a path to a specified point and store the resulting path.                     |
| [CompleteOffMeshLink](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent.CompleteOffMeshLink.html)               | Completes the movement on the current OffMeshLink.                                      |
| [FindClosestEdge](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent.FindClosestEdge.html)                       | Locate the closest NavMesh edge.                                                        |
| [GetAreaCost](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent.GetAreaCost.html)                               | Gets the cost for path calculation when crossing area of a particular type.             |
| [Move](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent.Move.html)                                             | Apply relative movement to current position.                                            |
| [Raycast](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent.Raycast.html)                                       | Trace a straight path towards a target postion in the NavMesh without moving the agent. |
| [ResetPath](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent.ResetPath.html)                                   | Clears the current path.                                                                |
| [SamplePathPosition](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent.SamplePathPosition.html)                 | Sample a position along the current path.                                               |
| [SetAreaCost](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent.SetAreaCost.html)                               | Sets the cost for traversing over areas of the area type.                               |
| [SetDestination](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent.SetDestination.html)                         | Sets or updates the destination thus triggering the calculation for a new path.         |
| [SetPath](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent.SetPath.html)                                       | Assign a new path to this agent.                                                        |
| [Warp](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent.Warp.html)                                             | Warps agent to the provided position.                                                   |

### Inherited Members

### Properties

| Property                                                                                                              | Description                                                                                                                                    |
|-----------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------|
| [enabled](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Behaviour-enabled.html)                       | True if this Behaviour is enabled, otherwise false.                                                                                            |
| [isActiveAndEnabled](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Behaviour-isActiveAndEnabled.html) | Checks whether a component is enabled, attached to a GameObject that is active in the hierarchy, and the component's OnEnable has been called. |
| [gameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component-gameObject.html)                 | The game object this component is attached to. A component is always attached to a game object.                                                |
| [tag](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component-tag.html)                               | The tag of this game object.                                                                                                                   |
| [transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component-transform.html)                   | The Transform attached to this GameObject.                                                                                                     |
| [transformHandle](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component-transformHandle.html)       | The TransformHandle of this GameObject.                                                                                                        |
| [hideFlags](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-hideFlags.html)                      | Controls whether the object is hidden, saved with the scene, and editable by the user.                                                         |
| [name](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-name.html)                                | The name of the object.                                                                                                                        |

### Public Methods

| Method                                                                                                                          | Description                                                                                                                      |
|---------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------|
| [BroadcastMessage](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.BroadcastMessage.html)               | Calls the method named methodName on every MonoBehaviour in this game object or any of its children.                             |
| [CompareTag](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.CompareTag.html)                           | Checks the GameObject's tag against the defined tag.                                                                             |
| [GetComponent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponent.html)                       | Gets a reference to a component of type T on the same GameObject as the component specified.                                     |
| [GetComponentInChildren](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponentInChildren.html)   | Gets a reference to a component of type T on the same GameObject as the component specified, or any child of the GameObject.     |
| [GetComponentIndex](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponentIndex.html)             | Gets the index of the component on its parent GameObject.                                                                        |
| [GetComponentInParent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponentInParent.html)       | Gets a reference to a component of type T on the same GameObject as the component specified, or any parent of the GameObject.    |
| [GetComponents](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponents.html)                     | Gets references to all components of type T on the same GameObject as the component specified.                                   |
| [GetComponentsInChildren](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponentsInChildren.html) | Gets references to all components of type T on the same GameObject as the component specified, and any child of the GameObject.  |
| [GetComponentsInParent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponentsInParent.html)     | Gets references to all components of type T on the same GameObject as the component specified, and any parent of the GameObject. |
| [SendMessage](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.SendMessage.html)                         | Calls the method named methodName on every MonoBehaviour in this game object.                                                    |
| [SendMessageUpwards](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.SendMessageUpwards.html)           | Calls the method named methodName on every MonoBehaviour in this game object and on every ancestor of the behaviour.             |
| [TryGetComponent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.TryGetComponent.html)                 | Gets the component of the specified type, if it exists.                                                                          |
| [GetHashCode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.GetHashCode.html)                            | Returns the hash code for the object.                                                                                            |
| [GetInstanceID](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.GetInstanceID.html)                        | Gets the instance ID of the object.                                                                                              |
| [ToString](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.ToString.html)                                  | Returns the name of the object.                                                                                                  |

### Static Methods

| Method                                                                                                                   | Description                                                                                                                                                 |
|--------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Destroy](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.Destroy.html)                             | Removes a GameObject, component, or asset.                                                                                                                  |
| [DestroyImmediate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.DestroyImmediate.html)           | Destroys the specified object immediately. Use with caution and in Edit mode only.                                                                          |
| [DontDestroyOnLoad](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.DontDestroyOnLoad.html)         | Do not destroy the target Object when loading a new Scene.                                                                                                  |
| [FindAnyObjectByType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindAnyObjectByType.html)     | Retrieves any active loaded object of Type T.                                                                                                               |
| [FindFirstObjectByType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindFirstObjectByType.html) | Retrieves the first active loaded object of Type type.                                                                                                      |
| [FindObjectsByType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindObjectsByType.html)         | Retrieves a list of all loaded objects of Type type and sorts the results according to sortMode.                                                            |
| [Instantiate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.Instantiate.html)                     | Clones the object original and returns the clone.                                                                                                           |
| [InstantiateAsync](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.InstantiateAsync.html)           | Captures a snapshot of the original object that's related to another GameObject and obtains an AsyncInstantiateOperation instance of the resulting objects. |

### Operators

| Operator                                                                                             | Description                                                             |
|------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------|
| [bool](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-operator_Object.html)    | Determines whether the object exists.                                   |
| [operator !=](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-operator_ne.html) | Compares if two objects refer to a different object.                    |
| [operator ==](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-operator_eq.html) | Compares two object references to see if they refer to the same object. |
