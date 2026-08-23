---
title: "JSON Serialization"
page_title: "Unity - Manual: JSON Serialization"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/json-serialization.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/json-serialization.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# JSON Serialization

Use the [JsonUtility](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/JsonUtility.html) class to convert Unity objects to and from the [JSON](http://www.json.org) format. For example, you can use JSON Serialization to interact with web services, or to easily pack and unpack data to a text-based format.

JSON Serialization uses a notion of “structured” JSON: you create a class or structure to describe what variables you want to store in your JSON data. For example:

``` lang-cs
[Serializable]
public class MyClass

```

This defines a plain C# class containing three variables (**level**, **timeElapsed**, and **playerName**) and marks it with the `Serializable` attribute, in order to work with the JSON serializer. To create an instance of your class, you can use something like this:

``` lang-cs
MyClass myObject = new MyClass();
myObject.level = 1;
myObject.timeElapsed = 47.5f;
myObject.playerName = "Dr Charles Francis";
```

Then use the [JsonUtility.ToJson](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/JsonUtility.ToJson.html) method to serialize it (convert it) to the JSON format:

``` lang-cs
string json = JsonUtility.ToJson(myObject);
// json now contains: '{"level":1,"timeElapsed":47.5,"playerName":"Dr Charles Francis"}'
```

To convert the JSON back into an object, use [JsonUtility.FromJson](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/JsonUtility.FromJson.html):

``` lang-cs
myObject = JsonUtility.FromJson<MyClass>(json);
```

This creates a new instance of `MyClass` and sets the values on it using the JSON data. If the JSON data contains values that do not map to fields in `MyClass`, then the serializer ignores those values. If the JSON data is missing values for fields in `MyClass`, then the serializer leaves the constructed values for those fields in the returned object.

## Overwriting objects with JSON

You can also deserialize JSON data over an existing object, which overwrites any existing data:

``` lang-cs
JsonUtility.FromJsonOverwrite(json, myObject);
```

If the JSON data does not contain a value for a field, the serializer does not change that field’s value. This method allows you to keep allocations to a minimum by reusing objects that you created previously. It also allows you to “patch” objects by deliberately overwriting them with JSON that only contains a small subset of fields.

**Warning:** The JSON Serializer API supports [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html) and [ScriptableObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.html) subclasses as well as plain structs and classes. However, when deserializing JSON into subclasses of `MonoBehaviour` or `ScriptableObject`, you must use the [FromJsonOverwrite](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/JsonUtility.FromJsonOverwrite.html) method. If you try to use [FromJson](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/JsonUtility.FromJson.html), Unity throws an exception because this behavior is not supported.

## Supported types

The JSON Serializer API supports any `MonoBehaviour` subclass, `ScriptableObject` subclass, or plain class or struct with the `[Serializable]` attribute. When you pass in an object to the standard Unity serializer for processing, the same rules and limitations apply as they do in the Inspector: Unity serializes fields only; and types like `Dictionary<>` are not supported.

Unity does not support passing other types directly to the API, such as primitive types or arrays. If you need to convert those, wrap them in a `class` or `struct` of some sort.

In the Editor only, there is a parallel API, [EditorJsonUtility](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorJsonUtility.html), which allows you to serialize any object derived from [UnityEngine.Object](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html) both to and from JSON. This produces JSON that contains the same data as the YAML representation of the object.

[JsonUtility](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/JsonUtility.html) and [EditorJsonUtility](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorJsonUtility.html) are utility classes for serializing Objects to and from JSON’s string format using [Unity serialization rules](https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-rules.html). In cases where it’s necessary to manipulate JSON data through code, or to serialize data structures that Unity’s serialization doesn’t support, you can use a general purpose .NET JSON library as a companion to the JsonUtility API.

## Performance

Benchmark tests indicate that [JsonUtility](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/JsonUtility.html) is significantly faster than popular .NET JSON solutions, even though this class provides fewer features in some cases.

Memory usage for garbage collection (GC) is at a minimum:

-   [ToJson](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/JsonUtility.ToJson.html) allocates GC memory only for the returned string.
-   [FromJson](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/JsonUtility.FromJson.html) allocates GC memory only for the returned object, as well as any subobjects needed (for example, if you deserialize an object that contains an array, then Unity allocates GC memory for the array).
-   [FromJsonOverwrite](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/JsonUtility.FromJsonOverwrite.html) allocates GC memory only as necessary for written fields (for example, strings and arrays). This means that Unity does not allocate any GC memory at all if all the fields being overwritten by the JSON are value-typed.

You can use the JsonUtility API from a background thread. However, as with any multithreaded code, be careful not to access or alter an object on one thread while another thread is serializing or deserializing it.

## Controlling the output of ToJson()

The [ToJson](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/JsonUtility.ToJson.html) method supports pretty-printing the JSON output. It is off by default but you can turn it on by passing `true` as the second parameter.

You can omit fields from the output by using the `[NonSerialized]` attribute.

## Using FromJson() with unknown types

If you don’t know the type of an object ahead of time, deserialize the JSON into a class or struct that contains “common” fields, and then use the values of those fields to work out what actual type you want. Then deserialize a second time into that type.
