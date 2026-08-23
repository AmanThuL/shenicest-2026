---
title: "Scripting API: AssetDatabase.CreateAsset"
page_title: "Unity - Scripting API: AssetDatabase.CreateAsset"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetDatabase.CreateAsset.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetDatabase.CreateAsset.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [AssetDatabase](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetDatabase.html).CreateAsset

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

public static void <span class="sig-kw">CreateAsset</span>([Object](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html) <span class="sig-kw">asset</span>, string <span class="sig-kw">path</span>);

### Parameters

| Parameter | Description                              |
|-----------|------------------------------------------|
| asset     | Object to use in creating the asset.     |
| path      | Project relative path for the new asset. |

### Description

Creates a new asset in a native Unity format.

Use this method to create an asset in one of Unity's native formats. For a list of native asset formats, refer to [Native asset importers reference](https://docs.unity3d.com/6000.3/Documentation/Manual/assets-supported-types.html).  
  
You can't use this method to create a prefab from a GameObject. To do this, use the [PrefabUtility](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PrefabUtility.html) class instead. You also can't use this method to create non-native assets, such as text files or image files.  
  
If an asset already exists at the path specified Unity overwrites it with the new asset. The path is relative to the project folder, for example: `Assets/MyStuff/hello.mat`. You must ensure that the path you provide uses a native asset extension, or Unity reports an error in the console. For example, `.mat` for materials, `.anim` for animations, or `.asset` for arbitrary other assets. For a list of native asset formats, refer to [Native asset importers reference](https://docs.unity3d.com/6000.3/Documentation/Manual/assets-supported-types.html).  
  
**Important:** You can't use this method to create assets in the `StreamingAssets` folder (Assets/StreamingAssets). If you attempt to create an asset in this folder, Unity reports an error in the console.  
  
An asset file can contain multiple assets. After you create an asset file, you can use [AssetDatabase.AddObjectToAsset](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetDatabase.AddObjectToAsset.html) to add additional assets to the file. When you add multiple objects to an asset, the order doesn't matter. No object serves as a root asset.  
  
Don't use this method to create assets during import, for example from within a ScriptedImporter or Postprocessor. Doing so can prevent the import process from producing consistent (deterministic) results, and reports a warning in the console. For more information, refer to [Check the consistency of the import process](https://docs.unity3d.com/6000.3/Documentation/Manual/ImporterConsistency.html).

``` codeExampleCS
using UnityEngine;
using UnityEditor;

public class CreateMaterialExample : MonoBehaviour

}
```
