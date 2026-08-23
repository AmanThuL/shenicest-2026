---
title: "Unload Addressable assets (4.0)"
page_title: "Unload Addressable assets | Addressables | 4.0.2"
source_url: "https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/UnloadingAddressableAssets.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/UnloadingAddressableAssets.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Unload Addressable assets

The Addressables system uses reference counting to check whether an asset is in use. This means that you must release every asset that you load or instantiate when you're finished with it. Refer to [Memory management](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/MemoryManagement.html) for more information.

The unloading behavior of a scene depends on the [content build system](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/content-build-systems.html) you use:

-   **AssetBundles**: When you unload a scene, the AssetBundle it belongs to is unloaded. This unloads assets associated with the scene, including any GameObjects moved from the original scene to a different scene.
-   **Content directories**: When you unload a scene, the scene and its associated assets are released but the content directory remains registered.

Unity automatically calls [`UnloadUnusedAssets`](xref:UnityEngine.Resources.UnloadUnusedAssets) when it loads a scene using the [`LoadSceneMode.Single`](xref:UnityEngine.SceneManagement.LoadSceneMode.Single) mode. To prevent the scene and its assets from being unloaded, keep a reference to the scene load operation handle until you want to unload the scene manually. To do this, use <a href="https://docs.unity3d.com/Packages/com.unity.addressables@4.0/api/UnityEngine.ResourceManagement.ResourceManager.Acquire.html#UnityEngine_ResourceManagement_ResourceManager_Acquire_UnityEngine_ResourceManagement_AsyncOperations_AsyncOperationHandle_" class="xref"><code>ResourceManager.Acquire</code></a> on the load operation handle.

##### Important

Conventional methods of preserving the assets such as [`Object.DontDestroyOnLoad`](xref:UnityEngine.Object.DontDestroyOnLoad(UnityEngine.Object)) or [`HideFlags.DontUnloadUnusedAsset`](xref:UnityEngine.HideFlags.DontUnloadUnusedAsset) don't work.

Individual Addressable assets and their operation handles that you load separately from the scene aren't released. You must call <a href="https://docs.unity3d.com/Packages/com.unity.addressables@4.0/api/UnityEngine.AddressableAssets.Addressables.Release.html" class="xref"><code>Addressables.Release</code></a> to free these assets. The exception to this is that any Addressable assets that you instantiate using <a href="https://docs.unity3d.com/Packages/com.unity.addressables@4.0/api/UnityEngine.AddressableAssets.Addressables.InstantiateAsync.html" class="xref"><code>Addressables.InstantiateAsync</code></a> with `trackHandle` set to true, the default, are automatically released.

## Additional resources

-   [Memory management](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/MemoryManagement.html)
-   [Load Addressable assets](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/LoadingAddressableAssets.html)
-   [Asset and AssetBundle dependencies](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/AssetDependencies.html)
-   [Wait for asynchronous loads to complete](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/AddressableAssetsAsyncOperationHandle.html)
-   <a href="https://docs.unity3d.com/Packages/com.unity.addressables@4.0/api/UnityEngine.ResourceManagement.ResourceManager.html" class="xref"><code>ResourceManager API</code> reference</a>
-   <a href="https://docs.unity3d.com/Packages/com.unity.addressables@4.0/api/UnityEngine.AddressableAssets.Addressables.Release.html" class="xref"><code>Addressables.Release</code> API reference</a>
