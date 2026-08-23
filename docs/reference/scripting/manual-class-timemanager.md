---
title: "Time (project settings)"
page_title: "Unity - Manual: Time"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-TimeManager.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-TimeManager.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Time

Use **Time** settings to set properties that control timing within your game. To access **Time** settings, go to **Edit \> Project Settings \> Time**.

![The Time Project Settings](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/TimeSet.png)

## Properties

| **Property**                  | **Description**                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
|:------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Fixed Timestep**            | A frame rate independent interval that dictates when physics calculations and `FixedUpdate`events are performed.                                                                                                                                                                                                                                                                                                                                                              |
| **Maximum Allowed Timestep**  | A frame rate independent interval that caps the worst case scenario when frame rate is low. Physics calculations and `FixedUpdate` events will not be performed for longer time than specified.                                                                                                                                                                                                                                                                               |
| **Time Scale**                | The speed at which time progresses. Change this value to simulate slow motion effects. A value of 1 means real-time. A value of 0.5 means half speed; a value of 2 is double speed.                                                                                                                                                                                                                                                                                           |
| **Maximum Particle Timestep** | A frame rate independent interval that controls the accuracy of the particle simulation. When the frame time exceeds this value, multiple iterations of the particle update are performed in one frame, so that the duration of each step does not exceed this value. For example, a game running at 30fps (0.03 seconds per frame) could run the particle update at 60fps (in steps of 0.0167 seconds) to achieve a more accurate simulation, at the expense of performance. |

## Details

The Time Manager lets you set properties globally, but it is often useful to set them from a script during gameplay (for example, setting **Time Scale** to zero is a useful way to pause the game). Refer to the page on [Time and frame rate management](https://docs.unity3d.com/6000.3/Documentation/Manual/managing-time-and-frame-rate.html) for full details of how time can be managed in Unity.

## Additional resources

-   [Fixed updates](https://docs.unity3d.com/6000.3/Documentation/Manual/fixed-updates.html)
-   [Optimize physics performance](https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization.html)
