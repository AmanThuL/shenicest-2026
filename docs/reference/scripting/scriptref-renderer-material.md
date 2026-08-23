---
title: "Scripting API: Renderer.material"
page_title: "Unity - Scripting API: Renderer.material"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-material.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-material.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Renderer](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer.html).material

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

<span style="color:red;"> </span>public [Material](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.html) <span class="sig-kw">material</span>;

### Description

Returns the first instantiated [Material](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.html) assigned to the renderer.

Modifying `material` will change the material for this object only.  
  
If the material is used by any other renderers, this will clone the shared material and start using it from now on.  
  
**Note:**  
This function automatically instantiates the materials and makes them unique to this renderer. It is your responsibility to destroy the materials when the game object is being destroyed. [Resources.UnloadUnusedAssets](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.UnloadUnusedAssets.html) also destroys the materials but it is usually only called when loading a new level.

``` codeExampleCS
using UnityEngine;
using System.Collections;

public class ExampleClass : MonoBehaviour

    void Update()
    
    }

    void OnMouseOver()
    
    void OnMouseExit()
    
    void OnDestroy()
    
}
```
