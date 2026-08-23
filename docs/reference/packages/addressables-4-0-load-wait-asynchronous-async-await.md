---
title: "Wait for asynchronous loads with async and await (4.0)"
page_title: "Wait for asynchronous loads with async and await | Addressables | 4.0.2"
source_url: "https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/load-wait-asynchronous-async-await.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/load-wait-asynchronous-async-await.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Wait for asynchronous loads with async and await

<a href="https://docs.unity3d.com/Packages/com.unity.addressables@4.0/api/UnityEngine.ResourceManagement.AsyncOperations.AsyncOperationHandle.html" class="xref"><code>AsyncOperationHandle</code></a> provides a <a href="https://docs.unity3d.com/Packages/com.unity.addressables@4.0/api/UnityEngine.ResourceManagement.AsyncOperations.AsyncOperationHandle.Task.html#UnityEngine_ResourceManagement_AsyncOperations_AsyncOperationHandle_Task" class="xref"><code>Task</code></a> object that you can use with the C# `async` and `await` keywords to sequence code that calls asynchronous methods and handles the results.

The following example loads Addressable assets using a list of keys. The differences between this task-based approach and the [coroutine](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/load-wait-asynchronous-coroutines.html) or [event-based approaches](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/load-wait-asynchronous-events.html) are in the signature of the calling method. This method must include the `async` and `await` keywords with the operation handle's `Task` property. The calling method, `Start` in this case, suspends operation while the task finishes. Execution then resumes and the example instantiates all the loaded prefabs in a grid pattern.

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

##### Note

Awaiting `Task` never throws - it resolves to `default` on most failures, though a `LoadAssetsAsync` call with `releaseDependenciesOnFailure: false` can return a non-null partial result instead. Check <a href="https://docs.unity3d.com/Packages/com.unity.addressables@4.0/api/UnityEngine.ResourceManagement.AsyncOperations.AsyncOperationHandle.Status.html#UnityEngine_ResourceManagement_AsyncOperations_AsyncOperationHandle_Status" class="xref"><code>AsyncOperationHandle.Status</code></a> or <a href="https://docs.unity3d.com/Packages/com.unity.addressables@4.0/api/UnityEngine.ResourceManagement.AsyncOperations.AsyncOperationHandle.OperationException.html#UnityEngine_ResourceManagement_AsyncOperations_AsyncOperationHandle_OperationException" class="xref"><code>OperationException</code></a> to detect failure this way.

## Await an operation handle directly

You can also `await` an <a href="https://docs.unity3d.com/Packages/com.unity.addressables@4.0/api/UnityEngine.ResourceManagement.AsyncOperations.AsyncOperationHandle.html" class="xref"><code>AsyncOperationHandle</code></a> or <a href="https://docs.unity3d.com/Packages/com.unity.addressables@4.0/api/UnityEngine.ResourceManagement.AsyncOperations.AsyncOperationHandle-1.html" class="xref"><code>AsyncOperationHandle&lt;T&gt;</code></a> directly, without going through `Task`. This is built on Unity's [`Awaitable`](xref:UnityEngine.Awaitable) type and, unlike `Task`, throws an <a href="https://docs.unity3d.com/Packages/com.unity.addressables@4.0/api/UnityEngine.ResourceManagement.Exceptions.AsyncOperationHandleException.html" class="xref"><code>AsyncOperationHandleException</code></a> on failure, so a normal `try`/`catch` works:

``` lang-cs
using System;
using System.Threading;
using UnityEngine;
using UnityEngine.AddressableAssets;
using UnityEngine.ResourceManagement.Exceptions;

internal class LoadWithAwait : MonoBehaviour

        catch (OperationCanceledException)
        
        catch (AsyncOperationHandleException<GameObject> e)
        {
            // Release immediately rather than waiting for OnDisable to eventually cancel
            // m_Cts: the failed handle stays valid (and unreleased) until then, and the
            // component could stay enabled indefinitely after a failed load.
            Debug.LogError($"Failed to load '{address}': {e.Message}");
            e.Handle.Release();
        }
    }

    void OnDisable()
    
}
```

A failed operation's handle isn't released automatically - catch the typed <a href="https://docs.unity3d.com/Packages/com.unity.addressables@4.0/api/UnityEngine.ResourceManagement.Exceptions.AsyncOperationHandleException-1.html" class="xref"><code>AsyncOperationHandleException&lt;T&gt;</code></a> (or <a href="https://docs.unity3d.com/Packages/com.unity.addressables@4.0/api/UnityEngine.ResourceManagement.Exceptions.AsyncOperationHandleException.html" class="xref"><code>AsyncOperationHandleException</code></a> for non-generic handles) and release `e.Handle`, which is exactly the handle that failed. Release it in the `catch` block itself; waiting for a later lifecycle event (`OnDisable`, `OnDestroy`, a cancellation token) leaves it unreleased until then.

This example keeps the instantiated result alive past the call that created it. Releasing the handle in `OnDisable` alone isn't enough: `OnDisable` can run while the load from `OnEnable` is still pending, and releasing the handle there doesn't stop the `await` from resuming later against a disabled object.

<a href="https://docs.unity3d.com/Packages/com.unity.addressables@4.0/api/UnityEngine.ResourceManagement.AsyncOperations.AsyncOperationHandle-1.ToAwaitable.html#UnityEngine_ResourceManagement_AsyncOperations_AsyncOperationHandle_1_ToAwaitable_System_Threading_CancellationToken_" class="xref"><code>AsyncOperationHandle.ToAwaitable(CancellationToken)</code></a> closes that gap: canceling the token always releases the handle, and also throws `OperationCanceledException` if the load is still pending. If the load already resolved successfully, the cancellation just releases the handle with no throw. `OnDisable` above cancels a `CancellationTokenSource` created fresh each `OnEnable`, so a disable at any point cleans everything up.

