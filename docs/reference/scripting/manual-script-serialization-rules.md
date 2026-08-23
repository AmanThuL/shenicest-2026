---
title: "Unity 6.3 Manual: Serialization rules"
page_title: "Unity - Manual: Serialization rules"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-rules.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-rules.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Serialization rules

Unity uses its own serialization system, which is specifically designed to operate efficiently at runtime. Because of this, serialization in Unity behaves differently to serialization in other programming environments.

Unity supports the standard .NET/C# [`[Serializable]`](https://learn.microsoft.com/en-us/dotnet/api/system.serializableattribute?view=net-9.0) and [`[NonSerialized]`](https://learn.microsoft.com/en-us/dotnet/api/system.nonserializedattribute?view=net-9.0) attributes, but their behavior in Unity is subject to additional Unity-specific considerations. Unity won’t automatically serialize a class marked `[Serializable]` unless it meets the Unity serialization rules outlined in the following sections.

Unity automatically serializes built-in Unity types that inherit from [`UnityEngine.Object`](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Object.html), so you only need to apply `[Serializable]` to custom classes or structs used as fields in these Unity objects. The `[NonSerialized]` attribute is used in Unity as in standard C# to exclude fields from serialization. However, in the Unity context this also prevents the Inspector from serializing or displaying that field. Unity has its own attribute, [`[HideInInspector]`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/HideInInspector.html), which hides the field in the Inspector without preventing serialization.

**Important**: To serialize structs or custom classes not derived from [`UnityEngine.Object`](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Object.html), you must annotate them with `[Serializable]`. Note that the `[Serializable]` attribute is not automatically inherited by subclasses and must be applied to all classes in a class hierarchy. The Unity Editor issues warnings about incorrect usage. For more information, refer to [Serialization of custom classes](https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-rules.html#CustomClasses).

## Field serialization rules

Serializers in Unity work directly on the **fields** of your C# classes rather than their properties, so Unity only serializes your fields if they meet certain conditions. The following section outlines how to use field serialization in Unity.

To use field serialization you must ensure that the field:

-   Is `public`, or has a [`[SerializeField]`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SerializeField.html) attribute
    -   **Note**: In some cases `private` fields are serialized, refer to [Hot reloading](https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-how-unity-uses.html#hot-reload)
-   Is not `static`
-   Is not `const`
-   Is not `readonly`
-   Has a field type that can be serialized:
    -   Primitive data types (int, float, double, bool, string, etc.).
    -   Enum types (32 bits or smaller).
    -   Fixed-size buffers.
    -   Unity built-in types, for example, Vector2, Vector3, Rect, Matrix4x4, Color, AnimationCurve.
    -   Custom structs with the `[Serializable]` attribute.
    -   References to objects that derive from [UnityEngine.Object](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html).
    -   Custom classes with the `[Serializable]` attribute. (Refer to [Serialization of custom classes](https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-rules.html#CustomClasses)).
    -   An array or `List<T>` of one of the previously listed field types. With default serialization by value, if one element appears in a list or array twice, the serialized version of the collection will have two copies of that element, rather than one copy that appears twice. When serializing a collection of classes by reference, multiple references to the same object are preserved. For more information, refer to the [`[SerializeReference]` API documentation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SerializeReference.html).

**Note**: Unity doesn’t support serialization of multilevel types (multidimensional arrays, jagged arrays, dictionaries, and nested container types). If you want to serialize these, you have two options:

-   Wrap the nested type in a class or struct
-   Use serialization callbacks, by implementing [ISerializationCallbackReceiver](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ISerializationCallbackReceiver.html), to perform [custom serialization](https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-custom-serialization.html).

## <span id="CustomClasses"></span> Serialization of custom classes

For Unity to serialize a custom class, you must ensure the class:

-   Has the [`[Serializable]`](https://learn.microsoft.com/en-us/dotnet/api/system.serializableattribute?view=net-9.0) attribute.
-   Is not static.

When you assign an instance of a `UnityEngine.Object`-derived class to a field and Unity saves that field, Unity serializes the field as a reference to that instance. Unity serializes the instance itself independently, so it isn’t duplicated when multiple fields are assigned to the instance. But for custom classes which don’t derive from `UnityEngine.Object`, Unity includes the state of the instance directly in the serialized data of the MonoBehaviour or ScriptableObject that references them. There are two ways that this can happen: **inline** and by **`[SerializeReference]`**.

-   **Inline serialization**: By default, Unity serializes custom classes inline by value when you don’t specify `[SerializeReference]` on the field that references the class. This means that if you store a reference to an instance of a custom class in several different fields, they become separate objects when serialized. Then, when Unity deserializes the fields, they contain different distinct objects with identical data.
-   **`[SerializeReference]` serialization**: If you do specify `[SerializeReference]`, Unity establishes the object as a managed reference. The host object still stores the objects directly in its serialized data, but in a dedicated registry section.

`[SerializeReference]` adds some overhead but supports the following cases:

-   Fields can be null. Inline serialization can’t represent null, instead, it replaces null with an inline object that has unassigned fields.
-   Multiple references to the same object. If you store a reference to an instance of a custom class in several different fields without using `[SerializeReference]`, then they become separate objects when serialized.
-   Graphs and cyclical data (for example, an object that has a reference back to itself). Inline class serialization doesn’t support null or shared references, so any cycle in data can lead to unexpected results, such as strange Inspector behavior, console errors or infinite loops.
-   Polymorphism. If you create a class that derives from a parent class and assign it to a field that uses the parent class as its type, without `[SerializeReference]` Unity only serializes the fields that belong to the parent class. When Unity deserializes the class instance, it instantiates the parent class instead of the derived class.
-   When a data structure requires a stable identifier to point to a specific object without hard-coding the object’s array position or searching the entire array. Refer to [Serialization.ManagedReferenceUtility.SetManagedReferenceIdForObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Serialization.ManagedReferenceUtility.SetManagedReferenceIdForObject.html).

**Note**: Inline serialization is more efficient, and you should use it unless you specifically need one of the features that `[SerializeReference]` supports. For full details on how to use `[SerializeReference]`, refer to the [SerializeReference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SerializeReference.html) documentation.

When you use `[SerializeReference]`, Unity doesn’t strictly enforce `[Serializable]`, but displays a warning in the Console if a class isn’t marked `[Serializable]`. You can supress this warning with the [`[MakeSerializable]`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MakeSerializableAttribute.html) attribute.

## Serialization of properties

Unity doesn’t serialize properties. However, if the property is backed by a field, the field can be serialized.

-   If a property has an explicit backing field, Unity serializes it according to regular serialization rules. For example:

``` lang-cs
public int MyInt

[SerializeField] private int m_backing;
```

-   If a property is an auto-property, then a private backing field is generated for it implicitly by the compiler, and the regular serialization rules apply to this backing field. You can apply attributes to this field by using the `field:` prefix on attributes for the property. For example:

``` lang-cs
// Serialize the implicit backing field behind this property
[field: SerializeField]
public int MyInt 
// Serialize the implicit backing field behind this property as a reference instead of inline
[field: SerializeReference]
public MyType MyReferenceToType 
// Do not serialize the backing field for this property even when hot-reloading
[field: NonSerialized]
public bool NeverSerializedProperty 
```

## Additional resources

-   [Custom serialization](https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-custom-serialization.html)
-   [How Unity uses serialization](https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-how-unity-uses.html)
-   [JSONSerialization](https://docs.unity3d.com/6000.3/Documentation/Manual/json-serialization.html)
-   [Serialization best practices](https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-best-practices.html)
