---
title: "Make an agent patrol between a set of points"
page_title: "Make an Agent Patrol Between a Set of Points | AI Navigation | 2.0.14"
source_url: "https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/NavAgentPatrol.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/NavAgentPatrol.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Make an Agent Patrol Between a Set of Points

Many games feature NPCs that patrol automatically around the playing area. The navigation system can be used to implement this behavior but it is slightly more involved than standard pathfinding - merely using the shortest path between two points makes for a limited and predictable patrol route. You can get a more convincing patrol pattern by keeping a set of key points that are “useful” for the NPC to pass through and visiting them in some kind of sequence. For example, in a maze, you might place the key patrol points at junctions and corners to ensure the agent checks every corridor. For an office building, the key points might be the individual offices and other rooms.

![A maze with key patrol points marked](https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/images/NavPatrolMaze.svg)

A maze with key patrol points marked

The ideal sequence of patrol points depends on the way you want the NPCs to behave. For example, a robot would probably just visit the points in a methodical order while a human guard might try to catch the player out by using a more random pattern. You can implement the simple behavior of the robot with the code shown below.

The patrol points are supplied to the script using a public array of Transforms. This array can be assigned from the [**inspector**](https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/Glossary.html#inspector "A Unity window that displays information about the currently selected GameObject, asset or project settings, allowing you to inspect and edit the values.") using [**GameObjects**](https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/Glossary.html#gameobject "The fundamental object in Unity scenes, which can represent characters, props, scenery, cameras, waypoints, and more. A GameObject’s functionality is defined by the Components attached to it.") to mark the points’ positions. The *GotoNextPoint* function sets the destination point for the agent (which also starts it moving) and then selects the new destination that will be used on the next call. As it stands, the code cycles through the points in the sequence they occur in the array but you can easily modify this, say by using [Random.Range](https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Random.Range.html) to choose an array index at random.

In the *Update* function, the script checks how close the agent is to the destination using the [remainingDistance](https://docs.unity3d.com/6000.0/Documentation/ScriptReference/AI.NavMeshAgent-remainingDistance.html) property. When this distance is very small, a call to *GotoNextPoint* is made to start the next leg of the patrol.

``` lang-C#
    // Patrol.cs
    using UnityEngine;
    using UnityEngine.AI;
    using System.Collections;

    public class Patrol : MonoBehaviour 
        void GotoNextPoint() 
        void Update () 
    }
```
