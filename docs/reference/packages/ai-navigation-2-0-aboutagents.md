---
title: "About Agents"
page_title: "About NavMesh agents | AI Navigation | 2.0.14"
source_url: "https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/AboutAgents.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/AboutAgents.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# About NavMesh agents

The NavMesh agent is a [GameObject](https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/Glossary.html#gameobject "The fundamental object in Unity scenes, which can represent characters, props, scenery, cameras, waypoints, and more.") that is represented by an upright cylinder whose size is specified by the Radius and Height properties. The cylinder moves with the GameObject, but remains upright even if the GameObject rotates. The shape of the cylinder is used to detect and respond to collisions with other agents and obstacles. When the anchor point of the GameObject is not at the base of the cylinder, use the Base Offset property to specify the height difference.

![How the anchor point and base offset work together](https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/images/NavMeshAgentOffset.svg)

The height and radius of the cylinder are specified in the [Navigation window](https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/NavigationWindow.html) and the [NavMesh Agent component](https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/NavMeshAgent.html) properties of the individual agents.

-   **Navigation window settings** describe how all the NavMesh Agents collide and avoid static world geometry. To keep memory on budget and CPU load at a reasonable level, you can only specify one size in the bake settings.
-   **NavMesh Agent component properties** values describe how the agent collides with moving obstacles and other agents.

Typically you set the size of the agent with the same values in both places. However, you might, give a heavy soldier a larger radius, so that other agents leave more space around your soldier. Otherwise, your soldier avoids the environment in the same manner as the other agents.

## Additional resources

-   [Create a NavMesh Agent](https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/CreateNavMeshAgent.html)
-   [NavMesh Agent component reference](https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/NavMeshAgent.html)
-   [NavMesh Agent scripting reference](ScriptRef:AI.NavMeshAgent)
-   [Navigation Agent Types](https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/NavigationWindow.html#agents-tab)
-   [Build a HeightMesh for Accurate Character Placement](https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/HeightMesh.html)
