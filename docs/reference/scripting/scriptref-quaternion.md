---
title: "Scripting API: Quaternion"
page_title: "Unity - Scripting API: Quaternion"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Quaternion

struct in UnityEngine

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-Quaternion.html" class="switch-link gray-btn sbtn left show" title="Go to Quaternion Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

### Description

Quaternions are used to represent rotations.

A quaternion is a four-tuple of real numbers {x,y,z,w}. A quaternion is a mathematically convenient alternative to the euler angle representation. You can interpolate a quaternion without experiencing gimbal lock. You can also use a quaternion to concatenate a series of rotations into a single representation.  
  
Unity internally uses Quaternions to represent all rotations.  
  
In most cases, you can use existing rotations from methods such as [Transform.localRotation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform-localRotation.html) or [Transform.rotation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform-rotation.html) to construct new rotations. For example, use existing rotations to smoothly interpolate between two rotations. The most used Quaternion functions are as follows: [Quaternion.LookRotation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.LookRotation.html), [Quaternion.Angle](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.Angle.html), [Quaternion.Euler](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.Euler.html), [Quaternion.Slerp](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.Slerp.html), [Quaternion.FromToRotation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.FromToRotation.html), and [Quaternion.identity](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion-identity.html).  
  
You can use the Quaternion.operator \* to rotate one rotation by another, or to rotate a vector by a rotation.  
  
Note that Unity expects Quaternions to be normalized.

### Static Properties

| Property                                                                                           | Description                        |
|----------------------------------------------------------------------------------------------------|------------------------------------|
| [identity](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion-identity.html) | The identity rotation (Read Only). |

### Properties

| Property                                                                                                    | Description                                                                                       |
|-------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------|
| [eulerAngles](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion-eulerAngles.html)    | Returns or sets the euler angle representation of the rotation in degrees.                        |
| [normalized](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion-normalized.html)      | Returns this quaternion with a magnitude of 1 (Read Only).                                        |
| [this\[int\]](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.Index_operator.html) | Access the x, y, z, w components using \[0\], \[1\], \[2\], \[3\] respectively.                   |
| [w](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion-w.html)                        | W component of the Quaternion. Do not directly modify quaternions.                                |
| [x](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion-x.html)                        | X component of the Quaternion. Don't modify this directly unless you know quaternions inside out. |
| [y](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion-y.html)                        | Y component of the Quaternion. Don't modify this directly unless you know quaternions inside out. |
| [z](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion-z.html)                        | Z component of the Quaternion. Don't modify this directly unless you know quaternions inside out. |

### Constructors

| Constructor                                                                                      | Description                                              |
|--------------------------------------------------------------------------------------------------|----------------------------------------------------------|
| [Quaternion](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion-ctor.html) | Constructs new Quaternion with given x,y,z,w components. |

### Public Methods

| Method                                                                                                               | Description                                                                 |
|----------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------|
| [Equals](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.Equals.html)                       | Performs exact binary comparison of each Quaternion component (x, y, z, w). |
| [Set](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.Set.html)                             | Set x, y, z and w components of an existing Quaternion.                     |
| [SetFromToRotation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.SetFromToRotation.html) | Creates a rotation which rotates from fromDirection to toDirection.         |
| [SetLookRotation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.SetLookRotation.html)     | Creates a rotation with the specified forward and upwards directions.       |
| [ToAngleAxis](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.ToAngleAxis.html)             | Converts a rotation to angle-axis representation.                           |
| [ToString](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.ToString.html)                   | Returns a formatted string for this quaternion.                             |

### Static Methods

| Method                                                                                                         | Description                                                                                             |
|----------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------|
| [Angle](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.Angle.html)                   | Returns the angle in degrees between two rotations a and b. The resulting angle ranges from 0 to 180.   |
| [AngleAxis](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.AngleAxis.html)           | Creates a rotation which rotates angle degrees around axis.                                             |
| [Dot](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.Dot.html)                       | The dot product between two rotations.                                                                  |
| [Euler](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.Euler.html)                   | Converts an input Euler angle rotation specified as three floats to a Quaternion.                       |
| [FromToRotation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.FromToRotation.html) | Creates a rotation from fromDirection to toDirection.                                                   |
| [Inverse](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.Inverse.html)               | Returns the Inverse of rotation.                                                                        |
| [Lerp](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.Lerp.html)                     | Interpolates between a and b by t and normalizes the result afterwards.                                 |
| [LerpUnclamped](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.LerpUnclamped.html)   | Interpolates between a and b by t and normalizes the result afterwards. The parameter t is not clamped. |
| [LookRotation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.LookRotation.html)     | Creates a rotation with the specified forward and upwards directions.                                   |
| [Normalize](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.Normalize.html)           | Converts this quaternion to a quaternion with the same orientation but with a magnitude of 1.0.         |
| [RotateTowards](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.RotateTowards.html)   | Rotates a rotation from towards to.                                                                     |
| [Slerp](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.Slerp.html)                   | Spherically linear interpolates between unit quaternions a and b by a ratio of t.                       |
| [SlerpUnclamped](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.SlerpUnclamped.html) | Spherically linear interpolates between unit quaternions a and b by t.                                  |

### Operators

| Operator                                                                                                       | Description                              |
|----------------------------------------------------------------------------------------------------------------|------------------------------------------|
| [operator \*](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion-operator_multiply.html) | Combines rotations lhs and rhs.          |
| [operator ==](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion-operator_eq.html)       | Are two quaternions equal to each other? |
