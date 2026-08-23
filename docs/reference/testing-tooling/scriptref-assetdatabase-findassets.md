---
title: "Scripting API: AssetDatabase.FindAssets"
page_title: "Unity - Scripting API: AssetDatabase.FindAssets"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetDatabase.FindAssets.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetDatabase.FindAssets.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [AssetDatabase](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetDatabase.html).FindAssets

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

public static string\[\] <span class="sig-kw">FindAssets</span>(string <span class="sig-kw">filter</span>);

<span style="color:red;"> </span>

## Declaration

public static string\[\] <span class="sig-kw">FindAssets</span>(string <span class="sig-kw">filter</span>, string\[\] <span class="sig-kw">searchInFolders</span>);

### Parameters

| Parameter       | Description                                                                                                                                                                           |
|-----------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| filter          | The filter string can contain search data. See below for details about this string.                                                                                                   |
| searchInFolders | The folders to perform the search in. Unity searches within this folder and any child folders. If unspecified, Unity searches in the `Assets` and `Packages` folders of your project. |

### Returns

**string\[\]** An array containing the GUIDs of any matching assets in string format. If no matching assets were found, returns empty array.

### Description

Search the asset database using the search filter string.

FindAssets allows you to search for Assets. The `string` argument can provide names, labels or types (classnames). The filter string can include:  
  
**Name**: Filter assets by their filename (without extension). Words separated by a space are treated as separate name searches. For example, `"test asset"`, is for two name searches, one looking for a match with `test` and the other with `asset`. You can also perform partial searches. For example, you can match `MyAwesomeTexture` by searching for `awesome`.  
  
**Labels (l:)**: Assets can have labels attached to them. Use the keyword `'l:'` before each label to search for assets by their labels.  
  
**Types (t:)**: Use the keyword `'t:'` to find assets by their type. If more than one type is included in the filter `string` then assets that match one class will be returned. Types can either be built-in types such as `Texture2D` or user created script classes. User created classes are assets created from a ScriptableObject class in the project. If all assets are wanted use `Object` as the type because all assets derive from Object. Specifying one or more folders using the `searchInFolders` argument limits the searching to these folders and their child folders. This is faster than searching all assets in all folders.  
  
**AssetBundles (b:)**: Use the keyword `'b:'` to find assets which are part of an AssetBundle.  
  
**Area (a:)** : Find assets in a specific **area** of a project. Valid values are `"all"`, `"assets"` and `"packages"`. Use this to make your query more specific using the `'a:'` keyword followed by the area name to speed up searching.  
  
**Globbing (glob:)**: Use globbing to match specific rules. The keyword `glob:` is followed by the query. For example, `glob:Editor` will find all Editor folders in a project, `glob:(Editor|Resources)` will find all Editor and Resources folders in a project, `glob:Editor/*` will return all Assets inside Editor folders in a project, while `glob:Editor/**` will return all Assets within Editor folders recursively.  
  
**Note:**  
Searching is case insensitive.  
  
Use [AssetDatabase.GUIDToAssetPath](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetDatabase.GUIDToAssetPath.html) to get asset paths and [AssetDatabase.LoadAssetAtPath](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetDatabase.LoadAssetAtPath.html) to load an asset.

``` codeExampleCS
using UnityEngine;
using UnityEditor;

public class Example

        // Find all Texture2Ds that have 'co' in their filename, that are labelled with 'architecture' and are placed in 'MyAwesomeProps' folder
        string[] guids2 = AssetDatabase.FindAssets("co l:architecture t:texture2D", new[] {"Assets/MyAwesomeProps"});

        foreach (string guid2 in guids2)
        
    }
}
```

The following script example shows how the Names, Labels and Types details added to Assets can be located. The [FindAssets](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetDatabase.FindAssets.html) function is demonstrated. The assets created in this example use the `ScriptObj` class.

``` codeExampleCS
// This script file has two CS classes.  The first is a simple Unity ScriptableObject script.
// The class it defines is used by the Example class below.
// (This is a single Unity script file. You could split this file into a ScriptObj.cs and an
// Example.cs file which is more structured.)

using UnityEngine;
using UnityEditor;
using System.IO;

public class ScriptObj : ScriptableObject

}

// Use ScriptObj to show how AssetDabase.FindAssets can be used

public class Example

    static void CreateAssets()
    
        if (!Directory.Exists("Assets/AssetFolder/SpecialFolder"))
        
        testI = (ScriptObj)ScriptableObject.CreateInstance(typeof(ScriptObj));
        AssetDatabase.CreateAsset(testI, "Assets/AssetFolder/testI.asset");

        testJ = (ScriptObj)ScriptableObject.CreateInstance(typeof(ScriptObj));
        AssetDatabase.CreateAsset(testJ, "Assets/AssetFolder/testJ.asset");

        // create an asset in a sub-folder and with a name which contains a space
        testK = (ScriptObj)ScriptableObject.CreateInstance(typeof(ScriptObj));
        AssetDatabase.CreateAsset(testK, "Assets/AssetFolder/SpecialFolder/testK example.asset");

        // an asset with a material will be used later
        Material material = new Material(Shader.Find("Standard"));
        AssetDatabase.CreateAsset(material, "Assets/AssetFolder/SpecialFolder/MyMaterial.mat");
    }

    static void NamesExample()
    
        results = AssetDatabase.FindAssets("testJ");
        foreach (string guid in results)
        
        results = AssetDatabase.FindAssets("testK example");
        foreach (string guid in results)
        
        Debug.Log("*** More complex asset search ***");

        // find all assets that contain test (which is all assets)
        results = AssetDatabase.FindAssets("test");
        foreach (string guid in results)
        
    }

    static void LabelsExample()
    {
        Debug.Log("*** FINDING ASSETS BY LABELS ***");

        string[] setLabels;

        setLabels = new string[] { "wrapper" };
        AssetDatabase.SetLabels(testI, setLabels);

        setLabels = new string[] { "bottle", "banana", "carrot" };
        AssetDatabase.SetLabels(testJ, setLabels);

        setLabels = new string[] { "swappable", "helmet" };
        AssetDatabase.SetLabels(testK, setLabels);

        // label searching:
        //   testI has wrapper, testK has swappable, so both have 'app'
        //   testJ has bottle, so have a label searched as 'bot'
        string[] getGuids = AssetDatabase.FindAssets("l:app l:bot");
        foreach (string guid in getGuids)
        
    }

    static void TypesExample()
    
        guids = AssetDatabase.FindAssets("t:Object l:helmet");
        foreach (string guid in guids)
        
    }
}
```
