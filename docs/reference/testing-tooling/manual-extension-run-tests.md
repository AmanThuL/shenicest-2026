---
title: "Specify which tests to run (TestRunnerApi Filter)"
page_title: "Unity - Manual: Specify which tests to run"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/extension-run-tests.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/extension-run-tests.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Specify which tests to run

To run tests from code, call `Execute` on the [TestRunnerApi](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEditor.TestTools.TestRunner.Api.TestRunnerApi.html) and specify which tests to run with a [Filter](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEditor.TestTools.TestRunner.Api.Filter.html).

The following example runs all Play mode tests in a project:

``` lang-cs
var testRunnerApi = ScriptableObject.CreateInstance<TestRunnerApi>();
var filter = new Filter()
{
    testMode = TestMode.PlayMode
};
testRunnerApi.Execute(new ExecutionSettings(filter));
```

## Multiple filter values

You can define additional fields on the `Filter` class to create a more specific filter.

Many of the fields allow for multiple values. When you define multiple values for a field, the test runner runs any tests that match at least one of the values.

The following example runs tests with full names that match either of the two names provided:

``` lang-cs
var api = ScriptableObject.CreateInstance<TestRunnerApi>();
api.Execute(new ExecutionSettings(new Filter()

}));
```

## Multiple filter fields

If you define multiple fields on a filter, the runner only runs tests that match all the fields.

In this example, it runs any test in the specified assembly with a name that matches either of the two specified test names.

``` lang-cs
var api = ScriptableObject.CreateInstance<TestRunnerApi>();
api.Execute(new ExecutionSettings(new Filter()
{
    assemblyNames = new [] {"MyTestAssembly"},
    testNames = new [] 
}));
```

## Multiple constructor filters

The execution settings take one or more filters in its constructor. If there is no filter provided, then it runs all Edit mode tests by default. If there are multiple filters provided, then a test runs if it matches any of the filters.

The following runs all tests in the assembly named `MyTestAssembly` any test with a name that matches either of the two specified test names:

``` lang-cs
var api = ScriptableObject.CreateInstance<TestRunnerApi>();
api.Execute(new ExecutionSettings(
    new Filter()
    {
        assemblyNames = new[] {"MyTestAssembly"},
    },
    new Filter()
    
    }
));
```

**Note**: Specifying different test modes or platforms in each `Filter` is not currently supported. The test mode and platform is from the first `Filter` only and defaults to Edit Mode, if not supplied.

## Additional resources

-   [Retrieve test results](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/extension-get-test-results.html)
-   [Retrieve the list of tests](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/extension-retrieve-test-list.html)
