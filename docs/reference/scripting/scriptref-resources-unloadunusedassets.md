---
title: "Scripting API: Resources.UnloadUnusedAssets"
page_title: "Unity - Scripting API: Resources.UnloadUnusedAssets"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.UnloadUnusedAssets.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.UnloadUnusedAssets.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Resources](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.html).UnloadUnusedAssets

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

## Declaration

public static [AsyncOperation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AsyncOperation.html) <span class="sig-kw">UnloadUnusedAssets</span>();

### Returns

**AsyncOperation** Object on which you can yield to wait until the operation completes.

### Description

Unloads assets that are not used.

An asset is deemed to be unused if it isn't reached after walking the whole game object hierarchy, including script components. Static variables are also examined.  
  
The script execution stack, however, is **not** examined so an asset referenced only from within the script stack will be unloaded. All assets other than ScriptableObjects are loaded back in the next time one of its properties or methods is used. This requires extra care for assets which have been modified in memory. Make sure to call [EditorUtility.SetDirty](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorUtility.SetDirty.html) before an asset garbage collection is triggered.  
  
Additional resources: [EditorUtility.UnloadUnusedAssetsImmediate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorUtility.UnloadUnusedAssetsImmediate.html).
