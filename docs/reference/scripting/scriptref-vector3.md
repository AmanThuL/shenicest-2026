---
title: "Scripting API: Vector3"
page_title: "Unity - Scripting API: Vector3"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Vector3

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

<span style="color:red;"> </span>

### Description

Representation of 3D vectors and points.

This structure is used throughout Unity to pass 3D positions and directions around. It also contains functions for doing common vector operations.  
  
Besides the functions listed below, other classes can be used to manipulate vectors and points as well. For example the [Quaternion](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.html) and the [Matrix4x4](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Matrix4x4.html) classes are useful for rotating or transforming vectors and points.

### Static Properties

| Property                                                                                                        | Description                                                                                            |
|-----------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------|
| [back](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3-back.html)                         | Shorthand for writing Vector3(0, 0, -1).                                                               |
| [down](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3-down.html)                         | Shorthand for writing Vector3(0, -1, 0).                                                               |
| [forward](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3-forward.html)                   | Shorthand for writing Vector3(0, 0, 1).                                                                |
| [left](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3-left.html)                         | Shorthand for writing Vector3(-1, 0, 0).                                                               |
| [negativeInfinity](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3-negativeInfinity.html) | Shorthand for writing Vector3(float.NegativeInfinity, float.NegativeInfinity, float.NegativeInfinity). |
| [one](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3-one.html)                           | Shorthand for writing Vector3(1, 1, 1).                                                                |
| [positiveInfinity](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3-positiveInfinity.html) | Shorthand for writing Vector3(float.PositiveInfinity, float.PositiveInfinity, float.PositiveInfinity). |
| [right](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3-right.html)                       | Shorthand for writing Vector3(1, 0, 0).                                                                |
| [up](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3-up.html)                             | Shorthand for writing Vector3(0, 1, 0).                                                                |
| [zero](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3-zero.html)                         | Shorthand for writing Vector3(0, 0, 0).                                                                |

### Properties

| Property                                                                                                 | Description                                                           |
|----------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------|
| [magnitude](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3-magnitude.html)        | Returns the length of this vector (Read Only).                        |
| [normalized](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3-normalized.html)      | The unit vector in the direction of the current vector.               |
| [sqrMagnitude](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3-sqrMagnitude.html)  | Returns the squared length of this vector (Read Only).                |
| [this\[int\]](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.Index_operator.html) | Access the x, y, z components using \[0\], \[1\], \[2\] respectively. |
| [x](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3-x.html)                        | X component of the vector.                                            |
| [y](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3-y.html)                        | Y component of the vector.                                            |
| [z](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3-z.html)                        | Z component of the vector.                                            |

### Constructors

| Constructor                                                                                | Description                                      |
|--------------------------------------------------------------------------------------------|--------------------------------------------------|
| [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3-ctor.html) | Creates a new three-dimensional vector or point. |

### Public Methods

| Method                                                                                          | Description                                                 |
|-------------------------------------------------------------------------------------------------|-------------------------------------------------------------|
| [Equals](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.Equals.html)     | Checks if the given object is exactly equal to this vector. |
| [Set](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.Set.html)           | Set x, y and z components of an existing Vector3.           |
| [ToString](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.ToString.html) | Formats this vector as a string.                            |

### Static Methods

| Method                                                                                                      | Description                                                                                       |
|-------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------|
| [Angle](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.Angle.html)                   | Calculates the angle between two vectors.                                                         |
| [ClampMagnitude](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.ClampMagnitude.html) | Creates a copy of a given Vector3 with its magnitude clamped to a maximum length.                 |
| [Cross](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.Cross.html)                   | Calculates the cross product of two three-dimensional vectors.                                    |
| [Distance](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.Distance.html)             | Calculates the distance between two three-dimensional points.                                     |
| [Dot](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.Dot.html)                       | Calculates the dot product of two three-dimensional vectors defined in the same coordinate space. |
| [Lerp](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.Lerp.html)                     | Interpolates linearly between two points.                                                         |
| [LerpUnclamped](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.LerpUnclamped.html)   | Interpolates linearly between two vectors, allowing extrapolation beyond the end points.          |
| [Max](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.Max.html)                       | Creates a vector that is made from the largest components of two vectors.                         |
| [Min](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.Min.html)                       | Creates a vector that is made from the smallest components of two vectors.                        |
| [MoveTowards](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.MoveTowards.html)       | Moves vector incrementally towards a target point.                                                |
| [Normalize](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.Normalize.html)           | Normalizes the magnitude of the current vector to 1 while maintaining the direction.              |
| [OrthoNormalize](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.OrthoNormalize.html) | Makes vectors normalized and orthogonal to each other.                                            |
| [Project](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.Project.html)               | Projects a vector onto another vector.                                                            |
| [ProjectOnPlane](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.ProjectOnPlane.html) | Projects a vector onto a plane.                                                                   |
| [Reflect](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.Reflect.html)               | Reflects a vector off the plane defined by a normal vector.                                       |
| [RotateTowards](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.RotateTowards.html)   | Rotates a vector current towards target.                                                          |
| [Scale](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.Scale.html)                   | Multiplies two vectors component-wise.                                                            |
| [SignedAngle](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.SignedAngle.html)       | Calculates the signed angle between two vectors, using a third vector to determine the sign.      |
| [Slerp](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.Slerp.html)                   | Spherically interpolates between two three-dimensional vectors.                                   |
| [SlerpUnclamped](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.SlerpUnclamped.html) | Spherically interpolates between two vectors.                                                     |
| [SmoothDamp](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.SmoothDamp.html)         | Gradually changes a vector towards a desired goal over time.                                      |

### Operators

| Operator                                                                                                    | Description                                                      |
|-------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------|
| [operator -](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3-operator_subtract.html)  | Subtracts one vector from another.                               |
| [operator !=](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3-operator_ne.html)       | Returns true if vectors are different.                           |
| [operator \*](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3-operator_multiply.html) | Multiplies a vector by a number.                                 |
| [operator /](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3-operator_divide.html)    | Divides a vector by a number.                                    |
| [operator +](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3-operator_add.html)       | Adds two three-dimensional vectors with component-wise addition. |
| [operator ==](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3-operator_eq.html)       | Returns true if two vectors are approximately equal.             |
