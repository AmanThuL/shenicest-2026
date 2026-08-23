---
title: "Create a NavMesh"
page_title: "Create a NavMesh | AI Navigation | 2.0.14"
source_url: "https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/CreateNavMesh.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/CreateNavMesh.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Create a NavMesh

You need to create a [**NavMesh**](https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/Glossary.html#navmesh "A mesh that Unity generates to approximate the walkable areas and obstacles in your environment for path finding and AI-controlled navigation.") to define an area of your scene within which a character can navigate intelligently.

To create a NavMesh do the following:

1.  Select the scene geometry where you want to add the NavMesh.
2.  In the Inspector window, click **Add Component**.
3.  Select **Navigation** > **NavMesh Surface**.
4.  In the NavMesh Surface component, specify the necessary settings. For details on the available settings, refer to [NavMesh Surface component](https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/NavMeshSurface.html).
5.  When you are finished, click **Bake**.  
    The NavMesh is generated and displayed in the scene as a blue overlay on the underlying scene geometry whenever the Navigation window is open and visible.

You can bake the NavMesh again to update it each time you make changes to either the scene geometry, the NavMesh [modifiers](https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/NavMeshModifier.html), the properties of the **NavMesh Surface** component, or [the settings](https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/NavigationWindow.html#agents-tab) of [the selected agent type](https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/NavMeshSurface.html#navmesh-surface-main-settings).

To permanently remove a NavMesh from your project, do one of the following:

-   Click the **Clear** button in the **NavMesh Surface** inspector.
-   Delete [the NavMesh asset file](https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/NavMeshSurface.html#navmesh-surface-asset-file) in the **Project** window. If you choose to remove the **NavMesh Surface** component itself from the GameObject, the asset file is not deleted, even though the NavMesh is no longer present in the scene.

## Additional resources

-   [Navigation window](https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/NavigationWindow.html)
-   [Create a NavMeshAgent](https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/CreateNavMeshAgent.html)
-   [NavMesh Surface component](https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/NavMeshSurface.html)
-   [Navigation Areas and Costs](https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/AreasAndCosts.html)
-   [Build a HeightMesh for Accurate Character Placement](https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/HeightMesh.html)
