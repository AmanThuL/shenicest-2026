---
title: "Set fixed timestep to optimize physics simulation frequency"
page_title: "Unity - Manual: Set fixed timestep to optimize physics simulation frequency"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu-frequency.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu-frequency.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Set fixed timestep to optimize physics simulation frequency

Adjust the fixed timestep value to optimize physics simulation performance.

The physics system updates at a [fixed time interval](https://docs.unity3d.com/6000.3/Documentation/Manual/fixed-updates.html), which is important for accurate and consistent physics simulations. Configuring this frequency impacts the runtime performance of your project.

To review available project Time settings in the Editor, refer to [Time](https://docs.unity3d.com/6000.3/Documentation/Manual/class-TimeManager.html).

## Adjust fixed timestep

Running multiple physics steps per frame can significantly affect performance. The fixed timestep value determines the interval at which the physics system updates its simulation. The default value of fixed timestep is **0.02**, which corresponds to 50 fixed updates per second (50 Hz).

Game performance is negatively affected if multiple physics steps are required to keep pace with elapsed game time. For example, if game logic takes 35 ms to run in a frame and your **Fixed Timestep** value aims for 50 Hz (20 ms), the system might need to run two physics steps instead of one, which increases the computational load.

You can adjust the fixed timestep value to balance performance and simulation accuracy. However, consider the following trade-offs when adjusting the **Fixed Timestep** value:

-   A smaller **Fixed Timestep** value (higher update frequency) creates a more accurate and stable simulation, but increases CPU usage because of more frequent physics updates.
-   A larger **Fixed Timestep** value (lower update frequency) reduces CPU usage, but can result in less stable physics. Objects might pass through each other (tunneling) or exhibit jittery movement.

To view or modify the **Fixed Timestep** setting:

1.  Go to **Edit > Project Settings** to open the Project Settings window.
2.  Select the **Time** group.
3.  Adjust the **Fixed Timestep** field.

## Mitigate escalating physics simulation load

On lower-end devices, or when the main thread is overloaded, a common performance issue occurs when the physics system runs multiple fixed updates per frame, leading to a cycle of increasing CPU load and frame time. This performance issue is often referred to as the “spiral of doom”.

If the physics system spends a long time processing a frame, it might run multiple fixed update steps within that frame to catch up with elapsed game time. Each additional physics step consumes more CPU resources, further increasing the total frame time. Longer frame times cause more physics steps, and this increased load then makes the next frame time even longer. This desynchronization and escalating CPU requirements can quickly waste calculations on outdated game states and severely degrade performance.

You can set a value for **Maximum Allowed Timestep** in the **Time** section of the Project Settings to limit the time spent on physics updates per frame if the main thread lags. However, this safeguard can cause the physics simulation to appear to slow down, so use it carefully.

## Additional resources

-   [Unity Profiler](https://docs.unity3d.com/6000.3/Documentation/Manual/Profiler.html)
-   [Managing time and frame rate](https://docs.unity3d.com/6000.3/Documentation/Manual/managing-time-and-frame-rate.html)
-   [Memory Profiler](https://docs.unity3d.com/Packages/com.unity.memoryprofiler@latest)
-   [Physics Project Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PhysicsManager.html)
-   [Fixed Updates](https://docs.unity3d.com/6000.3/Documentation/Manual/fixed-updates.html)
-   [Time](https://docs.unity3d.com/6000.3/Documentation/Manual/class-TimeManager.html)
