---
title: "Scripting API: JsonUtility.ToJson"
page_title: "Unity - Scripting API: JsonUtility.ToJson"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/JsonUtility.ToJson.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/JsonUtility.ToJson.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [JsonUtility](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/JsonUtility.html).ToJson

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

## Declaration

public static string <span class="sig-kw">ToJson</span>(object <span class="sig-kw">obj</span>);

<span style="color:red;"> </span>

## Declaration

public static string <span class="sig-kw">ToJson</span>(object <span class="sig-kw">obj</span>, bool <span class="sig-kw">prettyPrint</span>);

### Parameters

| Parameter   | Description                                                                                                 |
|-------------|-------------------------------------------------------------------------------------------------------------|
| obj         | The object to convert to JSON form.                                                                         |
| prettyPrint | If true, format the output for readability. If false, format the output for minimum size. Default is false. |

### Returns

**string** The object's data in JSON format.

### Description

Generate a JSON representation of the public fields of an object.

Internally, this method uses the Unity serializer. The object you pass in and all its fields must meet the requirements for serialization by the Unity serializer. For the full list of these requirements, refer to [Serialization rules](https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-rules.html) in the manual.  
  
`ToJson` supports any plain class or structure and classes derived from MonoBehaviour or ScriptableObject. Other engine types are not supported. In the Editor only, you can use [EditorJsonUtility.ToJson](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorJsonUtility.ToJson.html) to serialize other engine types to JSON.  
  
If the object contains fields with references to other Unity objects, those references are serialized by recording the InstanceID for each referenced object. Because the Instance ID acts like a handle to the in-memory object instance, the JSON string can only be deserialized back during the same session of the Unity engine.  
  
Note that while `ToJson` acccepts primitive types, instead of serializing them directly, it attempts to serialize their public instance fields, producing an empty object as a result. Similarly, passing an array does not produce a JSON array containing each element, but an object containing the public fields of the array object itself (of which there are none). To serialize the actual content of an array or primitive type, you must wrap it in a class or struct.  
  
`ToJson` can be called from background threads. You should not alter the object that you pass to this function while it is still executing.  
  
Additional resources: [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html), [ScriptableObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.html), [Object.GetInstanceID](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.GetInstanceID.html)

``` codeExampleCS
using UnityEngine;

public class PlayerState : MonoBehaviour

    // Given:
    // playerName = "Dr Charles"
    // lives = 3
    // health = 0.8f
    // SaveToString returns:
    // 
}
```
