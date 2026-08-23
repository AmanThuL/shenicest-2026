---
title: "Performing actions before and after tests"
page_title: "Unity - Manual: Performing actions before and after tests"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/before-and-after-tests.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/before-and-after-tests.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Performing actions before and after tests

Write reliable tests by performing the appropriate pre-test setup and post-test cleanup work to ensure your tests run in the right state. Unity Test Framework has a range of APIs that allow you to perform work at defined stages before and after a test run.

| **Topic**                                                                                                                                                         | **Description**                                                                                                                                                                                                                                 |
|:------------------------------------------------------------------------------------------------------------------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **[Setting up and tearing down tests](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-unitysetup-and-unityteardown.html)**          | Use Unity Test Framework APIs for test setup and tear down.                                                                                                                                                                                     |
| **[Performing actions before setup or after tear down](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-outerunitytestaction.html)** | Use the [IOuterUnityTestAction](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.IOuterUnityTestAction.html) API to do work outside the test before setup and after tear down. |
| **[Setting up and cleaning up at build time](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-setup-and-cleanup.html)**              | Make changes to Unity or the file system before building tests and then clean up these changes after the test run.                                                                                                                              |
| **[Execution order of test actions](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-actions-outside-tests.html)**                   | Understand the order in which test actions run relative to one another.                                                                                                                                                                         |

## Additional resources

-   [Setup and teardown](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/setup-teardown.html)
-   [Setup and cleanup at build time](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/build-setup-cleanup.html)
