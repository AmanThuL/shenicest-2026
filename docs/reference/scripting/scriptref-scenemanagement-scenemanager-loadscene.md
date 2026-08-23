---
title: "Scripting API: SceneManagement.SceneManager.LoadScene"
page_title: "Unity - Scripting API: SceneManagement.SceneManager.LoadScene"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.LoadScene.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.LoadScene.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [SceneManager](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.html).LoadScene

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

public static void <span class="sig-kw">LoadScene</span>(int <span class="sig-kw">sceneBuildIndex</span>, [SceneManagement.LoadSceneMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.LoadSceneMode.html) <span class="sig-kw">mode</span> = LoadSceneMode.Single);

<span style="color:red;"> </span>

## Declaration

public static void <span class="sig-kw">LoadScene</span>(string <span class="sig-kw">sceneName</span>, [SceneManagement.LoadSceneMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.LoadSceneMode.html) <span class="sig-kw">mode</span> = LoadSceneMode.Single);

### Parameters

| Parameter       | Description                                                                                                                                                                                                                      |
|-----------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| sceneName       | Name or path of the Scene to load.                                                                                                                                                                                               |
| sceneBuildIndex | Index of the Scene in the Build Settings to load.                                                                                                                                                                                |
| mode            | Allows you to specify whether or not to load the Scene additively. See [LoadSceneMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.LoadSceneMode.html) for more information about the options. |

### Description

Loads the Scene by its name or index in Build Settings.

**Note:** In most cases, to avoid pauses or performance hiccups while loading, you should use the asynchronous version of this command which is: [LoadSceneAsync](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.LoadSceneAsync.html).  
  
When using [SceneManager.LoadScene](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.LoadScene.html), the scene loads in the next frame, that is it does not load immediately. This semi-asynchronous behavior can cause frame stuttering and can be confusing because load does not complete immediately.  
  
Because loading is set to complete in the next rendered frame, calling [SceneManager.LoadScene](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.LoadScene.html) forces all previous AsyncOperations to complete, even if [AsyncOperation.allowSceneActivation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AsyncOperation-allowSceneActivation.html) is set to false. To avoid this, use [LoadSceneAsync](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.LoadSceneAsync.html) instead.  
  
The given `sceneName` can either be the Scene name only, without the `.unity` extension, or the path as shown in the BuildSettings window still without the `.unity` extension. If only the Scene name is given this will load the first Scene in the list that matches. If you have multiple Scenes with the same name but different paths, you should use the full path.  
  
Note that `sceneName` is case insensitive, except when you load the Scene from an [AssetBundle](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetBundle.html).  
  
For opening Scenes in the Editor see [EditorSceneManager.OpenScene](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.EditorSceneManager.OpenScene.html). `SceneA` can additively load `SceneB` multiple times. The regular name is used for each loaded scene. If `SceneA` loads `SceneB` ten times each `SceneB` will have the same name. Finding a particular added scene is not possible.  
  
If a single mode scene is loaded, Unity calls Resources.UnloadUnusedAssets automatically.

``` codeExampleCS
using UnityEngine;
using UnityEngine.SceneManagement;

public class ExampleClass : MonoBehaviour

}
```

``` codeExampleCS
// Load an assetbundle which contains Scenes.
// When the user clicks a button the first Scene in the assetbundle is
// loaded and replaces the current Scene.

using UnityEngine;
using UnityEngine.SceneManagement;

public class LoadScene : MonoBehaviour

    void OnGUI()
    
    }
}
```

The following two script examples show how [LoadScene](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.LoadScene.html) can load Scenes from Build Settings. `LoadSceneA` uses the name of the Scene to load. `LoadSceneB` uses the number of the Scene to load. The scripts work together.  
  
`LoadSceneA` file.

``` codeExampleCS
// SceneA.
// SceneA is given the sceneName which will
// load SceneB from the Build Settings

using UnityEngine;
using UnityEngine.SceneManagement;

public class LoadScenesA : MonoBehaviour

    public void LoadA(string scenename)
    
}
```

`LoadSceneB` file.

``` codeExampleCS
// SceneB.
// SceneB is given the sceneBuildIndex of 0 which will
// load SceneA from the Build Settings

using UnityEngine;
using UnityEngine.SceneManagement;

public class LoadScenesB : MonoBehaviour

    public void LoadB(int sceneANumber)
    
}
```

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static [SceneManagement.Scene](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.Scene.html) <span class="sig-kw">LoadScene</span>(int <span class="sig-kw">sceneBuildIndex</span>, [SceneManagement.LoadSceneParameters](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.LoadSceneParameters.html) <span class="sig-kw">parameters</span>);

<span style="color:red;"> </span>

## Declaration

public static [SceneManagement.Scene](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.Scene.html) <span class="sig-kw">LoadScene</span>(string <span class="sig-kw">sceneName</span>, [SceneManagement.LoadSceneParameters](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.LoadSceneParameters.html) <span class="sig-kw">parameters</span>);

### Parameters

| Parameter       | Description                                       |
|-----------------|---------------------------------------------------|
| sceneName       | Name or path of the Scene to load.                |
| sceneBuildIndex | Index of the Scene in the Build Settings to load. |
| parameters      | Various parameters used to load the Scene.        |

### Returns

**Scene** A handle to the Scene being loaded.

### Description

Loads the Scene by its name or index in Build Settings.

An example using two scenes called `Scene1` and `Scene2`. ExampleScript1.cs is for `scene1` and ExampleScript2.cs is for `scene2`.

``` codeExampleCS
using UnityEngine;
using UnityEngine.SceneManagement;

// This is scene1.  It loads 3 copies of scene2.
// Each copy has the same name.

public class ExampleScript1 : MonoBehaviour

}
```

Scene2:

``` codeExampleCS
using UnityEngine;

// create a randomly placed cube

public class ExampleScript2 : MonoBehaviour

}
```
