---
title: "Scripting API: UIElements.Button.clicked"
page_title: "Unity - Scripting API: UIElements.Button.clicked"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.Button-clicked.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.Button-clicked.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Button](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.Button.html).clicked

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

Callback triggered when the button is clicked.

This is a shortcut for modifying [Clickable.clicked](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.Clickable-clicked.html). It is provided as a convenience. When you add or remove actions from clicked, it adds or removes them from `Clickable.clicked` automatically.  
  
The following example shows how to use the clicked event to print a message to the console when the button is clicked.

``` codeExampleCS
using UnityEngine;
using UnityEditor;
using UnityEngine.UIElements;

public class ButtonExample : EditorWindow

    void CreateGUI()
    {
        var button = new Button { text = "Click me" };
        button.clicked += OnClick;

        rootVisualElement.Add(button);
    }

    void OnClick()
    
}
```
