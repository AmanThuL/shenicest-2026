---
title: "Object (Unity 6.3 Manual)"
page_title: "Unity - Manual: Object"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-Object.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-Object.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Object

<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html" class="switch-link gray-btn sbtn left" title="Go to Object page in the Scripting Reference">Switch to Scripting</a>

The `UnityEngine.Object` class acts as a base class for all objects that Unity can reference in the Unity Editor. You can drag and drop classes that inherit from `UnityEngine.Object` into fields in the Inspector, or pick them using the Object Picker next to an Object field.

![An example of an Object Field in the Inspector window. The Object Picker is the circular icon to the right of the field.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/ExampleObjectField.png)

Rather than inheriting directly from `Object` for your own custom classes, it’s often better to inherit from a class designed to be more specific to your goal. For example:

-   Inherit from `MonoBehaviour` if you want to write a custom component which you can add to a `GameObject`, to control what the `GameObject` does or provide some functionality relating to it.
-   Inherit from `ScriptableObject` if you want to create custom assets which can store serialized data.

Both of these inherit from `UnityEngine.Object` but provide extra functionality to suit those purposes.

**Note:** `UnityEngine.Object` is different from .NET’s base `System.Object`, which is not included in the default script template so that the names don’t clash. You can still inherit from .NET’s `System.Object` if you want to create classes which you don’t need to assign in the Inspector.

The `Object` class provides methods for instantiating and destroying Objects and for finding references to Objects of a specific type. For more information on the API for the Object class, refer to the [script reference page for Object](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html).

## Special behavior of UnityEngine.Object

`UnityEngine.Object` is a special type of C# object in Unity, because it’s linked to an unmanaged (C++) counterpart object. For example, when you use a [Camera](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Camera.html) component, Unity stores the state of the Object on the Object’s C++ counterpart, not on the C# Object itself.

![Two containers side-by-side represent the unmanaged and managed layers of the Unity Engine. Each container has its own representation of UnityEngine.Object. Connecting lines between the two layers demonstrate the link between the managed Object instance and its unmanaged counterpart.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/unity-engine-object.png)

Unity doesn’t currently support the use of the C# `WeakReference` class with instances of `UnityEngine.Object`. For this reason, you shouldn’t use a `WeakReference` to reference a loaded asset. Refer to Microsoft’s [WeakReference documentation](https://docs.microsoft.com/en-us/dotnet/api/system.weakreference?view=netcore-3.1) for more information on the `WeakReference` class.

### Unity C# and Unity C++ share UnityEngine Objects

When you use a method such as [Object.Destroy](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.Destroy.html) or [Object.DestroyImmediate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.DestroyImmediate.html) to destroy an object derived from `UnityEngine.Object`, Unity destroys (unloads) the C++ counterpart object. You can’t destroy the C# object with an explicit call, because the garbage collector manages the memory. Once there are no longer any references to the managed object, the garbage collector collects and destroys it.

If your application tries to access a destroyed `UnityEngine.Object` again, Unity recreates the native counterpart object for most types. Two exceptions to this recreation behavior are [MonoBehaviours](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html) and [ScriptableObjects](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.html): Unity never reloads them once they have been destroyed.

<span id="custom-equality-operators"></span>

### Custom equality operators

For types that inherit from [UnityEngine.Object](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Object.html), Unity uses a custom version of the C# [equality and inequality operators](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/operators/equality-operators). This means the null check `myGameObject == null` can evaluate `true` (and conversely `myGameObject != null` can evaluate `false`) even if `myGameObject` technically holds a valid C# object reference. This happens in two cases:

1.  The object can be a so-called fake null or placeholder object which Unity uses in the Editor only to populate uninitialized MonoBehaviour fields. These objects store useful debugging information to help you locate the source of these fields if you try to reference them.
2.  The object can be a managed (C#) object which has not yet been garbage collected but which should be considered null because the unmanaged (C++) counterpart object has been destroyed.

Because you can’t overload the `??` and `?.` operators, they aren’t compatible with objects that derive from `UnityEngine.Object`. The operators don’t return the same results as the equality and inequality operators when you use them on a destroyed `MonoBehaviour` or `ScriptableObject` while the managed object still exists.

## Additional resources

-   [`UnityEngine.Object` API reference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html)
