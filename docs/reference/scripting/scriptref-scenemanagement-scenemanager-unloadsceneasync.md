---
title: "Scripting API: SceneManagement.SceneManager.UnloadSceneAsync"
page_title: "Unity - Scripting API: SceneManagement.SceneManager.UnloadSceneAsync"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.UnloadSceneAsync.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.UnloadSceneAsync.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [SceneManager](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.html).UnloadSceneAsync

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

public static [AsyncOperation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AsyncOperation.html) <span class="sig-kw">UnloadSceneAsync</span>(int <span class="sig-kw">sceneBuildIndex</span>);

<span style="color:red;"> </span>

## Declaration

public static [AsyncOperation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AsyncOperation.html) <span class="sig-kw">UnloadSceneAsync</span>(string <span class="sig-kw">sceneName</span>);

<span style="color:red;"> </span>

## Declaration

public static [AsyncOperation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AsyncOperation.html) <span class="sig-kw">UnloadSceneAsync</span>([SceneManagement.Scene](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.Scene.html) <span class="sig-kw">scene</span>);

<span style="color:red;"> </span>

## Declaration

public static [AsyncOperation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AsyncOperation.html) <span class="sig-kw">UnloadSceneAsync</span>(int <span class="sig-kw">sceneBuildIndex</span>, [SceneManagement.UnloadSceneOptions](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.UnloadSceneOptions.html) <span class="sig-kw">options</span>);

<span style="color:red;"> </span>

## Declaration

public static [AsyncOperation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AsyncOperation.html) <span class="sig-kw">UnloadSceneAsync</span>(string <span class="sig-kw">sceneName</span>, [SceneManagement.UnloadSceneOptions](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.UnloadSceneOptions.html) <span class="sig-kw">options</span>);

<span style="color:red;"> </span>

## Declaration

public static [AsyncOperation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AsyncOperation.html) <span class="sig-kw">UnloadSceneAsync</span>([SceneManagement.Scene](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.Scene.html) <span class="sig-kw">scene</span>, [SceneManagement.UnloadSceneOptions](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.UnloadSceneOptions.html) <span class="sig-kw">options</span>);

### Parameters

| Parameter       | Description                          |
|-----------------|--------------------------------------|
| sceneBuildIndex | Index of the Scene in BuildSettings. |
| sceneName       | Name or path of the Scene to unload. |
| scene           | Scene to unload.                     |
| options         | Scene unloading options.             |

### Returns

**AsyncOperation** Use the [AsyncOperation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AsyncOperation.html) to determine if the operation has completed.

### Description

Destroys all GameObjects associated with the given Scene and removes the Scene from the SceneManager.

The given Scene name can either be the full Scene path, the path shown in the Build Settings window or just the Scene name. If only the Scene name is given this will unload the first Scene in the list that matches. If you have multiple Scenes with same name but different paths, you should use the full Scene path. Examples of supported formats:  
`"Scene1"`  
`"Scene2"`  
`"Scenes/Scene3"`  
`"Scenes/Others/Scene3"`  
`"Assets/scenes/others/scene3.unity"`  
  
**Note:** This is case-insensitive and due to it being async there are no guarantees about completion time.  
**Note:** Assets are currently not unloaded. In order to free up asset memory call [Resources.UnloadUnusedAssets](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.UnloadUnusedAssets.html).  
**Note:** It is not possible to [UnloadSceneAsync](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.UnloadSceneAsync.html) if there are no scenes to load. For example, a project that has a single scene cannot use this static member.
