---
title: "New UI Toolkit demos for programmers and artists"
page_title: "New UI Toolkit demos for programmers and artists"
source_url: "https://unity.com/blog/engine-platform/new-ui-toolkit-demos-for-programmers-artists"
final_url: "https://unity.com/blog/engine-platform/new-ui-toolkit-demos-for-programmers-artists"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# New UI Toolkit demos for programmers and artists

<a href="https://unity.com/blog" class="text-xxs mt-8 flex items-center font-bold uppercase hover:underline"><span class="ml-1">Unity Blog</span></a>

Demo

# UI Toolkit: New and updated demos for programmers and artists

<span class="text-gray-900 dark:text-gray-100 pb-1 loco-caption-lg-semibold">THOMAS KROGH-JACOBSEN / UNITY TECHNOLOGIES</span><span class="text-gray-700 dark:text-gray-300 tracking-normal loco-text-body-xs-semibold">Senior Technical Content Marketing Manager</span>

<span class="mr-2">Nov 27, 2023</span><span class="mr-2">\|</span><span class="mr-2">9 Min</span>

Programming and DevOps

2D applications

Target platforms

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

We’re happy to announce the availability of two new and updated educational samples to support the different perspectives of programmers and artists/designers in creating professional in-game UI with UI Toolkit.

