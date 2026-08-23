---
title: "ScriptableObject.CreateInstance (Unity 6.3 Scripting API)"
page_title: "Unity - Scripting API: ScriptableObject.CreateInstance"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.CreateInstance.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.CreateInstance.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [ScriptableObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.html).CreateInstance

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-ScriptableObject.html" class="switch-link gray-btn sbtn left show" title="Go to ScriptableObject Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

## Declaration

public static [ScriptableObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.html) <span class="sig-kw">CreateInstance</span>(string <span class="sig-kw">className</span>);

<span style="color:red;"> </span>

## Declaration

public static [ScriptableObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.html) <span class="sig-kw">CreateInstance</span>(Type <span class="sig-kw">type</span>);

### Parameters

| Parameter | Description                                                            |
|-----------|------------------------------------------------------------------------|
| className | The type of the ScriptableObject to create, as the name of the type.   |
| type      | The type of the ScriptableObject to create, as a System.Type instance. |

### Returns

**ScriptableObject** The created ScriptableObject.

### Description

Creates an instance of a scriptable object.

To easily create a ScriptableObject instance that is bound to a .asset file via the Editor user interface, consider using [CreateAssetMenuAttribute](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/CreateAssetMenuAttribute.html).

``` codeExampleCS
using UnityEngine;

public class MyData : ScriptableObject

public class CreateInstance : MonoBehaviour

}
```

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static T <span class="sig-kw">CreateInstance</span>();

### Returns

**T** The created ScriptableObject.

### Description

Creates an instance of a scriptable object.

To easily create a ScriptableObject instance that is bound to a .asset file via the Editor user interface, consider using [CreateAssetMenuAttribute](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/CreateAssetMenuAttribute.html).

``` codeExampleCS
using UnityEngine;

public class MyData : ScriptableObject

public class CreateInstanceGeneric : MonoBehaviour

}
```
