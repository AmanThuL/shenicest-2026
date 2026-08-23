---
title: "Retrieve test results (ICallbacks)"
page_title: "Unity - Manual: Retrieve test results"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/extension-get-test-results.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/extension-get-test-results.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Retrieve test results

You can receive callbacks when the active test run, or individual tests, starts and finishes. You can register callbacks by invoking `RegisterCallbacks` on the [`TestRunnerApi`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEditor.TestTools.TestRunner.Api.TestRunnerApi.html) with an instance of a class that implements [`ICallbacks`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEditor.TestTools.TestRunner.Api.ICallbacks.html). There are four `ICallbacks` methods for the start and finish of both the whole run and each level of the test tree.

The folliwng example shows how listeners can be set up:

**Note**: Listeners receive callbacks from all test runs, regardless of the registered `TestRunnerApi` for that instance.

``` lang-cs
public void SetupListeners()

private class MyCallbacks : ICallbacks

    public void RunFinished(ITestResultAdaptor result)
    
    public void TestStarted(ITestAdaptor test)
    
    public void TestFinished(ITestResultAdaptor result)
    {
        if (!result.HasChildren && result.ResultState != "Passed")
        {
            Debug.Log(string.Format("Test {0} {1}", result.Test.Name, result.ResultState));
        }
    }
}
```

**Note**: The registered callbacks are not persisted on domain reloads. So it is necessary to re-register the callback after a domain reloads, usually with [InitializeOnLoad](https://docs.unity3d.com/Manual/RunningEditorCodeOnLaunch.html).

It is possible to provide a `priority` as an integer as the second argument when registering a callback. This influences the invocation order of different callbacks. The default value is zero. It is also possible to provide `RegisterCallbacks` with a class instance that implements [`IErrorCallbacks`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEditor.TestTools.TestRunner.Api.IErrorCallbacks.html) that is an extended version of `ICallbacks`. `IErrorCallbacks` also has a callback method for `OnError` that invokes if the run fails to start, for example, due to compilation errors or if an [IPrebuildSetup](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-setup-and-cleanup.html) throws an exception.

## Additional resources

-   [Retrieve the list of tests](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/extension-retrieve-test-list.html)
