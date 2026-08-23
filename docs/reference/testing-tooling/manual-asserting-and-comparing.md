---
title: "Asserting and comparing"
page_title: "Unity - Manual: Asserting and comparing"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/asserting-and-comparing.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/asserting-and-comparing.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Asserting and comparing

Unity Test Framework extends NUnit with Unity-specific custom APIs for comparing, asserting, and providing constraints for your assertions.

## Asserting

A test fails if Unity logs a message other than a regular log or warning message. You can use [`LogAssert`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.LogAssert.html) to check for an expected message in the log so the test doesn’t fail when Unity logs the message.

Use `LogAssert.Expect` before running the code under test, as the check for expected logs runs at the end of each frame.

A test also reports a failure if an expected message does not appear, or if Unity does not log any regular log or warning messages.

The following example uses `LogAssert.Expect` to expect both a regular log message and an error message in the Editor log:

``` lang-cs
[Test]
public void LogAssertExample()

```

### Asserting with constraints

NUnit allows you to write human-readable, descriptive [assertions](https://docs.nunit.org/articles/nunit/writing-tests/assertions/assertions.html) with the `Assert.That` mechanism, where the first parameter is an object under test and the second parameter describes conditions that the object has to meet.

Unity Test Framework extends this with a custom constraint type and declared an overlay [`Is`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.Constraints.Is.html) class. To resolve ambiguity between the original implementation and the custom one you must explicitly declare it with a `using` statement or via addressing through the full type name `UnityEngine.TestTools.Constraints.Is`.

## Comparing

Unity Test Framework provides custom equality comparers and utilities to enable easier verification of custom Unity type values in your tests. Comparable types include \[Color\], \[Quaternion\] and Vectors.

Use these classes to compare two objects of the same type for equality within the range of a given tolerance using [NUnit constraints](https://docs.nunit.org/articles/nunit/writing-tests/constraints/Constraints.html) or [Unity constraints](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.Constraints.Is.html).

Call `Instance` to apply the default calculation error value to the comparison. To set a specific error value, instantiate a new comparer object using a one argument constructor `ctor(float error)`.

For the full list of available comparers and example usage, refer to the API reference for [`UnityEngine.TestTools.Utils`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.Utils.html).

## Additional resources

-   [Arrange, act, assert](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/arrange-act-assert.html)
-   [Asserting logs](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/asserting-logs.html)
-   [Semantic test assertion](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/semantic-test-assertion.html)
-   [Custom comparison](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/custom-comparison.html)
