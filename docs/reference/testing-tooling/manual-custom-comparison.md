---
title: "Course 4. Custom comparison"
page_title: "Unity - Manual: 4. Custom comparison"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/custom-comparison.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/custom-comparison.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# 4. Custom comparison

## Learning objectives

This exercise will cover the custom equality comparers included in Unity Test Framework, such as `Vector3EqualityComparer`. These are used to assert on e.g. Vectors.

## Intro and motivation

We have extended the assertion capabilities of NUnit with some custom comparisons for Unity-specific objects. A good example of this is the ability to compare two `Vector3` objects.

An example of its use is:

``` lang-cs
actual = new Vector3(0.01f, 0.01f, 0f);
expected = new Vector3(0.01f, 0.01f, 0f);

Assert.That(actual, Is.EqualTo(expected).Using(Vector3EqualityComparer.Instance));
```

This allows us to verify that the two vectors are identical within a given tolerence. By default the tolerance is 0.0001f. The tolerance can be changed by providing a new `Vector3EqualityComparer`, instead of using the default in .instance. For example you can up the tolerance to 0.01f with the following:

``` lang-cs
Assert.That(actual, Is.EqualTo(expected).Using(new Vector3EqualityComparer(0.01f));
```

For a list of all available custom comparers, see [Custom equality comparers](https://docs.unity3d.com/Packages/com.unity.test-framework@1.1/manual/reference-custom-equality-comparers.html).

## Exercise

Similar to the project for exercise 3, the [sample](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/test-framework-general-introduction.html#import-samples) `4_CustomComparison` contains a `ValueOutputter` class.

Verify that the `ValueOutputter` returns the correct values from its methods:

-   `GetVector3()` should return a `Vector3` that is roughly equal to (10.333, 3, 9.666).

-   `GetFloat()` should return a `float` that is roughly 19.333. This is the same as previous exercise, but you can try to solve this with a `FloatEqualityComparer`.

-   `GetQuaternion` should return a [Quaternion](https://docs.unity3d.com/ScriptReference/Quaternion.html) object that should be roughly equal to (10f, 0f, 7.33333f, 0f).

## Hints

-   For some of the exercises, you might need to provide a custom error tolerance to the comparer.
-   If the comparison fails, the comparers give a message about the actual and expected value, just like a normal assertion. However, because `ToString` on `Vector3` rounds the value off before displaying it, the two values in the string message might be equal, even when their `Vector3` values are not.

## Solution

The full solution is available in the sample `4_CustomComparison_Solution`.

``` lang-cs
[Test]
public void Vector3ReturnsCorrectValue()

[Test]
public void FloatReturnsCorrectValue()

[Test]
public void QuaternionReturnsCorrectValue()

```

## Additional resources

-   [Asserting and comparing](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/asserting-and-comparing.html)
