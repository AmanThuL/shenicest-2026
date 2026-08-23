---
title: "Introduction to rigid body physics"
page_title: "Unity - Manual: Introduction to rigid body physics"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/RigidbodiesOverview.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/RigidbodiesOverview.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to rigid body physics

In real-world physics, a rigid body is any physical body that does not deform or change shape under physics forces. The distance between any two given points of a rigid body remains constant in time, regardless of external forces exerted on it.

To simulate physics-based behavior such as movement, gravity, collision, and joints, you need to configure items in your scene as rigid bodies. To configure GameObjects as rigid bodies in Unity’s PhysX system, you can assign them the [Rigidbody](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Rigidbody.html) component. The Rigidbody component is represented in the API by the [`Rigidbody`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.html) class.

## Rigid body GameObjects with physics-based movement

In Unity, a [Rigidbody](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Rigidbody.html) component provides a physics-based way to control the movement and position of a GameObject. Instead of the [Transform](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Transform.html) properties, you can use simulated physics forces and torque to move the GameObject, and let the physics engine calculate the results.

In most cases, if a GameObject has a Rigidbody, you should use the Rigidbody properties to move the GameObject, instead of the Transform properties. The Rigidbody properties apply forces and torque from the physics system, which change the GameObject’s Transform; if you then change the Transform directly, Unity cannot correctly calculate the physics simulation, and you might see unwanted behavior. This is particularly true of rigid bodies with [Joints](https://docs.unity3d.com/6000.3/Documentation/Manual/joints-section.html).

Unity handles physics-based movement globally, not locally. When a GameObject with a Rigidbody moves via physics-based movement, it moves independently of any parent or child GameObject. A child GameObject that has a Rigidbody still uses its parent GameObject to define its local position for initialization, but Unity calculates its physics-based movement in global space.

To control a Rigidbody via script, the primary methods are [`AddForce`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.AddForce.html) (to add forces to a GameObject) and [`AddTorque`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.AddTorque.html) (to apply torque to a GameObject).

## Rigid body GameObjects without physics-based movement

There are some cases where you might want the physics system to detect a GameObject, but not to control it. For example, you might want [Colliders](https://docs.unity3d.com/6000.3/Documentation/Manual/collision-section.html) to detect a GameObject, but you intend to control that GameObject’s movement and position via its [Transform](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Transform.html).

Movement in Unity that is not physics-based is called **kinematic motion**. The Rigidbody component has the property **Is Kinematic** which, when enabled, defines the attached GameObject as non-physics-based, and removes it from the control of the physics engine. This allows you to move it kinematically via the Transform without Unity’s physics simulation calculations overriding the changes.

A kinematic Rigidbody can apply physics-based force to physics-based Rigidbody GameObjects, but does not receive physics-based force. For example, a kinematic Rigidbody can collide with and “push” a Rigidbody that has physics-based movement, but a Rigidbody with physics-based movement cannot “push” a kinematic Rigidbody.

If you use a [Joint](https://docs.unity3d.com/6000.3/Documentation/Manual/joints-section.html) to attach a kinematic Rigidbody to a non-kinematic Rigidbody, the Joint cannot exert forces to move the kinematic Rigidbody. It can only ever move the non-kinematic Rigidbody. However, you can still move the kinematic Rigidbody via the Transform, and the Joint can adjust the pose of the non-kinematic body to satisfy the joint limits.

## Rigidbody optimization

When a Rigidbody moves at a slower speed than the **Sleep Threshold** (see the [Physics](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PhysicsManager.html) Project Settings), Unity sets the Rigidbody to “sleep”, which means that the physics system does not include it in physics calculations. When a sleeping Rigidbody receives a collision or force, Unity “wakes up” the Rigidbody and continues to include it in physics calculations.

By default, the sleeping and waking of a Rigidbody component happens automatically. However, you can also control this behavior yourself via script, via the methods [`Rigidbody.Sleep`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.Sleep.html) and [`Rigidbody.WakeUp`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.WakeUp.html).

A Rigidbody might fail to wake up in response to movement and collisions from static colliders (that is, colliders without a Rigidbody) that are moving via the **Transform** position instead of the physics system. This is particularly likely if the physics system can no longer detect the static collider. If this happens, you can use [`Rigidbody.WakeUp`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.WakeUp.html) to wake up the sleeping Rigidbody.

To learn more about Rigidbody component sleeping and how to optimize your Rigidbody components, refer to [Use Rigidbody sleeping to improve physics performance](https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu-rigidbody-sleeping.html).

For more information on how the PhysX physics system handles sleeping, see the NVIDIA PhysX SDK Rigidbody Dynamics documentation on [Sleeping](https://docs.nvidia.com/gameworks/content/gameworkslibrary/physx/guide/Manual/RigidBodyDynamics.html#sleeping).
