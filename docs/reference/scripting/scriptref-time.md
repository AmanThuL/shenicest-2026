---
title: "Scripting API: Time"
page_title: "Unity - Scripting API: Time"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Time

class in UnityEngine

/

Implemented in:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UnityEngine.CoreModule.html" class="cl">UnityEngine.CoreModule</a>

<span id="scrollToFeedback">Leave feedback</span>

<span class="blue-btn sbtn">Suggest a change</span>

## Success!

Thank you for helping us improve the quality of Unity Documentation. Although we cannot accept all submissions, we do read each suggested change from our users and will make updates where applicable.

<span class="gray-btn sbtn close">Close</span>

## Submission failed

For some reason your suggested change could not be submitted. Please \<a>try again\</a> in a few minutes. And thank you for taking the time to help us improve the quality of Unity Documentation.

<span class="gray-btn sbtn close">Close</span>

Your name Your email Suggestion<span class="r">\*</span>

Submit suggestion

<span class="cancel left lh42 cn">Cancel</span>

<span style="color:red;"> </span>

### Description

Provides an interface to get time information from Unity.

For more information, see the following pages in the User Manual:

-   [Time and Framerate Management](https://docs.unity3d.com/6000.3/Documentation/Manual/managing-time-and-frame-rate.html)
-   [Order of execution for event functions](https://docs.unity3d.com/6000.3/Documentation/Manual/execution-order.html).

### Static Properties

| Property                                                                                                                             | Description                                                                                                                                                                                    |
|--------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [captureDeltaTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-captureDeltaTime.html)                         | Slows your application’s playback time to allow Unity to save screenshots in between frames.                                                                                                   |
| [captureDeltaTimeRational](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-captureDeltaTimeRational.html)         | Slows your application’s playback time to allow Unity to save screenshots in between frames.                                                                                                   |
| [captureFramerate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-captureFramerate.html)                         | The reciprocal of Time.captureDeltaTime.                                                                                                                                                       |
| [deltaTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-deltaTime.html)                                       | The interval in seconds from the last frame to the current one (Read Only).                                                                                                                    |
| [fixedDeltaTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-fixedDeltaTime.html)                             | The interval in seconds of in-game time at which physics and other fixed frame rate updates (like MonoBehaviour's MonoBehaviour.FixedUpdate) are performed.                                    |
| [fixedTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-fixedTime.html)                                       | The time at which the last MonoBehaviour.FixedUpdate started in seconds since the start of the game (Read Only).                                                                               |
| [fixedTimeAsDouble](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-fixedTimeAsDouble.html)                       | The double-precision time at which the last MonoBehaviour.FixedUpdate started in seconds since the start of the game (Read Only).                                                              |
| [fixedUnscaledDeltaTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-fixedUnscaledDeltaTime.html)             | The interval in seconds of timeScale-independent ("real") time at which physics and other fixed frame rate updates (like MonoBehaviour's MonoBehaviour.FixedUpdate) are performed.(Read Only). |
| [fixedUnscaledTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-fixedUnscaledTime.html)                       | The timeScale-independent time at the beginning of the last MonoBehaviour.FixedUpdate phase (Read Only). This is the time in seconds since the start of the game.                              |
| [fixedUnscaledTimeAsDouble](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-fixedUnscaledTimeAsDouble.html)       | The double precision timeScale-independent time at the beginning of the last MonoBehaviour.FixedUpdate (Read Only). This is the time in seconds since the start of the game.                   |
| [frameCount](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-frameCount.html)                                     | The total number of frames since the start of the game (Read Only).                                                                                                                            |
| [inFixedTimeStep](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-inFixedTimeStep.html)                           | Returns true if called inside a fixed time step callback (like MonoBehaviour's MonoBehaviour.FixedUpdate), otherwise returns false (Read Only).                                                |
| [maximumDeltaTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-maximumDeltaTime.html)                         | The maximum value of Time.deltaTime in any given frame. This is a time in seconds that limits the increase of Time.time between two frames.                                                    |
| [maximumParticleDeltaTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-maximumParticleDeltaTime.html)         | The maximum time a frame can spend on particle updates. If the frame takes longer than this, then updates are split into multiple smaller updates.                                             |
| [realtimeSinceStartup](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-realtimeSinceStartup.html)                 | The real time in seconds since the game started (Read Only).                                                                                                                                   |
| [realtimeSinceStartupAsDouble](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-realtimeSinceStartupAsDouble.html) | The real time in seconds since the game started (Read Only). Double precision version of Time.realtimeSinceStartup.                                                                            |
| [smoothDeltaTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-smoothDeltaTime.html)                           | A smoothed out Time.deltaTime (Read Only).                                                                                                                                                     |
| [time](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-time.html)                                                 | The time at the beginning of the current frame in seconds since the start of the application (Read Only).                                                                                      |
| [timeAsDouble](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-timeAsDouble.html)                                 | The double precision time at the beginning of this frame (Read Only). This is the time in seconds since the start of the game.                                                                 |
| [timeAsRational](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-timeAsRational.html)                             | The time this frame has started (Read Only). This is the time in seconds since the start of the game represented as a RationalTime.                                                            |
| [timeScale](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-timeScale.html)                                       | The rate at which in-game time passes relative to real time.                                                                                                                                   |
| [timeSinceLevelLoad](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-timeSinceLevelLoad.html)                     | The time in seconds since the last non-additive scene finished loading (Read Only).                                                                                                            |
| [timeSinceLevelLoadAsDouble](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-timeSinceLevelLoadAsDouble.html)     | The double precision time in seconds since the last non-additive scene finished loading (Read Only).                                                                                           |
| [unscaledDeltaTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-unscaledDeltaTime.html)                       | The timeScale-independent interval in seconds from the last frame to the current one (Read Only).                                                                                              |
| [unscaledTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-unscaledTime.html)                                 | The timeScale-independent time for this frame (Read Only). This is the time in seconds since the start of the game.                                                                            |
| [unscaledTimeAsDouble](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-unscaledTimeAsDouble.html)                 | The double precision timeScale-independent time for this frame (Read Only). This is the time in seconds since the start of the game.                                                           |
