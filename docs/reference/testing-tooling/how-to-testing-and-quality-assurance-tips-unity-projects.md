---
title: "Testing and quality assurance tips for Unity projects"
page_title: "Game Development Testing and QA Best Practices"
source_url: "https://unity.com/how-to/testing-and-quality-assurance-tips-unity-projects"
final_url: "https://unity.com/how-to/testing-and-quality-assurance-tips-unity-projects"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Testing and quality assurance tips for Unity projects

## This article provides an introduction to different testing practices that will help you ship a more stable project with Unity.

Testing, or quality assurance (QA), is a critical process that should be run throughout the game development cycle. As experienced developers know, any code you write needs to be tested.

There are a range of testing and QA methods you can employ, whether you’re an independent developer or part of a large team (established studios often have dedicated QA engineers).

If you like to play and/or watch sports, then you know that in many matches it’s the defense that wins championships. Think of your QA process as your defense strategy that leaves nothing to chance when it comes to releasing a game with the best possible performance and stability.

Why is testing and quality assurance important?

When should you implement testing in the game development cycle?

Who is responsible for testing and QA?

How to QA and test a game?

Unit testing

Test-driven development

Integration testing

Regression testing

Functional testing

Performance testing

A/B testing

Diagnostics test tooling

More quality assurance resources for game devs

## Why is testing and quality assurance important?

Testing is crucial for discovering issues such as bugs in your code, visual artifacts in artwork, or user experience problems in the game design and gameplay. You can develop the most technically impressive game, but if it crashes nine times out of 10 then your users are going to give up on it pretty quickly.

## When should you implement testing in the game development cycle?

Avoid leaving testing to the end of your game development process. Instead of thinking of testing as one stage in a sequence, it can help to see it as an ongoing process that underpins the other stages of game development. Test your ideas and prototypes throughout production and before you ship. Repeat this process for every update you release for your game.

There are a range of different testing techniques that might better suit different stages of your project.

## Who is responsible for testing and QA?

Are you a member of a small studio with no dedicated QA team? Get a workgroup of friends to help out with testing, or choose a third-party QA provider to help. Even studios with an in-house QA team will often use an external firm for additional testing services, such as localization testing (LQA).

Player testing, which can be seen as a subset of QA, helps ensure your game resonates with your target audience and market. It’s a process that can provide valuable feedback from players to improve the game during the development stage.

The people who should participate in player testing vary depending on the specific goals of the testing. However, in general, it’s important to involve a diverse group of players who represent the target audience for the game. By involving different kinds of players in player testing, game developers can gather feedback from a variety of perspectives and ensure that the game appeals to a broad audience.

## How to QA and test a game?

In the following sections, you can read about common testing techniques. These methods can be combined to ensure that your codebase performs as smoothly as possible.

It’s also important to test the game on a range of devices within your target platforms. This would apply especially to mobile games; you’ll want to test on different operating systems, screen sizes, and the lowest-specification mobile devices. Doing so will help to benchmark your minimum device requirements, and each category should be constantly revisited when you add more features to your application.

Testing on various platforms is not only about identifying potential game-breaking issues, it’s also important to understand long-term or indirect implications, such as battery drainage or thermal overheating for mobile games.

## Unit testing

Unit testing is a technique that involves testing individual units or components of a game in isolation, helping to ensure bugs are caught early in the development process and that changes to the code don’t break existing functionality.

Unit testing is done by writing small test cases that exercise specific behaviors of the code. Tests can be run on individual scripts, GameObjects, or specific features of the game.

Both manual and automated methods of unit testing should be used in game development.

**Manual unit testing**

Manual testing involves people playing the game to test its features and functionality. It’s important to run manual tests because there are issues that automated tests might not pick up, such as UI bugs or unbalanced or poorly executed gameplay or design.

An example of manual unit testing in Unity would be adding a test condition for a function and using Debug.Log to output the criteria for it passing or failing (the output of the test scenarios) using Unity’s **Play mode**.

**Automated unit testing**

Automated unit testing requires writing code to automatically test individual units or pieces of code in isolation. In Unity, you can write tests for scripts, components, and other units of game code that can be run as part of a testing suite.

