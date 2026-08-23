---
title: "Tell a NavMesh agent to move to a destination"
page_title: "Tell a NavMeshAgent to Move to a Destination | AI Navigation | 2.0.14"
source_url: "https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/NavMoveToDestination.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/NavMoveToDestination.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Tell a NavMeshAgent to Move to a Destination

You can tell an agent to start calculating a path simply by setting the [NavMeshAgent.destination](https://docs.unity3d.com/6000.0/Documentation/ScriptReference/AI.NavMeshAgent-destination.html) property with the point you want the agent to move to. As soon as the calculation is finished, the agent will automatically move along the path until it reaches its destination. The following code implements a simple class that uses a [**GameObject**](https://docs.unity3d.com/6000.0/Documentation/Manual/class-GameObject.html "The fundamental object in Unity scenes, which can represent characters, props, scenery, cameras, waypoints, and more. A GameObject’s functionality is defined by the Components attached to it.") to mark the target point which gets assigned to the *destination* property in the *Start* function. Note that the script assumes you have already added and configured the NavMeshAgent component from the editor.

``` lang-C#
    // MoveDestination.cs
    using UnityEngine;
    using UnityEngine.AI;

    public class MoveDestination : MonoBehaviour 
    }
```
