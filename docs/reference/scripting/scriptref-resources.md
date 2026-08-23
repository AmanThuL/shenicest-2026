---
title: "Scripting API: Resources"
page_title: "Unity - Scripting API: Resources"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Resources

class in UnityEngine

/

Implemented in:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UnityEngine.CoreModule.html" class="cl">UnityEngine.CoreModule</a>

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

The Resources class allows you to find and access objects including assets.

When you build your project, all assets in any `Resources` folders are included in the built Player. You can then load these assets at runtime using [Resources.Load](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.Load.html). You must create the `Resources` folder. Unity doesn't automatically create a `Resources` folder when you create a project. Your project can contain multiple `Resources` folders.  
  
Use [Resources.FindObjectsOfTypeAll](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.FindObjectsOfTypeAll.html) to locate assets and scene objects in the Editor.  
  
One way to access assets in Unity is to expose a reference to an asset by declaring a member-variable, then assign it in the Inspector, instead of using the direct path to an asset. This allows Unity to automatically calculate which assets are used when building a Player and minimizes the size of the Player to only contain the assets used in your application. However, this method fixes the references in the Inspector which makes them less flexible.  
  
You can use the Resources class to load assets at runtime by specifying their path as a string. For example, you might want to create a GameObject procedurally from a script and assign a texture to a procedurally generated mesh.  
  
Some loaded assets, most notably textures, can use up memory even when no instance exists in the Scene. To reclaim this memory when the asset is no longer needed, you can use [Resources.UnloadUnusedAssets](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.UnloadUnusedAssets.html).  
  
For more information, refer to the [Introduction to the Resources system](https://docs.unity3d.com/6000.3/Documentation/Manual/LoadingResourcesatRuntime.html).  
  

``` codeExampleCS
using UnityEngine;
using System.Collections;

public class ExampleClass : MonoBehaviour

}
```

### Static Methods

| Method                                                                                                                          | Description                                                                                                                                                                                                                 |
|---------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [EntityIdsToObjectList](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.EntityIdsToObjectList.html)     | Translates an array of entity IDs to a list of Object references.                                                                                                                                                           |
| [EntityIdToObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.EntityIdToObject.html)               | Translates an EntityId to an object reference.                                                                                                                                                                              |
| [FindObjectsOfTypeAll](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.FindObjectsOfTypeAll.html)       | Obtains a list of all objects of type T.                                                                                                                                                                                    |
| [InstanceIDsToValidArray](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.InstanceIDsToValidArray.html) | Translates an array of instance IDs to an array of bools indicating whether a given instance ID from instanceIDs corresponds to a valid Object in memory. The Object could have been deleted or not loaded into memory yet. |
| [Load](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.Load.html)                                       | Loads the asset of the requested type stored at path in a Resources folder.                                                                                                                                                 |
| [LoadAll](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.LoadAll.html)                                 | Loads all assets in a folder or file at path in a Resources folder.                                                                                                                                                         |
| [LoadAsync](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.LoadAsync.html)                             | Asynchronously loads an asset stored at path in a Resources folder.                                                                                                                                                         |
| [UnloadAsset](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.UnloadAsset.html)                         | Unloads assetToUnload from memory.                                                                                                                                                                                          |
| [UnloadUnusedAssets](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.UnloadUnusedAssets.html)           | Unloads assets that are not used.                                                                                                                                                                                           |
