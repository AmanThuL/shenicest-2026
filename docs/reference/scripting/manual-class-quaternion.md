---
title: "Unity 6.3 Manual: Programming with the Quaternion class"
page_title: "Unity - Manual: Programming with the Quaternion class"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-Quaternion.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-Quaternion.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Programming with the Quaternion class

<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.html" class="switch-link gray-btn sbtn left" title="Go to Quaternion page in the Scripting Reference">Switch to Scripting</a>

Unity uses the Quaternion class to store the three dimensional orientation of GameObjects, as well as using them to describe a relative rotation from one orientation to another.

This page provides an overview of the Quaternion class and its common uses when scripting with it. For an exhaustive reference of every member of the Quaternion class, see the [Quaternion script reference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.html).

It’s important to understand the difference between Euler angles (the X, Y, & Z values that you see in the inspector for the rotation of a GameObject), and the underlying Quaternion value which Unity uses to store the actual rotation of GameObjects. For the basics of this topic, read [Rotation and Orientation in Unity](https://docs.unity3d.com/6000.3/Documentation/Manual/QuaternionAndEulerRotationsInUnity.html).

When dealing with handling rotations in your scripts, you should use the Quaternion class and its functions to create and modify rotational values. There are some situations where it is valid to use Euler angles, but you should bear in mind: - You should use the Quaternion Class functions that deal with Euler angles - Retrieving, modifying, and re-applying Euler values from a rotation can cause unintentional side-effects (see below)

## Creating and manipulating quaternions directly

Unity’s Quaternion class has a number of functions which allow you to create and manipulate rotations without needing to use Euler angles at all, and these are the ones you should use in most typical cases. Each of these links to the Script Reference with code samples:

### Creating Rotations:

-   [`Quaternion.LookRotation`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.LookRotation.html)
-   [`Quaternion.Angle`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.Angle.html)
-   [`Quaternion.AngleAxis`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.AngleAxis.html)
-   [`Quaternion.FromToRotation`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.FromToRotation.html)

### Manipulating Rotations:

-   [`Quaternion.Slerp`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.Slerp.html)
-   [`Quaternion.Inverse`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.Inverse.html)
-   [`Quaternion.RotateTowards`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.RotateTowards.html)

The Transform class also provides methods which allow you to work with the Quaternion rotations:

-   [`Transform.Rotate`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.Rotate.html) & [`Transform.RotateAround`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.RotateAround.html)

## Working with Euler angles

In some cases it’s more desirable to use Euler angles in your scripts. When doing so, it’s important to note that you must keep your angles in variables, and only use them to *apply* them as Euler angles to your rotation, which should still ultimately be stored as a Quaternion. While it’s possible to retrieve Euler angles *from* a quaternion, if you retrieve, modify and re-apply, problems are likely to arise.

You can read more detail about exactly how these problems can arise in the [eulerAngles script reference page](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion-eulerAngles.html).

Here are some examples of **mistakes** commonly made using a hypothetical example of trying to rotate a GameObject around the X axis at 10 degrees per second. This is what you should **avoid**:

``` lang-cs
// rotation scripting mistake #1
// the mistake here is that we are modifying the x value of a quaternion
// this value does not represent an angle, and does not produce desired results
    
void Update () 

```

``` lang-cs
// rotation scripting mistake #2
// Read, modify, then write the Euler values from a Quaternion.
// Because these values are calculated from a Quaternion,
// each new rotation might return very different Euler angles, which might suffer from gimbal lock.
        
void Update () 

```

And here is an example of using Euler angles in script **correctly**:

``` lang-cs
// Rotation scripting with Euler angles correctly.
// Store the Euler angle in a class variable, and only use it to
// apply it as an Euler angle, but never rely on reading the Euler back.
        
float x;
void Update () 

```

## Additional resources

-   [Quaternion and euler rotations in Unity](https://docs.unity3d.com/6000.3/Documentation/Manual/QuaternionAndEulerRotationsInUnity.html)
-   [`Quaternion` API reference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.html)
