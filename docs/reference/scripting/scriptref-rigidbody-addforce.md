---
title: "Scripting API: Rigidbody.AddForce"
page_title: "Unity - Scripting API: Rigidbody.AddForce"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.AddForce.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.AddForce.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Rigidbody](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.html).AddForce

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-Rigidbody.html" class="switch-link gray-btn sbtn left show" title="Go to Rigidbody Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

## Declaration

public void <span class="sig-kw">AddForce</span>([Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">force</span>, [ForceMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ForceMode.html) <span class="sig-kw">mode</span> = ForceMode.Force);

### Parameters

| Parameter | Description                        |
|-----------|------------------------------------|
| force     | Force vector in world coordinates. |
| mode      | Type of force to apply.            |

### Description

Adds a force to the [Rigidbody](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.html).

Force is applied continuously along the direction of the `force` vector. Specifying the [ForceMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ForceMode.html) `mode` allows the type of force to be changed to an Acceleration, Impulse or Velocity Change.  
  
The effects of the forces applied with this function are accumulated at the time of the call. The physics system applies the effects during the next simulation run (either after [FixedUpdate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayerLoop.FixedUpdate.html), or when the script explicitly calls the [Physics.Simulate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.Simulate.html) method). Because this function has different modes, the physics system only accumulates the resulting velocity change, not the passed force values. Assuming deltaTime (DT) is equal to the simulation step length ([Time.fixedDeltaTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-fixedDeltaTime.html)), and mass is equal to the mass of the Rigidbody the force is being applied to, here is how the velocity change is calculated for all the modes:

-   [ForceMode.Force](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ForceMode.Force.html): Interprets the input as force (measured in Newtons), and changes the velocity by the value of force \* DT / mass. The effect depends on the simulation step length and the mass of the body.
-   [ForceMode.Acceleration](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ForceMode.Acceleration.html): Interprets the parameter as acceleration (measured in meters per second squared), and changes the velocity by the value of force \* DT. The effect depends on the simulation step length but doesn't depend on the mass of the body.
-   [ForceMode.Impulse](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ForceMode.Impulse.html): Interprets the parameter as an impulse (measured in newton-seconds), and changes the velocity by the value of force / mass. The effect depends on the mass of the body but doesn't depend on the simulation step length.
-   [ForceMode.VelocityChange](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ForceMode.VelocityChange.html): Interprets the parameter as a direct velocity change (measured in meters per second), and changes the velocity by the value of force. The effect doesn't depend on the mass of the body or the simulation step length.

Force can only be applied to an active Rigidbody. If a GameObject is inactive, AddForce has no effect. Also, the Rigidbody cannot be kinematic.  
  
By default the Rigidbody's state is set to awake once a force is applied, unless the force is [Vector3.zero](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3-zero.html).  
  
Additional resources: [AddForceAtPosition](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.AddForceAtPosition.html), [AddRelativeForce](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.AddRelativeForce.html), [AddTorque](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.AddTorque.html).  
  
This example applies a forward force to the GameObject's Rigidbody.

``` codeExampleCS
using UnityEngine;
using UnityEngine.InputSystem;

public class Example : MonoBehaviour

    void FixedUpdate()
    
    }
}
```

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public void <span class="sig-kw">AddForce</span>(float <span class="sig-kw">x</span>, float <span class="sig-kw">y</span>, float <span class="sig-kw">z</span>, [ForceMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ForceMode.html) <span class="sig-kw">mode</span> = ForceMode.Force);

### Parameters

| Parameter | Description                           |
|-----------|---------------------------------------|
| x         | Size of force along the world x-axis. |
| y         | Size of force along the world y-axis. |
| z         | Size of force along the world z-axis. |
| mode      | Type of force to apply.               |

### Description

Adds a force to the [Rigidbody](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.html).

This example applies an Impulse force along the Z axis to the GameObject's Rigidbody.

``` codeExampleCS
using UnityEngine;

public class Example : MonoBehaviour

}
```
