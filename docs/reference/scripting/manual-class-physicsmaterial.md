---
title: "Unity 6.3 Manual: Physics Material asset reference"
page_title: "Unity - Manual: Physics Material asset reference"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-PhysicsMaterial.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-PhysicsMaterial.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Physics Material asset reference

<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PhysicsMaterial.html" class="switch-link gray-btn sbtn left" title="Go to PhysicsMaterial page in the Scripting Reference">Switch to Scripting</a>

The **Physics Material** is a material asset that you can place on a GameObject. The material defines properties on the collider’s surface, such as friction and bounciness.

To create a Physics Material, go to **Assets** \> **Create** \> **Physics Material**, then drag the Physics Material from the Project window onto a collider in the scene.

If there is no Physics Material set, a collider uses the default surface settings. To adjust the project’s default settings, use the [Physics Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PhysicsManager.html).

<table><thead><tr class="header"><th style="text-align: left;"><strong>Property</strong></th><th style="text-align: left;"><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Dynamic Friction</strong></td><td style="text-align: left;">Define how much friction the collider’s surface has against another collider when the colliders are moving or sliding against each other. This value is between 0 and 1. A value of 0 means no friction (like ice), while a value of 1 means very high friction (like rubber). By default, <strong>Dynamic Friction</strong> is set to 0.6.<br />
<br />
Unity uses the friction value of both touching colliders to calculate the friction between them, based on the <strong>Friction Combine</strong> property (below).</td></tr><tr class="even"><td style="text-align: left;"><strong>Static Friction</strong></td><td style="text-align: left;">Define how much friction the collider’s surface has against another collider when the colliders are not moving. This value is between 0 and 1. A value of 0 means no friction (like ice), while a value of 1 means very high friction (like rubber). By default, <strong>Static Friction</strong> is set to 0.6.<br />
<br />
Unity uses the friction value of both touching colliders to calculate the friction between them, based on the <strong>Friction Combine</strong> property (below).</td></tr><tr class="odd"><td style="text-align: left;"><strong>Bounciness</strong></td><td style="text-align: left;">Define how bouncy the surface is, and how much other colliders can bounce off it. A value of 0 means the surface is not at all bouncy (like soft clay), and other colliders lose kinetic energy upon hitting it. A value of 1 means the surface is very bouncy (like rubber), and other colliders bounce without any loss of kinetic energy. By default, <strong>Bounciness</strong> is set to 0.<br />
<br />
Unity uses the bounciness value of both touching colliders to calculate the bounce between them, based on the <strong>Bounce Combine</strong> property.<br />
<br />
Note that the physics system’s bounce approximations might still add small amounts of energy to the simulation.</td></tr><tr class="even"><td style="text-align: left;"><strong>Friction Combine</strong></td><td style="text-align: left;">Define how the physics system calculates friction between two colliders, based on each collider’s friction. This selection applies to both Dynamic Friction and Static Friction. By default, <strong>Friction Combine</strong> is set to <strong>Average</strong>. For details, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/collider-surfaces-combine.html">How collider surface values combine</a>.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Bounce Combine</strong></td><td style="text-align: left;">Define how the physics system calculates bounce between two colliders, based on each collider’s <strong>Bounciness</strong> value. By default, <strong>Bounce Combine</strong> is set to <strong>Average</strong>. For details, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/collider-surfaces-combine.html">How collider surface values combine</a>.</td></tr></tbody></table>
