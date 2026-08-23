---
title: "Move static colliders to prevent performance issues"
page_title: "Unity - Manual: Move static colliders to prevent performance issues"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu-static-colliders.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu-static-colliders.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Move static colliders to prevent performance issues

Properly manage static colliders when they move to avoid performance issues.

A [Static collider](https://docs.unity3d.com/6000.3/Documentation/Manual/collider-types-introduction.html#static-colliders) is a GameObject with a Collider component but no Rigidbody or ArticulationBody component attached. You can use static colliders for objects that don’t move during gameplay, such as terrain, buildings, or other environmental features.

When you move a static collider by changing its transform values, the physics system detects the change and updates its internal spatial structures during the next physics step or when [`Physics.SyncTransforms`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.SyncTransforms.html) is called. If you want to make frequent changes to the transform values of a static collider between physics simulations steps when you execute gameplay code, use a Kinematic Rigidbody component instead.

If you want to move a static collider, the recommended best practice is that you don’t add a Rigidbody component to a static object solely to move that GameObject. If it doesn’t need a physics simulation, you’re adding an unnecessary performance burden.

## Additional resources

-   [Unity Profiler](https://docs.unity3d.com/6000.3/Documentation/Manual/Profiler.html)
-   [Managing time and frame rate](https://docs.unity3d.com/6000.3/Documentation/Manual/managing-time-and-frame-rate.html)
-   [Memory Profiler](https://docs.unity3d.com/Packages/com.unity.memoryprofiler@latest)
-   [Physics Project Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PhysicsManager.html)
-   [Introduction to collider types](https://docs.unity3d.com/6000.3/Documentation/Manual/collider-types-introduction.html)
