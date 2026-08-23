---
title: "Scripting API: HeaderAttribute"
page_title: "Unity - Scripting API: HeaderAttribute"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/HeaderAttribute.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/HeaderAttribute.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# HeaderAttribute

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

Use this [PropertyAttribute](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PropertyAttribute.html) to add a header above some fields in the Inspector.

The header is done using a [DecoratorDrawer](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/DecoratorDrawer.html).

``` codeExampleCS
using UnityEngine;

public class Example : MonoBehaviour

```

### Properties

| Property                                                                                            | Description      |
|-----------------------------------------------------------------------------------------------------|------------------|
| [header](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/HeaderAttribute-header.html) | The header text. |

### Constructors

| Constructor                                                                                                | Description                                      |
|------------------------------------------------------------------------------------------------------------|--------------------------------------------------|
| [HeaderAttribute](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/HeaderAttribute-ctor.html) | Add a header above some fields in the Inspector. |

### Inherited Members

### Properties

| Property                                                                                                                    | Description                                                                             |
|-----------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------|
| [applyToCollection](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PropertyAttribute-applyToCollection.html) | Makes attribute affect collections instead of their items.                              |
| [order](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PropertyAttribute-order.html)                         | Optional field to specify the order that multiple DecorationDrawers should be drawn in. |
