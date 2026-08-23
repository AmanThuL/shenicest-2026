---
title: "Get started with the Unity ScriptableObjects demo"
page_title: "Get Started with the ScriptableObjects Demo"
source_url: "https://unity.com/how-to/get-started-with-scriptableobjects-demo"
final_url: "https://unity.com/how-to/get-started-with-scriptableobjects-demo"
topic: "design-patterns"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Get started with the Unity ScriptableObjects demo

This page provides an overview of [*PaddleBallSO*](https://github.com/UnityTechnologies/PaddleGameSO), the companion demo project for the e-book [*Create modular game architecture in Unity with ScriptableObjects*](https://resources.unity.com/games/create-modular-game-architecture-with-scriptable-objects-ebook?ungated=true), and explains how it uses design patterns and modularity in its code architecture.

This is the first in a series of six mini-guides created to assist Unity developers with the demo that accompanies the e-book. The demo is inspired by classic ball and paddle arcade game mechanics, and shows how ScriptableObjects can help you create components that are testable, scalable, and designer-friendly.

Together, the e-book, demo project, and these mini-guides provide best practices for using [programming design patterns](https://resources.unity.com/games/level-up-your-code-with-game-programming-patterns?ungated=true) with the ScriptableObject class in your Unity project. These tips can help you simplify your code, reduce memory usage, and promote code reusability.

This series includes the following articles:

-   [Separate game data and logic with ScriptableObjects](https://unity.com/how-to/separate-game-data-logic-scriptable-objects)
-   [Use ScriptableObject-based enums in your Unity project](https://unity.com/how-to/scriptableobject-based-enums)
-   [Use ScriptableObjects as delegate objects](https://unity.com/how-to/scriptableobjects-delegate-objects)
-   [Use ScriptableObjects as event channels in game code](https://unity.com/how-to/scriptableobjects-event-channels-game-code)
-   [How to use a ScriptableObject-based runtime set](https://unity.com/how-to/scriptableobject-based-runtime-set)

Important note before you start

The paddle ball ScriptableObject project

Getting started

Overview of the PaddleBallSO project

Exploring the patterns and mini-game

Modular game architecture

ScriptableObjects at work

6 best practices for ScriptableObjects

More ScriptableObject resources

## Important note before you start

Before you dive into the ScriptableObject demo project and this series of mini-guides, remember that, at their core, design patterns are just ideas. They won’t apply to every situation. These techniques can help you learn new ways to work with Unity and ScriptableObjects.

Each pattern has pros and cons. Choose only the ones that meaningfully benefit your specific project. Do your designers rely heavily on the [Unity Editor](https://unity.com/download)? A ScriptableObject-based pattern could be a good choice to help them collaborate with your developers.

Ultimately, the best code architecture is the one that fits your project and team.

## The paddle ball ScriptableObject project

*PaddleBallSO* centers around the classic game that gave birth to modern video games, featuring two players, two paddles, and a ball.

The emphasis here is on infrastructure rather than game mechanics. Think of this as “game plumbing” – the less glamorous but vitally important foundation that keeps your application running.

This project focuses on how ScriptableObjects can work behind the scenes to build a unified application. Use them to construct versatile game systems that can simplify project maintenance and promote code reusability. You can also employ them for player data, game state management, in-game behaviors, and more.

The *PaddleBallSO* project is compatible with the latest version of Unity Long Term Support (LTS), currently [2022 LTS](https://unity.com/releases/lts). It incorporates the UI Toolkit for creating runtime UI, and the Input System for handling user inputs.

<a href="https://github.com/UnityTechnologies/PaddleGameSO" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[2.875rem] px-[1.625rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Download PaddleBallSO<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>

## Getting started

Locate and download the project in the [GitHub repository](https://github.com/UnityTechnologies/PaddleGameSO).

Load the **Bootloader_scene** or enable **Load Bootstrap Scene on Play** from the GameSystems menu. Enter Play mode to begin.

Though these are not specific to ScriptableObjects, the demo project uses a couple of common techniques to help start the game application in a consistent and predictable state.

A **Scene** **Bootstrapper** (or bootloader) is an Editor extension script responsible for setting up the game’s initial state. This initialization code is separate from the game logic and ensures that all dependencies are set up correctly for the objects in the scene.

To avoid dependency issues, the bootstrapper configures essential game objects, managers, or services when a scene is loaded.

If your Unity application spans several scenes, the bootloader can force load a specific bootstrap scene, which is the first scene from the Build Settings. When exiting Play mode, the Editor reloads the previous scene.

Another component in the bootstrap scene, the **Sequence Manager**, can then instantiate essential Prefabs on scene load. In this specific demo project, everything needed to create the game is a Prefab, including a camera, SplashScreen, UI menus, and a SceneLoader.

The **SceneLoader** then additively loads (and unloads) any gameplay scenes as needed. In most cases, these scenes are primarily composed of Prefabs.

**Project scenes**

Each mini-game level is a separate Unity scene and appears in the Build Settings. Disable the SceneBootstrapper in the GameSystems menu if you want to explore those individual scenes.

Many projects also include a staging area for the main menu after the bootstrap scene. This simplified demo project omits a main menu scene.

## Overview of the PaddleBallSO project

Use the **Play** and **Pattern** menus to test *PaddleBallSO*, which includes:

-   **Design pattern** demos, or bite-size examples, that show specific techniques and illustrate each pattern in isolation
-   **Mini-games** that combine these into functional, working samples

The **Core** folder contains non-application-specific parts of the code base, like the basic pattern scripts, scene management, and UI logic. These are more general classes that could apply to a variety of applications.

## Exploring the patterns and mini-game

The sample game recreates an iconic 2D physics simulation and showcases the potential of ScriptableObject-based design patterns.

Before diving into the patterns, however, you’ll want to familiarize yourself with the MonoBehaviours that make up the application. As you might expect, components like Paddle, Ball, Bouncer, and ScoreGoal scripts govern basic gameplay.

Several higher-level manager scripts control game flow:

-   The **GameManger** controls the game states (start, end, reset), initializes game components, manages the UI, and responds to events.
-   The **GameSetup** works with the GameManager to set up the ball, paddles, walls, and goals.
-   The **ScoreManager** updates score values, handles game events, and controls UI updates for score displays.

These MonoBehaviours work with your ScriptableObjects. They play a vital role in bridging these components so that they can talk and share data between them.

Events are instrumental for communication between different parts of the project. They connect these manager scripts with other scene objects and the user interface. This event-driven architecture can help make code more organized and debuggable.

We’ve also provided simplified demo examples for each of the most common ScriptableObject patterns. As you familiarize yourself with them, you’ll start recognizing how ScriptableObjects underpin the architecture of the mini-game.

We could have made the featured mini-game with far fewer lines of code, but this demo specifically focuses on design patterns with ScriptableObjects. Note that you can also implement many of these patterns without ScriptableObjects.

Decide as a team how each pattern might apply to your project and pick the approach that works best for you.

<a href="https://github.com/UnityTechnologies/PaddleGameSO" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[2.875rem] px-[1.625rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Download PaddleBallSO<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>

## Modular game architecture

Modularity in software development involves breaking an application into smaller, more independent pieces. These modules serve specific purposes and can be developed and tested separately.

Each small set of objects functions as one unit and handles one aspect of the game. This could be anything from controlling player input, handling physics, or tallying the score.

As you explore the project scripts, pay attention to the following key takeaways:

-   **Construct your scenes from Prefabs:** You’ll note that most scenes in the project are simply collections of Prefabs with minimal overrides. Prefabs inherently provide a level of modularity. Troubleshooting a feature becomes a matter of testing that particular Prefab in isolation. Like ScriptableObjects, Prefabs are project-level assets that can be reused and shared across multiple scenes.  
-   **Use ScriptableObjects for data storage (and more):** Avoid using MonoBehaviours to store static gameplay data. Instead, leverage ScriptableObjects for better reusability. You can also relegate certain game logic to ScriptableObjects or have them facilitate communication between your scene objects.  
-   **Separate concerns:** Maintain a clear distinction between data, logic, and user interface in your project. This improves code maintainability and simplifies debugging. Our menu screen system utilizes the newer [UI Toolkit](https://docs.unity3d.com/Manual/UIElements.html). This UI system enforces a workflow that separates the interface from its underlying logic. For more details, check out the [*User interface design and implementation in Unity*](https://resources.unity.com/games/user-interface-design-and-implementation-in-unity?ungated=true) e-book.  
-   **Minimize dependencies:** Reducing dependencies between components makes it easier to modify or replace parts of your project without causing unforeseen issues.  
-   **Use events for communication:** Events enable loose coupling between components, allowing them to send messages to each other without direct dependencies. You can further decouple them with ScriptableObject-based “event channels.”  
-   **Avoid unnecessary singletons:** Singleton design patterns can be useful, but only when a single instance of a class is essential. Overusing singletons can result in tightly-coupled code and hinder testing. Skip the singleton if it’s not needed.

Refactoring a large monolithic script into smaller pieces promotes reusability and scalability. This leads to improved team collaboration and simplified testing.

## ScriptableObjects at work

We’ve created the PaddleBallSO project to demonstrate ScriptableObject use cases. Here are a few specific places where you’ll see them in action:

-   The **GameDataSO** ScriptableObject serves as a central data container for game settings. Edit your common data once, and then share it with the other objects that need it.  
-   The mini-games rely on numerous **event channels** to communicate in a decoupled manner. These ScriptableObject-based events form the backbone of how objects send messages to one another.  
-   Sound playback uses a ScriptableObject-based **delegate object** to separate logic from the MonoBehaviour component.  
-   We use a **PlayerIDSO** ScriptableObject-based **enum** to differentiate “teams” between Player1 and Player2.  
-   The **LevelLayoutSO** ScriptableObject serves as a data container for the starting positions of game elements like the paddles, goals, walls, and ball. This allows for easy modification of level layouts within Unity and externally via exported JSON files. The modding of level designs outside of Unity can encourage player creativity and sharing of custom layouts.

Be sure to check out the [design pattern demos](https://resources.unity.com/games/level-up-your-code-with-game-programming-patterns?ungated=true) for a few extras as well!

<a href="https://github.com/UnityTechnologies/PaddleGameSO" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[2.875rem] px-[1.625rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Download PaddleBallSO<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>

## 6 best practices for ScriptableObjects

While ScriptableObjects can be a powerful tool for storing game data and streamlining your workflow, it’s essential to use them effectively to avoid cluttering your project.

Here are some best practices for using ScriptableObjects in Unity:

-   **Keep data modular and organized:** Use separate ScriptableObjects for different data types (e.g., one for player stats, one for enemy behavior, etc.). Break down complex data into smaller pieces that can be easily managed.  
-   **Use folders and naming conventions:** ScriptableObjects can help reduce code in your scripts, but the trade-off is dealing with more assets in your project folders. Proper naming and directory organization can help manage these ScriptableObjects efficiently. Check out our [code style guide](https://resources.unity.com/games/create-code-style-guide-e-book?ungated=true) for tips on naming.  
-   **Avoid excessive use of ScriptableObjects:** ScriptableObjects are amazing data containers, but it’s important you don’t overuse them. Keep in mind that ScriptableObjects can add complexity to your project, so deploy them only when they offer a clear benefit. (For example, don’t use them to save persistent data.)  
-   **Back up data regularly:** Changes to ScriptableObjects happen “live” at runtime and are saved as asset files. Be sure to back up your project regularly to avoid losing any data. Use version control software to track changes to your ScriptableObjects.  
-   **Use the Inspector window:** One key advantage to ScriptableObjects is that they are serializable and appear in the Inspector. Take advantage of the Editor interface to view and manipulate data stored in ScriptableObjects.  
-   **Use custom Editor scripts to your advantage:** ScriptableObjects cannot reference runtime objects from the Scene Hierarchy natively. Use Editor scripting to make the Inspector a more user-friendly interface if you need to visualize those objects.  

By following these guidelines, you can avoid common development pitfalls.

## More ScriptableObject resources

Read more about design patterns with ScriptableObjects in the e-book Create modular game architecture in Unity with ScriptableObjects. You can also find out more about common Unity development design patterns in the e-book Level up your code with game programming patterns.
