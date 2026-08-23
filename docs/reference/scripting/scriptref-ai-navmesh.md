---
title: "Scripting API: AI.NavMesh"
page_title: "Unity - Scripting API: NavMesh"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMesh.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMesh.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# NavMesh

class in UnityEngine.AI

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

Singleton class to access the baked NavMesh.

Use the NavMesh class to perform spatial queries such as pathfinding and walkability tests. This class also lets you set the pathfinding cost for specific area types, and tweak the global behavior of pathfinding and avoidance.  
  
Before you can use spatial queries, you must first bake the NavMesh to your scene.  
  
See also:  
• [Create a NavMesh](https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/CreateNavMesh.html) – for more information on how to setup and bake NavMesh  
• [Areas and Costs](https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/AreasAndCosts.html) – to learn how to use different Area types.  
• [NavMeshAgent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent.html) – to learn how to control and move NavMesh Agents.  
• [NavMeshObstacle](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshObstacle.html) – to learn how to control NavMesh Obstacles using scripting.  
• [NavMeshLink](https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/api/Unity.AI.Navigation.NavMeshLink.html) – to learn how to control Off-Mesh Links using scripting.  

### Static Properties

| Property                                                                                                                                     | Description                                                                                       |
|----------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------|
| [AllAreas](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMesh.AllAreas.html)                                           | Area mask constant that includes all NavMesh areas.                                               |
| [avoidancePredictionTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMesh-avoidancePredictionTime.html)             | Describes how far in the future the agents predict collisions for avoidance.                      |
| [onPreUpdate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMesh-onPreUpdate.html)                                     | Set a function to be called before the NavMesh is updated during the frame update execution.      |
| [pathfindingIterationsPerFrame](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMesh-pathfindingIterationsPerFrame.html) | The maximum number of nodes processed for each frame during the asynchronous pathfinding process. |

### Static Methods

| Method                                                                                                                         | Description                                                                                                                                           |
|--------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------|
| [AddLink](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMesh.AddLink.html)                               | Adds a link to the NavMesh. The link is described by the NavMeshLinkData struct.                                                                      |
| [AddNavMeshData](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMesh.AddNavMeshData.html)                 | Adds the specified NavMeshData to the game.                                                                                                           |
| [CalculatePath](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMesh.CalculatePath.html)                   | Calculate a path between two points and store the resulting path.                                                                                     |
| [CalculateTriangulation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMesh.CalculateTriangulation.html) | Calculates a triangulation of all the NavMeshes that are present in the scene at the time of the call.                                                |
| [CreateSettings](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMesh.CreateSettings.html)                 | Creates and returns a new entry of NavMesh build settings available for runtime NavMesh building.                                                     |
| [FindClosestEdge](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMesh.FindClosestEdge.html)               | Locate the closest NavMesh edge from a point on the NavMesh.                                                                                          |
| [GetAreaCost](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMesh.GetAreaCost.html)                       | Gets the cost for path finding over geometry of the area type.                                                                                        |
| [GetAreaFromName](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMesh.GetAreaFromName.html)               | Returns the area index for a named NavMesh area type.                                                                                                 |
| [GetAreaNames](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMesh.GetAreaNames.html)                     | Get all the NavMesh area names.                                                                                                                       |
| [GetLinkOwner](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMesh.GetLinkOwner.html)                     | Gets the object, if any, that is associated with the link instance.                                                                                   |
| [GetSettingsByID](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMesh.GetSettingsByID.html)               | Returns an existing entry of NavMesh build settings.                                                                                                  |
| [GetSettingsByIndex](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMesh.GetSettingsByIndex.html)         | Returns an existing entry of NavMesh build settings by its ordered index.                                                                             |
| [GetSettingsCount](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMesh.GetSettingsCount.html)             | Returns the number of registered NavMesh build settings.                                                                                              |
| [GetSettingsNameFromID](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMesh.GetSettingsNameFromID.html)   | Returns the name associated with the NavMesh build settings matching the provided agent type ID.                                                      |
| [IsLinkActive](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMesh.IsLinkActive.html)                     | Determines whether the instance of the link can be used to calculate paths, and if NavMesh agents can move over it.                                   |
| [IsLinkOccupied](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMesh.IsLinkOccupied.html)                 | Determines whether or not a NavMesh agent is currently using this link.                                                                               |
| [IsLinkValid](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMesh.IsLinkValid.html)                       | Determines whether the link instance is part of the current data used for navigation.                                                                 |
| [Raycast](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMesh.Raycast.html)                               | Trace a line between two points on the NavMesh.                                                                                                       |
| [RemoveAllNavMeshData](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMesh.RemoveAllNavMeshData.html)     | Removes all NavMesh surfaces and links from the game.                                                                                                 |
| [RemoveLink](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMesh.RemoveLink.html)                         | Removes a link from the NavMesh.                                                                                                                      |
| [RemoveNavMeshData](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMesh.RemoveNavMeshData.html)           | Removes the specified NavMeshDataInstance from the game, making it unavailable for agents and queries.                                                |
| [RemoveSettings](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMesh.RemoveSettings.html)                 | Removes the build settings matching the agent type ID.                                                                                                |
| [SamplePosition](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMesh.SamplePosition.html)                 | Finds the nearest point based on the NavMesh within a specified range.                                                                                |
| [SetAreaCost](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMesh.SetAreaCost.html)                       | Sets the cost for finding path over geometry of the area type on all agents.                                                                          |
| [SetLinkActive](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMesh.SetLinkActive.html)                   | Activates or deactivates the link instance. An active link instance can be traversed by agents and used to plan paths, but a deactivated link cannot. |
| [SetLinkOwner](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMesh.SetLinkOwner.html)                     | Associates an object with the instance of a link.                                                                                                     |

### Delegates

| Delegate                                                                                                               | Description                                                                 |
|------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------|
| [OnNavMeshPreUpdate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMesh.OnNavMeshPreUpdate.html) | Registers callback methods to be invoked before the NavMesh system updates. |
