---
title: "Scripting API: JsonUtility"
page_title: "Unity - Scripting API: JsonUtility"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/JsonUtility.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/JsonUtility.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# JsonUtility

class in UnityEngine

/

Implemented in:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UnityEngine.JSONSerializeModule.html" class="cl">UnityEngine.JSONSerializeModule</a>

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

Provides functions for converting between objects and JSON data.

You can use this class to generate a JSON representation of an object, or to populate an object from a JSON string. This can be useful when interacting with web services that send and receive JSON data, or when you need to convert objects into a serializable format, such as when saving game state.  
  
The functions use the standard Unity serializer, which means they only serialize or deserialize the fields on an object, and only when the fields are of supported types. For more information about the Unity serializer, refer to [Serialization rules](https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-rules.html) in the Unity manual.  
  
The following example shows use of `JsonUtility` to save and load a game's state to the [PlayerPrefs](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayerPrefs.html).

``` codeExampleCS
using UnityEngine;
using System;
using System.Collections.Generic;

[Serializable]
public class GameState

    public static GameState CreateFromPlayerPrefs()
    
}
```

The object or type you pass to the functions must be a custom C# type you have defined. It must not be a primitive type such as `bool` or `string` or a collection type such as `List<T>` or an array. If you want to serialize a collection of objects to JSON, you must create a `class` or `struct` which has the collection as a member. Similarly, if you want to deserialize a JSON string, that JSON string must always have an object at the top level, not an array.  
  
Additional resources: [EditorJsonUtility](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorJsonUtility.html), [json-serialization](https://docs.unity3d.com/6000.3/Documentation/Manual/json-serialization.html).

### Static Methods

| Method                                                                                                                | Description                                                          |
|-----------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------|
| [FromJson](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/JsonUtility.FromJson.html)                   | Create an object from its JSON representation.                       |
| [FromJsonOverwrite](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/JsonUtility.FromJsonOverwrite.html) | Overwrite data in an object by reading from its JSON representation. |
| [ToJson](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/JsonUtility.ToJson.html)                       | Generate a JSON representation of the public fields of an object.    |
