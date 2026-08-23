---
title: "Course 3. Semantic test assertion"
page_title: "Unity - Manual: 3. Semantic test assertion"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/semantic-test-assertion.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/semantic-test-assertion.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# 3. Semantic test assertion

## Learning objectives

This exercise introduces the `Assert.That` and related classes.

## Intro and motivation

The NUnit test framework and the Unity Test Framework have a series of classes for asserting objects in a way that is closer to natural language. This makes the statements easily readable.

Here are some examples on how to use the semantic assertion classes:

``` lang-cs
Assert.That(myValue, Is.GreaterThan(20));
Assert.That(str, Does.Contain("a string").And.Contain("something else"));
```

Here we check that the variable `myValue` is greater than 20 and then that the string `str` contains both “a string” and “something else”.

The semantic assertion is also known as [Constraint Model](https://docs.nunit.org/articles/nunit/writing-tests/assertions/assertion-models/constraint.html). Other than `It` and `Does` there are multiple other keywords that can be used.

## Exercise

In the `3_SemanticTestAssertion` [sample](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/test-framework-general-introduction.html#import-samples), there is a class called `ValueOutputter`, which returns values of different types.

Write tests that assert on the different outputs. It should be verified that:

-   `GetInt()` returns 11.
-   `GetString()` returns a string that contains the words `string` and `asserted`.
-   `GetFloat()` returns a value that is around 19.33.

## Hints

-   Asserting on the float might require a check for the value being greater than 19.33 and less than 19.34, as the output is not rational.

## Solution

A full solution to the exercise is available in the sample `3_SemanticTestAssertion_Solution`.

``` lang-cs
internal class ValueOutputterTests

 [Test]
 public void GivesExpectedString()
 
 [Test]
 public void GivesExpectedFloat()
 
}
```

## Additional resources

-   [Constraint-Based Assert Model](https://nunit.org/docs/2.4/constraintModel.html)
