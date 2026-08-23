---
title: "Handling variation in time"
page_title: "Unity - Manual: Handling variation in time"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/time-handling-variations.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/time-handling-variations.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Handling variation in time

For a given frame rate in frames per second (FPS), the duration of individual frames tends to vary. These variations can be minor. For example, in a game running at 60 FPS, the actual number of frames per second may vary slightly, so that each frame lasts between 0.016 and 0.018 seconds. Larger variations can occur when your application performs heavy computations or garbage collection, or when there’s competition for resources from other applications.

## Recording elapsed time

[Time.time](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-time.html) indicates the amount of time elapsed since the start of the application, and so usually rises continuously and steadily. [Time.deltaTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-deltaTime.html) indicates the amount of time elapsed since the last frame, and so ideally remains fairly constant. Both these values are based on [in-game rather than real time](https://docs.unity3d.com/6000.3/Documentation/Manual/time-scale.html), which means they take into account any scaling of time that you apply. For example, if you set [Time.timeScale](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-timeScale.html) to 0.1 for a slow-motion effect, the value of `Time.time` increases at 10% the rate of real time. After 10 seconds of real time, the value of `Time.time` would have increased by 1.

In addition to slowing down or speeding up time in your game, you can set `Time.timeScale` to zero to pause your game. In this case Unity still calls the `Update` method, but `Time.time` doesn’t increase at all, and `Time.deltaTime` is zero.

### Limiting recorded time variation

These values are also capped by the value of [Time.maximumDeltaTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-maximumDeltaTime.html). The length of any pauses or variations in frame rate reported by these properties will never exceed `Time.maximumDeltaTime`. For example, if a delay of one second occurs, but `maximumDeltaTime` is set to the default value of 0.333, `Time.time` only increases by 0.333 and `Time.deltaTime` equals 0.333, despite one second elapsing in the real world.

The unscaled versions of each of these properties ([Time.unscaledTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-unscaledTime.html) and [Time.unscaledDeltaTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-unscaledDeltaTime.html)) ignore these limitations, and report the actual time elapsed in both cases. This is useful for anything that should respond at a fixed speed even when the game is playing in slow-motion. An example of this is UI interaction animation.

The table below shows an example of 16 frames elapsing one after another, with one large delay occuring half-way through, on a single frame. These figures illustrate how the various `Time` class properties report and respond to this large variation in frame rate.

| Frame     | unscaledTime  | time          | unscaledDeltaTime | deltaTime     | smoothDeltaTime |
|:----------|:--------------|:--------------|:------------------|:--------------|:----------------|
| 1         | 0.000         | 0.000         | 0.018             | 0.018         | 0.018           |
| 2         | 0.018         | 0.018         | 0.018             | 0.018         | 0.018           |
| 3         | 0.036         | 0.036         | 0.018             | 0.018         | 0.018           |
| 4         | 0.054         | 0.054         | 0.018             | 0.018         | 0.018           |
| 5         | 0.071         | 0.071         | 0.017             | 0.017         | 0.018           |
| 6         | 0.089         | 0.089         | 0.018             | 0.018         | 0.018           |
| 7         | 0.107         | 0.107         | 0.018             | 0.018         | 0.018           |
| 8 (**a**) | 1.123 (**b**) | 0.440 (**c**) | 1.016 (**d**)     | 0.333 (**e**) | 0.081 (**f**)   |
| 9         | 1.140         | 0.457         | 0.017             | 0.017         | 0.066           |
| 10        | 1.157         | 0.474         | 0.017             | 0.017         | 0.056           |
| 11        | 1.175         | 0.492         | 0.018             | 0.018         | 0.049           |
| 12        | 1.193         | 0.510         | 0.018             | 0.018         | 0.042           |
| 13        | 1.211         | 0.528         | 0.018             | 0.018         | 0.038           |
| 14        | 1.229         | 0.546         | 0.018             | 0.018         | 0.034           |
| 15        | 1.247         | 0.564         | 0.018             | 0.018         | 0.031           |
| 16        | 1.265         | 0.582         | 0.018             | 0.018         | 0.028           |

Frames 1 to 7 are running at a steady rate of approximately 60 frames per second. Note that both `Time.time` and `Time.unscaledTime` increase steadily together, indicating that `Time.timeScale` is set to 1.

On frame 8 (**a**), a large delay of just over one second occurs. Competition for resources can cause this. For example, when an operation blocks the main process while it loads a large amount of data from disk.

When a frame delay exceeds `Time.maximumDeltaTime`, Unity limits the value reported by `Time.deltaTime` and the amount added to `Time.time`. This avoids undesirable side-effects that might occur if the time step exceeds that amount. Without the limit, objects whose movement is scaled by `Time.deltaTime` can theoretically move unlimited distances from one frame to the next. This can cause a glitching effect where, for example, characters pass through obstacles such as walls unimpeded.

You can adjust `Time.maximumDeltaTime` in the Editor by changing the **Maximum allowed timestep** setting in the [Time](https://docs.unity3d.com/6000.3/Documentation/Manual/class-TimeManager.html) window or in code by setting the value of the [Time.maximumDeltaTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-maximumDeltaTime.html) property.

The default `Time.maximumDeltaTime` value is one third of a second (0.3333333). This means that in a game where movement is controlled by `Time.deltaTime`, an object’s movement from one frame to the next is limited to the distance it could cover in a third of a second, regardless of how much time actually elapsed since the previous frame.

Looking at the data from the previous table in graph form can help to visualise how these time properties behave in relation to each other:

![For the delayed frame 8, delta time reports its default maximum value of 0.333 seconds while unscaled delta time reports the real time elapsed since the previous frame, which is 1.016 seconds.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/time-delta-unscaled.png)

On frame 8, `Time.unscaledDeltaTime` (**d**) and `Time.deltaTime` (**e**) differ in how much time they report has elapsed. Although a whole second of real time elapsed between frames 7 and 8, `Time.deltaTime` reports only 0.333 seconds. This is because `Time.deltaTime` is capped to the `Time.maximumDeltaTime` value.

![Before the delayed frame 8, time and unscaled time are equal and increasing at the same rate. The delayed frame causes the two values to diverge by the difference between delta time and unscaled delta time for frame 8.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/time-and-unscaled.png)

Similarly, `Time.unscaledTime` (**b**) has increased by approximately a whole second because the true (uncapped) value has been added, whereas `Time.time` (**c**) has only increased by the smaller capped value. `Time.time` does not catch up to the elapsed real time, and instead behaves as though the delay was only `Time.maximumDeltaTime` in duration.

![The value of delta time spikes significantly on the delayed frame 8 but remains consistent across the other frames. Smooth delta time instead rises slightly on frame 8 but spreads the increase out across subsequent frames. It remains higher than delta time for the next 8 frames while gradually trending down.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/time-delta-smoothed.png)

The `Time.smoothDeltaTime` property reports an approximation of the recent `Time.deltaTime` values with all variations smoothed out according to an algorithm. This is another technique to avoid undesirable fluctuations in movement or other time-based calculations. In particular, those which fall below the threshold set by `Time.maximumDeltaTime`. The smoothing algorithm can’t predict future variations, but it gradually adapts its reported value to smooth out variations in the recently elapsed `Time.deltaTime` values, so that the average reported time remains approximately equivalent to the actual amount of time elapsed.

## Time variation and the fixed update loop

The `maximumDeltaTime` value also affects the [fixed update loop](https://docs.unity3d.com/6000.3/Documentation/Manual/fixed-updates.html). The physics system uses the fixed time interval defined by `Time.fixedDeltaTime` to determine how much time to simulate in each step. Unity tries to keep the physics simulation up-to-date with the amount of time that has elapsed and sometimes performs multiple physics updates per frame.

However, if the physics simulation falls too far behind, the physics system may require a large number of steps to catch up to the current time. These catch-up steps may themselves cause additional slow-down. To avoid a feedback loop of slow-downs, the `Time.maximumDeltaTime` value also acts as a limit on the amount of time the physics system simulates between any two given frames.

If a frame update takes longer than `Time.maximumDeltaTime` to process, the physics engine doesn’t try to simulate any of the additional time, and instead lets the frame processing catch up. Once the frame update has finished, the physics resumes as though no time has passed since it stopped.

The result of this is that physics objects won’t move perfectly in real time as they usually do, but will be slowed slightly. However, the physics system still tracks them as though they were moving normally. The slowing of physics time is usually not noticeable and is often an acceptable trade-off against gameplay performance.

## Unity’s time logic

The following flowchart illustrates the logic that Unity uses to count time in a single frame, and how the [time](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-time.html), [deltaTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-deltaTime.html), [fixedDeltaTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-fixedDeltaTime.html), and [maximumDeltaTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-maximumDeltaTime.html) properties relate to each other.

![Unity computes delta time, reducing it to the maximum delta time if necessary, and adds this value to the total elapsed time. If the total elapsed time is now ahead of the fixed time value by at least one fixed time step, Unity performs a fixed update. If not, it performs a regular frame update.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/time-flowchart.svg)

## Additional resources

-   [Per-frame updates](https://docs.unity3d.com/6000.3/Documentation/Manual/time-per-frame-updates.html)
-   [Time scale](https://docs.unity3d.com/6000.3/Documentation/Manual/time-scale.html)
-   [Capture frame rate](https://docs.unity3d.com/6000.3/Documentation/Manual/time-capture-frame-rate.html)
