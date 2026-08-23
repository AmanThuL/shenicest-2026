---
title: "Wait for asynchronous loads with async and await"
page_title: "Wait for asynchronous loads with async and await | Addressables | 2.9.1"
source_url: "https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/load-wait-asynchronous-async-await.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/load-wait-asynchronous-async-await.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Wait for asynchronous loads with async and await

<a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/api/UnityEngine.ResourceManagement.AsyncOperations.AsyncOperationHandle.html" class="xref"><code>AsyncOperationHandle</code></a> provides a <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/api/UnityEngine.ResourceManagement.AsyncOperations.AsyncOperationHandle.Task.html#UnityEngine_ResourceManagement_AsyncOperations_AsyncOperationHandle_Task" class="xref"><code>Task</code></a> object that you can use with the C# `async` and `await` keywords to sequence code that calls asynchronous methods and handles the results.

The following example loads Addressable assets using a list of keys. The differences between this task-based approach and the [coroutine](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/load-wait-asynchronous-coroutines.html) or [event-based approaches](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/load-wait-asynchronous-events.html) are in the signature of the calling method. This method must include the `async` and `await` keywords with the operation handle's `Task` property. The calling method, `Start` in this case, suspends operation while the task finishes. Execution then resumes and the example instantiates all the loaded prefabs in a grid pattern.

``` lang-cs
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AddressableAssets;
using UnityEngine.ResourceManagement.AsyncOperations;

internal class LoadWithTask : MonoBehaviour
{
    // Label or address strings to load
    public List<string> keys = new List<string>() {"characters", "animals"};

    // Operation handle used to load and release assets
    AsyncOperationHandle<IList<GameObject>> loadHandle;

    public async void Start()
    {
        loadHandle = Addressables.LoadAssetsAsync<GameObject>(
            keys, // Either a single key or a List of keys
            addressable =>
            {
                // Called for every loaded asset
                Debug.Log(addressable.name);
            }, Addressables.MergeMode.Union, // How to combine multiple labels
            false); // Whether to fail if any asset fails to load

        // Wait for the operation to finish in the background
        await loadHandle.Task;

        // Instantiate the results
        float x = 0, z = 0;
        foreach (var addressable in loadHandle.Result)
        
            }
        }
    }

    private void OnDestroy()
    
}
```

When you use `Task`-based operation handling, you can use the C# `Task` class methods such as [`WhenAll`](https://docs.microsoft.com/en-us/dotnet/api/system.threading.tasks.task.whenall) to control which operations you run in parallel and which you want to run in sequence. The following example illustrates how to wait for more than one operation to finish before moving onto the next task:

``` lang-cs
// Load the Prefabs
var prefabOpHandle = Addressables.LoadAssetsAsync<GameObject>(
    keys, null, Addressables.MergeMode.Union, false);

// Load a Scene additively
var sceneOpHandle
    = Addressables.LoadSceneAsync(nextScene,
        UnityEngine.SceneManagement.LoadSceneMode.Additive);

await System.Threading.Tasks.Task.WhenAll(prefabOpHandle.Task, sceneOpHandle.Task);
```

## Additional resources

-   [Asynchronous programming scenarios](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/concepts/async/)
-   [Wait for asynchronous loads to complete](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/AddressableAssetsAsyncOperationHandle.html)
-   [Wait for asynchronous loads with coroutines](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/load-wait-asynchronous-coroutines.html)
-   [Wait for asynchronous loads with events](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/load-wait-asynchronous-events.html)
