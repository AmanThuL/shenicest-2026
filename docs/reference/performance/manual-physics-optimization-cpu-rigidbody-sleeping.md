---
title: "Use Rigidbody sleeping to improve physics performance"
page_title: "Unity - Manual: Use Rigidbody sleeping to improve physics performance"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu-rigidbody-sleeping.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu-rigidbody-sleeping.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Use Rigidbody sleeping to improve physics performance

Reduce CPU load and improve physics performance by enabling Rigidbody sleeping for stationary objects.

Rigidbody sleeping can drastically reduce CPU load, especially in scenes with many physical objects that are often stationary or frequently come to rest. When a **Rigidbody** component moves at a slower speed than the **[Sleep Threshold](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PhysicsManager.html)**, the physics system sets the **Rigidbody** component to a sleeping state. When a **Rigidbody** component is asleep, the physics system doesn’t include it in physics calculations. When a sleeping **Rigidbody** component receives a collision or force, the physics system wakes up the Rigidbody component and includes it in physics calculations.

In script, control Rigidbody sleeping with [`Rigidbody.Sleep`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.Sleep.html) and [`Rigidbody.WakeUp`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.WakeUp.html)

Rigidbody sleeping is highly effective in environments with many interactive props, destructible elements that settle, or physics-based puzzles that stabilize. While scenes with constant high-velocity motion benefit less, enabling sleeping is generally a good default behavior.

To enable Rigidbody sleeping, the recommended best practices are:

-   Ensure that the **Rigidbody** component’s sleep threshold is set appropriately. Set the **Sleep Threshold** in the [Physics Project Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PhysicsManager.html) and in script with [`Rigidbody.sleepThreshold`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody-sleepThreshold.html).
-   Avoid calling `Rigidbody.WakeUp` unnecessarily on objects unless they need to be active in the simulation. Continuously waking objects negates the benefit of sleeping.
-   Check if a **Rigidbody** component is sleeping with [`Rigidbody.IsSleeping`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.IsSleeping.html).
-   Use the Physics Debugger (**Window > Analysis > Physics Debugger**) to visually inspect the sleep state of **Rigidbody** components in your scene. The Physics Debugger can help identify objects that are unexpectedly active and not sleeping, potentially due to persistent small contacts or incorrect sleep settings.

## Additional resources

-   [Unity Profiler](https://docs.unity3d.com/6000.3/Documentation/Manual/Profiler.html)
-   [Managing time and frame rate](https://docs.unity3d.com/6000.3/Documentation/Manual/managing-time-and-frame-rate.html)
-   [Memory Profiler](https://docs.unity3d.com/Packages/com.unity.memoryprofiler@latest)
-   [Physics Project Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PhysicsManager.html)
-   [`Rigidbody.Sleep`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.Sleep.html)
