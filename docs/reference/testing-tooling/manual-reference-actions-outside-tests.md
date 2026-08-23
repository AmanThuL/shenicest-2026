---
title: "Execution order of test actions"
page_title: "Unity - Manual: Execution order of test actions"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-actions-outside-tests.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-actions-outside-tests.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Execution order of test actions

When writing tests, it is possible to avoid duplication of code by using the [SetUp and TearDown](https://docs.nunit.org/articles/nunit/technical-notes/usage/SetUp-and-TearDown.html) methods built into [NUnit](http://www.nunit.org/). The Unity Test Framework has extended these methods with extra functionality, which can yield commands and skip frames, in the same way as [`UnityTest`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.UnityTestAttribute.html).

## Action execution order

The actions related to a test run in the following order:

-   Attributes implementing [IApplyToContext](https://docs.nunit.org/articles/nunit/extending-nunit/IApplyToContext-Interface.html)
-   Methods marked with [`[UnityOneTimeSetUp]`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.UnityOneTimeSetUpAttribute.html).
-   Methods marked with [`[OneTimeSetup]`](https://docs.nunit.org/articles/nunit/writing-tests/attributes/onetimesetup.html).
-   The `BeforeTest` method of any attribute implementing [IOuterUnityTestAction](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.IOuterUnityTestAction.html).
-   Methods marked with [`[UnitySetUp]`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.UnitySetUpAttribute.html).
-   Attributes implementing [IWrapSetUpTearDown](https://docs.nunit.org/articles/nunit/extending-nunit/ICommandWrapper-Interface.html).
-   Methods marked with [`[SetUp]`](https://docs.nunit.org/articles/nunit/writing-tests/attributes/setup.html).
-   The `BeforeTest` method of [Action attributes](https://docs.nunit.org/articles/nunit/extending-nunit/Action-Attributes.html?q=action%20a).
-   Attributes implementing [IWrapTestMethod](https://docs.nunit.org/articles/nunit/extending-nunit/ICommandWrapper-Interface.html).
-   **The test itself runs**
-   The `AfterTest` method of [Action attributes](https://docs.nunit.org/articles/nunit/extending-nunit/Action-Attributes.html?q=action%20a).
-   Methods marked with [`[TearDown]`](https://docs.nunit.org/articles/nunit/writing-tests/attributes/teardown.html).
-   Methods marked with [`[UnityTearDown]`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.UnityTearDownAttribute.html).
-   The `AfterTest` method of any attribute implementing [IOuterUnityTestAction](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.IOuterUnityTestAction.html).
-   Methods marked with [`[OneTimeTearDown]`](https://docs.nunit.org/articles/nunit/writing-tests/attributes/onetimeteardown.html).
-   Methods marked with [`[UnityOneTimeTearDown]`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.UnityOneTimeTearDownAttribute.html).

The list of actions is the same for both `Test` and `UnityTest`.

### Execution order flow

![The order of execution for test actions and callbacks, with those that re-run on domain reload differentiated from those that don’t.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/test-framework/execution-order-full.png)

## Additional resources

-   [Setting up and tearing down tests](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-unitysetup-and-unityteardown.html)
-   [Performing actions before setup or after tear down](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-outerunitytestaction.html)
