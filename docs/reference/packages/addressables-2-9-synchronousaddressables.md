---
title: "Load assets synchronously"
page_title: "Synchronous loading | Addressables | 2.9.1"
source_url: "https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/SynchronousAddressables.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/SynchronousAddressables.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

## Synchronous loading

You can wait for an operation to finish without yielding, waiting for an event, or using `async await` by calling an operation's <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/api/UnityEngine.ResourceManagement.AsyncOperations.AsyncOperationHandle.WaitForCompletion.html" class="xref"><code>WaitForCompletion</code></a> method. This method blocks the current program execution thread while it waits for the operation to finish before continuing in the current scope.

Avoid calling `WaitForCompletion` on operations that can take a significant amount of time, such as those that must download data. Calling `WaitForCompletion` can cause frame hitches and interrupt UI responsiveness.

The following example loads a prefab asset by address, waits for the operation to complete, and then instantiates the prefab:

``` lang-cs
using UnityEngine;
using UnityEngine.AddressableAssets;
using UnityEngine.ResourceManagement.AsyncOperations;

internal class LoadSynchronously : MonoBehaviour

        else
        
    }

    void OnDestroy()
    
}
```

The result of `WaitForCompletion` is the `Result` of the asynchronous operation it's called on. If the operation fails, this returns `default(TObject)`.

You can get a `default(TObject)` for a result when the operation doesn't fail. Asynchronous operations that auto release their `AsyncOperationHandle` instances on completion are such cases. `Addressables.InitializeAsync` and any API with a `autoReleaseHandle` parameter set to true return `default(TObject)` even if the operations succeeded.

## Performance considerations

Calling `WaitForCompletion` might have performance implications on your runtime when compared to `Resources.Load` or `Instantiate` calls directly. If the AssetBundle is local or has been downloaded before and cached, these performance hits are small.

All active asset load operations are completed when `WaitForCompletion` is called on any asset load operation, because of how Unity handles asynchronous operations. To avoid unexpected stalls, use `WaitForCompletion` when you known the current operation count, and the you want all active operations to complete synchronously.

Don't call `WaitForCompletion` on an operation that's going to fetch and download a remote `AssetBundle`.

## Deadlocks caused by scene limitations

Unity can't complete scene loading synchronously. Calling `WaitForCompletion` on an operation returned from <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/api/UnityEngine.AddressableAssets.Addressables.LoadSceneAsync.html" class="xref"><code>Addressables.LoadSceneAsync</code></a> doesn't completely load the scene, even if `activateOnLoad `is set to `true`. It waits for dependencies and assets to complete but the scene activation must be done asynchronously.

This can be done using the `sceneHandle`, or by the <a href="https://docs.unity3d.com/ScriptReference/AsyncOperation.html" class="xref"><code>AsyncOperation</code></a> from `ActivateAsync` on the `SceneInstance`:

``` lang-c#
IEnumerator LoadScene(string myScene)

```

Unity can't unload a scene synchronously. Calling <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/api/UnityEngine.ResourceManagement.AsyncOperations.AsyncOperationHandle.WaitForCompletion.html#UnityEngine_ResourceManagement_AsyncOperations_AsyncOperationHandle_WaitForCompletion" class="xref"><code>WaitForCompletion</code></a> on a scene unload doesn't unload the scene or any assets, and a warning is logged to the Console.

Because of limitations with scene integration on the main thread through the `SceneManager` API, you can lock the Unity Editor or Player when calling `WaitForCompletion` to load scenes. This issue happens when loading two scenes in succession, with the second scene load request having `WaitForCompletion` called from its `AsyncOperationHandle`.

Scene loading takes extra frames to fully integrate on the main thread, and `WaitForCompletion` locks the main thread, so you might have a situation where `SceneManager` informs Unity that the first scene is fully loaded, even though it hasn't finished all operations. At this point, the scene is fully loaded, but the `SceneManager` attempts to call `UnloadUnusedAssets`, on the main thread, if the scene was loaded in `Single` mode. Then, the second scene load request locks the main thread with `WaitForCompletion`, but can't begin loading because `SceneManager` requires the `UnloadUnusedAssets` to complete before the next scene can begin loading.

To avoid this deadlock, either load successive scenes asynchronously, or add a delay between scene load requests.

Another issue is calling `WaitForCompletion` on an asynchronous operation during `Awake` when a scene isn't fully loaded. This can block the main thread and prevent other asynchronous operations (such as unloading an AssetBundle) in progress from completing. To avoid this deadlock, call `WaitForCompletion` during `Start` instead.

Note that Addressables has a callback registered to <a href="https://docs.unity3d.com/ScriptReference/SceneManagement.SceneManager-sceneUnloaded.html" class="xref"><code>SceneManager.sceneUnloaded</code></a> that releases any unloaded Addressable scenes. This can trigger scene AssetBundle unloading if no other scenes from the AssetBundle are loaded.

## Custom operations

Addressables supports custom `AsyncOperation` instances which support unique implementations of <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/api/UnityEngine.ResourceManagement.AsyncOperations.AsyncOperationBase-1.InvokeWaitForCompletion.html#UnityEngine_ResourceManagement_AsyncOperations_AsyncOperationBase_1_InvokeWaitForCompletion" class="xref"><code>InvokeWaitForCompletion</code></a>. This method can be overridden to implement custom synchronous operations.

Custom operations work with `ChainOperation` and `GroupsOperation` instances. If you want to complete chained operations synchronously, make your custom operations implement `InvokeWaitForCompletion` and create a `ChainOperation` using your custom operations. Similarly, `GroupOperations` are well suited to make a collection of `AsyncOperations`, including custom operations, complete together.

Both <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/api/UnityEngine.ResourceManagement.ResourceManager.CreateChainOperation.html" class="xref"><code>ChainOperation</code></a> and <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/api/UnityEngine.ResourceManagement.ResourceManager.CreateGroupOperation.html" class="xref"><code>GroupOperation</code></a> have their own implementations of `InvokeWaitForCompletion` that relies on the `InvokeWaitForCompletion` implementations of the operations they depend on.

## WebGL support

WebGL doesn't support `WaitForCompletion`. On WebGL, a web request loads all files. On other platforms, a web request gets started on a background thread and the main thread spins in a tight loop while waiting for the web request to finish. This is how Addressables does it for `WaitForCompletion` when a web request is used.

Because WebGL is single-threaded, the tight loop blocks the web request and the operation is never allowed to finish. If a web request finishes the same frame it was created, then `WaitForCompletion` wouldn't have any issue. However, this isn't guaranteed.

## Additional resources

-   <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/api/UnityEngine.ResourceManagement.AsyncOperations.AsyncOperationHandle.WaitForCompletion.html" class="xref"><code>WaitForCompletion</code> API reference</a>
-   [Wait for asynchronous loads to complete](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/AddressableAssetsAsyncOperationHandle.html)
-   [Monitor wait operations](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/load-monitor-wait-operations.html)
