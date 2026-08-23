---
title: "Scripting API: ISerializationCallbackReceiver"
page_title: "Unity - Scripting API: ISerializationCallbackReceiver"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ISerializationCallbackReceiver.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ISerializationCallbackReceiver.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# ISerializationCallbackReceiver

interface in UnityEngine

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

Interface for receiving callbacks before serialization and after deserialization, to process datatypes that can't otherwise be serialized or deserialized.

The Unity serializer can automatically serialize most data types, but not all of them. In cases where a data type can't be serialized, you can use the serialization callbacks defined in this interface to manually process the data into a serializable form. For more information on when and why manual processing is necessary, refer to [Custom serialization](https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-custom-serialization.html).  
  
Unity invokes `OnBeforeSerialize` just before an object is serialized. Inside this callback, you can transform your data into something Unity understands just before Unity serializes it. After the callback is complete, Unity serializes the arrays.  
  
Unity invokes `OnAfterDeserialize` after an object is deserialized. After Unity has written the data to your fields, use this callback to transform the deserialized data back into the form you want it to have at runtime.  
  
Work performed in these callbacks must be done with care, as the Unity serializer runs on a different thread from most of the Unity API. It's recommended to process only fields that are directly owned by the object, to keep the processing burden as low as possible.  
  
This interface supports serialization as reference, such as on objects decorated with the [SerializeReference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SerializeReference.html) attribute. The order of callback execution between these objects isn't guaranteed. However, the following execution orders are guaranteed:

-   `OnBeforeSerialize` is called on the host object before it's called on any of the host object's managed references.
-   `OnAfterDeserialize` is called on the host object before it's called on any of the host object's managed references.

For a full explanation of the `SerializeReference` attribute's behaviour, refer to [SerializeReference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SerializeReference.html). For more information on when and how Unity performs serialization, refer to [Script serialization](https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization.html) in the Manual.

``` codeExampleCS
using UnityEngine;
using System;
using System.Collections.Generic;

public class SerializationCallbackScript : MonoBehaviour, ISerializationCallbackReceiver
{
    public List<int> keys = new List<int> { 3, 4, 5 };
    public List<string> values = new List<string> { "I", "Love", "Unity" };

    // Create a Dictionary. The Unity serializer doesn't support Dictionary types.
    public Dictionary<int, string>  myDictionary = new Dictionary<int, string>();

    public void OnBeforeSerialize()
    
    }

    public void OnAfterDeserialize()
    
    void OnGUI()
    
}
```

Additional resources: [SerializeReference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SerializeReference.html), [SerializeField](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SerializeField.html).

### Public Methods

| Method                                                                                                                                     | Description                                                                                                        |
|--------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------|
| [OnAfterDeserialize](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ISerializationCallbackReceiver.OnAfterDeserialize.html) | Implement this callback to transform data back into runtime data types after an object is deserialized.            |
| [OnBeforeSerialize](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ISerializationCallbackReceiver.OnBeforeSerialize.html)   | Implement this callback to transform data into serializable data types immediately before an object is serialized. |
