---
title: "Choose a collision detection mode"
page_title: "Unity - Manual: Choose a collision detection mode"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/choose-collision-detection-mode.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/choose-collision-detection-mode.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Choose a collision detection mode

**Collision Detection** defines which algorithm the physics body (Rigidbody or ArticulationBody) uses to detect collisions. Different algorithms offer different levels of accuracy, but more accurate algorithms require more computational resources.

There are three algorithms available, represented by four collision detection modes:

<table><thead><tr class="header"><th style="text-align: left;"><strong>Collision detection mode</strong></th><th style="text-align: left;"><strong>Algorithm</strong></th><th style="text-align: left;"><strong>Useful for</strong></th><th style="text-align: left;"><strong>Not useful for</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Discrete</strong></td><td style="text-align: left;">Discrete</td><td style="text-align: left;">- Slow-moving collisions.</td><td style="text-align: left;">- Fast-moving collisions.</td></tr><tr class="even"><td style="text-align: left;"><strong>Continuous Speculative</strong></td><td style="text-align: left;">Speculative CCD</td><td style="text-align: left;">- Fast-moving collisions.</td><td style="text-align: left;">- Some fast-moving collisions that require an especially high degree of accuracy.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Continuous</strong></td><td style="text-align: left;">Sweep CCD</td><td style="text-align: left;">- Fast-moving linear collisions that require a high degree of accuracy.<br />
- Physics bodies that only collide with static colliders.</td><td style="text-align: left;">- Collisions that happen as a result of the physics body rotating.<br />
- Physics bodies that collide with moving colliders.</td></tr><tr class="even"><td style="text-align: left;"><strong>Continuous Dynamic</strong></td><td style="text-align: left;">Sweep CCD</td><td style="text-align: left;">- Fast-moving linear collisions that require a high degree of accuracy.<br />
- Physics bodies that collide with moving colliders.</td><td style="text-align: left;">- Collisions that happen as a result of the physics body rotating.</td></tr></tbody></table>

The following decision flow might provide a starting point for selecting a collision detection type. It starts with the least computationally intensive mode, and progresses to the most computationally intensive mode.

1.  Try **Discrete** first.
2.  If you notice missed collisions in **Discrete** mode, try **Continuous Speculative**.
3.  If you notice missed collisions or false collisions in **Continuous Speculative** mode, try **Continuous** for collisions with static colliders, or **Continuous Dynamic** for collisions with dynamic Rigidbody colliders.

In some cases, you might find that the physics performance relies on a combination of the collision detection mode and the physics timestep frequency. Experiment with both and profile the results to find the right solution for your project.

## Select a collision detection mode

To select an algorithm, set the physics body’s **Collision Detection** property in one of the following ways:

-   In the Editor: On the Rigidbody or Articulation Body component Inspector, change the **Collision Detection** property.
-   In code: Use the API properties [Rigidbody.collisionDetectionMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody-collisionDetectionMode.html) and [ArticulationBody.collisionDetectionMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ArticulationBody-collisionDetectionMode.html).
