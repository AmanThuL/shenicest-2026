---
title: "Apply interpolation to a Rigidbody"
page_title: "Unity - Manual: Apply interpolation to a Rigidbody"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/rigidbody-interpolation.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/rigidbody-interpolation.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Apply interpolation to a Rigidbody

Interpolation provides a way to manage the appearance of jitter in the movement of your [Rigidbody](https://docs.unity3d.com/6000.3/Documentation/Manual/RigidbodiesOverview.html) GameObjects at run time.

Jitter can happen when the rate of physics simulation updates (determined by the [Fixed Timestep](https://docs.unity3d.com/6000.3/Documentation/Manual/class-TimeManager.html)) is slower than the application’s frame rate. It is most noticeable if you have a Rigidbody with physics-based movement that the camera tracks at run time.

Unity’s PhysX system provides a way to implement interpolation. The **Interpolate** setting on a Rigidbody provides two options to smooth the appearance of a Rigidbody’s motion if it appears jittery at run time. These options are **Interpolate** and **Extrapolate**.

Both interpolation and extrapolation calculate the pose of the Rigidbody (that is, the position and rotation) between physics updates. Which one you should choose depends on which option produces the best visual outcome for your use case.

You should only use interpolation or extrapolation if you see jitter in your Rigidbody’s movement. **Interpolate** is set to **None** by default.

When interpolation or extrapolation is enabled, the physics system takes control of the Rigidbody’s transform. For this reason, you should follow any direct (non-physics) change to the transform with a [Physics.SyncTransforms](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.SyncTransforms.html) call. Otherwise, Unity ignores any transform change that does not originate from the physics system.

## Interpolate

Use the pose of the Rigidbody from the previous two physics updates to calculate and apply the pose of the Rigidbody in the current frame.

Interpolate makes the Rigidbody appear to move slightly behind where it should be. This is because interpolation delays the Rigidbody’s pose by one physics update, so that it has two points to use for its calculation, and enough time to move the Rigidbody to the new pose.

Interpolation is more accurate than extrapolation, but it has a time lag of one physics update.

Interpolate is usually the best option for situations where the Rigidbody’s velocity varies, or if there are other physics elements that influence the Rigidbody’s movement.

Interpolate is represented by the API property [`RigidbodyInterpolation.Interpolate`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RigidbodyInterpolation.Interpolate.html).

## Extrapolate

Use the pose of the Rigidbody from the previous physics update, and predict the pose of the Rigidbody in the next physics update, to calculate and predict the pose in the current frame.

Extrapolate makes the Rigidbody appear to move slightly ahead of where it should be. This is because extrapolation uses the Rigidbody’s current velocity to predict the Rigidbody’s pose in the next physics update, so that it has two points to use for its calculation.

Extrapolation is often less accurate, and might visibly overshoot collision bounds (and then correct itself in the next frame, after the next physics update). This is because the extrapolation calculation does not take into account future physics forces or calculations.

Extrapolate is usually only a good option for situations where accuracy is not important; for example, if the Rigidbody moves at a constant velocity, and there are no other physics elements that influence the Rigidbody’s movement.

Extrapolate is represented by the API property [`RigidbodyInterpolation.Extrapolate`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RigidbodyInterpolation.Extrapolate.html).
