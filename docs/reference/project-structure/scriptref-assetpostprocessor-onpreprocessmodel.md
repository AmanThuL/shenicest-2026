---
title: "Scripting API: AssetPostprocessor.OnPreprocessModel"
page_title: "Unity - Scripting API: AssetPostprocessor.OnPreprocessModel()"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPreprocessModel.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPreprocessModel.html"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [AssetPostprocessor](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.html).OnPreprocessModel()

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

Add this function to a subclass to get a notification just before a model (.fbx, .mb file etc.) is imported.

This lets you control the import settings through code.

``` codeExampleCS
using UnityEngine;
using UnityEditor;

// Disable import of materials if the file contains
// the @ sign marking it as an animation.
public class Example : AssetPostprocessor

    void OnPreprocessModel()
    
    }
}
```
