---
title: "Scripting API: AssetDatabase.LoadAssetAtPath"
page_title: "Unity - Scripting API: AssetDatabase.LoadAssetAtPath"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetDatabase.LoadAssetAtPath.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetDatabase.LoadAssetAtPath.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [AssetDatabase](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetDatabase.html).LoadAssetAtPath

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

public static Object <span class="sig-kw">LoadAssetAtPath</span>(string <span class="sig-kw">assetPath</span>, Type <span class="sig-kw">type</span>);

### Parameters

| Parameter | Description                                                                                                    |
|-----------|----------------------------------------------------------------------------------------------------------------|
| assetPath | The project-relative path of the asset to load.                                                                |
| type      | The type of asset to load. This type must derive from `UnityEngine.Object`, for example `Texture2D` or `Mesh`. |

### Returns

**Object** The first asset object of type `type` at given path `assetPath`.

### Description

Retrieves the first asset object of type `type` at given path `assetPath`.

Some asset files may contain multiple objects. (such as a Maya file which may contain multiple Meshes and GameObjects). All paths are relative to the project folder, for example: "Assets/MyTextures/hello.png".  
  
**Note:**  
The **assetPath** parameter is not case sensitive.  
This returns only an asset object that is visible in the Project view. If the asset is not found `LoadAssetAtPath` returns `null`.

``` codeExampleCS
using UnityEngine;
using UnityEditor;

public class MyPlayer : MonoBehaviour

}
```

Additional resources: [AssetDatabase.LoadMainAssetAtPath](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetDatabase.LoadMainAssetAtPath.html), [AssetDatabase.LoadAllAssetsAtPath](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetDatabase.LoadAllAssetsAtPath.html).

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static T <span class="sig-kw">LoadAssetAtPath</span>(string <span class="sig-kw">assetPath</span>);

### Parameters

| Parameter | Description                                     |
|-----------|-------------------------------------------------|
| assetPath | The project-relative path of the asset to load. |

### Returns

**T** The first asset object at the given `assetPath`.

### Description

Retrieves the first asset object at given path `assetPath`.

This returns only an asset object that is visible in the Project view. If the asset is not found `LoadAssetAtPath` returns `null`.
