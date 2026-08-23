---
title: "Testing your code (Unity Test Framework introduction)"
page_title: "Unity - Manual: Testing your code"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/test-framework-introduction.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/test-framework-introduction.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Testing your code

Write tests for your Edit mode or Play mode code and run them through the Unity Editor’s **Test Runner** window, from the command line, or from code. Unity Test Framework integrates a custom version of [NUnit](http://www.nunit.org/), the open-source unit testing library for .NET languages and extends it with Unity-specific capabilities.

As an alternative to [NUnit tests](https://docs.nunit.org/articles/nunit/writing-tests/attributes/test.html), Unity Test Framework provides [Unity tests](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.UnityTestAttribute.html), which can interact with Unity-specific concepts such as frames, the application loop, and [domain reload](https://docs.unity3d.com/6000.3/Documentation/Manual/domain-reloading.html). A Unity test runs as a [coroutine](https://docs.unity3d.com/6000.3/Documentation/Manual/Coroutines.html) in Play mode and in the [`EditorApplication.update`](https://docs.unity3d.com/ScriptReference/EditorApplication-update.html) callback loop in Edit mode.

Unity tests can [yield instructions for the Unity Editor](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-custom-yield-instructions.html). Once the instruction is complete, the test run continues. You can also `yield return null` in a Unity test to skip a frame and defer an operation until the next iteration of either the `EditorApplication.update` or the [per-frame game update](https://docs.unity3d.com/6000.3/Documentation/Manual/time-per-frame-updates.html) loop.

This documentation assumes you’re familiar with NUnit and with fundamental principles of unit testing in C#. If you’re not, refer to [Unit testing C# with NUnit and .NET Core](https://learn.microsoft.com/en-us/dotnet/core/testing/unit-testing-with-nunit) and [Unit testing best practices](https://learn.microsoft.com/en-us/dotnet/core/testing/unit-testing-best-practices) in the Microsoft documentation.

**Note**: Unity Test Framework is a [core Unity package](https://docs.unity3d.com/6000.3/Documentation/Manual/pack-core) and is distributed as part of a Unity Editor installation. Unity Test Framework currently uses a custom version of NUnit based on version 3.5.

| **Topic**                                                                                                                               | **Description**                                                                                                    |
|:----------------------------------------------------------------------------------------------------------------------------------------|:-------------------------------------------------------------------------------------------------------------------|
| **[Get started with Unity Test Framework](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/getting-started.html)**   | Create your first test assembly and sample Unity Test Framework tests.                                             |
| **[Command-line reference](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-command-line.html)**           | Run tests and configure test settings from the Unity Editor command line.                                          |
| **[Writing tests](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/writing-tests.html)**                             | Write Unity tests for Edit mode or Play mode code with the Unity Test Framework C# APIs.                           |
| **[Running tests](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/running-tests.html)**                             | Run Unity tests from the Editor’s **Test Runner** window, from the command line, or directly from code.            |
| **[Unity Test Framework learning materials](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/overview.html)** | Follow a practical tutorial with a series of exercises to help you learn the fundamentals of Unity Test Framework. |

## Additional resources

-   [QA your code: The new Unity Test Framework (Unite Copenhagen)](https://www.youtube.com/watch?v=wTiF2D0_vKA)
-   [Performance Testing Package for Unity Test Framework](https://docs.unity3d.com/Packages/com.unity.test-framework.performance@latest/)
