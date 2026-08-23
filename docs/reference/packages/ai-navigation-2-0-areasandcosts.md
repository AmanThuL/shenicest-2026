---
title: "Navigation Areas and Costs"
page_title: "Navigation Areas and Costs | AI Navigation | 2.0.14"
source_url: "https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/AreasAndCosts.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/AreasAndCosts.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Navigation Areas and Costs

The **Navigation Area** defines how difficult it is to walk across a specific area. This is important for finding the path with the lowest total cost. In addition, each [NavMesh Agent](https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/NavMeshAgent.html) has an **Area Mask** which you can use to specify which areas the agent can move on.

![A scene with a door that only some agents can traverse, and a water area that is more expensive to walk through.](https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/images/NavMeshAreaType.svg)

In the example above the area types are used for two common use cases:

-   The **Water** area is made more costly to walk through by assigning it a higher cost, to deal with a scenario where walking in shallow water is slower.
-   The **Door** area is made accessible to specific characters, to create a scenario where humans can walk through doors, but zombies cannot.

You can assign the area type to every object that is included in the [**NavMesh**](https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/Glossary.html#navmesh "A mesh that Unity generates to approximate the walkable areas and obstacles in your environment for path finding and AI-controlled navigation.") baking. In addition, each **NavMesh Link** has a property to specify the area type.

## Pathfinding Cost

In a nutshell, the cost allows you to control which areas the pathfinder favors when finding a path. For example, if you set the cost of an area to 3.0, traveling across that area is considered to be three times longer than alternative routes.

To fully understand how the cost works, let’s take a look at how the pathfinder works.

![Nodes and links visited during pathfinding.](https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/images/NavMeshNodePositions.svg)

Nodes and links visited during pathfinding.

Unity uses A\* to calculate the shortest path on the NavMesh. A\* works on a graph of connected nodes. The algorithm starts from the nearest node to the path start and visits the connect nodes until the destination is reached.

Since the Unity navigation representation is a [**mesh**](https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/Glossary.html#mesh "The main graphics primitive of Unity. Meshes make up a large part of your 3D worlds. Unity supports triangulated or Quadrangulated polygon meshes. Nurbs, Nurms, Subdiv surfaces must be converted to polygons.") of polygons, the first thing the pathfinder needs to do is to place a point on each polygon, which is the location of the node. The shortest path is then calculated between these nodes.

The yellow dots and lines in the above picture shows how the nodes and links are placed on the NavMesh, and in which order they are traversed during the A\*.

The cost to move between two nodes depends on the distance to travel and the cost associated with the area type of the polygon under the link, that is, *distance \* cost*. In practice this means, that if the cost of an area is 2.0, the distance across such polygon will appear to be twice as long. The A\* algorithm requires that all costs must be larger than 1.0.

The effect of the costs on the resulting path can be hard to tune, especially for longer paths. The best way to approach costs is to treat them as hints. For example, if you want the agents to not use **NavMesh Links** too often, you could increase their cost. But it can be challenging to tune a behavior where the agents prefer to walk on sidewalks.

Another thing you may notice on some levels is that the pathfinder does not always choose the shortest path. The reason for this is the node placement. The effect can be noticeable in scenarios where big open areas are next to tiny obstacles, which results in a navigation mesh with very big and small polygons. In such cases the nodes on the big polygons may get placed anywhere in the big polygon and from the pathfinder’s point of view it looks like a detour.

The *cost* per *area type* can be set globally in the *Areas* tab, or you can override them per agent using a script.

## Area Types

![A table of areas, each showing their cost.](https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/images/NavMeshAreaTypeList.png)

The area types are specified in the *Navigation Window*’s *Areas* tab. There are 29 custom types, and 3 built-in types: *Walkable*, *Not Walkable*, and *Jump*.

-   **Walkable** is a generic area type which specifies that the area can be walked on.
-   **Not Walkable** is a generic area type which prevents navigation. It is useful for cases where you want to mark certain object to be an obstacle, but without getting NavMesh on top of it.
-   **Jump** is an area type that is assigned to all auto-generated **NavMesh Links**.

If several objects of different area types are overlapping, the resulting NavMesh area type will generally be the one with the highest index. There is one exception however: *Not Walkable* always takes precedence. Which can be helpful if you need to block out an area.

## Area Mask

![The Area Mask dropdown list, with four selected options: Walkable, Not Walkable, Jump, and Water.](https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/images/NavMeshAreaMask.svg)

Each agent has an *Area Mask* which describes which areas it can use when navigating. The area mask can be set in the agent properties, or the bitmask can be manipulated using a script at runtime.

The area mask is useful when you want only certain types characters to be able to walk through an area. For example, in a zombie evasion game, you could mark the area under each door with a *Door* area type, and uncheck the Door area from the zombie character’s Area Mask.

## Additional resources

-   [Create a NavMesh](https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/CreateNavMesh.html "Workflow to create a NavMesh.")
-   [NavMesh Modifier component reference](https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/NavMeshModifier.html "Use for affecting the NavMesh generation of NavMesh area types based on the transform hierarchy.")
-   [NavMesh Modifier Volume component reference](https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/NavMeshModifierVolume.html "Use for affecting the NavMesh generation of NavMesh area types based on volume.")
-   [NavMeshAgent.areaMask scripting reference](https://docs.unity3d.com/6000.0/Documentation/ScriptReference/AI.NavMeshAgent-areaMask.html "Script API to set which area types an agent can use for movement.")
-   [NavMeshAgent.SetAreaCost() scripting reference](https://docs.unity3d.com/6000.0/Documentation/ScriptReference/AI.NavMeshAgent.SetAreaCost.html "Script API to set what cost an agent considers for each area type.")
