---
title: "Scripting API: SerializeField"
page_title: "Unity - Scripting API: SerializeField"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SerializeField.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SerializeField.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# SerializeField

class in UnityEngine

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

Force Unity to serialize a private field.

Unity only serializes public fields by default. To serialize private fields, add the `[SerializeField]` attribute to them.  
  
Unity serializes all your script components, reloads the new assemblies, and recreates your script components from the serialized versions. This serialization is done with an internal Unity serialization system; not with .NET's serialization functionality.  
  
For a full reference of what Unity can serialize, refer to [Serialization rules](https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-rules.html).  
  
Additional resources: [SerializeReference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SerializeReference.html)

``` codeExampleCS
using UnityEngine;

public class SomePerson : MonoBehaviour

}
```