[UI Toolkit](https://unity.com/features/ui-toolkit) provides [a set of tools](https://docs.unity3d.com/Manual/UIBuilder.html) for developing performant and scalable [runtime UI for games](https://unity.com/case-study/timberborn) and applications, custom extensions for the Unity Editor, and runtime debugging tools. Its core concepts and workflows will be familiar to you if you have experience developing web pages or applications.

Our aim with these educational samples is to help you build rich, responsive, and scalable UIs with UI Toolkit. The new demo [*QuizU*](https://assetstore.unity.com/packages/essentials/tutorial-projects/quizu-a-ui-toolkit-sample-268492), for programmers, and the updated [*UI Toolkit Sample* – *Dragon Crashers*](https://assetstore.unity.com/packages/essentials/tutorial-projects/ui-toolkit-sample-dragon-crashers-231178) for artists and designers, are two very different projects, each with extensive supporting instructional content.

An example of a character screen from UI Toolkit Sample – Dragon Crashers shows how the mix of GameObjects and UI Elements makes the screen dynamic and fun to use.

New: QuizU demo for UI Toolkit

The QuizU project is a UI Toolkit-based game.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

[QuizU](https://assetstore.unity.com/packages/essentials/tutorial-projects/quizu-a-ui-toolkit-sample-268492) is a programmer-centric sample of an interactive quiz application that shows how UI Toolkit components can work together, leveraging various design patterns, in a small but functional game with multiple screens and game flow management.

The demo consists of two parts: 10 small, digestible samples that demonstrate different aspects of UI Toolkit, and a mini quiz game that consolidates many of the techniques from the 10 scenes into a complete project.

The minimalist visual style of the mini-game lets you focus on the mechanics of the UI implementation, without getting lost in the design details.

A playable mini game to demonstrate design patterns

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

The quiz game illustrates how to use the state pattern for game flow, manage multiple menu screens, use the model-view-presenter pattern, implement event handling in UI Toolkit, and more. The gameplay is a very simple quiz game mechanic but the intent is to show and teach implementation techniques that you can use in your own projects.

Play QuizU to see how design patterns and UI Toolkit can work together.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

By integrating some of these [design patterns](https://blog.unity.com/games/level-up-your-code-with-game-programming-patterns) consistently into your project, you can improve code readability and make your codebase cleaner. Design patterns not only reduce refactoring and the time spent testing, they can speed up development processes for your entire team.

Additionally, event-driven architecture, whereby game components communicate with each other through events, promotes loose coupling for scalability and testability.

<a href="https://discussions.unity.com/t/welcome-to-the-new-ui-toolkit-sample-project-quizu/308607" class="cursor-pointer inline-block items-center outline-hidden overflow-x-hidden btn-primary btn-md caption-sm-bold px-3 py-2.5 inline-flex rounded-full btn-arrow"></a>

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Download QuizU</span>

Bite-sized demo scenes

Select a demo from the Demo Selection Screen.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

The second part of the demo consists of 10 small demo scenes. Each demo scene represents a specific technique or feature. Consider them as a set of recipes to inspire and guide you as you evaluate UI Toolkit for your next project. Here's a brief sampling of the UI Toolkit features and techniques the demo scenes illustrate:

-   [**UXML and Visual Trees**](https://docs.unity3d.com/Manual/UIE-VisualTree.html): UXML files form a hierarchical structure of UI elements. These visual trees serve as a blueprint for your user interface.
-   [**Flexbox**](https://docs.unity3d.com/Manual/UIE-LayoutEngine.html): The Flexible Box Layout Model (Flexbox) provides an efficient layout model for arranging UI elements dynamically within a container.
-   [**Unity Style Sheets (USS)**](https://docs.unity3d.com/Manual/UIE-about-uss.html): USS allows developers to customize UI elements with predefined styles. Reskinning your UI is just a matter of swapping style sheets.
-   [**UQuery**](https://docs.unity3d.com/Manual/UIE-UQuery.html): UQuery simplifies the process of searching through a complex hierarchy of UI elements, enabling seamless navigation to specific UI components within the visual tree.
-   [**Pseudo-classes**](https://docs.unity3d.com/Manual/UIE-USS-Selectors-Pseudo-Classes.html): Pseudo-classes can be used to create interactive and animated UI elements with minimal extra code, adding extra “juice” to your visual interface (e.g., enlarging a button when hovering over it or changing a text field color after selection).
-   [**UI Toolkit Event System**](https://docs.unity3d.com/Manual/UIE-Events-Dispatching.html): UI Toolkit has its own event system, designed to handle your UI's clicks, changes, and pointer input, even across complex hierarchies.
-   [**Manipulators**](https://docs.unity3d.com/Manual/UIE-Events-Handling.html#manipulator): Encapsulating related event callbacks into a single class, a manipulator promotes reusability and makes it easier to define user interactions (e.g., a click-and-drag manipulator for an inventory system, a gesture manipulator for a pinch-to-zoom effect, etc.).
-   [**Custom Controls**](https://docs.unity3d.com/Manual/UIB-structuring-ui-custom-elements.html): The demo shows how to define and instantiate custom VisualElement through UxmlFactory and UxmlTraits classes. These custom controls can then be reused through scripts or the UI Builder.

We recommend that you [download QuizU](https://assetstore.unity.com/packages/essentials/tutorial-projects/quizu-a-ui-toolkit-sample-268492) using Unity 2022 LTS. You can also follow along in our series of articles, published on Unity Discussions, that accompany the demo. The articles are here:

-   [Welcome to the new UI Toolkit sample project QuizU](https://discussions.unity.com/t/welcome-to-the-new-ui-toolkit-sample-project-quizu/308607)
-   [QuizU: State pattern for game flow](https://discussions.unity.com/t/quizu-state-pattern-for-game-flow/309255)
-   [Managing menu screens in UI Toolkit](https://discussions.unity.com/t/quizu-managing-menu-screens-in-ui-toolkit/310272)
-   [The Model View presenter Pattern](https://discussions.unity.com/t/quizu-the-model-view-presenter-pattern/311043)
-   [Event handling in UI Toolkit](https://discussions.unity.com/t/quizu-event-handling-in-ui-toolkit/312447)
-   [UI Toolkit performance tips](https://discussions.unity.com/t/quizu-ui-toolkit-performance-tips/312451)

<a href="https://unity.com/resources/level-up-your-code-with-game-programming-patterns" class="cursor-pointer inline-block items-center outline-hidden overflow-x-hidden btn-primary btn-md caption-sm-bold px-3 py-2.5 inline-flex rounded-full btn-arrow"></a>

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Download the e-book</span>

Updated: UI Toolkit Sample – Dragon Crashers (2022 LTS)

Updated for Unity 2022 LTS: Responsive UI in landscape and portrait

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

In September 2022, we launched *UI Toolkit Sample – Dragon Crashers* (you can read the launch [blog post](https://blog.unity.com/games/try-the-new-ui-toolkit-sample-now-available-on-the-asset-store)). This demo of a full-featured interface over a slice of the 2D mini RPG project [*Dragon Crashers*](https://assetstore.unity.com/packages/essentials/tutorial-projects/dragon-crashers-2d-sample-project-190721), shows you techniques for leveraging UI Toolkit in your own applications. It’s the companion piece to the e-book [*User interface design and implementation in Unity*](https://resources.unity.com/games/user-interface-design-and-implementation-in-unity?ungated=true), also released in late 2022.

You can now download a new version of *UI Toolkit Sample – Dragon Crashers* for Unity 2022 LTS. The improvements and updates in this latest version include:

-   Support for runtime landscape and portrait screen modes through themes and the GeometryChangedEvent in UI Toolkit
-   Implementation of the SafeArea API to contain UI functionality within the usable screen area of a device
-   Increased fps limit for mobile devices to 60 fps
-   Refactored, simplified selectors and USS stylesheets
-   Higher resolution icons
-   Improved fixed VFX spawning position for different screen ratios and some cursor inconsistencies
-   Refactored design patterns for cleaner UI architecture
-   New learning content provided via the Tutorial Inspector window

The demo is updated with usage of the SafeArea API, which helps you to contain UI functionality within the usable screen area of your device.

<a href="https://forum.unity.com/threads/the-ui-toolkit-sample-project-dragon-crashers-is-now-available-on-the-asset-store.1332075/page-2" class="cursor-pointer inline-block items-center outline-hidden overflow-x-hidden btn-primary btn-md caption-sm-bold px-3 py-2.5 inline-flex rounded-full btn-arrow"></a>

<span class="btn-label transition-spacing flex duration-300 ease-in-out">UI Toolkit Sample Project – Dragon Crashers</span>

A new user guide and video tutorial for the demo

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

We also added a user guide for the updated project. This is in response to feedback we received from users who asked for better instructional content to help them understand the techniques and features used in the demo.

Finally, a video walkthrough of the project is now available to help you navigate through the demo. Check it out:

This content is hosted by a third party provider that does not allow video views without acceptance of Targeting Cookies. Please set your cookie preferences for Targeting Cookies to yes if you wish to view videos from these providers.

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Cookie settings</span>

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

We hope you’ll pick up many useful tips with *QuizU* and the updated *UI Toolkit Sample – Dragon Crashers*. You’ll find all of Unity’s advanced e-books for programmers, artists, technical artists, and designers in the [Unity best practices hub](https://unity.com/how-to).
