---
title: "Scripting API: SceneManagement.SceneManager.LoadSceneAsync"
page_title: "Unity - Scripting API: SceneManagement.SceneManager.LoadSceneAsync"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.LoadSceneAsync.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.LoadSceneAsync.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [SceneManager](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.html).LoadSceneAsync

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

public static [AsyncOperation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AsyncOperation.html) <span class="sig-kw">LoadSceneAsync</span>(string <span class="sig-kw">sceneName</span>, [SceneManagement.LoadSceneMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.LoadSceneMode.html) <span class="sig-kw">mode</span> = LoadSceneMode.Single);

<span style="color:red;"> </span>

## Declaration

public static [AsyncOperation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AsyncOperation.html) <span class="sig-kw">LoadSceneAsync</span>(int <span class="sig-kw">sceneBuildIndex</span>, [SceneManagement.LoadSceneMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.LoadSceneMode.html) <span class="sig-kw">mode</span> = LoadSceneMode.Single);

<span style="color:red;"> </span>

## Declaration

public static [AsyncOperation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AsyncOperation.html) <span class="sig-kw">LoadSceneAsync</span>(string <span class="sig-kw">sceneName</span>, [SceneManagement.LoadSceneParameters](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.LoadSceneParameters.html) <span class="sig-kw">parameters</span>);

<span style="color:red;"> </span>

## Declaration

public static [AsyncOperation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AsyncOperation.html) <span class="sig-kw">LoadSceneAsync</span>(int <span class="sig-kw">sceneBuildIndex</span>, [SceneManagement.LoadSceneParameters](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.LoadSceneParameters.html) <span class="sig-kw">parameters</span>);

### Parameters

| Parameter       | Description                                                                                    |
|-----------------|------------------------------------------------------------------------------------------------|
| sceneName       | Name or path of the Scene to load.                                                             |
| sceneBuildIndex | Index of the Scene in the Build Settings to load.                                              |
| mode            | If LoadSceneMode.Single then all current Scenes will be unloaded before loading.               |
| parameters      | Struct that collects the various parameters into a single place except for the name and index. |

### Returns

**AsyncOperation** Use the [AsyncOperation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AsyncOperation.html) to determine if the operation has completed.

### Description

Loads the Scene asynchronously in the background.

You can provide the full Scene path, the path shown in the Build Settings window, or just the Scene name. If you only provide the Scene name, Unity loads the first Scene in the list that matches. If you have multiple Scenes with the same name but different paths, you should use the full Scene path in the Build Settings.  
  
Examples of supported formats:  
`"Scene1"`  
`"Scenes/Scene1"`  
`"Scenes/Others/Scene1"`  
`"Assets/scenes/others/scene1.unity"`  
  
**Note:** Scene name input is not case-sensitive.  
If you call this method with an invalid **sceneName** or **sceneBuildIndex**, Unity throws an exception.  
  
**Note:** The name of the Scene to load can be case insensitive.  
  
If a single mode scene is loaded, Unity calls Resources.UnloadUnusedAssets automatically.

``` codeExampleCS
using System.Collections;
using UnityEngine;
using UnityEngine.SceneManagement;

public class Example : MonoBehaviour

    }

    IEnumerator LoadYourAsyncScene()
    
    }
}
```
