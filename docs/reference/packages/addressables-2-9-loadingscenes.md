---
title: "Load scenes"
page_title: "Load scenes | Addressables | 2.9.1"
source_url: "https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/LoadingScenes.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/LoadingScenes.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Load scenes

Use the <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/api/UnityEngine.AddressableAssets.Addressables.LoadSceneAsync.html" class="xref"><code>Addressables.LoadSceneAsync</code></a> method to load an Addressable scene asset by address or other addressable key object.

`Addressables.LoadSceneAsync` uses the `UnityEngine` <a href="https://docs.unity3d.com/ScriptReference/SceneManagement.SceneManager.LoadSceneAsync.html" class="xref"><code>SceneManager.LoadSceneAsync</code></a> method internally. APIs that affect the behavior of `SceneManager.LoadSceneAsync` also affect `Addressables.LoadSceneAsync` in the same way, such as <a href="https://docs.unity3d.com/ScriptReference/Application-backgroundLoadingPriority.html" class="xref"><code>Application.backgroundLoadingPriority</code></a>.

The remaining parameters of the `Addressables.LoadSceneAsync` method correspond to those used with the `SceneManager.LoadSceneAsync` method:

-   `loadMode`: Whether to add the loaded scene into the current scene, or to unload and replace the current scene.
-   `loadSceneParameters`: Includes `loadMode` and `localPhysicsMode`. This is used when loading the scene to specify whether to create a 2D or 3D physics scene.
-   `activateOnLoad`: Whether to activate the scene as soon as it finishes loading or to wait until you call the `SceneInstance` object's <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/api/UnityEngine.ResourceManagement.ResourceProviders.SceneInstance.ActivateAsync.html" class="xref"><code>ActivateAsync</code></a> method. Corresponds to the <a href="https://docs.unity3d.com/ScriptReference/AsyncOperation-allowSceneActivation.html" class="xref"><code>AsyncOperation.allowSceneActivation</code></a> option. Defaults to true.
-   `priority`: The priority of the `AsyncOperation` used to load the scene. Corresponds to the <a href="https://docs.unity3d.com/ScriptReference/AsyncOperation-priority.html" class="xref"><code>AsyncOperation.priority</code></a> option. Defaults to 100.

##### Warning

Setting the `activateOnLoad` parameter to false blocks the `AsyncOperation` queue, including the loading of any other Addressable assets, until you activate the scene. To activate the scene, call the <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/api/UnityEngine.ResourceManagement.ResourceProviders.SceneInstance.ActivateAsync.html" class="xref"><code>ActivateAsync</code></a> method of the <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/api/UnityEngine.ResourceManagement.ResourceProviders.SceneInstance.html" class="xref"><code>SceneInstance</code></a> returned by <a href="https://docs.unity3d.com/ScriptReference/SceneManagement.SceneManager.LoadSceneAsync.html" class="xref"><code>LoadSceneAsync</code></a>. Refer to <a href="https://docs.unity3d.com/ScriptReference/AsyncOperation-allowSceneActivation.html" class="xref"><code>AsyncOperation.allowSceneActivation</code></a> for additional information.

The following example loads a scene additively. The component that loads the scene stores the operation handle and uses it to unload and release the scene when the parent GameObject is destroyed.

``` lang-cs
using UnityEngine;
using UnityEngine.AddressableAssets;
using UnityEngine.ResourceManagement.AsyncOperations;
using UnityEngine.ResourceManagement.ResourceProviders;
using UnityEngine.SceneManagement;

internal class LoadSceneByAddress : MonoBehaviour

    void OnDestroy()
    
}
```

If you load a scene with <a href="https://docs.unity3d.com/ScriptReference/SceneManagement.LoadSceneMode.Single.html" class="xref"><code>LoadSceneMode.Single</code></a>, the Unity runtime unloads the current scene and calls <a href="https://docs.unity3d.com/ScriptReference/Resources.UnloadUnusedAssets.html" class="xref"><code>Resources.UnloadUnusedAssets</code></a>. Refer to <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/UnloadingAddressableAssets.html" class="xref">Releasing Addressable assets</a> for more information.

##### Note

In the Editor, you can always load scenes in the current project, even when they're packaged in a remote bundle that's not available and you set the Play Mode Script to **Use Existing Build**. The Editor loads the scene using the Asset Database.

## Use Addressables in a scene

If a scene is Addressable, you can use Addressable assets in the scene just like any other assets. You can place prefabs and other assets in the scene, and assign assets to component properties. If you use an asset that isn't Addressable, that asset becomes an implicit dependency of the scene and the build system packs it in the same AssetBundle as the scene when you make a content build. Addressable assets are packed into their own AssetBundles according to the group they're in.

##### Note

Implicit dependencies used in more than one place can be duplicated in multiple AssetBundles and in the built-in scene data. Use the <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/BuildLayoutReport.html" class="xref">Build Layout Report</a> to identify and resolve unwanted asset duplication resulting from your project content organization.

If a scene isn't Addressable, then any Addressable assets you add directly to the scene hierarchy become implicit dependencies and Unity includes copies of those assets in the built-in scene data even if they also exist in an Addressable group. The same is true for any assets, such as materials assigned to a component on a GameObject in the scene.

In custom component classes, you can use <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/api/UnityEngine.AddressableAssets.AssetReference.html" class="xref"><code>AssetReference</code></a> fields to allow the assignment of Addressable assets in non-Addressable scenes. Otherwise, you can use <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/AddressableAssetsOverview.html" class="xref">addresses</a> and [labels](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/Labels.html) to load assets at runtime from a script. You must load an `AssetReference` in code regardless of if the scene is Addressable.

## Additional resources

-   <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/api/UnityEngine.AddressableAssets.Addressables.LoadSceneAsync.html" class="xref"><code>Addressables.LoadSceneAsync</code> API reference</a>
-   [Optimization tools](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/optimization-tools.html)
-   [Load assets](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/load-assets.html)