The [Unity Test Framework](https://docs.unity3d.com/Packages/com.unity.test-framework@1.3/manual/index.html) (UTF) package provides a framework for developers to write their own automated tests in both Edit and Play modes in the Unity Editor. UTF looks for a test inside any assembly that references [NUnit](https://www.nunit.org/). Such assemblies are referred to as **TestAssemblies**. Play mode and Edit mode tests need to be in separate assemblies.

UTF provides a [Test Runner](https://docs.unity3d.com/Packages/com.unity.test-framework@1.3/manual/getting-started.html) window in the Editor to help you run and manage your test cases.

Since UTF uses a Test Assembly Definition, you’ll need to break your project down into runtime assembly definitions. This is easier to do when you plan it early on in the development process; it also encourages you to [write more modular code](https://resources.unity.com/games/level-up-your-code-with-game-programming-patterns?ungated=true).

The Unity package, [Performance Testing Extension](https://docs.unity3d.com/Packages/com.unity.test-framework.performance@1.0/manual/index.html) is an extension you can use with the UTF. It provides extra APIs to take measurements and provide custom metrics from your test cases.

Learn how to get started with the Unity Test Framework by reading through the [Unity Test Framework for video game development](https://unity.com/how-to/unity-test-framework-video-game-development#getting-started-unity-test-framework) tutorial.

## Test-driven development

Test-driven development (TDD) is a technique that involves writing tests for a piece of functionality before writing the actual code to implement it. The process usually involves writing a failing test, writing the minimum amount of code necessary to make the test pass, and then refactoring the code to make it more maintainable before moving on to design the next test case.

TTD is quite rare in game development (it’s more common in mainstream software development). This is probably due to it being a counterintuitive process for prototyping and crafting fun and compelling gameplay.

However, it can speed up the process of identifying broken parts of your games, because any game-breaking changes will immediately create failed test cases.

For more on TDD in Unity, see the blog post “[Testing Test-Driven Development with the Unity Test Runner.](https://blog.unity.com/technology/testing-test-driven-development-with-the-unity-test-runner)”

**Code Coverage**

If you want to implement TDD or unit tests, consider using the Unity [Code Coverage package](https://docs.unity3d.com/Packages/com.unity.testtools.codecoverage@1.2/manual/index.html). When used with UTF, the Code Coverage package can show you which lines of code in your project are getting tested to help you identify vulnerable or untested parts of your project.

Code Coverage can also generate reports while you test your game in Play mode. This will show you parts of your code that you regularly run tests through, even if they aren’t covered by unit testing. However, while the Code Coverage reports show you what lines of code were covered in your test, it won’t show you different pathways that logic flowed through in the code.

See the blog post “[Code Coverage: Spot gaps in your tests](https://blog.unity.com/technology/code-coverage-spot-gaps-in-your-tests)” for more information.

## Integration testing

Integration testing is a technique that tests different components of a system together to ensure they work correctly. This can include testing how different GameObjects, scripts, or systems interact with one another within the game. Due to its wider scope, integration testing can help catch bugs that may not show up in unit testing, such as problems with data flow or communication between components.

For example, instead of using individual unit tests, an integration test could be written for this entire sequence: a player firing a weapon which instantiates a bullet, the bullet hitting an enemy and killing them, the player getting points for killing the enemy, and an achievement being unlocked when the player reaches a certain score.

You can use UTF to build integration tests in Unity. Using the [SetUp and TearDown methods](https://docs.unity3d.com/Packages/com.unity.test-framework@1.3/manual/course/setup-teardown.html), you can create an environment to test a number of systems at once. Player logic and input can be simulated, especially if you have implemented them using the [Command Pattern](https://unity.com/how-to/use-command-pattern-flexible-and-extensible-game-systems) (and if you’re using the new Input System then you likely have), in order for you to test the full flow of player input to game logic.

## Regression testing

Regression testing is a method to verify that software or features perform correctly after being modified or updated. The goal of regression testing is to ensure that changes to the codebase do not introduce new bugs or regressions in the software. This technique is best applied to large, complex applications with frequent updates, such as a live game, where there may be many different components that can interact in unexpected ways.

As your game world and mechanics expand, so does the need for regression testing, which can make it costly. Therefore, it’s important to automate it wherever possible. Regression testing should be done in parallel with the development of new features, especially if you’re targeting multiple platforms.

While regression testing is best suited to larger and live games, other factors, such as the complexity of the software, frequency of changes or updates, and the critical importance of affected features (mission- or safety-critical systems) also determine its need.

## Functional testing

Functional testing evaluates the functionality of a system or software application by testing it against its functional requirements. It involves testing the system’s features, user interfaces, database interactions, and other aspects that affect its behavior and functionality. The objective of functional testing is to verify whether the system or application meets the requirements and specifications provided by the customer or end user.

Most unit tests focus on a specific path through code, testing whether it returns the correct outputs based on certain inputs. It’s not able to test if the game does what it’s designed to do.

Functional testing is the approach for this. Each function or feature is compared with the original design to see if the output meets expectations. This can include testing the game’s controls, gameplay mechanics, and overall user experience.

It can be useful to keep functional testing in mind when developing your game, and create tasks with the “when this, then that” approach. For example, when the player presses the spacebar, the character should jump: This is both instruction to the developer on how they should implement a feature, and an acceptance criteria for the tester to test against. Sometimes, a feature may include a few related acceptance criteria, such as when a feature can and cannot be used. But they should generally focus on a single piece of functionality.

Functional testing is most powerful when the requirements are clearly defined and scoped out. It can thus be useful for contracting freelancers or studios to deliver components of your gameplay or game world assets.

You can run both automated and manual functional tests. Both “black-box” tests (testing the system without knowledge of its internal workings) and “white-box” tests (testing the system with knowledge of its internal workings) should be run.

## Performance testing

Performance testing involves testing the game to ensure that it runs smoothly and efficiently on different hardware and software configurations. This is closely related to [profiling and general performance optimization workflows](https://resources.unity.com/games/ultimate-guide-to-profiling-unity-games?ungated=true), and this practice can help identify performance bottlenecks or issues that may impact the game’s performance.

The key objective is to evaluate the performance of a system or application under different workload conditions. In game development, performance testing gauges whether the game runs at an acceptable level of performance, frame rate, responsiveness, and stability, and uses memory most efficiently.

Different types of performance tests include:

-   **Load tests**: Determines how the game performs when subjected to heavy workloads
-   **Stress tests**: Evaluates how the game handles unexpected situations, such as sudden increases in player activity
-   **Endurance tests**: Evaluates how the game performs over long periods of time

**The Unity Profiler**

The [Profiler](https://docs.unity3d.com/Manual/Profiler.html) tool in Unity helps you analyze the performance of your game as you develop it. It works in both the Editor, providing an overview while you develop, or on any device connected to your machine by cable or over a local network, providing an accurate analysis of how your game runs on a target device.

The Profiler can be extended to customize the presentation of both the kind of data you want to capture and how it will be presented visually in the Profiler window.

Learn more about customizing the Profiler in the Unite 2022 session “[How to customize performance metrics in the Unity Profiler.](https://www.youtube.com/watch?v=ixEk6EWrL6Y)”

You can also write your own tools to create automated performance testing. For an interesting discussion on how to approach this, take a look at the talk from Monument Valley developers, ustwo Games, from Unite 2022: “[Making Alba: How to build a performant open-world game.](https://www.youtube.com/watch?v=YOtDVv5-0A4)”

## A/B testing

Testing isn’t limited to finding bugs and monitoring performance. Sometimes, you might want to compare two versions of a game feature to determine which one gets more engagement from players and performs better. This is called [A/B testing](https://unity.com/how-to/ab-testing-games).

A/B testing is useful for modifying the stats of a character or weapons that would affect the balance of your game but where the game mechanics are unchanged. Other examples might be tests conducted to compare the effectiveness of different tutorials, game mechanics, or user interfaces. By analyzing the data collected from the two groups, you can identify which version of the game or feature is more effective and make data-driven decisions about which changes to incorporate into the final product.

A/B testing involves randomly assigning players to two groups: One group plays the original version of the game or feature (the control group), while the other group plays a modified version of the game or feature (the experimental group).

The key is to collect data on how a small cohort of players were affected by the different changes to help you make a design decision on which approach to release as a widespread update.

A/B testing can help to improve the user experience and increase player engagement and retention. It’s particularly useful for games that have large user bases, where even small improvements in user engagement or retention can have a significant impact.

A/B testing is usually provided as a backend service, with the players not even being aware that they are using a different variant. Unity Gaming Services (UGS) has tools to help you run A/B tests in your game, which you can learn more about [here](https://docs.unity.com/gameoverrides/en/manual/ABTesting). You can also check out the [UGS Use Cases](https://blog.unity.com/games/how-to-ab-test-game-difficulty-with-ugs-use-cases), a collection of samples for our backend services, to explore samples of how you might set up A/B testing in a game.

## Diagnostics test tooling

[Cloud Diagnostics Advanced](https://unity.com/products/cloud-diagnostics-advanced) is a crash reporting and analysis tool, powered by Backtrace, that integrates with Unity to provide developers with detailed information about crashes and exceptions in their games. When a crash occurs, Cloud Diagnostics Advanced captures a snapshot of the game’s state at the time of the crash, including information about the environment, call stack, heap, and registers. This snapshot is then sent to the Backtrace servers, where it’s analyzed to determine the root cause of the crash.

Cloud Diagnostics Advanced also provides detailed analytics and reporting tools, which can help you to identify trends and patterns in your games’ performance and stability over time. A deduplication algorithm clusters common crashes by their root cause in the code, which can be used to help prioritize which errors to fix first to improve stability for the most players possible.

## More quality assurance resources for game devs

No matter which testing techniques you use, it’s important to have a plan in place for how you will test your game, and to make sure that testing’s an integral part of your development process. By using a combination of these techniques, you can ensure that your Unity game is of the highest quality and ready for production.

A new series of e-books for programmers is now available from Unity for free. Each guide is authored by experienced programmers and provides best practices for specific topics that are important to development teams.

[*Create a C# style guide: Write cleaner code that scales*](https://blog.unity.com/engine-platform/clean-up-your-code-how-to-create-your-own-c-code-style) guides teams in developing a style guide to help unify their approach for creating a more cohesive codebase.

[*Level up your code with game programming patterns*](https://blog.unity.com/games/level-up-your-code-with-game-programming-patterns) highlights best practices for using the SOLID principles and common programming patterns to create scalable game code architecture in your Unity project.

[*Create modular game architecture in Unity with ScriptableObjects*](https://resources.unity.com/games/create-modular-game-architecture-with-scriptable-objects-ebook?ungated=true) provides best practices for deploying ScriptableObjects in game production.

We created this series to provide actionable tips and inspiration to our most experienced creators. But they are not rule books! There are many ways to structure your Unity project; evaluate the advantages and disadvantages of each recommendation, tip, and pattern with your colleagues before deploying it.

Find more advanced guides and articles on the [Unity best practices hub](https://unity.com/how).
