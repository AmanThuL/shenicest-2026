---
title: "Scripting API: Vector2"
page_title: "Unity - Scripting API: Vector2"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Vector2

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

Representation of 2D vectors and points.

This structure is used in some places to represent 2D positions and vectors (e.g. texture coordinates in a [Mesh](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mesh.html) or texture offsets in [Material](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.html)). In the majority of other cases a Vector3 is used.

### Static Properties

| Property                                                                                                        | Description                                                                    |
|-----------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------|
| [down](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2-down.html)                         | Shorthand for writing Vector2(0, -1).                                          |
| [left](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2-left.html)                         | Shorthand for writing Vector2(-1, 0).                                          |
| [negativeInfinity](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2-negativeInfinity.html) | Shorthand for writing Vector2(float.NegativeInfinity, float.NegativeInfinity). |
| [one](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2-one.html)                           | Shorthand for writing Vector2(1, 1).                                           |
| [positiveInfinity](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2-positiveInfinity.html) | Shorthand for writing Vector2(float.PositiveInfinity, float.PositiveInfinity). |
| [right](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2-right.html)                       | Shorthand for writing Vector2(1, 0).                                           |
| [up](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2-up.html)                             | Shorthand for writing Vector2(0, 1).                                           |
| [zero](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2-zero.html)                         | Shorthand for writing Vector2(0, 0).                                           |

### Properties

| Property                                                                                                 | Description                                                                                                                                                                                                                        |
|----------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [magnitude](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2-magnitude.html)        | Returns the length of this vector (Read Only).                                                                                                                                                                                     |
| [normalized](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2-normalized.html)      | Returns a normalized vector based on the current vector. The normalized vector has a magnitude of 1 and is in the same direction as the current vector. Returns a zero vector If the current vector is too small to be normalized. |
| [sqrMagnitude](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2-sqrMagnitude.html)  | Returns the squared length of this vector (Read Only).                                                                                                                                                                             |
| [this\[int\]](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2.Index_operator.html) | Access the x or y component using \[0\] or \[1\] respectively.                                                                                                                                                                     |
| [x](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2-x.html)                        | X component of the vector.                                                                                                                                                                                                         |
| [y](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2-y.html)                        | Y component of the vector.                                                                                                                                                                                                         |

### Constructors

| Constructor                                                                                | Description                                         |
|--------------------------------------------------------------------------------------------|-----------------------------------------------------|
| [Vector2](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2-ctor.html) | Constructs a new vector with given x, y components. |

### Public Methods

| Method                                                                                          | Description                                                     |
|-------------------------------------------------------------------------------------------------|-----------------------------------------------------------------|
| [Equals](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2.Equals.html)     | Determines if the given vector is exactly equal to this vector. |
| [Set](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2.Set.html)           | Set x and y components of an existing Vector2.                  |
| [ToString](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2.ToString.html) | Formats this vector as a string.                                |

### Static Methods

| Method                                                                                                      | Description                                                                                                                                                                                   |
|-------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Angle](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2.Angle.html)                   | Gets the unsigned angle in degrees between from and to.                                                                                                                                       |
| [ClampMagnitude](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2.ClampMagnitude.html) | Creates a copy of a given vector, with its magnitude clamped to a maximum length.                                                                                                             |
| [Distance](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2.Distance.html)             | Returns the distance between a and b.                                                                                                                                                         |
| [Dot](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2.Dot.html)                       | Calculates the dot product of two vectors.                                                                                                                                                    |
| [Lerp](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2.Lerp.html)                     | Linearly interpolates between vectors a and b by t.                                                                                                                                           |
| [LerpUnclamped](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2.LerpUnclamped.html)   | Linearly interpolates between vectors a and b by t.                                                                                                                                           |
| [Max](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2.Max.html)                       | Creates a vector that is made from the largest components of two vectors.                                                                                                                     |
| [Min](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2.Min.html)                       | Creates a vector that is made from the smallest components of two vectors.                                                                                                                    |
| [MoveTowards](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2.MoveTowards.html)       | Moves a point current towards target.                                                                                                                                                         |
| [Normalize](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2.Normalize.html)           | Makes this vector have a magnitude of 1.                                                                                                                                                      |
| [Perpendicular](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2.Perpendicular.html)   | Returns the 2D vector perpendicular to this 2D vector. The result is always rotated 90-degrees in a counter-clockwise direction for a 2D coordinate system where the positive Y axis goes up. |
| [Reflect](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2.Reflect.html)               | Reflects a vector off the surface defined by a normal.                                                                                                                                        |
| [Scale](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2.Scale.html)                   | Multiplies two vectors component-wise.                                                                                                                                                        |
| [SignedAngle](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2.SignedAngle.html)       | Gets the signed angle in degrees between from and to.                                                                                                                                         |
| [SmoothDamp](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2.SmoothDamp.html)         | Gradually changes a vector towards a desired goal over time.                                                                                                                                  |

### Operators

| Operator                                                                                                    | Description                                          |
|-------------------------------------------------------------------------------------------------------------|------------------------------------------------------|
| [operator -](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2-operator_subtract.html)  | Subtracts one vector from another.                   |
| [operator \*](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2-operator_multiply.html) | Multiplies a vector by a number.                     |
| [operator /](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2-operator_divide.html)    | Divides a vector by a number.                        |
| [operator +](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2-operator_add.html)       | Adds two vectors.                                    |
| [operator ==](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2-operator_eq.html)       | Returns true if two vectors are approximately equal. |
| [Vector2](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2-operator_Vector3.html)      | Converts a Vector3 to a Vector2.                     |
| [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector2-operator_Vector2.html)      | Converts a Vector2 to a Vector3.                     |