##### Note

`OnEnable`/`OnDisable` can run many times over a component's life, so the token must be created fresh each `OnEnable` and canceled in the matching `OnDisable`. [`destroyCancellationToken`](xref:UnityEngine.MonoBehaviour.destroyCancellationToken) only cancels on final destruction, so it doesn't fit here - but it's exactly right for a one-shot load, as in the next example.

For a one-shot load started from `Start()`, <a href="https://docs.unity3d.com/Packages/com.unity.addressables@4.0/api/UnityEngine.ResourceManagement.AsyncOperations.AsyncOperationHandle-1.ToAwaitable.html#UnityEngine_ResourceManagement_AsyncOperations_AsyncOperationHandle_1_ToAwaitable_UnityEngine_MonoBehaviour_" class="xref"><code>ToAwaitable(MonoBehaviour)</code></a> is simpler: it ties cancellation to `destroyCancellationToken` for you, so no cleanup method - not even `OnDestroy` - is needed:

``` lang-cs
using System;
using UnityEngine;
using UnityEngine.AddressableAssets;
using UnityEngine.ResourceManagement.Exceptions;

internal class LoadOnceWithAwait : MonoBehaviour

        catch (OperationCanceledException)
        
        catch (AsyncOperationHandleException<GameObject> e)
        {
            // Release immediately rather than waiting for destroyCancellationToken to
            // eventually fire: the failed handle stays valid (and unreleased) until this
            // object is actually destroyed, which could be arbitrarily far in the future.
            Debug.LogError($"Failed to load '{address}': {e.Message}");
            e.Handle.Release();
        }
    }
}
```

##### Note

`AsyncOperationHandleException`'s <a href="https://learn.microsoft.com/dotnet/api/system.exception.innerexception" class="xref"><code>InnerException</code></a> is the operation's <a href="https://docs.unity3d.com/Packages/com.unity.addressables@4.0/api/UnityEngine.ResourceManagement.AsyncOperations.AsyncOperationHandle.OperationException.html#UnityEngine_ResourceManagement_AsyncOperations_AsyncOperationHandle_OperationException" class="xref"><code>OperationException</code></a>. Releasing `e.Handle` matters even more for <a href="https://docs.unity3d.com/Packages/com.unity.addressables@4.0/api/UnityEngine.AddressableAssets.Addressables.LoadAssetsAsync.html" class="xref"><code>LoadAssetsAsync</code></a> with `releaseDependenciesOnFailure: false`: it can fail with a partial result (loaded assets alongside `null` entries), reachable through `e.Handle.Result` before you release it:

``` lang-csharp
try

catch (AsyncOperationHandleException<IList<GameObject>> e)

```

When you load multiple assets with <a href="https://docs.unity3d.com/Packages/com.unity.addressables@4.0/api/UnityEngine.AddressableAssets.Addressables.LoadAssetsAsync.html" class="xref"><code>LoadAssetsAsync</code></a> and don't need to keep them past the call site, you don't need to keep the handle either: <a href="https://docs.unity3d.com/Packages/com.unity.addressables@4.0/api/UnityEngine.AddressableAssets.Addressables.Release.html" class="xref"><code>Addressables.Release</code></a> can look up the handle from the result object it returned, so releasing the awaited result in the same scope is enough. Doing the load, use, and release in one method avoids any window where the object could be disabled before the `await` completes. This only applies on success, though - on failure there's no result to release by, so the `catch` block releases `e.Handle` instead:

``` lang-cs
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AddressableAssets;
using UnityEngine.ResourceManagement.Exceptions;

internal class LoadMultipleWithAwait : MonoBehaviour
{
    public string label = "characters";

    // Load, use, and release in one self-contained scope - no lifecycle callback can run
    // before the await completes, so there's no window for a disable to leave it unreleased.
    // To keep assets past this method, store the handle instead - see LoadWithAwait.
    async void Start()
    {
        IList<GameObject> loaded = null;
        try
        {
            loaded = await Addressables.LoadAssetsAsync<GameObject>(label);
            foreach (var prefab in loaded)
                Debug.Log($"Loaded '{prefab.name}' for label '{label}'.");
        }
        catch (AsyncOperationHandleException<IList<GameObject>> e)
        {
            // The awaited handle releases itself on failure - only e.Handle needs releasing.
            Debug.LogError($"Failed to load label '{label}': {e.Message}");
            e.Handle.Release();
        }
        finally
        
    }
}
```

##### Important

`Addressables.Release` finds the handle by looking up the exact object instance the load returned. Copying the result (for example with `.ToList()`) and releasing the copy has no effect and logs an error - always release the same instance the `await` produced.

To keep the loaded assets alive past the method that loaded them, see the two single-asset examples above: a `CancellationTokenSource` scoped to `OnEnable`/`OnDisable` for a repeatable load, or `ToAwaitable(MonoBehaviour)` for a one-shot load.

## Additional resources

-   [Asynchronous programming scenarios](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/concepts/async/)
-   [Wait for asynchronous loads to complete](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/AddressableAssetsAsyncOperationHandle.html)
-   [Wait for asynchronous loads with coroutines](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/load-wait-asynchronous-coroutines.html)
-   [Wait for asynchronous loads with events](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/load-wait-asynchronous-events.html)
