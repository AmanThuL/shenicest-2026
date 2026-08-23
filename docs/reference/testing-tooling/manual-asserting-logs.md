---
title: "Course 5. Asserting and expecting logs"
page_title: "Unity - Manual: 5. Asserting and expecting logs"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/asserting-logs.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/asserting-logs.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# 5. Asserting and expecting logs

## Learning objectives

How to test and verify code that writes to the console log.

## Intro and motivation

At Unity, we have many packages and modules that communicate with the user through logging messages and exceptions to the console log. This can be both for the normal workflows and for error cases.

We have extended the test framework to be aware of the console log. This means that by default, any error or exception that is logged while running a test will result in that test failing. If such failures are expected, then it is possible to use `LogAssert.Expect(logtype, message)` to ensure that a given message is logged. This can be used to expect normal messages and warnings as well. The `LogAssert.Expect` can be placed both before and after the message happens. When the test is done (or next time it yields), it will fail if the expected message is not present.

``` lang-cs
[Test]
public void LogAssertExample()

```

The `LogAssert.Expect` also takes a regex as an argument, as sometimes it is not possible to know the precise string. For example, if the logged message has time duration in the string.

## Exercise

In the [sample](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/test-framework-general-introduction.html#import-samples) `5_AssertingLogs` there is a class called `MyLoggingClass`.

The class has two methods with the following behavior:

-   `DoSomething();` logs the message “Doing something”.

-   `DoSomethingElse();` logs an error “An error happened. Code: #” where # is a random number from 0 to 9.

Write tests that verify the above behavior using `LogAssert.Expect`. You can experiment by seeing what happens if `DoSomethingElse();` is called without the expect and what happens if you expect e.g. a message of type warning.

## Hints

-   You will need to use a regular expression together with `LogAssert.Expect` in order to expect the error message.
-   In Unity, there is a difference between a logged error and a logged exception.

## Solution

A full solution to the exercise can be found in the sample `5_AssertingLogs_Solution`.

One possible implementation of the tests is as follows:

``` lang-cs
[Test]
public void DoSomethingLogsMessage()

[Test]
public void DoSomethingElseLogsError()

```

## Additional resources

[API reference for `LogAssert`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.LogAssert.html)
