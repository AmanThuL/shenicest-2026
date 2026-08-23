---
title: "Running tests from code (TestRunnerApi)"
page_title: "Unity - Manual: Running tests from code"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/running-tests-from-code.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/running-tests-from-code.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Running tests from code

You can invoke Unity Test Framework’s test runner from code with the [`TestRunnerAPI`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEditor.TestTools.TestRunner.Api.TestRunnerApi.html) class, which lets you control which tests are run and retrieve test data and results.

| **Topic**                                                                                                                               | **Description**                                                                                                                                                                                                                                                                                                                                                                                            |
|:----------------------------------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **[Specify which tests to run](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/extension-run-tests.html)**          | Compose [`Filter`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEditor.TestTools.TestRunner.Api.Filter.html) objects for the [`TestRunnerAPI`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEditor.TestTools.TestRunner.Api.TestRunnerApi.html) to determine which tests to include in a test run. |
| **[Retrieving test results](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/extension-get-test-results.html)**      | Register to receive callbacks from the test runner at the start or finish of an active test run or individual test.                                                                                                                                                                                                                                                                                        |
| **[Retrieve the list of tests](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/extension-retrieve-test-list.html)** | Retrieve the test tree for a given test mode (Edit mode or Play mode) from the test runner.                                                                                                                                                                                                                                                                                                                |

## Additional resources

-   [Run tests in the Test Runner window](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/workflow-run-test.html)
-   [Run tests from the command line](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/run-tests-from-command-line.html)
