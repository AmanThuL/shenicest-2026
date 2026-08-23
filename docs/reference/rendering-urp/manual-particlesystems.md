---
title: "Unity 6.3 Manual: Particle effects"
page_title: "Unity - Manual: Particle effects"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/ParticleSystems.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/ParticleSystems.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Particle effects

A particle system simulates and renders many small images or Meshes, called particles, to produce a visual effect. Each particle in a system represents an individual graphical element in the effect. The system simulates every particle collectively to create the impression of the complete effect.

![The holo table in Unity’s Spaceship demo. Made with the Visual Effect Graph.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/ParticleSystems-HoloTable.png)

Particle systems are useful when you want to create dynamic objects like fire, smoke, or liquids because it is difficult to depict this kind of object with a Mesh (3D) or Sprite (2D). Meshes and Sprites are better at depicting solid objects such as a house or a car.

This section contains information on:

| **Topic**                                                                                                                                                   | **Description**                                                                             |
|:------------------------------------------------------------------------------------------------------------------------------------------------------------|:--------------------------------------------------------------------------------------------|
| **[Choosing your particle system solution](https://docs.unity3d.com/6000.3/Documentation/Manual/ChoosingYourParticleSystem.html)**                          | Compare Unity’s particle systems: the Built-in Particle System and the Visual Effect Graph. |
| **[Create and view a Particle System](https://docs.unity3d.com/6000.3/Documentation/Manual/PartSysUsage.html)**                                             | Add a Particle System component to a GameObject and preview it in the Scene view.           |
| **[Vary Particle System properties over time](https://docs.unity3d.com/6000.3/Documentation/Manual/varying-particle-system-properties-over-time.html)**     | Use constants and curves to animate numeric properties throughout a particle’s lifetime.    |
| **[Configuring particles](https://docs.unity3d.com/6000.3/Documentation/Manual/configuring-particles.html)**                                                | Configure emissions, global properties, movement, appearance, and physics.                  |
| **[Optimize the Particle System with the C# Job System](https://docs.unity3d.com/6000.3/Documentation/Manual/particle-system-job-system-integration.html)** | Apply custom behaviors across multiple threads using Unity’s C# Job System.                 |
| **[Access the Particle System from the Animation system](https://docs.unity3d.com/6000.3/Documentation/Manual/access-particle-system-from-animation.html)** | Use the Animator component to keyframe particle properties.                                 |
| **[Particle System component reference](https://docs.unity3d.com/6000.3/Documentation/Manual/class-ParticleSystem.html)**                                   | Reference for the base properties of the Particle System component.                         |
| **[Particle System component module reference](https://docs.unity3d.com/6000.3/Documentation/Manual/ParticleSystemModules.html)**                           | Reference for the property modules that define particle behavior and appearance.            |

## Additional resources

-   [Decals](https://docs.unity3d.com/6000.3/Documentation/Manual/visual-effects-decals.html)
-   [Lens flares](https://docs.unity3d.com/6000.3/Documentation/Manual/visual-effects-lens-flares.html)
