---
title: "Scripting API: AssetPostprocessor.OnPreprocessTexture"
page_title: "Unity - Scripting API: AssetPostprocessor.OnPreprocessTexture()"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPreprocessTexture.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPreprocessTexture.html"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [AssetPostprocessor](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.html).OnPreprocessTexture()

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

Add this function to a subclass to get a notification just before the texture importer is run.

This lets you set up default values for the import settings.  
  
Use this callback if you want to change the compression format of the texture.

``` codeExampleCS
using UnityEngine;
using UnityEditor;

// Automatically convert any texture file with "_bumpmap"
// in its file name into a normal map.

class MyTexturePostprocessor : AssetPostprocessor

    void OnPreprocessTexture()
    
    }
}
```
