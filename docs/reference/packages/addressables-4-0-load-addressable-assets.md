---
title: "Introduction to loading Addressable assets (4.0)"
page_title: "Introduction to loading Addressable assets | Addressables | 4.0.2"
source_url: "https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/load-addressable-assets.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/load-addressable-assets.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to loading Addressable assets

The <a href="https://docs.unity3d.com/Packages/com.unity.addressables@4.0/api/UnityEngine.AddressableAssets.Addressables.html" class="xref"><code>Addressables</code></a> class provides methods to load Addressable assets. You can load assets one at a time or in batches. To identify the assets to load, you pass either a single key or a list of keys to the loading method. A key can be one of the following objects:

-   **Address**: A string containing the address you assigned to the asset
-   **Label**: A string containing a label assigned to one or more assets
-   **AssetReference object**: An instance of <a href="https://docs.unity3d.com/Packages/com.unity.addressables@4.0/api/UnityEngine.AddressableAssets.AssetReference.html" class="xref"><code>AssetReference</code></a>
-   <a href="https://docs.unity3d.com/Packages/com.unity.addressables@4.0/api/UnityEngine.ResourceManagement.ResourceLocations.IResourceLocation.html" class="xref"><code>IResourceLocation</code></a> instance: An intermediate object that contains information to load an asset and its dependencies.

## How Addressables loads assets

When you call one of the asset loading methods, the Addressables system begins an asynchronous operation that carries out the following tasks:

1.  Looks up the resource locations for the specified keys, except `IResourceLocation` keys.
2.  Gathers the list of dependencies.
3.  If using the content directory system, registers any required content directories if not already registered.
4.  If using the AssetBundle system, performs the following steps:
    1.  Downloads any remote AssetBundles that are required.
    2.  Loads the AssetBundles into memory.
5.  Sets the <a href="https://docs.unity3d.com/Packages/com.unity.addressables@4.0/api/UnityEngine.ResourceManagement.AsyncOperations.AsyncOperationHandle.Result.html#UnityEngine_ResourceManagement_AsyncOperations_AsyncOperationHandle_Result" class="xref"><code>Result</code></a> object of the operation to the loaded objects.
6.  Updates the <a href="https://docs.unity3d.com/Packages/com.unity.addressables@4.0/api/UnityEngine.ResourceManagement.AsyncOperations.AsyncOperationHandle.Status.html#UnityEngine_ResourceManagement_AsyncOperations_AsyncOperationHandle_Status" class="xref"><code>Status</code></a> of the operation and calls any <a href="https://docs.unity3d.com/Packages/com.unity.addressables@4.0/api/UnityEngine.ResourceManagement.AsyncOperations.AsyncOperationHandle.Completed.html" class="xref"><code>Completed</code></a> event listeners.

If the load operation succeeds, the `Status` is set to `Succeeded` and the loaded object or objects can be accessed from the <a href="https://docs.unity3d.com/Packages/com.unity.addressables@4.0/api/UnityEngine.ResourceManagement.AsyncOperations.AsyncOperationHandle.Result.html#UnityEngine_ResourceManagement_AsyncOperations_AsyncOperationHandle_Result" class="xref"><code>Result</code></a> object.

If an error occurs, the exception is copied to the <a href="https://docs.unity3d.com/Packages/com.unity.addressables@4.0/api/UnityEngine.ResourceManagement.AsyncOperations.AsyncOperationHandle.OperationException.html#UnityEngine_ResourceManagement_AsyncOperations_AsyncOperationHandle_OperationException" class="xref"><code>OperationException</code></a> member of the operation object and the `Status` is set to `Failed`. By default, the exception isn't thrown as part of the operation. However, you can assign a handler function to the <a href="https://docs.unity3d.com/Packages/com.unity.addressables@4.0/api/UnityEngine.ResourceManagement.ResourceManager.ExceptionHandler.html#UnityEngine_ResourceManagement_ResourceManager_ExceptionHandler" class="xref"><code>ResourceManager.ExceptionHandler</code></a> property to handle any exceptions. You can also enable the <a href="https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/AddressableAssetSettings.html" class="xref">Log Runtime Exceptions</a> option in the Addressable system settings to record errors to the <a href="https://docs.unity3d.com/Manual/Console.html" class="xref">Unity Console</a>.

When you call loading methods that load multiple Addressable assets, you can specify whether to abort the operation if any single load operation fails, or to load any assets it can. In both cases, the operation status is set to failed. Set the `releaseDependenciesOnFailure` parameter to `true` in the call to the loading method to abort the entire operation on any failure.

## Asynchronous loading

The Addressables API is asynchronous and returns an <a href="https://docs.unity3d.com/Packages/com.unity.addressables@4.0/api/UnityEngine.ResourceManagement.AsyncOperations.AsyncOperationHandle.html" class="xref"><code>AsyncOperationHandle</code></a> to manage operation progress and completion.

Addressables is designed to be content location agnostic. The content might need to be downloaded first or use other methods that can take a long time. To force synchronous execution, refer to [Synchronous loading](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/SynchronousAddressables.html) for more information.

When loading an asset for the first time, the handle is complete after a minimum of one frame. If the content has already loaded, execution times might differ between the various asynchronous loading options. You can wait until the load has completed as follows:

-   [Coroutine](xref:UnityEngine.Coroutine): Always delayed at a minimum of one frame before execution continues.
-   <a href="https://docs.unity3d.com/Packages/com.unity.addressables@4.0/api/UnityEngine.ResourceManagement.AsyncOperations.AsyncOperationHandle.Completed.html" class="xref"><code>Completed</code> callback</a>: A minimum of one frame if the content hasn't already loaded, otherwise the callback is invoked in the same frame.
-   Awaiting <a href="https://docs.unity3d.com/Packages/com.unity.addressables@4.0/api/UnityEngine.ResourceManagement.AsyncOperations.AsyncOperationHandle.Task.html#UnityEngine_ResourceManagement_AsyncOperations_AsyncOperationHandle_Task" class="xref"><code>AsyncOperationHandle.Task</code></a>: A minimum of one frame if the content hasn't already loaded, otherwise the execution continues in the same frame.

``` lang-cs
using System.Collections;
using UnityEngine;
using UnityEngine.AddressableAssets;
using UnityEngine.ResourceManagement.AsyncOperations;

internal class AsynchronousLoading : MonoBehaviour

    // minimum of 1 frame for new asset loads
    // callback called in current frame for already loaded assets
    void LoadAssetCallback()
    {
        loadHandle = Addressables.LoadAssetAsync<GameObject>(address);
        loadHandle.Completed += h =>
        {
            // Loaded here
        };
    }

    // minimum of 1 frame for new asset loads
    // await completes in current frame for already loaded assets
    async void LoadAssetWait()
    
    private void OnDestroy()
    
}
```

## Additional resources

-   [Asynchronous operation handles](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/AddressableAssetsAsyncOperationHandle.html)
-   [Load assets](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/load-assets.html)
