---
title: "Run Play mode tests in a Player"
page_title: "Unity - Manual: Run Play mode tests in a Player"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/workflow-run-playmode-test-standalone.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/workflow-run-playmode-test-standalone.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Run Play mode tests in a Player

If you run a Play mode test in the same way as an [Editor test](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/workflow-run-test.html), it runs inside the Unity Editor. You can also run Play mode tests on specific platforms. Select the **Player** tab to build and run your tests on the currently active target platform.

![The Test Runner window with the Player tab selected, displaying the list of Play mode tests available to run in the Player.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/test-framework/run-playmode-standalone.png)

Your current platform shows at the top of the **Test Runner** window. For example, in the image above, the bar above the search bar reads **Running in StandaloneOSX**, because the current platform is MacOS. The target platform is always the active platform profile selected in [Build Profiles](https://docs.unity3d.com/6000.3/Documentation/Manual/BuildSettings.html) (menu: **File** \> **Build Profiles**).

The test result displays in the build once the test completes:

![The built Player displays the results of the Play mode tests run on it.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/test-framework/playmode-results-standalone.png)

The application running on the platform reports back the test results to the Editor UI then displays the executed tests and shuts down. Some platforms don’t support shutting down the Player application with `Application.Quit` so it continues running after reporting the test results.

To make sure you receive the test results from the Player on your target platform back into the Editor that’s running the test, both must be on the same network. If Unity can’t instantiate the connection, you can see the tests succeed in the running application. Running tests on platforms with arguments, in this state, does not provide XML test results.

## Build a Player with tests

You can use the dropdown selector next to the **Run All** button to build a Player with all the tests, or a selected subset of tests, without running it.

![The dropdown selector in the Test Runner window displays the options to Build All Tests or Build Selected Tests to a Player without running them.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/test-framework/playmode-standalone-build-tests.png)

In some cases the available selections are different. If the selected platform is Android or iOS and **Export Project** is enabled in **Build Profiles**, the selections are **Export All Tests** and **Export Selected Tests**.

![The dropdown selector in the Test Runner window displays the options to Export All Tests or Export Selected Tests to a Player without running them.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/test-framework/playmode-standalone-build-tests-android-ios.png)

## Additional resources

-   [Modifying a Player build for tests](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-attribute-testplayerbuildmodifier.html)
-   [Play mode tests in a player](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/play-mode-tests-in-player.html)
