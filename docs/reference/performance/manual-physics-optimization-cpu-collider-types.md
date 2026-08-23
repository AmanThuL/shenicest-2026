---
title: "Collider types and performance"
page_title: "Unity - Manual: Collider types and performance"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu-collider-types.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu-collider-types.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Collider types and performance

Optimize CPU performance by selecting the most appropriate collider type for your scene.

Choosing the right collider type directly affects CPU performance. Unity has several collider types, each with different computational costs.

To learn more about **Mesh Collider** component properties, refer to [Mesh collider component reference](https://docs.unity3d.com/6000.3/Documentation/Manual/class-MeshCollider.html).

To learn more about collider interactions, refer to [Collider interactions](https://docs.unity3d.com/6000.3/Documentation/Manual/collider-interactions.html).

The following table summarizes the collider types and their performance characteristics in order from most to least performant:

| **Collider type**            | **Performance characteristics**                                                                                                                                                                                                                       |
|:-----------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Sphere Collider**          | The simplest and most efficient collider. Use for round objects and general-purpose interactions.                                                                                                                                                     |
| **Capsule Collider**         | Slightly more complex than a Sphere Collider, but still efficient. Use for characters, poles, or other elongated shapes.                                                                                                                              |
| **Box Collider**             | Efficient and flexible, especially for rectangular or block-shaped objects. Slightly more resource-intensive than Sphere Collider or Capsule Collider.                                                                                                |
| **Convex Mesh Collider**     | More resource-intensive than primitive colliders. Use only when primitive shapes or compound colliders cannot approximate the geometry. The mesh must be convex. You can attach this to GameObjects with non-kinematic Rigidbody components attached. |
| **Non-convex Mesh Collider** | A Mesh Collider with **Convex** unchecked. The most resource-intensive collider type. Use only for static, non-moving geometry that requires precise collision surfaces. Cannot be attached to non-kinematic Rigidbodies.                             |

## Compound colliders

[Compound colliders](https://docs.unity3d.com/6000.3/Documentation/Manual/compound-colliders.html) are formed by parenting multiple primitive colliders, such as Sphere, Box, and Capsule colliders, to a single GameObject with a Rigidbody component. You can use compound colliders, which are comprised of simple components, to approximate complex shapes. Compound colliders are generally more efficient than using a single, complex Mesh Collider for a dynamic object, but they’re more resource-intensive than a single primitive collider.

Use as few primitive colliders as possible within a compound setup to have effective collision detection.

To learn more about compound colliders, refer to [Compound colliders](https://docs.unity3d.com/6000.3/Documentation/Manual/compound-colliders.html).

Use Compound colliders when:

-   You have an object whose shape cannot be accurately represented by a single primitive collider.
-   You have dynamic objects that require a complex collision shape but must remain performant (as an alternative to a costly convex Mesh Collider).
-   You need dynamic concave collision shapes, which a single Mesh Collider on a dynamic `Rigidbody` cannot do because a single Mesh Collider must be convex.
-   You need fine-tuned collision zones for gameplay. For example you have distinct head, torso, or limb hitboxes on a character.

<span id="prepare-meshes-for-mesh-colliders"></span>

## Prepare meshes for mesh colliders

[Mesh Collider components](https://docs.unity3d.com/6000.3/Documentation/Manual/mesh-colliders.html) require a preprocessing step called “mesh cooking” to convert their geometry into an optimized format for efficient physics calculations. If this cooking occurs at runtime, it can cause significant CPU performance spikes.

To learn more about Mesh Collider components, refer to [Mesh colliders](https://docs.unity3d.com/6000.3/Documentation/Manual/mesh-colliders.html).

You can avoid mesh cooking at runtime by doing the following:

-   Use Editor-Time cooking (Implicit): The primary way to pre-cook meshes is in the Editor. When you assign a Mesh asset to a Mesh Collider component in the Inspector window and save your scene or prefab, the Editor automatically cooks the mesh for that specific collider instance. The cooked data is then saved with your asset.
-   Enable Prebake Collision Meshes in the Player section of the Project Settings: Enable **Prebake Collision Meshes** to make the Editor proactively find and cook all meshes used by Mesh Collider components in your project during builds, asset imports, and Editor loads. This setting is enabled by default. **Prebake Collision Meshes** can increase build times and Editor load times as the meshes process. The cooked data is stored, which slightly affects build size if many unique meshes are involved, but the main trade-off is increased build and load duration versus runtime stability. Use **Prebake Collision Meshes** to prevent unexpected runtime cooking spikes by ensuring most meshes are ready. The recommended best practice is to keep **Prebake Collision Meshes** enabled as a safety net. Consider disabling **Prebake Collision Meshes** only if you manually and meticulously manage all mesh cooking. For example, you rely solely on Editor-time instance cooking and `Physics.BakeMesh` for all dynamic cases and you want to potentially reduce build and Editor processing times.
-   Use [`Physics.BakeMesh`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.BakeMesh.html): For meshes assigned or procedurally generated at runtime, use `Physics.BakeMesh(meshInstanceId, convex, cookingOptions)` to explicitly control when cooking occurs. Preferably use `Physics.BakeMesh` during loading screens or in background threads if you use the [job system](https://docs.unity3d.com/6000.3/Documentation/Manual/job-system-overview.html).

# Additional resources

-   [Unity Profiler](https://docs.unity3d.com/6000.3/Documentation/Manual/Profiler.html)
-   [Managing time and frame rate](https://docs.unity3d.com/6000.3/Documentation/Manual/managing-time-and-frame-rate.html)
-   [Memory Profiler](https://docs.unity3d.com/Packages/com.unity.memoryprofiler@latest)
-   [Physics Project Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PhysicsManager.html)
-   [Mesh collider component reference](https://docs.unity3d.com/6000.3/Documentation/Manual/class-MeshCollider.html)
-   [Collider interactions](https://docs.unity3d.com/6000.3/Documentation/Manual/collider-interactions.html)
-   [Compound colliders](https://docs.unity3d.com/6000.3/Documentation/Manual/compound-colliders.html)
-   [Mesh colliders](https://docs.unity3d.com/6000.3/Documentation/Manual/mesh-colliders.html)
