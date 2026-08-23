---
title: "Scripting API: JsonUtility.FromJson"
page_title: "Unity - Scripting API: JsonUtility.FromJson"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/JsonUtility.FromJson.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/JsonUtility.FromJson.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [JsonUtility](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/JsonUtility.html).FromJson

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

public static T <span class="sig-kw">FromJson</span>(string <span class="sig-kw">json</span>);

### Parameters

| Parameter | Description                            |
|-----------|----------------------------------------|
| json      | The JSON representation of the object. |

### Returns

**T** An instance of the object.

### Description

Create an object from its JSON representation.

Internally, this method uses the Unity serializer. The object you're creating and all its fields must meet the requirements for serialization by the Unity serializer. For the full list of these requirements, refer to [Serialization rules](https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-rules.html) in the manual.  
  
`FromJson` only supports plain classes and structures. It does not support classes derived from `UnityEngine.Object`, such as MonoBehaviour or ScriptableObject. To deserialize data into classes derived from MonoBehaviour or ScriptableObject, use [JsonUtility.FromJsonOverwrite](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/JsonUtility.FromJsonOverwrite.html) instead.  
  
Field initializers and any logic in the default constructor are executed during deserialization. After the instance is constructed, fields that appear in the supplied JSON representation are set to those values. Any fields missing from the JSON keep their values as assigned by the constructor or field initializers.  
  
If the input is null or empty, `FromJson` returns null.  
  
`FromJson` can be called from background threads.

``` codeExampleCS
using UnityEngine;

public class FromJsonTest : MonoBehaviour
{
    public static string completeJson = "{\"name\":\"Dr Charles\",\"lives\":3,\"health\":0.8}";
    // Partial JSON, missing lives and health. In this example, these fields will get their values from the initializer and constructor respectively.
    public static string partialJson = "{\"name\":\"Dr Charles\"}";

    void Start()
    
}

[System.Serializable]
public class PlayerInfo

    public static PlayerInfo CreateFromJSON(string jsonString)
    
}
```

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static object <span class="sig-kw">FromJson</span>(string <span class="sig-kw">json</span>, Type <span class="sig-kw">type</span>);

### Parameters

| Parameter | Description                                 |
|-----------|---------------------------------------------|
| json      | The JSON representation of the object.      |
| type      | The type of object represented by the Json. |

### Returns

**object** An instance of the object.

### Description

Create an object from its JSON representation.

Internally, this method uses the Unity serializer. The object you're creating and all its fields must meet the requirements for serialization by the Unity serializer. For the full list of these requirements, refer to [Serialization rules](https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-rules.html) in the manual.  
  
`FromJson` only supports plain classes and structures. It does not support classes derived from `UnityEngine.Object`, such as MonoBehaviour or ScriptableObject. To deserialize data into classes derived from MonoBehaviour or ScriptableObject, use [JsonUtility.FromJsonOverwrite](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/JsonUtility.FromJsonOverwrite.html) instead.  
  
Field initializers and any logic in the default constructor are executed during deserialization. After the instance is constructed, fields that appear in the supplied JSON representation are set to those values. Any fields missing from the JSON keep their values as assigned by the constructor or field initializers.  
  
`FromJson` can be called from background threads.
