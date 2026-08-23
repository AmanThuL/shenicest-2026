---
title: "Course 16. Custom attributes"
page_title: "Unity - Manual: 16. Custom attributes"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/custom-attributes.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/custom-attributes.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# 16. Custom attributes

## Learning objectives

In this section we will look at some ways of implementing custom NUnit attributes, which can be used to alter test execution.

## Intro and motivation

A powerful part of NUnit is that it is very extendable. One of the ways it can be extended is through custom attributes. An example is attributes that implement the [IWrapTestMethod](https://docs.nunit.org/articles/nunit/extending-nunit/ICommandWrapper-Interface.html) interface. This interface has a method for wrapping a `TestCommand`, which implements a method for executing. Normally these test commands do something, call execute on their inner command and then maybe do something again after the inner command is completed.

In the following three classes an `IWrapTestMethod` interface is implemented and used in a test:

``` lang-cs
public class MyAttribute : NUnitAttribute, IWrapTestMethod

}

public class MyCommand : TestCommand

 public override TestResult Execute(ITestExecutionContext context)
 
}

public class MyTests

}
```

When running `MyTests.Test1` the following output is printed:

Test1 (0,017s)  
-–  
Before  
The test  
After

Other interfaces that custom attributes can implement are `IWrapSetUpTearDown`, `IApplyToContext`, and `IApplyToTest`.

## Exercise

At Unity we have a goal that an action should never take longer than 500 ms. In the [sample](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/test-framework-general-introduction.html#import-samples) `16_CustomAttributes` there is a class called `MyClass`, which has two methods. Both methods are supposed to return true. However someone has made a regression so that one of the two methods takes a long time to run.

The task is to create a new custom attribute, which detects if the test takes longer than 500 ms to run. If that happens, it should fail the test with a descriptive message. Apply that to the two existing tests.

## Hints

-   You can use the class `System.Diagnostics.Stopwatch` to time how many miliseconds have passed.

## Solution

A full solution for the exercise is availiable at `16_CustomAttributes_Solution`.

The core of the solution is the execute method in the test command implementation:

``` lang-cs
public override TestResult Execute(ITestExecutionContext context)
{
 var stopWatch = new Stopwatch();
 stopWatch.Start();
 var result = innerCommand.Execute(context);
 stopWatch.Stop();

 if (stopWatch.ElapsedMilliseconds > 500)
 {
  result.SetResult(ResultState.Failure, $"Test took {stopWatch.ElapsedMilliseconds} ms. That is longer than 500ms!");
 }

 return result;
}
```
