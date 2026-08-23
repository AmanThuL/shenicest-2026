---
title: "Unity Scripting API 6.3 LTS: AssetDatabase.ForceReserializeAssets"
page_title: "Unity - Scripting API: AssetDatabase.ForceReserializeAssets"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetDatabase.ForceReserializeAssets.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetDatabase.ForceReserializeAssets.html"
topic: "version-control"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [AssetDatabase](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetDatabase.html).ForceReserializeAssets

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

public static void <span class="sig-kw">ForceReserializeAssets</span>();

<span style="color:red;"> </span>

## Declaration

public static void <span class="sig-kw">ForceReserializeAssets</span>(IEnumerable\<string> <span class="sig-kw">assetPaths</span>, [ForceReserializeAssetsOptions](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ForceReserializeAssetsOptions.html) <span class="sig-kw">options</span>);

### Parameters

| Parameter  | Description                                                                                                              |
|------------|--------------------------------------------------------------------------------------------------------------------------|
| assetPaths | The paths to the assets that should be reserialized.                                                                     |
| options    | Specify whether you want to reserialize the assets themselves, their .meta files, or both. If omitted, defaults to both. |

### Description

Forcibly load and re-serialize the given assets, flushing any outstanding data changes to disk.

When Unity loads old data from an asset or Scene file, the data is dynamically upgraded in memory, but not written back to disk unless the user does something that explicitly dirties the object (like changing a value on it). This method allows you to proactively load, upgrade, and write back to disk any asset or Scene files in the project, without having to manually make them dirty.  
  
Unity's usual behaviour has a number of benefits, particularly for projects with version control systems, where upgrading all the assets proactively after moving to a new Unity version would result in massive lists of changed files to be committed. However, it also has the drawback of upgrades being 'mixed in' with deliberate changes as users continue to work on a project. This method allows you to be proactive in a controlled way, deciding exactly which assets you want to upgrade and when.  
  
Note: You should only call this method from direct user actions, such as a menu item. You should not call ForceReserializeAssets from a Unity callback (such as OnEnable), because it might be called while a scene is being modified. If you do this, Unity throws an exception.

``` codeExampleCS
using UnityEditor;
using UnityEngine;

public class AssetDatabaseExamples : MonoBehaviour
{
    [MenuItem("AssetDatabase/Force Reserialize Assets Example")]
    static void UpdateGroundMaterials()
    {
        for (var i = 0; i < 10; i++)
        {
            var matPath = $"Assets/Materials/GroundMaterial{i}.mat";
            var mat = (Material)AssetDatabase.LoadMainAssetAtPath(matPath);
            AssetImporter.GetAtPath(matPath).SetAssetBundleNameAndVariant("GroundBundle", "");
            mat.shader = Shader.Find("Standard");
            mat.color = Color.white;
            mat.mainTexture = (Texture)AssetDatabase.LoadMainAssetAtPath($"Assets/Textures/GroundTexture{i}.jpg");
        }
        AssetDatabase.ForceReserializeAssets();

    }
}
```
