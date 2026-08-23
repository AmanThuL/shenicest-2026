---
title: "Fixed updates"
page_title: "Unity - Manual: Fixed updates"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/fixed-updates.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/fixed-updates.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

## Fixed updates

Unlike the main [frame update](https://docs.unity3d.com/6000.3/Documentation/Manual/time-per-frame-updates.html), Unity’s physics system updates at a fixed time interval, which is important for the accuracy and consistency of physics simulations. The interval between fixed updates is often referred to as the fixed timestep. You can read or change the fixed timestep in two ways:

-   In code, by setting the value of the [`Time.fixedDeltaTime`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-fixedDeltaTime.html) property .
-   In the Unity Editor’s [Time](https://docs.unity3d.com/6000.3/Documentation/Manual/class-TimeManager.html) window, by modifying the **Fixed Timestep** value.

In both cases the fixed time step is specified in seconds. For example, a value of 0.01 means each fixed time step is one hundredth of a second in duration, so there are 100 fixed updates per second.

The fixed update loop simulates code running at fixed time intervals but in practice the interval between fixed updates isn’t fixed. This is because a fixed update always needs a frame to run in and the duration of a frame and the length of the fixed time step are not in perfect sync. If a fixed time step completes during the current frame, the associated fixed update can’t run until the next frame. [When frame rates are low](https://docs.unity3d.com/6000.3/Documentation/Manual/fixed-updates.html#low-frame-rates), a single frame might span several fixed time steps. In this case a backlog of fixed updates accumulates during the current frame and Unity executes all of them in the next frame to catch up.

**Note:** There is a maximum timestep period beyond which Unity will not attempt to catch up with the simulation. For more information, refer to [Handling variation in time](https://docs.unity3d.com/6000.3/Documentation/Manual/time-handling-variations.html).

Unity provides the [`MonoBehaviour.FixedUpdate`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.FixedUpdate.html) method as an entry point for you to execute your own code on each fixed update. This is most commonly used for executing your own physics-related code, such as [applying a force](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.AddForce.html) to a [Rigidbody](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.html).

You can see more details of what occurs during the fixed update cycle in the **Physics** section of the [execution order diagram](https://docs.unity3d.com/6000.3/Documentation/Manual/execution-order.html) diagram.

## When frame rate is higher than the fixed update rate

If your application runs at a higher frame rate than the number of fixed time steps per second then the average frame duration is less than the duration of a single fixed time step. In this case, each frame has one fixed update or none at all. For example, if the fixed time step value is 0.02, there are 50 fixed updates per second. If your application runs at around 128 frames per second, a fixed update occurs every two or three frames, as shown below.

![An example showing FixedUpdate running at 50 updates per second (0.02s per fixed update) and the Player Loop running at approximately 128 frames per second. Some frame updates (marked in yellow) have a corresponding FixedUpdate (marked in green) if a new complete fixed timestep has elapsed by the start of the frame.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/TimingFixedUpdateFastFPS.png)

This diagram shows the frame rate running faster than the fixed update timestep rate. Time progresses to the right, each frame is numbered, and shows its `Update` call at the start of the frame in orange. The fixed timestep here is 0.02 seconds (50 times per second), and the game is running faster, at about 128 frames per second. In this situation there are some frames with one fixed update call, and some frames with none, depending on whether a full fixed update timestep has completed by the time the frame starts. The fixed time step periods are marked with letters A, B, C, D, E, and the frames in which their corresponding fixed update calls occur are marked in green. The fixed update call for timestep A occurs at the start of frame 4, the fixed update call for timestep B occurs at the start of frame 7, and so on.

<span id="low-frame-rates"></span>

## When frame rate is lower than the fixed update rate

If your application runs at a lower frame rate than the fixed timestep value then the average frame duration is longer than a single fixed timestep. This means a backlog of fixed updates can accumulate during some frames and so each frame has one or more fixed updates to allow the physics simulation to catch up with the backlog. For example, if the fixed timestep value is 0.01, there are 100 fixed updates per second. If your application runs at around 40 frames per second, Unity performs an average of two or three fixed updates per frame to keep up. You might want a scenario like this when it’s more important to model more accurate physics than to have a high frame rate.

![An example showing Update running at around 38 FPS and FixedUpdate running at 100 updates per second. As a result, some frames have up to three FixedUpdates (marked in green).](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/TimingFixedUpdateSlowFPS.png)

This diagram shows what happens when the fixed update cycle is running faster than the frame rate. The fixed timestep here is 0.01 seconds (100 times per second), and the game frame rate is running slower, at about 38 frames per second. In this situation most frames have multiple fixed update calls before each update call, the number depending on how many whole update timesteps have elapsed since the previous frame. The fixed update time step periods are marked with letters A, B, C, and so on, and frames in which their corresponding fixed update calls occur are marked in green. The fixed update call for timestep A and B occurs at the start of frame 2, the fixed update call for frames C, D & E occur at the start of frame 3, and so on.

**Note:** A lower timestep value means more frequent physics updates and more precise simulations, which leads to higher CPU load.

## Additional resources

-   [Managing variable frame rate](https://docs.unity3d.com/6000.3/Documentation/Manual/time-per-frame-updates.html)
-   [Handling variations in time](https://docs.unity3d.com/6000.3/Documentation/Manual/time-handling-variations.html)
-   [Time scale](https://docs.unity3d.com/6000.3/Documentation/Manual/time-scale.html)
-   [Capture frame rate](https://docs.unity3d.com/6000.3/Documentation/Manual/time-capture-frame-rate.html)
