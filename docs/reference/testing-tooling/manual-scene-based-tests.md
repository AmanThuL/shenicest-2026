---
title: "Course 11. Scene-based tests"
page_title: "Unity - Manual: 11. Scene-based tests"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/scene-based-tests.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/scene-based-tests.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# 11. Scene-based tests

## Learning objectives

In this exercise, you will learn how to test content that is stored in a scene.

## Intro and motivation

A useful scenario for our customers is using the test framework for verifying the content of a scene. That could be checking for certain GameObjects and MonoBehaviors.

The [EditorSceneManager](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.EditorSceneManager.html) allows for loading and saving scenes. In combination with the test framework, this allows for the implementation of tests that verify a scene.

When changing the state of the Editor in a test, such as loading a scene, it’s good practice to clean up afterward. This can be done in a method with the `[TearDown]` attribute.

## Exercise

Import the [sample](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/test-framework-general-introduction.html#import-samples) `11_SceneBasedTests`, which contains a scene named `MyGameScene` and an assembly for Edit Mode tests.

The task is to create a test that opens the scene, verifies that the scene contains a game object named `GameObjectToTestFor`.

As cleanup, it should open a new empty scene, which is the default for Edit Mode tests. It is recommended to put that in a `[TearDown]`, which ensures that the cleanup code is run, even if the test fails.

## Hints

-   `EditorSceneManager.OpenScene("Assets\\MyGameScene.unity");` loads the scene
-   `EditorSceneManager.NewScene(NewSceneSetup.DefaultGameObjects, NewSceneMode.Single);` cleans up by changing back to an empty scene.

## Solution

A full solution is available in the sample `11_SceneBasedTests_Solution`.

The test implementation can look like this:

``` lang-cs
public class SceneTests

 [Test]
 public void VerifyScene()
 
 [TearDown]
 public void Teardown()
 
}
```

## Additional resources

[API reference for `EditorSceneManager`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.EditorSceneManager.html)
