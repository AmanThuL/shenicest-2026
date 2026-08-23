---
title: "Scripting API: Object.DestroyImmediate"
page_title: "Unity - Scripting API: Object.DestroyImmediate"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.DestroyImmediate.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.DestroyImmediate.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Object](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html).DestroyImmediate

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-Object.html" class="switch-link gray-btn sbtn left show" title="Go to Object Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

## Declaration

public static void <span class="sig-kw">DestroyImmediate</span>([Object](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html) <span class="sig-kw">obj</span>, bool <span class="sig-kw">allowDestroyingAssets</span> = false);

### Parameters

| Parameter             | Description                                  |
|-----------------------|----------------------------------------------|
| obj                   | Object to be destroyed.                      |
| allowDestroyingAssets | Set to true to allow assets to be destroyed. |

### Description

Destroys the specified object immediately. Use with caution and in Edit mode only.

`DestroyImmediate` is intended for use in scripts that run in Edit mode, not at runtime. In Edit mode, the usual delayed destruction performed by `Destroy` does not occur, so immediate destruction is necessary.  
  
In runtime code, use [Object.Destroy](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.Destroy.html) instead. This call marks the object for destruction at the end of the current frame, which is safer and prevents many common issues. If you only want to deactivate a GameObject, use [GameObject.SetActive](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.SetActive.html) instead.  
  
Attempting to call `DestroyImmediate` during physics trigger/contact events, animation event callbacks, rendering callbacks, or [MonoBehaviour.OnValidate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnValidate.html) results in an error.  
  
Using `DestroyImmediate` with the optional `allowDestroyingAssets` parameter set to `true` can permanently remove assets from your project.  
  
Destroying or removing objects from a collection (such as an array or list) while looping through it can cause skipped elements, out-of-bounds errors, or other unpredictable behavior. This is a general programming risk, not unique to Unity.

``` codeExampleCS
// Select one or more GameObjects in your hierarchy.
// Go to the menu: Tools > Destroy Selected GameObjects Immediately.
// The selected GameObjects will be deleted from the scene immediately.

using UnityEngine;
using UnityEditor;

public class DestroyImmediateExample

        foreach (var go in selected)
        
        Debug.Log($"{selected.Length} GameObjects destroyed immediately.");
    }
}
```
