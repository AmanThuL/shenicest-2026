---
title: "Scripting API: AddComponentMenu"
page_title: "Unity - Scripting API: AddComponentMenu"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AddComponentMenu.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AddComponentMenu.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# AddComponentMenu

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

The AddComponentMenu attribute allows you to place a script anywhere in the "Component" menu, instead of just the "Component->Scripts" menu.

You can use this to organize the Component menu better and improve the workflow of adding scripts.

``` codeExampleCS
using UnityEngine;

[AddComponentMenu("Transform/Follow Transform")]
public class FollowTransform : MonoBehaviour

```

### Properties

| Property                                                                                                             | Description                                                                                |
|----------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------|
| [componentOrder](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AddComponentMenu-componentOrder.html) | The order of the component in the component menu (lower values appear higher in the menu). |

### Constructors

| Constructor                                                                                                  | Description                        |
|--------------------------------------------------------------------------------------------------------------|------------------------------------|
| [AddComponentMenu](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AddComponentMenu-ctor.html) | Add an item in the Component menu. |
