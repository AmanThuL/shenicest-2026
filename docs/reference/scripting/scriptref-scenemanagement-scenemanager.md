---
title: "Scripting API: SceneManagement.SceneManager"
page_title: "Unity - Scripting API: SceneManager"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# SceneManager

class in UnityEngine.SceneManagement

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

Manage scenes in the Player and in Play mode in the Editor.

You can use the SceneManager to manage and manipulate scenes in the Player.  
  
**Scene creation, loading and unloading**

-   To create scenes dynamically at runtime, use [SceneManager.CreateScene](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.CreateScene.html).
-   To load scenes from built content, use [SceneManager.LoadSceneAsync](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.LoadSceneAsync.html) or [SceneManager.LoadScene](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.LoadScene.html).
-   Scenes cannot be saved at runtime.
-   You can load multiple scenes simultaneously. To add more scenes to the currently open ones, use the [LoadSceneMode.Additive](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.LoadSceneMode.Additive.html) option when calling [SceneManager.LoadSceneAsync](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.LoadSceneAsync.html) or [SceneManager.LoadScene](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.LoadScene.html).
-   You can load the same scene multiple times in both the Player and in Play mode in the Editor. In Edit mode in the Editor, SceneManager cannot be used and a scene can only be loaded once (using [EditorSceneManager](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.EditorSceneManager.html)).
-   To unload a scene explicitly, use [SceneManager.UnloadSceneAsync](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.UnloadSceneAsync.html). All open scenes can be unloaded implicitly by loading another scene with [LoadSceneMode.Single](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.LoadSceneMode.Single.html).

**Accessing loaded scenes**  
  
The Scene Manager offers APIs to access currently loaded Scenes. For example, [SceneManager.loadedSceneCount](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager-loadedSceneCount.html), [SceneManager.GetSceneAt](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.GetSceneAt.html), and [SceneManager.GetSceneByPath](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.GetSceneByPath.html).  
  
**Scene manipulation**  
  
To move objects between scenes, use methods like [SceneManager.MergeScenes](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.MergeScenes.html) and [SceneManager.MoveGameObjectToScene](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.MoveGameObjectToScene.html).  
  
**SceneManager events**  
  
The SceneManager also exposes the following events:

-   [SceneManager.activeSceneChanged](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager-activeSceneChanged.html)
-   [SceneManager.sceneLoaded](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager-sceneLoaded.html)
-   [SceneManager.sceneUnloaded](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager-sceneUnloaded.html)

Scripts can register on these events and then be notified when there are changes in the state of the SceneManager.  
  
**The scene list**  
  
The Player contains a BuildSettings object which records the list of scenes that are available to load. The contents of this list is exposed by [SceneManager.sceneCountInBuildSettings](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager-sceneCountInBuildSettings.html) and [SceneUtility.GetScenePathByBuildIndex](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneUtility.GetScenePathByBuildIndex.html).  
  
The contents of this list is determined when the Player is built:

-   By default, all the enabled scenes in the [EditorBuildSettings.scenes](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorBuildSettings-scenes.html) array are included. You can view and edit this list from the active profile in the Build Profiles window.
-   When building via scripts with [BuildPipeline.BuildPlayer](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPipeline.BuildPlayer.html), specify scenes using [BuildPlayerOptions.scenes](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPlayerOptions-scenes.html).

The scene order is crucial for several reasons:

-   The first enabled scene in the Scene list (with a build index of 0) loads automatically when the Player starts.
-   Earlier listed Scenes load faster due to optimized assignment of their dependent content to fewer sharedAsset files.
-   [SceneManager.LoadSceneAsync](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.LoadSceneAsync.html) and [SceneManager.LoadScene](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.LoadScene.html) supports loading scenes by index, determined by the order in [EditorBuildSettings.scenes](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorBuildSettings-scenes.html) or [BuildPlayerOptions.scenes](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPlayerOptions-scenes.html) after any disabled scenes are removed.

**AssetBundles and Scenes**

-   Additional scenes can be included in AssetBundles. When an [AssetBundle](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetBundle.html) that contains scenes is loaded, its scenes become available to the SceneManager and can be loaded by path using [SceneManager.LoadSceneAsync](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.LoadSceneAsync.html) or [SceneManager.LoadScene](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.LoadScene.html).
-   Scenes from AssetBundles have a [Scene.buildIndex](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.Scene-buildIndex.html) of -1.
-   When loading scenes by path, a match from loaded AssetBundle takes priority over scenes in the Player build.

**Scene management in the Editor**

-   Use [EditorSceneManager](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.EditorSceneManager.html) instead of SceneManager for scene authoring and manipulation in the Editor.
-   The [SceneManager](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.html) API should only be used in Play mode. In Edit mode calls to unsupported methods such as [SceneManager.LoadSceneAsync](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.LoadSceneAsync.html) will throw an invalid operation exception.
-   In Play mode, only scenes listed in [EditorBuildSettings](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorBuildSettings.html) are available to load, along with scenes from loaded AssetBundles, simulating Player behavior.

**Notes**

-   Loading Scenes by index can be fragile due to potential reordering; the recommended best practice is to load scenes by path for better clarity.
-   Loading scenes by filename (without a full path) can cause issues if multiple scenes share the same name; full path specification removes that ambiguity.

