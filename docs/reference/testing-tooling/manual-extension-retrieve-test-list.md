---
title: "Retrieve the list of tests"
page_title: "Unity - Manual: Retrieve the list of tests"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/extension-retrieve-test-list.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/extension-retrieve-test-list.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Retrieve the list of tests

You can use the [`TestRunnerApi`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEditor.TestTools.TestRunner.Api.TestRunnerApi.html) to retrieve the test tree for a given test mode (Edit mode or Play mode). You can retrieve the test tree by invoking `RetrieveTestList` with the desired `TestMode` and a callback action, with an [`ITestAdaptor`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEditor.TestTools.TestRunner.Api.ITestAdaptor.html) representing the test tree.

## Example

The following example retrieves the test tree for Edit Mode tests and prints the number of total test cases:

``` lang-cs
var api = ScriptableObject.CreateInstance<TestRunnerApi>();
api.RetrieveTestList(TestMode.EditMode, (testRoot) =>
{
    Debug.Log(string.Format("Tree contains {0} tests.", testRoot.TestCaseCount));
});
```

## Additional resources

-   [Specifying which tests to run](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/extension-run-tests.html)
-   [Retrieve test results](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/extension-get-test-results.html)
