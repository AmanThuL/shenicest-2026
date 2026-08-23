---
title: "Continuous collision detection (CCD)"
page_title: "Unity - Manual: Continuous collision detection (CCD)"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/ContinuousCollisionDetection.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/ContinuousCollisionDetection.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Continuous collision detection (CCD)

Continuous collision detection (CCD) modes use predictive algorithms to calculate collisions that happen between physics timesteps. They are more accurate, but usually require more computational resources than discrete collision detection.

CCD is supported for Box, Sphere and Capsule colliders. It is intended as a safety net to catch collisions in cases where colliders would otherwise pass through each other. However, it does not always deliver physically accurate collision results, so you might still consider decreasing the physics timestep frequency to make the simulation more precise.

In Unity, there are two CCD algorithms, represented by three **Collision Detection** mode options.

| **Topic**                                                                                    | **Description**                                                                                                                        |
|:---------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------------------------|
| [Speculative CCD](https://docs.unity3d.com/6000.3/Documentation/Manual/speculative-ccd.html) | Learn about speculative collision detection. **Continuous Speculative** uses speculative collision detection.                          |
| [Sweep-based CCD](https://docs.unity3d.com/6000.3/Documentation/Manual/sweep-based-ccd.html) | Learn about sweep-based collision detection. Both **Continuous** and **Continuous Dynamic** modes use sweep-based collision detection. |