Additional resources: [EditorSceneManager](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.EditorSceneManager.html), [SceneUtility](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneUtility.html), [Scene.buildIndex](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.Scene-buildIndex.html), [EditorBuildSettingsScene.enabled](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorBuildSettingsScene-enabled.html), [AssetBundle.GetAllScenePaths](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetBundle.GetAllScenePaths.html).

``` codeExampleCS
using UnityEngine;
using UnityEngine.SceneManagement;

// This MonoBehaviour could be placed as a component inside the first scene in the Build Profiles Scene List.
// When the Player starts it instantiates this MonoBehaviour, which in turn loads
// an additional scene.
public class SceneLoader : MonoBehaviour
{
    // This scene must be listed in the Scene List in the Build Profiles Window,
    // or available from a loaded AssetBundle.
    const string sceneToLoad = "Assets/Example/AnotherScene.unity";

    void Start()
    {
        var op = SceneManager.LoadSceneAsync(sceneToLoad, LoadSceneMode.Additive);
        op.completed += (AsyncOperation obj) =>
        {
            Scene loadedScene = SceneManager.GetSceneByPath(sceneToLoad);
            Debug.Log($"{sceneToLoad} finished loading (build index: {loadedScene.buildIndex}).");
            Debug.Log($"It has {loadedScene.rootCount} root(s).");
            Debug.Log($"There are now {SceneManager.loadedSceneCount} Scenes open.");
        };
    }

    private void OnDestroy()
    
}
```

``` codeExampleCS
using System.Text;
using UnityEngine;
using UnityEngine.SceneManagement;

public class SceneInfo : MonoBehaviour

    void LogSceneManagerState()
    {
        var sb = new StringBuilder();
        sb.AppendLine("SceneManager state");

        sb.AppendLine($"Active Scene: {SceneManager.GetActiveScene().path}");

        sb.AppendLine($"Scene List (size {SceneManager.sceneCountInBuildSettings})");
        for(int i = 0; i < SceneManager.sceneCountInBuildSettings; i++)
        {
            var scenePath = SceneUtility.GetScenePathByBuildIndex(i);
            sb.AppendLine($"  {i}: {scenePath}");
        }

        sb.AppendLine($"Loaded Scenes (size {SceneManager.sceneCount})");
        for(int i = 0; i < SceneManager.sceneCount; i++)
        {
            var scene = SceneManager.GetSceneAt(i);
            sb.AppendLine($"  {i}: {scene.path}");
        }

        Debug.Log(sb.ToString());
    }
}
```

### Static Properties

| Property                                                                                                                                               | Description                         |
|--------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------|
| [loadedSceneCount](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager-loadedSceneCount.html)                   | The number of loaded Scenes.        |
| [sceneCount](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager-sceneCount.html)                               | The current number of Scenes.       |
| [sceneCountInBuildSettings](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager-sceneCountInBuildSettings.html) | Number of Scenes in Build Settings. |

### Static Methods

| Method                                                                                                                                           | Description                                                                                                                           |
|--------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------|
| [CreateScene](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.CreateScene.html)                       | Create an empty new Scene at runtime with the given name.                                                                             |
| [GetActiveScene](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.GetActiveScene.html)                 | Gets the currently active Scene.                                                                                                      |
| [GetSceneAt](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.GetSceneAt.html)                         | Gets the scene at the specified index in the SceneManager's scene list. This includes scenes that are currently loading or unloading. |
| [GetSceneByBuildIndex](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.GetSceneByBuildIndex.html)     | Get a Scene struct from a build index.                                                                                                |
| [GetSceneByName](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.GetSceneByName.html)                 | Searches through the Scenes loaded for a Scene with the given name.                                                                   |
| [GetSceneByPath](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.GetSceneByPath.html)                 | Searches all Scenes loaded for a Scene that has the given asset path.                                                                 |
| [LoadScene](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.LoadScene.html)                           | Loads the Scene by its name or index in Build Settings.                                                                               |
| [LoadSceneAsync](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.LoadSceneAsync.html)                 | Loads the Scene asynchronously in the background.                                                                                     |
| [MergeScenes](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.MergeScenes.html)                       | This will merge the source Scene into the destinationScene.                                                                           |
| [MoveGameObjectsToScene](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.MoveGameObjectsToScene.html) | Move multiple GameObjects, represented by a NativeArray of instance IDs, from their current Scene to a new Scene.                     |
| [MoveGameObjectToScene](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.MoveGameObjectToScene.html)   | Move a GameObject from its current Scene to a new Scene.                                                                              |
| [SetActiveScene](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.SetActiveScene.html)                 | Set the Scene to be active.                                                                                                           |
| [UnloadSceneAsync](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.UnloadSceneAsync.html)             | Destroys all GameObjects associated with the given Scene and removes the Scene from the SceneManager.                                 |

### Events

| Event                                                                                                                                    | Description                                                                          |
|------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------|
| [activeSceneChanged](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager-activeSceneChanged.html) | Subscribe to this event to get notified when the active Scene has changed.           |
| [sceneLoaded](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager-sceneLoaded.html)               | Assign a custom callback to this event to get notifications when a Scene has loaded. |
| [sceneUnloaded](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager-sceneUnloaded.html)           | Add a delegate to this to get notifications when a Scene has unloaded.               |
