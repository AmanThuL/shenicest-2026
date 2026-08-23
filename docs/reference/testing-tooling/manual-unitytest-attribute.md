---
title: "Course 9. Using the UnityTest attribute"
page_title: "Unity - Manual: 9. Using the UnityTest Attribute"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/unitytest-attribute.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/unitytest-attribute.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# 9. Using the UnityTest Attribute

## Learning objectives

This section will introduce you to the custom `[UnityTest]` Attribute, which allows for creating tests that run over multiple frames.

## Intro and motivation

An important extension to the Nunit framework that we’ve made is introducing the `[UnityTest]` attribute. The attribute allows for creating tests that can yield and resume running after a certain condition. Therefore the test must have the return type of `IEnumerator`. You can then yield back a yield instruction or null, like so:

``` lang-cs
[UnityTest]
public IEnumerator MyTest()

```

In the snippet above we call the `DoSomething` method, then skip one frame before calling the `DoSomethingElse` method.

For more information on the yield keyword in C#, see the [Microsoft documentation](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/yield).

## Exercise

In the [sample](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/test-framework-general-introduction.html#import-samples) `9_UnityTestAttribute` you will find a Play Mode test assembly set up with one Play Mode test in it. The PlayMode test does not have a body yet, but there is a function called `PrepareCube()` which will set up a cube with some physics applied.

The task is to initialize the cube and then verify that it has moved after one frame has passed.

## Solution

The full solution is available in the `9_UnityTestAttribute_Solution` sample.

``` lang-cs
[UnityTest]
public IEnumerator CubeMovesDown()

```

## Additional resources

[UnityTest attribute](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.UnityTestAttribute.html)
