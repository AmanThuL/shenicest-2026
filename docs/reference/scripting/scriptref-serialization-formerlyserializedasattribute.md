---
title: "Scripting API: Serialization.FormerlySerializedAsAttribute"
page_title: "Unity - Scripting API: FormerlySerializedAsAttribute"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Serialization.FormerlySerializedAsAttribute.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Serialization.FormerlySerializedAsAttribute.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# FormerlySerializedAsAttribute

class in UnityEngine.Serialization

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

Use this attribute to rename a field without losing its serialized value.

This is an Editor-only attribute and can't be used at runtime. For example, if you have a class like this:

``` codeExampleCS
using UnityEngine;

public class MyMonster : MonoBehaviour

```

And you would now like to rename this field. You can achieve that by using this attribute:

``` codeExampleCS
using UnityEngine;
using UnityEngine.Serialization;

public class MyMonster : MonoBehaviour

```

Unity serializes public variables by default. To serialize private variables, use the SerializeField attribute. For more information, see the [Script Serialization documentation](https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization.html).

### Properties

| Property                                                                                                                          | Description                              |
|-----------------------------------------------------------------------------------------------------------------------------------|------------------------------------------|
| [oldName](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Serialization.FormerlySerializedAsAttribute-oldName.html) | The name of the field before the rename. |

### Constructors

| Constructor                                                                                                                                          | Description |
|------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| [FormerlySerializedAsAttribute](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Serialization.FormerlySerializedAsAttribute-ctor.html) |             |
