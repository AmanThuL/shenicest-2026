---
title: "Unity 6.3 Manual: Serialization best practices"
page_title: "Unity - Manual: Serialization best practices"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-best-practices.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-best-practices.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Serialization best practices

Apply the following coding practices and organizational principles to prevent errors and optimize serialization performance in your project.

## Thread safety

Most Unity APIs can only be called from the main thread. Don’t call Unity APIs from constructors and field initializers of [serializable types](https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-rules.html) because these run on a separate loading thread.

In [development builds](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles-reference.html), Unity throws an error if you attempt to call main thread APIs from a loading thread. In a release build, the code runs without errors but can produce crashes and other unexpected behavior in your application.

**Tip**: To reduce the risk of errors during serialization, don’t call API methods that can influence the project state or that involve other Unity objects. APIs that are safe to call include [`Debug.Log`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.Log.html) and those that work on simple data types, such as [math functions](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Mathf.html) and [`Vector3`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html).

### Finalizers

Don’t initiate serialization from finalizer methods. Finalizers don’t run on the main thread. The [garbage collector](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-garbage-collector.html) determines when they run and in some circumstances they might not run at all.

Attempting to serialize data from a finalizer can lead to unexpected behavior and crashes. For more information, refer to the Microsoft documentation on [Finalizers](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/finalizers).

## Organizing your data

You can organize your data as follows to ensure optimal use of Unity’s serialization:

-   Aim to have Unity serialize the smallest possible set of data. The purpose of this isn’t to save space on your computer’s hard drive, but to make sure that you can maintain backwards compatibility with previous versions of the project. Backwards compatibility can become more difficult later on in development if you work with large sets of serialized data.
-   Never have Unity serialize duplicate data or cached data. This causes significant problems for backwards compatibility: it carries a high risk of error because data can get out of sync.
-   Use caution when adding fields that reference custom C# classes or structs. When you reference custom C# classes or structs in fields, Unity embeds the whole content of the referenced object in the serialized data of the referencing object. If this structure becomes complex or deeply nested then it can be hard to migrate this data as you change your structure in the future. Also the data from an object can easily be repeated unintentionally more than once in the serialized data. Instead, aim to keep the structure within your MonoBehaviour and ScriptableObject derived classes flat and simple.
-   The way to share data between Objects is to use [ScriptableObjects](https://docs.unity3d.com/6000.3/Documentation/Manual/class-ScriptableObject.html). When you reference a class derived from `UnityEngine.Object` (such as a class derived from ScriptableObject), Unity only serializes the reference and not the entire object graph. So the data is only serialized once, in the ScriptableObject, not at each point that references it. Similarly, you can use the [`[SerializeReference]`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SerializeReference.html) attribute if you want to reference the same custom C# class more than once within a single MonoBehaviour or ScriptableObject. For more information, refer to [Serialization of custom classes](https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-rules.html#CustomClasses).

## Additional resources

-   [Serialization rules](https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-rules.html)
-   [How Unity uses serialization](https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-how-unity-uses.html)
-   [JSONSerialization](https://docs.unity3d.com/6000.3/Documentation/Manual/json-serialization.html)
