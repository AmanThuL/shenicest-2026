---
title: "Setting up and cleaning up at build time (IPrebuildSetup / IPostBuildCleanup)"
page_title: "Unity - Manual: Setting up and cleaning up at build time"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-setup-and-cleanup.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-setup-and-cleanup.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Setting up and cleaning up at build time

Sometimes you might want to make changes to Unity or the file system before building tests and then clean up these changes after the test run. You can incorporate pre-build setup and post-build cleanup stages in your tests in one of the following ways:

-   Implement [`IPrebuildSetup`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.IPrebuildSetup.html) and [`IPostBuildCleanup`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.IPostBuildCleanup.html) interfaces in a test class.
-   Apply the [`[PrebuildSetup]`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.PrebuildSetupAttribute.html) and [`[PostBuildCleanup]`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.PostBuildCleanupAttribute.html) attributes to your test class, to an individual test, or to the test assembly, and provide a class that implements the corresponding interface as an argument. For example, decorate a test method with `[PrebuildSetup("MyTestSceneSetup")]` to perform prebuild setup work defined in a class called `MyTestSceneSetup` that implements `IPrebuildSetup`.

Both `PrebuildSetup` and `PostBuildCleanup` attributes run if the test or test class they’re applied to is included in the current test run. The test is included when you run all tests or if you define a [filter](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/extension-run-tests.html) that includes it. If multiple tests reference the same pre-build setup or post-build cleanup, then it only runs once.

The following example implements `IPrebuildSetup` on a test class to define work to perform prior to building tests:

``` lang-cs
[TestFixture]
public class CreateSpriteTest : IPrebuildSetup

    [SetUp]
    public void SetUpTest()
    
    [Test]
    public void WhenNullTextureIsPassed_CreateShouldReturnNullSprite()
    
}
```

**Note**: Use `#if UNITY_EDITOR` if you want to access Editor only APIs, but the setup/cleanup is inside a **Play Mode** assembly.

## Setup and Cleanup with Test Data

You can use the [`IPrebuildSetupWithTestData`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.IPrebuildSetupWithTestData.html) and the [`IPostBuildCleanupWithTestData`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.IPostBuildCleanupWithTestData.html) interfaces to define setup and cleanup methods that have access to [`Test Data`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.TestData.html). The test data contains information about the tests that are about to or have just run.

The respective attributes also exist and the same rules and patterns apply as specified above.

## Execution order

All setups run in a deterministic order one after another. Setups defined with attributes run first. Then any test class implementing the interface runs, in alphabetical order within their namespace, which is the same order as the tests run.

Setups that provide the TestData object will run in the above order before all the Setups that do not provide data. The same applies to the Cleanups.

In a Player build, cleanup runs immediately after the test. In the Unity Editor cleanup runs only after related tests complete.

## Additional resources

-   [Setup and cleanup at build time](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/build-setup-cleanup.html)
