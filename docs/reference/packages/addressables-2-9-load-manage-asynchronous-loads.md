---
title: "Manage asynchronous asset loading"
page_title: "Manage asynchronous asset loading | Addressables | 2.9.1"
source_url: "https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/load-manage-asynchronous-loads.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/load-manage-asynchronous-loads.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Manage asynchronous asset loading

By default, Addressables uses asynchronous loading to prevent tasks from blocking operations while they load or download data. You can control how Unity performs asynchronous loading through coroutines, events, and async and await tasks, or alternatively synchronously load assets.

| **Topic**                                                                                                                                                           | **Description**                                                                                                                      |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------|
| **[Wait for asynchronous loads to complete](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/AddressableAssetsAsyncOperationHandle.html)**       | Use `AsyncOperationHandle `to access asynchronous loaded objects.                                                                    |
| **[Wait for asynchronous loads with coroutines](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/load-wait-asynchronous-coroutines.html)**       | Use coroutines and `IEnumerator` to yield `AsyncOperationHandle` objects until operations complete.                                  |
| **[Wait for asynchronous loads with events](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/load-wait-asynchronous-events.html)**               | Use event delegates to handle asynchronous operations.                                                                               |
| **[Wait for asynchronous loads with async and await](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/load-wait-asynchronous-async-await.html)** | Use C# async/await patterns to handle asynchronous operations.                                                                       |
| **[Create a custom wait operation](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/load-custom-wait-operation.html)**                           | Create custom operations with proper execution, completion handling, and termination lifecycle management through `ResourceManager`. |
| **[Load assets synchronously](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/SynchronousAddressables.html)**                                   | Load assets synchronously with `WaitForCompletion`, which blocks execution until operations finish.                                  |
| **[Monitor wait operations](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/load-monitor-wait-operations.html)**                                | Track operation progress using `GetDownloadStatus` and `PercentComplete`.                                                            |

## Additional resources

-   [Load Addressable assets](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/LoadingAddressableAssets.html)
-   [Memory management](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/MemoryManagement.html)
-   <a href="https://docs.unity3d.com/Manual/Coroutines.html" class="xref">Unity coroutines documentation</a>
-   <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/api/UnityEngine.ResourceManagement.ResourceManager.html" class="xref"><code>ResourceManager</code> API reference</a>
-   <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/api/UnityEngine.ResourceManagement.AsyncOperations.AsyncOperationHandle.html" class="xref"><code>AsyncOperationHandle</code> API reference</a>
