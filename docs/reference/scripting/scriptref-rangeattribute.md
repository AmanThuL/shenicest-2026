---
title: "Scripting API: RangeAttribute"
page_title: "Unity - Scripting API: RangeAttribute"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RangeAttribute.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RangeAttribute.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# RangeAttribute

class in UnityEngine

/

Inherits from:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PropertyAttribute.html" class="cl">PropertyAttribute</a>

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

Attribute used to make a float or int variable in a script be restricted to a specific range.

When this attribute is used, the float or int will be shown as a slider in the Inspector instead of the default number field.

``` codeExampleCS
using UnityEngine;

public class Example : MonoBehaviour

```

### Constructors

| Constructor                                                                                              | Description                                                                                   |
|----------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------|
| [RangeAttribute](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RangeAttribute-ctor.html) | Attribute used to make a float or int variable in a script be restricted to a specific range. |

### Inherited Members

### Properties

| Property                                                                                                                    | Description                                                                             |
|-----------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------|
| [applyToCollection](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PropertyAttribute-applyToCollection.html) | Makes attribute affect collections instead of their items.                              |
| [order](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PropertyAttribute-order.html)                         | Optional field to specify the order that multiple DecorationDrawers should be drawn in. |
