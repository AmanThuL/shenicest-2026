---
title: "Scripting API: MonoBehaviour.OnValidate()"
page_title: "Unity - Scripting API: MonoBehaviour.OnValidate()"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnValidate.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnValidate.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html).OnValidate()

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-MonoBehaviour.html" class="switch-link gray-btn sbtn left show" title="Go to MonoBehaviour Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

### Description

Editor-only function that Unity calls when the script is loaded or a value changes in the Inspector.

Use this callback to validate serialized fields and enforce data constraints in response to Inspector edits. This is the primary intended use case for `OnValidate`.  
  
`OnValidate` can also be called at various stages during the Editor's normal operation, such as loading scenes, importing assets, building a Player, and entering Play mode. Because of this, don't treat `OnValidate` as a general-purpose callback for all property changes or Editor-side logic.  
  
`OnValidate` doesn't save anything itself. Values it assigns to serialized fields are written to disk only when the containing scene or asset is saved for another reason, such as an edit you make. When Unity calls `OnValidate` while loading or importing an object, Unity clears the object's dirty state afterwards, so that a loaded object always appears clean. Values assigned during a load aren't scheduled for saving, even if you call [EditorUtility.SetDirty](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorUtility.SetDirty.html) from `OnValidate`.  
  
Don't rely on `OnValidate` to persist computed values, especially in Prefabs. A Prefab Variant stores only explicitly edited values as property overrides, so a value that `OnValidate` assigns is not written to the variant's file, including when the variant is loaded, imported, or updated because its base Prefab changed. To persist a computed value in an asset, assign it from an explicit edit, for example from an [AssetPostprocessor.OnPostprocessAllAssets](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPostprocessAllAssets.html) callback that saves the Prefab using [PrefabUtility.SavePrefabAsset](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PrefabUtility.SavePrefabAsset.html).  
  
`OnValidate` can be called often when the user interacts with an Inspector in the Editor. It can also be called from threads other than Unity's main thread, such as the loading thread. For these reasons, only use `OnValidate` to validate the data that changed. Don't use it to do other tasks such as creating objects or calling other non-thread-safe Unity API.  
  
You can't reliably perform Camera rendering operations from `OnValidate`. Instead, add a listener to [EditorApplication.update](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorApplication-update.html), and perform the rendering during the next Editor Update call.  
  
Additional resources: [EditorApplication.update](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorApplication-update.html), [EditorApplication.delayCall](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorApplication-delayCall.html).

``` codeExampleCS
using UnityEngine;

public class Health : MonoBehaviour

}
```
