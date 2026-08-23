---
title: "Configure Mesh Collider component cooking options for optimization"
page_title: "Unity - Manual: Configure Mesh Collider component cooking options for optimization"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu-mesh-cooking-options.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu-mesh-cooking-options.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Configure Mesh Collider component cooking options for optimization

Optimize physics calculations by configuring the cooking options for Mesh Collider components.

When you select a GameObject with a Mesh Collider component in the Editor, you can modify the **Cooking Options** property in the Inspector window. Set this property to define how to process this mesh for physics calculations. Cooking options affect both cooking time and runtime performance. You can select more than one of the available options to combine them.

When you set the **Cooking Options** property for a component, you define how to cook that particular mesh. To learn more about how to set options for cooking meshes for the whole simulation, refer to [Prepare meshes for mesh colliders](https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu-collider-types.html#prepare-meshes-for-mesh-colliders).

To learn about what properties are available for the Mesh Collider component, refer to [Mesh collider component reference](https://docs.unity3d.com/6000.3/Documentation/Manual/class-MeshCollider.html).

The cooking options are:

-   **None**: Disables all **Cooking Options** and provides the standard cooking behavior. **None** is disabled by default. When cooking occurs at runtime, such as for a procedurally generated mesh that hasn’t been pre-cooked, using **None** sets the most basic cooking process.
-   **Everything**: Enables all **Cooking Options**. This is enabled by default.
-   **Cook For Faster Simulation**: Performs additional processing during cooking to optimize the mesh for faster collision detection at runtime. When cooking occurs at runtime, enabling this can significantly increase the initial cooking time (a CPU spike), but it often leads to better performance during the physics simulation itself, especially for complex meshes that are frequently involved in collisions. This is a trade-off: longer load and setup time for smoother gameplay.
-   **Enable Mesh Cleaning**: Cleans up imperfections in the mesh geometry, such as tiny triangles or nearly co-located vertices. Enabling **Enable Mesh Cleaning** increases runtime cooking time. However, a cleaner mesh can lead to more stable and robust collision detection at runtime, potentially preventing physics glitches or unexpected behavior that would otherwise use more CPU cycles to resolve. This option is useful for meshes that have been generated or imported with flaws.
-   **Weld Colocated Vertices**: Similar to **Enable Mesh Cleaning**, **Weld Colocated Vertices** merges vertices that are very close to each other. While enabling **Weld Colocated Vertices** increases runtime cooking time, it can improve runtime performance by simplifying the mesh and reducing the number of vertices the physics system needs to process for collision checks.
-   **Use Fast Midphase**: Uses a faster, but potentially less precise, mid-phase algorithm for collision detection. Enabling this can improve performance for certain types of meshes by speeding up the collision query process. However, it might slightly reduce the precision of collision detection, which might affect highly sensitive physics interactions.

The recommended best practices to configure Mesh Collider cooking options are:

-   Always use relatively low-poly, closed (watertight), and clean meshes with no degenerate triangles or overlapping vertices for Mesh Collider components. This approach reduces cooking time and improves runtime performance.
-   Use the [**Unity Profiler**](https://docs.unity3d.com/6000.3/Documentation/Manual/Profiler.html) to determine if unexpected mesh cooking occurs at runtime.

The recommended performance tips for using Mesh Collider components in general are:

-   Always favor primitive colliders (Sphere, Capsule, Box) for dynamic (moving) or frequently updated objects.
-   Use non-convex Mesh Collider components only for static environmental geometry where high-fidelity collision is essential.
-   For dynamic objects that require complex shapes, prefer convex Mesh Collider components or compound colliders over non-convex ones.
-   Minimize the complexity of meshes used for Mesh Collider components.

To evaluate Mesh Collider performance:

-   Profile: Use the [**Unity Profiler**](https://docs.unity3d.com/6000.3/Documentation/Manual/Profiler.html). Focus on narrow phase processing and Physics solve times when the object with the Mesh Collider is actively colliding. High values can indicate a Mesh Collider that is resource-intensive. Also, watch for runtime mesh cooking spikes if meshes aren’t pre-cooked.

-   A/B test: Compare performance. Create a test scenario with your GameObject that has the Mesh Collider attached. Then, create a version of the same GameObject that has a [compound collider](https://docs.unity3d.com/6000.3/Documentation/Manual/compound-colliders.html) approximation attached. Test both under identical collision conditions, and compare Profiler data.

-   Consider alternatives: If a Mesh Collider is affecting performance, consider alternatives:

-   Separate the graphic representation of the mesh from its physics representation to simplify its mesh. You might want to use different GameObjects so the physics system can use a separate, simplified mesh. For more information, refer to [Prepare meshes for mesh colliders](https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu-collider-types.html#prepare-meshes-for-mesh-colliders).

-   If you have dynamic objects, consider using a compound collider to achieve collision fidelity.

-   Remember that for dynamic Rigidbody and Mesh Collider components, they must be convex. If concave dynamic collision is needed, compound colliders are the standard approach.

## Additional resources

-   [Unity Profiler](https://docs.unity3d.com/6000.3/Documentation/Manual/Profiler.html)
-   [Managing time and frame rate](https://docs.unity3d.com/6000.3/Documentation/Manual/managing-time-and-frame-rate.html)
-   [Memory Profiler](https://docs.unity3d.com/Packages/com.unity.memoryprofiler@latest)
-   [Physics Project Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PhysicsManager.html)
-   [Mesh collider component reference](https://docs.unity3d.com/6000.3/Documentation/Manual/class-MeshCollider.html)
-   [Compound colliders](https://docs.unity3d.com/6000.3/Documentation/Manual/compound-colliders.html)
