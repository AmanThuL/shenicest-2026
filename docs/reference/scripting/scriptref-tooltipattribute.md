---
title: "Scripting API: TooltipAttribute"
page_title: "Unity - Scripting API: TooltipAttribute"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/TooltipAttribute.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/TooltipAttribute.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# TooltipAttribute

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

Specify a tooltip for a field in the Inspector window.

![](https://docs.unity3d.com/6000.3/Documentation/StaticFiles/ScriptRefImages/tooltip.png)  
*Tooltip hovering over the class it was added to.*  
  
In the following script a `Tooltip` is added. This provides information to the user about the range of values for the `health` variable. The suggested range is provided in the `TooltipAttribute` string.  
  
Note: Unity will only use Tooltips from Fields when displaying them in the Editor. You can add Tooltips to other areas, such as classes, structs, and properties to work with user created editor extensions, but Unity won't display them in the Editor.

``` codeExampleCS
using UnityEngine;

public class Example : MonoBehaviour

```

### Properties

| Property                                                                                               | Description       |
|--------------------------------------------------------------------------------------------------------|-------------------|
| [tooltip](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/TooltipAttribute-tooltip.html) | The tooltip text. |

### Constructors

| Constructor                                                                                                  | Description                    |
|--------------------------------------------------------------------------------------------------------------|--------------------------------|
| [TooltipAttribute](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/TooltipAttribute-ctor.html) | Specify a tooltip for a field. |

### Inherited Members

### Properties

| Property                                                                                                                    | Description                                                                             |
|-----------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------|
| [applyToCollection](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PropertyAttribute-applyToCollection.html) | Makes attribute affect collections instead of their items.                              |
| [order](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PropertyAttribute-order.html)                         | Optional field to specify the order that multiple DecorationDrawers should be drawn in. |
