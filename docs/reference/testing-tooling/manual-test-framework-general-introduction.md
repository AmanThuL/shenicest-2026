---
title: "General introduction to Unity Test Framework (course)"
page_title: "Unity - Manual: General introduction to Unity Test Framework"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/test-framework-general-introduction.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/test-framework-general-introduction.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# General introduction to Unity Test Framework

Welcome to the Unity Test Framework general introduction course.

This course consists of different exercises to help you learn fundamental Unity Test Framework concepts through practical examples. Each exercise has a **Learning Objectives** section to help you identify the skills you will learn. The exercises are grouped thematically, and their difficulty varies.

After completing an exercise, you can check your solution against the one provided. Note that many of the exercises can be solved in several possible ways.

<span id="import-samples"></span>

## Import samples

Project files for each exercise and its accompanying solution are provided as samples with the Unity Test Framework package. To import an exercise or solution to your Unity Editor:

1.  Go to **Window > Package Manager** and, in the [packages list view](https://docs.unity3d.com/Manual/upm-ui-list.html), selct Unity Test Framework.
2.  In the package [details view](https://docs.unity3d.com/Manual/upm-ui-details.html), find the **Samples** section.
3.  Find the exercise or solution you want to import and click the import button.

![The Package Manager window with the expanded list of package samples available for import.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/test-framework/samples.png)

**Note**: You can import an exercise and its solution or multiple exercises at the same time, but since several of the exercises use the same naming pattern this will likely result in compilation errors that prevent you running tests or building your project. The recommended workflow is to import and work on one exercise at a time. If you import additional exercises or solutions for reference, you can delete them again before running your main exercise.

## Course outline

| **Topic**                                                                                                                                            | **Description**                                                                                                                                                                                     |
|:-----------------------------------------------------------------------------------------------------------------------------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **[Running a test in a Unity project](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/running-test.html)**                | Set up a simple Unity project with a test assembly and tests and run them from the **Test Runner** window.                                                                                          |
| **[Arrange, act, assert](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/arrange-act-assert.html)**                       | Use the core unit testing principle of AAA (Arrange, Act, Assert) to structure your unit tests.                                                                                                     |
| **[Semantic test assertion](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/semantic-test-assertion.html)**               | Use `Assert.That` to test whether conditions are true.                                                                                                                                              |
| **[Custom comparison](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/custom-comparison.html)**                           | Use the Unity Test Framework’s custom equality comparers to check for value equality of Unity types.                                                                                                |
| **[Asserting logs](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/asserting-logs.html)**                                 | Test and verify code that writes to the console log.                                                                                                                                                |
| **[Setup and teardown](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/setup-teardown.html)**                             | Use the NUnit attributes `[SetUp]` and `[TearDown]` to reduce code duplication in your tests.                                                                                                       |
| **[Play mode tests](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/play-mode-tests.html)**                               | Create and run Play mode tests.                                                                                                                                                                     |
| **[Play mode tests in a player](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/play-mode-tests-in-player.html)**         | Run Play mode tests in a standalone platform Player.                                                                                                                                                |
| **[Using the UnityTest attribute](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/unitytest-attribute.html)**             | Use the `[UnityTest]` to write tests that run across multiple frames.                                                                                                                               |
| **[Long-running tests](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/long-running-tests.html)**                         | Write long-running tests that can instruct the Editor to wait for a defined period of time.                                                                                                         |
| **[Scene-based tests](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/scene-based-tests.html)**                           | Test content that is stored in a scene.                                                                                                                                                             |
| **[Setup and cleanup at build time](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/build-setup-cleanup.html)**           | Perform work before and after the Player build phase.                                                                                                                                               |
| **[Domain reload](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/domain-reload.html)**                                   | Invoke and wait for domain reload from your tests.                                                                                                                                                  |
| **[Preserve test state](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/preserve-test-state.html)**                       | Make data in your tests survive domain reloads using serialization.                                                                                                                                 |
| **[Test cases](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/test-cases.html)**                                         | Work with NUnit’s `[TestCase]` attribute in Unity tests.                                                                                                                                            |
| **[Custom attributes](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/custom-attributes.html)**                           | Implement custom NUnit attributes, which can be used to alter test execution.                                                                                                                       |
| **[Running tests programmatically](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/running-tests-programmatically.html)** | Run tests from code using the [TestRunnerAPI](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEditor.TestTools.TestRunner.Api.TestRunnerApi.html). |

## Additional resources

-   [Testing Lost Crypt](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/LostCrypt/lost-crypt-introduction.html)
